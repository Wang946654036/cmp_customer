//停车卡办理状态
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/date_util.dart';

const String auditWaiting = "DSH"; //待审核
const String auditFailed = "SHBTG"; //审核不通过
const String payWaiting = "DZF"; //待支付
const String completed = "YWC"; //已完成
const String cancelled = "YQX"; //已取消
//const String xzAuditWaiting="";//续租待审核
//const String xzAuditFailed=7;//续租不通过
//const String xzPayWaiting=8;//续租待支付
//const String xzCompleted=9;//续租已完成
//const String xzCancelled=10;//续租已取消
const String tzAcceptWaiting = "DSL"; //退卡待受理
const String tzConfirmWaiting = "DQR"; //退卡待确认
//const String tkCompleted=13;//续租已完成
//const String tkCancelled=14;//续租已取消

const String operationXK = "XK"; //新卡申请
const String operationXF = "XF"; //续费
const String operationTZ = "TZ"; //退租

const String parking_refresh = "parking_refresh"; //刷新事件监听名称
//const String parking_details_close="parking_details_close";//详情页面关闭监听名称

////获取状态名称
//getStateText(String state) {
//  var stateText = "";
//  switch (state) {
//    case auditWaiting:
////    case xzAuditWaiting:
//      stateText = "待审核";
//      break;
//    case auditFailed:
////    case xzAuditFailed:
//      stateText = "审核不通过";
//      break;
//    case payWaiting:
////    case xzPayWaiting:
//      stateText = "待支付";
//      break;
//    case tzAcceptWaiting:
//      stateText = "待受理";
//      break;
//    case tzConfirmWaiting:
//      stateText = "待确认";
//      break;
//    case completed:
////    case xzCompleted:
////    case tkCompleted:
//      stateText = "已完成";
//      break;
//    case cancelled:
////    case xzCancelled:
////    case tkCancelled:
//      stateText = "已取消";
//      break;
//  }
//  return stateText;
//}

//获取操作状态名称
getOperationStateText(String state) {
  String name = "";
  switch (state) {
    case operationXK:
      name = "新卡申请";
      break;
    case operationXF:
      name = "续费";
      break;
    case operationTZ:
      name = "退租";
      break;
  }
  return name;
}

//获取月卡的有效性（参数为月卡有效结束时间）
getCardValidityName(String endTime) {
  if(StringsHelper.isEmpty(endTime)) return "";
  int days=DateUtils.getDifferenceDay(endTime);
  String text="";
  if(days>30){
    text="已启用";
  }else if(days>=0){
    text="即将过期";
  }else{
    text="已过期";
  }
  return text;
}
//
////获取节点状态名称
//getNodeStateText(String state) {
//  var stateText = "";
//  switch (state) {
//    case auditWaiting:
//      stateText = "审核";
//      break;
//    case auditFailed:
//      stateText = "审核不通过";
//      break;
//    case payWaiting:
//      stateText = "待支付";
//      break;
//    case tzAcceptWaiting:
//      stateText = "待受理";
//      break;
//    case tzConfirmWaiting:
//      stateText = "待确认";
//      break;
//    case completed:
//      stateText = "已完成";
//      break;
//    case cancelled:
//      stateText = "已取消";
//      break;
//  }
//  return stateText;
//}

////获取节点对应的操作
//getNodeStateOperationText(String state) {
//  var stateText = "";
//  switch (state) {
//    case auditWaiting:
//      stateText = "待审核";
//      break;
//    case auditFailed:
//      stateText = "审核不通过";
//      break;
//    case payWaiting:
//      stateText = "待支付";
//      break;
//    case tzAcceptWaiting:
//      stateText = "待受理";
//      break;
//    case tzConfirmWaiting:
//      stateText = "待确认";
//      break;
//    case completed:
//      stateText = "已完成";
//      break;
//    case cancelled:
//      stateText = "已取消";
//      break;
//  }
//  return stateText;
//}
