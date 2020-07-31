import 'dart:convert';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/models/common_result_model.dart';
import 'package:cmp_customer/models/dictionary_list.dart';
import 'package:cmp_customer/models/html_healthy_token_model.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/html/html_page.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:scoped_model/scoped_model.dart';

import '../main.dart';

//第三方html
mixin HtmlStateModel on Model {
  // 插件提供的对象，该对象用于WebView的各种操作
  FlutterWebviewPlugin flutterWebViewPlugin;

  //预约挂号的Token验证(mobile和account用的是同一个手机号码)
  getHealthyToken(String mobile) {
    CommonToast.show(msg: "请求中...");
    String jsonData = json.encode({
      'mobile': mobile,
      'account': mobile,
    });
    HttpUtil.post(HttpOptions.healthUrl, _getHealthyTokenCallBack,
        jsonData: jsonData, errorCallBack: _errorCallBack);
  }

  _getHealthyTokenCallBack(data) {
    CommonToast.dismiss();
    try {
      HtmlHealthyTokenModel model = HtmlHealthyTokenModel.fromJson(data);
      if (model.success() && model.healthyInfo != null) {
        String url = HttpOptions.getHealthUrl(model.healthyInfo.url,
            model.healthyInfo.cid, model.healthyInfo.token);
        Navigate.toNewPage(HtmlPage(url, "预约挂号"));
      } else {
        _errorCallBack(model.message);
      }
    } catch (e) {
      _errorCallBack('请求异常，参数返回错误');
    }
  }

  //到家钱包的Token验证(mobile和account用的是同一个手机号码)
  getPurseUrl(int id, {Function callback}) {
    CommonToast.show(msg: "请求中...");
    String jsonData = json.encode({
      'custId': id,
    });
    HttpUtil.post(HttpOptions.purseUrl,
        (data) => _getPurseTokenCallBack(data, callback: callback),
        jsonData: jsonData, errorCallBack: _errorCallBack);
  }

  _getPurseTokenCallBack(data, {Function callback}) {
    CommonToast.dismiss();
    try {
      CommonResultModel model = CommonResultModel.fromJson(data);
//      HtmlHealthyTokenModel model = HtmlHealthyTokenModel.fromJson(data);
      if (model.success() && model.data != null && model.data['url'] != null) {
        String url = model.data['url'];
        if (url == 'building') {
          if (callback != null) callback(false);
        } else {
          url = url.replaceAll('isDisplay=1', 'isDisplay=0'); //移除标题栏显示
          LogUtils.printLog('到家url:$url');
          Navigate.toNewPage(HtmlPage(url, "到家钱包"));
        }
      } else {
        _errorCallBack(model.message);
      }
    } catch (e) {
      _errorCallBack('请求异常，参数返回错误');
    }
  }

  //充值中心的token验证
  getBeeUrl() {
    CommonToast.show(msg: "请求中...");
    HttpUtil.post(HttpOptions.beeUrl, _getBeeUrlCallBack,
        errorCallBack: _errorCallBack);
  }

  _getBeeUrlCallBack(data) {
    CommonToast.dismiss();
    try {
      CommonResultModel model = CommonResultModel.fromJson(data);
      if (model.success() && model.data != null && model.data['url'] != null) {
        String url = model.data['url'];
        LogUtils.printLog('充值中心url:$url');
        Navigate.toNewPage(HtmlPage(url, "充值中心"));
      } else {
        _errorCallBack(model.message);
      }
    } catch (e) {
      _errorCallBack('请求异常，参数返回错误');
    }
  }

  _errorCallBack(data) {
    LogUtils.printLog('error:$data');
    CommonToast.show(msg: data, type: ToastIconType.FAILED);
  }


  //商城
  getMallLink({Function callback}) {
//    CommonToast.show(msg: "请求中...");
    String jsonData = json.encode({
      "dataSubType": "DJH_SC_URL",
      "dataType": "DJH_MENU_URL",
    });
    HttpUtil.post(HttpOptions.findDataDictionaryList, (data)=> _mallLinkCallBack(data, callback: callback),
        jsonData: jsonData, errorCallBack: (data)=> _mallLinkErrorCallBack(data, callback: callback));
  }

  _mallLinkCallBack(data, {Function callback}) {
//    CommonToast.dismiss();
    try {
      DictionaryList model = DictionaryList.fromJson(data);
      if (model.code == '0') {
        if(model?.data != null && model.data.length > 0){
          String url = model.data[0].dataCode;
          if(StringsHelper.isNotEmpty(url)){
            if(callback != null) callback(url: url, state: ListState.HINT_DISMISS);
          }else {
            if(callback != null) callback(state: ListState.HINT_NO_DATA_CLICK);
          }
        }else {
          if(callback != null) callback(state: ListState.HINT_NO_DATA_CLICK);
        }
      } else {
        if(callback != null) callback(state: ListState.HINT_LOADED_FAILED_CLICK);
      }
    } catch (e) {
//      _mallLinkErrorCallBack('请求异常，参数返回错误');
      if(callback != null) callback(state: ListState.HINT_LOADED_FAILED_CLICK);
    }
  }

  _mallLinkErrorCallBack(data, {Function callback}) {
    LogUtils.printLog('商城error:$data');
//    CommonToast.show(msg: data, type: ToastIconType.FAILED);
    if(callback != null) callback(state: ListState.HINT_LOADED_FAILED_CLICK);
  }


  //美伦体检
  getMeiLunUrl({Function callback}) {
    CommonToast.show(msg: "请求中...");
    String jsonData = json.encode({
      'custAppId': stateModel.accountId,
    });
    HttpUtil.post(HttpOptions.getMeiLunUrl, (data)=>  _getMeiLunUrlCallBack(data, callback: callback),
        jsonData: jsonData, errorCallBack: _errorCallBack);
  }

  _getMeiLunUrlCallBack(data, {Function callback}) {
    CommonToast.dismiss();
    try {
      CommonResultModel model = CommonResultModel.fromJson(data);
      if (model.success()) {
        String url = model.data;
        if(callback != null) callback(url);

      } else {
        _errorCallBack(model.message);
      }
    } catch (e) {
      _errorCallBack('请求异常，参数返回错误');
    }
  }
}
