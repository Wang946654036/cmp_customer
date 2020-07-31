//操作节点
import 'check_in_status.dart';

const String check_in_step_apply = "ZHRZ_TJSQ"; //提交申请
const String check_in_step_edit = "ZHRZ_XGSQ"; //修改申请
const String check_in_step_audit = "ZHRZ_WYSH"; //物业审核
const String check_in_step_pay = "ZHRZ_JFQR"; //缴费去人
const String check_in_step_complete = "ZHRZ_RZQR"; //入驻确认
const String check_in_step_cancel = "ZHRZ_QXSQ"; //取消申请

////获取流程节点的中文名称
//getCheckInStepName(String stepCode,String customerType) {
//  String name = "";
//  switch (stepCode) {
//    case check_in_step_apply:
//      name = "发起申请";
//      break;
//    case check_in_step_edit:
//      name = "修改申请";
//      break;
//    case check_in_step_audit:
//      name = "物业审核";
//      break;
//    case check_in_step_pay:
//      name = "缴费确认";
//      break;
//    case check_in_step_complete:
//      name = "入驻确认";
//      break;
//    case check_in_step_cancel:
//      name = "撤销";
//      break;
//  }
//  return name;
//}

////获取审核操作内容（是否通过）
//getCheckInStepContent(String stepCode,String state){
//  String content="";
//  if(stepCode==check_in_step_audit){
//    if(state==auditFailed){
//      content="不通过";
//    }else{
//      content="通过";
//    }
//  }
//  return content;
//}
