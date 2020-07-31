//文案配置-文案类型
import 'package:cmp_customer/http/http_options.dart';

enum CopyWritingType {
  ParkingAgreement, //停车场停车协议
  EntranceCardCharging, //门禁卡收费标准
  EntranceCardAgreement, //门禁卡协议
  ConferenceRoomUsage, //会议室使用协议
  ConferenceRoomCharging, //会议室收费标准
  CardBrandApplication, //水牌名牌申请协议
  OfficeRentRefundNotes, //写字楼退租注意事项
  PropertyChangeNotes, //产权变更注意事项
  ReleasePassTips, //放行条温馨提示
  TipsForHotWork, //动火温馨提示
  TipsForDecoration,//	装修温馨提示
  TipsForDecorationPass,//	装修工出入证温馨提示
  DecorationCommitment,//	装修施工承诺书
  DecorationAgreement,//	装修协议
  DecorationGuarantee,//	房屋装修业主担保书
  FireSafetyResponsibility,//	安全防火责任书
  TipsForTenants, //租户入驻温馨提示
  OwnerPledge, //业主公约
  CivilizationConvention, //精神文明建设公约
  FireDirectorContact, //防火负责人联络表
  EntrustPayAgreement, //委托收款结算协议书
}

//List<String> copyWritingTypeList = [
//  'ParkingAgreement', //停车场停车协议 - 0
//  'EntranceCardCharging', //门禁卡收费标准 - 1
//  'ConferenceRoomUsage', //会议室使用协议 - 2
//  'ConferenceRoomCharging', //会议室收费标准 - 3
//  'CardBrandApplication', //水牌名牌申请协议 - 4
//  'OfficeRentRefundNotes', //写字楼退租注意事项 - 5
//  'PropertyChangeNotes', //产权变更注意事项 - 6
//  'ReleasePassTips', //放行条温馨提示 - 7
//];

//扫码类型（生成的二维码为扫码类型+“_”+id）
enum QRCodeType {
  ArticlesRelease, //物品放行
  HotWork,//动火申请
  DecorationPermit,//装修申请
  DecorationPass,//装修出入证
  VisitorRelease,//访客放行
}


//时间段（3-最近三个月 6-最近半年 12-最近一年）
const Map<int, String> timeIntervalMap = {
  3: '最近三个月',
  6: '最近半年',
  12: '最近一年',
};


//环境
const Map<String, String> developmentMap = {
  HttpOptions.urlTest: '测试环境',
  HttpOptions.urlDemonstration: '演示环境',
  HttpOptions.urlProduction: '生产环境',
  '': '其他环境',
  null: '其他环境',
};

const String externalDir = '/UbmsCustomer';

const String appStoreUserAccount = '18800000000';