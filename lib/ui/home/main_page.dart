import 'dart:convert';
import 'dart:io';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/ad_info_model.dart';
import 'package:cmp_customer/models/decoration_obj.dart';
import 'package:cmp_customer/models/dictionary_list.dart';
import 'package:cmp_customer/models/pgc/pgc_comment_obj.dart';
import 'package:cmp_customer/scoped_models/decoration_model.dart';
import 'package:cmp_customer/scoped_models/home_state_model.dart';
import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/scoped_models/new_house_state_model.dart';
import 'package:cmp_customer/scoped_models/reservation_state_model.dart';
import 'package:cmp_customer/strings/strings_common.dart';
import 'package:cmp_customer/strings/strings_notice.dart';
import 'package:cmp_customer/ui/articles_release/articles_release_detail_page.dart';
import 'package:cmp_customer/ui/change_of_title/change_of_title_detail.dart';
import 'package:cmp_customer/ui/check_in/check_in_details.dart';
import 'package:cmp_customer/ui/common/common_dialog.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/conference_room_reservation/reservation_detail.dart';
import 'package:cmp_customer/ui/decorate_manager/decoration_permit/decoration_apply_detail_page.dart';
import 'package:cmp_customer/ui/decorate_manager/decoration_permit/decoration_apply_detail_tab.dart';
import 'package:cmp_customer/ui/decoration/decoration_pass_card_details.dart';
import 'package:cmp_customer/ui/door/open_door_list.dart';
import 'package:cmp_customer/ui/door/open_door_used.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_apply_audit.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_details.dart';
import 'package:cmp_customer/ui/home/mall_page.dart';
import 'package:cmp_customer/ui/home/service_page.dart';
import 'package:cmp_customer/ui/hot_work/hot_work_detail_page.dart';
import 'package:cmp_customer/ui/house_authentication/house_detail_page.dart';
import 'package:cmp_customer/ui/html/html_page.dart';
import 'package:cmp_customer/ui/market/chat_list.dart';
import 'package:cmp_customer/ui/market/market_detail.dart';
import 'package:cmp_customer/ui/me/me_page.dart';
import 'package:cmp_customer/ui/new_house/new_house_detail_page.dart';
import 'package:cmp_customer/ui/notice/message_page.dart';
import 'package:cmp_customer/ui/notice/property_notice_detail_page.dart';
import 'package:cmp_customer/ui/office_cancel_lease/office_cancel_lease_detail_page.dart';
import 'package:cmp_customer/ui/parking/parking_card_details.dart';
import 'package:cmp_customer/ui/pgc/pgc_comment_page.dart';
import 'package:cmp_customer/ui/pgc/pgc_ui.dart';
import 'package:cmp_customer/ui/work_other/complaint_detail_page.dart';
import 'package:cmp_customer/ui/work_other/work_other_ui.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/permission_util.dart';
import 'package:cmp_customer/utils/shared_preferences_key.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:install_plugin/install_plugin.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scoped_model/scoped_model.dart';

import 'home_cache_page.dart';
import 'home_page.dart';
import 'mall_msg_detail_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static List _bottomBarTitles;
  List _bottomBarIcons;
  HomeStateModel _homeStateModel = HomeStateModel();

//  StateSetter _dialogState; //进度条弹框的state
//  double _installProgress = 0; //安装包下载进度
//  GlobalKey<ComplaintDetailPageState> detailKey = new GlobalKey<ComplaintDetailPageState>();

//  GlobalKey _dialogKey = GlobalKey(); //进度条弹框的key
//  bool _downBack = false; //是否后台下载更新应用
//  int _countJPush = 0; //调用极光推送设置别名的次数

  @override
  void initState() {
    super.initState();
    _initData();
    stateModel.reloadUsedDoor();
//    _checkRefreshToken();
    stateModel.getUserData(loginTag: true, callBack: ({String errorMsg}) {});
  }

  @override
  void dispose() {
    super.dispose();
  }

//  void _checkRefreshToken(){
//    if(stateModel.showRefreshTokenFailed){
//      stateModel.showRefreshTokenFailed = false;
//
//    }
//  }

//  @override
//  void didChangeAppLifecycleState(AppLifecycleState state) {
//    LogUtils.printLog("didChangeAppLifecycleState: $state");
//    if (state == AppLifecycleState.resumed) {
//      //ios需要更新角标
//      if(Platform.isIOS){
//        JPush jPush = new JPush();
//        jPush.setBadge(stateModel.unReadMessageTotalCount).then((map) {});
//      }
//    }
//    super.didChangeAppLifecycleState(state);
//  }

//  //跳转到选择默认社区
//  void _go2DefaultCommunity() {
//    Future.delayed(Duration(milliseconds: 100)).whenComplete(() {
//      //没有默认社区跳转到选择社区界面
//      if (stateModel.defaultProjectId == null) {
//        Navigate.toNewPage(
//            CommunitySearchPage(callback: (int projectId, String projectName) {
//          stateModel.setUncertifiedCommunity(projectId, projectName);
//        }));
//      }
//    });
//  }
//
//  Future<void> _initJPush() async {
////    jPush.getRegistrationID().then((rid) {
////      setState(() {
////        debugLable = "flutter getRegistrationID: $rid";
////      });
////    });
//
//    try {
//      //注意：addEventHandler 方法建议放到 setup 之前，其他方法需要在 setup 方法之后调用
//      stateModel.jPush.addEventHandler(
//        // 接收通知回调方法。
//        onReceiveNotification: (Map<String, dynamic> message) async {
//          stateModel.getUnReadMessageTotalCount();
//          LogUtils.printLog("flutter onReceiveNotification: $message");
//          var extras;
//          if (Platform.isAndroid)
//            extras = json.decode(message['extras']['cn.jpush.android.EXTRA']);
//          else
//            extras = message['extras'];
//          LogUtils.printLog("flutter onReceiveNotification extras: $extras");
//          if (extras != null) {
//            if (extras.containsKey('messageType')) {
//              String messageType = extras['messageType'];
//              LogUtils.printLog("messageType: $messageType");
//              //banner更新后消息推送（静默推送，用户收不到，只做后台处理）
//              if (messageType == 'banner') {
//                stateModel.getBanner();
////                stateModel.reLogin(callBack: ({String errorMsg}){
////                  if(errorMsg == null){
////                    stateModel.getBanner();
////                  }
////                });
//              } else {
//                if (extras.containsKey('subMessageType')) {
//                  switch (extras['subMessageType']) {
//                    //房屋认证通知认证通过
//                    case 'FWRZTG':
//                      LogUtils.printLog("flutter onReceiveNotification FWRZTG");
//                      stateModel.reLogin();
////                stateModel.clearAccessToken();
////                stateModel.getUserData();
//                      break;
//                    case 'XFRH':
//                      LogUtils.printLog("flutter onReceiveNotification XFRH");
////                if (stateModel.customerType == 1) {
//                      stateModel.reLogin();
////                }
//                      break;
//                  }
//                }
//              }
//            }
//          }
//        },
//        // 点击通知回调方法。
//        onOpenNotification: (Map<String, dynamic> message) async {
//          jPushListener(message);
//        },
//        // 接收自定义消息回调方法。
//        onReceiveMessage: (Map<String, dynamic> message) async {
//          LogUtils.printLog("flutter onReceiveMessage: $message");
//        },
//      );
//    } on PlatformException {
//      LogUtils.printLog("Failed to get platform version.");
//    }
//
//    ///
//    /// 添加初始化方法，调用 setup 方法会执行两个操作：
//    ///  1、初始化 JPush SDK
//    ///  2、将缓存的事件下发到 dart 环境中。
//    ///
//    ///注意： 插件版本 >= 0.0.8 android 端支持在 setup 方法中动态设置 channel，
//    ///动态设置的 channel 优先级比 manifestPlaceholders 中的 JPUSH_CHANNEL 优先级要高。
//    ///39175294bec711cb54367435 招商账号IOS体验版
//    ///741ddd31e7d7e099295391c0 招商账号
//    ///836845276e457c36d8ef0799 自己账号
//    String appKey = '741ddd31e7d7e099295391c0';
//    if (HttpOptions.isTrialVersion && Platform.isIOS) appKey = '39175294bec711cb54367435';
//    stateModel.jPush.setup(
//      appKey: appKey,
//      channel: "developer-default",
//      production: !HttpOptions.isInDebugMode,
//      debug: HttpOptions.isInDebugMode,
////      production: HttpOptions.isInDebugMode, //测试数据
////      debug: !HttpOptions.isInDebugMode, //测试数据
//    );
//
//    _jPushSetAlias();
//
//    //申请推送权限，注意这个方法只会向用户弹出一次推送权限请求（如果用户不同意，之后只能用户到设置页面里面勾选相应权限），需要开发者选择合适的时机调用。
//    //注意： iOS10+ 可以通过该方法来设置推送是否前台展示，是否触发声音，是否设置应用角标 badge
//    stateModel?.jPush?.applyPushAuthority(new NotificationSettingsIOS(sound: true, alert: true, badge: true));
//    stateModel?.jPush?.getLaunchAppNotification()?.then((Map<dynamic, dynamic> message) {
//      jPushListener(message);
//    });
////
////    // If the widget was removed from the tree while the asynchronous platform
////    // message was in flight, we want to discard the reply rather than calling
////    // setState to update our non-existent appearance.
////    if (!mounted) return;
////
////    setState(() {
////      debugLable = platformVersion;
////    });
//  }
//
//  //极光推送监听
//  void jPushListener(Map<dynamic, dynamic> message) {
//    LogUtils.printLog("flutter onOpenNotification: $message");
//    var extras;
//    if (Platform.isAndroid)
//      extras = json.decode(message['extras']['cn.jpush.android.EXTRA']);
//    else {
//      extras = message['extras'];
//    }
////          LogUtils.printLog("flutter onReceiveNotification extras: $extras");
////          LogUtils.printLog("flutter onOpenNotification extras subMessageType: ${extras['subMessageType']}");
////          LogUtils.printLog("flutter onOpenNotification extras map: ${json.decode(extras)}");
//
//    try {
//      stateModel.setMessageRead(int.parse(extras['messageId']), stateModel.customerId, stateModel.accountId,
//          callBack: () {
//        setState(() {
//          stateModel.getUnReadMessageTotalCount();
//        });
//      });
//    } catch (e) {
//      LogUtils.printLog('极光推送监听，设置条数');
//    }
//    if (extras != null && StringsHelper.isNotEmpty(extras['messageType']) && extras['messageType'] == 'GDXX') {
//      //工单
//
//      if (ComplaintDetailPageState.isOpen != null && ComplaintDetailPageState.isOpen) {
//        detailKey.currentState.reflashDetailPage(int.parse(extras['relatedId']));
////        MainStateModel.of(context).getWorkOthersDetail(
////            int.parse(extras['relatedId']));
//      } else {
//        Navigate.toNewPage(ComplaintDetailPage(
//          extras['subMessageType'],
//          int.parse(extras['relatedId']),
//          key: detailKey,
//        ));
//      }
//    } else if (extras != null &&
//        StringsHelper.isNotEmpty(extras['messageType']) &&
//        extras['messageType'] == 'TZZX') {
//      //物业通知
//      Navigate.toNewPage(PropertyNoticeDetailPage(
//        int.parse(extras['relatedId']),
//      ));
//    } else if (extras != null && StringsHelper.isNotEmpty(extras['subMessageType']))
//      switch (extras['subMessageType']) {
//        //房屋认证通知认证通过
//        case 'FWRZTG':
//          Navigate.toNewPage(HouseDetailPage(custHouseRelationId: int.parse(extras['relatedId'])));
//          break;
//        //房屋认证通知认证不通过
//        case 'FWRZBTG':
//          Navigate.toNewPage(HouseDetailPage(houseCustAuditId: int.parse(extras['relatedId'])));
//          break;
//        case 'MJK': //门禁卡
//          if ("1" == extras['ToOwnerAgree']) {
//            Navigate.toNewPage(EntranceCardApplyAuditPage(null, int.parse(extras['relatedId'])));
//          } else {
//            Navigate.toNewPage(EntranceCardDetailsPage(int.parse(
//              extras['relatedId'],
//            )));
//          }
//          break;
//        //停车办理
//        case 'XK':
//        case 'XF':
//        case 'TZ':
//        case 'TCBL':
//          Navigate.toNewPage(ParkingCardDetailsPage(int.parse(extras['relatedId'])));
//          break;
//        case 'ZHRZ': //租户入驻
//          Navigate.toNewPage(CheckInDetailsPage(int.parse(extras['relatedId'])));
//          break;
//        case 'ACTIVITY_VIEW': //活动详情（1问卷/2投票/3报名）
//          stateModel.communityActivityGetH5(int.parse(extras['relatedId']), callBack: (String url) {
//            Navigate.toNewPage(HtmlPage(url, extras['title']));
//          });
//          break;
//        case 'WPFX': //物品放行
//          Navigate.toNewPage(
//              ArticlesReleaseDetailPage(int.parse(extras['relatedId']), toOwnerAgree: extras['ToOwnerAgree']));
//          break;
//        case 'XZLTZ': //写字楼退租
//          Navigate.toNewPage(OfficeCancelLeaseDetailPage(int.parse(extras['relatedId'])));
//          break;
//        case 'DHSQ': //动火申请
//          Navigate.toNewPage(
//              HotWorkDetailPage(int.parse(extras['relatedId']), toOwnerAgree: extras['ToOwnerAgree']));
//          break;
//        case messageSubTypeWAREREPLY: //集市的评论和回复
//        case messageSubTypeWARELIKE: //集市的点赞
//          Navigate.toNewPage(MarketDetail(
//            int.parse(extras['relatedId']),
//          ));
//          break;
//        case 'JSLT': //集市聊天页面
//          Navigate.toNewPage(ChatListPage());
//          break;
//        case 'REPLY': //评论/回复
//        case 'LIKE': //点赞
//          Navigate.toNewPage(PgcCommentPage(
//              PgcCommentInfo(pgcId: int.parse(extras['mainId']), pgcCommentId: int.parse(extras['relatedId'])),
//              PgcInfoType.infomation));
//          break;
//        case 'ZXCRZ': //装修出入证
//          if ("1" == extras['ToOwnerAgree']) {
//            Navigate.toNewPage(DecorationPassCardDetailsPage(int.parse(extras['relatedId']), 0)); //业主审核
//          } else {
//            Navigate.toNewPage(DecorationPassCardDetailsPage(int.parse(extras['relatedId']), 1)); //业主审核
//          }
//          break;
//        case 'CQBG': //产权变更
//          Navigate.toNewPage(ChangeOfTitleDetail(
//              null,
////                                    widget.type,
//              int.parse(extras['relatedId'])));
//          break;
//        case 'ZXYS':
//        case 'ZXXKZ': //装修许可证
//          DecorationModel _model = new DecorationModel();
//          _model.getDecorationInfo(int.parse(extras['relatedId']), callback: (DecorationInfo info) {
//            //ACCEPTANCE_CHECK-验收待处理，ACCEPTANCE_CHECK_FAIL-验收不通过，ACCEPTANCE_CHECK_SUCCESS-验收通过
//            if ((info?.state ?? '') == 'ACCEPTANCE_CHECK' ||
//                (info?.state ?? '') == 'ACCEPTANCE_CHECK_FAIL' ||
//                (info?.state ?? '') == 'ACCEPTANCE_CHECK_SUCCESS')
//              Navigate.toNewPage(
//                DecorationDetailTabPage(_model, info.id),
//              );
//            else
//              Navigate.toNewPage(
//                DecorationApplyDetailPage(_model, info.id),
//              );
//          });
//          break;
//        case 'HYSYD': //会议室预定
//          Navigate.toNewPage(ReservationDetailPage(ReservationModel(), int.parse(extras['relatedId'])));
//          break;
//        case 'XFRH': //新房入伙
//          Navigate.toNewPage(NewHouseDetailPage(NewHouseStateModel(), int.parse(extras['relatedId'])));
//          break;
//        case 'RENT': //其他消息-房屋出租档案通知
//        case 'HOUSEMAINTAINITEM': //其他消息-房屋维保项消息
//        case 'HOUSEVACANT': //其他消息-房屋空置档案消息
//          if (extras.containsKey('messageType') && StringsHelper.isNotEmpty(extras['messageType'])) {
//            Navigate.toNewPage(MessagePage(messageCenterMap[extras['messageType']] ?? '', extras['messageType']));
//          }
//          break;
//        case 'SCXX': //商城
//          if (StringsHelper.isNotEmpty(extras['visitUrl']?.toString())) {
//            //url有值跳转htmlPage
//            Navigate.toNewPage(HtmlPage(
//                HttpOptions.getMallUrl(
//                    extras['visitUrl']?.toString(), stateModel.accountId, stateModel.defaultProjectId),
//                '商城'));
//          } else {
//            Navigate.toNewPage(
//                MallMsgDetailPage(extras['messageTitle']?.toString(), extras['messageText']?.toString()));
//          }
//          break;
//      }
//  }
//
//  //获取当前环境标识，放在极光推送别名前面区分
//  String _getEnvironment() {
////    return 'DEV'; //测试数据
//    switch (HttpOptions.baseUrl) {
//      case HttpOptions.urlProduction:
//        //生产
//        return 'PROD';
//        break;
//      case HttpOptions.urlDemonstration:
//        //演示
//        return 'PREVIEW';
//        break;
//      case HttpOptions.urlTest:
//        //测试
//        return 'TEST';
//        break;
//      default:
//        return 'DEV';
//        break;
//    }
//  }
//
//  //极光推送设置别名
//  void _jPushSetAlias() {
//    LogUtils.printLog('极光推送设置别名：$_countJPush');
//    stateModel.jPush.setAlias('${_getEnvironment()}${stateModel.userAccount}').then((map) {
////    stateModel.jPush.setAlias('1').then((map) { //测试数据
//      LogUtils.printLog("setAlias success: $map");
//    }).catchError((error, stackTrace) {
//      LogUtils.printLog("setAlias error: $error");
////      reportError(error, stackTrace);
//      if (_countJPush < 3) {
//        Future.delayed(Duration(seconds: 15)).whenComplete((){
//          _countJPush++;
//          _jPushSetAlias();
//        });
//      }
//    });
//  }

//  _getBottomBarTitleColor(index) {
//    return stateModel.mainCurrentIndex == index ? UIData.darkGreyColor : UIData.darkGreyColor;
//  }

  _getBottomBarIcon(index) {
    return ScopedModelDescendant<HomeStateModel>(builder: (context, child, model) {
      return SizedBox(
          width: ScreenUtil.getInstance().setWidth(21),
          height: ScreenUtil.getInstance().setHeight(21),
          child: model.mainCurrentIndex == index ? _bottomBarIcons[index][1] : _bottomBarIcons[index][0]);
    });
  }

  void _initData() {
    _bottomBarTitles = [
      '首页',
      '服务',
      '一键开门',
      '商城',
      '我的',
    ];
    _bottomBarIcons = [
      [
        Image.asset(UIData.iconHomeNormal),
        Image.asset(UIData.iconHomeSelected),
      ],
      [
        Image.asset(UIData.iconServiceNormal),
        Image.asset(UIData.iconServiceSelected),
      ],
      [
        Container(),
        Container(),
      ],
      [
        Image.asset(UIData.iconMallNormal),
        Image.asset(UIData.iconMallSelected),
      ],
      [
        Image.asset(UIData.iconMeNormal),
        Image.asset(UIData.iconMeSelected),
      ],
    ];
  }

  List<Widget> _buildIndexedStack() {
//    return stateModel.userAccount == appStoreUserAccount
//        ? <Widget>[AppStoreHomePage(), AppStoreServicePage(), Container(), MallPage(), MePage()]
//        :
//    return <Widget>[HomeCachePage(), ServicePage(), Container(), Container(), MePage()];
    LogUtils.printLog('首页显示:${stateModel.baseDataLoaded}');
    return <Widget>[
      ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
        return model.baseDataLoaded == 1 ? HomePage() : HomeCachePage();
      }),
      ServicePage(),
      Container(),
      Container(),
      MePage()
    ];
  }

  Widget _buildBottomNavigationBar() {
    return ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
      return ColorFiltered(
          colorFilter:
//              ColorFilter.mode(model.baseDataLoaded == 1 ? Colors.transparent : Colors.grey, BlendMode.color),
              ColorFilter.mode(Colors.transparent, BlendMode.color),
          child: Container(
            height: ScreenUtil.getInstance().setHeight(55),
            child: BottomNavigationBar(
              elevation: 0.0,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: _getBottomBarIcon(0),
                  title: Text(_bottomBarTitles[0],
                      style: TextStyle(color: UIData.darkGreyColor, fontSize: UIData.fontSize12)),
                ),
                BottomNavigationBarItem(
                  icon: _getBottomBarIcon(1),
                  title: Text(_bottomBarTitles[1],
                      style: TextStyle(color: UIData.darkGreyColor, fontSize: UIData.fontSize12)),
                ),
                BottomNavigationBarItem(
                  icon: _getBottomBarIcon(2),
                  title: Text(_bottomBarTitles[2],
                      style: TextStyle(color: UIData.darkGreyColor, fontSize: UIData.fontSize16)),
                ),
                BottomNavigationBarItem(
                  icon: _getBottomBarIcon(3),
                  title: Text(_bottomBarTitles[3],
                      style: TextStyle(color: UIData.darkGreyColor, fontSize: UIData.fontSize12)),
                ),
                BottomNavigationBarItem(
                  icon: _getBottomBarIcon(4),
                  title: Text(_bottomBarTitles[4],
                      style: TextStyle(color: UIData.darkGreyColor, fontSize: UIData.fontSize12)),
                ),
              ],
              currentIndex: _homeStateModel.mainCurrentIndex,
              onTap: (index) async {
                //0=加载中，1=加载成功，2=加载失败
                if (model.baseDataLoaded == 1) {
                  if(index == 1){
                    //服务
                    if(stateModel.menuDataLoaded == 2){
                      //如果项目菜单加载失败则重新加载
                      stateModel.getMenuProjectList();
                    }
                    _homeStateModel.mainCurrentIndex = index;
                  }else if (index == 2) {
                    //自动打开开门页面
//          stateModel.callNative("openDoor");
                    if (stateModel.usedList == null || stateModel.usedList.isEmpty) {
                      if (stateModel.baseDataLoaded == 1) {
                        Navigate.checkCustomerCertified(context, OpenDoorListPage()); //空的列表，跳转到请求列表
                      } else {
                        CommonToast.show(
                            msg: stateModel.baseDataLoaded == 0 ? '页面加载中，请稍候' : '请刷新页面再试！',
                            type: ToastIconType.INFO);
                      }
                    } else {
//                      Navigate.checkCustomerCertified(context, OpenDoorUsedPage()); //存在列表，跳转到常用列表
                      //存在列表，跳转到常用列表
                      if (stateModel.baseDataLoaded == 1) {
                        Navigate.checkCustomerCertified(context, OpenDoorUsedPage());
                      } else {
                        SharedPreferences prefs = await SharedPreferencesKey.globalPrefs;
                        int projectId = prefs.getInt(SharedPreferencesKey.KEY_PROJECT_ID);
                        int customerId = prefs.getInt(SharedPreferencesKey.KEY_CUSTOMER_ID);
                        int houseId = prefs.getInt(SharedPreferencesKey.KEY_HOUSE_ID);
                        if (customerId != null && projectId != null && houseId != null) {
//                      Navigate.checkCustomerCertified(context, OpenDoorUsedPage());
                          Navigate.toNewPage(OpenDoorUsedPage());
                        } else {
                          CommonToast.show(
                              msg: stateModel.baseDataLoaded == 0 ? '页面加载中，请稍候' : '请刷新页面再试！',
                              type: ToastIconType.INFO);
                        }
                      }
                    }
                  } else if (index == 3) {
                    //打开商城
                    Navigate.toNewPage(MallPage());
                  } else {
                    _homeStateModel.mainCurrentIndex = index;
                  }
                } else {
                  if (index != 0 && index != 4) {
                    if (model.baseDataLoaded == 0)
                      CommonToast.show(msg: '页面加载中，请稍候', type: ToastIconType.INFO);
                    else
                      CommonToast.show(msg: '请刷新页面再试！', type: ToastIconType.INFO);
                  } else {
                    _homeStateModel.mainCurrentIndex = index;
                  }
                }
              },
            ),
          ));
    });
  }

//
//  //获取广告弹框内容
//  void _getAd() {
//    stateModel.getAd(callback: (AdInfo adInfo) async {
//      Dio dio = new Dio(HttpOptions.getInstance);
//      Map<String, dynamic> map = new Map();
//      map["Accept-Encoding"] = "identity"; //https长度返回-1，在此添加参数后正常
//      Options options = Options(receiveTimeout: 900000, headers: map);
//
//      Response response = await dio.head(HttpOptions.urlAppDownloadImage + adInfo.imgUrl, options: options);
//      var adLength = response?.headers?.contentLength;
//      LogUtils.printLog('adLength:$adLength');
//
//      final Directory tempDir = await getTemporaryDirectory();
//      LogUtils.printLog('tempDir:${tempDir.path}');
//      SharedPreferences prefs = await SharedPreferencesKey.globalPrefs;
////      prefs.setString(SharedPreferencesKey.KEY_AD_FLAG, '红花'); //测试数据
//      if (!prefs.containsKey(SharedPreferencesKey.KEY_AD_FLAG) ||
//          (prefs.containsKey(SharedPreferencesKey.KEY_AD_FLAG) &&
//              prefs.getString(SharedPreferencesKey.KEY_AD_FLAG) != adInfo?.foreign)) {
//        dio.download(HttpOptions.urlAppDownloadImage + adInfo.imgUrl, '${tempDir.path}/${adInfo.imgUrl}',
//            options: Options(receiveTimeout: 900000), onReceiveProgress: (int received, int total) async {
//          LogUtils.printLog('下载监听');
//          LogUtils.printLog('progress received: $received');
//          LogUtils.printLog('progress total: $total');
//          if (received == adLength) {
//            LogUtils.printLog('下载完成');
//            File image = File('${tempDir.path}/${adInfo.imgUrl}');
//            if (await image.exists()) {
//              LogUtils.printLog('image 存在');
//              prefs.setString(SharedPreferencesKey.KEY_AD_FLAG, adInfo?.foreign);
//              CommonDialog.showAdDialog(context, adInfo, bgImage: image);
//            }
//          }
//        });
//      }
//    });
//  }
//
//  //检测版本
//  void _getAppVersion() {
//    stateModel.getAppVersion(callback: (String url, String version, bool isForce, String size, String desc) {
//      //下载
////      if (Platform.isAndroid) {
//      PermissionUtil.requestPermission([PermissionGroup.storage], callback: (bool isGranted) async {
//        if (isGranted) {
//          _showTipInstallDialog(url, version, isForce, size, desc);
//        } else {
//          if (isForce) {
//            //强制升级
//            CommonDialog.showAlertDialog(context,
//                title: '请打开存储权限用以更新版本！',
////                  showPositiveBtn: false,
//                showNegativeBtn: false,
//                willPop: !isForce, onConfirm: () {
//              //这是整个app退出
////              SystemNavigator.pop();
//              exit(0);
//            });
//          } else {
//            CommonDialog.showAlertDialog(context, title: '请打开存储权限用以更新版本！', showNegativeBtn: false);
//          }
//        }
//      });
////      } else {
////        InstallPlugin.gotoAppStore(url);
////      }
//    });
//  }
//
//  void _showTipInstallDialog(String url, String version, bool isForce, String size, String decs) {
//    if (isForce) {
//      //强制升级
//      CommonDialog.showUpgradeDialog(context,
//          version: version, content: decs, isForce: isForce, onTapCloseDialog: Platform.isAndroid, onConfirm: () {
//        if (Platform.isAndroid) {
////          _buildProgress();
//          _installNewVersion(url, version, size, isForce);
//        } else if (Platform.isIOS) {
//          if (HttpOptions.isTrialVersion) {
//            //IOS体验版跳转链接下载
//            if (StringsHelper.isNotEmpty(url)) {
//              stateModel.launchURL(url);
////              CommonDialog.showUpgradingDialog(context);
//            }
//          } else {
//            //IOS正式版跳转App Store
//            InstallPlugin.gotoAppStore(url);
////            CommonDialog.showUpgradingDialog(context);
//          }
//        }
//      }
////      , onCancel: () {
////        //这是整个app退出
//////        SystemNavigator.pop();
////        exit(0);
////      }
//          );
////      CommonDialog.showAlertDialog(context, content: '检测到新版本，是否安装？', willPop: !isForce,
//////                showPositiveBtn: false,
//////                showNegativeBtn: false,
////          onConfirm: () {
////      }, onCancel: () {
////        //这是整个app退出
//////        SystemNavigator.pop();
////        exit(0);
////      });
//    } else {
//      CommonDialog.showUpgradeDialog(context, version: version, content: decs, isForce: isForce, onConfirm: () {
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
////      CommonDialog.showAlertDialog(context, content: '检测到新版本，是否安装？', willPop: !isForce, onConfirm: () {
//////        _installNewVersion(url, version, size);
////        if (Platform.isAndroid) {
////          _installNewVersion(url, version, size, isForce);
////        } else if (Platform.isIOS) {
////          if (HttpOptions.isTrialVersion) {
////            //IOS体验版跳转链接下载
////            if (StringsHelper.isNotEmpty(url)) {
////              stateModel.launchURL(url);
////            }
////          } else {
////            //IOS正式版跳转App Store
////            InstallPlugin.gotoAppStore(url);
////          }
////        }
////      });
//    }
//  }
//
//  //进度条弹框
//  Widget _buildProgress(bool isForce) {
//    return CommonDialog.showAlertDialog(context,
//        content: StatefulBuilder(
//            key: _dialogKey,
//            builder: (context, state) {
//              return Column(
//                children: <Widget>[
//                  Container(
//                    margin: EdgeInsets.only(bottom: UIData.spaceSize16),
//                    width: UIData.spaceSize150,
//                    child: Image.asset(UIData.imageInUpgrading),
//                  ),
//                  Row(
//                    children: <Widget>[
//                      Expanded(
//                          child: LinearProgressIndicator(
//                              backgroundColor: UIData.dividerColor, value: _installProgress.toInt() / 100)),
//                      SizedBox(width: UIData.spaceSize4),
//                      CommonText.darkGrey14Text('${_installProgress.toInt()}%')
//                    ],
//                  ),
//                ],
//              );
//            }),
//        showPositiveBtn: !isForce,
//        showNegativeBtn: false,
//        willPop: false,
//        positiveBtnText: '后台下载',
//        positiveBtnColor: Colors.redAccent, onConfirm: () {
//      setState(() {
//        _downBack = true;
//      });
//    });
//  }
//
//  //安装新版本
//  void _installNewVersion(String url, String version, String size, bool isForce) async {
////    final Directory dir = await getTemporaryDirectory();
//    final Directory exDir = await getExternalStorageDirectory();
//    final Directory dir = Directory('${exDir.path}$externalDir');
//    if (!(await dir.exists())) {
//      await dir.create();
//    }
////    final dir = await getTemporaryDirectory();
////    final Directory dir = await getApplicationDocumentsDirectory();
//    LogUtils.printLog('安装包路径:$dir');
////    LogUtils.printLog('安装包路径exDir:$exDir');
//    String apkName = url.split('/').last;
//    String apkAbsoluteName = '${dir.path}/$apkName';
//    LogUtils.printLog('apkAbsoluteName:$apkAbsoluteName');
//    File apkFile = File(apkAbsoluteName);
//    LogUtils.printLog('服务器文件大小：$size');
//    LogUtils.printLog('本地文件大小：${await apkFile.exists() ? await apkFile.length() : '空'}');
//    Dio dio = new Dio(HttpOptions.getInstance);
//
//    if (apkFile != null && await apkFile.exists()) {
//      int localFileLength = await apkFile.length();
//      LogUtils.printLog('localFileLength: $localFileLength}');
//      if (localFileLength > 0) {
//        Response response = await dio.head(url);
//        int newVersionLength = response?.headers?.contentLength;
//        LogUtils.printLog('newVersionLength: $newVersionLength');
//        if (localFileLength == newVersionLength) {
//          //本地文件已下载完成最新版本，可直接安装
////          Navigator.pop(context);
//          _showInstallNewVersion(apkAbsoluteName, isForce);
////          OpenFile.open(apkAbsoluteName, type: "application/vnd.android.package-archive");
//          stateModel.openFile(apkAbsoluteName);
//          return;
//        }
//      }
//    }
////    if (await apkFile.exists() && StringsHelper.isNotEmpty(size) && await apkFile.length() == int.parse(size)) {
////      //安装包已存在本地，直接安装
////      OpenFile.open(apkAbsoluteName, type: "application/vnd.android.package-archive");
////      exit(0);
////    } else {
//    //安装包不存在本来，先下载再安装
//    _buildProgress(isForce);
//    Options options = Options(receiveTimeout: 900000);
////    dio.download('http://60.213.146.68:8001/download/wl_v0.2.6.apk', dir.path + '/' + url.split('/').last,
////        options: options, onReceiveProgress: (int received, int total) {
//    LogUtils.printLog('@@@@@@@@@@@@@@@@@@@$apkAbsoluteName');
////    dio.download(url, dir.path + '/' + url.split('/').last, options: options,
//    LogUtils.printLog('apkAbsoluteName2:$apkAbsoluteName');
//    dio.download(url, apkAbsoluteName, options: options, onReceiveProgress: (int received, int total) {
//      LogUtils.printLog('下载监听');
//      LogUtils.printLog('progress received: $received');
//      LogUtils.printLog('progress total: $total');
//      if (_dialogKey.currentState != null) {
//        _dialogKey.currentState.setState(() {
//          LogUtils.printLog('progress: ${_installProgress.toInt()}');
//          if ((received / total * 100) > _installProgress) _installProgress = received / total * 100;
//        });
//      }
//      // 当下载完成时，调用安装
//      if (received == total) {
//        LogUtils.printLog('下载完成');
//        if (!_downBack) Navigator.pop(context);
//        _showInstallNewVersion(apkAbsoluteName, isForce);
//        stateModel.openFile(apkAbsoluteName);
////        InstallPlugin.installApk(dir.path + '/' + url.split('/').last, stateModel.packageName);
////          OpenFile.open(apkAbsoluteName, type: "application/vnd.android.package-archive");
//        //这是整个app退出
////        SystemNavigator.pop();
////          exit(0);
////        FlutterDownloader.open(taskId: id);
//      }
//    });
////    }
//  }
//
//  void _showInstallNewVersion(String filePath, bool isForce) {
//    CommonDialog.showAlertDialog(context,
//        content: "新版本下载完成，点击安装",
//        positiveBtnText: '安装',
//        showNegativeBtn: !isForce,
//        willPop: !isForce,
//        onTapCloseDialog: false, onConfirm: () {
//      stateModel.openFile(filePath);
////      OpenFile.open(filePath, type: "application/vnd.Android.package-archive");
//    });
//  }

  @override
  Widget build(BuildContext context) {
    mainContext = context;
    return ScopedModel(
        model: _homeStateModel,
        child: ScopedModelDescendant<HomeStateModel>(builder: (context, child, model) {
          return CommonScaffold(
            showAppBar: false,
            bodyData: IndexedStack(
              index: model.mainCurrentIndex,
              children: _buildIndexedStack(),
            ),
            bottomNavigationBar: _buildBottomNavigationBar(),
            floatingActionButton: SizedBox(
              width: ScreenUtil.getInstance().setWidth(65),
              height: ScreenUtil.getInstance().setWidth(65),
              child: FloatingActionButton(
                  child: Image.asset(
                    UIData.iconOpenDoor,
                    fit: BoxFit.fill,
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  highlightElevation: 0.0,
                  onPressed: () async {
//                    CommonToast.show(msg: '嵌入页面，开发中，稍候开放', type: ToastIconType.INFO);
//                    stateModel.callNative("openDoor");
//                    Navigate.toNewPage(OpenDoorPage())
//                    model.mainCurrentIndex=2;
//                    model.notifyListeners();
                    if (stateModel.usedList == null || stateModel.usedList.isEmpty) {
                      if (stateModel.baseDataLoaded == 1) {
                        Navigate.checkCustomerCertified(context, OpenDoorListPage()); //空的列表，跳转到请求列表
                      } else {
                        CommonToast.show(
                            msg: stateModel.baseDataLoaded == 0 ? '页面加载中，请稍候' : '请刷新页面再试！',
                            type: ToastIconType.INFO);
                      }
                    } else {
//                      Navigate.checkCustomerCertified(context, OpenDoorUsedPage()); //存在列表，跳转到常用列表
                      //存在列表，跳转到常用列表
                      if (stateModel.baseDataLoaded == 1) {
                        Navigate.checkCustomerCertified(context, OpenDoorUsedPage());
                      } else {
                        SharedPreferences prefs = await SharedPreferencesKey.globalPrefs;
                        int projectId = prefs.getInt(SharedPreferencesKey.KEY_PROJECT_ID);
                        int customerId = prefs.getInt(SharedPreferencesKey.KEY_CUSTOMER_ID);
                        int houseId = prefs.getInt(SharedPreferencesKey.KEY_HOUSE_ID);
                        if (customerId != null && projectId != null && houseId != null) {
//                      Navigate.checkCustomerCertified(context, OpenDoorUsedPage());
                          Navigate.toNewPage(OpenDoorUsedPage());
                        } else {
                          CommonToast.show(
                              msg: stateModel.baseDataLoaded == 0 ? '页面加载中，请稍候' : '请刷新页面再试！',
                              type: ToastIconType.INFO);
                        }
                      }
                    }
                  }),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          );
        }));
  }
}
