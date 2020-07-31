import 'dart:convert';
import 'dart:io';

import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:dio/dio.dart';

//  Dio dio = new Dio(HttpOptions.getInstance);
class HttpOptions {
  static BaseOptions _options = BaseOptions(
    baseUrl: HttpOptions.baseUrl,
    connectTimeout: HttpOptions.connectTimeout,
    receiveTimeout: HttpOptions.receiveTimeout,
//      contentType:  ContentType.json
  );

  static BaseOptions get getInstance {
    return _options;
  }

  static bool get isInDebugMode {
    bool inDebugMode = false;
    assert(inDebugMode = true); //debug模式执行assert打印log
    return inDebugMode;
  }

  ///
  ///com.eshore.ubms.customer  企业版
  ///com.cmhk.uhome 商店版
  ///IOS是否运行体验版
  static bool isTrialVersion = false;

  static String baseUrl = urlTest;
  static int connectTimeout = 30000;
  static int receiveTimeout = 30000;
  static const int pageSize = 20;
  static String basicAuth = 'Basic ${base64.encode(utf8.encode('ubms-customer:ubms-customer'))}';

//  static String urlAppDownload  = "${baseUrl.replaceAll('ubms-customer/', 'template/appDownload/')}";
  static String urlAppDownloadImage = "${baseUrl.replaceAll('ubms-customer/', 'template/appDownload/images/')}";
  static String urlAppShare = "${baseUrl.replaceAll('ubms-customer/', 'template/appShare/')}";

//  static String basicAuth = 'Basic ${base64.encode(utf8.encode('ubms:ubms'))}';

//  static const String urlProduction = "http://129.204.21.131:9001/ubms-customer/"; //生产环境
  static const String urlProduction = "https://cmpss.cmpmc.com/ubms-customer/"; //生产环境
  static const String urlTest = "http://119.147.37.203:9001/ubms-customer/"; //测试环境
  static const String urlDemonstration = "http://218.17.81.123:9001/ubms-customer/"; //演示环境

  static const String _urlTaskTmp = "http://task.v1xcx.com/ubms-customer/"; //对接任务管理的环境
  static const String _urlWeQiangTmp = "http://10.19.160.140:9200/ubms-customer/"; //维强本地环境
  static const String _urlBodongTmp = "http://10.19.160.89:9200/ubms-customer/"; //博栋本地环境
  static const String _urlXUEHUI = 'http://10.19.160.52:9200/ubms-customer/'; //雪辉姐
  static const String _urlTENG = 'http://10.19.160.58:9200/ubms-customer/'; //杨腾
  static const String _urlXinBin = "http://10.19.160.19:9200/ubms-customer/"; //信斌
  static const String _urlXinBin2 = "http://2931c02c29.zicp.vip/ubms-customer/"; //信斌
  static const String _urlWenBin = "http://10.19.160.57:9200/ubms-customer/"; //闻彬
  static const String _urlShaoQin = "http://10.19.160.123:9200/ubms-customer/"; //绍钦
  static const String _urlShaoQin2 = "http://103.46.128.45:45568/ubms-customer/"; //绍钦
  static const String _urlShaoQinTest = "http://183.56.130.229:9001/ubms-customer/"; //绍钦外网
  static const String _urlCanCan = "http://10.19.160.150:9200/ubms-customer/"; //灿灿
  static const String _urlZhengZhi = "http://3038sf5682.zicp.vip:25655/ubms-customer/"; //正治
  static const String _urlXiongHao = "http://3x05z07443.qicp.vip/ubms-customer/"; //熊浩
  static const String _urlXin = "http://132.126.2.72:9200/ubms-customer/";
  static const String _urlWuHanXin = "http://31047z26o9.zicp.vip/ubms-customer/"; //鑫

  static const String _urlLiuChunMing = "http://103.46.128.45:45568/ubms-customer/"; //刘春明
  // 获取验证码（除登录获取验证码外其他获取验证码都用这个接口）
  static const String getVerificationCodeUrl = "app/verificationCode/get";

  // 验证验证码是否正确
  static const String checkVerificationCodeUrl = "app/verificationCode/verification";

  // 注册
  static const String registerUrl = "masterdata/cust/save";

  // 获取验证码前交验账号是否存在
  static const String checkMobileExistUrl = "authorize/loginCheck/checkMobileExist";

  // 获取验证码(只限于登录用)
  static const String getVerificationCodeForLoginUrl = "code/sms";

  // 手机号验证码登录操作（获取access_token）
  static const String loginUrl = "authentication/mobile";

  // 手机号密码登录操作（获取access_token）
  static const String loginByPwdUrl = "authorize/login";

  // 刷新access_token（获取refresh_token）
  static const String refreshTokenUrl = "oauth/token";

  // 获取基础用户数据
  static const String userDataUrl = "masterdata/cust/custLoginAfter";

  // 首页项目菜单（九个位置处）和服务中的菜单
  static const String menuProjectUrl = "authorize/loginCheck/getMenuListByProjectId";

  // 上报设备信息
  static const String uploadDeviceInfoUrl = "base/appLoginLog/addLog";

  // 修改手机号
  static const String changeMobileUrl = "masterdata/cust/changeMobile";

  //文案协议
  static const String agreementUrl = "base/agreementconfig/queryAgreementByProjectAndType";

  //预约挂号
  static const String healthUrl = "health/getToken";

//到家钱包
  static String purseUrl = 'external/homeMoney/authPage';

  //充值中心
  static String beeUrl = 'bee/getToken';

  //房租租售
  static const String houseShouYeUrl = "https://sz.cmpc.cn/mobile/shouye?currentPersonId=";

  //获取banner
  static const String getBannerUrl = "base/banner/listCustomerBanner";

  //周边信息
  static const String findNearListByProjectId = 'masterdata/near/findNearListByProjectId';

  //获取版本信息
  static const String getAppVersionUrl = "base/appUpdate/check";

  //获取通用广告弹框信息
  static const String getAdUrl = "base/appTips/list";

  //**************************通知和消息**********************************//
  //物业通知列表
  static const String propertyNoticeUrl = "base/managementnotice/findManagementNoticePage";

  //物业通知详情
  static const String propertyNoticeDetailUrl = "base/managementnotice/AppFindNoticeById";

  //获取消息中心列表
  static const String messageCenterUrl = "base/pushmessage/findPushMessagePageApp";

  //获取子类消息列表
  static const String messageSubUrl = "base/pushmessage/findSubMessageListApp";

  //获取子类消息列表（返回未读数量）
  static const String messageSubWithCountUrl = "base/pushmessage/findSubMessageListWithCountApp";

  //将某个消息设置为已读
  static const String setMessageReadUrl = "base/pushmessage/setAlreadyRead";

  //消息批量设置已读（用为全部标为已读）
  static const String setBatchMessageReadUrl = "base/pushmessage/batchSetAlreadyRead";

  //未读消息总数量
  static const String unReadMessageTotalCountUrl = "base/pushmessage/findCountYetReadMessage";

  //**************************通知和消息**********************************//

  //**************************待办工单**********************************//
  //待办列表
  static const String pendingOrderListUrl = 'workorder/workorder/findWorkOrderList';

  //待办详情-详情
  static const String pendingOrderDetailUrl = 'workorder/workorder/queryWorkOrderDetail';

  //待办详情-提交
  static const String processWorkTaskUrl = 'workorder/worktask/processWorkTask';

  //创建工单
  static const String createWorkOrderUrl = 'workorder/workorder/createWorkOrder';

  //创建反馈
  static const String createCustomerFeedback = 'workorder/customerfeedback/createCustomerFeedback';

  //有尝服务列表
  static const String findServiceConfigListUrl = 'workorder/serviceconfig/findServiceConfigList';

  //有偿服务详情
  static const String queryServiceConfigDetailUrl = 'workorder/serviceconfig/queryServiceConfigDetail';

  //获取节点列表
  static const String queryWorkOrderNodeListUrl = 'workorder/processmainnode/queryWorkOrderNodeList';

  //**************************待办工单end**********************************//
  //***************************产权变更***************************//
  static const String findPropertyChangeDetail = 'business/propertychange/findPropertyChangeDetail';
  static const String findPropertyChangePage = 'business/propertychange/findPropertyChangeListByCust';
  static const String createPropertyChange = 'business/propertychange/createPropertyChange';
  static const String changeStatusByCust = 'business/propertychange/changeStatusByCust';

  //***************************产权变更***************************//

  //***************************水牌名牌***************************//
  static const String createBrandName = 'business/brandname/createBrandName';
  static const String findBrandNameListByCust = 'business/brandname/findBrandNameListByCust';
  static const String findBrandNameDetailed = 'business/brandname/findBrandNameDetailed';
  static const String brandnameChangeStatusByCust = 'business/brandname/changeStatusByCust';

  //***************************水牌名牌***************************//

  //***************************停车办理***************************//
  // 停车卡我的
  static const String parkingMyList = "business/parking/findMyParkingList";

  // 停车卡客户办理记录
  static const String parkingCustList = "business/parking/findParkingListByCust";

  // 停车卡客户所有车辆
  static const String parkingCustCars = "business/parking/findCustCars";

  // 停车卡详情
  static const String parkingDetail = "business/parking/findParkingDetail";

  // 停车卡新卡申请、续租、退租接口
  static const String parkingCreate = "business/parking/createParking";

  // 停车卡编辑
  static const String parkingEdit = "business/parking/editParking";

  // 停车卡更改业务状态
  static const String changeParkingStatus = "business/parking/changeStatusByCust";

  // 停车卡获取套餐列表
  static const String parkingPrices = "business/parking/getPrices";

  // 停车卡获取套餐详情
  static const String parkingPrice = "business/parking/getPrice";

  // 停车卡获取月卡费用
  static const String parkingMonthlyFee = "business/parking/getPlateMonthlyFee";

  // 停车卡支付信息
  static const String parkingPay = "business/parking/payMonthlyCard";

  // 停车卡月卡信息（根绝车牌号码查询）
  static const String parkingPlateMonthly = "business/parking/getPlateMonthly";

  // 停车卡月卡绑定
  static const String parkingBind = "business/parking/bindPlateMonthly";

  //***************************停车办理***************************//

  //*************************** 门禁卡***************************//
  // 门禁卡已启用的门禁卡方案
  static const String entranceSetting = "business/accesscardsetting/findAccessCardSetting";

  // 门禁卡申请
  static const String entranceCreate = "business/accesscard/createAccessCard";

  // 门禁卡编辑
  static const String entranceEdit = "business/accesscard/editAccessCard";

  // 门禁卡列表（业主和租户）
  static const String entranceList = "business/accesscard/findAccessCardListByCust";

  // 门禁卡详情
  static const String entranceDetail = "business/accesscard/findAccessCardDetail";

  // 门禁卡更改业务状态
  static const String changeEntranceStatus = "business/accesscard/changeStatusByCust";

  //***************************门禁卡***************************//

  //***************************房屋认证***************************//

  //房屋查询(当前项目下所有已认证的房屋)
  static const String houseCertifiedList = "masterdata/custhouserelation/auditHouseInfoByProjectId";

  //查询所有房屋
  static const String allHouseUrl = "masterdata/houseCustAudit/allHouse";

  //已认证房屋详情
  static const String houseCertifiedDetailUrl = "masterdata/houseCustAudit/findAuditedHouseInfo";

  //认证中房屋详情
  static const String houseCertificatingDetailUrl = "masterdata/houseCustAudit/reviewHouseInfo";

  //游客手机号/证件匹配客户
  static const String getTouristAccountStatusUrl = "masterdata/cust/findByCard";

  //游客人工认证/客户添加房屋
  static const String artificialAuthUrl = "masterdata/houseCustAudit/createHouseCustAuditApp";

  //游客自动认证
  static const String autoAuthUrl = "masterdata/custapprelation/createCustAppRelationApp";

  //迁出
  static const String moveOutUrl = "masterdata/custhouserelation/hirerEmigration";

  //已经认证的房屋列表
  static const String certifiedHouseListUrl = "masterdata/custhouserelation/hirerEmigration";

  //已经认证通过的社区列表
  static const String certifiedCommunityListUrl = "masterdata/custhouserelation/getAuditProjectList";

  //更改默认社区
  static const String changeDefaultCommunityUrl = "masterdata/custhouserelation/addDefaultProject";

  //更改默认房屋
  static const String changeDefaultHouseUrl = "masterdata/custhouserelation/addDefaultHouse";

//选出该业主名下的物业
  static const String getAuditHouseInfoByCustProper = 'masterdata/custhouserelation/getAuditHouseInfoByCustProper';

//删除客户认证失败的房屋记录
  static const String deleteAuditFailedHouseUrl = 'masterdata/houseCustAudit/changeDataFlag';

  //***************************房屋认证***************************//

  //**************************社区活动****************************//
  //活动列表查询
  static const String communityActivityListUrl = "customer_app/activity/findActivityPage";

  //获取_活动详情的h5授权url链接
  static const String communityActivityGetH5Url = "customer_app/activity/getH5Url";

  //***************************社区活动***************************//

  //**************************物品放行****************************//
  //创建-放行条申请
  static const String applyArticlesReleaseUrl = "business/releasepass/createReleasePass";

  //编辑-放行条申请
  static const String modifyArticlesReleaseUrl = "business/releasepass/editReleasePass";

  //物品放行申请列表
  static const String articlesReleaseListUrl = "business/releasepass/findReleasePassListByCust";

  //物品放行详情
  static const String articlesReleaseDetailUrl = "business/releasepass/findReleasePassDetail";

  //物品放行更改业务状态(取消申请/业主审核)
  static const String changeArticlesReleaseStatusUrl = "business/releasepass/changeStatusByCust";

  //***************************物品放行***************************//
  //**************************写字楼退租****************************//
  //创建-写字楼退租申请
  static const String applyOfficeCancelLeaseUrl = "business/officesurrender/createOfficeSurrender";

  //编辑-写字楼退租申请
  static const String modifyOfficeCancelLeaseUrl = "business/officesurrender/editOfficeSurrender";

  //物品放行申请列表
  static const String officeCancelLeaseListUrl = "business/officesurrender/findOfficeSurrenderListByCust";

  //写字楼退租详情
  static const String officeCancelLeaseDetailUrl = "business/officesurrender/findOfficeSurrenderDetail";

  //写字楼退租更改业务状态(取消申请/整改完成)
  static const String changeStatusOfficeCancelLeaseUrl = "business/officesurrender/changeStatusByCust";

  //***************************物品放行***************************//

  //***************************我的***************************//
  //根据项目名模糊查询项目列表
  static const String searchProjectUrl = "masterdata/project/searchProjectPage";

  //根据项目id查楼栋列表
  static const String buildingListByProjectUrl = "masterdata/build/findBuildInfoByProjectId";

  //根据楼栋id查单元列表
  static const String unitListByBuildingUrl = "masterdata/unit/findUnitInfoByBuildId";

  //根据单元id查房号列表
  static const String roomListByUnitUrl = "masterdata/house/findHouseInfoByUnitId";

  //修改个人资料
  static const String modifyPersonalInfoUrl = "masterdata/cust/changeCustInfo";

  //***************************我的***************************//

  //***************************开门***************************//
  //获取门列表
  static const String getDoorList = "external/cmgate/getGateList";

  //请求开门
  static const String openDoor = "external/cmgate/openDoor";

  //开门记录
  static const String openDoorHistory = "external/gateopenrecord/getOpenRecord";

  //保存蓝牙记录
  static const String saveOpenBlueDoorRecord = "external/gateopenrecord/saveLYOpenRecord";

  //***************************开门***************************//

  //***************************房屋入驻申请***************************//
  // 房屋入驻申请
  static const String checkInCreate = "business/rentingenter/createRentingEnter";

  // 房屋入驻编辑
  static const String checkInEdit = "business/rentingenter/editRentingEnter";

  // 房屋入驻申请列表
  static const String checkInList = "business/rentingenter/findRentingEnterListByCust";

  // 房屋入驻详情
  static const String checkInDetail = "business/rentingenter/findRentingEnterDetail";

  // 房屋入驻更改业务状态
  static const String changeCheckInStatus = "business/rentingenter/changeStatusByCust";

  //***************************房屋入驻申请***************************//

  //***************************会议室预定***************************//
  //会议室预约申请
  static String createMeetingMainOrder = 'business/meetingmainorder/createMeetingMainOrder';

  //已预约列表
  static String findMeetingMainOrderPage = 'business/meetingmainorder/findMeetingMainOrderPage';

  //预约详情
  static String getMeetingMainOrder = 'business/meetingmainorder/getMeetingMainOrder';

  //获取可预约的会议室
  static String selectTimeList = 'business/meetingmainorder/selectTimeList';

  //  编辑用户
  static String editMeetingMainOrder = 'business/meetingmainorder/editMeetingMainOrder';

  //操作
  static String changeMeetingMainOrderStatus = 'business/meetingmainorder/changeMeetingMainOrderStatus';

  //***************************会议室预定***************************//

//*****************************新房入伙******************************
  //新建
  static String createHouseJoin = 'business/housejoin/createHouseJoin';

  //编辑
  static String editHouseJoin = 'business/housejoin/editHouseJoin';

  //操作
  static String changeHouseJoinStatus = 'business/housejoin/changeHouseJoinStatus';

  //分页获取-新房入伙业务办理操作记录表
  static String findHouseJoinPage = 'business/housejoin/findHouseJoinPage';

  //详情
  static String getHouseJoinDetailById = 'business/housejoin/getHouseJoinDetailById';

//*****************************新房入伙******************************
  //*****************************访客放行******************************
  //新建
  static String addAppointmentVisitInfo = 'business/appointmentvisit/addAppointmentVisitInfo';

  //分页获取预约到访列表查询
  static String findAppointmentApplyPage = 'business/appointmentvisit/getCustAppointmentPage';

  //授权
  static String authorizeAppointmentVisit = 'business/appointmentvisit/authorizeAppointmentVisit';

  //最大期限
  static String findVisitSettingByProjectId = 'business/appointmentvisit/findVisitSettingByProjectId';

  //详情
  static String getAppointmentVisitDetailById = 'business/appointmentvisit/getAppointmentVisitDetailById';

//*****************************装修许可证******************************
  //租客申请
  static String lesseeApplyList = 'business/decorateApply/lesseeApplyList';

  //我的申请
  static String ownerApplyList = 'business/decorateApply/ownerApplyList';

  //新建
  static String decorateApplySave = 'business/decorateApply/save';

  //修改
  static String decorateApplyUpdate = 'business/decorateApply/update';

  //修改状态
  static String decorateApplyChangeState = 'business/decorateApply/changeState';

  //详情
  static String decorateApplyGetApply = 'business/decorateApply/getApply';

  //发起验收
  static String decorateSaveAcceptance = 'business/decorateApply/saveAcceptance';

  //验收修改
  static String decorateUpdateAcceptance = 'business/decorateApply/updateAcceptance';

  static String decoratePermitGet = 'business/decoratePermit/get';

//*****************************装修许可证******************************

  //***************************动火申请***************************//

  //根据ID查询项目个性化设置详情（获取允许申请时间段和允许动火时间段）
  static const String hotWorkSettingUrl = "base/projectsetting/queryProjectSettingDetail";

  //创建-动火申请
  static const String applyHotWorkUrl = "business/hotworkapply/createHotWorkApply";

  //编辑-动火申请
  static const String modifyHotWorkUrl = "business/hotworkapply/editHotWorkApply";

  //动火申请列表
  static const String hotWorkListUrl = "business/hotworkapply/findHotWorkApplyList";

  //动火申请详情
  static const String hotWorkDetailUrl = "business/hotworkapply/queryHotWorkApplyDetail";

  //改变动火申请状态
  static const String hotWorkChangeStatusUrl = "business/hotworkapply/processHotWorkByCust";

  //***************************动火申请***************************//

  //***************************装修工出入证***************************//
  // 获取可以申请装修出入证的房屋
  static const String decorationPassCardApplyHouse = "business/decoratePass/listProjectAndHouse";

  // 新增-装修出入证
  static const String decorationPassCardSave = "business/decoratePass/save";

  // 修改-装修出入证
  static const String decorationPassCardUpdate = "business/decoratePass/update";

  // 装修出入证有效时间
  static const String decorationPassCardEffectDate = "business/decoratePass/getDate";

  // 装修出入证详情
  static const String decorationPassCardDetail = "business/decoratePass/get";

  // 装修出入证更改业务状态
  static const String decorationPassCardChangeStatus = "/business/decoratePass/changeState";

  // 装修出入证租户申请的列表记录
  static const String decorationPassCardLesseeList = "business/decoratePass/lesseeApplyList";

  // 装修出入证自己申请的列表记录
  static const String decorationPassCardOwnerList = "business/decoratePass/ownerApplyList";

  //***************************装修工出入证***************************//

//***************************pgc***************************//
//pgc列表
  static const String findCustomerPgcPage = "home/pgc/findCustomerPgcPage";

  //评论列表
  static const String findCustomerPgcCommentPage = 'home/pgccomment/findCustomerPgcCommentPage';

  //pgc详情
  static const String pgcGet = 'home/pgc/get';

//操作PGC
  static const String createCustomerOperation = 'home/pgc/createCustomerOperation';

  //操作评论
  static const String changePgcComment = 'home/pgccomment/createCustomerOperation';

  //收藏列表
  static const String findCustomerCollectList = 'sys/custappcollect/findCustomerCollectList';

  //批量删除收藏列表
  static const String deleteCustomerCollect = 'sys/custappcollect/deleteCustomerCollect';

//pgc content url
  static const String getPgcContent = 'home/pgc/getPgcContent?pgcId=';

//***************************pgc***************************//

//***************************邻里集市***************************//
  //发布商品
  static String addWare = "home/ware/addWare";

  //编辑商品
  static String editWare = "home/ware/editWare";

  //收藏/取消收藏商品
  static String collectWare = "home/ware/collectWare";

  //查询商品分类
  static String findWareDataDictionaryList = "home/ware/findDataDictionaryList";

  //商品详情
  static String findWareDetail = "home/ware/findWareDetail";

  //商品列表的展示和搜索
  static String findWaresPage = "home/ware/findWaresPage";

  //我发布的商品列表
  static String findMyWaresPage = "home/ware/findMyWaresPage";

  //我收藏的商品列表
  static String findMyCollectWaresPage = "home/ware/findMyCollectWaresPage";

  //点赞/取消点赞
  static String likeWare = "home/ware/likeWare";

  //隐藏所属项目（待议）
  static String projectIsShowOrHide = "home/ware/projectIsShowOrHide";

  //发表留言
  static String addWareComment = "home/ware/addWareComment";

  //商品留言查询
  static String queryCustomerWareComment = "home/ware/queryCustomerWareComment";

  //查询登录人房屋所属的项目(待议)
  static String queryProjectList = "home/ware/queryProjectList";

  //评论详情(待议)
  static String findWareCommentDetail = "home/ware/findWareCommentDetail";

  //商品状态更新(上架、下架)
  static String updateWareStatus = "home/ware/updateWareStatus";

  //是否可继续发布商品接口
  static String wareIsPublish = "home/ware/wareIsPublish";

  //聊天列表
  static String findChatRecords = "websocket/findChatRecords";

  //聊天历史记录
  static String findSingleChatRecord = "websocket/findSingleChatRecord";

//***************************邻里集市***************************//

//***************************运营模块***************************//

  //说说列表
  static String findAppTalkPage = "home/talk/findAppTalkPage";

  //我收藏的说说列表
  static String findMyCollectTalkPage = "home/talk/findMyCollectTalkPage";

  //收藏/取消说说
  static String collectTalk = "home/talk/collectTalk";

  //话题列表
  static String findCustomerTopicPage = "home/topic/findCustomerTopicPage";

  //我收藏的话题列表
  static String findMyCollectTopicPage = "home/topic/findMyCollectTopicPage";

  //收藏/取消收藏话题
  static String collectTopic = "home/topic/collectTopic";

  //活动主题
  static String queryActivity = "home/activity/queryActivityIsShow";

  //我的中奖记录
  static String findAppWinningManagement = "home/winningmanagement/findAppWinningManagement";

//***************************运营模块***************************//

//***************************社区通行***************************//
  // 通行证列表
  static String accessPassListUrl(String token, int projectId) {
    return "${baseUrl.replaceAll('ubms-customer/', '')}template/appShare/codeList.html?token=$token&projectId=$projectId";
  }

  // 通行证二维码预览
  static String accessPassQRCodeUrl(String token, int passId) {
    return "${baseUrl.replaceAll('ubms-customer/', '')}template/appShare/showCode.html?token=$token&id=$passId";
  }

  // 通行证二维码申请
  static String accessPassApplyUrl(String token, int projectId) {
    return "${baseUrl.replaceAll('ubms-customer/', '')}template/appShare/codeApplication.html?token=$token&projectId=$projectId";
  }

  //社区通行通行证列表
  static const String getAccessPassListUrl = 'masterdata/passport/findPassPortPage';

//***************************社区通行***************************//

//***************************绿萝行动***************************//
  static String getLvluoUrl(phone) {
    return "http://php.tencenthouse.com/dist/index.html#/?phone=$phone";
  }
//***************************绿萝行动***************************//

//***************************美伦体检***************************//
  static const String getMeiLunUrl = "base/meilun/getUrl";
//***************************美伦体检***************************//

//***************************获取支付接口*************************//
  // 支付地址
  static const String getCMPay = "business/cmpay/showPay";
//***************************获取支付接口***************************//


//***************************修改密码/忘记密码***************************//
  // 获取验证码（修改密码用）
  static const String getVerificationCodeForModifyPwdUrl = "authorize/loginCheck/sendSmsCode";
  // 验证验证码
  static const String verificationCodeForModifyPwdUrl = "authorize/loginCheck/checkSmsCode";
  // 根据验证码修改密码
  static const String modifyPwdUrl = "authorize/loginCheck/updatePwdBySmsCode";
//***************************修改密码/忘记密码***************************//

  //数据字典
  static const String findDataDictionaryList = 'base/datadictionary/findDataDictionaryList';

  //分享记录
  static const String findCustSharePage = 'home/custshare/findCustSharePage';

  // 文件上传
  static const String fileUpload = "base/mongo/uploadFile";

  // 文件下载展示
  static String downloadFileUrl(id) {
    return "${baseUrl}base/mongo/download/$id";
  }

  // 图片展示
  static String showPhotoUrl(id) {
//    LogUtils.printLog("${baseUrl}base/mongo/show/$id");
    return "${baseUrl}base/mongo/show/$id";
  }

  // 回单上传单张图片
  static String uploadPicUrl(String orderNo, String fileName) {
    return "business/order/product/uploadOrderSignPhoto?orderNo=$orderNo&fileName=$fileName";
  }

  //预约挂号的url组装
  static String getHealthUrl(String url, String cid, String token) {
    return "$url?cid=$cid&mtToken=$token";
  }

  //商城的url组装
  static String getMallUrl(String url, int accountId, int projectId) {
    if (url.contains('?')) {
      List<String> strList = url.split('?');
      if (strList != null && strList.length > 1 && StringsHelper.isNotEmpty(strList[1])) {
        LogUtils.printLog('商城url：$url&appuserid=$accountId&appcommunityId=$projectId');
        return "$url&appuserid=$accountId&appcommunityId=$projectId";
      } else {
        LogUtils.printLog('商城url：$url?appuserid=$accountId&appcommunityId=$projectId');
        return "$url?appuserid=$accountId&appcommunityId=$projectId";
      }
    } else {
      LogUtils.printLog('商城url：$url?appuserid=$accountId&appcommunityId=$projectId');
      return "$url?appuserid=$accountId&appcommunityId=$projectId";
    }
  }

  //临停缴费的url组装
  static String getParkingPayUrl(int userId, int community) {
    LogUtils.printLog('停车缴费：userId$userId；community$community');
    return "${HttpOptions.baseUrl == HttpOptions.urlProduction ? 'http://app.park.cmskcrm.com' : 'http://app.park.ylmo2o.com'}/?user=$userId&community=$community&source=ubms";
  }

  //物管缴费的url组装
  static String getPropertyPayUrl() {
    String params = (stateModel.customerId?.toString() ?? "") +
        ";" +
        (Platform.isAndroid ? "ANDROID" : "IOS") +
        ";" +
        (stateModel.mobile ?? "");
    String key = base64.encode(utf8.encode(params));
    return "${HttpOptions.baseUrl == HttpOptions.urlProduction ? 'http://jz.cmpmc.com' : 'http://218.17.81.126:8089'}/fycx/$key?version=2.0";
  }
}
