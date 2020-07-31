import 'dart:convert';
import 'dart:io';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/login_model.dart';
import 'package:cmp_customer/ui/common/common_dialog.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/failed_code_trans.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/shared_preferences_key.dart';
import 'package:cmp_customer/utils/ui_data.dart';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tip_dialog/tip_dialog.dart';
import 'http_options.dart';

class HttpUtil {
  static const String GET = 'get';
  static const String POST = 'post';

  static void get(String url, Function callBack, {Map<String, dynamic> params, Function errorCallBack}) async {
    _intercept(url, callBack, method: GET, params: params, errorCallBack: errorCallBack);
  }

//post请求
  static Future<void> post(String url, Function callBack,
      {Map<String, dynamic> params,
      String jsonData,
      FormData formData,
      Function errorCallBack,
      var tag,
      CancelToken cancelToken}) async {
    await _intercept(url, callBack,
        method: POST,
        params: params,
        jsonData: jsonData,
        formData: formData,
        errorCallBack: errorCallBack,
        tag: tag,
        cancelToken: cancelToken);
  }

  static Future<void> _intercept(String url, Function callBack,
      {String method,
      Map<String, dynamic> params,
      String jsonData,
      FormData formData,
      Function errorCallBack,
      var tag,
      CancelToken cancelToken}) async {
    SharedPreferences prefs = await SharedPreferencesKey.globalPrefs;
//    BaseOptions options = HttpOptions.getInstance;

    Dio dio = new Dio(HttpOptions.getInstance);
    dio.interceptors
      ..add(InterceptorsWrapper(onRequest: (RequestOptions options) {
        // 在请求被发送之前做一些事情
        if (url.contains(HttpOptions.getVerificationCodeForLoginUrl)) {
//          LogUtils.printLog('deviceId:${options.queryParameters['mobile']}');
          options.headers['deviceId'] = options.queryParameters['mobile'];
        } else if (url.contains(HttpOptions.loginUrl) || url.contains(HttpOptions.loginByPwdUrl)) {
          options.headers['deviceId'] = options.queryParameters['mobile'];
          options.headers[HttpHeaders.authorizationHeader] = HttpOptions.basicAuth;
//          options.contentType = ContentType.parse('application/x-www-form-urlencoded');
        } else if (url.contains(HttpOptions.refreshTokenUrl)) {
          options.headers[HttpHeaders.authorizationHeader] = HttpOptions.basicAuth;
        } else if (!url.contains(HttpOptions.registerUrl) &&
            !url.contains(HttpOptions.getVerificationCodeUrl) &&
            !url.contains(HttpOptions.checkMobileExistUrl) &&
            !url.contains(HttpOptions.getVerificationCodeForModifyPwdUrl) &&
            !url.contains(HttpOptions.verificationCodeForModifyPwdUrl) &&
            !url.contains(HttpOptions.modifyPwdUrl)) {
          options.headers[HttpHeaders.authorizationHeader] =
              'Bearer ${prefs.getString(SharedPreferencesKey.KEY_ACCESS_TOEKN)}';
//          options.headers[HttpHeaders.authorizationHeader] = //测试数据
//              'Bearer 123'; //测试数据
        }
        return options;
      }, onResponse: (Response response) async {
        // 在返回响应数据之前做一些预处理
//        LogUtils.printLog('onResponse:${response.data['code']}');
        String errorMsg;
        int statusCode = response.statusCode;
        if (statusCode != 200) {
          LogUtils.printLog('response.statusCode: ${response.statusCode}');
          errorMsg = '网络请求出错，请联系管理：' + statusCode.toString();
          if (errorCallBack != null) {
//            tag == null ? errorCallBack(errorMsg) : errorCallBack(errorMsg, tag);
          }
          LogUtils.printLog('errorMsg: $errorMsg');
          DioError error = DioError(message: errorMsg);
          return error;
        } else if (!url.contains(HttpOptions.getVerificationCodeForLoginUrl) &&
            response.data is Map &&
            response.data['code'] is int) {
          if (errorCallBack != null) {
            errorMsg = '系统异常，请联系管理员：' + response.data['code'].toString();
//            tag == null ? errorCallBack(errorMsg) : errorCallBack(errorMsg, tag);
            DioError error = DioError(message: errorMsg);
            return error;
          }
        }
//        return response.data["data"]; //
      }, onError: (DioError e) async {
        // 当请求失败时做一些预处理
//        LogUtils.printLog('请求失败response.data：${e.response.data}');
//        LogUtils.printLog('请求失败e：${e.message}');
        if (e.response == null) {
          //请求异常
            String failedDescri = FailedCodeTrans.enTochsTrans(failMsg: e.message);
            LogUtils.printLog('e.message：$failedDescri');
          if (errorCallBack != null) {
            tag == null ? errorCallBack(failedDescri) : errorCallBack(failedDescri, tag);
          }
            return e;
        } else if (e.response.statusCode == 500 &&
            (url.contains(HttpOptions.loginUrl) || url.contains(HttpOptions.loginByPwdUrl))) {
            String failedDescri = FailedCodeTrans.enTochsTrans(failMsg: e.response.data['content']);
          LogUtils.printLog('e.response.data[content]：$failedDescri');
          if (errorCallBack != null) {
            tag == null ? errorCallBack(failedDescri) : errorCallBack(failedDescri, tag);
          }
          return e;
        } else if (e.response?.data['message'] != null) {
          if (e.response.data['message'] == 'Invalid access toke') {
            //access-token过期，需要调用刷新token接口重新获取新的access-token
            refreshToken(callBack: ({String errorMsg}) async {
              if (errorMsg == null) {
                //刷新成功重新调用获取数据的接口
                await _intercept(url, callBack,
                    method: POST,
                    params: params,
                    jsonData: jsonData,
                    formData: formData,
                    errorCallBack: errorCallBack,
                    tag: tag);
              }
            });
          } else {
              String failedDescri = FailedCodeTrans.enTochsTrans(failMsg: e.response.data['message']);
              LogUtils.printLog('e.response.datamessage:$failedDescri');
            if (errorCallBack != null) {
              tag == null ? errorCallBack(failedDescri) : errorCallBack(failedDescri, tag);
            }
          }
          return e;
        } else {
            String failedDescri = FailedCodeTrans.enTochsTrans(failMsg: e.message);
            LogUtils.printLog('failedDescri:$failedDescri');
          if (errorCallBack != null) {
            tag == null ? errorCallBack(failedDescri) : errorCallBack(failedDescri, tag);
          }
          return e;
        }
//        else if(e.response.statusCode == 400 && e.response.data['message'].toString().contains('Invalid refresh token')){
//
//        }
      }))
//      ..add(LogInterceptor(responseBody: false))
      ..add(CookieManager(CookieJar()));
//    dio.cookieJar = new CookieJar();
//    dio.cookieJar=new PersistCookieJar("./cookies");
//    Directory appDocDir = await getApplicationDocumentsDirectory();
//    String cookiesDir = '${appDocDir.path}/cookies';
//    Directory(Constant.cookiesDir).create().then((Directory dir) {
//      print('cookiesDir:${Constant.cookiesDir}');
//    });
//    Directory(Constant.cookiesDir).create();
//    dio.cookieJar = new PersistCookieJar(Constant.cookiesDir);
//    int statusCode;
//    String errorMsg;
    await _request(dio, url, callBack,
        method: method,
        params: params,
        jsonData: jsonData,
        formData: formData,
        errorCallBack: errorCallBack,
        tag: tag,
        cancelToken: cancelToken);
  }

  static Future<void> _request(Dio dio, String url, Function callBack,
      {String method,
      Map<String, dynamic> params,
      String jsonData,
      FormData formData,
      Function errorCallBack,
      var tag,
      CancelToken cancelToken}) async {
    try {
      Response response;
      if (method == GET) {
        //GET请求
        if (params != null && params.isNotEmpty) {
//          FormData formData = new FormData.from(params);
          if (HttpOptions.isInDebugMode) _urlPrint(url, params: params);
          response = await dio.get(url, queryParameters: params);
        } else {
          if (HttpOptions.isInDebugMode) _urlPrint(url);
          response = await dio.get(url);
        }
      } else {
        //POST请求
        if (params != null && params.isNotEmpty) {
//          FormData formData = new FormData.from(params);
//          print('formData:$formData');
          if (HttpOptions.isInDebugMode) _urlPrint(url, params: params);
          response = await dio.post(url, queryParameters: params);
//          print('response header:${response.headers}');
        } else if (jsonData != null && jsonData.isNotEmpty) {
          if (HttpOptions.isInDebugMode) _urlPrint(url, jsonData: jsonData);
          response = await dio.post(url, data: jsonData);
        } else if (formData != null && formData.isNotEmpty) {
          if (HttpOptions.isInDebugMode) _urlPrint(url, formData: formData);
          response = await dio.post(url, data: formData, cancelToken: cancelToken); //文件上传，增加取消（防止文件太大）
        } else {
          if (HttpOptions.isInDebugMode) _urlPrint(url);
          response = await dio.post(url);
        }
      }
//      print('response data: ' + response.data.toString());
      String responseData = json.encode(response.data).trim();
      if ((responseData?.length ?? 0) > 10000) {
        //避免数据过大，打印后会异常
        LogUtils.printLog('response data: ' + responseData.substring(0, 10000));
      } else {
        LogUtils.printLog('response data: ' + responseData);
      }
//      statusCode = response.statusCode;
//      LogUtils.printLog('status:' + response.statusCode.toString());
//      if (statusCode != 200) {
//        errorMsg = '网络请求出错，状态码：' + statusCode.toString();
//        if (errorCallBack != null) {
//          tag == null ? errorCallBack(errorMsg) : errorCallBack(errorMsg, tag);
//        }
//        LogUtils.printLog('errorMsg: $errorMsg');
//        return;
//      }
      if (callBack != null) {
        //是登录获取验证码接口直接返回statusCode
        if (url.contains(HttpOptions.getVerificationCodeForLoginUrl)) {
          callBack(response.statusCode);
        } else {
          if (tag != null) {
            callBack(response.data, tag);
          } else
            callBack(response.data);
//        print('response data: ' + response.data);
        }
      }
    } on DioError catch (e) {
      LogUtils.printLog(e?.message ?? "");
    }
  }

  ///
  /// 刷新token
  ///
  static void refreshToken({Function callBack}) async {
    SharedPreferences prefs = await SharedPreferencesKey.globalPrefs;
    Map<String, dynamic> params = new Map();
    params['grant_type'] = 'refresh_token';
    params['refresh_token'] = prefs.getString(SharedPreferencesKey.KEY_REFRESH_TOEKN);
//    params['refresh_token'] = '123'; //测试数据
//    String jsonData = json.encode({
//      'mobile': mobile,
//      'smsCode': smsCode,
//    });

    HttpUtil.post(HttpOptions.refreshTokenUrl, (data) => _callBack(data, callBack: callBack),
        params: params, errorCallBack: (errorMsg) => _errorCallBack(errorMsg, callBack: callBack));
  }

  static void _callBack(data, {Function callBack}) async {
    LogUtils.printLog('刷新token:$data');
    LoginModel model = LoginModel.fromJson(data);
    SharedPreferences prefs = await SharedPreferencesKey.globalPrefs;
    prefs.setString(SharedPreferencesKey.KEY_ACCESS_TOEKN, model.accessToken);
    prefs.setString(SharedPreferencesKey.KEY_REFRESH_TOEKN, model.refreshToken);
    if (callBack != null) callBack();
//    notifyListeners();
  }

  static void _errorCallBack(String errorMsg, {Function callBack}) {
    LogUtils.printLog('刷新token接口返回失败：$errorMsg');
//    CommonToast.show(type: TipDialogType.FAIL, msg: errorMsg);
//    if (callBack != null) callBack(errorMsg: errorMsg);
//    navigatorKey.currentState.pushNamedAndRemoveUntil(Constant.pageLogin, (Route<dynamic> route) => false);
    if (errorMsg.contains('Invalid refresh token')) {
      if (mainContext != null) {
        CommonDialog.showAlertDialog(mainContext, content: '登录已过期，请重新登录', contentFontSize: UIData.fontSize16,
            onConfirm: () {
          stateModel.logout();
//          navigatorKey.currentState.pushNamedAndRemoveUntil(Constant.pageLogin, (Route<dynamic> route) => false);
        }, showNegativeBtn: false);
      }
//      else {
//        stateModel.showRefreshTokenFailed = true;
//      }
//      CommonToast.show(msg: '已过期，请重新登录！', type: ToastIconType.INFO);
    } else if(errorMsg.contains('Unauthorized')) {
      if (mainContext != null) {
        CommonDialog.showAlertDialog(mainContext, content: '认证信息有变，请重新登录', contentFontSize: UIData.fontSize16,
            onConfirm: () {
              stateModel.logout();
            }, showNegativeBtn: false);
      }
    }else{
      if (StringsHelper.isNotEmpty(errorMsg)) {
        CommonToast.show(msg: errorMsg, type: ToastIconType.INFO);
      } else {
        CommonToast.show(msg: '凭证刷新失败，请重试！', type: ToastIconType.INFO);
      }
//      else {
//        if (mainContext != null) {
//          CommonDialog.showAlertDialog(mainContext, content: '登录已过期，请重新登录', contentFontSize: UIData.fontSize16,
//              onConfirm: () {
//                navigatorKey.currentState.pushNamedAndRemoveUntil(Constant.pageLogin, (Route<dynamic> route) => false);
//              }, showNegativeBtn: false);
//        }else {
//          stateModel.showRefreshTokenFailed = true;
//        }
//      }
    }
//    Navigator.of(navigatorKey.currentContext).pushNamedAndRemoveUntil(Constant.pageLogin, (Route<dynamic> route) => false);
//    notifyListeners();
  }

//  LogUtils.printLog('Invalid access toke');
//  Map<String, dynamic> params = new Map();
//  params['grant_type'] = 'refresh_token';
//  params['refresh_token'] = prefs.getString(SharedPreferencesKey.KEY_REFRESH_TOEKN);
//  FormData _formData = new FormData.from(params);
//  Dio _dio = new Dio(HttpOptions.getInstance);
//  Options _options = Options(headers: {
//    HttpHeaders.authorizationHeader: 'Basic ${base64.encode(utf8.encode('ums:ums'))}',
//  });
////           options.headers[HttpHeaders.authorizationHeader] = 'Basic ${base64.encode(utf8.encode('ums:ums'))}';
//  Response _response = await _dio.post(HttpOptions.refreshTokenUrl, options: _options, data: _formData);
//  LogUtils.printLog('refesh_token_response：${_response.data}');
//  LogUtils.printLog('refesh_token_response_statusCode：${_response.statusCode}');
//  if (_response.statusCode == 200) {
//  LogUtils.printLog('refresh_token成功');
//  LoginModel model = LoginModel.fromJson(_response.data);
//  prefs.setString(SharedPreferencesKey.KEY_ACCESS_TOEKN, model.accessToken);
//  prefs.setString(SharedPreferencesKey.KEY_REFRESH_TOEKN, model.refreshToken);
//  _request(dio, url, callBack,
//  method: method, params: params, jsonData: jsonData, errorCallBack: errorCallBack, tag: tag);
//  } else {}

  static void _urlPrint(String url, {Map<String, dynamic> params, String jsonData, FormData formData}) {
    String urlStr;
    StringBuffer sb = new StringBuffer();
    sb.write(HttpOptions.baseUrl);
    sb.write(url + '?');
    if (params != null && params.isNotEmpty) {
      params.forEach((key, value) {
//        if (value is String)
        sb.write(key + '=' + value.toString() + '&');
      });
    } else if (jsonData != null && jsonData.isNotEmpty) {
      sb.write(jsonData);
    } else if (formData != null && formData.isNotEmpty) {
      sb.write(formData.keys.map((String key) {
//        return key + '=' + formData[key] is String ? formData[key] :"" + '&';
      }));
    }
    urlStr = sb.toString();
    if ((params != null && params.isNotEmpty) || (formData != null && formData.isNotEmpty))
      urlStr = urlStr.substring(0, urlStr.length - 1);
//    LogUtil.v('url:', tag: urlStr);
//    print("url:  $urlStr");
    LogUtils.printLog("url:  $urlStr");
  }
}
