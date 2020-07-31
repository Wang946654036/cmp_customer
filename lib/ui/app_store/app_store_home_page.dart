//import 'package:cached_network_image/cached_network_image.dart';
//import 'package:cmp_customer/http/http_options.dart';
//import 'package:cmp_customer/http/http_util.dart';
//import 'package:cmp_customer/main.dart';
//import 'package:cmp_customer/models/banner_model.dart';
//import 'package:cmp_customer/models/community_activity_model.dart';
//import 'package:cmp_customer/models/market/ware_detail_model.dart';
//import 'package:cmp_customer/models/pgc/pgc_infomation_obj.dart';
//import 'package:cmp_customer/models/user_data_model.dart';
//import 'package:cmp_customer/scoped_models/main_state_model.dart';
//import 'package:cmp_customer/scoped_models/market_model/market_list_model.dart';
//import 'package:cmp_customer/scoped_models/pgc_model/pgc_infomation_model.dart';
//import 'package:cmp_customer/ui/articles_release/articles_release_apply_page.dart';
//import 'package:cmp_customer/ui/common/common_button.dart';
//import 'package:cmp_customer/ui/common/common_dialog.dart';
//import 'package:cmp_customer/ui/common/common_scaffold.dart';
//import 'package:cmp_customer/ui/common/common_shadow_container.dart';
//import 'package:cmp_customer/ui/common/common_text.dart';
//import 'package:cmp_customer/ui/common/common_toast.dart';
//import 'package:cmp_customer/ui/home/banner_detail_page.dart';
//import 'package:cmp_customer/ui/home/community_activity_page.dart';
//import 'package:cmp_customer/ui/home/home_appbar.dart';
//import 'package:cmp_customer/ui/home/service_page.dart';
//import 'package:cmp_customer/ui/house_authentication/my_house_page.dart';
//import 'package:cmp_customer/ui/html/html_page.dart';
//import 'package:cmp_customer/ui/market/market_item.dart';
//import 'package:cmp_customer/ui/market/market_list_page.dart';
//import 'package:cmp_customer/ui/near_info/near_info_list.dart';
//import 'package:cmp_customer/ui/notice/property_notice_detail_page.dart';
//import 'package:cmp_customer/ui/notice/property_notice_page.dart';
//import 'package:cmp_customer/ui/pgc/pgc_infomation/pgc_infomation_detail.dart';
//import 'package:cmp_customer/ui/pgc/pgc_infomation/pgc_infomation_item.dart';
//import 'package:cmp_customer/ui/pgc/pgc_infomation/pgc_infomation_list_page.dart';
//import 'package:cmp_customer/ui/visitor_release/visitor_release_create.dart';
//import 'package:cmp_customer/ui/work_other/complaint_page.dart';
//import 'package:cmp_customer/ui/work_other/pay_service_list.dart';
//import 'package:cmp_customer/ui/work_other/work_other_ui.dart';
//import 'package:cmp_customer/utils/common_strings_helper.dart';
//import 'package:cmp_customer/utils/navigate.dart';
//import 'package:cmp_customer/utils/shared_preferences_key.dart';
//import 'package:cmp_customer/utils/ui_data.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:flutter_swiper/flutter_swiper.dart';
//import 'package:scoped_model/scoped_model.dart';
//
//class AppStoreHomePage extends StatefulWidget {
//  @override
//  _AppStoreHomePageState createState() => _AppStoreHomePageState();
//}
//
//class _AppStoreHomePageState extends State<AppStoreHomePage> {
//  double _maxImageHeight = 0;
//  List<MenuInfo> _menuList; //菜单列表
//  bool _marketStatementCheck = false; //邻里集市声明是否显示
//  GlobalKey _marketStatementDialogKey = GlobalKey(); //邻里集市声明弹框的key
//
//  @override
//  void initState() {
//    super.initState();
////    _initBanner();
//    //750*314
//    double screenWidth = ScreenUtil.screenWidthDp;
//    _maxImageHeight = 314 * (screenWidth / 750);
//
//    _menuList = stateModel?.menuList?.where((MenuInfo child) => child.orderNo != -1)?.toList();
//
////    _checkMarketStatement();
//  }
//
//  @override
//  void dispose() {
//    super.dispose();
//    stateModel.closeWebSocket(); //关闭聊天
//  }
//
////  void _checkMarketStatement() async {
////    SharedPreferences prefs = await SharedPreferencesKey.globalPrefs;
////    _marketStatementCheck = prefs.getBool(SharedPreferencesKey.KEY_MARKET_STATEMENT) ?? true;
////  }
//
//  //获取banner
////  void _initBanner() {
////    stateModel.getBanner();
////  }
//
//  SwiperPlugin _buildSwiperPagination() {
//    return SwiperPagination(
//        margin: EdgeInsets.all(0.0),
//        builder: SwiperCustomPagination(builder: (BuildContext context, SwiperPluginConfig config) {
//          return Container(
//            alignment: Alignment.centerRight,
//            decoration: BoxDecoration(
//                image: DecorationImage(image: AssetImage(UIData.imageBannerFrontBg), fit: BoxFit.fill)),
//            padding: EdgeInsets.only(right: UIData.spaceSize4),
//            child: ListView.builder(
//                shrinkWrap: true,
//                itemCount: stateModel.bannerList?.length ?? 1,
////                reverse: true,
//                scrollDirection: Axis.horizontal,
//                itemBuilder: (context, index) {
//                  return Container(
//                    alignment: Alignment.topCenter,
//                    child: Container(
//                      width: ScreenUtil.getInstance().setWidth(5),
//                      height: ScreenUtil.getInstance().setHeight(5),
//                      margin: EdgeInsets.only(right: UIData.spaceSize2, top: UIData.spaceSize20),
//                      decoration: ShapeDecoration(
//                          shape: BeveledRectangleBorder(
//                            //每个角落的半径
//                            borderRadius: BorderRadius.circular(100.0),
//                          ),
//                          color: config.activeIndex == index ? UIData.themeBgColor : UIData.dividerColor),
//                    ),
//                  );
//                }),
//            constraints: new BoxConstraints.expand(height: 35.0),
//          );
//        }));
//  }
//
//  //banner图片显示
//  Widget _buildImage({String imagePath, GestureTapCallback onTap}) {
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
//  }
//
//  ///
//  /// 轮播图
//  ///
//  Widget _buildSwiper() {
//    return ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
//      return Container(
//        alignment: Alignment.topCenter,
//        width: ScreenUtil.screenWidth,
//        height: _maxImageHeight,
//        child: (stateModel.bannerList == null || stateModel.bannerList.length == 0)
//            ? _buildImage()
//            : Swiper(
//                autoplay: stateModel.bannerAutoPlay,
////            autoplay: false,
//                //测试数据
//                loop: (stateModel.bannerList?.length ?? 1) > 1,
//                itemBuilder: (BuildContext context, int index) {
//                  if (stateModel.bannerList == null || stateModel.bannerList.length == 0) {
//                    return _buildImage();
//                  } else {
//                    BannerInfo bannerInfo = stateModel.bannerList[index];
//                    return _buildImage(
//                        imagePath: bannerInfo?.uuid,
//                        onTap: () {
//                          //类型：1-网页链接，2-图片链接，3-pgc链接
//                          if (bannerInfo.type == 1) {
//                            Navigate.toNewPage(HtmlPage(bannerInfo.url, bannerInfo?.title ?? ''));
////                      Navigate.toNewPage(HtmlPage('http://www.baidu.com', ''));
//                          } else if (bannerInfo.type == 2) {
//                            Navigate.toNewPage(BannerDetailPage(bannerInfo.url, bannerInfo?.title ?? ''));
//                          } else if (bannerInfo.type == 3) {
//                            Navigate.toNewPage(PgcInfomationDetail(
//                                PgcInfomationInfo(
//                                    pgcId: StringsHelper.isNotEmpty(bannerInfo.url)
//                                        ? int.parse(bannerInfo.url)
//                                        : null),
//                                canEdit: false));
//                          }
//                        });
//                  }
//                },
//                itemCount: stateModel.bannerList?.length ?? 1,
//                pagination: _buildSwiperPagination()),
//      );
//    });
//  }
//
//  ///
//  /// 一个Item，图标+文字样式
//  ///
//  Widget _buildItem(String title, String imageName, double size, {GestureTapCallback onTap}) {
//    return GestureDetector(
//      behavior: HitTestBehavior.translucent,
//      child: Container(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            SizedBox(
//              width: ScreenUtil.getInstance().setWidth(size),
//              height: ScreenUtil.getInstance().setHeight(size),
//              child: Image.asset(imageName),
//            ),
//            SizedBox(height: UIData.spaceSize8),
//            CommonText.darkGrey12Text(title),
//          ],
//        ),
//      ),
//      onTap: onTap,
//    );
//  }
//
//  ///
//  ///第一行图标
//  ///[paddingDirect]内边距的方向，0-左，1-右
//  ///
//  Widget _buildFirstLineItem(String title, String subTitle, String imagePath, int paddingDirect,
//      {GestureTapCallback onTap}) {
//    return Expanded(
//        child: GestureDetector(
//      child: Container(
//        decoration: BoxDecoration(
//            border: Border.all(color: UIData.lighterGreyColor, width: 0.2),
//            borderRadius: BorderRadius.circular(6.0)),
//        padding: EdgeInsets.only(
//            left: paddingDirect == 1 ? 0 : UIData.spaceSize8,
//            right: paddingDirect == 1 ? UIData.spaceSize8 : 0,
//            top: UIData.spaceSize8,
//            bottom: UIData.spaceSize8),
//        child: paddingDirect == 1
//            ? Row(
//                mainAxisAlignment: MainAxisAlignment.end,
//                children: <Widget>[
//                  Column(
//                    crossAxisAlignment: CrossAxisAlignment.end,
//                    children: <Widget>[
//                      CommonText.darkGrey15Text(title),
//                      SizedBox(height: UIData.spaceSize4),
//                      CommonText.lightGrey11Text(subTitle)
//                    ],
//                  ),
//                  SizedBox(width: UIData.spaceSize8),
//                  Image.asset(imagePath, width: UIData.spaceSize30, fit: BoxFit.fitWidth),
//                ],
//              )
//            : Row(
//                mainAxisAlignment: MainAxisAlignment.start,
//                children: <Widget>[
//                  Image.asset(imagePath, width: UIData.spaceSize30, fit: BoxFit.fitWidth),
//                  SizedBox(width: UIData.spaceSize8),
//                  Column(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: <Widget>[
//                      CommonText.darkGrey15Text(title),
//                      SizedBox(height: UIData.spaceSize4),
//                      CommonText.lightGrey11Text(subTitle)
//                    ],
//                  ),
//                ],
//              ),
//      ),
//      onTap: onTap,
//    ));
//  }
//
//  ///
//  /// 第一行图标
//  ///
//  Widget _buildFirstLine() {
//    return Stack(
//      alignment: Alignment.center,
//      children: <Widget>[
//        Container(
//          color: UIData.primaryColor,
//          padding: EdgeInsets.symmetric(vertical: UIData.spaceSize16, horizontal: UIData.spaceSize16),
//          child: Column(
//            children: <Widget>[
//              Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: <Widget>[
//                  _buildFirstLineItem('公区报障', '一键报障随手拍', UIData.iconReportObstacle, 0,
//                      onTap: () =>
//                          Navigate.checkCustomerCertified(context, ComplaintPage(WorkOtherMainType.Warning))),
//                  SizedBox(width: UIData.spaceSize8),
//                  _buildFirstLineItem('物管缴费', '一键缴费超省心', UIData.iconPropertyPayment, 1,
//                      onTap: () => Navigate.checkCustomerCertified(
//                          context, HtmlPage(HttpOptions.getPropertyPayUrl(), '物管缴费'))),
//                ],
//              ),
//              SizedBox(height: UIData.spaceSize8),
//              Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: <Widget>[
//                  _buildFirstLineItem('停车缴费', '绿色通行好助手', UIData.iconParkingPayment, 0, onTap: () {
//                    if (stateModel.defaultProjectId != null) {
//                      Navigate.toNewPage(HtmlPage(
//                          HttpOptions.getParkingPayUrl(stateModel.accountId, stateModel.defaultProjectId),
//                          "停车缴费"));
//                    } else {
//                      CommonToast.show(msg: '请选择社区！', type: ToastIconType.INFO);
//                    }
//                  }),
//                  SizedBox(width: UIData.spaceSize8),
//                  _buildFirstLineItem(
//                    '预约到访',
//                    '亲友来访提前约',
//                    UIData.iconVisitorAppointment,
//                    1,
//                    onTap: () {
//                      Navigate.toNewPage(VisitorReleaseCreate());
//                    },
//                  )
//                ],
//              ),
//            ],
//          ),
//        ),
//        GestureDetector(
//            child: Container(
//              padding: EdgeInsets.all(UIData.spaceSize12),
//              decoration: ShapeDecoration(shape: CircleBorder(), color: UIData.primaryColor, shadows: [
//                BoxShadow(
//                    color: UIData.lightestGreyColor70,
//                    offset: Offset(0.0, 3.0),
//                    blurRadius: 1.0,
//                    spreadRadius: 0.0)
//              ]),
//              child: Column(
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: <Widget>[
//                  Image.asset(UIData.iconMyHouse, width: UIData.spaceSize30, fit: BoxFit.fitWidth),
//                  SizedBox(height: UIData.spaceSize8),
//                  CommonText.darkGrey15Text('我的房屋'),
//                  SizedBox(height: UIData.spaceSize8),
//                ],
//              ),
//            ),
//            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
//                  return MyHousePage();
////                  return FirstPrivacyPolicyPage(); //测试数据
//                }))),
////        CommonShadowContainer(
////          borderRadius: 1000.0,
//////          backgroundColor: UIData.lightestRedColor70,
////          shadowColor: UIData.lighterRedColor,
////          offsetX: 3.0,
////          offsetY: 1.0,
////          blurRadius: 1.0,
////          padding: EdgeInsets.all(UIData.spaceSize16),
////          child: Column(
////            children: <Widget>[
////              Image.asset(UIData.iconMyHouse, width: UIData.spaceSize30, fit: BoxFit.fitWidth),
////              SizedBox(width: UIData.spaceSize16),
////              CommonText.darkGrey18Text('我的房屋'),
////            ],
////          ),
////        )
//      ],
//    );
////    return Container(
////      color: UIData.primaryColor,
////      padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize16),
////      child: Container(
////        padding: EdgeInsets.symmetric(vertical: UIData.spaceSize20),
////        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: UIData.scaffoldBgColor))),
////        child: Row(
////          mainAxisAlignment: MainAxisAlignment.spaceBetween,
////          children: <Widget>[
////            _buildItem('物管缴费', UIData.iconPropertyPayment, 42,
////                onTap: () =>
////                  Navigate.checkCustomerCertified(context,HtmlPage(HttpOptions.getPropertyPayUrl(), '物管缴费'))),
////            _buildItem('到家钱包', UIData.iconWallet, 42,
////                onTap: () =>
//////                    CommonToast.show(msg: '非本期功能', type: ToastIconType.INFO)
////                    CommonDialog.showDevelopmentDialog(context)),
////            _buildItem('我的房屋', UIData.iconMyHouse, 42,
////                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
////                      return MyHousePage();
////                    }))),
////            _buildItem('停车缴费', UIData.iconParkingPayment, 42,
////                onTap: (){
////                  Navigate.toNewPage(HtmlPage(HttpOptions.getParkingPayUrl(stateModel.customerId, stateModel.defaultProjectId),"停车缴费"));
////                }
//////                    CommonToast.show(
//////                    msg: '开发中，稍候开放', type: ToastIconType.INFO)
//////                    CommonDialog.showDevelopmentDialog(context)
////
////            ),
////            _buildItem('房屋租售', UIData.iconHousePurchasing, 42,
////                onTap: () =>
//////                    CommonToast.show(msg: '非本期功能', type: ToastIconType.INFO)
//////                    CommonDialog.showDevelopmentDialog(context)
////                //跳转到招商置业页面
////                Navigate.toNewPage(HtmlPage(HttpOptions.houseShouYeUrl,"房屋租售"))
////            ),
////          ],
////        ),
////      ),
////    );
//  }
//
//  List<Widget> _buildSecondItem() {
//    List<Widget> widgetList = List();
//    _menuList?.forEach((MenuInfo menuInfo) {
//      widgetList.add(_buildItem(
//          menuInfo?.resourceName ?? '',
//          '${StringsHelper.isNotEmpty(menuInfo?.icon) ? '${UIData.imageDirService}/${menuInfo?.icon}' : '${UIData.imageDir}/nodata.png'}',
//          26, onTap: () {
//        stateModel.tap2Module(menuInfo.linkUrl, title: menuInfo.resourceName, context: context);
//      }));
//    });
//    widgetList.add(_buildItem('全部', UIData.iconMore, 26, onTap: () {
//      Navigate.toNewPage(ServicePage(showTop: false));
//    }));
//    return widgetList;
//  }
//
//  ///
//  /// 第二三行Item
//  ///
//  Widget _buildSecondLine() {
//    return Container(
//        color: UIData.primaryColor,
////        padding: EdgeInsets.only(top: UIData.spaceSize20),
//        child: GridView(
//          physics: NeverScrollableScrollPhysics(),
//          shrinkWrap: true,
//          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
////          children: _buildSecondItem(),
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
////            _buildItem('房屋租售', UIData.iconHouseRentSale, 26,
////                onTap: () =>
//////                          CommonDialog.showDevelopmentDialog(context)
////                    Navigate.toNewPage(HtmlPage(HttpOptions.houseShouYeUrl, "房屋租售"))),
//////            _buildItem('室内维修', UIData.iconRepairService, 26, onTap: () {
//////              Navigate.checkCustomerCertified(
//////                  context, ComplaintPage(WorkOtherMainType.Repair, sub: WorkOtherSubType.Repair));
//////            }),
//////            _buildItem('公区报障', UIData.iconReportObstacle, 26, onTap: () {
//////              Navigate.checkCustomerCertified(context, ComplaintPage(WorkOtherMainType.Warning));
//////            }),
//            _buildItem('调查问卷', UIData.iconQuestionnaire, 26,
//                onTap: () => Navigate.toNewPage(CommunityActivityPage(activityType: 1))),
//////            _buildItem('停车办理', UIData.iconComplaint, 26, onTap: () {
//////              Navigate.checkCustomerCertified(context, ParkingCardMinePage());
//////            }),
////            _buildItem('预约挂号', UIData.iconHealth160Service, 26, onTap: () {
////              stateModel
////                  .getHealthyToken(stateModel.customerType == 2 ? stateModel.mobile : stateModel.userAccount);
//////              if (stateModel.checkModulePermission(context)) stateModel.getHealthyToken(stateModel.mobile);
//////              Navigate.toNewPage(HtmlPage("https://www.taobao.com/","预约挂号"));
////            }),
////            ScopedModelDescendant<HomeStateModel>(builder: (context, child, model) {
////              return
//            _buildItem('周边信息', UIData.iconAroundInfo, 26, onTap: () => Navigate.toNewPage(NearInfoListPage())),
//            _buildItem('全部', UIData.iconMore, 26, onTap: () {
////                model.mainCurrentIndex = 1;
//              Navigate.toNewPage(ServicePage(showTop: false));
//            })
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
//////            _buildItem('房屋维修', UIData.iconHouseRepair, 26, onTap: () {
//////              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
//////                return PayServiceWorkOtherListPage(WorkOtherSubType.HousePaid, [
//////                  WorkOtherSubType.InstallPaid,
//////                  WorkOtherSubType.RepairPaid,
//////                  WorkOtherSubType.CleaningPaid,
//////                  WorkOtherSubType.HousePaid,
//////                  WorkOtherSubType.OtherPaid
//////                ]);
//////              }));
//////            }),
//////            _buildItem('表扬', UIData.iconPraise, 26, onTap: () {
//////              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
//////                return ComplaintPage(WorkOtherMainType.Praise);
//////              }));
//////            }),
////            }),
//          ],
//        ));
//  }
//
//  //Gridview点击跳转处理
////  void _tap2Module(MenuInfo menuInfo) async {
////    switch (menuInfo.linkUrl) {
////      case '室内维修':
////        Navigate.checkCustomerCertified(
////            context,
////            ComplaintPage(
////              WorkOtherMainType.Repair,
////              sub: WorkOtherSubType.Repair,
////            ));
////        break;
////      case '咨询建议':
////        Navigate.checkCustomerCertified(
////            context,
////            ComplaintPage(
////              WorkOtherMainType.Advice,
////              sub: WorkOtherSubType.Advice,
////            ));
////        break;
////      case '表扬':
////        Navigate.checkCustomerCertified(context, ComplaintPage(WorkOtherMainType.Praise));
////        break;
////      case '投诉':
////        Navigate.checkCustomerCertified(context, ComplaintPage(WorkOtherMainType.Complaint));
////        break;
////      case '物品放行':
////        Navigate.checkCustomerCertified(context, ArticlesReleaseApplyPage());
////        break;
////      case '社区通行':
////        if (2 == stateModel?.customerType &&
////            stateModel.customerId != null &&
////            stateModel.defaultProjectId != null &&
////            stateModel.defaultHouseId != null) {
////          CommonToast.show(msg: '加载中');
////          HttpUtil.refreshToken(callBack: ({String errorMsg}) async {
////            CommonToast.dismiss();
////            if (errorMsg == null) {
////              stateModel.getAccessPassInfo();
////            } else {
////              CommonToast.show(type: ToastIconType.FAILED, msg: errorMsg);
////            }
////          });
////        } else {
////          CommonDialog.showUncertifiedDialog(context);
////        }
////        break;
////      case '家政保洁':
////        Navigate.checkCustomerCertified(
////            context,
////            PayServiceWorkOtherListPage(WorkOtherSubType.CleaningPaid, [
////              WorkOtherSubType.InstallPaid,
////              WorkOtherSubType.RepairPaid,
////              WorkOtherSubType.CleaningPaid,
////              WorkOtherSubType.HousePaid,
////              WorkOtherSubType.OtherPaid
////            ]));
////        break;
////      case '房屋租售':
////        Navigate.toNewPage(HtmlPage(HttpOptions.houseShouYeUrl, menuInfo.resourceName));
////        break;
////      case '预约挂号':
////        stateModel.getHealthyToken(stateModel.customerType == 2 ? stateModel.mobile : stateModel.userAccount);
////        break;
////      case '预约挂号':
////        stateModel.getHealthyToken(stateModel.customerType == 2 ? stateModel.mobile : stateModel.userAccount);
////        break;
////    }
////  }
//
//  ///
//  /// 招小通客服
//  ///
//  Widget _buildCustomerService() {
//    return GestureDetector(
//      child: Container(
//        color: UIData.primaryColor,
//        padding: EdgeInsets.all(UIData.spaceSize16),
//        child: Container(
//          padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize16),
//          decoration: BoxDecoration(
//            borderRadius: BorderRadius.circular(5.0),
//            border: Border.all(color: UIData.dividerColor),
//          ),
//          child: Row(
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            crossAxisAlignment: CrossAxisAlignment.center,
//            children: <Widget>[
//              Container(
//                width: ScreenUtil.getInstance().setWidth(40),
//                child: Image.asset(
//                  UIData.imageZhaoxiaotong,
//                  fit: BoxFit.fill,
//                ),
//              ),
//              Expanded(
//                  child: ListTile(
//                dense: true,
////              isThreeLine: true,
//                title: CommonText.darkGrey15Text('招小通客户服务热线', fontWeight: FontWeight.bold),
//                subtitle: CommonText.grey12Text('您的专属管家，一键便达！'),
//              )),
//              Container(
//                width: ScreenUtil.getInstance().setWidth(42),
//                child: UIData.iconTel,
//              )
//            ],
//          ),
//        ),
//      ),
//      onTap: () {
//        if (stateModel.checkModulePermission(context)) stateModel.callPhone(stateModel.allDayTel);
//      },
//    );
//  }
//
//  ///
//  /// 物业通知栏
//  ///
//  Widget _buildPropertyNotice() {
////    return GestureDetector(
////      child: Container(
//////        margin: EdgeInsets.only(bottom: UIData.spaceSize16),
////        color: UIData.primaryColor,
////        child: Column(
////          children: <Widget>[
////            ListTile(
////                dense: true,
////                title: CommonText.darkGrey16Text('物业通知', fontWeight: FontWeight.bold),
////                trailing: CommonText.grey12Text('更多')),
//////          CommonText.darkGrey18Text('稍后开放')
////            ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
////              return (model?.propertyNoticeList != null && model.propertyNoticeList.length > 0)
////                  ? ListView.builder(
////                      padding:
////                          EdgeInsets.fromLTRB(UIData.spaceSize16, 0.0, UIData.spaceSize16, UIData.spaceSize16),
////                      physics: NeverScrollableScrollPhysics(),
////                      shrinkWrap: true,
////                      itemCount: model?.propertyNoticeList?.length ?? 0,
////                      itemBuilder: (context, index) {
////                        PropertyNotice notice = model.propertyNoticeList[index];
////                        return Container(
////                          padding: EdgeInsets.only(bottom: UIData.spaceSize4),
////                          child: Row(
////                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
////                            children: <Widget>[
////                              CommonText.grey14Text(notice?.title ?? ''),
////                              CommonText.lightGrey14Text(notice?.sendTime ?? ''),
////                            ],
////                          ),
////                        );
//////                  ListTile(dense: true,
//////                    title: CommonText.grey14Text('关于开展迎新春写春联活动的通知'), trailing: CommonText.grey14Text('01-11'));
////                      })
////                  : Container(
////                      alignment: Alignment.centerLeft,
////                      padding: EdgeInsets.only(bottom: UIData.spaceSize8, left: UIData.spaceSize16),
////                      child: CommonText.lightGrey12Text('暂无信息'));
////            })
////          ],
////        ),
////      ),
////      onTap: () => Navigate.toNewPage(PropertyNoticePage()),
////    );
//    return Container(
//      padding: EdgeInsets.all(UIData.spaceSize16),
//      color: UIData.primaryColor,
//      child: Row(
//        crossAxisAlignment: CrossAxisAlignment.center,
//        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//        children: <Widget>[
//          Expanded(
//              child: GestureDetector(
//            behavior: HitTestBehavior.translucent,
//            child: Row(
//              children: <Widget>[
//                Container(
//                  padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize6, vertical: UIData.spaceSize2),
//                  decoration: BoxDecoration(
//                      color: UIData.themeBgColor,
//                      borderRadius:
//                          BorderRadius.only(topLeft: Radius.circular(10.0), bottomRight: Radius.circular(10.0))),
//                  child: CommonText.text12('物业通知', color: UIData.primaryColor),
//                ),
//                SizedBox(width: UIData.spaceSize8),
//                Expanded(
//                    child: CommonText.darkGrey14Text(
//                        (stateModel.propertyNoticeList == null || stateModel.propertyNoticeList.length == 0)
//                            ? '暂无'
//                            : (stateModel.propertyNoticeList[0]?.title ?? ''))),
//                SizedBox(width: UIData.spaceSize8),
//                CommonText.lightGrey12Text((stateModel.propertyNoticeList != null &&
//                        stateModel.propertyNoticeList.length > 0 &&
//                        StringsHelper.isNotEmpty(stateModel?.propertyNoticeList[0]?.sendTime))
//                    ? StringsHelper.formatterMD.format(DateTime.parse(stateModel.propertyNoticeList[0]?.sendTime))
//                    : '')
//              ],
//            ),
//            onTap: () => Navigate.toNewPage(PropertyNoticeDetailPage(stateModel.propertyNoticeList[0]?.id)),
//          )),
//          GestureDetector(
//            behavior: HitTestBehavior.translucent,
//            child: Row(
//              children: <Widget>[SizedBox(width: UIData.spaceSize16), CommonText.grey14Text('更多')],
//            ),
//            onTap: () => Navigate.toNewPage(PropertyNoticePage()),
//          ),
//        ],
//      ),
//    );
//  }
//
//  //社区活动栏表头
//  Widget _buildCommunityActivityTop(String title, List list, {GestureTapCallback onTap}) {
//    return Visibility(
//        child: GestureDetector(
//          child: Container(
//            padding:
//                EdgeInsets.only(left: UIData.spaceSize16, right: UIData.spaceSize16, bottom: UIData.spaceSize12),
//            color: UIData.primaryColor,
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//              crossAxisAlignment: CrossAxisAlignment.end,
//              children: <Widget>[
//                CommonText.darkGrey16Text(title ?? '', fontWeight: FontWeight.bold),
//                CommonText.lightGrey12Text('更多')
//              ],
//            ),
////          child: ListTile(
////              dense: true,
////              title: CommonText.darkGrey16Text(title ?? '', fontWeight: FontWeight.bold),
////              trailing: CommonText.lightGrey12Text('更多'),
////              onTap: onTap),
//          ),
//          onTap: onTap,
//        ),
//        visible: list != null && list.length > 0);
//  }
//
//  ///
//  /// 社区活动栏
//  ///
//  Widget _buildCommunityActivity() {
//    return ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
//      return Visibility(
//          visible: model.activityHomePageList != null && model.activityHomePageList.length > 0,
//          child: Container(
//            color: UIData.primaryColor,
//            padding: EdgeInsets.only(bottom: UIData.spaceSize16),
//            child: Container(
//              height: ScreenUtil.getInstance().setHeight(190),
////            height: _communityActivityHeight,
//              color: UIData.primaryColor,
//              child: ListView.builder(
//                  scrollDirection: Axis.horizontal,
//                  padding: EdgeInsets.fromLTRB(0.0, 0.0, UIData.spaceSize16, 0.0),
//                  physics: AlwaysScrollableScrollPhysics(),
//                  itemCount: model?.activityHomePageList?.length ?? 0,
//                  itemBuilder: (context, index) {
//                    ActivityInfo info = model.activityHomePageList[index];
//                    return _buildCommunityActivityCard(info);
//                  }),
//            ),
//          )
//
////                    ;
////                  }))
////                ],
////              ),
////            ),
////            onTap: () => Navigate.toNewPage(CommunityActivityPage()),
////          )
//          );
//    });
//  }
//
//  //社区活动卡片
//  Widget _buildCommunityActivityCard(ActivityInfo info) {
////    LogUtils.printLog('社区活动图片：'+'${HttpOptions.urlAppDownload}${UIData.imageCommunityDefaultHomePage}');
////    info?.logo = null;
//    return CommonShadowContainer(
////        padding: EdgeInsets.only(bottom: UIData.spaceSize8),
//        margin: EdgeInsets.only(left: UIData.spaceSize16, bottom: ScreenUtil.getInstance().setHeight(12)),
//        child: Container(
////          width: UIData.spaceSize200,
//          //只有一条的时候撑开
//          width: stateModel?.activityHomePageList?.length == 1
//              ? ScreenUtil.screenWidthDp - (2 * UIData.spaceSize16)
//              : UIData.spaceSize200,
//          child: Column(
//            mainAxisSize: MainAxisSize.min,
//            crossAxisAlignment: CrossAxisAlignment.stretch,
//            children: <Widget>[
//              ClipRRect(
//                  borderRadius: BorderRadius.only(topLeft: Radius.circular(6.0), topRight: Radius.circular(6.0)),
//                  child:
////                  info?.logo != null
////                      ?
////                  FadeInImage.assetNetwork(
////                    height: ScreenUtil.getInstance().setHeight(95),
////                    placeholder: UIData.imageBannerDefaultLoading,
////                    image: HttpOptions.showPhotoUrl(info?.logo),
////                    fit: BoxFit.cover,
////                  )
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
////                      : Image.asset(UIData.imageBannerDefaultNoData,
////                          height: ScreenUtil.getInstance().setHeight(95), fit: BoxFit.cover)
//                  ),
//              Container(
//                padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize16),
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.stretch,
//                  children: <Widget>[
////                    SizedBox(height: UIData.spaceSize4),
//                    Container(
//                        height: ScreenUtil.getInstance().setHeight(20),
//                        alignment: Alignment.bottomLeft,
//                        child: CommonText.darkGrey14Text(info?.name ?? '')),
////                    SizedBox(height: UIData.spaceSize2),
//                    Container(
//                        height: ScreenUtil.getInstance().setHeight(16),
//                        alignment: Alignment.bottomLeft,
//                        child: CommonText.text12(
//                            '活动开始时间：${StringsHelper.isNotEmpty(info?.beginTime) ? info?.beginTime?.substring(0, 16) : ''}',
//                            color: UIData.lightGreyColor)),
////                    SizedBox(height: UIData.spaceSize2),
//                    Container(
//                        height: ScreenUtil.getInstance().setHeight(16),
//                        alignment: Alignment.bottomLeft,
//                        child: CommonText.text12(
//                            '活动结束时间：${StringsHelper.isNotEmpty(info?.endTime) ? info?.endTime?.substring(0, 16) : ''}',
//                            color: UIData.lightGreyColor)),
////                    SizedBox(height: UIData.spaceSize2),
//                    Container(
//                      height: ScreenUtil.getInstance().setHeight(25),
//                      alignment: Alignment.bottomLeft,
//                      child: Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        children: <Widget>[
//                          Row(
//                            children: <Widget>[
//                              CommonText.text12('参与人数：', color: UIData.lightGreyColor),
//                              CommonText.text12((info?.commitCount ?? 0).toString(), color: UIData.lightGreyColor),
//                              CommonText.text12('人', color: UIData.lightGreyColor),
//                            ],
//                          ),
//                          StadiumOutlineButton('去参加')
//                        ],
//                      ),
//                    ),
//                  ],
//                ),
//              )
//            ],
//          ),
//        ),
//        onTap: () {
//          stateModel.communityActivityGetH5(info?.id, callBack: (String url) {
//            Navigate.toNewPage(HtmlPage(url, info?.name,
//                toShare: true,
//                thumbImageUrl: StringsHelper.isNotEmpty(info?.logo)
//                    ? HttpOptions.showPhotoUrl(info?.logo)
//                    : '${HttpOptions.urlAppDownloadImage}${UIData.imageCommunityDefaultHomePage}'));
//          });
//        });
//  }
//
//  //投票模块
//  Widget _buildVote() {
//    return ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
//      return (model.voteHomePageList != null && model.voteHomePageList.length > 0)
//          ? Container(
//              color: UIData.primaryColor,
//              padding: EdgeInsets.only(bottom: UIData.spaceSize16),
//              child: Container(
//                height: ScreenUtil.getInstance().setHeight(190),
//                margin: EdgeInsets.only(left: UIData.spaceSize16, right: UIData.spaceSize16),
//                child: CommonShadowContainer(
//                  padding: EdgeInsets.only(left: UIData.spaceSize8, right: UIData.spaceSize8),
//                  offsetY: 1.0,
//                  blurRadius: 10.0,
//                  child: (stateModel.voteHomePageList == null || stateModel.voteHomePageList.length == 0)
//                      ? Container()
//                      : Swiper(
//                          autoplay: stateModel.voteAutoPlay,
//                          loop: (model?.voteHomePageList?.length ?? 0) > 1,
//                          itemBuilder: (BuildContext context, int index) {
//                            return _buildVoteCard(model.voteHomePageList[index]);
//                          },
//                          itemCount: model.voteHomePageList?.length ?? 0),
//                ),
//              ),
//            )
//          : Container();
//    });
//  }
//
//  //投票item
//  Widget _buildVoteCard(ActivityInfo info) {
////    LogUtils.printLog('投票图片：'+'${HttpOptions.urlAppDownload}${UIData.imageVoteDefaultHomePage}');
//    return GestureDetector(
//      child: Container(
//        height: ScreenUtil.getInstance().setHeight(190),
//        child: Column(
//          mainAxisSize: MainAxisSize.min,
//          crossAxisAlignment: CrossAxisAlignment.stretch,
//          children: <Widget>[
//            SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
//            Container(
//              height: ScreenUtil.getInstance().setHeight(125),
////              width: ScreenUtil.getInstance().setWidth(300),
//              child: FittedBox(
//                fit: BoxFit.cover,
//                alignment: Alignment.center,
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
//              ),
//            ),
//            Container(
//                height: ScreenUtil.getInstance().setHeight(20),
//                alignment: Alignment.bottomLeft,
//                child: CommonText.darkGrey14Text(info?.name ?? '')),
////                    SizedBox(height: UIData.spaceSize2),
//            Container(
//              height: ScreenUtil.getInstance().setHeight(25),
//              alignment: Alignment.bottomLeft,
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: <Widget>[
//                  Row(
//                    children: <Widget>[
//                      CommonText.text12('参与人数：', color: UIData.lightGreyColor),
//                      CommonText.text12((info?.commitCount ?? 0).toString(), color: UIData.lightGreyColor),
//                      CommonText.text12('人', color: UIData.lightGreyColor),
//                    ],
//                  ),
//                  StadiumOutlineButton('去投票')
//                ],
//              ),
//            )
//          ],
//        ),
//      ),
//      onTap: () {
////        info?.logo = null; //测试数据
//        stateModel.communityActivityGetH5(info?.id, callBack: (String url) {
//          Navigate.toNewPage(HtmlPage(url, info?.name,
//              toShare: true,
//              thumbImageUrl: StringsHelper.isNotEmpty(info?.logo)
//                  ? HttpOptions.showPhotoUrl(info?.logo)
//                  : '${HttpOptions.urlAppDownloadImage}${UIData.imageVoteDefaultHomePage}'));
//        });
//      },
//    );
//  }
//
//  //问卷调查模块
//  Widget _buildQuestionnaire() {
//    return ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
//      return (model.questionnaireHomePageList != null && model.questionnaireHomePageList.length > 0)
//          ? Container(
//              color: UIData.primaryColor,
//              padding: EdgeInsets.only(bottom: UIData.spaceSize16),
//              child: Container(
//                height: ScreenUtil.getInstance().setHeight(190),
//                margin: EdgeInsets.only(left: UIData.spaceSize16, right: UIData.spaceSize16),
//                child: CommonShadowContainer(
//                  padding: EdgeInsets.only(left: UIData.spaceSize8, right: UIData.spaceSize8),
//                  offsetY: 1.0,
//                  blurRadius: 10.0,
//                  child: (stateModel.questionnaireHomePageList == null ||
//                          stateModel.questionnaireHomePageList.length == 0)
//                      ? Container()
//                      : Swiper(
//                          autoplay: stateModel.questionnaireAutoPlay,
//                          loop: (model?.questionnaireHomePageList?.length ?? 0) > 1,
//                          itemBuilder: (BuildContext context, int index) {
//                            return _buildQuestionnaireCard(model.questionnaireHomePageList[index]);
//                          },
//                          itemCount: model.questionnaireHomePageList?.length ?? 0),
//                ),
//              ),
//            )
//          : Container();
//    });
//  }
//
//  //问卷调查item
//  Widget _buildQuestionnaireCard(ActivityInfo info) {
////    LogUtils.printLog('投票图片：'+'${HttpOptions.urlAppDownload}${UIData.imageVoteDefaultHomePage}');
//    return GestureDetector(
//      child: Container(
//        height: ScreenUtil.getInstance().setHeight(190),
//        child: Column(
//          mainAxisSize: MainAxisSize.min,
//          crossAxisAlignment: CrossAxisAlignment.stretch,
//          children: <Widget>[
//            SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
//            Container(
//              height: ScreenUtil.getInstance().setHeight(125),
////              width: ScreenUtil.getInstance().setWidth(300),
//              child: FittedBox(
//                fit: BoxFit.cover,
//                alignment: Alignment.center,
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
//              ),
//            ),
//            Container(
//                height: ScreenUtil.getInstance().setHeight(20),
//                alignment: Alignment.bottomLeft,
//                child: CommonText.darkGrey14Text(info?.name ?? '')),
////                    SizedBox(height: UIData.spaceSize2),
//            Container(
//              height: ScreenUtil.getInstance().setHeight(25),
//              alignment: Alignment.bottomLeft,
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: <Widget>[
//                  Row(
//                    children: <Widget>[
//                      CommonText.text12('参与人数：', color: UIData.lightGreyColor),
//                      CommonText.text12((info?.commitCount ?? 0).toString(), color: UIData.lightGreyColor),
//                      CommonText.text12('人', color: UIData.lightGreyColor),
//                    ],
//                  ),
//                  StadiumOutlineButton('去参与')
//                ],
//              ),
//            )
//          ],
//        ),
//      ),
//      onTap: () {
//        stateModel.communityActivityGetH5(info?.id, callBack: (String url) {
//          Navigate.toNewPage(HtmlPage(url, info?.name,
//              toShare: true,
//              thumbImageUrl: StringsHelper.isNotEmpty(info?.logo)
//                  ? HttpOptions.showPhotoUrl(info?.logo)
//                  : '${HttpOptions.urlAppDownloadImage}${UIData.imageQuestionnaireDefaultHomePage}'));
//        });
//      },
//    );
//  }
//
//  //社区资讯pgc模块
//  Widget _buildPgc() {
//    return ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
//      return (model.pgcHomePageList != null && model.pgcHomePageList.length > 0)
//          ? Container(
//              color: UIData.primaryColor,
//              padding: EdgeInsets.only(bottom: UIData.spaceSize16),
//              child: Container(
//                height: ScreenUtil.getInstance().setHeight(140),
//                margin: EdgeInsets.only(left: UIData.spaceSize16, right: UIData.spaceSize16),
//                child: CommonShadowContainer(
////                  padding: EdgeInsets.only(left: UIData.spaceSize8, right: UIData.spaceSize8),
//                  offsetY: 1.0,
//                  blurRadius: 10.0,
//                  child: (stateModel.pgcHomePageList == null || stateModel.pgcHomePageList.length == 0)
//                      ? Container()
//                      : Swiper(
//                          autoplay: stateModel.pgcAutoPlay,
//                          loop: (model?.pgcHomePageList?.length ?? 0) > 1,
//                          itemBuilder: (BuildContext context, int index) {
//                            PgcInfomationInfo info = model?.pgcHomePageList[index];
////                      return _buildQuestionnaireCard(model.questionnaireHomePageList[index]);
////                      PgcInfomationListModel model = PgcInfomationListModel();
////                      model.isBulkCollectOperation = false;
//                            return PgcInfomationItem(info, PgcInfomationListModel());
//                          },
//                          itemCount: model.pgcHomePageList?.length ?? 0),
//                ),
//              ),
//            )
//          : Container();
//    });
//  }
//
//  //集市模块
//  Widget _buildMarket() {
//    return ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
//      return (model.marketHomePageList != null && model.marketHomePageList.length > 0)
//          ? Container(
//              color: UIData.primaryColor,
//              padding: EdgeInsets.only(bottom: UIData.spaceSize16),
//              child: Container(
//                height: ScreenUtil.getInstance().setHeight(210),
//                margin: EdgeInsets.only(left: UIData.spaceSize16, right: UIData.spaceSize16),
//                child: CommonShadowContainer(
////                padding: EdgeInsets.only(left: UIData.spaceSize8, right: UIData.spaceSize8),
//                  offsetY: 1.0,
//                  blurRadius: 10.0,
//                  child: (stateModel.marketHomePageList == null || stateModel.marketHomePageList.length == 0)
//                      ? Container()
//                      : Swiper(
//                          autoplay: stateModel.marketAutoPlay,
//                          loop: (model?.marketHomePageList?.length ?? 0) > 1,
//                          itemBuilder: (BuildContext context, int index) {
//                            WareDetailModel info = model?.marketHomePageList[index];
////                      return _buildQuestionnaireCard(model.questionnaireHomePageList[index]);
////                      PgcInfomationListModel model = PgcInfomationListModel();
////                      model.isBulkCollectOperation = false;
//                            return MarketItem(info, MarketListModel(), fromHome: true);
//                          },
//                          itemCount: model.marketHomePageList?.length ?? 0),
//                ),
//              ),
//            )
//          : Container();
//    });
//  }
//
//  ///
//  /// 底线
//  ///
//  Widget _buildBottomLine() {
//    return Container(
//      margin: EdgeInsets.only(bottom: UIData.spaceSize40, top: UIData.spaceSize16),
//      alignment: Alignment.center,
//      child: CommonText.lighterGrey12Text('——  我是有底线的  ——'),
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
//      return CommonScaffold(
//        showLeftButton: false,
//        appTitle: HomeLocationButton(),
//        appBarActions: [
////        HomeScanButton(),
//          HomeMessageButton()
//        ],
//        bodyData: ListView(
//          children: <Widget>[
//            _buildSwiper(),
//            _buildPropertyNotice(),
//            _buildFirstLine(),
//            _buildSecondLine(),
//            _buildCustomerService(),
////            Visibility(
////                visible: stateModel.customerType == 2 && !stateModel.uncertifiedDefault,
////                child:
//            Column(
//              children: <Widget>[
////                  _buildPropertyNotice(),
////                  CommonFullScaleDivider(),
//                Visibility(
//                    child: _buildCommunityActivityTop('社区活动', model.activityHomePageList,
//                        onTap: () => Navigate.toNewPage(CommunityActivityPage())),
//                    visible: stateModel.customerType == 2 && stateModel.hasHouse),
//                Visibility(
//                    child: _buildCommunityActivity(),
//                    visible: stateModel.customerType == 2 && stateModel.hasHouse),
//
//                Visibility(
//                    child: _buildCommunityActivityTop('社区资讯', model.pgcHomePageList, onTap: () {
//                      if (stateModel.defaultProjectId == null) {
//                        CommonToast.show(type: ToastIconType.INFO, msg: '请先选择社区');
//                      } else {
//                        Navigate.toNewPage(PgcInfomationListPage());
//                      }
//                    }),
//                    visible: stateModel.defaultProjectId != null),
//                Visibility(child: _buildPgc(), visible: stateModel.defaultProjectId != null),
//                Visibility(
//                    child: _buildCommunityActivityTop('邻里集市', model.marketHomePageList, onTap: () async {
//                      SharedPreferences prefs = await SharedPreferencesKey.globalPrefs;
////                      prefs.setBool(SharedPreferencesKey.KEY_SHOW_MARKET_STATEMENT, true); //测试数据
//                      bool showMarketStatement =
//                          prefs.getBool(SharedPreferencesKey.KEY_SHOW_MARKET_STATEMENT) ?? true;
//                      if (showMarketStatement) {
//                        CommonDialog.showAlertDialog(context,
//                            title: '邻里集市免责申明',
//                            content: StatefulBuilder(
//                                key: _marketStatementDialogKey,
//                                builder: (context, state) {
//                                  return ListView(
//                                    shrinkWrap: true,
//                                    children: <Widget>[
//                                      Container(
//                                        padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize16),
//                                        child: CommonText.darkGrey14Text(stateModel.marketStatement ?? '',
//                                            height: 1.2, overflow: TextOverflow.fade),
//                                      ),
//                                      Container(
//                                        padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize8),
//                                        child: CommonCheckBox(
//                                            text: '我已充分了解以上申明，下次不再提示',
//                                            fontSize: UIData.fontSize12,
//                                            value: _marketStatementCheck,
//                                            onChanged: (value) {
//                                              _marketStatementDialogKey.currentState.setState(() {
//                                                _marketStatementCheck = value;
////                                          prefs.setBool(SharedPreferencesKey.KEY_MARKET_STATEMENT, !value);
//                                              });
//                                            }),
//                                      )
//                                    ],
//                                  );
//                                }),
//                            showNegativeBtn: false,
//                            positiveBtnText: '我知道了', onConfirm: () {
//                          if (_marketStatementCheck) {
//                            prefs.setBool(SharedPreferencesKey.KEY_SHOW_MARKET_STATEMENT, false);
//                            _marketStatementCheck = false;
//                          }
//                          Navigate.toNewPage(MarketListPage());
//                        });
//                      } else {
//                        Navigate.toNewPage(MarketListPage());
//                      }
//                    }),
//                    visible: stateModel.defaultProjectId != null),
//                Visibility(child: _buildMarket(), visible: stateModel.defaultProjectId != null),
//
//                Visibility(
//                    child: _buildCommunityActivityTop('投票', model.voteHomePageList,
//                        onTap: () =>
//                            Navigate.checkCustomerCertified(context, CommunityActivityPage(activityType: 2))),
//                    visible: stateModel.customerType == 2 && stateModel.hasHouse),
//                Visibility(child: _buildVote(), visible: stateModel.customerType == 2 && stateModel.hasHouse),
//
//                Visibility(
//                    child: _buildCommunityActivityTop('问卷调查', model.questionnaireHomePageList,
//                        onTap: () =>
//                            Navigate.checkCustomerCertified(context, CommunityActivityPage(activityType: 1))),
//                    visible: stateModel.customerType == 2 && stateModel.hasHouse),
//                Visibility(
//                    child: _buildQuestionnaire(), visible: stateModel.customerType == 2 && stateModel.hasHouse),
//              ],
//            ),
////            ),
////            Container(height: UIData.spaceSize16, color: UIData.primaryColor),
//            _buildBottomLine(),
//          ],
//        ),
//      );
//    });
//  }
//}
