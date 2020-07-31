import 'dart:convert';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/articles_release_detail_model.dart';
import 'package:cmp_customer/models/articles_release_record_model.dart';
import 'package:cmp_customer/models/common/common_page_model.dart';
import 'package:cmp_customer/models/common_result_model.dart';
import 'package:cmp_customer/models/hot_work_detail_model.dart';
import 'package:cmp_customer/models/hot_work_record_model.dart';
import 'package:cmp_customer/models/project_setting_model.dart';
import 'package:cmp_customer/models/response/entrance_card_house_response.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/strings/strings_house_auth.dart';
import 'package:cmp_customer/ui/articles_release/articles_release_apply_page.dart';
import 'package:cmp_customer/ui/articles_release/articles_release_detail_page.dart';
import 'package:cmp_customer/ui/articles_release/articles_release_record_page.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/hot_work/hot_work_detail_page.dart';
import 'package:cmp_customer/ui/house_authentication/my_house_page.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/failed_code_trans.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

mixin HotWorkStateModel on Model {
  ///
  /// 获取允许申请时间段和允许动火时间段
  ///
  void getHotWorkSetting({Function callBack}) async {
//    CommonToast.show(msg: '数据加载中');
    String jsonData = json.encode({'projectId': stateModel.defaultProjectId});
    HttpUtil.post(HttpOptions.hotWorkSettingUrl, (data) => _hotWorkSettingCallBack(data, callBack: callBack),
        jsonData: jsonData,
        errorCallBack: (errorMsg) => _hotWorkSettingErrorCallBack(errorMsg, callBack: callBack));
  }

  void _hotWorkSettingCallBack(data, {Function callBack}) async {
    CommonToast.dismiss();
    LogUtils.printLog('获取允许申请时间段和允许动火时间段:$data');
    ProjectSettingModel model = ProjectSettingModel.fromJson(data);
    if (model.code == '0') {
      if (model?.projectSetting?.settingDetailList != null && model.projectSetting.settingDetailList.length > 0) {
        SettingDetail settingDetail = model.projectSetting.settingDetailList
            .firstWhere((SettingDetail detail) => detail?.typeCode == 'HOT_WORK_TIME', orElse: () => null);
        if (settingDetail != null) {
          if (callBack != null) callBack(hotWorkTimeInfo: settingDetail?.hotWorkTimeInfo);
        }
      }
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
      if (callBack != null) callBack(failedMsg: failedDescri);
      CommonToast.show(type: ToastIconType.FAILED, msg: failedDescri);
    }
    notifyListeners();
  }

  void _hotWorkSettingErrorCallBack(String errorMsg, {Function callBack}) {
    LogUtils.printLog('接口返回失败：$errorMsg');
//    if (callBack != null) callBack(errorMsg: errorMsg);
    if (callBack != null) callBack(failedMsg: errorMsg);
    CommonToast.show(type: ToastIconType.FAILED, msg: errorMsg);
    notifyListeners();
  }

  ///
  /// 调用动火申请接口
  ///
  void applyHotWork({
    @required HotWorkDetail applyModel,
    bool newCreate,
    VoidCallback callBack,
  }) async {
    CommonToast.show();

    String jsonData = json.encode(applyModel);

    String url;
    if (newCreate)
      url = HttpOptions.applyHotWorkUrl;
    else
      url = HttpOptions.modifyHotWorkUrl;
    HttpUtil.post(
        url,
        (data) {
          _applyHotWorkCallBack(data);
        },
        jsonData: jsonData,
        errorCallBack: (errorMsg) {
          _applyHotWorkErrorCallBack(errorMsg);
        });
  }

  void _applyHotWorkCallBack(data) {
    CommonResultModel model = CommonResultModel.fromJson(data);
    LogUtils.printLog('动火申请:${json.encode(data)}');
    if (model.code == '0') {
      CommonToast.show(msg: '申请成功', type: ToastIconType.SUCCESS);
      navigatorKey.currentState.pop(true);
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
      CommonToast.show(msg: failedDescri, type: ToastIconType.FAILED);
    }
    notifyListeners();
  }

  void _applyHotWorkErrorCallBack(errorMsg) {
    LogUtils.printLog('接口返回失败');
    CommonToast.show(msg: errorMsg, type: ToastIconType.FAILED);
    notifyListeners();
  }

  ///
  /// 物品放行申请记录列表
  /// [customerType] 查询类型，业主查询租户申请：0，查询自己的申请：1
  ///
  void loadHotWorkRecordList(ListPageModel pageModel, int customerType, {bool preRefresh = false}) {
    pageModel.listPage.listState = ListState.HINT_LOADING;
    if (preRefresh) notifyListeners();
    pageModel.listPage.currentPage = 1;
    pageModel.listPage.maxCount = false;
    pageModel.list.clear();
//    print('_orderAllMap[page.tag]:${_orderAllMap[page]}');
//    if (entranceHistoryList != null) entranceHistoryList.clear();
    _getHotWorkRecordList(pageModel, customerType);
  }

//  Future<void> hotWorkRecordHandleRefresh({@required TaskPageController controller, bool preRefresh = false}) async {
//    loadTaskList(controller:controller,preRefresh: preRefresh);
//  }

  ///
  /// [customerType] 查询类型，业主查询租户申请：0，查询自己的申请：1
  ///
  hotWorkRecordHandleLoadMore(ListPageModel pageModel, int customerType) {
    pageModel.listPage.currentPage++;
    if (!pageModel.listPage.maxCount) {
      _getHotWorkRecordList(pageModel, customerType);
    }
  }

  ///
  /// [customerType] 查询类型，业主查询租户申请：0，查询自己的申请：1
  ///
  _getHotWorkRecordList(ListPageModel pageModel, int customerType) async {
    Map<String, dynamic> params = new Map();
    params['current'] = pageModel.listPage.currentPage;
    params['pageSize'] = HttpOptions.pageSize.toString();
    params['projectId'] = [stateModel.defaultProjectId];
    //customerType为1时，提交customerId， 0时提交ownerId，放入customerId的值
    if (customerType == 1)
      params['customerId'] = stateModel.customerId;
    else
      params['ownerId'] = stateModel.customerId;
    String jsonData = json.encode(params);

    HttpUtil.post(
        HttpOptions.hotWorkListUrl,
        (data) {
          _hotWorkRecordCallBack(data, pageModel);
        },
        jsonData: jsonData,
        errorCallBack: (errorMsg) {
          _hotWorkRecordErrorCallBack(errorMsg, pageModel);
        });
  }

  void _hotWorkRecordCallBack(data, ListPageModel pageModel) {
    HotWorkRecordModel model = HotWorkRecordModel.fromJson(data);
    LogUtils.printLog('动火申请记录列表:$data');
    if (model.code == '0') {
      if (model.hotWorkList != null && model.hotWorkList.length > 0) {
        pageModel.listPage.listState = ListState.HINT_DISMISS;
        if (pageModel.listPage.currentPage == 1) {
          //刷新操作，清空数据再添加（防止多次刷新请求导致数据重复添加）
          pageModel.list.clear();
        }
        pageModel.list.addAll(model.hotWorkList);
        if (model.hotWorkList.length < HttpOptions.pageSize) pageModel.listPage.maxCount = true;
//        }
      } else {
        if (pageModel.list == null || pageModel.list.isEmpty) {
          //nodata
          pageModel.listPage.listState = ListState.HINT_NO_DATA_CLICK;
          pageModel.list.clear();
        } else {
          //已到列表最底
          pageModel.listPage.maxCount = true;
        }
      }
    } else {
//      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
      pageModel.listPage.listState = ListState.HINT_LOADED_FAILED_CLICK;
    }
    notifyListeners();
  }

  void _hotWorkRecordErrorCallBack(errorMsg, ListPageModel pageModel) {
    LogUtils.printLog('接口返回失败');
    pageModel.listPage.listState = ListState.HINT_LOADED_FAILED_CLICK;
    notifyListeners();
  }

  ///
  /// 调用动火详情接口
  ///
  void getHotWorkDetail(
    int id,
    HotWorkPageModel pageModel, {
    VoidCallback callBack,
  }) async {
    pageModel.pageState = ListState.HINT_LOADING;
    notifyListeners();
    Map<String, dynamic> params = new Map();
    params['hotWorkId'] = id;
    String jsonData = json.encode(params);

    HttpUtil.post(
        HttpOptions.hotWorkDetailUrl,
        (data) {
          _hotWorkDetailCallBack(data, pageModel);
        },
        jsonData: jsonData,
        errorCallBack: (errorMsg) {
          _hotWorkDetailErrorCallBack(errorMsg, pageModel);
        });
  }

  void _hotWorkDetailCallBack(data, HotWorkPageModel pageModel) {
    HotWorkDetailModel model = HotWorkDetailModel.fromJson(data);
    LogUtils.printLog('动火申请详情:${json.encode(data)}');
    if (model.code == '0') {
      pageModel.hotWorkDetail = model.hotWorkDetail;
      pageModel.pageState = ListState.HINT_DISMISS;
    } else {
      pageModel.pageState = ListState.HINT_LOADED_FAILED_CLICK;
//      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
    }
    notifyListeners();
  }

  void _hotWorkDetailErrorCallBack(errorMsg, HotWorkPageModel pageModel) {
    LogUtils.printLog('接口返回失败');
    pageModel.pageState = ListState.HINT_LOADED_FAILED_CLICK;
    notifyListeners();
  }

  ///
  /// 更改动火申请状态
  ///
  void changeHotWorkStatus(
    int id,
    String processNodeCode, {
    int passFlag,
    String remark,
    List attDhYzSignList,
    VoidCallback callBack,
  }) async {
    CommonToast.show();

    Map<String, dynamic> params = new Map();
    params['hotWorkId'] = id;
    params['processNodeCode'] = processNodeCode;
    params['passFlag'] = passFlag;
    params['processContent'] = remark;
    if(attDhYzSignList != null && attDhYzSignList.length > 0){
      params['attDhYzSignList'] = attDhYzSignList;
    }
    String jsonData = json.encode(params);

    HttpUtil.post(
        HttpOptions.hotWorkChangeStatusUrl,
        (data) {
          _changeHotWorkStatusCallBack(data, callBack: callBack);
        },
        jsonData: jsonData,
        errorCallBack: (errorMsg) {
          _changeHotWorkStatusErrorCallBack(errorMsg);
        });
  }

  void _changeHotWorkStatusCallBack(data, {VoidCallback callBack}) {
    CommonResultModel model = CommonResultModel.fromJson(data);
    LogUtils.printLog('更改动火申请状态:${json.encode(data)}');
    if (model.code == '0') {
      CommonToast.show(msg: '提交成功', type: ToastIconType.SUCCESS);
      navigatorKey.currentState.pop();
      if (callBack != null) callBack();
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
      CommonToast.show(msg: failedDescri, type: ToastIconType.FAILED);
    }
//    notifyListeners();
  }

  void _changeHotWorkStatusErrorCallBack(errorMsg) {
    LogUtils.printLog('接口返回失败');
    CommonToast.show(msg: errorMsg, type: ToastIconType.FAILED);
//    notifyListeners();
  }

  static HotWorkStateModel of(context) => ScopedModel.of<HotWorkStateModel>(context);
}
