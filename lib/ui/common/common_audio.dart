import 'dart:async';
import 'dart:io';

import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/scoped_models/audio_state_model.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/permission_util.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound/android_encoder.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound/ios_quality.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tip_dialog/tip_dialog.dart';

enum RecorderState {
  normal, //正常状态（可录音）
  recording, //录音中（可停止）
  complete, //录音完成（可播放）
  cancel, //录音取消（可重新录音）
}
enum PlayerState {
  normal, //正常状态（可播放）
  play, //播放（可停止播放）
  stop, //停止（可重新播放）
}
enum TapState {
  normal, //正常状态
  down, //按下
  up, //抬起
  cancel //取消
}

//音频控件
class CommonAudio extends StatefulWidget {
  static final String androidAudioFormat=".amr";//安卓音频文件后缀格式
  static final String iosAudioFormat=".aac";//苹果音频文件后缀格式（播放器暂时不支持网络播放m4a格式）
  ValueChanged<String> recordCallback; //录音回调，返回的是文件的路径
  CommonAudio({this.recordCallback});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CommonAudioWidget();
  }
}

class CommonAudioWidget extends State<CommonAudio> with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  AudioStateModel stateModel;
  RecorderState _recorderState;
  PlayerState _playerState;
  TapState tapState; //点击状态
//  int recoredStatus; //点击状态（0：未开始录音、1：录音中、2：录音结束、3：取消录音）
  bool showing; //显示中
//  bool complete; //录音完成（有效数据）
  bool cancelling; //取消录音中（用于避免重复取消录音）
//  bool playing; //播放中
  int playMillisecond; //播放的毫秒
  String fileName;
  FlutterSound flutterSound;
  StreamSubscription _recorderSubscription;
  StreamSubscription _dbPeakSubscription;
  StreamSubscription _playerSubscription;
  int interval = 200;

//  double _recorderCurrentPosition = 0;
//  bool _recorderDbFlag = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    stateModel = new AudioStateModel();
    _recorderState = RecorderState.normal;
    _playerState = PlayerState.normal;
    cancelling = false;
//    playing = false;
//    recoredStatus = 0;
    stateModel.dbLevel = 0;
    playMillisecond = 0;

    flutterSound = new FlutterSound();
    flutterSound.setSubscriptionDuration(0.1);
    flutterSound.setDbPeakLevelUpdate(0.2);
    flutterSound.setDbLevelEnabled(true);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      setState(() {
        LogUtils.printLog("didChangeAppLifecycleState  inner");
        tapState = TapState.cancel;
        _dismiss();
      });
    }
    LogUtils.printLog("didChangeAppLifecycleState: $state");
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
        model: stateModel,
        child: ScopedModelDescendant<AudioStateModel>(builder: (context, child, model) {
          return Row(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTapDown: (e) => _onTapDown(),
                  onTapUp: (e) => _onTapUp(),
                  onTapCancel: () => _onTapCancel(),
                  child: Container(
                      height: ScreenUtil.getInstance().setHeight(30),
                      //固定高度
                      margin: EdgeInsets.symmetric(horizontal: UIData.spaceSize20),
                      padding: EdgeInsets.symmetric(vertical: UIData.spaceSize4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(ScreenUtil.getInstance().setWidth(4)),
//                    border: Border.all(color: recoredStatus==2?UIData.themeBgColor:(recoreding?UIData.themeBgColor:Color(0xffdddddd))),
                        border: Border.all(color: UIData.themeBgColor),
                        color: _playerState == PlayerState.play
                            ? UIData.audioBtnRedColor
                            : (_recorderState == RecorderState.recording
                                ? UIData.audioBtnRedColor
                                : Color(0x00000000)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Visibility(
                              visible: _recorderState == RecorderState.complete,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: ScreenUtil.getInstance().setWidth(10),
                                    right: ScreenUtil.getInstance().setWidth(5)),
                                child: Image(
                                  image: AssetImage(_getPlayImage(playMillisecond)),
                                  width: ScreenUtil.getInstance().setWidth(15),
                                  height: ScreenUtil.getInstance().setWidth(15),
                                ),
                              )),
                          Visibility(
                            visible: _recorderState == RecorderState.complete,
                            child: CommonText.text12(_playerState == PlayerState.play ? "播放中..." : "点击播放",
                                textAlign: TextAlign.left, color: UIData.themeBgColor),
                          ),
                          Expanded(
                              child: Visibility(
                            visible: _recorderState != RecorderState.complete,
                            child: CommonText.text12(_recorderState == RecorderState.recording ? "松开结束" : "按住说话",
                                textAlign: TextAlign.center, color: UIData.themeBgColor),
                          )),
                        ],
                      )),
                ),
              ),
              Visibility(
                  visible: _recorderState == RecorderState.complete,
                  child: GestureDetector(
                    child: CommonText.text16('重录', textAlign: TextAlign.center, color: UIData.themeBgColor),
                    onTap: () {
                      _stopPlaySound();
                      if (widget.recordCallback != null) {
                        widget.recordCallback(null);
                      }
                      setState(() {
                        //重新录制
                        _recorderState = RecorderState.normal;
                        _playerState = PlayerState.normal;
                      });
                    },
                  )),
            ],
          );
        }));
  }

  //按下
  _onTapDown() {
//    _recorderCurrentPosition = 0;
//    _recorderDbFlag = false;
    tapState = TapState.down;
    LogUtils.printLog("onTapDown");
    if (_recorderState == RecorderState.complete) {
      if (_playerState == PlayerState.play) {
        _stopPlaySound();
      } else {
        _startPlaySound();
      }
    } else if (_recorderState != RecorderState.recording && !cancelling) {//取消录音的过程中，不能再次启动录音
//      List<PermissionGroup> permissions = List<PermissionGroup>();
//      permissions.add(PermissionGroup.microphone);
//      if (Platform.isAndroid) permissions.add(PermissionGroup.storage);
      PermissionUtil.requestPermission([PermissionGroup.microphone, PermissionGroup.storage], callback: (bool isGranted) {
        if (isGranted) {
          _startRecordSound();
        } else {
          if (Platform.isAndroid)
            CommonToast.show(msg: '请打开麦克风和读写文件权限', type: ToastIconType.INFO);
          else
            CommonToast.show(msg: '请打开麦克风权限', type: ToastIconType.INFO);
        }
      });
    }
  }

  //抬起
  _onTapUp() {
    tapState = TapState.up;
    LogUtils.printLog("onTapUp");
  }

  //取消点击
  _onTapCancel() {
    tapState = TapState.cancel;
    LogUtils.printLog("onTapCancel");
  }

  //开始录音
  _startRecordSound() async {
    try {
      Directory externalDir = await getTemporaryDirectory();
      fileName = externalDir.path +
          "/" +
          StringsHelper.getStringValue(DateTime.now()
              .toString()
              .replaceAll(" ", "")
              .replaceAll(":", "")
              .replaceAll(".", "")
              .replaceAll("-", "")) +
          "${Platform.isAndroid ? CommonAudio.androidAudioFormat : CommonAudio.iosAudioFormat}";
      if (tapState == TapState.down) {
        //防止等待获取文件路径时、用户抬起（取消录音）
//        String path = await flutterSound.startRecorder(fileName,
//            androidEncoder: AndroidEncoder.HE_AAC,bitRate: 128,iosQuality: IosQuality.HIGH);
        try {
          String path = await flutterSound.startRecorder(fileName,
              androidEncoder: AndroidEncoder.AMR_WB, iosQuality: IosQuality.HIGH);
          LogUtils.printLog("recoredFile:" + path);
        } on Exception catch (e) {
//          //android没打开麦克风会走这段
//          setState(() {
//            tapState = TapState.cancel;
//          });
//          if (e.toString().contains('PlatformException')) {
//            CommonToast.show(msg: '请打开麦克风权限', type: ToastIconType.INFO);
//          }
          LogUtils.printLog("e:" + e.toString());
          return ;
        }
        if (tapState == TapState.down) {
          //等待开始录音后、仍按下，显示录音中（否则取消录音）
          setState(() {
            _recorderState = RecorderState.recording;
          });
        }
        _dbPeakSubscription = flutterSound.onRecorderDbPeakChanged.listen((value) {
//          if (value > 0.5) _recorderDbFlag = true;
//          if (Platform.isIOS && !_recorderDbFlag && _recorderCurrentPosition > 300) {
//            _recorderDbFlag = true;
//            //ios没打开麦克风会走这段
////            LogUtils.printLog("_recorderDbFlag:$value");
//            setState(() {
//              tapState = TapState.cancel;
//            });
//            CommonToast.show(msg: '请打开麦克风权限', type: ToastIconType.INFO);
//          } else {
          LogUtils.printLog("onRecorderDbPeakChanged:$value");
////              print("got update -> $value");
          stateModel.setDBLevel(value);
//          }
        });
        _recorderSubscription = flutterSound.onRecorderStateChanged.listen((e) {
          LogUtils.printLog("onRecorderStateChanged:" + e.toString());
//        e.currentPosition//单位是毫秒
//          DateTime date0 = new DateTime.fromMicrosecondsSinceEpoch(e.currentPosition.toInt());//fromMicrosecondsSinceEpoch 微妙
//          DateTime date = new DateTime.fromMillisecondsSinceEpoch(e.currentPosition.toInt());//fromMillisecondsSinceEpoch 毫秒

//          _recorderCurrentPosition = e.currentPosition;
          if (tapState == TapState.down &&
              _recorderState == RecorderState.recording &&
              !tipDialogKey.currentState.isShow &&
              e.currentPosition > 500) {
            _showMic(); //有效录音、显示弹窗
          } else if (tapState != TapState.down) {
            //停止录音
            if (e.currentPosition > 300) {
              //录音超过300毫秒时才能停止，否则不能停止（防止太快结束会导致录音出错）
              if (!cancelling) {
                _stopRecordSound();
              }
            } else {
              tapState = TapState.cancel;
            }
          }
        });
      }
    } catch (e) {
      LogUtils.printLog('_startRecordSound error: ${e?.toString()}');
    }
  }

  //停止录音
  _stopRecordSound() async {
    try {
      cancelling = true;
      String result = await flutterSound.stopRecorder();
      LogUtils.printLog("stopRecorder:" + result);
//      print('stopRecorder: $result');
      _dismiss();
      if (_recorderSubscription != null) {
        _recorderSubscription.cancel();
        _recorderSubscription = null;
      }
      if (_dbPeakSubscription != null) {
        _dbPeakSubscription.cancel();
        _dbPeakSubscription = null;
      }
//      if (tapState == TapState.cancel) {
//        tapState = TapState.normal;
//        _recorderState = RecorderState.normal;
//      }

      if (tapState == TapState.up) {
        _recorderState = RecorderState.complete; //录音完成、有效数据
        if (widget.recordCallback != null) {
          widget.recordCallback(fileName);
        }
      }else{
        tapState = TapState.normal;
        _recorderState = RecorderState.normal;
      }

      cancelling = false;
      setState(() {});
    } catch (e) {
      LogUtils.printLog(e?.toString());
    }
  }

//  //取消录音
//  _cancelRecordSound() async{
//    try{
//      String result = await flutterSound.stopRecorder();
//      print('stopRecorder: $result');
//      setState(() {
//        recoredStatus==2 = false;
//        recoreding = false;
//      });
//      new File(fileName).delete();
//    }catch(e){
//      LogUtils.printLog(e.toString());
//    }
//    finally {
//      if (_recorderSubscription != null) {
//        _recorderSubscription.cancel();
//        _recorderSubscription = null;
//      }
//    }
//  }

  //播放声音
  _startPlaySound() async {
    try {
      String path = await flutterSound.startPlayer(fileName);
      LogUtils.printLog("startPlayerStatus:" + _playerState.toString());
      LogUtils.printLog("startPlayer:" + path);
      await flutterSound.setVolume(1.0);
//      print('startPlayer: $path');
      _playerSubscription = flutterSound.onPlayerStateChanged.listen((e) {
//        print(e?.currentPosition.toInt().toString());
        if (e?.currentPosition == e?.duration) {
          //播放结束
          _playerState = PlayerState.stop;
        }
        playMillisecond = e?.currentPosition?.toInt() ?? 0;
        setState(() {});
      });
      setState(() {
        _playerState = PlayerState.play; //开始播放
      });
    } catch (e) {
      LogUtils.printLog(e?.toString());
      _stopPlaySound();
    }
  }

  _stopPlaySound() async {
    try {
      String result = await flutterSound.stopPlayer();
      if (_playerSubscription != null) {
        _playerSubscription.cancel();
        _playerSubscription = null;
      }
      LogUtils.printLog('stopPlayer: $result');
      setState(() {
//        playing = false;
        _playerState = PlayerState.stop; //开始播放
      });
    } catch (e) {
      LogUtils.printLog(e?.toString());
    }
  }

//  @override
//  void dispose() {
//    // TODO: implement dispose
//    super.dispose();
//      try{
//        if(_dbPeakSubscription !=null){
//          _dbPeakSubscription.cancel();
//          _dbPeakSubscription = null ;
//        }
//        if (_recorderSubscription != null) {
//          _recorderSubscription.cancel();
//          _recorderSubscription = null;
//          flutterSound.stopRecorder();
//          flutterSound=null;
//        }
//      }catch(e){
//
//      }
//      try{
//        if (_playerSubscription != null) {
//          _playerSubscription.cancel();
//          _playerSubscription = null;
//          flutterSound.stopRecorder();
//        }
//      }catch(e){
//
//      }
//
//  }

  _showMic() {
    tipDialogKey.currentState.show(
        tipDialog: new TipDialog.builder(bodyBuilder: (BuildContext context) {
          return ScopedModel<AudioStateModel>(
              model: stateModel,
              child: ScopedModelDescendant<AudioStateModel>(builder: (context, child, model) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          top: ScreenUtil.getInstance().setWidth(20),
                          bottom: ScreenUtil.getInstance().setWidth(10)),
                      child: Image.asset(
                        _getMicImage(stateModel.dbLevel),
                        width: ScreenUtil.getInstance().setWidth(51),
                        height: ScreenUtil.getInstance().setWidth(37),
                      ),
//                    child: Icon(Icons.mic),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: ScreenUtil.getInstance().setWidth(20),
                          right: ScreenUtil.getInstance().setWidth(20),
                          bottom: ScreenUtil.getInstance().setWidth(20)),
                      child: Text(
                        "松开完成，下滑取消",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil.getInstance().setWidth(11),
                        ),
                        textDirection: TextDirection.ltr,
                      ),
                    )
                  ],
                );
              }));
        }),
        isAutoDismiss: false);
  }

  _dismiss() {
    if (tipDialogKey.currentState != null && tipDialogKey.currentState.isShow) tipDialogKey.currentState.dismiss();
  }

  String _getMicImage(double dbLevel) {
    if (dbLevel > 150) {
      return UIData.audio_mic5;
    } else if (dbLevel > 120) {
      return UIData.audio_mic4;
    } else if (dbLevel > 90) {
      return UIData.audio_mic3;
    } else if (dbLevel > 60) {
      return UIData.audio_mic2;
    } else {
      return UIData.audio_mic1;
    }
  }

  String _getPlayImage(int millisecond) {
    int remainder = ((millisecond ?? 0) % 1000).toInt();
    if (remainder > 0 && remainder <= 333) {
      return UIData.icon_voice1;
    } else if (remainder > 333 && remainder <= 666) {
      return UIData.icon_voice2;
    } else {
      return UIData.icon_voice3;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    if (StringsHelper.isNotEmpty(fileName)) new File(fileName)?.delete(); //删除音频文件(关闭页面后自动删除文件)
  }
}
