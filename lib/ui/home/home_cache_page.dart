import 'dart:convert';

import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/home_menulist_model.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_refresh_page.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/notice/property_notice_detail_page.dart';
import 'package:cmp_customer/ui/notice/property_notice_page.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/shared_preferences_key.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeCachePage extends StatefulWidget {
  @override
  _HomeCachePageState createState() => _HomeCachePageState();
}

class _HomeCachePageState extends State<HomeCachePage> {
  double _maxImageHeight = 0;
  List<MenuInfo> _menuList; //菜单列表
  bool _refreshLoading = false; //是否下拉刷新

  @override
  void initState() {
    super.initState();
    //750*314
    double screenWidth = ScreenUtil.screenWidthDp;
    _maxImageHeight = 314 * (screenWidth / 750);
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///
  /// 轮播图
  ///
  Widget _buildSwiper() {
    return ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
      return ColorFiltered(
          colorFilter: ColorFilter.mode(Colors.transparent, BlendMode.color),
          child: Container(
//        alignment: Alignment.topCenter,
            width: ScreenUtil.screenWidth,
            height: _maxImageHeight,
            child: GestureDetector(
                child: Image.asset(UIData.imageBannerDefaultLoading, fit: BoxFit.cover),
                onTap: () => CommonToast.show(msg: '页面加载中，请稍候', type: ToastIconType.INFO)),
          ));
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
      onTap: () {
        CommonToast.show(msg: '页面加载中，请稍候', type: ToastIconType.INFO);
      },
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
      onTap: () => CommonToast.show(msg: '页面加载中，请稍候', type: ToastIconType.INFO),
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
                  _buildFirstLineItem('公区报障', '一键报障随手拍', UIData.iconGreySquareLogo, 0),
                  SizedBox(width: UIData.spaceSize8),
                  _buildFirstLineItem('物管缴费', '一键缴费超省心', UIData.iconGreySquareLogo, 1),
                ],
              ),
              SizedBox(height: UIData.spaceSize8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _buildFirstLineItem('停车缴费', '绿色通行好助手', UIData.iconGreySquareLogo, 0),
                  SizedBox(width: UIData.spaceSize8),
                  _buildFirstLineItem(
                    '房屋租售',
                    '优房租售好管家',
                    UIData.iconGreySquareLogo,
                    1,
                    onTap: () => CommonToast.show(msg: '页面加载中，请稍候', type: ToastIconType.INFO),
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
                  Image.asset(UIData.iconGreySquareLogo, width: UIData.spaceSize30, fit: BoxFit.fitWidth),
                  SizedBox(height: UIData.spaceSize8),
                  CommonText.darkGrey15Text('我的房屋'),
                  SizedBox(height: UIData.spaceSize8),
                ],
              ),
            ),
            onTap: () => CommonToast.show(msg: '页面加载中，请稍候', type: ToastIconType.INFO)),
      ],
    );
  }

  Future<List<Widget>> _buildSecondItem() async {
    List<Widget> widgetList = List();
    SharedPreferences prefs = await SharedPreferencesKey.globalPrefs;
    String menuStr = prefs.getString(SharedPreferencesKey.KEY_HOME_MENULIST);
    if (StringsHelper.isNotEmpty(menuStr)) {
      HomeMenuListModel homeMenuListModel = HomeMenuListModel.fromJson(json.decode(menuStr));
      _menuList = homeMenuListModel.menuList;
      _menuList?.forEach((MenuInfo menuInfo) {
        widgetList.add(_buildItem(menuInfo?.resourceName ?? '', UIData.iconGreyCircularLogo, 26));
      });
      widgetList.add(_buildItem('全部', UIData.iconGreyCircularLogo, 26));
      return widgetList;
    } else
      return null;
  }

  ///
  /// 第二三行Item
  ///
  Widget _buildSecondLine() {
    return FutureBuilder(
        future: _buildSecondItem(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Container();
              break;
            case ConnectionState.waiting:
              return Container();
              break;
            case ConnectionState.active:
              return Container();
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                return Container(
                    color: UIData.primaryColor,
//        padding: EdgeInsets.only(top: UIData.spaceSize20),
                    child: GridView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
                      children: snapshot.data,
                    ));
              } else {
                return _defaultSecondLine();
              }
              break;
            default:
              return Container();
              break;
          }
        });
  }

  Widget _defaultSecondLine() {
    return Container(
        color: UIData.primaryColor,
//        padding: EdgeInsets.only(top: UIData.spaceSize20),
        child: GridView(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
          children: <Widget>[
            _buildItem('室内维修', UIData.iconGreyCircularLogo, 26),
            _buildItem('咨询建议', UIData.iconGreyCircularLogo, 26),
            _buildItem('表扬', UIData.iconGreyCircularLogo, 26),
            _buildItem('投诉', UIData.iconGreyCircularLogo, 26),
            _buildItem('物品放行', UIData.iconGreyCircularLogo, 26),
            _buildItem('社区通行', UIData.iconGreyCircularLogo, 26),
            _buildItem('周边信息', UIData.iconGreyCircularLogo, 26),
            _buildItem('房屋租售', UIData.iconGreyCircularLogo, 26),
            _buildItem('预约挂号', UIData.iconGreyCircularLogo, 26),
            _buildItem('全部', UIData.iconGreyCircularLogo, 26),
          ],
        ));
  }

  ///
  /// 招小通客服
  ///
  Widget _buildCustomerService() {
    return ColorFiltered(
        colorFilter: ColorFilter.mode(Colors.transparent, BlendMode.color),
        child: GestureDetector(
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
          onTap: () => CommonToast.show(msg: '页面加载中，请稍候', type: ToastIconType.INFO),
        ));
  }

  ///
  /// 物业通知栏
  ///
  Widget _buildPropertyNotice() {
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

  //问卷调查模块

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

  Future<void> _handleRefresh() async {
    setState(() {
      _refreshLoading = true;
    });
    await stateModel.getUserData(loginTag: true, callBack: ({String errorMsg}) {});
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
      return CommonScaffold(
        showLeftButton: false,
//        showAppBar: false,
//        appTitle: HomeLocationButton(),
//        appBarActions: [
////        HomeScanButton(),
//          HomeMessageButton()
//        ],
//      bodyData: RefreshIndicator(
//        child: ListView(
//          children: <Widget>[
//            _buildSwiper(),
////            _buildPropertyNotice(),
//            _buildFirstLine(),
//            _buildSecondLine(),
//            _buildCustomerService(),
//            _buildBottomLine(),
//          ],
//        ),
//        onRefresh: _handleRefresh,
//      ),
        bodyData: model.baseDataLoaded == 0
            ? RefreshIndicator(
                child: Stack(
                  children: <Widget>[
                    ListView(
                      children: <Widget>[
                        _buildSwiper(),
//            _buildPropertyNotice(),
                        _buildFirstLine(),
                        _buildSecondLine(),
                        _buildCustomerService(),
                        _buildBottomLine(),
                      ],
                    ),
                    Visibility(
                        child: Container(
                            child: const SpinKitFadingCircle(color: UIData.redGradient3),
                            margin: EdgeInsets.only(bottom: ScreenUtil.getInstance().setHeight(150))),
                        visible: !_refreshLoading)
//                    Container(child: const SpinKitFadingCube(color: UIData.redGradient3),
//                    margin: EdgeInsets.only(bottom: ScreenUtil.getInstance().setHeight(50)))
                  ],
                ),
                onRefresh: _handleRefresh,
              )
            : CommonRefreshPage(callbackRefresh: (){
          setState(() {
        _refreshLoading = false;
      });
      stateModel.getUserData(loginTag: true, callBack: ({String errorMsg}) {});

        },)
//        Container(
//                color: UIData.primaryColor,
////            padding: EdgeInsets.all(UIData.spaceSize30),
//                child: Center(
//                  child: Column(
//                    mainAxisSize: MainAxisSize.min,
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    crossAxisAlignment: CrossAxisAlignment.stretch,
//                    children: <Widget>[
////            CommonText.darkGrey16Text('功能建设中', textAlign: TextAlign.center, fontWeight: FontWeight.w500),
////            SizedBox(height: UIData.spaceSize16),
//                      Container(
//                        alignment: Alignment.center,
//                        height: ScreenUtil.getInstance().setWidth(135),
//                        child: Image.asset(
//                          UIData.imageNoNetwork,
//                          fit: BoxFit.fitHeight,
//                        ),
//                      ),
//                      SizedBox(height: UIData.spaceSize30),
////            CommonText.darkGrey18Text('关注公众号“招商到家汇”', textAlign: TextAlign.center),
////            SizedBox(height: UIData.spaceSize20),
//                      CommonText.darkGrey15Text(
//                          StringsHelper.isNotEmpty(model.baseDataLoadedFailedMsg)
//                              ? model.baseDataLoadedFailedMsg
//                              : '亲，您的手机网络不大顺畅哦，请检查网络设置',
//                          fontWeight: FontWeight.w500,
//                          textAlign: TextAlign.center,
//                          overflow: TextOverflow.fade),
//                      SizedBox(height: UIData.spaceSize40),
//                      StadiumSolidButton('刷新', onTap: () {
//                        setState(() {
//                          _refreshLoading = false;
//                        });
//                        stateModel.getUserData(loginTag: true, callBack: ({String errorMsg}) {});
//                      }),
//                    ],
//                  ),
//                ),
//              ),
      );
    });
  }
}
