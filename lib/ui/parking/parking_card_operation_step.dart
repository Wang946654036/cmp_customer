//操作节点
const String parking_step_apply = "TCBL_TJSQ"; //提交申请
const String parking_step_edit = "TCBL_XGSQ"; //修改申请
const String parking_step_audit = "TCBL_SLSH"; //受理审核
const String parking_step_pay = "TCBL_ZFFY"; //支付费用
const String parking_step_accept = "TCBL_KFSL"; //客服受理
const String parking_step_confirm = "TCBL_KHQR"; //客户确认
const String parking_step_cancel = "TCBL_QXSQ"; //取消申请

////获取停车办理流程节点的中文名称
//getParkingStepName(String stepCode) {
//  String name = "";
//  switch (stepCode) {
//    case parking_step_apply:
//      name = "申请";
//      break;
//    case parking_step_edit:
//      name = "修改";
//      break;
//    case parking_step_audit:
//      name = "审核";
//      break;
//    case parking_step_pay:
//      name = "缴费";
//      break;
//    case parking_step_accept:
//      name = "受理";
//      break;
//    case parking_step_confirm:
//      name = "确认";
//      break;
//    case parking_step_cancel:
//      name = "撤销";
//      break;
//  }
//  return name;
//}
