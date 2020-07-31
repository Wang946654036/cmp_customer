import 'package:cmp_customer/ui/common/common_wrap.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';

//操作环节：XZLTZ_TJSQ-提交申请、XZLTZ_XGSQ-修改申请、XZLTZ_QXSQ-取消申请、XZLTZ_WYSH-物业审核、XZLTZ_JYDJ-交验登记、XZLTZ_ZGWC-整改完成
enum OfficeCancelLeaseOperateStep {
  XZLTZ_TJSQ, //提交申请
  XZLTZ_XGSQ, //修改申请
  XZLTZ_WYSH, // 物业审核
  XZLTZ_JYDJ, //交验登记
  XZLTZ_ZGWC, //整改完成
  XZLTZ_QXSQ, //取消申请
}
//操作环节：WPFX_TJSQ-提交申请、WPFX_XGSQ-修改申请、WPFX_WYSH-物业审核、XZLTZ_JYDJ-交验登记、XZLTZ_ZGWC-整改完成、XZLTZ_QXSQ-取消申请
Map<String, String> officeCancelLeaseOperateStepMap = {
  StringsHelper.enum2String(OfficeCancelLeaseOperateStep.XZLTZ_TJSQ): '提交申请',
  StringsHelper.enum2String(OfficeCancelLeaseOperateStep.XZLTZ_XGSQ): '修改申请',
  StringsHelper.enum2String(OfficeCancelLeaseOperateStep.XZLTZ_WYSH): '物业审核',
  StringsHelper.enum2String(OfficeCancelLeaseOperateStep.XZLTZ_JYDJ): '交验登记',
  StringsHelper.enum2String(OfficeCancelLeaseOperateStep.XZLTZ_ZGWC): '整改完成',
  StringsHelper.enum2String(OfficeCancelLeaseOperateStep.XZLTZ_QXSQ): '取消申请',
};

//写字楼退租状态:DSH-待审核，DJY-待交验，SHBTG-审核不通过，JYBTG-交验不通过，JYTG-交验通过，YQX-已取消
const Map<String, String> officeCancelLeaseStatusMap = {
  'DSH': '待审核', //0
  'DJY': '待交验', //1
  'SHBTG': '审核不通过', //2
  'JYBTG': '交验不通过', //3
  'JYTG': '交验通过', //4
  'YQX': '已取消', //5
};

//物品放行状态对应颜色：DSH-待审核，DJY-待交验，SHBTG-审核不通过，JYBTG-交验不通过，JYTG-交验通过，YQX-已取消
Map<String, Color> officeCancelLeaseStatusToColorMap = {
  'DSH': UIData.yellowColor,
  'DJY': UIData.yellowColor,
  'SHBTG': UIData.lightRedColor,
  'JYBTG': UIData.lightRedColor,
  'JYTG': UIData.lightGreyColor,
  'YQX': UIData.lightGreyColor,
  null: UIData.yellowColor,
//    null: UIData.yellowColor,
};