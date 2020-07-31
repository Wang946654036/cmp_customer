//操作节点
import 'package:cmp_customer/ui/entrance/entrance_card_state.dart';

const String entrance_step_apply = "MJK_TJSQ"; //提交申请
const String entrance_step_apply_yz = "MJK_YZSQ"; //业主申请
const String entrance_step_apply_zh = "MJK_ZHSQ"; //租户申请
const String entrance_step_edit = "MJK_XGSQ"; //修改申请
const String entrance_step_audit_yz = "MJK_YZSH"; //业主审核
const String entrance_step_audit_wy = "MJK_WYSH"; //物业审核
const String entrance_step_pay = "MJK_ZFFY"; //支付费用
const String entrance_step_complete = "MJK_WGDJ"; //完工登记
const String entrance_step_cancel = "MJK_QXSQ"; //取消申请

////获取门禁卡流程节点的中文名称
//getEntranceStepName(String stepCode,String customerType) {
//  String name = "";
//  switch (stepCode) {
//    case entrance_step_apply:
//      if(customerType == customerYZ || customerType ==customerJTCY){
//        name = "业主申请";
//      }else if(customerType == customerZH || customerType ==customerZHCY){
//        name = "租户申请";
//      }else{
//        name = "申请";
//      }
//      break;
//    case entrance_step_edit:
//      name = "修改申请";
//      break;
//    case entrance_step_audit_yz:
//      name = "业主审核";
//      break;
//    case entrance_step_audit_wy:
//      name = "物业审核";
//      break;
//    case entrance_step_pay:
//      name = "缴费";
//      break;
//    case entrance_step_complete:
//      name = "完工";
//      break;
//    case entrance_step_cancel:
//      name = "撤销";
//      break;
//  }
//  return name;
//}
//
////获取审核操作内容（是否通过）
//getEntranceStepContent(String stepCode,String state){
//  String content="";
//  if(stepCode==entrance_step_audit_yz){
//    if(state==auditLandlordFailed){
//      content="业主不同意";
//    }else{
//      content="业主同意";
//    }
//  }else if(stepCode==entrance_step_audit_wy){
//    if(state==auditPropertyFailed){
//      content="物业不同意";
//    }else{
//      content="物业同意";
//    }
//  }
//  return content;
//}
