import 'dart:convert';
import 'dart:io';

import 'package:cmp_customer/models/decoration_obj.dart';
import 'package:flutter/services.dart';
import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/ad_info_model.dart';
import 'package:cmp_customer/models/banner_model.dart';
import 'package:cmp_customer/models/community_activity_model.dart';
import 'package:cmp_customer/models/dictionary_list.dart';
import 'package:cmp_customer/models/market/ware_detail_model.dart';
import 'package:cmp_customer/models/pgc/pgc_comment_obj.dart';
import 'package:cmp_customer/models/pgc/pgc_infomation_obj.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/scoped_models/decoration_model.dart';
import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/scoped_models/market_model/market_list_model.dart';
import 'package:cmp_customer/scoped_models/new_house_state_model.dart';
import 'package:cmp_customer/scoped_models/pgc_model/pgc_infomation_model.dart';
import 'package:cmp_customer/scoped_models/reservation_state_model.dart';
import 'package:cmp_customer/strings/strings_common.dart';
import 'package:cmp_customer/strings/strings_notice.dart';
import 'package:cmp_customer/ui/articles_release/articles_release_detail_page.dart';
import 'package:cmp_customer/ui/change_of_title/change_of_title_detail.dart';
import 'package:cmp_customer/ui/check_in/check_in_details.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_dialog.dart';
import 'package:cmp_customer/ui/common/common_image_widget.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_shadow_container.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/conference_room_reservation/reservation_detail.dart';
import 'package:cmp_customer/ui/decorate_manager/decoration_permit/decoration_apply_detail_page.dart';
import 'package:cmp_customer/ui/decorate_manager/decoration_permit/decoration_apply_detail_tab.dart';
import 'package:cmp_customer/ui/decoration/decoration_pass_card_details.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_apply_audit.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_details.dart';
import 'package:cmp_customer/ui/home/banner_detail_page.dart';
import 'package:cmp_customer/ui/home/community_activity_page.dart';
import 'package:cmp_customer/ui/home/home_appbar.dart';
import 'package:cmp_customer/ui/home/service_page.dart';
import 'package:cmp_customer/ui/hot_work/hot_work_detail_page.dart';
import 'package:cmp_customer/ui/house_authentication/house_detail_page.dart';
import 'package:cmp_customer/ui/house_authentication/my_house_page.dart';
import 'package:cmp_customer/ui/html/html_page.dart';
import 'package:cmp_customer/ui/market/chat_list.dart';
import 'package:cmp_customer/ui/market/market_detail.dart';
import 'package:cmp_customer/ui/market/market_item.dart';
import 'package:cmp_customer/ui/market/market_list_page.dart';
import 'package:cmp_customer/ui/new_house/new_house_detail_page.dart';
import 'package:cmp_customer/ui/notice/message_page.dart';
import 'package:cmp_customer/ui/notice/property_notice_detail_page.dart';
import 'package:cmp_customer/ui/notice/property_notice_page.dart';
import 'package:cmp_customer/ui/office_cancel_lease/office_cancel_lease_detail_page.dart';
import 'package:cmp_customer/ui/parking/parking_card_details.dart';
import 'package:cmp_customer/ui/pgc/pgc_comment_page.dart';
import 'package:cmp_customer/ui/pgc/pgc_infomation/pgc_infomation_detail.dart';
import 'package:cmp_customer/ui/pgc/pgc_infomation/pgc_infomation_item.dart';
import 'package:cmp_customer/ui/pgc/pgc_infomation/pgc_infomation_list_page.dart';
import 'package:cmp_customer/ui/pgc/pgc_ui.dart';
import 'package:cmp_customer/ui/work_other/complaint_detail_page.dart';
import 'package:cmp_customer/ui/work_other/complaint_page.dart';
import 'package:cmp_customer/ui/work_other/work_other_ui.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/permission_util.dart';
import 'package:cmp_customer/utils/shared_preferences_key.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:install_plugin/install_plugin.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scoped_model/scoped_model.dart';

import 'mall_msg_detail_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _maxImageHeight = 0;
//  List<MenuInfo> _menuList; //菜单列表
  bool _marketStatementCheck = false; //邻里集市声明是否显示
  GlobalKey _marketStatementDialogKey = GlobalKey(); //邻里集市声明弹框的key
  bool _downBack = false; //是否后台下载更新应用
  GlobalKey _dialogKey = GlobalKey(); //进度条弹框的key
  double _installProgress = 0; //安装包下载进度
  int _countJPush = 0; //调用极光推送设置别名的次数
  GlobalKey<ComplaintDetailPageState> detailKey = new GlobalKey<ComplaintDetailPageState>();

  @override
  void initState() {
    super.initState();
//    _initBanner();
    //750*314
    double screenWidth = ScreenUtil.screenWidthDp;
    _maxImageHeight = 314 * (screenWidth / 750);

    _getAppVersion();
    _getAd();
    _getHomeData();
    _initJPush();
  }

  @override
  void dispose() {
    super.dispose();
    stateModel.closeWebSocket(); //关闭聊天
  }

  Future<void> _getUserData() async {
    await stateModel.getUserData(callBack: ({String errorMsg}) {
      if (StringsHelper.isNotEmpty(errorMsg)) CommonToast.show(type: ToastIconType.FAILED, msg: errorMsg);
    });
  }

  void _getHomeData() {
//    stateModel.getCommunityActivityListOnHomePage();
//    stateModel.getVoteListOnHomePage();
//    stateModel.getQuestionnaireListOnHomePage();
//    stateModel.getPgcInformationListOnHomePage();
//    stateModel.getMarketListOnHomePage();
    stateModel.loadCityData(); //加载城市数据
    stateModel.findWareDataDictionaryList(); //获取商品类型数据
    _getWorkOrderData(); //工单基础数据
//    stateModel.getBanner();
  }

  void _getWorkOrderData() {
    stateModel.checkOutDataDictionaryList(
        dataMap: {"dataSubType": "Paid", "dataType": "WO_SERVICE_SUB_TYPE"},
        callBack: (List<Dictionary> data) {
          if (data != null && data.length > 0) {
            data.forEach((Dictionary dictionary) {
              /// String pay_Appliance_repair = '家政维修';
              // String pay__Appliance_installation = '家电安装';
              // String pay_Housing_maintenance = '房屋维修';
              // String pay_Housekeeping = '房屋保洁';
              // String pay_orther = '其他服务';
              switch (dictionary.dataCode) {
                case 'InstallPaid': //家电安装
                  pay__Appliance_installation = '家电安装';
                  break;
                case 'RepairPaid': //家政维修
                  pay_Appliance_repair = '家政维修';
                  break;
                case 'CleaningPaid': //家政保洁
                  pay_Housekeeping = '家政保洁';
                  break;
                case 'HousePaid': //房屋维修
                  pay_Housing_maintenance = '房屋维修';
                  break;
                case 'OtherPaid': //其它
                  pay_orther = '其它服务';
                  break;
              }
            });
          }
        });
  }

  //获取广告弹框内容
  void _getAd() {
    stateModel.getAd(callback: (AdInfo adInfo) async {
      Dio dio = new Dio(HttpOptions.getInstance);
      Map<String, dynamic> map = new Map();
      map["Accept-Encoding"] = "identity"; //https长度返回-1，在此添加参数后正常
      Options options = Options(receiveTimeout: 900000, headers: map);

      Response response = await dio.head(HttpOptions.urlAppDownloadImage + adInfo.imgUrl, options: options);
      var adLength = response?.headers?.contentLength;
      LogUtils.printLog('adLength:$adLength');

      final Directory tempDir = await getTemporaryDirectory();
      LogUtils.printLog('tempDir:${tempDir.path}');
      SharedPreferences prefs = await SharedPreferencesKey.globalPrefs;
//      prefs.setString(SharedPreferencesKey.KEY_AD_FLAG, '红花'); //测试数据
      if (!prefs.containsKey(SharedPreferencesKey.KEY_AD_FLAG) ||
          (prefs.containsKey(SharedPreferencesKey.KEY_AD_FLAG) &&
              prefs.getString(SharedPreferencesKey.KEY_AD_FLAG) != adInfo?.foreign)) {
        dio.download(HttpOptions.urlAppDownloadImage + adInfo.imgUrl, '${tempDir.path}/${adInfo.imgUrl}',
            options: Options(receiveTimeout: 900000), onReceiveProgress: (int received, int total) async {
          LogUtils.printLog('下载监听');
          LogUtils.printLog('progress received: $received');
          LogUtils.printLog('progress total: $total');
          if (received == adLength) {
            LogUtils.printLog('下载完成');
            File image = File('${tempDir.path}/${adInfo.imgUrl}');
            if (await image.exists()) {
              LogUtils.printLog('image 存在');
              prefs.setString(SharedPreferencesKey.KEY_AD_FLAG, adInfo?.foreign);
              CommonDialog.showAdDialog(context, adInfo, bgImage: image);
            }
          }
        });
      }
    });
  }

  //检测版本
  void _getAppVersion() {
    LogUtils.printLog('检测版本  检测版本  检测版本');
    stateModel.getAppVersion(callback: (String url, String version, bool isForce, String size, String desc) {
      //下载
//      if (Platform.isAndroid) {
      PermissionUtil.requestPermission([PermissionGroup.storage], callback: (bool isGranted) async {
        if (isGranted) {
          _showTipInstallDialog(url, version, isForce, size, desc);
        } else {
          if (isForce) {
            //强制升级
            CommonDialog.showAlertDialog(context,
                title: '请打开存储权限用以更新版本！',
//                  showPositiveBtn: false,
                showNegativeBtn: false,
                willPop: !isForce, onConfirm: () {
              //这是整个app退出
//              SystemNavigator.pop();
              exit(0);
            });
          } else {
            CommonDialog.showAlertDialog(context, title: '请打开存储权限用以更新版本！', showNegativeBtn: false);
          }
        }
      });
//      } else {
//        InstallPlugin.gotoAppStore(url);
//      }
    });
  }

  void _showTipInstallDialog(String url, String version, bool isForce, String size, String decs) {
    if (isForce) {
      //强制升级
      CommonDialog.showUpgradeDialog(context,
          version: version, content: decs, isForce: isForce, onTapCloseDialog: Platform.isAndroid, onConfirm: () {
        if (Platform.isAndroid) {
//          _buildProgress();
          _installNewVersion(url, version, size, isForce);
        } else if (Platform.isIOS) {
          if (HttpOptions.isTrialVersion) {
            //IOS体验版跳转链接下载
            if (StringsHelper.isNotEmpty(url)) {
              stateModel.launchURL(url);
//              CommonDialog.showUpgradingDialog(context);
            }
          } else {
            //IOS正式版跳转App Store
            InstallPlugin.gotoAppStore(url);
//            CommonDialog.showUpgradingDialog(context);
          }
        }
      }
//      , onCancel: () {
//        //这是整个app退出
////        SystemNavigator.pop();
//        exit(0);
//      }
          );
//      CommonDialog.showAlertDialog(context, content: '检测到新版本，是否安装？', willPop: !isForce,
////                showPositiveBtn: false,
////                showNegativeBtn: false,
//          onConfirm: () {
//      }, onCancel: () {
//        //这是整个app退出
////        SystemNavigator.pop();
//        exit(0);
//      });
    } else {
      CommonDialog.showUpgradeDialog(context, version: version, content: decs, isForce: isForce, onConfirm: () {
        if (Platform.isAndroid) {
          _installNewVersion(url, version, size, isForce);
        } else if (Platform.isIOS) {
          if (HttpOptions.isTrialVersion) {
            //IOS体验版跳转链接下载
            if (StringsHelper.isNotEmpty(url)) {
              stateModel.launchURL(url);
            }
          } else {
            //IOS正式版跳转App Store
            InstallPlugin.gotoAppStore(url);
          }
        }
      });
//      CommonDialog.showAlertDialog(context, content: '检测到新版本，是否安装？', willPop: !isForce, onConfirm: () {
////        _installNewVersion(url, version, size);
//        if (Platform.isAndroid) {
//          _installNewVersion(url, version, size, isForce);
//        } else if (Platform.isIOS) {
//          if (HttpOptions.isTrialVersion) {
//            //IOS体验版跳转链接下载
//            if (StringsHelper.isNotEmpty(url)) {
//              stateModel.launchURL(url);
//            }
//          } else {
//            //IOS正式版跳转App Store
//            InstallPlugin.gotoAppStore(url);
//          }
//        }
//      });
    }
  }

  //进度条弹框
  Widget _buildProgress(bool isForce) {
    return CommonDialog.showAlertDialog(context,
        content: StatefulBuilder(
            key: _dialogKey,
            builder: (context, state) {
              return Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: UIData.spaceSize16),
                    width: UIData.spaceSize150,
                    child: Image.asset(UIData.imageInUpgrading),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: LinearProgressIndicator(
                              backgroundColor: UIData.dividerColor, value: _installProgress.toInt() / 100)),
                      SizedBox(width: UIData.spaceSize4),
                      CommonText.darkGrey14Text('${_installProgress.toInt()}%')
                    ],
                  ),
                ],
              );
            }),
        showPositiveBtn: !isForce,
        showNegativeBtn: false,
        willPop: false,
        positiveBtnText: '后台下载',
        positiveBtnColor: Colors.redAccent, onConfirm: () {
      setState(() {
        _downBack = true;
      });
    });
  }

  //安装新版本
  void _installNewVersion(String url, String version, String size, bool isForce) async {
//    final Directory dir = await getTemporaryDirectory();
    final Directory exDir = await getExternalStorageDirectory();
    final Directory dir = Directory('${exDir.path}$externalDir');
    if (!(await dir.exists())) {
      await dir.create();
    }
//    final dir = await getTemporaryDirectory();
//    final Directory dir = await getApplicationDocumentsDirectory();
    LogUtils.printLog('安装包路径:$dir');
//    LogUtils.printLog('安装包路径exDir:$exDir');
    String apkName = url.split('/').last;
    String apkAbsoluteName = '${dir.path}/$apkName';
    LogUtils.printLog('apkAbsoluteName:$apkAbsoluteName');
    File apkFile = File(apkAbsoluteName);
    LogUtils.printLog('服务器文件大小：$size');
    LogUtils.printLog('本地文件大小：${await apkFile.exists() ? await apkFile.length() : '空'}');
    Dio dio = new Dio(HttpOptions.getInstance);

    if (apkFile != null && await apkFile.exists()) {
      int localFileLength = await apkFile.length();
      LogUtils.printLog('localFileLength: $localFileLength}');
      if (localFileLength > 0) {
        Response response = await dio.head(url);
        int newVersionLength = response?.headers?.contentLength;
        LogUtils.printLog('newVersionLength: $newVersionLength');
        if (localFileLength == newVersionLength) {
          //本地文件已下载完成最新版本，可直接安装
//          Navigator.pop(context);
          _showInstallNewVersion(apkAbsoluteName, isForce);
//          OpenFile.open(apkAbsoluteName, type: "application/vnd.android.package-archive");
          stateModel.openFile(apkAbsoluteName);
          return;
        }
      }
    }
//    if (await apkFile.exists() && StringsHelper.isNotEmpty(size) && await apkFile.length() == int.parse(size)) {
//      //安装包已存在本地，直接安装
//      OpenFile.open(apkAbsoluteName, type: "application/vnd.android.package-archive");
//      exit(0);
//    } else {
    //安装包不存在本来，先下载再安装
    _buildProgress(isForce);
    Options options = Options(receiveTimeout: 900000);
//    dio.download('http://60.213.146.68:8001/download/wl_v0.2.6.apk', dir.path + '/' + url.split('/').last,
//        options: options, onReceiveProgress: (int received, int total) {
    LogUtils.printLog('@@@@@@@@@@@@@@@@@@@$apkAbsoluteName');
//    dio.download(url, dir.path + '/' + url.split('/').last, options: options,
    LogUtils.printLog('apkAbsoluteName2:$apkAbsoluteName');
    dio.download(url, apkAbsoluteName, options: options, onReceiveProgress: (int received, int total) {
      LogUtils.printLog('下载监听');
      LogUtils.printLog('progress received: $received');
      LogUtils.printLog('progress total: $total');
      if (_dialogKey.currentState != null) {
        _dialogKey.currentState.setState(() {
          LogUtils.printLog('progress: ${_installProgress.toInt()}');
          if ((received / total * 100) > _installProgress) _installProgress = received / total * 100;
        });
      }
      // 当下载完成时，调用安装
      if (received == total) {
        LogUtils.printLog('下载完成');
        if (!_downBack) Navigator.pop(context);
        _showInstallNewVersion(apkAbsoluteName, isForce);
        stateModel.openFile(apkAbsoluteName);
//        InstallPlugin.installApk(dir.path + '/' + url.split('/').last, stateModel.packageName);
//          OpenFile.open(apkAbsoluteName, type: "application/vnd.android.package-archive");
        //这是整个app退出
//        SystemNavigator.pop();
//          exit(0);
//        FlutterDownloader.open(taskId: id);
      }
    });
//    }
  }

  void _showInstallNewVersion(String filePath, bool isForce) {
    CommonDialog.showAlertDialog(context,
        content: "新版本下载完成，点击安装",
        positiveBtnText: '安装',
        showNegativeBtn: !isForce,
        willPop: !isForce,
        onTapCloseDialog: false, onConfirm: () {
      stateModel.openFile(filePath);
//      OpenFile.open(filePath, type: "application/vnd.Android.package-archive");
    });
  }

  Future<void> _initJPush() async {
//    jPush.getRegistrationID().then((rid) {
//      setState(() {
//        debugLable = "flutter getRegistrationID: $rid";
//      });
//    });

    try {
      //注意：addEventHandler 方法建议放到 setup 之前，其他方法需要在 setup 方法之后调用
      stateModel.jPush.addEventHandler(
        // 接收通知回调方法。
        onReceiveNotification: (Map<String, dynamic> message) async {
          stateModel.getUnReadMessageTotalCount();
          LogUtils.printLog("flutter onReceiveNotification: $message");
          var extras;
          if (Platform.isAndroid)
            extras = json.decode(message['extras']['cn.jpush.android.EXTRA']);
          else
            extras = message['extras'];
          LogUtils.printLog("flutter onReceiveNotification extras: $extras");
          if (extras != null) {
            if (extras.containsKey('messageType')) {
              String messageType = extras['messageType'];
              LogUtils.printLog("messageType: $messageType");
              //banner更新后消息推送（静默推送，用户收不到，只做后台处理）
              if (messageType == 'banner') {
                stateModel.getBanner();
//                stateModel.reLogin(callBack: ({String errorMsg}){
//                  if(errorMsg == null){
//                    stateModel.getBanner();
//                  }
//                });
              } else {
                if (extras.containsKey('subMessageType')) {
                  switch (extras['subMessageType']) {
                    //房屋认证通知认证通过
                    case 'FWRZTG':
                      LogUtils.printLog("flutter onReceiveNotification FWRZTG");
                      stateModel.reLogin();
//                stateModel.clearAccessToken();
//                stateModel.getUserData();
                      break;
                    case 'XFRH':
                      LogUtils.printLog("flutter onReceiveNotification XFRH");
//                if (stateModel.customerType == 1) {
                      stateModel.reLogin();
//                }
                      break;
                  }
                }
              }
            }
          }
        },
        // 点击通知回调方法。
        onOpenNotification: (Map<String, dynamic> message) async {
          jPushListener(message);
        },
        // 接收自定义消息回调方法。
        onReceiveMessage: (Map<String, dynamic> message) async {
          LogUtils.printLog("flutter onReceiveMessage: $message");
        },
      );
    } on PlatformException {
      LogUtils.printLog("Failed to get platform version.");
    }

    ///
    /// 添加初始化方法，调用 setup 方法会执行两个操作：
    ///  1、初始化 JPush SDK
    ///  2、将缓存的事件下发到 dart 环境中。
    ///
    ///注意： 插件版本 >= 0.0.8 android 端支持在 setup 方法中动态设置 channel，
    ///动态设置的 channel 优先级比 manifestPlaceholders 中的 JPUSH_CHANNEL 优先级要高。
    ///39175294bec711cb54367435 招商账号IOS体验版
    ///741ddd31e7d7e099295391c0 招商账号
    ///836845276e457c36d8ef0799 自己账号
    String appKey = '741ddd31e7d7e099295391c0';
    if (HttpOptions.isTrialVersion && Platform.isIOS) appKey = '39175294bec711cb54367435';
    stateModel.jPush.setup(
      appKey: appKey,
      channel: "developer-default",
      production: !HttpOptions.isInDebugMode,
      debug: HttpOptions.isInDebugMode,
//      production: HttpOptions.isInDebugMode, //测试数据
//      debug: !HttpOptions.isInDebugMode, //测试数据
    );

    _jPushSetAlias();

    //申请推送权限，注意这个方法只会向用户弹出一次推送权限请求（如果用户不同意，之后只能用户到设置页面里面勾选相应权限），需要开发者选择合适的时机调用。
    //注意： iOS10+ 可以通过该方法来设置推送是否前台展示，是否触发声音，是否设置应用角标 badge
    stateModel?.jPush?.applyPushAuthority(new NotificationSettingsIOS(sound: true, alert: true, badge: true));
    stateModel?.jPush?.getLaunchAppNotification()?.then((Map<dynamic, dynamic> message) {
      jPushListener(message);
    });
//
//    // If the widget was removed from the tree while the asynchronous platform
//    // message was in flight, we want to discard the reply rather than calling
//    // setState to update our non-existent appearance.
//    if (!mounted) return;
//
//    setState(() {
//      debugLable = platformVersion;
//    });
  }

  //极光推送监听
  void jPushListener(Map<dynamic, dynamic> message) {
    LogUtils.printLog("flutter onOpenNotification: $message");
    var extras;
    if (Platform.isAndroid)
      extras = json.decode(message['extras']['cn.jpush.android.EXTRA']);
    else {
      extras = message['extras'];
    }
//          LogUtils.printLog("flutter onReceiveNotification extras: $extras");
//          LogUtils.printLog("flutter onOpenNotification extras subMessageType: ${extras['subMessageType']}");
//          LogUtils.printLog("flutter onOpenNotification extras map: ${json.decode(extras)}");

    try {
      stateModel.setMessageRead(int.parse(extras['messageId']), stateModel.customerId, stateModel.accountId,
          callBack: () {
        setState(() {
          stateModel.getUnReadMessageTotalCount();
        });
      });
    } catch (e) {
      LogUtils.printLog('极光推送监听，设置条数');
    }
    if (extras != null && StringsHelper.isNotEmpty(extras['messageType']) && extras['messageType'] == 'GDXX') {
      //工单

      if (ComplaintDetailPageState.isOpen != null && ComplaintDetailPageState.isOpen) {
        detailKey.currentState.reflashDetailPage(int.parse(extras['relatedId']));
//        MainStateModel.of(context).getWorkOthersDetail(
//            int.parse(extras['relatedId']));
      } else {
        Navigate.toNewPage(ComplaintDetailPage(
          extras['subMessageType'],
          int.parse(extras['relatedId']),
          key: detailKey,
        ));
      }
    } else if (extras != null &&
        StringsHelper.isNotEmpty(extras['messageType']) &&
        extras['messageType'] == 'TZZX') {
      //物业通知
      Navigate.toNewPage(PropertyNoticeDetailPage(
        int.parse(extras['relatedId']),
      ));
    } else if (extras != null && StringsHelper.isNotEmpty(extras['subMessageType']))
      switch (extras['subMessageType']) {
        //房屋认证通知认证通过
        case 'FWRZTG':
          Navigate.toNewPage(HouseDetailPage(custHouseRelationId: int.parse(extras['relatedId'])));
          break;
        //房屋认证通知认证不通过
        case 'FWRZBTG':
          Navigate.toNewPage(HouseDetailPage(houseCustAuditId: int.parse(extras['relatedId'])));
          break;
        case 'MJK': //门禁卡
          if ("1" == extras['ToOwnerAgree']) {
            Navigate.toNewPage(EntranceCardApplyAuditPage(null, int.parse(extras['relatedId'])));
          } else {
            Navigate.toNewPage(EntranceCardDetailsPage(int.parse(
              extras['relatedId'],
            )));
          }
          break;
        //停车办理
        case 'XK':
        case 'XF':
        case 'TZ':
        case 'TCBL':
          Navigate.toNewPage(ParkingCardDetailsPage(int.parse(extras['relatedId'])));
          break;
        case 'ZHRZ': //租户入驻
          Navigate.toNewPage(CheckInDetailsPage(int.parse(extras['relatedId'])));
          break;
        case 'ACTIVITY_VIEW': //活动详情（1问卷/2投票/3报名）
          stateModel.communityActivityGetH5(int.parse(extras['relatedId']), callBack: (String url) {
            Navigate.toNewPage(HtmlPage(url, extras['title']));
          });
          break;
        case 'WPFX': //物品放行
          Navigate.toNewPage(
              ArticlesReleaseDetailPage(int.parse(extras['relatedId']), toOwnerAgree: extras['ToOwnerAgree']));
          break;
        case 'XZLTZ': //写字楼退租
          Navigate.toNewPage(OfficeCancelLeaseDetailPage(int.parse(extras['relatedId'])));
          break;
        case 'DHSQ': //动火申请
          Navigate.toNewPage(
              HotWorkDetailPage(int.parse(extras['relatedId']), toOwnerAgree: extras['ToOwnerAgree']));
          break;
        case messageSubTypeWAREREPLY: //集市的评论和回复
        case messageSubTypeWARELIKE: //集市的点赞
          Navigate.toNewPage(MarketDetail(
            int.parse(extras['relatedId']),
          ));
          break;
        case messageSubTypeTOPICCOMMENT: //话题评论/回复
        case messageSubTypeTOPICLIKE: //话题点赞
          _toTopicDetailPage(extras['relatedId']);
          break;
        case messageSubTypeTALKCOMMENT: //说说评论/回复
        case messageSubTypeTALKLIKE: //说说点赞
          _toTalkAboutDetailPage(extras['relatedId']);
          break;
        case 'JSLT': //集市聊天页面
          Navigate.toNewPage(ChatListPage());
          break;
        case 'REPLY': //评论/回复
        case 'LIKE': //点赞
          Navigate.toNewPage(PgcCommentPage(
              PgcCommentInfo(pgcId: int.parse(extras['mainId']), pgcCommentId: int.parse(extras['relatedId'])),
              PgcInfoType.infomation));
          break;
        case 'ZXCRZ': //装修出入证
          if ("1" == extras['ToOwnerAgree']) {
            Navigate.toNewPage(DecorationPassCardDetailsPage(int.parse(extras['relatedId']), 0)); //业主审核
          } else {
            Navigate.toNewPage(DecorationPassCardDetailsPage(int.parse(extras['relatedId']), 1)); //业主审核
          }
          break;
        case 'CQBG': //产权变更
          Navigate.toNewPage(ChangeOfTitleDetail(
              null,
//                                    widget.type,
              int.parse(extras['relatedId'])));
          break;
        case 'ZXYS':
        case 'ZXXKZ': //装修许可证
          DecorationModel _model = new DecorationModel();
          _model.getDecorationInfo(int.parse(extras['relatedId']), callback: (DecorationInfo info) {
            //ACCEPTANCE_CHECK-验收待处理，ACCEPTANCE_CHECK_FAIL-验收不通过，ACCEPTANCE_CHECK_SUCCESS-验收通过
            if ((info?.state ?? '') == 'ACCEPTANCE_CHECK' ||
                (info?.state ?? '') == 'ACCEPTANCE_CHECK_FAIL' ||
                (info?.state ?? '') == 'ACCEPTANCE_CHECK_SUCCESS')
              Navigate.toNewPage(
                DecorationDetailTabPage(_model, info.id),
              );
            else
              Navigate.toNewPage(
                DecorationApplyDetailPage(_model, info.id),
              );
          });
          break;
        case 'HYSYD': //会议室预定
          Navigate.toNewPage(ReservationDetailPage(ReservationModel(), int.parse(extras['relatedId'])));
          break;
        case 'XFRH': //新房入伙
          Navigate.toNewPage(NewHouseDetailPage(NewHouseStateModel(), int.parse(extras['relatedId'])));
          break;
        case 'RENT': //其他消息-房屋出租档案通知
        case 'HOUSEMAINTAINITEM': //其他消息-房屋维保项消息
        case 'HOUSEVACANT': //其他消息-房屋空置档案消息
          if (extras.containsKey('messageType') && StringsHelper.isNotEmpty(extras['messageType'])) {
            Navigate.toNewPage(MessagePage(messageCenterMap[extras['messageType']] ?? '', extras['messageType']));
          }
          break;
        case 'SCXX': //商城
          if (StringsHelper.isNotEmpty(extras['visitUrl']?.toString())) {
            //url有值跳转htmlPage
            Navigate.toNewPage(HtmlPage(
                HttpOptions.getMallUrl(
                    extras['visitUrl']?.toString(), stateModel.accountId, stateModel.defaultProjectId),
                '商城'));
          } else {
            Navigate.toNewPage(
                MallMsgDetailPage(extras['messageTitle']?.toString(), extras['messageText']?.toString()));
          }
          break;
      }
  }

  //获取当前环境标识，放在极光推送别名前面区分
  String _getEnvironment() {
//    return 'DEV'; //测试数据
    switch (HttpOptions.baseUrl) {
      case HttpOptions.urlProduction:
        //生产
        return 'PROD';
        break;
      case HttpOptions.urlDemonstration:
        //演示
        return 'PREVIEW';
        break;
      case HttpOptions.urlTest:
        //测试
        return 'TEST';
        break;
      default:
        return 'DEV';
        break;
    }
  }

  //极光推送设置别名
  void _jPushSetAlias() {
    LogUtils.printLog('极光推送设置别名：$_countJPush');
    stateModel.jPush.setAlias('${_getEnvironment()}${stateModel.userAccount}').then((map) {
//    stateModel.jPush.setAlias('1').then((map) { //测试数据
      LogUtils.printLog("setAlias success: $map");
    }).catchError((error, stackTrace) {
      LogUtils.printLog("setAlias error: $error");
//      reportError(error, stackTrace);
      if (_countJPush < 3) {
        Future.delayed(Duration(seconds: 15)).whenComplete(() {
          _countJPush++;
          _jPushSetAlias();
        });
      }
    });
  }

  //获取banner
//  void _initBanner() {
//    stateModel.getBanner();
//  }

  SwiperPlugin _buildSwiperPagination() {
    return SwiperPagination(
        margin: EdgeInsets.all(0.0),
        builder: SwiperCustomPagination(builder: (BuildContext context, SwiperPluginConfig config) {
          return Container(
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(UIData.imageBannerFrontBg), fit: BoxFit.fill)),
            padding: EdgeInsets.only(right: UIData.spaceSize4),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: stateModel.bannerList?.length ?? 1,
//                reverse: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: ScreenUtil.getInstance().setWidth(5),
                      height: ScreenUtil.getInstance().setHeight(5),
                      margin: EdgeInsets.only(right: UIData.spaceSize2, top: UIData.spaceSize20),
                      decoration: ShapeDecoration(
                          shape: BeveledRectangleBorder(
                            //每个角落的半径
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          color: config.activeIndex == index ? UIData.themeBgColor : UIData.dividerColor),
                    ),
                  );
                }),
            constraints: new BoxConstraints.expand(height: 35.0),
          );
        }));
  }

  //banner图片显示
  Widget _buildImage({String imagePath, GestureTapCallback onTap}) {
    return CommonImageWidget(imagePath, onTap: imagePath != null ? onTap : null);
//    return GestureDetector(
//        child: imagePath != null && imagePath.isNotEmpty
//            ? TransitionToImage(
//          image: AdvancedNetworkImage(
//            HttpOptions.showPhotoUrl(imagePath),
//            loadedCallback: () => LogUtils.printLog('It works!'),
//            loadFailedCallback: () => LogUtils.printLog('Oh, no!'),
//            // loadingProgress: (double progress, _) => print(progress),
//            timeoutDuration: Duration(seconds: 30),
//            retryLimit: 1,
//          ),
//          fit: BoxFit.cover,
//          placeholder: Image.asset(UIData.imageBannerDefaultFailed, fit: BoxFit.cover),
//          loadingWidgetBuilder: (
//              BuildContext context,
//              double progress,
//              Uint8List imageData,
//              ) {
//            return Image.asset(UIData.imageBannerDefaultLoading, fit: BoxFit.cover);
//          },
//        )
//            : Image.asset(UIData.imageBannerDefaultNoData, fit: BoxFit.cover),
//        onTap: imagePath != null ? onTap : null);
//    return GestureDetector(
//        child: imagePath != null && imagePath.isNotEmpty
//            ? CachedNetworkImage(
//                placeholder: (context, url) => Image.asset(UIData.imageBannerDefaultLoading),
//                errorWidget: (context, url, error) => Image.asset(UIData.imageBannerDefaultFailed),
//                imageUrl: HttpOptions.showPhotoUrl(imagePath),
//                fit: BoxFit.cover,
//              )
//            : Image.asset(UIData.imageBannerDefaultNoData, fit: BoxFit.fitHeight),
//        onTap: imagePath != null ? onTap : null);
  }

  ///
  /// 轮播图
  ///
  Widget _buildSwiper() {
    return ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
      return Container(
        alignment: Alignment.topCenter,
        width: ScreenUtil.screenWidth,
        height: _maxImageHeight,
        child: (stateModel.bannerList == null || stateModel.bannerList.length == 0)
            ? Container(child: _buildImage(), height: _maxImageHeight)
            : Swiper(
                autoplay: stateModel.bannerAutoPlay,
//            autoplay: false,
                //测试数据
                loop: (stateModel.bannerList?.length ?? 1) > 1,
                itemBuilder: (BuildContext context, int index) {
                  if (stateModel.bannerList == null || stateModel.bannerList.length == 0) {
                    return _buildImage();
                  } else {
                    BannerInfo bannerInfo = stateModel.bannerList[index];
                    return _buildImage(
                        imagePath: bannerInfo?.uuid,
                        onTap: () {
                          //类型：1-网页链接，2-图片链接，3-pgc链接
                          if (bannerInfo.type == 1) {
                            Navigate.toNewPage(HtmlPage(bannerInfo.url, bannerInfo?.title ?? ''));
//                      Navigate.toNewPage(HtmlPage('http://www.baidu.com', ''));
                          } else if (bannerInfo.type == 2) {
                            Navigate.toNewPage(BannerDetailPage(bannerInfo.url, bannerInfo?.title ?? ''));
                          } else if (bannerInfo.type == 3) {
                            Navigate.toNewPage(PgcInfomationDetail(
                                PgcInfomationInfo(
                                    pgcId: StringsHelper.isNotEmpty(bannerInfo.url)
                                        ? int.parse(bannerInfo.url)
                                        : null),
                                canEdit: false));
                          }
                        });
                  }
                },
                itemCount: stateModel.bannerList?.length ?? 1,
                pagination: _buildSwiperPagination()),
      );
    });
  }

  ///
  /// 一个Item，图标+文字样式
  ///
  Widget _buildItem(String title, String imageName, double size, {GestureTapCallback onTap}) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: ScreenUtil.getInstance().setWidth(size),
              height: ScreenUtil.getInstance().setHeight(size),
              child: Image.asset(imageName),
            ),
            SizedBox(height: UIData.spaceSize8),
            CommonText.darkGrey12Text(title),
          ],
        ),
      ),
      onTap: onTap,
    );
  }

  ///
  ///第一行图标
  ///[paddingDirect]内边距的方向，0-左，1-右
  ///
  Widget _buildFirstLineItem(String title, String subTitle, String imagePath, int paddingDirect,
      {GestureTapCallback onTap}) {
    return Expanded(
        child: GestureDetector(
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: UIData.lighterGreyColor, width: 0.2),
            borderRadius: BorderRadius.circular(6.0)),
        padding: EdgeInsets.only(
            left: paddingDirect == 1 ? 0 : UIData.spaceSize8,
            right: paddingDirect == 1 ? UIData.spaceSize8 : 0,
            top: UIData.spaceSize8,
            bottom: UIData.spaceSize8),
        child: paddingDirect == 1
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      CommonText.darkGrey15Text(title),
                      SizedBox(height: UIData.spaceSize4),
                      CommonText.lightGrey11Text(subTitle)
                    ],
                  ),
                  SizedBox(width: UIData.spaceSize8),
                  Image.asset(imagePath, width: UIData.spaceSize30, fit: BoxFit.fitWidth),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image.asset(imagePath, width: UIData.spaceSize30, fit: BoxFit.fitWidth),
                  SizedBox(width: UIData.spaceSize8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CommonText.darkGrey15Text(title),
                      SizedBox(height: UIData.spaceSize4),
                      CommonText.lightGrey11Text(subTitle)
                    ],
                  ),
                ],
              ),
      ),
      onTap: onTap,
    ));
  }

  ///
  /// 第一行图标
  ///
  Widget _buildFirstLine() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          color: UIData.primaryColor,
          padding: EdgeInsets.symmetric(vertical: UIData.spaceSize16, horizontal: UIData.spaceSize16),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _buildFirstLineItem('公区报障', '一键报障随手拍', UIData.iconReportObstacle, 0,
                      onTap: () =>
                          Navigate.checkCustomerCertified(context, ComplaintPage(WorkOtherMainType.Warning))),
                  SizedBox(width: UIData.spaceSize8),
                  _buildFirstLineItem('物管缴费', '一键缴费超省心', UIData.iconPropertyPayment, 1,
                      onTap: () => Navigate.checkCustomerCertified(
                          context, HtmlPage(HttpOptions.getPropertyPayUrl(), '物管缴费'))),
                ],
              ),
              SizedBox(height: UIData.spaceSize8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _buildFirstLineItem('停车缴费', '绿色通行好助手', UIData.iconParkingPayment, 0, onTap: () {
                    if (stateModel.defaultProjectId != null) {
                      Navigate.toNewPage(HtmlPage(
                          HttpOptions.getParkingPayUrl(stateModel.accountId, stateModel.defaultProjectId),
                          "停车缴费"));
                    } else {
                      CommonToast.show(msg: '请选择社区！', type: ToastIconType.INFO);
                    }
                  }),
                  SizedBox(width: UIData.spaceSize8),
                  _buildFirstLineItem(
                    '房屋租售',
                    '优房租售好管家',
//                    '到家钱包',
//                    '能赚能花的钱包',
//                    UIData.iconWallet,
                    UIData.iconHouseRentSale,
                    1,
                    onTap: () {
                      stateModel.tap2Module('房屋租售', title: '房屋租售', context: context);
//                      stateModel.getPurseUrl(stateModel.accountId, callback: (bool value) {
//                        if (value != null && !value) CommonDialog.showDevelopmentDialog(context);
//                      });
//                      Navigate.toNewPage(
//                          HtmlPage('http://119.147.37.203:9001/template/appShare/upload.html', '测试')); //测试数据
                    },
                  )
                ],
              ),
            ],
          ),
        ),
        GestureDetector(
            child: Container(
              padding: EdgeInsets.all(UIData.spaceSize12),
              decoration: ShapeDecoration(shape: CircleBorder(), color: UIData.primaryColor, shadows: [
                BoxShadow(
                    color: UIData.lightestGreyColor70,
                    offset: Offset(0.0, 3.0),
                    blurRadius: 1.0,
                    spreadRadius: 0.0)
              ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(UIData.iconMyHouse, width: UIData.spaceSize30, fit: BoxFit.fitWidth),
                  SizedBox(height: UIData.spaceSize8),
                  CommonText.darkGrey15Text('我的房屋'),
                  SizedBox(height: UIData.spaceSize8),
                ],
              ),
            ),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                  return MyHousePage();
//                  return FirstPrivacyPolicyPage(); //测试数据
                }))),
//        CommonShadowContainer(
//          borderRadius: 1000.0,
////          backgroundColor: UIData.lightestRedColor70,
//          shadowColor: UIData.lighterRedColor,
//          offsetX: 3.0,
//          offsetY: 1.0,
//          blurRadius: 1.0,
//          padding: EdgeInsets.all(UIData.spaceSize16),
//          child: Column(
//            children: <Widget>[
//              Image.asset(UIData.iconMyHouse, width: UIData.spaceSize30, fit: BoxFit.fitWidth),
//              SizedBox(width: UIData.spaceSize16),
//              CommonText.darkGrey18Text('我的房屋'),
//            ],
//          ),
//        )
      ],
    );
//    return Container(
//      color: UIData.primaryColor,
//      padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize16),
//      child: Container(
//        padding: EdgeInsets.symmetric(vertical: UIData.spaceSize20),
//        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: UIData.scaffoldBgColor))),
//        child: Row(
//          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//          children: <Widget>[
//            _buildItem('物管缴费', UIData.iconPropertyPayment, 42,
//                onTap: () =>
//                  Navigate.checkCustomerCertified(context,HtmlPage(HttpOptions.getPropertyPayUrl(), '物管缴费'))),
//            _buildItem('到家钱包', UIData.iconWallet, 42,
//                onTap: () =>
////                    CommonToast.show(msg: '非本期功能', type: ToastIconType.INFO)
//                    CommonDialog.showDevelopmentDialog(context)),
//            _buildItem('我的房屋', UIData.iconMyHouse, 42,
//                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
//                      return MyHousePage();
//                    }))),
//            _buildItem('停车缴费', UIData.iconParkingPayment, 42,
//                onTap: (){
//                  Navigate.toNewPage(HtmlPage(HttpOptions.getParkingPayUrl(stateModel.customerId, stateModel.defaultProjectId),"停车缴费"));
//                }
////                    CommonToast.show(
////                    msg: '开发中，稍候开放', type: ToastIconType.INFO)
////                    CommonDialog.showDevelopmentDialog(context)
//
//            ),
//            _buildItem('房屋租售', UIData.iconHousePurchasing, 42,
//                onTap: () =>
////                    CommonToast.show(msg: '非本期功能', type: ToastIconType.INFO)
////                    CommonDialog.showDevelopmentDialog(context)
//                //跳转到招商置业页面
//                Navigate.toNewPage(HtmlPage(HttpOptions.houseShouYeUrl,"房屋租售"))
//            ),
//          ],
//        ),
//      ),
//    );
  }

  List<Widget> _buildSecondItem() {
//    stateModel?.menuList = stateModel?.menuList?.where((MenuInfo child) => child.orderNo != -1)?.toList();
    List<Widget> widgetList = List();
    stateModel?.menuList?.forEach((MenuInfo menuInfo) {
      widgetList.add(_buildItem(
          menuInfo?.resourceName ?? '',
          '${StringsHelper.isNotEmpty(menuInfo?.icon) ? '${UIData.imageDirService}/${menuInfo?.icon?.trim()}' : '${UIData.imageDir}/nodata.png'}',
          26, onTap: () {
        stateModel.tap2Module(menuInfo.linkUrl, title: menuInfo.resourceName, context: context);
      }));
    });
    widgetList.add(_buildItem('全部', UIData.iconMore, 26, onTap: () {
      Navigate.toNewPage(ServicePage(showTop: false));
    }));
    return widgetList;
  }

  ///
  /// 第二三行Item
  ///
  Widget _buildSecondLine() {
    return Visibility(
        visible: stateModel.menuList != null && stateModel.menuList.length > 0,
        child: Container(
            color: UIData.primaryColor,
//        padding: EdgeInsets.only(top: UIData.spaceSize20),
            child: GridView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
              children: _buildSecondItem(),
//          children: <Widget>[
//            _buildItem('室内维修', UIData.iconRepairService, 26, onTap: () {
//              Navigate.checkCustomerCertified(
//                  context,
//                  ComplaintPage(
//                    WorkOtherMainType.Repair,
//                    sub: WorkOtherSubType.Repair,
//                  ));
//            }),
//            _buildItem('咨询建议', UIData.iconAdviceSuggestion, 26, onTap: () {
//              //PgcTopicDisscussPage
//              Navigate.checkCustomerCertified(
//                  context,
//                  ComplaintPage(
//                    WorkOtherMainType.Advice,
//                    sub: WorkOtherSubType.Advice,
//                  ));
//            }),
//            _buildItem('表扬', UIData.iconPraiseService, 26, onTap: () {
//              Navigate.checkCustomerCertified(context, ComplaintPage(WorkOtherMainType.Praise));
//            }),
//            _buildItem('投诉', UIData.iconComplaintService, 26, onTap: () {
//              Navigate.checkCustomerCertified(context, ComplaintPage(WorkOtherMainType.Complaint));
//            }),
//            _buildItem('物品放行', UIData.iconGoodsPassService, 26, onTap: () {
//              Navigate.checkCustomerCertified(context, ArticlesReleaseApplyPage());
//            }),
////            _buildItem('周边信息', UIData.iconAroundInfo, 26, onTap: () => Navigate.toNewPage(NearInfoListPage())),
//            _buildItem('社区通行', UIData.iconAccessPass, 26, onTap: () {
//              if (2 == stateModel?.customerType &&
//                  stateModel.customerId != null &&
//                  stateModel.defaultProjectId != null &&
//                  stateModel.defaultHouseId != null) {
//                CommonToast.show(msg: '加载中');
//                HttpUtil.refreshToken(callBack: ({String errorMsg}) async {
//                  CommonToast.dismiss();
//                  if (errorMsg == null) {
//                    stateModel.getAccessPassInfo();
//                  } else {
//                    CommonToast.show(type: ToastIconType.FAILED, msg: errorMsg);
//                  }
//                });
//              } else {
//                CommonDialog.showUncertifiedDialog(context);
//              }
//            }),
//            _buildItem('家政保洁', UIData.iconHousekeepingService, 26, onTap: () {
//              Navigate.checkCustomerCertified(
//                  context,
//                  PayServiceWorkOtherListPage(WorkOtherSubType.CleaningPaid, [
//                    WorkOtherSubType.InstallPaid,
//                    WorkOtherSubType.RepairPaid,
//                    WorkOtherSubType.CleaningPaid,
//                    WorkOtherSubType.HousePaid,
//                    WorkOtherSubType.OtherPaid
//                  ]));
//            }),
//            _buildItem('房屋租售', UIData.iconHouseRentSale, 26,
//                onTap: () =>
////                          CommonDialog.showDevelopmentDialog(context)
//                    Navigate.toNewPage(HtmlPage(HttpOptions.houseShouYeUrl, "房屋租售"))),
////            _buildItem('室内维修', UIData.iconRepairService, 26, onTap: () {
////              Navigate.checkCustomerCertified(
////                  context, ComplaintPage(WorkOtherMainType.Repair, sub: WorkOtherSubType.Repair));
////            }),
////            _buildItem('公区报障', UIData.iconReportObstacle, 26, onTap: () {
////              Navigate.checkCustomerCertified(context, ComplaintPage(WorkOtherMainType.Warning));
////            }),
////            _buildItem('调查问卷', UIData.iconGoodsPassing, 26,
////                onTap: () => Navigate.toNewPage(CommunityActivityPage(activityType: 1))),
////            _buildItem('停车办理', UIData.iconComplaint, 26, onTap: () {
////              Navigate.checkCustomerCertified(context, ParkingCardMinePage());
////            }),
//            _buildItem('预约挂号', UIData.iconHealth160Service, 26, onTap: () {
//              stateModel
//                  .getHealthyToken(stateModel.customerType == 2 ? stateModel.mobile : stateModel.userAccount);
////              if (stateModel.checkModulePermission(context)) stateModel.getHealthyToken(stateModel.mobile);
////              Navigate.toNewPage(HtmlPage("https://www.taobao.com/","预约挂号"));
//            }),
//            ScopedModelDescendant<HomeStateModel>(builder: (context, child, model) {
//              return _buildItem('全部', UIData.iconMore, 26, onTap: () {
////                model.mainCurrentIndex = 1;
//                Navigate.toNewPage(ServicePage(showTop: false));
//              });
////            _buildItem('家电安装', UIData.iconApplianceInstall, 26, onTap: () {
////              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
////                return PayServiceWorkOtherListPage(WorkOtherSubType.InstallPaid, [
////                  WorkOtherSubType.InstallPaid,
////                  WorkOtherSubType.RepairPaid,
////                  WorkOtherSubType.CleaningPaid,
////                  WorkOtherSubType.HousePaid,
////                  WorkOtherSubType.OtherPaid
////                ]);
////              }));
////            }),
////            _buildItem('房屋维修', UIData.iconHouseRepair, 26, onTap: () {
////              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
////                return PayServiceWorkOtherListPage(WorkOtherSubType.HousePaid, [
////                  WorkOtherSubType.InstallPaid,
////                  WorkOtherSubType.RepairPaid,
////                  WorkOtherSubType.CleaningPaid,
////                  WorkOtherSubType.HousePaid,
////                  WorkOtherSubType.OtherPaid
////                ]);
////              }));
////            }),
////            _buildItem('表扬', UIData.iconPraise, 26, onTap: () {
////              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
////                return ComplaintPage(WorkOtherMainType.Praise);
////              }));
////            }),
//            }),
//          ],
            )));
  }

  //Gridview点击跳转处理
//  void _tap2Module(MenuInfo menuInfo) async {
//    switch (menuInfo.linkUrl) {
//      case '室内维修':
//        Navigate.checkCustomerCertified(
//            context,
//            ComplaintPage(
//              WorkOtherMainType.Repair,
//              sub: WorkOtherSubType.Repair,
//            ));
//        break;
//      case '咨询建议':
//        Navigate.checkCustomerCertified(
//            context,
//            ComplaintPage(
//              WorkOtherMainType.Advice,
//              sub: WorkOtherSubType.Advice,
//            ));
//        break;
//      case '表扬':
//        Navigate.checkCustomerCertified(context, ComplaintPage(WorkOtherMainType.Praise));
//        break;
//      case '投诉':
//        Navigate.checkCustomerCertified(context, ComplaintPage(WorkOtherMainType.Complaint));
//        break;
//      case '物品放行':
//        Navigate.checkCustomerCertified(context, ArticlesReleaseApplyPage());
//        break;
//      case '社区通行':
//        if (2 == stateModel?.customerType &&
//            stateModel.customerId != null &&
//            stateModel.defaultProjectId != null &&
//            stateModel.defaultHouseId != null) {
//          CommonToast.show(msg: '加载中');
//          HttpUtil.refreshToken(callBack: ({String errorMsg}) async {
//            CommonToast.dismiss();
//            if (errorMsg == null) {
//              stateModel.getAccessPassInfo();
//            } else {
//              CommonToast.show(type: ToastIconType.FAILED, msg: errorMsg);
//            }
//          });
//        } else {
//          CommonDialog.showUncertifiedDialog(context);
//        }
//        break;
//      case '家政保洁':
//        Navigate.checkCustomerCertified(
//            context,
//            PayServiceWorkOtherListPage(WorkOtherSubType.CleaningPaid, [
//              WorkOtherSubType.InstallPaid,
//              WorkOtherSubType.RepairPaid,
//              WorkOtherSubType.CleaningPaid,
//              WorkOtherSubType.HousePaid,
//              WorkOtherSubType.OtherPaid
//            ]));
//        break;
//      case '房屋租售':
//        Navigate.toNewPage(HtmlPage(HttpOptions.houseShouYeUrl, menuInfo.resourceName));
//        break;
//      case '预约挂号':
//        stateModel.getHealthyToken(stateModel.customerType == 2 ? stateModel.mobile : stateModel.userAccount);
//        break;
//      case '预约挂号':
//        stateModel.getHealthyToken(stateModel.customerType == 2 ? stateModel.mobile : stateModel.userAccount);
//        break;
//    }
//  }

  ///
  /// 招小通客服
  ///
  Widget _buildCustomerService() {
    return GestureDetector(
      child: Container(
        color: UIData.primaryColor,
        padding: EdgeInsets.all(UIData.spaceSize16),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: UIData.dividerColor),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: ScreenUtil.getInstance().setWidth(40),
                child: Image.asset(
                  UIData.imageZhaoxiaotong,
                  fit: BoxFit.fill,
                ),
              ),
              Expanded(
                  child: ListTile(
                dense: true,
//              isThreeLine: true,
                title: CommonText.darkGrey15Text('招小通客户服务热线', fontWeight: FontWeight.bold),
                subtitle: CommonText.grey12Text('您的专属管家，一键便达！'),
              )),
              Container(
                width: ScreenUtil.getInstance().setWidth(42),
                child: UIData.iconTel,
              )
            ],
          ),
        ),
      ),
      onTap: () {
        if (stateModel.checkModulePermission(context)) stateModel.callPhone(stateModel.allDayTel);
      },
    );
  }

  ///
  /// 物业通知栏
  ///
  Widget _buildPropertyNotice() {
//    return GestureDetector(
//      child: Container(
////        margin: EdgeInsets.only(bottom: UIData.spaceSize16),
//        color: UIData.primaryColor,
//        child: Column(
//          children: <Widget>[
//            ListTile(
//                dense: true,
//                title: CommonText.darkGrey16Text('物业通知', fontWeight: FontWeight.bold),
//                trailing: CommonText.grey12Text('更多')),
////          CommonText.darkGrey18Text('稍后开放')
//            ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
//              return (model?.propertyNoticeList != null && model.propertyNoticeList.length > 0)
//                  ? ListView.builder(
//                      padding:
//                          EdgeInsets.fromLTRB(UIData.spaceSize16, 0.0, UIData.spaceSize16, UIData.spaceSize16),
//                      physics: NeverScrollableScrollPhysics(),
//                      shrinkWrap: true,
//                      itemCount: model?.propertyNoticeList?.length ?? 0,
//                      itemBuilder: (context, index) {
//                        PropertyNotice notice = model.propertyNoticeList[index];
//                        return Container(
//                          padding: EdgeInsets.only(bottom: UIData.spaceSize4),
//                          child: Row(
//                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                            children: <Widget>[
//                              CommonText.grey14Text(notice?.title ?? ''),
//                              CommonText.lightGrey14Text(notice?.sendTime ?? ''),
//                            ],
//                          ),
//                        );
////                  ListTile(dense: true,
////                    title: CommonText.grey14Text('关于开展迎新春写春联活动的通知'), trailing: CommonText.grey14Text('01-11'));
//                      })
//                  : Container(
//                      alignment: Alignment.centerLeft,
//                      padding: EdgeInsets.only(bottom: UIData.spaceSize8, left: UIData.spaceSize16),
//                      child: CommonText.lightGrey12Text('暂无信息'));
//            })
//          ],
//        ),
//      ),
//      onTap: () => Navigate.toNewPage(PropertyNoticePage()),
//    );
    return Container(
      padding: EdgeInsets.all(UIData.spaceSize16),
      color: UIData.primaryColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
              child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize6, vertical: UIData.spaceSize2),
                  decoration: BoxDecoration(
                      color: UIData.themeBgColor,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(10.0), bottomRight: Radius.circular(10.0))),
                  child: CommonText.text12('物业通知', color: UIData.primaryColor),
                ),
                SizedBox(width: UIData.spaceSize8),
                Expanded(
                    child: CommonText.darkGrey14Text(
                        (stateModel.propertyNoticeList == null || stateModel.propertyNoticeList.length == 0)
                            ? '暂无'
                            : (stateModel.propertyNoticeList[0]?.title ?? ''))),
                SizedBox(width: UIData.spaceSize8),
                CommonText.lightGrey12Text((stateModel.propertyNoticeList != null &&
                        stateModel.propertyNoticeList.length > 0 &&
                        StringsHelper.isNotEmpty(stateModel?.propertyNoticeList[0]?.sendTime))
                    ? StringsHelper.formatterMD.format(DateTime.parse(stateModel.propertyNoticeList[0]?.sendTime))
                    : '')
              ],
            ),
            onTap: () => Navigate.toNewPage(PropertyNoticeDetailPage(stateModel.propertyNoticeList[0]?.id)),
          )),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: Row(
              children: <Widget>[SizedBox(width: UIData.spaceSize16), CommonText.grey14Text('更多')],
            ),
            onTap: () => Navigate.toNewPage(PropertyNoticePage()),
          ),
        ],
      ),
    );
  }

  //社区活动栏表头
  Widget _buildCommunityActivityTop(String title, List list, {GestureTapCallback onTap}) {
    return Visibility(
        child: GestureDetector(
          child: Container(
            padding:
                EdgeInsets.only(left: UIData.spaceSize16, right: UIData.spaceSize16, bottom: UIData.spaceSize12),
            color: UIData.primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                CommonText.darkGrey16Text(title ?? '', fontWeight: FontWeight.bold),
                CommonText.lightGrey12Text('更多')
              ],
            ),
//          child: ListTile(
//              dense: true,
//              title: CommonText.darkGrey16Text(title ?? '', fontWeight: FontWeight.bold),
//              trailing: CommonText.lightGrey12Text('更多'),
//              onTap: onTap),
          ),
          onTap: onTap,
        ),
        visible: list != null && list.length > 0);
  }

  ///
  /// 社区活动栏
  ///
  Widget _buildCommunityActivity() {
    return ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
      return Visibility(
          visible: model.activityHomePageList != null && model.activityHomePageList.length > 0,
          child: Container(
            color: UIData.primaryColor,
            padding: EdgeInsets.only(bottom: UIData.spaceSize16),
            child: Container(
              height: ScreenUtil.getInstance().setHeight(190),
//            height: _communityActivityHeight,
              color: UIData.primaryColor,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.fromLTRB(0.0, 0.0, UIData.spaceSize16, 0.0),
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: model?.activityHomePageList?.length ?? 0,
                  itemBuilder: (context, index) {
                    ActivityInfo info = model.activityHomePageList[index];
                    return _buildCommunityActivityCard(info);
                  }),
            ),
          )

//                    ;
//                  }))
//                ],
//              ),
//            ),
//            onTap: () => Navigate.toNewPage(CommunityActivityPage()),
//          )
          );
    });
  }

  //社区活动卡片
  Widget _buildCommunityActivityCard(ActivityInfo info) {
//    LogUtils.printLog('社区活动图片：'+'${HttpOptions.urlAppDownload}${UIData.imageCommunityDefaultHomePage}');
//    info?.logo = null;
    return CommonShadowContainer(
//        padding: EdgeInsets.only(bottom: UIData.spaceSize8),
        margin: EdgeInsets.only(left: UIData.spaceSize16, bottom: ScreenUtil.getInstance().setHeight(12)),
        child: Container(
//          width: UIData.spaceSize200,
          //只有一条的时候撑开
          width: stateModel?.activityHomePageList?.length == 1
              ? ScreenUtil.screenWidthDp - (2 * UIData.spaceSize16)
              : UIData.spaceSize200,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(6.0), topRight: Radius.circular(6.0)),
                  child:
//                  info?.logo != null
//                      ?
//                  FadeInImage.assetNetwork(
//                    height: ScreenUtil.getInstance().setHeight(95),
//                    placeholder: UIData.imageBannerDefaultLoading,
//                    image: HttpOptions.showPhotoUrl(info?.logo),
//                    fit: BoxFit.cover,
//                  )
                      Container(
                    height: ScreenUtil.getInstance().setHeight(95),
                    child: CommonImageWidget(info?.logo,
                        loadedNoDataImage:
                            '${HttpOptions.urlAppDownloadImage}${UIData.imageCommunityDefaultHomePage}'),
                  )
//                      CachedNetworkImage(
//                    height: ScreenUtil.getInstance().setHeight(95),
//                    placeholder: (context, url) => Image.asset(UIData.imageBannerDefaultLoading),
//                    errorWidget: (context, url, error) => Image.asset(UIData.imageBannerDefaultFailed),
//                    imageUrl: (StringsHelper.isNotEmpty(info?.logo))
//                        ? HttpOptions.showPhotoUrl(info?.logo)
//                        : '${HttpOptions.urlAppDownloadImage}${UIData.imageCommunityDefaultHomePage}',
//                    fit: BoxFit.cover,
////                    alignment: Alignment.topCenter,
//                  )
//                      : Image.asset(UIData.imageBannerDefaultNoData,
//                          height: ScreenUtil.getInstance().setHeight(95), fit: BoxFit.cover)
                  ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
//                    SizedBox(height: UIData.spaceSize4),
                    Container(
                        height: ScreenUtil.getInstance().setHeight(20),
                        alignment: Alignment.bottomLeft,
                        child: CommonText.darkGrey14Text(info?.name ?? '')),
//                    SizedBox(height: UIData.spaceSize2),
                    Container(
                        height: ScreenUtil.getInstance().setHeight(16),
                        alignment: Alignment.bottomLeft,
                        child: CommonText.text12(
                            '活动开始时间：${StringsHelper.isNotEmpty(info?.beginTime) ? info?.beginTime?.substring(0, 16) : ''}',
                            color: UIData.lightGreyColor)),
//                    SizedBox(height: UIData.spaceSize2),
                    Container(
                        height: ScreenUtil.getInstance().setHeight(16),
                        alignment: Alignment.bottomLeft,
                        child: CommonText.text12(
                            '活动结束时间：${StringsHelper.isNotEmpty(info?.endTime) ? info?.endTime?.substring(0, 16) : ''}',
                            color: UIData.lightGreyColor)),
//                    SizedBox(height: UIData.spaceSize2),
                    Container(
                      height: ScreenUtil.getInstance().setHeight(25),
                      alignment: Alignment.bottomLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              CommonText.text12('参与人数：', color: UIData.lightGreyColor),
                              CommonText.text12((info?.commitCount ?? 0).toString(), color: UIData.lightGreyColor),
                              CommonText.text12('人', color: UIData.lightGreyColor),
                            ],
                          ),
                          StadiumOutlineButton('去参加')
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        onTap: () {
          stateModel.communityActivityGetH5(info?.id, callBack: (String url) {
            Navigate.toNewPage(HtmlPage(url, info?.name,
                toShare: true,
                thumbImageUrl: StringsHelper.isNotEmpty(info?.logo)
                    ? HttpOptions.showPhotoUrl(info?.logo)
                    : '${HttpOptions.urlAppDownloadImage}${UIData.imageCommunityDefaultHomePage}'));
          });
        });
  }

  //投票模块
  Widget _buildVote() {
    return ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
      return (model.voteHomePageList != null && model.voteHomePageList.length > 0)
          ? Container(
              color: UIData.primaryColor,
              padding: EdgeInsets.only(bottom: UIData.spaceSize16),
              child: Container(
                height: ScreenUtil.getInstance().setHeight(190),
                margin: EdgeInsets.only(left: UIData.spaceSize16, right: UIData.spaceSize16),
                child: CommonShadowContainer(
                  padding: EdgeInsets.only(left: UIData.spaceSize8, right: UIData.spaceSize8),
                  offsetY: 1.0,
                  blurRadius: 10.0,
                  child: (stateModel.voteHomePageList == null || stateModel.voteHomePageList.length == 0)
                      ? Container()
                      : Swiper(
                          autoplay: stateModel.voteAutoPlay,
                          loop: (model?.voteHomePageList?.length ?? 0) > 1,
                          itemBuilder: (BuildContext context, int index) {
                            return _buildVoteCard(model.voteHomePageList[index]);
                          },
                          itemCount: model.voteHomePageList?.length ?? 0),
                ),
              ),
            )
          : Container();
    });
  }

  //投票item
  Widget _buildVoteCard(ActivityInfo info) {
//    LogUtils.printLog('投票图片：'+'${HttpOptions.urlAppDownload}${UIData.imageVoteDefaultHomePage}');
    return GestureDetector(
      child: Container(
        height: ScreenUtil.getInstance().setHeight(190),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
            Container(
              height: ScreenUtil.getInstance().setHeight(125),
//              width: ScreenUtil.getInstance().setWidth(300),
              child: FittedBox(
                fit: BoxFit.cover,
                alignment: Alignment.center,
                child: CommonImageWidget(info?.logo,
//                child: CommonImageWidget('http://218.17.81.123:9001/ubms-customer/base/mongo/show/5ec5f75355ae0c33d3da1400',
                    loadedNoDataImage: '${HttpOptions.urlAppDownloadImage}${UIData.imageVoteDefaultHomePage}'),
//                child: CachedNetworkImage(
////                color: UIData.redColor,
////                height: ScreenUtil.getInstance().setHeight(30),
//                  placeholder: (context, url) => Image.asset(UIData.imageBannerDefaultLoading),
//                  errorWidget: (context, url, error) => Image.asset(UIData.imageBannerDefaultFailed),
//                  imageUrl: (StringsHelper.isNotEmpty(info?.logo))
//                      ? HttpOptions.showPhotoUrl(info?.logo)
//                      : '${HttpOptions.urlAppDownloadImage}${UIData.imageVoteDefaultHomePage}',
//                  fit: BoxFit.cover,
//                  alignment: Alignment.center,
//                ),
              ),
            ),
            Container(
                height: ScreenUtil.getInstance().setHeight(20),
                alignment: Alignment.bottomLeft,
                child: CommonText.darkGrey14Text(info?.name ?? '')),
//                    SizedBox(height: UIData.spaceSize2),
            Container(
              height: ScreenUtil.getInstance().setHeight(25),
              alignment: Alignment.bottomLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CommonText.text12('参与人数：', color: UIData.lightGreyColor),
                      CommonText.text12((info?.commitCount ?? 0).toString(), color: UIData.lightGreyColor),
                      CommonText.text12('人', color: UIData.lightGreyColor),
                    ],
                  ),
                  StadiumOutlineButton('去投票')
                ],
              ),
            )
          ],
        ),
      ),
      onTap: () {
//        info?.logo = null; //测试数据
        stateModel.communityActivityGetH5(info?.id, callBack: (String url) {
          Navigate.toNewPage(HtmlPage(url, info?.name,
              toShare: true,
              thumbImageUrl: StringsHelper.isNotEmpty(info?.logo)
                  ? HttpOptions.showPhotoUrl(info?.logo)
                  : '${HttpOptions.urlAppDownloadImage}${UIData.imageVoteDefaultHomePage}'));
        });
      },
    );
  }

  //问卷调查模块
  Widget _buildQuestionnaire() {
    return ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
      return (model.questionnaireHomePageList != null && model.questionnaireHomePageList.length > 0)
          ? Container(
              color: UIData.primaryColor,
              padding: EdgeInsets.only(bottom: UIData.spaceSize16),
              child: Container(
                height: ScreenUtil.getInstance().setHeight(190),
                margin: EdgeInsets.only(left: UIData.spaceSize16, right: UIData.spaceSize16),
                child: CommonShadowContainer(
                  padding: EdgeInsets.only(left: UIData.spaceSize8, right: UIData.spaceSize8),
                  offsetY: 1.0,
                  blurRadius: 10.0,
                  child: (stateModel.questionnaireHomePageList == null ||
                          stateModel.questionnaireHomePageList.length == 0)
                      ? Container()
                      : Swiper(
                          autoplay: stateModel.questionnaireAutoPlay,
                          loop: (model?.questionnaireHomePageList?.length ?? 0) > 1,
                          itemBuilder: (BuildContext context, int index) {
                            return _buildQuestionnaireCard(model.questionnaireHomePageList[index]);
                          },
                          itemCount: model.questionnaireHomePageList?.length ?? 0),
                ),
              ),
            )
          : Container();
    });
  }

  //问卷调查item
  Widget _buildQuestionnaireCard(ActivityInfo info) {
//    LogUtils.printLog('投票图片：'+'${HttpOptions.urlAppDownload}${UIData.imageVoteDefaultHomePage}');
    return GestureDetector(
      child: Container(
        height: ScreenUtil.getInstance().setHeight(190),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
            Container(
              height: ScreenUtil.getInstance().setHeight(125),
//              width: ScreenUtil.getInstance().setWidth(300),
              child: FittedBox(
                fit: BoxFit.cover,
                alignment: Alignment.center,
                child: CommonImageWidget(info?.logo,
                    loadedNoDataImage:
                        '${HttpOptions.urlAppDownloadImage}${UIData.imageQuestionnaireDefaultHomePage}'),
//                child: CachedNetworkImage(
////                color: UIData.redColor,
////                height: ScreenUtil.getInstance().setHeight(30),
//                  placeholder: (context, url) => Image.asset(UIData.imageBannerDefaultLoading),
//                  errorWidget: (context, url, error) => Image.asset(UIData.imageBannerDefaultFailed),
//                  imageUrl: (StringsHelper.isNotEmpty(info?.logo))
//                      ? HttpOptions.showPhotoUrl(info?.logo)
//                      : '${HttpOptions.urlAppDownloadImage}${UIData.imageQuestionnaireDefaultHomePage}',
//                  fit: BoxFit.cover,
//                  alignment: Alignment.center,
//                ),
              ),
            ),
            Container(
                height: ScreenUtil.getInstance().setHeight(20),
                alignment: Alignment.bottomLeft,
                child: CommonText.darkGrey14Text(info?.name ?? '')),
//                    SizedBox(height: UIData.spaceSize2),
            Container(
              height: ScreenUtil.getInstance().setHeight(25),
              alignment: Alignment.bottomLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CommonText.text12('参与人数：', color: UIData.lightGreyColor),
                      CommonText.text12((info?.commitCount ?? 0).toString(), color: UIData.lightGreyColor),
                      CommonText.text12('人', color: UIData.lightGreyColor),
                    ],
                  ),
                  StadiumOutlineButton('去参与')
                ],
              ),
            )
          ],
        ),
      ),
      onTap: () {
        stateModel.communityActivityGetH5(info?.id, callBack: (String url) {
          Navigate.toNewPage(HtmlPage(url, info?.name,
              toShare: true,
              thumbImageUrl: StringsHelper.isNotEmpty(info?.logo)
                  ? HttpOptions.showPhotoUrl(info?.logo)
                  : '${HttpOptions.urlAppDownloadImage}${UIData.imageQuestionnaireDefaultHomePage}'));
        });
      },
    );
  }

  //社区资讯pgc模块
  Widget _buildPgc() {
    return ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
      return (model.pgcHomePageList != null && model.pgcHomePageList.length > 0)
          ? Container(
              color: UIData.primaryColor,
              padding: EdgeInsets.only(bottom: UIData.spaceSize16),
              child: Container(
                height: ScreenUtil.getInstance().setHeight(140),
                margin: EdgeInsets.only(left: UIData.spaceSize16, right: UIData.spaceSize16),
                child: CommonShadowContainer(
//                  padding: EdgeInsets.only(left: UIData.spaceSize8, right: UIData.spaceSize8),
                  offsetY: 1.0,
                  blurRadius: 10.0,
                  child: (stateModel.pgcHomePageList == null || stateModel.pgcHomePageList.length == 0)
                      ? Container()
                      : Swiper(
                          autoplay: stateModel.pgcAutoPlay,
                          loop: (model?.pgcHomePageList?.length ?? 0) > 1,
                          itemBuilder: (BuildContext context, int index) {
                            PgcInfomationInfo info = model?.pgcHomePageList[index];
//                      return _buildQuestionnaireCard(model.questionnaireHomePageList[index]);
//                      PgcInfomationListModel model = PgcInfomationListModel();
//                      model.isBulkCollectOperation = false;
                            return PgcInfomationItem(info, PgcInfomationListModel());
                          },
                          itemCount: model.pgcHomePageList?.length ?? 0),
                ),
              ),
            )
          : Container();
    });
  }

  //集市模块
  Widget _buildMarket() {
    return ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
      return (model.marketHomePageList != null && model.marketHomePageList.length > 0)
          ? Container(
              color: UIData.primaryColor,
              padding: EdgeInsets.only(bottom: UIData.spaceSize16),
              child: Container(
                height: ScreenUtil.getInstance().setHeight(210),
                margin: EdgeInsets.only(left: UIData.spaceSize16, right: UIData.spaceSize16),
                child: CommonShadowContainer(
//                padding: EdgeInsets.only(left: UIData.spaceSize8, right: UIData.spaceSize8),
                  offsetY: 1.0,
                  blurRadius: 10.0,
                  child: (stateModel.marketHomePageList == null || stateModel.marketHomePageList.length == 0)
                      ? Container()
                      : Swiper(
                          autoplay: stateModel.marketAutoPlay,
                          loop: (model?.marketHomePageList?.length ?? 0) > 1,
                          itemBuilder: (BuildContext context, int index) {
                            WareDetailModel info = model?.marketHomePageList[index];
//                      return _buildQuestionnaireCard(model.questionnaireHomePageList[index]);
//                      PgcInfomationListModel model = PgcInfomationListModel();
//                      model.isBulkCollectOperation = false;
                            return MarketItem(info, MarketListModel(), fromHome: true);
                          },
                          itemCount: model.marketHomePageList?.length ?? 0),
                ),
              ),
            )
          : Container();
    });
  }

  ///
  /// 底线
  ///
  Widget _buildBottomLine() {
    return Container(
      margin: EdgeInsets.only(bottom: UIData.spaceSize40, top: UIData.spaceSize16),
      alignment: Alignment.center,
      child: CommonText.lighterGrey12Text('——  我是有底线的  ——'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
      return CommonScaffold(
        showLeftButton: false,
        appTitle: HomeLocationButton(),
        appBarActions: [
//        HomeScanButton(),
          HomeMessageButton()
        ],
        bodyData: RefreshIndicator(
            child: ListView(
              children: <Widget>[
                _buildSwiper(),
                _buildPropertyNotice(),
                _buildFirstLine(),
                _buildSecondLine(),
                _buildCustomerService(),
//            Visibility(
//                visible: stateModel.customerType == 2 && !stateModel.uncertifiedDefault,
//                child:
                Column(
                  children: <Widget>[
//                  _buildPropertyNotice(),
//                  CommonFullScaleDivider(),
                    Visibility(
                        child: _buildCommunityActivityTop('社区活动', model.activityHomePageList,
                            onTap: () => Navigate.toNewPage(CommunityActivityPage())),
                        visible: stateModel.customerType == 2 && stateModel.hasHouse),
                    Visibility(
                        child: _buildCommunityActivity(),
                        visible: stateModel.customerType == 2 && stateModel.hasHouse),

                    Visibility(
                        child: _buildCommunityActivityTop('社区资讯', model.pgcHomePageList, onTap: () {
                          if (stateModel.defaultProjectId == null) {
                            CommonToast.show(type: ToastIconType.INFO, msg: '请先选择社区');
                          } else {
                            Navigate.toNewPage(PgcInfomationListPage());
                          }
                        }),
                        visible: stateModel.defaultProjectId != null),
                    Visibility(child: _buildPgc(), visible: stateModel.defaultProjectId != null),
                    Visibility(
                        child: _buildCommunityActivityTop('邻里集市', model.marketHomePageList, onTap: () async {
                          SharedPreferences prefs = await SharedPreferencesKey.globalPrefs;
//                      prefs.setBool(SharedPreferencesKey.KEY_SHOW_MARKET_STATEMENT, true); //测试数据
                          bool showMarketStatement =
                              prefs.getBool(SharedPreferencesKey.KEY_SHOW_MARKET_STATEMENT) ?? true;
                          if (showMarketStatement) {
                            CommonDialog.showAlertDialog(context,
                                title: '邻里集市免责申明',
                                content: StatefulBuilder(
                                    key: _marketStatementDialogKey,
                                    builder: (context, state) {
                                      return ListView(
                                        shrinkWrap: true,
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize16),
                                            child: CommonText.darkGrey14Text(stateModel.marketStatement ?? '',
                                                height: 1.2, overflow: TextOverflow.fade),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize8),
                                            child: CommonCheckBox(
                                                text: '我已充分了解以上申明，下次不再提示',
                                                fontSize: UIData.fontSize12,
                                                value: _marketStatementCheck,
                                                onChanged: (value) {
                                                  _marketStatementDialogKey.currentState.setState(() {
                                                    _marketStatementCheck = value;
//                                          prefs.setBool(SharedPreferencesKey.KEY_MARKET_STATEMENT, !value);
                                                  });
                                                }),
                                          )
                                        ],
                                      );
                                    }),
                                showNegativeBtn: false,
                                positiveBtnText: '我知道了', onConfirm: () {
                              if (_marketStatementCheck) {
                                prefs.setBool(SharedPreferencesKey.KEY_SHOW_MARKET_STATEMENT, false);
                                _marketStatementCheck = false;
                              }
                              Navigate.toNewPage(MarketListPage());
                            });
                          } else {
                            Navigate.toNewPage(MarketListPage());
                          }
                        }),
                        visible: stateModel.defaultProjectId != null),
                    Visibility(child: _buildMarket(), visible: stateModel.defaultProjectId != null),

                    Visibility(
                        child: _buildCommunityActivityTop('投票', model.voteHomePageList,
                            onTap: () =>
                                Navigate.checkCustomerCertified(context, CommunityActivityPage(activityType: 2))),
                        visible: stateModel.customerType == 2 && stateModel.hasHouse),
                    Visibility(child: _buildVote(), visible: stateModel.customerType == 2 && stateModel.hasHouse),

                    Visibility(
                        child: _buildCommunityActivityTop('问卷调查', model.questionnaireHomePageList,
                            onTap: () =>
                                Navigate.checkCustomerCertified(context, CommunityActivityPage(activityType: 1))),
                        visible: stateModel.customerType == 2 && stateModel.hasHouse),
                    Visibility(
                        child: _buildQuestionnaire(),
                        visible: stateModel.customerType == 2 && stateModel.hasHouse),
                  ],
                ),
//            ),
//            Container(height: UIData.spaceSize16, color: UIData.primaryColor),
                _buildBottomLine(),
              ],
            ),
            onRefresh: _getUserData),
      );
    });
  }

  //跳转到话题详情页面
  _toTopicDetailPage(String topicId) async {
    if(StringsHelper.isNotEmpty(topicId)){
      SharedPreferences prefs = await SharedPreferencesKey.globalPrefs;
      String token = prefs.getString(SharedPreferencesKey.KEY_ACCESS_TOEKN);
      if(stateModel.flutterWebViewPlugin!=null){
        stateModel.flutterWebViewPlugin.reloadUrl("${HttpOptions.baseUrl.replaceAll(
            "ubms-customer/",
            "")}template/appShare/topicDetails.html?projectId=${stateModel
            ?.defaultProjectId}&token=$token&topicId=$topicId");
      }else{
        Navigate.toNewPage(HtmlPage("${HttpOptions.baseUrl.replaceAll(
            "ubms-customer/",
            "")}template/appShare/topicDetails.html?projectId=${stateModel
            ?.defaultProjectId}&token=$token&topicId=$topicId&closePage=1",
          "", showTitle: false,));
      }
    }
  }

  //跳转到说说详情页面
  _toTalkAboutDetailPage(String talkId) async{
    if(StringsHelper.isNotEmpty(talkId)) {
      SharedPreferences prefs = await SharedPreferencesKey.globalPrefs;
      String token = prefs.getString(SharedPreferencesKey.KEY_ACCESS_TOEKN);
      if(stateModel.flutterWebViewPlugin!=null){
        stateModel.flutterWebViewPlugin.reloadUrl("${HttpOptions.baseUrl.replaceAll(
            "ubms-customer/",
            "")}template/appShare/talkAboutDetail.html?projectId=${stateModel
            ?.defaultProjectId}&token=$token&talkId=$talkId");
      }else {
        Navigate.toNewPage(HtmlPage("${HttpOptions.baseUrl.replaceAll(
            "ubms-customer/",
            "")}template/appShare/talkAboutDetail.html?projectId=${stateModel
            ?.defaultProjectId}&token=$token&talkId=$talkId&closePage=1", "",
          showTitle: false,));
      }
    }
  }
}
