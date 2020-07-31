import 'dart:convert';
import 'dart:io';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/common_result_model.dart';
import 'package:cmp_customer/models/request/entrance_card_apply_request.dart';
import 'package:cmp_customer/models/response/activity_info_response.dart';
import 'package:cmp_customer/models/response/base_response.dart';
import 'package:cmp_customer/models/response/entrance_card_details_response.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_apply.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_operation_step.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_state.dart';
import 'package:cmp_customer/utils/common_event_bus.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/shared_preferences_key.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tip_dialog/tip_dialog.dart';
import 'package:toast/toast.dart';

import 'base_model.dart';

class ActivityStateModel extends BaseModel {
  //获取活动
  queryActivity(Function callback) {
    Map<String, Object> params = new Map();
    params['projectId'] = stateModel.defaultProjectId;
    params['location'] = "0";
    HttpUtil.post(HttpOptions.queryActivity, (data) {
      _queryActivityCallBack(data, callback);
    }, jsonData: json.encode(params));
  }

  //获取活动回调
  _queryActivityCallBack(data, Function callback) {
    ActivityInfoResponse response = ActivityInfoResponse.fromJson(data);
    if (response != null) {
      if (response.success() &&
          (response.data?.themePic?.isNotEmpty ?? false)) {
        _downloadActivityImage(callback, response.data);
      }
    }
  }

  //下载活动图片
  _downloadActivityImage(Function callback, ActivityInfo info) async {
    final Directory tempDir = await getTemporaryDirectory();
    String themeFilePath = "${tempDir.path}/${info.themePic}";
    info.themeFilePath = themeFilePath;
    File file = new File(themeFilePath);
    Dio dio = new Dio(HttpOptions.getInstance);
//    SharedPreferences prefs = await SharedPreferencesKey.globalPrefs;
//    dio.interceptors
//      ..add(InterceptorsWrapper(onRequest: (RequestOptions options) {
//        // 在请求被发送之前做一些事情
//        options.headers[HttpHeaders.authorizationHeader] =
//            'Bearer ${prefs.getString(SharedPreferencesKey.KEY_ACCESS_TOEKN)}';
//        return options;
//      }));
    Map<String, dynamic> map = new Map();
    map["Accept-Encoding"] = "identity"; //https长度返回-1，在此添加参数后正常
    Options options = Options(receiveTimeout: 900000, headers: map);
    Response response = await dio
        .head(HttpOptions.showPhotoUrl(info.themePic), options: options);
    int adLength = response?.headers?.contentLength;
    if (await file.exists()) {
      //文件存在
      int fileLength = await file.length();
      if (fileLength == adLength) {
        //已下载直接返回
        callback(info);
        return;
      }
    }
    //需要重新下载
    dio.download(HttpOptions.showPhotoUrl(info.themePic), themeFilePath,
        options: Options(receiveTimeout: 900000),
        onReceiveProgress: (int received, int total) async {
      LogUtils.printLog("$received\_$total");
      if (received == total) {
        //下载完成
        callback(info);
      }
    });
  }
}
