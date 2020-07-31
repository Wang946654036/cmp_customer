import 'package:binding_helper/binding_helper.dart';
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/ui/common/common_list_refresh.dart';
import 'package:cmp_customer/ui/common/common_refresh_page.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/home/home_appbar.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sticky_headers/sticky_headers.dart';

///
/// 服务
///
class ServicePage extends StatefulWidget {
  final bool showTop;

  ServicePage({this.showTop = true});

  @override
  _ServicePageState createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  final ScrollController _scrollController = new ScrollController(); //垂直列表
  final ScrollController _tabScrollController = new ScrollController(); //tab栏横向
  final double _tabWidth = ScreenUtil.screenWidthDp / 4; //tab的宽度
  int _currentModuleIndex = 0;
  double _topWidgetHeight = 0;
  double _firstGridViewHeight;
  double _firstGridViewPosition;
  double _secondGridViewHeight;
  double _secondGridViewPosition;
  double _thirdGridViewHeight;
  double _thirdGridViewPosition;
  double _fourthGridViewHeight;
  double _fourthGridViewPosition;
  double _fifthGridViewHeight;
  double _fifthGridViewPosition;
  double _sixthGridViewHeight;
  double _sixthGridViewPosition;
  double _tabHeight = ScreenUtil.getInstance().setHeight(45);

//  double _blankHeight = 230;
  bool _clickButton = false; //是否点击tab按钮做出的滑动动作，如果是点击做出的滑动，按钮底下的色块不动
  double _pageHeight = 0; //应用中心页面总高度
  double _spaceHeight = 0; //留白的高度

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
//      LogUtils.printLog('offset: ${_scrollController.offset}');
      setState(() {
        if (!_clickButton) {
          if (_scrollController.offset < _secondGridViewPosition) {
            _currentModuleIndex = 0;
            _tabAnimateToPosition(0);
          } else if (_scrollController.offset >= _secondGridViewPosition &&
              _scrollController.offset < _thirdGridViewPosition) {
            _currentModuleIndex = 1;
            _tabAnimateToPosition(0);
          } else if (_scrollController.offset >= _thirdGridViewPosition &&
              _scrollController.offset < _fourthGridViewPosition) {
            _currentModuleIndex = 2;
            _tabAnimateToPosition(_tabWidth);
          } else if (_scrollController.offset >= _fourthGridViewPosition &&
              _scrollController.offset < _fifthGridViewPosition) {
            _currentModuleIndex = 3;
            _tabAnimateToPosition(_tabWidth * 2);
          } else if (_scrollController.offset >= _fifthGridViewPosition &&
              _scrollController.offset < _sixthGridViewPosition) {
            _currentModuleIndex = 4;
            _tabAnimateToPosition(_tabWidth * 3);
          } else if (_scrollController.offset >= _sixthGridViewPosition) {
            _currentModuleIndex = 5;
            _tabAnimateToPosition(_tabWidth * 4);
          }
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///
  /// 一个Item，图标+文字样式
  ///
  Widget _buildItem(String title, String imageName, {double size = 25, GestureTapCallback onTap}) {
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

  Widget _buildGridViewWithTitle({String title, int index, List<Widget> children}) {
    return RectProvider(
        child: Container(
          color: UIData.primaryColor,
          padding: EdgeInsets.only(top: UIData.spaceSize16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Visibility(
                  visible: title != null,
                  child: Container(
                    decoration:
                        BoxDecoration(border: Border(left: BorderSide(color: UIData.themeBgColor, width: 5))),
                    padding: EdgeInsets.only(left: UIData.spaceSize8),
                    margin: EdgeInsets.only(left: UIData.spaceSize16),
                    child: CommonText.darkGrey16Text(title ?? '', fontWeight: FontWeight.bold),
                  )),
              GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, childAspectRatio: 1.2),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                children: children,
              )
            ],
          ),
        ),
        onGetRect: (Rect rect) {
//          LogUtils.printLog('girdview$index: ${rect.size.height}');
          switch (index) {
            case 0:
              _firstGridViewHeight = rect.size.height;
              _firstGridViewPosition = _topWidgetHeight;
              _secondGridViewPosition = _topWidgetHeight + _firstGridViewHeight;
              if (stateModel.menuServiceList != null && stateModel.menuServiceList.length == 2)
                _spaceHeight = _pageHeight - _tabHeight - _firstGridViewHeight;
//              LogUtils.printLog('_firstGridViewPosition: $_firstGridViewPosition');
              break;
            case 1:
              _secondGridViewHeight = rect.size.height;
//              _secondGridViewPosition = _topWidgetHeight + _firstGridViewHeight;
              _thirdGridViewPosition = _secondGridViewPosition + _secondGridViewHeight;
              if (stateModel.menuServiceList != null && stateModel.menuServiceList.length == 2)
                _spaceHeight = _pageHeight - _tabHeight - _secondGridViewHeight;
//              LogUtils.printLog('_secondGridviewPosition: $_secondGridViewPosition');
              break;
            case 2:
              _thirdGridViewHeight = rect.size.height;
//              _thirdGridViewPosition = _secondGridViewPosition + _secondGridViewHeight;
              _fourthGridViewPosition = _thirdGridViewPosition + _thirdGridViewHeight;
              if (stateModel.menuServiceList != null && stateModel.menuServiceList.length == 3)
                _spaceHeight = _pageHeight - _tabHeight - _thirdGridViewHeight;
//              LogUtils.printLog('_thirdGridviewPosition: $_thirdGridViewPosition');
              break;
            case 3:
              _fourthGridViewHeight = rect.size.height;
//              _fourthGridViewPosition = _thirdGridViewPosition + _thirdGridViewHeight;
              _fifthGridViewPosition = _fourthGridViewPosition + _fourthGridViewHeight;
              if (stateModel.menuServiceList != null && stateModel.menuServiceList.length == 4)
                _spaceHeight = _pageHeight - _tabHeight - _fourthGridViewHeight;
//              LogUtils.printLog('_fourthGridViewPosition: $_fourthGridViewPosition');
              break;
            case 4:
              _fifthGridViewHeight = rect.size.height;
//              _fifthGridViewPosition = _fourthGridViewPosition + _fourthGridViewHeight;
              _sixthGridViewPosition = _fifthGridViewPosition + _fifthGridViewHeight;
              if (stateModel.menuServiceList != null && stateModel.menuServiceList.length == 5)
                _spaceHeight = _pageHeight - _tabHeight - _fifthGridViewHeight;
//              LogUtils.printLog('_fifthGridViewPosition: $_fifthGridViewPosition');
              break;
            case 5:
              _sixthGridViewHeight = rect.size.height;
//              _sixthGridViewPosition = _fifthGridViewPosition + _fifthGridViewHeight;
              if (stateModel.menuServiceList != null && stateModel.menuServiceList.length == 6)
                _spaceHeight = _pageHeight - _tabHeight - _sixthGridViewHeight;
              LogUtils.printLog('_sixthGridViewHeight$_sixthGridViewHeight');
//              if (_contentHeight != null) {
//                setState(() {
//                  _blankHeight = _contentHeight - _sixthGridViewHeight;
//                  LogUtils.printLog('_blankHeight$_blankHeight');
//                });
//              }
//              LogUtils.printLog('_sixthGridViewPosition: $_sixthGridViewPosition');
              break;
          }
        });
  }

  ///
  /// 最近使用
  ///
//  Widget _buildRecentlyUsed() {
//    return _buildGridViewWithTitle(title: '最近使用', children: <Widget>[
//      _buildItem('预约挂号', UIData.iconHealth160Service, onTap: () {
//        stateModel.getHealthyToken(stateModel.mobile);
//      }),
//      _buildItem('投诉', UIData.iconComplaintService),
//      _buildItem('物品放行', UIData.iconGoodsPassService),
//      _buildItem('家政维修', UIData.iconApplianceRepairService),
//      _buildItem('家政保洁', UIData.iconHousekeepingService),
//      _buildItem('房屋租售', UIData.iconHouseRentSale, onTap: () {
//        Navigate.toNewPage(HtmlPage(HttpOptions.houseShouYeUrl, "房屋租售"));
//      }),
//      _buildItem('表扬', UIData.iconPraiseService),
//      _buildItem('调查问卷', UIData.iconQuestionnaire),
//    ]);
//  }

  ///
  /// 底部横线的容器
  ///
  Widget _buildBottomBorderContainer(String title, int index, {GestureTapCallback onTap}) {
    return GestureDetector(
      child: Container(
        width: _tabWidth,
        padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize12),
        color: UIData.primaryColor,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: index == _currentModuleIndex ? UIData.themeBgColor : UIData.primaryColor,
                      width: UIData.spaceSize3))),
          child: CommonText.darkGrey16Text(title),
        ),
      ),
      onTap: onTap,
    );
  }

  ///
  /// 滑动到列表指定位置
  ///
  void _animateToPosition(int index, double position) {
    setState(() {
      _clickButton = true;
      _currentModuleIndex = index;
      _scrollController.animateTo(position, duration: Duration(milliseconds: 500), curve: Curves.easeOut);
    });
  }

  ///
  /// tabBar滑动到指定位置
  ///
  void _tabAnimateToPosition(double position) {
    _tabScrollController.animateTo(position, duration: Duration(milliseconds: 200), curve: Curves.linear);
  }

  double _getIndexPosition(MenuInfo menuInfo) {
    switch (stateModel.menuServiceList?.indexOf(menuInfo)) {
      case 0:
        return _firstGridViewPosition;
        break;
      case 1:
        return _secondGridViewPosition;
        break;
      case 2:
        return _thirdGridViewPosition;
        break;
      case 3:
        return _fourthGridViewPosition;
        break;
      case 4:
        return _fifthGridViewPosition;
        break;
      case 5:
        return _sixthGridViewPosition;
        break;
      default:
        return 0;
    }
  }

  //获取tabar
  List<Widget> _getTabBar() {
    List<Widget> widgetList = List();
    stateModel.menuServiceList?.forEach((MenuInfo menuInfo) {
      widgetList.add(_buildBottomBorderContainer(
          menuInfo?.resourceName, stateModel.menuServiceList?.indexOf(menuInfo),
          onTap: () =>
              _animateToPosition(stateModel.menuServiceList?.indexOf(menuInfo), _getIndexPosition(menuInfo))));
    });
    return widgetList;
  }

  ///
  /// 功能模块顶部粘性列表
  ///
  Widget _buildModuleStickList() {
    return Container(
      color: UIData.primaryColor,
      padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, UIData.spaceSize16),
      child: StickyHeaderBuilder(
          builder: (BuildContext context, double stuckAmount) {
//            stuckAmount = 1.0 - stuckAmount.clamp(0.0, 1.0);
//            LogUtils.printLog(stuckAmount.toString());
            return Container(
              alignment: Alignment.topLeft,
              height: _tabHeight,
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: UIData.dividerColor)),
                color: UIData.primaryColor,
              ),
              child: ListView(
                controller: _tabScrollController,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
//                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _getTabBar(),
//                children: <Widget>[
//                  _buildBottomBorderContainer('为您推荐', 0,
//                      onTap: () => _animateToPosition(0, _firstGridViewPosition)),
//                  _buildBottomBorderContainer('物业服务', 1,
//                      onTap: () => _animateToPosition(1, _secondGridViewPosition)),
//                  _buildBottomBorderContainer('业务办理', 2,
//                      onTap: () => _animateToPosition(2, _thirdGridViewPosition)),
//                  _buildBottomBorderContainer('社区服务', 3,
//                      onTap: () => _animateToPosition(3, _fourthGridViewPosition)),
//                  _buildBottomBorderContainer('便民服务', 4,
//                      onTap: () => _animateToPosition(4, _fifthGridViewPosition)),
//                  _buildBottomBorderContainer('社区纷享', 5,
//                      onTap: () => _animateToPosition(5, _sixthGridViewPosition)),
//                ],
              ),
            );
          },
          content: Container(
            child: Column(
              children: _buildTabContent(),
//              children: <Widget>[
//                _buildGridViewWithTitle(index: 0, children: <Widget>[
//                  _buildItem(' ', UIData.iconPropertyPaymentService,
//                      onTap: () => stateModel.tap2Module('物管缴费', title: '物管缴费', context: context)),
//                  _buildItem('停车缴费', UIData.iconParkingPaymentService,
//                      onTap: () => stateModel.tap2Module('停车缴费', title: '停车缴费', context: context)),
////                  _buildItem('到家钱包', UIData.iconWalletService,
////                      onTap: () => stateModel.tap2Module('到家钱包', title: '到家钱包', context: context)),
//                  _buildItem('房屋租售', UIData.iconHouseRentSale,
//                      onTap: () => stateModel.tap2Module('房屋租售', title: '房屋租售', context: context)),
//                  _buildItem('充值中心', UIData.iconBeeService,
//                      onTap: () => stateModel.tap2Module('充值中心', title: '充值中心', context: context)),
//                  _buildItem('社区通行', UIData.iconAccessPass,
//                      onTap: () => stateModel.tap2Module('社区通行', title: '社区通行', context: context)),
//                ]),
//                _buildGridViewWithTitle(index: 1, title: '物业服务', children: <Widget>[
//                  _buildItem('公区报障', UIData.iconReportObstacle,
//                      onTap: () => stateModel.tap2Module('公区报障', title: '公区报障', context: context)),
//                  _buildItem('室内维修', UIData.iconRepairService,
//                      onTap: () => stateModel.tap2Module('室内维修', title: '室内维修', context: context)),
//                  _buildItem('投诉', UIData.iconComplaintService,
//                      onTap: () => stateModel.tap2Module('投诉', title: '投诉', context: context)),
//                  _buildItem('表扬', UIData.iconPraiseService,
//                      onTap: () => stateModel.tap2Module('表扬', title: '表扬', context: context)),
//                  _buildItem('投票', UIData.iconVote,
//                      onTap: () => stateModel.tap2Module('投票', title: '投票', context: context)),
//                  _buildItem('咨询建议', UIData.iconAdviceSuggestion,
//                      onTap: () => stateModel.tap2Module('咨询建议', title: '咨询建议', context: context)),
//                  _buildItem('我的房屋', UIData.iconMyHouseService,
//                      onTap: () => stateModel.tap2Module('我的房屋', title: '我的房屋', context: context)),
//                  _buildItem('调查问卷', UIData.iconQuestionnaire,
//                      onTap: () => stateModel.tap2Module('调查问卷', title: '调查问卷', context: context)),
////                  _buildItem('物业通知', UIData.iconQuestionnaire,
////                      onTap: () => Navigate.toNewPage(PropertyNoticePage())),
//                ]),
//                _buildGridViewWithTitle(index: 2, title: '业务办理', children: _buildYWBL()),
//                _buildGridViewWithTitle(index: 3, title: '社区服务', children: <Widget>[
//                  //家电安装
//                  _buildItem(pay__Appliance_installation, UIData.iconApplicationInstallService,
//                      onTap: () =>
//                          stateModel.tap2Module('家电安装', title: pay__Appliance_installation, context: context)),
//                  //家政维修
//                  _buildItem(pay_Appliance_repair, UIData.iconApplianceRepairService,
//                      onTap: () => stateModel.tap2Module('家政维修', title: pay_Appliance_repair, context: context)),
//                  //家政保洁
//                  _buildItem(pay_Housekeeping, UIData.iconHousekeepingService,
//                      onTap: () => stateModel.tap2Module('家政保洁', title: pay_Housekeeping, context: context)),
//                  //房屋维修
//                  _buildItem(pay_Housing_maintenance, UIData.iconHouseRepairService,
//                      onTap: () =>
//                          stateModel.tap2Module('房屋维修', title: pay_Housing_maintenance, context: context)),
//                  //其他服务
//                  _buildItem(pay_orther, UIData.iconOtherService,
//                      onTap: () => stateModel.tap2Module('其他服务', title: pay_orther, context: context)),
//                ]),
//                _buildGridViewWithTitle(index: 4, title: '便民服务', children: <Widget>[
////                  _buildItem('预约挂号', UIData.iconHealth160Service,
////                      onTap: () => stateModel.tap2Module('预约挂号', title: '预约挂号', context: context)),
//                  _buildItem('周边信息', UIData.iconAroundInfo,
//                      onTap: () => stateModel.tap2Module('周边信息', title: '周边信息', context: context)),
//                ]),
//                _buildGridViewWithTitle(index: 5, title: '社区纷享', children: _buildCommunityShare(),
////                    children: <Widget>[
////                  _buildItem('社区活动', UIData.iconCommunityActivity,
////                      onTap: () => stateModel.tap2Module('社区活动', title: '社区活动', context: context)),
////                  _buildItem('资讯', UIData.iconPcgInfomation,
////                      onTap: () => stateModel.tap2Module('资讯', title: '资讯', context: context)),
////                  _buildItem('邻里集市', UIData.iconMarket,
////                      onTap: () => stateModel.tap2Module('邻里集市', title: '邻里集市', context: context)),
////                      onTap: () => Navigate.checkCustomerCertified(context, PgcInfomationListPage())),
////                  _buildItem('社区话题', UIData.iconCommunityActivity,
////                      onTap: () => Navigate.toNewPage(PgcTopicDisscussPage())),
//
////                  _buildItem('投票', UIData.iconVote),
////                  _buildItem('活动报名', UIData.iconActivityRegistration),
////                  _buildItem('调查问卷', UIData.iconPraiseService,
////                      onTap: () => CommonToast.show(msg: '嵌入页面，开发中，稍候开放', type: ToastIconType.INFO)),
////                  _buildItem('便民服务', UIData.iconConvenienceServices),
////                  _buildItem('停车缴费', UIData.iconParkingPaymentService),
////                  _buildItem('物业通知', UIData.iconPropertyNotice,
////                      onTap: () => CommonToast.show(msg: '开发中，稍候开放', type: ToastIconType.INFO)),
////                  _buildItem('话题', UIData.iconTopic),
////                  _buildItem('市集', UIData.iconMarket),
////                  _buildItem('时事焦点', UIData.iconCurrentAffairsFocus),
////                  _buildItem('物业资讯', UIData.iconPropertyInfomation),
////                ]
//                    ),
//                Container(height: ScreenUtil.getInstance().setHeight(_blankHeight ?? 0)),
//              ],
            ),
          )),
    );
  }

  List<Widget> _buildTabContent() {
    List<Widget> widgetList = List();
//    _buildGridViewWithTitle(index: 0, children: _buildGD()),
    stateModel.menuServiceList?.forEach((MenuInfo menuInfo) {
      List<Widget> childList = List();
      menuInfo?.children?.forEach((MenuInfo child) {
        childList.add(_buildItem(child?.resourceName ?? '',
            '${UIData.imageDirService}/${StringsHelper.isNotEmpty(child?.icon) ? child?.icon?.trim() : 'nodata.png'}', onTap: () {
          stateModel.tap2Module(child.linkUrl, title: child.resourceName, context: context);
        }));
      });
      widgetList.add(_buildGridViewWithTitle(
//          title: stateModel.menuServiceList.length > 1 && stateModel.menuServiceList.indexOf(menuInfo) == 0
          title: stateModel.menuServiceList.indexOf(menuInfo) == 0
              ? null
              : menuInfo?.resourceName,
          index: stateModel.menuServiceList?.indexOf(menuInfo),
          children: childList));
    });
    widgetList.add(Container(height: _spaceHeight));
    return widgetList;
  }

  //社区纷享
//  List<Widget> _buildCommunityShare() {
//    List<Widget> widgetList = List();
//    widgetList.addAll([
//      _buildItem('社区活动', UIData.iconCommunityActivity,
//          onTap: () => stateModel.tap2Module('社区活动', title: '社区活动', context: context)),
//      _buildItem('资讯', UIData.iconPcgInfomation,
//          onTap: () => stateModel.tap2Module('资讯', title: '资讯', context: context)),
//      _buildItem('社区商圈', UIData.iconCommunityBusiness,
//          onTap: () => stateModel.tap2Module('社区商圈', title: '社区商圈', context: context)),
////      _buildItem('商圈本地', UIData.iconCommunityBusiness,
////          onTap: () => stateModel.tap2Module('商圈本地', title: '商圈本地', context: context)),
////      _buildItem('商业活动', UIData.iconBusinessActivities,
////          onTap: () => stateModel.tap2Module('商业活动', title: '商业活动', context: context)),
////      _buildItem('商业活动本地', UIData.iconBusinessActivities,
////          onTap: () => stateModel.tap2Module('商业活动本地', title: '商业活动本地', context: context)),
//      _buildItem('话题', UIData.iconCommunityTopics,
//          onTap: () => stateModel.tap2Module('话题', title: '话题', context: context)),
////      _buildItem('话题本地', UIData.iconCommunityTopics,
////          onTap: () => stateModel.tap2Module('话题本地', title: '话题本地', context: context)),
//      _buildItem('说说', UIData.iconCommunityShuoShuo,
//          onTap: () => stateModel.tap2Module('说说', title: '说说', context: context)),
////      _buildItem('说说本地', UIData.iconCommunityShuoShuo,
////          onTap: () => stateModel.tap2Module('说说本地', title: '说说本地', context: context)),
//    ]);
//    if (stateModel.showMarket) {
//      widgetList.add(_buildItem('邻里集市', UIData.iconMarket,
//          onTap: () => stateModel.tap2Module('邻里集市', title: '邻里集市', context: context)));
//    }
//    return widgetList;
//  }

  //业务办理模块图标
//  List<Widget> _buildYWBL() {
//    List<Widget> widgetList = List();
//    widgetList.addAll([
//      _buildItem('门禁卡申请', UIData.iconAccessCard,
//          onTap: () => stateModel.tap2Module('门禁卡申请', title: '门禁卡申请', context: context)),
//      _buildItem('停车办理', UIData.iconParkingManagement,
//          onTap: () => stateModel.tap2Module('停车办理', title: '停车办理', context: context)),
//      _buildItem('物品放行', UIData.iconGoodsPassService,
//          onTap: () => stateModel.tap2Module('物品放行', title: '物品放行', context: context)),
////                      onTap: () => CommonDialog.showDevelopmentDialog(context)),
//      _buildItem('动火申请', UIData.iconHotWorkApplication,
//          onTap: () => stateModel.tap2Module('动火申请', title: '动火申请', context: context)),
//      _buildItem('产权变更', UIData.iconPropertyChange,
//          onTap: () => stateModel.tap2Module('产权变更', title: '产权变更', context: context)),
//      //租户入驻属于商业
//      _buildItem('租户入驻', UIData.iconTenantSettled,
//          onTap: () => stateModel.tap2Module('租户入驻', title: '租户入驻', context: context)),
//      _buildItem('装修申请', UIData.iconDecorationApplication,
//          onTap: () => stateModel.tap2Module('装修申请', title: '装修申请', context: context)),
//      //游客也能访问，装修工负责人有可能是游客
//      _buildItem('装修工出入证', UIData.iconDecorationPass,
//          onTap: () => stateModel.tap2Module('装修工出入证', title: '装修工出入证', context: context)),
//      //预定会议室属于商业
//      _buildItem('会议室预定', UIData.iconMeetingRoomReservationService,
//          onTap: () => stateModel.tap2Module('会议室预定', title: '会议室预定', context: context)),
//      //写字楼退租属于商业
//      _buildItem('写字楼退租', UIData.iconOfficeWithdrawal,
////                      onTap: () => CommonDialog.showDevelopmentDialog(context)),
//          onTap: () => stateModel.tap2Module('写字楼退租', title: '写字楼退租', context: context)),
//      //水牌名牌属于商业
//      _buildItem('水牌名牌', UIData.iconBrandName,
////                      onTap: () => CommonDialog.showDevelopmentDialog(context)),
//          onTap: () => stateModel.tap2Module('水牌名牌', title: '水牌名牌', context: context)),
//      _buildItem('新房入伙', UIData.iconNewHouseJoininService,
////                      onTap: () => CommonDialog.showDevelopmentDialog(context)),
//          onTap: () => stateModel.tap2Module('新房入伙', title: '新房入伙', context: context)),
//      _buildItem('预约到访', UIData.iconVisitorAppointment,
////                      onTap: () => CommonDialog.showDevelopmentDialog(context)),
//          onTap: () => stateModel.tap2Module('预约到访', title: '预约到访', context: context)),
//    ]);
//    //生产环境不显示的内容
////    if (HttpOptions.baseUrl != HttpOptions.urlProduction) {
////      widgetList.addAll([
////      ]);
////    }
//    return widgetList;
//  }

  Widget _buildContent() {
    return RectProvider(
        child: Container(
          color: UIData.primaryColor,
          child: GestureDetector(
            child: ListView(
              controller: _scrollController,
              padding: EdgeInsets.zero,
              children: <Widget>[
//                  RectProvider(
//                      child: Column(
//                        children: <Widget>[
////                      _buildRecentlyUsed(),
////                      SizedBox(height: UIData.spaceSize12),
//                        ],
//                      ),
//                      onGetRect: (Rect rect) {
//                        _topWidgetHeight = rect.size.height;
//                  LogUtils.printLog('_topWidgetHeight:   $_topWidgetHeight');
//                      }),
                _buildModuleStickList(),
              ],
            ),
            onPanDown: (down) {
              setState(() {
                _clickButton = false;
              });
            },
          ),
        ),
        onGetRect: (Rect rect) {
          _pageHeight = rect.size.height;
//        LogUtils.printLog('_tabHeight${_tabHeight}');
//        LogUtils.printLog('_sixthGridViewHeight${_sixthGridViewHeight}');
//        LogUtils.printLog('_contentHeight${rect.size.height}');
//        _blankHeight = rect.size.height - _tabHeight - _sixthGridViewHeight + ScreenUtil.getInstance().setHeight(20);
//            _blankHeight = ScreenUtil.getInstance().setHeight(rect.height - _sixthGridViewHeight + 10);
//            _blankHeight = rect.size.height - (_tabHeight * 2) - _sixthGridViewHeight- UIData.spaceSize26;
//        LogUtils.printLog('@@@@@@@@@@@@@@@@@${rect.size.height}');
        });
  }

  Widget _buildBody() {
    switch (stateModel.menuDataLoaded) {
      //项目数据菜单是否加载完成：0=加载中，1=加载成功，2=加载失败
      case 0:
        return Center(
          child: Container(
              child: const SpinKitFadingCircle(color: UIData.redGradient3),
              margin: EdgeInsets.only(bottom: ScreenUtil.getInstance().setHeight(150))),
        );
        break;
      case 1:
        return stateModel.menuServiceList != null && stateModel.menuServiceList.length > 0
            ? _buildContent()
            : CommonListRefresh(
                state: ListState.HINT_NO_DATA_CLICK,
                callBack: () {
                  stateModel.getMenuProjectList();
                });
        break;
      case 2:
        return CommonRefreshPage(
          callbackRefresh: (){
            stateModel.getMenuProjectList();
          },
        );
        break;
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
      return CommonScaffold(
        showLeftButton: !widget.showTop,
        appTitle: widget.showTop ? HomeLocationButton() : '全部应用',
        appBarActions: widget.showTop
            ? [
//        HomeScanButton(),
                HomeMessageButton()
              ]
            : null,
        bodyData: _buildBody(),
      );
    });
  }
}
