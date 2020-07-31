import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UIData {
  //color
  static const primaryColor = Colors.white;
  static const themeBgColor = const Color(0xFFF9320F);
  static const themeBgColor70 = const Color(0x4DF9320F);
  static const scaffoldBgColor = const Color(0xFFF5F5F5);
  static const blackColor = const Color(0xFF000000);
  static const lightestGreyColor = const Color(0xFFC9C9C9);
  static const lightestGreyColor70 = const Color(0x4DC9C9C9);
  static const lighterGreyColor = const Color(0xFFC8C7CC);
  static const lightGreyColor = const Color(0xFF999999);
  static const greyColor = const Color(0xFF555555);
  static const darkGreyColor = const Color(0xFF333333);
  static const iconGreyColor = const Color(0xFFB2B2B2);
  static const opacity5BlackColor = const Color(0x0c000000);
  static const opacity20WhiteColor = const Color(0x33FFFFFF);
  static const opacity20BlueColor = const Color(0x3330B7E5);
  static const opacity50BlackColor = const Color(0x7F000000);
  static const underlineBlueColor = const Color(0xFF7ED3EF);
  static const lightBlueColor = const Color(0xFF7ED3EF);
  static const pgcBlueColor = const Color(0xFFEEFAFF);
  static const pgcBlueTextColor = const Color(0xFF80CAE9);
  static const lighterBlueColor = const Color(0xFFDBEFFF);
  static const indicatorBlueColor = const Color(0xFF1B82D1);
  static const greenColor = Colors.green;
  static const redColor = const Color(0xFFFF6969);
  static const pgcRedColor = const Color(0xFFFFEAE6);
  static const pgcRedTextColor = const Color(0xFFF93D1C);
  static const redColor60 = const Color(0x99FF6969);
  static const redGradient1 = const Color(0xFFF10001);
  static const redGradient2 = const Color(0xFFF7250B);
  static const redGradient3 = const Color(0xFFFF5216);
  static const redGradient4 = const Color(0xFFFF6E1B);
  static const redGradient5 = const Color(0xFFFF8F1B);
  static const greyGradient1 = const Color(0xFF2C2C2C);
  static const greyGradient70 = const Color(0x4D2C2C2C);
  static const greyGradient2 = const Color(0xFF525252);
  static const goldenGradient1 = const Color(0xFFC39D5A);
  static const goldenGradient2 = const Color(0xFFE0C38A);
  static const lightRedColor = const Color(0xFFEA2C25);
  static const audioBtnRedColor = const Color(0xFFFFEAE4);
  static const lighterRedColor = const Color(0xFFFFCBC9);
  static const lightestRedColor = const Color(0xFFFFEDEC);
  static const lightestRedColor2 = const Color(0xFFFEF5F6);
  static const orangeColor = const Color(0xFFFC8C07);
  static const lightOrangeColor = const Color(0xFFFC8C07);
  static const dividerColor = const Color(0xFFECECEC);
  static const yellowColor = const Color(0xFFFF9200);
  static const lighterYellowColor = const Color(0xFFFEFCEB);
  static const Color radius_solid_background = const Color(0xFFDBEFFF);

  static const lighterGreyGradient1 = const Color(0xffa0a0a0);
  static const lighterGreyGradient2 = const Color(0xffd0d0d0);

  static const lighterGreyGradient = [lighterGreyGradient1, lighterGreyGradient2];

  static const marketOrangeColor = const Color(0xFFF5B346);
  static const marketGreenColor = const Color(0xFF66CC33);
  static const marketBlueColor = const Color(0xFF5390E0);
  static const marketVioletColor = const Color(0xFFB397F9);
  static const marketGreyColor = const Color(0xFF999999);

  static double fontSize9 = ScreenUtil(allowFontScaling: true).setSp(9);
  static double fontSize10 = ScreenUtil(allowFontScaling: true).setSp(10);
  static double fontSize11 = ScreenUtil(allowFontScaling: true).setSp(11);
  static double fontSize12 = ScreenUtil(allowFontScaling: true).setSp(12);
  static double fontSize13 = ScreenUtil(allowFontScaling: true).setSp(13);
  static double fontSize14 = ScreenUtil(allowFontScaling: true).setSp(14);
  static double fontSize15 = ScreenUtil(allowFontScaling: true).setSp(15);
  static double fontSize16 = ScreenUtil(allowFontScaling: true).setSp(16);
  static double fontSize17 = ScreenUtil(allowFontScaling: true).setSp(17);
  static double fontSize18 = ScreenUtil(allowFontScaling: true).setSp(18);
  static double fontSize20 = ScreenUtil(allowFontScaling: true).setSp(20);
  static double fontSize24 = ScreenUtil(allowFontScaling: true).setSp(24);
  static double fontSize26 = ScreenUtil(allowFontScaling: true).setSp(26);
  static double fontSize30 = ScreenUtil(allowFontScaling: true).setSp(30);
  static double fontSize50 = ScreenUtil(allowFontScaling: true).setSp(50);
  static double spaceSize1 = ScreenUtil.getInstance().setWidth(1);
  static double spaceSize2 = ScreenUtil.getInstance().setWidth(2);
  static double spaceSize3 = ScreenUtil.getInstance().setWidth(3);
  static double spaceSize4 = ScreenUtil.getInstance().setWidth(4);
  static double spaceSize6 = ScreenUtil.getInstance().setWidth(6);
  static double spaceSize8 = ScreenUtil.getInstance().setWidth(8);
  static double spaceSize10 = ScreenUtil.getInstance().setWidth(10);
  static double spaceSize12 = ScreenUtil.getInstance().setWidth(12);
  static double spaceSize14 = ScreenUtil.getInstance().setWidth(14);
  static double spaceSize15 = ScreenUtil.getInstance().setWidth(15);
  static double spaceSize16 = ScreenUtil.getInstance().setWidth(16);
  static double spaceSize18 = ScreenUtil.getInstance().setWidth(18);
  static double spaceSize20 = ScreenUtil.getInstance().setWidth(20);
  static double spaceSize24 = ScreenUtil.getInstance().setWidth(24);
  static double spaceSize26 = ScreenUtil.getInstance().setWidth(26);
  static double spaceSize30 = ScreenUtil.getInstance().setWidth(30);
  static double spaceSize40 = ScreenUtil.getInstance().setWidth(40);
  static double spaceSize48 = ScreenUtil.getInstance().setWidth(48);
  static double spaceSize50 = ScreenUtil.getInstance().setWidth(50);
  static double spaceSize60 = ScreenUtil.getInstance().setWidth(60);
  static double spaceSize70 = ScreenUtil.getInstance().setWidth(70);
  static double spaceSize80 = ScreenUtil.getInstance().setWidth(80);
  static double spaceSize90 = ScreenUtil.getInstance().setWidth(90);
  static double spaceSize100 = ScreenUtil.getInstance().setWidth(100);
  static double spaceSize120 = ScreenUtil.getInstance().setWidth(120);
  static double spaceSize130 = ScreenUtil.getInstance().setWidth(130);
  static double spaceSize150 = ScreenUtil.getInstance().setWidth(150);
  static double spaceSize200 = ScreenUtil.getInstance().setWidth(200);
  static double spaceSize400 = ScreenUtil.getInstance().setWidth(400);

  //images
  static const String imageDir = "assets/images";
  static const String imageDirHome = "$imageDir/home"; //首页页面图标
  static const String imageDirService = "$imageDir/service"; //服务页面图标
  static const String iconLauncher = '$imageDir/ic_launcher.png';
  static const String iconLauncherDemonstration = '$imageDir/ic_launcher_demo.png';
  static const String iconMerchantsLogo = '$imageDir/merchants_logo.png';
  static const String audio_mic1 = '$imageDir/audio_mic1.png';
  static const String audio_mic2 = '$imageDir/audio_mic2.png';
  static const String audio_mic3 = '$imageDir/audio_mic3.png';
  static const String audio_mic4 = '$imageDir/audio_mic4.png';
  static const String audio_mic5 = '$imageDir/audio_mic5.png';
  static const String icon_voice1 = '$imageDir/icon_voice1.png';
  static const String icon_voice2 = '$imageDir/icon_voice2.png';
  static const String icon_voice3 = '$imageDir/icon_voice3.png';
  static const String takePhoto = '$imageDir/take_photo.png';
  static const String imageWelcome = '$imageDir/welcome.jpg';
  static const String imageAbout = '$imageDir/image_about.jpg';
  static const String imageIntro1 = '$imageDir/intro1.jpg';
  static const String imageIntro2 = '$imageDir/intro2.jpg';
  static const String imageIntro3 = '$imageDir/intro3.jpg';
  static const String imageIntro4 = '$imageDir/intro4.jpg';
  static const String imageLoginLogo = '$imageDir/login_logo.png';
  static const String imageImageLoading = '$imageDir/image_loading.jpg';
  static const String imageImageLoadFail = '$imageDir/image_load_fail.jpg';
  static const String imagePhone = '$imageDir/image_phone.png';
  static const String imageLoading = '$imageDir/page_loading.jpg';
  static const String imageLoadedFailed = '$imageDir/loaded_failed.png';
  static const String imageNoData = '$imageDir/nodata.png';
  static const String imageLoadingDetail = '$imageDir/page_loading.png';
  static const String iconHomeNormal = '$imageDir/icon_home_normal.png';
  static const String iconHomeSelected = '$imageDir/icon_home_selected.png';
  static const String iconServiceNormal = '$imageDir/icon_service_normal.png';
  static const String iconServiceSelected = '$imageDir/icon_service_selected.png';
  static const String iconOpenDoor = '$imageDir/icon_open.png';
  static const String iconMallNormal = '$imageDir/icon_mall_normal.png';
  static const String iconMallSelected = '$imageDir/icon_mall_selected.png';
  static const String iconMeNormal = '$imageDir/icon_me_normal.png';
  static const String iconMeSelected = '$imageDir/icon_me_selected.png';
  static const String imageLocation = '$imageDir/image_location.png';
  static const String iconScan = '$imageDir/icon_scan.png';
  static const String iconMessage = '$imageDir/icon_message.png';
  static const String iconRedCircle = '$imageDir/icon_red_circle.png';
  static const String iconRedCircle2 = '$imageDir/icon_red_circle2.png';
  static const String imageBanner1 = '$imageDir/banner1.jpg';
  static const String imageBanner2 = '$imageDir/banner2.jpg';
  static const String imageBanner3 = '$imageDir/banner3.jpg';
  static const String imageBanner4 = '$imageDir/banner4.jpg';
  static const String imageBannerFrontBg = '$imageDir/banner_front_bg.png';
  static const String iconApplianceInstall = '$imageDir/icon_appliance_install.png';
  static const String iconAdviceSuggestionsSmall = '$imageDir/icon_advice_suggestions_small.png'; //首页-咨询建议
  static const String imageZhaoxiaotong = '$imageDir/image_zhaoxiaotong.png';
  static const String imageParkingMine = '$imageDir/image_parking_mine.png';

//  static const String iconTel = '$imageDir/icon_tel.png';
  static const String imagePortrait = '$imageDir/image_portrait.png';
  static const String imageInDevelopment = '$imageDir/in_development.jpg'; //建设中
  static const String imageInUpgrading = '$imageDir/upgrading.png'; //升级中
  static const String imageTouristNoRecord = '$imageDir/tourist_no_record.png';
  static const String imageHouseBg = '$imageDir/house_bg.jpg';
  static const String imageHouseOwner = '$imageDir/houser_owner.png';
  static const String imageHouseFamilyMember = '$imageDir/house_family_member.png';
  static const String imagePayServiceDefault = '$imageDir/pay_service_image_default.jpg';
  static const String imagePayServiceDetailDefault = '$imageDir/pay_service_detail_image_default.jpg';
  static const String imageRoundClose = '$imageDir/round_close.png';
  static const String imageOwner = '$imageDir/image_owner.png'; //房屋认证——业主
  static const String imageMember = '$imageDir/image_member.png'; //房屋认证——业主成员
  static const String imageTenant = '$imageDir/image_tenant.png'; //房屋认证——租户
  static const String imageTenantMember = '$imageDir/image_tenant_member.png'; //房屋认证——租户成员
  static const String imageCarNoBg = '$imageDir/car_number_bg.png'; //车牌号键盘的输入框背景
  static const String imageBannerDefaultNoData = '$imageDir/image_banner_default_nodata.jpg';
  static const String imageBannerDefaultLoading = '$imageDir/image_banner_default_loading.jpg';
  static const String imageBannerDefaultFailed = '$imageDir/image_banner_default_failed.jpg';
  static const String imageQuestionnaireDefaultHomePage = 'dcwj.png'; //调查问卷首页默认图片
  static const String imageVoteDefaultHomePage = 'qmtp.png'; //投票首页默认图片
  static const String imageCommunityDefaultHomePage = 'sqhd.jpg'; //社区活动首页默认图片
  static const String imageQuestionnaireDefault = 'dcwj_default.jpg'; //调查问卷列表默认图片
  static const String imageVoteDefault = 'tp_default.jpg'; //投票列表默认图片
  static const String imageCommunityDefault = 'sqhd_default.jpg'; //社区活动列表默认图片
  static const String imageError = '$imageDir/error.png'; //错误页面提示
  static const String imageDownloadDemonstration = '$imageDir/code_demonstration.png';
  static const String imageDownloadProductionIos = '$imageDir/code_production_ios.png'; //ios的下载地址（生产环境）
  static const String imageUpgradeBg = '$imageDir/upgrade_bg.png'; //应用内升级提示框
  static const String imageWechatSubscriQrcode = '$imageDir/image_wechat_subscri_qrcode.png'; //到家汇微信公众号二维码
  static const String imageAdDialog = '$imageDir/image_ad_dialog.png'; //首页弹框广告图

  //*******************首页************************//
  static const String iconMyHouse = '$imageDirHome/icon_building.png'; //首页-我的房屋
  static const String iconWallet = '$imageDirHome/icon_wallet.png'; //首页-到家钱包
//  static const String iconHousePurchasing = '$imageDirHome/icon_house_purchasing.png'; //首页-房屋租售
  static const String iconParkingPayment = '$imageDirHome/icon_parking_payment.png'; //首页-停车缴费
  static const String iconPropertyPayment = '$imageDirHome/icon_property_payment.png'; //首页-物管缴费
  static const String iconMore = '$imageDirHome/icon_more.png'; //首页-全部
  static const String iconGreySquareLogo = '$imageDirHome/icon__grey_square_logo.png'; //首页-默认方形Logo
  static const String iconGreyCircularLogo = '$imageDirHome/icon__grey_circular_logo.png'; //首页-默认圆形Logo
  static const String imageNoNetwork = '$imageDirHome/image_no_network.png'; //首页-没有网络或加载失败图
  //*******************首页************************//

  //*******************服务************************//
  static const String iconAccessCard = '$imageDirService/icon_access_card.png'; //门禁卡
  static const String iconAdviceSuggestion = '$imageDirService/icon_advice_suggestions.png'; //建议咨询
  static const String iconApplianceRepairService = '$imageDirService/icon_appliance_repair_service.png'; //家政维修
  static const String iconApplicationInstallService =
      '$imageDirService/icon_application_install_service.png'; //家电安装
  static const String iconAroundInfo = '$imageDirService/icon_around_info.png'; //周边信息
  static const String iconBrandName = '$imageDirService/icon_brand_and_name.png'; //水牌名牌
  static const String iconCommunityActivity = '$imageDirService/icon_community_activity.png'; //社区活动
  static const String iconComplaintService = '$imageDirService/icon_complaint_service.png'; //投诉
  static const String iconRepairService = '$imageDirService/icon_create_repair_cust.png'; //室内维修
  static const String iconDecorationPass = '$imageDirService/icon_decoration_pass.png'; //装修工出入证
  static const String iconGoodsPassService = '$imageDirService/icon_goods_passing_service.png'; //物品放行
  static const String iconHealth160Service = '$imageDirService/icon_health160_service.png'; //预约挂号
  static const String iconBeeService = '$imageDirService/icon_bee_service.png'; //充值中心

  static const String iconHotWorkApplication = '$imageDirService/icon_hot_work_application.png'; //动火申请
  static const String iconHouseRentSale = '$imageDirService/icon_house_rent_sale.png'; //房屋租售
  static const String iconHouseRepairService = '$imageDirService/icon_house_repair_service.png'; //房屋维修
  static const String iconHousekeepingService = '$imageDirService/icon_housekeeping_service.png'; //家政保洁
  static const String iconMyHouseService = '$imageDirService/icon_my_house_service.png'; //我的房屋
  static const String iconOfficeWithdrawal = '$imageDirService/icon_office_withdrawal.png'; //写字楼退租
  static const String iconOtherService = '$imageDirService/icon_other_service.png'; //其他服务
  static const String iconParkingManagement = '$imageDirService/icon_parking_management.png'; //停车办理
  static const String iconParkingPaymentService = '$imageDirService/icon_parking_payment_service.png'; //停车缴费
  static const String iconPraiseService = '$imageDirService/icon_praise_service.png'; //表扬
//  static const String iconPrepaidRefill = '$imageDirService/icon_prepaid_refill.png'; //话费充值
  static const String iconPropertyChange = '$imageDirService/icon_property_change.png'; //产权变更
  static const String iconPropertyPaymentService = '$imageDirService/icon_property_payment_service.png'; //物管缴费
  static const String iconQuestionnaire = '$imageDirService/icon_questionnaire.png'; //调查问卷
  static const String iconReportObstacle = '$imageDirService/icon_report_obstacle.png'; //公区报障
  static const String iconTenantSettled = '$imageDirService/icon_tenant_settled.png'; //租户入驻
  static const String iconVisitorPass = '$imageDirService/icon_visitor_pass.png'; //访客放行
  static const String iconVote = '$imageDirService/icon_vote.png'; //投票
  static const String iconWalletService = '$imageDirService/icon_wallet_service.png'; //到家钱包
  static const String iconAccessPass = '$imageDirService/icon_access_pass.png'; //社区通行
  static const String iconDecorationApplication = '$imageDirService/icon_decoration_application.png'; //装修申请
  static const String iconMeetingRoomReservationService =
      '$imageDirService/icon_meeting_room_reservation_service.png'; //会议室预定
  static const String iconNewHouseJoininService =
      '$imageDirService/icon_new_house_joinin.png'; //新房入伙
  static const String iconPcgInfomation = '$imageDirService/icon_pcg_infomation.png'; //PGC
  static const String iconMarket = '$imageDirService/icon_market.png'; //邻里集市

  static const String iconBusinessActivities = '$imageDirService/icon_business_activities.png'; //商业活动
  static const String iconCommunityBusiness = '$imageDirService/icon_community_business.png'; //社区商圈
  static const String iconCommunityTopics = '$imageDirService/icon_community_topics.png'; //社区话题
  static const String iconCommunityShuoShuo = '$imageDirService/icon_community_shuoshuo.png'; //说说

  static const String iconVisitorAppointment = '$imageDirService/icon_visitor_appointment_service.png'; //预约到访

  //*******************服务************************//

//  static const String iconConvenienceServices = '$imageDir/icon_convenience_services.png'; //便民服务
//  static const String iconPropertyNotice = '$imageDir/icon_property_notice.png'; //物业通知
//  static const String iconTopic = '$imageDir/icon_topic.png'; //话题
//  static const String iconMarket = '$imageDir/icon_market.png'; //市集
//  static const String iconCurrentAffairsFocus = '$imageDir/icon_current_affairs_focus.png'; //时事焦点
//  static const String iconPropertyInfomation = '$imageDir/icon_property_infomation.png'; //物业资讯
//  static const String iconVoteSmall = '$imageDir/icon_vote_small.png'; //首页投票
//  static const String iconActivityRegistration = '$imageDir/icon_activity_registration.png'; //活动报名
//  static const String iconNameplate = '$imageDir/icon_nameplate.png'; //水牌名牌
  //*******************服务************************//

  //*******************社区活动************************//
  static const String imageActivityDefault = '$imageDir/image_activity_default.jpg'; //活动列表默认图片
  static const String imageActivityEnded = '$imageDir/image_activity_ended.png'; //活动列表结束
  //*******************社区活动************************//

  //*******************分享************************//
  static const String imageShareWechat = '$imageDir/share_wechat.png';
  static const String imageShareWechatMoments = '$imageDir/share_wechat_moments.png';
  static const String imageShareWechatFavorite = '$imageDir/share_wechat_favorite.png';
  static const String imageShareQQ = '$imageDir/share_qq.png';
  static const String imageShareQQZone = '$imageDir/share_qq_zone.png';
  static const String imageShareSinaWeibo = '$imageDir/share_sina_weibo.png';

  //*******************分享************************//

  static Icon iconTick =
      Icon(IconData(0xe6e7, fontFamily: 'iconfont'), color: themeBgColor, size: UIData.fontSize14);
  static Icon iconEntry =
      Icon(IconData(0xe6ed, fontFamily: 'iconfont'), color: darkGreyColor, size: UIData.fontSize14);
  static Icon iconLocation =
      Icon(IconData(0xe6f1, fontFamily: 'iconfont'), color: lighterGreyColor, size: UIData.fontSize14);
  static Icon iconChangeDefaultHouse =
      Icon(IconData(0xe711, fontFamily: 'iconfont'), color: redColor, size: UIData.fontSize18);
  static Icon iconMoveOut =
      Icon(IconData(0xe713, fontFamily: 'iconfont'), color: greyColor, size: UIData.fontSize18);
  static Icon iconMemberNumber =
      Icon(IconData(0xe716, fontFamily: 'iconfont'), color: lighterGreyColor, size: UIData.fontSize18);

  static const IconData iconDataStartSelected = IconData(0xe6f4, fontFamily: 'iconfont'); //星星-选中
  static const IconData iconDataStartUnselected = IconData(0xe6f3, fontFamily: 'iconfont'); //星星-未选中

  static Icon iconMore2 =
      Icon(IconData(0xe6ec, fontFamily: 'iconfont'), color: darkGreyColor, size: UIData.fontSize14); //更多
  static Icon iconAdd =
      Icon(IconData(0xe6f2, fontFamily: 'iconfont'), color: darkGreyColor, size: UIData.fontSize14);

  static Icon iconCheckBoxSelected =
      Icon(IconData(0xe6df, fontFamily: 'iconfont'), color: themeBgColor, size: UIData.fontSize18); //选中
  static Icon iconCheckBoxNormal =
      Icon(IconData(0xe6e0, fontFamily: 'iconfont'), color: lightGreyColor, size: UIData.fontSize18); //
  static const Icon iconFilter =
      Icon(IconData(0xe6e2, fontFamily: 'iconfont'), color: darkGreyColor, size: 20); //筛选（右上角）
//  static const Icon iconPhone = Icon(IconData(0xe71e, fontFamily: 'iconfont'),color: themeBgColor, size: 20); //电话
  static const Icon iconDiamonds =
      Icon(IconData(0xe705, fontFamily: 'iconfont'), color: primaryColor, size: 14); //套餐钻石
  static const Icon iconAttachment =
      Icon(IconData(0xe6eb, fontFamily: 'iconfont'), color: themeBgColor, size: 15); //附件
  static const Icon iconCarNoKeyboardDelete =
      Icon(IconData(0xe722, fontFamily: 'iconfont'), color: greyColor, size: 15); //车牌号键盘的删除
  static Icon iconInfoOutline = Icon(Icons.info_outline, color: themeBgColor, size: fontSize18); //圈着的感叹号
  static Icon iconCloseOutline =
      Icon(IconData(0xe632, fontFamily: 'iconfont'), color: greyColor, size: 18); //圈圈的叉叉

  static const String imageChatMineBg = '$imageDir/icon_chat_mine_bg.png';//聊天页面我的背景图
  static const String imageChatOtherBg = '$imageDir/icon_chat_other_bg.png';


  //*************************首页图标******************************//
  static Icon iconTel =
      Icon(IconData(0xe7ec, fontFamily: 'iconfont'), color: indicatorBlueColor, size: 28); //首页招小通电话
  //*************************首页图标******************************//
  //*************************消息中心图标******************************//
  static const Icon iconMessageWorkOrder =
      Icon(IconData(0xe704, fontFamily: 'iconfont'), color: orangeColor, size: 50); //工单消息
  static const Icon iconMessageBusiness =
      Icon(IconData(0xe708, fontFamily: 'iconfont'), color: redColor, size: 50); //业务办理消息
  static const Icon iconMessageOther =
      Icon(IconData(0xe7bd, fontFamily: 'iconfont'), color: const Color(0xFF9370DB), size: 50); //其他消息
  static const Icon iconMessageInteraction =
      Icon(IconData(0xe7b7, fontFamily: 'iconfont'), color: const Color(0xFF54C8EF), size: 50); //互动消息
  static const Icon iconMessageMarket =
      Icon(IconData(0xe7ba, fontFamily: 'iconfont'), color: const Color(0xFFFF9338), size: 50); //集市聊天
  //*************************消息中心图标******************************//

  //**************************开门图标*********************************//
  static const IconData iconDoorDevice = IconData(0xe786, fontFamily: 'iconfont'); //一键开门
  static const String iconDoorBackground = '$imageDir/open_door_bg.jpg'; //一键开门背景图(弃用)
  static const String imageOpenDoorBanner = '$imageDir/image_open_door_banner.png'; //一键开门banner
  static const String imageOpenDoorBtn = '$imageDir/image_open_door_btn.png'; //一键开门常用门开门按钮
  //**************************开门图标*********************************//

  //**************************集市图标*********************************//
  static const String imageMarketAdd = '$imageDir/image_market_add.png';
  static const Icon iconMarketXSY =
    Icon(IconData(0xe82a, fontFamily: 'iconfont'), color: const Color(0xFFF5B346), size: 30); //集市小生意
  static const Icon iconMarketES =
    Icon(IconData(0xe82c, fontFamily: 'iconfont'), color: const Color(0xFF66CC33), size: 30); //集市二手
  static const Icon iconMarketZJ =
    Icon(IconData(0xe829, fontFamily: 'iconfont'), color: const Color(0xFF5390E0), size: 30); //集市租借
  static const Icon iconMarketZS =
    Icon(IconData(0xe82b, fontFamily: 'iconfont'), color: const Color(0xFFB397F9), size: 30); //集市赠品

  static const Icon iconMarketYK =
    Icon(IconData(0xe827, fontFamily: 'iconfont'), color: const Color(0xFF80CAE9), size: 12); //游客
  static const Icon iconMarketRZYH =
    Icon(IconData(0xe82e, fontFamily: 'iconfont'), color: const Color(0xFFFC8C07), size: 12); //认证用户
  //**************************集市图标*********************************//

  //**************************动火申请*********************************//
  static const Icon iconHotWorkPass =
      Icon(IconData(0xe773, fontFamily: 'iconfont'), color: lightGreyColor, size: 25); //动火许可证图标
  //**************************动火申请*********************************//
  //**************************pgc图标*********************************//
  static const Icon iconWenzhangliulanshu = Icon(
    IconData(0xe6e3, fontFamily: 'iconfont'),
    color: greyColor,
    size: 18,
  ); //文章浏览数
  static const Icon iconDianzan = Icon(IconData(0xe79c, fontFamily: 'iconfont'), color: greyColor, size: 18); //未点赞
  static const Icon iconDianzan2 =
      Icon(IconData(0xe79c, fontFamily: 'iconfont'), color: yellowColor, size: 18); //已经点赞
  static const Icon iconPinlun = Icon(IconData(0xe79b, fontFamily: 'iconfont'), color: greyColor, size: 18); //评论数
  //**************************pgc图标*********************************//

  static Size deviceSize = ui.window.physicalSize;

  static final tipDialogDurationTime = Duration(seconds: 2);
}
