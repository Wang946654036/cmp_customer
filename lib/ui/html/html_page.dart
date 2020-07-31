import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/models/common/common_share_model.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/models/webview/map_info_model.dart';
import 'package:cmp_customer/models/webview/share_info_model.dart';
import 'package:cmp_customer/models/webview_call_native.dart';
import 'package:cmp_customer/scoped_models/image_state_model.dart';
import 'package:cmp_customer/scoped_models/pay_state_model.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_dialog.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_share_bottom_sheet.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/common/popover/cupertino_popover.dart';
import 'package:cmp_customer/ui/common/popover/cupertino_popover_menu_item.dart';
import 'package:cmp_customer/ui/house_authentication/my_house_page.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/map_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/permission_util.dart';
import 'package:cmp_customer/utils/share_util.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter/material.dart';
import 'package:sharesdk_plugin/sharesdk_defines.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../main.dart';

//第三方html加载
class HtmlPage extends StatefulWidget {
  final String title; //标题
  final String url; //html地址
  final bool toShare; //是否能分享
  final String thumbImageUrl; //缩略图的链接，用于分享
  final bool showTitle;
  final String payComplete;
  HtmlPage(this.url, this.title,
      {this.toShare = false, this.thumbImageUrl, this.showTitle = true,this.payComplete});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HtmlPageState(this.url, this.title);
  }
}

class HtmlPageState extends State<HtmlPage> {
  // WebView加载状态变化监听器
  StreamSubscription<WebViewStateChanged> _onStateChanged;

  // 标记是否是加载中
  bool loading = true;
  double loadingProgressValue = 0;
  String title; //标题
  String startUrl; //html地址
  bool canGoBack = true;
  bool _shareVisible = false; //底部分享是否显示
  String _urlTitle; //url返回的标题

  HtmlPageState(this.startUrl, this.title);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stateModel.flutterWebViewPlugin = new FlutterWebviewPlugin();
    startUrl = Uri.encodeFull(startUrl);
//    url="https://wxpay.wxutil.com/mch/pay/h5.v2.php";
//    url="http://app.park.ylmo2o.com/app/pay/segiCharge?community=1014162&user=200318631&id=96";
//    url = "http://www.taobao.com";
//    url = "assets/html/";
//    startUrl = "https://html.m.cmbchina.com/MobileHtml/Outreach/MHtmlGateway/CallappGateway.aspx?target=cmbmobilebank%3a%2f%2fcmbls%2ffunctionjump%3faction%3dgofuncid%26funcid%3d16335002%26needlogin%3dtrue%26cmb_app_trans_parms_start%3dhere%26appflag%3d0%26shorturl%3dhttps%253a%252f%252ft.cmbchina.com%252fvUbIFr";
    _onStateChanged =
        stateModel.flutterWebViewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      // state.type是一个枚举类型，取值有：WebViewState.shouldStart, WebViewState.startLoad, WebViewState.finishLoad
      _getHtmlTitle();
      switch (state.type) {
        case WebViewState.shouldStart:
          break;
        case WebViewState.startLoad:
          // 加载
          setState(() {
            loading = true;
            loadingProgressValue = 0;
          });
          break;
        case WebViewState.abortLoad:
          print("state.url===" + state.url);
          break;
        case WebViewState.finishLoad:
          // 加载结束
          setState(() {
            loading = false;
          });

//          if (isLoadingCallbackPage) {
//            // 当前是回调页面，则调用js方法获取数据
//            parseResult();
//          }
          break;
      }
    });
    stateModel.flutterWebViewPlugin.onProgressChanged.listen((double value) {
      setState(() {
        loadingProgressValue = value;
      });
    });
    stateModel.flutterWebViewPlugin.onUrlChanged.listen((String url) {
      if (startUrl == url) {
        canGoBack = false;
      } else {
        canGoBack = true;
      }
      LogUtils.printLog("url监听：" + url ?? "");
      if(url.startsWith(PayStateModel.payReturnUrl)){
        Navigate.closePage(true);//如果加载的是设置好返回的url，这关闭页面表示返回列表
      }
      //ios需要跳转其他APP的在这里处理(安卓的webview监听机制不一样，无法做到监听后仅仅不加载需要跳转的页面，需要在原生处理)
      if(Platform.isIOS){
        if(url.startsWith("cmbmobilebank://")){
          _openOtherAPP(url,appName: "招商银行");
          return;
        }else if(url.startsWith("itms-apps://")||url.startsWith("itms-appss://")){
          _openOtherAPP(url,appName: "App Store");
          return;
        }else if(url.startsWith("upwrp://")){
          _openOtherAPP(url,appName: "云闪付",needToast: false);
        }
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _onStateChanged.cancel();
    stateModel.flutterWebViewPlugin.dispose();
    stateModel.flutterWebViewPlugin = null;
  }

  @override
  Widget build(BuildContext context) {
//    // TODO: implement build
    Widget _buildTitle() {
      return
//        Row(
//        children: <Widget>[
        Expanded(child: Container(
          child: Text(StringsHelper.isNotEmpty(_urlTitle) ? _urlTitle : (title ?? ""),
//            child: Text(_urlTitle ?? '',
              style: TextStyle(fontSize: UIData.fontSize18, color: UIData.darkGreyColor),
              overflow: TextOverflow.ellipsis),
          margin: EdgeInsets.only(right: ScreenUtil.getInstance().setWidth(16)),
        ));
//          Visibility(
//              visible: loading,
//              child: SizedBox(
//                width: 15.0,
//                height: 15.0,
//                child: CircularProgressIndicator(
//                    strokeWidth: 1.0,
//                    valueColor: AlwaysStoppedAnimation(UIData.themeBgColor)),
//              )),
//        ],
//      );
    }

//    Map<String, String> map = new Map();
//    map["Referer"]="http://app.park.ylmo2o.com";
//    LogUtils.printLog('urlurlurlurlurl:$url');
    return CommonScaffold(
      appTitle: _buildTitle(),
      leftButton: Row(
        children: <Widget>[
          GestureDetector(
              behavior: HitTestBehavior.translucent,
              child: Container(
//                        width: 35,
                height: 35,
//                      iconSize: 35.0,
                padding: EdgeInsets.only(left: UIData.spaceSize16),
                child: Icon(Icons.keyboard_arrow_left,
                    color: UIData.darkGreyColor),
              ),
              onTap: () {
                _goBack();
              }),
          GestureDetector(
              behavior: HitTestBehavior.translucent,
              child: Container(
//                        width: 35,
                height: 35,
//                      iconSize: 35.0,
                padding: EdgeInsets.only(right: UIData.spaceSize16),
                child: Icon(Icons.clear, color: UIData.darkGreyColor),
              ),
              onTap: () {
                Navigator.of(context).pop(true);
              }),
        ],
      ),
      showAppBar: widget?.showTitle ?? false,
      appBarActions: widget.toShare
          ? [
              IconButton(
                  icon: Icon(Icons.share, color: UIData.greyColor),
                  onPressed: () {
                    setState(() {
                      _shareVisible = !_shareVisible;
                    });
                  })
            ]
          : null,
      bodyData: SafeArea(
          child: Column(
        children: <Widget>[
          SizedBox(
            height: 1.0,
            child: loading
                ? LinearProgressIndicator(
                    backgroundColor: UIData.dividerColor,
                    value: loadingProgressValue)
                : Container(),
          ),
          Expanded(
            child: WebviewScaffold(
              url: startUrl,
//              providerName: "fileProvider",
              initialChild: Container(
                child: const Center(
                  child: Text('加载中.....'),
                ),
              ),
//        headers: map,
//              userAgent:
//                  'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) '
//                  'Chrome/62.0.3202.94 Mobile Safari/537.36',
              withJavascript: true,
//              javascriptChannels: jsChannels,
//          clearCache:true,
//          clearCookies:true,
//        enableAppScheme: true,
//        primary: true,
//        withZoom: true,
//        withLocalStorage: true,
////        hidden: true,
////        withLocalUrl: true,
//          scrollBar:false,
//        supportMultipleWindows: true,
//        appCacheEnabled: true,
//          hidden : false,
//        allowFileURLs: true,
//        resizeToAvoidBottomInset: true,
//        geolocationEnabled: true,
              bottomNavigationBar: _shareVisible
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        CommonShareBottomSheet(
                            CommonShareModel(
                              title: title ?? '',
                              thumbImageUrl: StringsHelper.isNotEmpty(
                                      widget.thumbImageUrl)
                                  ? widget.thumbImageUrl
                                  : HttpOptions.urlProduction
                                          .replaceAll('ubms-customer/', '') +
                                      "template/appShare/images/icon_app.png",
                              text: '',
                              url: widget.url + '&state=share',
                            ),
                            close: false, callback: () {
                          LogUtils.printLog('图片路径：${widget.thumbImageUrl}');
                          setState(() {
                            _shareVisible = false;
                          });
                        }),
                        FlatButton(
                            onPressed: () {
                              setState(() {
                                _shareVisible = false;
                              });
                            },
                            child: CommonText.grey14Text('取消'))
                      ],
                    )
                  : null,
              javascriptChannels: <JavascriptChannel>[
                JavascriptChannel(
                    name: 'customer',
                    onMessageReceived: (JavascriptMessage message) {
                      LogUtils.printLog("html传入参数： ${message.message}");
                      WebViewCallNative callNative = WebViewCallNative.fromJson(
                          json.decode(message.message));
                      if (callNative.functionName == 'GOTO_MAP') {
                        //跳转到第三方地图
                        _gotoMap(callNative);
                      } else if (callNative.functionName == 'PHOTO_UPLOAD') {
                        //图片上传
                        _uploadImage(callNative);
                      } else if (callNative.functionName == 'SHARE') {
                        //分享
                        _share(callNative);
                      } else if (callNative.functionName == 'CALL_PHONE') {
                        //拨打电话
                        if (StringsHelper.isEmpty(callNative?.data)) {
                          errorCallback(callNative, "电话号码为空");
                        } else {
                          stateModel.callPhone(callNative.data);
                        }
                      } else if (callNative.functionName == 'CLOSE_PAGE') {
                        //关闭页面
                        Navigate.closePage();
                      } else if (callNative.functionName == 'CHECK_HOUSE') {
                        successCallback(callNative, checkCustomerHouse()?"true":"false");
                        //校验客户房屋校验客户是否存在在住或者暂离房屋，并进行认证
//                        if (checkCustomerHouse()) {
//                          successCallback(callNative, "true");
//                        } else {
//                          stateModel.flutterWebViewPlugin.hide(); //先隐藏
//                          _showUncertifiedDialog(context,callNative,(needToPage){
//                            if(needToPage){
//                              Navigate.toNewPage(MyHousePage(),callBack: (data){
//                                //关闭页面回来
//                                stateModel.flutterWebViewPlugin.show(); //显示
//                                if (checkCustomerHouse()) {
//                                  successCallback(callNative, "true");
//                                }
//                              });
//                            }else{
//                              stateModel.flutterWebViewPlugin.show(); //显示
//                            }
//                          });
//                        }
                      }
                    })
              ].toSet(),
            ),
          )
        ],
      )),
    );
  }

// ignore: prefer_collection_literals
//  final Set<JavascriptChannel> jsChannels = [
//    JavascriptChannel(
//        name: 'Native',
//        onMessageReceived: (JavascriptMessage message) {
//          print(message.message);
//        }),
//    JavascriptChannel(
//        name: 'NativepostCall',
//        onMessageReceived: (JavascriptMessage message) {
//          print(message.message);
//        }),
//  ].toSet();

  //获取h5页面标题
  _getHtmlTitle() async {
    String script = 'window.document.title';
    String title;
    title = await stateModel.flutterWebViewPlugin.evalJavascript(script);
    title = title.replaceAll(r'"', '');
    setState(() {
      _urlTitle = title;
    });
    LogUtils.printLog('html标题：$title');
  }

  //返回页面或关闭页面
  _goBack() async{
    if (canGoBack || await stateModel.flutterWebViewPlugin.canGoBack()) {
      stateModel.flutterWebViewPlugin.goBack();
    } else {
      Navigator.of(context).pop(true);
    }
  }

  //成功的回调
  void successCallback(WebViewCallNative callNative, String data) {
    if (data.contains("[") || data.contains("{")) {
      //直接传object
      LogUtils.printLog("${callNative.successCallback}(" + data + ")");
      stateModel.flutterWebViewPlugin
          .evalJavascript("${callNative.successCallback}(" + data + ")");
    } else {
      LogUtils.printLog("${callNative.successCallback}(\"" + data + "\")");
      stateModel.flutterWebViewPlugin
          .evalJavascript("${callNative.successCallback}(\"" + data + "\")");
//          .evalJavascript("${callNative.successCallback}(\"" + '拍照完成' + "\")");
    }
  }

  //失败的回调
  void errorCallback(WebViewCallNative callNative, String msg) {
    stateModel.flutterWebViewPlugin
        .evalJavascript("${callNative.errorCallback}(\"" + msg + "\")");
  }

  //地图跳转
  _gotoMap(WebViewCallNative callNative) async {
    String errorMessage;
    try {
      MapInfoModel mapInfo = MapInfoModel.fromJson(callNative.data);
      if ("baidu" == mapInfo.map) {
        //跳转到百度地
        errorMessage = await MapUtil.gotoBaiduMap(
            mapInfo.longitude, mapInfo.latitude,
            address: mapInfo.address);
      } else if ("gaode" == mapInfo.map) {
        //跳转到高德地图
        errorMessage = await MapUtil.gotoAMap(
            mapInfo.longitude, mapInfo.latitude,
            address: mapInfo.address);
      } else if ("tengxun" == mapInfo.map) {
        //跳转到腾讯地图
        errorMessage = await MapUtil.gotoTencentMap(
            mapInfo.longitude, mapInfo.latitude,
            address: mapInfo.address);
      } else {
        errorMessage = "未适配地图";
      }
    } catch (e) {
      errorMessage = "位置信息错误";
    }
    if (errorMessage != null) {
      errorCallback(callNative, errorMessage);
    }
  }

  //分享
  _share(WebViewCallNative callNative) async {
    String errorMessage;
    try {
      ShareInfoModel info = ShareInfoModel.fromJson(callNative.data);
      CommonShareModel shareModel = new CommonShareModel(
          title: info?.title??" ",
          text: info?.content??" ",
          thumbImageUrl: info?.imageUrl??"${HttpOptions.urlProduction.replaceAll('ubms-customer/', '')}template/appShare/images/icon_app.png",
          url: info?.url??"");
      if ("weixin" == info.type) {
        ShareUtil.share(shareModel, ShareSDKPlatforms.wechatSession);
      } else if ("pengyouquan" == info.type) {
        ShareUtil.share(shareModel, ShareSDKPlatforms.wechatTimeline);
      } else if ("qq" == info.type) {
        ShareUtil.share(shareModel, ShareSDKPlatforms.qq);
      } else {
        errorMessage = "未适配分享平台";
      }
    } catch (e) {
      errorMessage = "分享信息错误";
    }
    if (errorMessage != null) {
      errorCallback(callNative, errorMessage);
    }
  }

  //图片上传
  _uploadImage(WebViewCallNative callNative) async {
    //图片上传
    PermissionUtil.requestPermission(
        ("camera" == callNative.data)
            ? [PermissionGroup.camera]
            : [PermissionGroup.storage, PermissionGroup.photos],
        callback: (bool isGranted) async {
      if (isGranted) {
        ImageStateModel().getImage(callNative.data, (result) {
          if (result != null) {
            try {
              Attachment info = Attachment.fromJson(result);
              if (StringsHelper.isNotEmpty(info?.attachmentUuid)) {
                List<String> uuids = [
                  info?.attachmentUuid
                ];
                successCallback(callNative, json.encode(uuids));
              } else {
                errorCallback(callNative, "图片上传失败");
              }
            } catch (e) {
              errorCallback(callNative, "图片上传失败");
            }
          } else {
            errorCallback(callNative, "图片上传失败");
          }
        }, (errorMessage) {
          errorCallback(callNative, errorMessage?.toString() ?? "图片上传失败");
        });
      } else {
        errorCallback(
            callNative,
            ("camera" == callNative.data)
                ? "请打开相机权限"
                : (Platform.isIOS ? "请打开照片读取权限" : "请打开存储权限"));
      }
    });
  }

  //校验客户在当前项目存在在住或者暂离的房屋
  bool checkCustomerHouse(){
    return (2 == stateModel?.customerType &&
        stateModel.customerId != null &&
        stateModel.defaultProjectId != null &&
        stateModel.defaultHouseId != null);
  }

  //打开其他APP
  _openOtherAPP(String url,{String appName,bool needToast = true}) async{
    if(await canLaunch(url)){
      launch(url);
    }else{
      if(needToast)
        Fluttertoast.showToast(msg: "请先安装${appName??""}");
    }
  }

//  //显示未认证窗口
//  _showUncertifiedDialog(BuildContext context, WebViewCallNative callNative,Function callback) {
//    showDialog(
//        context: context,
//        barrierDismissible: false,
//        builder: (BuildContext context) {
//          return WillPopScope(
//              child: SimpleDialog(
//                backgroundColor: Colors.transparent,
//                contentPadding: EdgeInsets.only(top: UIData.spaceSize16),
//                children: <Widget>[
//                  Container(
//                    alignment: Alignment.centerRight,
//                    height: UIData.spaceSize40,
//                    child: GestureDetector(
//                        child: Image.asset(UIData.imageRoundClose,
//                            width: UIData.spaceSize24,
//                            height: UIData.spaceSize24),
//                        onTap: () {
//                          Navigator.pop(context);
//                          if(callback!=null) callback(false);
//                        }),
//                  ),
//                  Container(
//                    decoration: BoxDecoration(
//                        borderRadius: BorderRadius.circular(5),
//                        color: UIData.primaryColor),
//                    child: Center(
//                      child: Column(
//                        mainAxisSize: MainAxisSize.min,
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        crossAxisAlignment: CrossAxisAlignment.center,
//                        children: <Widget>[
//                          SizedBox(height: UIData.spaceSize40),
//                          Image.asset(
//                            UIData.imageTouristNoRecord,
//                            fit: BoxFit.fitWidth,
//                            width: ScreenUtil.getInstance().setWidth(135),
//                          ),
//                          SizedBox(height: UIData.spaceSize16),
//                          CommonText.grey16Text(callNative?.data ?? '很抱歉，\n请完成房屋认证',
//                              textAlign: TextAlign.center),
//                          SizedBox(height: UIData.spaceSize20),
//                          StadiumSolidButton(
//                            Padding(
//                              padding: EdgeInsets.symmetric(
//                                  horizontal: UIData.spaceSize20),
//                              child: CommonText.white16Text('马上认证'),
//                            ),
//                            onTap: () {
//                              Navigate.closePage();
//                              if(callback!=null) callback(true);
//                            },
//                          ),
//                          FlatButton(
//                              onPressed: () {
//                                Navigate.closePage();
//                                if(callback!=null) callback(false);
//                              },
//                              child: CommonText.red16Text('取消')),
//                          SizedBox(height: UIData.spaceSize40),
//                        ],
//                      ),
//                    ),
//                  ),
//                  SizedBox(height: UIData.spaceSize40)
//                ],
//              ),
//              onWillPop: () async {
//                return false;
//              });
//        });
//    return null;
//  }
}
