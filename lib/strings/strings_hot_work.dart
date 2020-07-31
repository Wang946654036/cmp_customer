import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';



const String hotWorkOperateStepCancel = "DH_APPLY_CANCEL"; //取消申请
const String hotWorkOperateStepProAudit = "DH_PRO_AUDIT"; //物业审核（初审和专审）
const String hotWorkOperateStepPassFinish = "DH_PASS_FINISH"; //已签证


const String hotWorkToOwnerAgree = "ToOwnerAgree"; //待业主同意
const String hotWorkOwnerDisagree = "OwnerDisagree"; //业主不同意
const String hotWorkToProFirstAudit = "ToProFirstAudit"; //待物业初审
const String hotWorkProFirstAuditFail = "ProFirstAuditFail"; //物业初审不通过
const String hotWorkToProSecondAudit = "ToProSecondAudit"; //待物业专审
const String hotWorkProSecondAuditFail = "ProSecondAuditFail"; //物业专审不通过
const String hotWorkHasApproved = "HasApproved"; //已签证
const String hotWorkHasCancel = "HasCancel"; //已撤单

///动火申请状态对应颜色：
///ToOwnerAgree-待业主同意、
///OwnerDisagree-业主不同意、
///ToProFirstAudit-待物业初审、
///ProFirstAuditFail-物业初审不通过、
///ToProSecondAudit-待物业专审、
///ProSecondAuditFail-物业专审不通过
///HasApproved-已签证
///HasCancel-已撤单
Map<String, Color> hotWorkStatusToColorMap = {
  hotWorkToOwnerAgree: UIData.yellowColor,
  hotWorkOwnerDisagree: UIData.lightRedColor,
  hotWorkToProFirstAudit: UIData.yellowColor,
  hotWorkProFirstAuditFail: UIData.lightRedColor,
  hotWorkToProSecondAudit: UIData.yellowColor,
  hotWorkProSecondAuditFail: UIData.lightRedColor,
  hotWorkHasApproved: UIData.lightGreyColor,
  hotWorkHasCancel: UIData.lightGreyColor,
  null: UIData.yellowColor,
//    null: UIData.yellowColor,
};