//import 'dart:async';
//import 'dart:io';
//import 'dart:typed_data';
//
//import 'package:audioplayer/audioplayer.dart';
//import 'package:cmp_customer/http/http_options.dart';
//import 'package:cmp_customer/ui/common/common_text.dart';
//import 'package:cmp_customer/utils/common_strings_helper.dart';
//import 'package:cmp_customer/utils/log_util.dart';
//import 'package:cmp_customer/utils/ui_data.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:http/http.dart';
//import 'package:path_provider/path_provider.dart';
//
//typedef void OnError(Exception exception);
//
//enum PlayerState { stopped, playing, paused }
//
//class CommonAudioPlayer extends StatefulWidget {
//  String uuid;//服务器中音频文件的uuid
//  CommonAudioPlayer(this.uuid);
//  @override
//  _CommonAudioPlayerState createState() => new _CommonAudioPlayerState(uuid);
//}
//
//class _CommonAudioPlayerState extends State<CommonAudioPlayer> {
//  Duration duration;
//  Duration position;
//  String playUrl;
//  String uuid;
//  AudioPlayer audioPlayer;
//
////  String localFilePath;
//
//  PlayerState playerState = PlayerState.stopped;
//
//  get isPlaying => playerState == PlayerState.playing;
////  get isPaused => playerState == PlayerState.paused;
//
////  get durationText =>
////      duration != null ? duration.toString().split('.').first : '';
////  get positionText =>
//////      position != null ? position.toString().split('.').first : '';
////      position != null ? _getRemainingTime() : '';
//
//  bool isMuted = false;
//
////  StreamSubscription _positionSubscription;
//  StreamSubscription _audioPlayerStateSubscription;
//
//  _CommonAudioPlayerState(this.uuid);
//  @override
//  void initState() {
//    super.initState();
//    initAudioPlayer();
//    playUrl=HttpOptions.showPhotoUrl(uuid);
//  }
//
//  @override
//  void dispose() {
////    _positionSubscription.cancel();
//    _audioPlayerStateSubscription.cancel();
//    audioPlayer.stop();
//    super.dispose();
//  }
//
//  void initAudioPlayer() {
//    audioPlayer = new AudioPlayer();
////    _positionSubscription = audioPlayer.onAudioPositionChanged
////        .listen((p) => setState(() => position = p));
//    _audioPlayerStateSubscription =
//        audioPlayer.onPlayerStateChanged.listen((s) {
//      if (s == AudioPlayerState.PLAYING) {
//        setState(() => duration = audioPlayer.duration);
//      } else if (s == AudioPlayerState.STOPPED) {
//        onComplete();
//        setState(() {
//          position = duration;
////              position = new Duration(seconds: 0);
//        });
//      }
//    }, onError: (msg) {
//      setState(() {
//        playerState = PlayerState.stopped;
//        duration = new Duration(seconds: 0);
//        position = new Duration(seconds: 0);
//      });
//    });
//  }
//
//  Future play() async {
//    await audioPlayer.play(playUrl);
//    setState(() {
//      playerState = PlayerState.playing;
//    });
//  }
//
////  Future _playLocal() async {
////    await audioPlayer.play(localFilePath, isLocal: true);
////    setState(() => playerState = PlayerState.playing);
////  }
//
////  Future pause() async {
////    await audioPlayer.pause();
////    setState(() => playerState = PlayerState.paused);
////  }
//
//  Future stop() async {
//    await audioPlayer.stop();
//    setState(() {
//      playerState = PlayerState.stopped;
//      position = new Duration();
//    });
//  }
//
//  Future mute(bool muted) async {
//    await audioPlayer.mute(muted);
//    setState(() {
//      isMuted = muted;
//    });
//  }
//
//  void onComplete() {
//    setState(() => playerState = PlayerState.stopped);
//  }
//
////  Future<Uint8List> _loadFileBytes(String url, {OnError onError}) async {
////    Uint8List bytes;
////    try {
////      bytes = await readBytes(url);
////    } on ClientException {
////      rethrow;
////    }
////    return bytes;
////  }
//
////  Future _loadFile() async {
////    final bytes = await _loadFileBytes(playUrl,
////        onError: (Exception exception) =>
////            print('_loadFile => exception $exception'));
////
////    final dir = await getApplicationDocumentsDirectory();
////    final file = new File('${dir.path}/audio.mp3');
////
////    await file.writeAsBytes(bytes);
////    if (await file.exists())
////      setState(() {
////        localFilePath = file.path;
////      });
////  }
//
//  @override
//  Widget build(BuildContext context) {
//    return _buildPlayer();
//  }
//
//  Widget _buildPlayer() => new GestureDetector(
//        onTapDown: (e) => _onTapDown(),
//        child: Container(
//          height: ScreenUtil.getInstance().setHeight(30), //固定高度
//          margin: EdgeInsets.symmetric(horizontal: UIData.spaceSize20),
//          padding: EdgeInsets.symmetric(vertical: UIData.spaceSize4),
//          decoration: BoxDecoration(
//            borderRadius:
//                BorderRadius.circular(ScreenUtil.getInstance().setWidth(4)),
////                    border: Border.all(color: recoredStatus==2?UIData.themeBgColor:(recoreding?UIData.themeBgColor:Color(0xffdddddd))),
//            border: Border.all(color: UIData.themeBgColor),
//            color: isPlaying ? UIData.audioBtnRedColor : Color(0x00000000),
//          ),
//          child: Row(
//            crossAxisAlignment: CrossAxisAlignment.center,
//            children: <Widget>[
//              Padding(
//                  padding: EdgeInsets.only(
//                      left: ScreenUtil.getInstance().setWidth(10),
//                      right: ScreenUtil.getInstance().setWidth(5)),
//                  child: Image(
//                    image: AssetImage(UIData.icon_voice3),
//                    width: ScreenUtil.getInstance().setWidth(15),
//                    height: ScreenUtil.getInstance().setWidth(15),
//                  )),
//              CommonText.text12(isPlaying ? "播放中..." : "点击播放",
//                  textAlign: TextAlign.left, color: UIData.themeBgColor),
//            ],
//          ),
//        ),
//      );
//
//  //按下
//  _onTapDown() {
//    if (isPlaying) {
//      //停止播放
//      stop();
//    } else {
//      //开始播放
//      play();
//    }
//  }
////
////  //播放剩余时间
////  _getRemainingTime() {
////    if (duration != null && position != null) {
////      return StringsHelper.getStringValue(
////              duration.inSeconds - position.inSeconds) +
////          "s";
////    }
////  }
//}
