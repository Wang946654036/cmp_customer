import 'dart:convert';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/access_pass_model.dart';
import 'package:cmp_customer/models/articles_release_detail_model.dart';
import 'package:cmp_customer/models/articles_release_record_model.dart';
import 'package:cmp_customer/models/common/common_page_model.dart';
import 'package:cmp_customer/models/common_result_model.dart';
import 'package:cmp_customer/models/response/entrance_card_house_response.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/strings/strings_articles_release.dart';
import 'package:cmp_customer/strings/strings_house_auth.dart';
import 'package:cmp_customer/ui/articles_release/articles_release_apply_page.dart';
import 'package:cmp_customer/ui/articles_release/articles_release_detail_page.dart';
import 'package:cmp_customer/ui/articles_release/articles_release_record_page.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/house_authentication/my_house_page.dart';
import 'package:cmp_customer/ui/html/html_page.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/failed_code_trans.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/shared_preferences_key.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

mixin AccessPassStateModel on Model {
  ///
  /// 调用社区放行列表接口判断跳转页面
  ///
  void getAccessPassInfo({
    VoidCallback callBack,
  }) async {
    Map<String, dynamic> params = new Map();
    params['projectId'] = stateModel.defaultProjectId;
    String jsonData = json.encode(params);

    HttpUtil.post(
        HttpOptions.getAccessPassListUrl,
        (data) {
          _accessPassInfoCallBack(data);
        },
        jsonData: jsonData,
        errorCallBack: (errorMsg) {
          _accessPassInfoErrorCallBack(errorMsg);
        });
  }

  void _accessPassInfoCallBack(data) async {
    AccessPassModel model = AccessPassModel.fromJson(data);
    LogUtils.printLog('社区放行信息:${json.encode(data)}');
    if (model.code == '0') {
      SharedPreferences prefs = await SharedPreferencesKey.globalPrefs;
      String token = prefs.getString(SharedPreferencesKey.KEY_ACCESS_TOEKN);
      if (model.AccessPassList == null || model.AccessPassList.length == 0) {
        //通行证列表为空则跳转申请页面
        Navigate.toNewPage(HtmlPage(HttpOptions.accessPassApplyUrl(token, stateModel.defaultProjectId), '社区通行'));
      } else if (model.AccessPassList.length == 1) {
        //通行证列表不为空并有一条数据则跳转二维码预览界面
        Navigate.toNewPage(HtmlPage(HttpOptions.accessPassQRCodeUrl(token, model.AccessPassList[0].id), '社区通行'));
      } else {
        //通行证列表不为空并有多条数据则跳转通行证列表界面
        Navigate.toNewPage(HtmlPage(HttpOptions.accessPassListUrl(token, stateModel.defaultProjectId), '社区通行'));
      }
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
      CommonToast.show(msg: failedDescri, type: ToastIconType.FAILED);
    }
  }

  void _accessPassInfoErrorCallBack(errorMsg) {
    LogUtils.printLog('社区放行信息接口返回失败');
    CommonToast.show(msg: errorMsg, type: ToastIconType.FAILED);
  }

  static AccessPassStateModel of(context) => ScopedModel.of<AccessPassStateModel>(context);
}
