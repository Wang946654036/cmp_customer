import 'package:flutter/services.dart';
import 'dart:io';

enum ListState {
  //显示“正在加载”
  HINT_LOADING,

  //无数据显示“点击可刷新”
  HINT_NO_DATA_CLICK,

  //加载失败显示“点击可刷新”
  HINT_LOADED_FAILED_CLICK,

  //隐藏提示信息
  HINT_DISMISS,
}

class Constant {
  //跳转界面赋值的页面string值
  //登录页面
  static final String pageLogin = '/login_page';
  //首页框架页面
  static final String pageMain = '/main_page';
  //介绍页
  static final String pageIntro = '/intro_page';
  //反馈页面（建议、意见、表扬）
  static final String pageFeedback = '/praise_feedback';
  //个人资料页面
  static final String pagePersonalInfo = '/personal_info_page';
  //设置页面
  static final String pageSetting = '/setting_page';
  //修改手机号页面
  static final String pageModifyPhoneNo = '/modify_phone_no_page';
  //验证验证码页面
  static final String pageCheckVerificationCode = '/check_verification_code_page';
  //首次登录隐私条款提示界面
  static final String pageFirstPolicy = '/first_policy_page';




  static final String dataBaseName = 'cmp_employee.db';

  static Directory appDocDir;

  static final String cookiesDir = '${appDocDir.path}/cookies';

  static final tipDialogDurationTime = Duration(seconds: 2);

  static final int verificationCodeSecond = 60;
}
