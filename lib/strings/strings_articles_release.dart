import 'package:cmp_customer/ui/common/common_wrap.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';

//物品放行申请理由：BJ-搬家、ZX-装修、TF-退房、RCQL-日常清理、OTHER-其他
const Map<String, String> articleReleaseReasonMap = {
  '搬家': 'BJ',
  '装修': 'ZX',
  '退房': 'TF',
  '日常清理': 'RCQL',
  '其他': 'OTHER',
};


//物品名称的常用词
List<String> articlesCommonWordsList = ['家电', '家具', '电脑'];

//操作环节：WPFX_TJSQ-业主提交申请、WPFX_ZHSQ-租户申请、WPFX_XGSQ-修改申请、WPFX_WYSH-物业审核、WPFX_WYFX-物业放行、MJK_QXSQ-取消申请
enum ArticlesReleaseOperateStep {
  WPFX_TJSQ, //提交申请
  WPFX_ZHSQ, //租户申请
  WPFX_XGSQ, //修改申请
  WPFX_YZSH, // 业主审核
  WPFX_WYSH, // 物业审核
  WPFX_WYFX, //物业放行
  WPFX_QXSQ, //取消申请
}

const String articleReleaseTJSQ = "WPFX_TJSQ"; //提交申请
const String articleReleaseQXSQ = "WPFX_QXSQ"; //取消申请
const String articleReleaseYZSH = "WPFX_YZSH"; //业主审核
const String articleReleaseWYSH = "WPFX_WYSH"; //物业审核
const String articleReleaseWYFX = "WPFX_WYFX"; //物业放行
//操作环节：WPFX_TJSQ-业主提交申请、WPFX_ZHSQ-租户申请、WPFX_XGSQ-修改申请、
// WPFX_YZSH-业主审核、WPFX_WYSH-物业审核、WPFX_WYFX-物业放行、MJK_QXSQ-取消申请
Map<String, String> articlesReleaseOperateStepMap = {
  StringsHelper.enum2String(ArticlesReleaseOperateStep.WPFX_TJSQ): '提交申请',
  StringsHelper.enum2String(ArticlesReleaseOperateStep.WPFX_XGSQ): '修改申请',
  StringsHelper.enum2String(ArticlesReleaseOperateStep.WPFX_WYSH): '物业审核',
  StringsHelper.enum2String(ArticlesReleaseOperateStep.WPFX_WYFX): '物业放行',
  StringsHelper.enum2String(ArticlesReleaseOperateStep.WPFX_QXSQ): '取消申请',
  StringsHelper.enum2String(ArticlesReleaseOperateStep.WPFX_ZHSQ): '租户申请',
  StringsHelper.enum2String(ArticlesReleaseOperateStep.WPFX_YZSH): '业主审核',
};



const String articlesReleaseDSH = "DSH"; //待审核0
const String articlesReleaseSHBTG = "SHBTG"; //审核不通过1
const String articlesReleaseSHTG = "SHTG"; //审核通过2
const String articlesReleaseFXBTG = "FXBTG"; //放行不通过3
const String articlesReleaseFXTG = "FXTG"; //放行通过4
const String articlesReleaseYQX = "YQX"; //已取消5
const String articlesReleaseDYZSH = "DYZSH"; //待业主审核6
const String articlesReleaseYZSHBTG = "YZSHBTG"; //业主审核不通过7
//物品放行状态：DSH-待审核、DYZSH-待业主审核、YZSHBTG-业主审核不通过、SHBTG-审核不通过、SHTG-审核通过、FXBTG-放行不通过、FXTG-放行通过、YQX-已取消
const Map<String, String> articlesReleaseStatusMap = {
  'DYZSH': '待业主同意',
  'YZSHBTG': '业主不同意',
  'DSH': '待审核',
  'SHBTG': '审核不通过',
  'SHTG': '审核通过',
  'FXBTG': '放行不通过',
  'FXTG': '放行通过',
  'YQX': '已取消',
};

//物品放行状态对应颜色：DSH-待审核、SHBTG-审核不通过、SHTG-审核通过、FXBTG-放行不通过、FXTG-放行通过、YQX-已取消
Map<String, Color> articlesReleaseStatusToColorMap = {
  'DSH': UIData.yellowColor,
  'SHBTG': UIData.lightRedColor,
  'DYZSH': UIData.yellowColor,
  'YZSHBTG': UIData.lightRedColor,
  'SHTG': UIData.greenColor,
  'FXBTG': UIData.lightRedColor,
  'FXTG': UIData.greenColor,
  'YQX': UIData.lightGreyColor,
  null: UIData.yellowColor,
//    null: UIData.yellowColor,
};
