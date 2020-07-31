import 'dart:convert';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/models/common_result_model.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/utils/failed_code_trans.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bcrypt/flutter_bcrypt.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/services.dart';

mixin PwdStateModel on Model {
  ///
  /// 获取验证码接口（修改密码用）
  ///
  void getVerificationCodeForModifyPwd({@required String mobile, Function callBack}) async {
    String jsonData = json.encode({
      'mobile': mobile,
    });

    HttpUtil.post(HttpOptions.getVerificationCodeForModifyPwdUrl,
        (data) => _getVerificationCodeForModifyPwdCallBack(data, callBack: callBack),
        jsonData: jsonData, errorCallBack: (errorMsg)=> _getVerificationCodeForModifyPwdErrorCallBack(errorMsg, callBack: callBack));
  }

  void _getVerificationCodeForModifyPwdCallBack(data, {Function callBack}) {
    CommonResultModel model = CommonResultModel.fromJson(data);
    LogUtils.printLog('获取验证码（修改密码）:$data');
    if (model.code == '0') {
      if (callBack != null) callBack(msg: true);
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
      CommonToast.show(msg: '$failedDescri', type: ToastIconType.FAILED);
      if (callBack != null) callBack(msg: false);
    }
//    notifyListeners();
  }

  void _getVerificationCodeForModifyPwdErrorCallBack(errorMsg, {Function callBack}) {
    LogUtils.printLog('获取验证码（修改密码）接口返回失败');
    CommonToast.show(msg: errorMsg, type: ToastIconType.FAILED);
    if (callBack != null) callBack(msg: false);
//    notifyListeners();
  }

  ///
  /// 验证验证码接口
  ///
  void verificationCodeByModifyPwd({@required String mobile, @required String code, VoidCallback callBack}) async {
    CommonToast.show(msg: '验证中');
    String jsonData = json.encode({
      'mobile': mobile,
      'code': code,
    });

    HttpUtil.post(HttpOptions.verificationCodeForModifyPwdUrl,
        (data) => _verificationCodeForModifyPwdCallBack(data, callBack: callBack),
        jsonData: jsonData, errorCallBack: _verificationCodeForModifyPwdErrorCallBack);
  }

  void _verificationCodeForModifyPwdCallBack(data, {VoidCallback callBack}) {
    CommonResultModel model = CommonResultModel.fromJson(data);
    CommonToast.dismiss();
    LogUtils.printLog('验证验证码:$data');
    if (model.code == '0') {
      if (callBack != null) callBack();
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
      CommonToast.show(msg: failedDescri, type: ToastIconType.FAILED);
    }
//    notifyListeners();
  }

  void _verificationCodeForModifyPwdErrorCallBack(errorMsg) {
    LogUtils.printLog('验证验证码接口返回失败');
    String failedDescri = FailedCodeTrans.enTochsTrans(failMsg: errorMsg);
    CommonToast.show(msg: failedDescri, type: ToastIconType.FAILED);
//    notifyListeners();
  }

  ///
  /// 修改密码接口
  ///
  void modifyPwd({@required String mobile, @required String pwd, VoidCallback callBack}) async {
    CommonToast.show();
    String bcryptCode;
    Map<String, dynamic> params = new Map();
    params['mobile'] = mobile;
    try {
//      var salt = await FlutterBcrypt.salt();
//      bcryptCode = await FlutterBcrypt.hashPw(password: pwd, salt: await FlutterBcrypt.salt());
//      var salt = await FlutterBcrypt.salt();
//      LogUtils.printLog("salt " + salt);
//      LogUtils.printLog("pwd " + pwd);
      var salt10 = await FlutterBcrypt.saltWithRounds(rounds: 10);
      LogUtils.printLog("salt10 " + salt10);
//      var salt102a = salt10.replaceFirst('b', 'a');
//      LogUtils.printLog("salt102a " + salt102a);
      bcryptCode = await FlutterBcrypt.hashPw(password: pwd, salt: salt10);
      params['pwd'] = bcryptCode;
//      var result = await FlutterBcrypt.verify(password: pwd, hash: bcryptCode);
//      LogUtils.printLog("result: " +  (result ? "ok" : "nok"));
      LogUtils.printLog("pwd：$pwd");
    } on PlatformException {
//        hash = 'Failed to get hash.';
      CommonToast.show(msg: '修改密码失败，请联系管理员！', type: ToastIconType.FAILED);
    }
    String jsonData = json.encode(params);

    HttpUtil.post(HttpOptions.modifyPwdUrl, (data) => _modifyPwdCallBack(data, callBack: callBack),
        jsonData: jsonData, errorCallBack: _modifyPwdErrorCallBack);
  }

  void _modifyPwdCallBack(data, {VoidCallback callBack}) {
    CommonResultModel model = CommonResultModel.fromJson(data);
    LogUtils.printLog('修改密码:$data');
    if (model.code == '0') {
      CommonToast.show(msg: '修改成功', type: ToastIconType.SUCCESS);
      if (callBack != null) callBack();
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
      CommonToast.show(msg: failedDescri, type: ToastIconType.FAILED);
    }
  }

  void _modifyPwdErrorCallBack(errorMsg) {
    LogUtils.printLog('修改密码接口返回失败');
    CommonToast.show(msg: errorMsg, type: ToastIconType.FAILED);
//    notifyListeners();
  }

  static PwdStateModel of(context) => ScopedModel.of<PwdStateModel>(context);
}
