//门禁卡申请状态
import 'package:cmp_customer/ui/entrance/entrance_card_apply.dart';

const String auditLandlordWaiting = "DYZTY"; //待业主同意
const String auditLandlordFailed = "YZBTY"; //业主不同意
const String auditPropertyWaiting = "DWYSH"; //待物业审核
const String auditPropertyFailed = "WYBTG"; //物业不通过
const String payWaiting = "DJF"; //待缴费
const String producing = "ZZZ"; //制作中
const String completed = "YWG"; //已完工
const String cancelled = "YQX"; //已取消
const String closed = "YGD"; //已关单

//门禁卡客户类型
const String customerYZ = "YZ"; //业主
const String customerZH = "ZH"; //租户
const String customerJTCY = "JTCY"; //业主成员
const String customerZHCY = "ZHCY"; //租户成员

const String entrance_refresh = "entrance_card_refresh"; //刷新事件监听名称
const String entrance_audit_refresh = "entrance_card_audit_refresh"; //审核刷新
//const String entrance_details_close="entrance_details_close";//详情页面关闭监听名称

//getStateText(String state) {
//  var stateText = "";
//  switch (state) {
//    case auditLandlordWaiting:
//      stateText = "待业主审核";
//      break;
//    case auditPropertyWaiting:
//      stateText = "待物业审核";
//      break;
//    case auditLandlordFailed:
//      stateText = "业主不同意";
//      break;
//    case auditPropertyFailed:
//      stateText = "物业不同意";
//      break;
//    case payWaiting:
//      stateText = "待缴费";
//      break;
//    case producing:
//      stateText = "制作中";
//      break;
//    case completed:
//      stateText = "已完工";
//      break;
//    case cancelled:
//      stateText = "已取消";
//      break;
//  }
//  return stateText;
//}

//获取申请类型
getEntranceApplyType(String customerType) {
  EntranceApplyType type;
  switch (customerType) {
    case customerYZ:
    case customerJTCY:
      type = EntranceApplyType.landlord;
      break;
    case customerZH:
    case customerZHCY:
      type = EntranceApplyType.tenant;
      break;
  }
  return type;
}
//getBottonText(String state){
//  var bottonText="";
//  switch(state){
//    case auditLandlordWaiting:
//    case auditPropertyWaiting:
//      bottonText="撤销申请";
//      break;
//    case auditLandlordFailed:
//    case auditPropertyFailed:
//      bottonText="重新申请";
//      break;
//  }
//  return bottonText;
//}
