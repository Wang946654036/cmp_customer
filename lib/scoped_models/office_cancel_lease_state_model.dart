import 'dart:convert';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/common/common_page_model.dart';
import 'package:cmp_customer/models/common_result_model.dart';
import 'package:cmp_customer/models/office_cancel_lease_detail_model.dart';
import 'package:cmp_customer/models/office_cancel_lease_record_model.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/office_cancel_lease/office_cancel_lease_detail_page.dart';
import 'package:cmp_customer/ui/office_cancel_lease/office_cancel_lease_record_page.dart';
import 'package:cmp_customer/ui/office_cancel_lease/rectify_complete_page.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/failed_code_trans.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

mixin OfficeCancelLeaseStateModel on Model {
  ///
  /// 调用申请写字楼退租接口
  ///
  void applyOfficeCancelLease({
    @required OfficeCancelLeaseDetail applyModel,
    bool newCreate,
    VoidCallback callBack,
  }) async {
    CommonToast.show();

    String jsonData = json.encode(applyModel);

    String url;
    if (newCreate)
      url = HttpOptions.applyOfficeCancelLeaseUrl;
    else
      url = HttpOptions.modifyOfficeCancelLeaseUrl;
    HttpUtil.post(
        url,
        (data) {
          _applyOfficeCancelLeaseCallBack(data);
        },
        jsonData: jsonData,
        errorCallBack: (errorMsg) {
          _applyOfficeCancelLeaseErrorCallBack(errorMsg);
        });
  }

  void _applyOfficeCancelLeaseCallBack(data) {
    CommonResultModel model = CommonResultModel.fromJson(data);
    LogUtils.printLog('申请写字楼退租:${json.encode(data)}');
    if (model.code == '0') {
      CommonToast.show(msg: '申请成功', type: ToastIconType.SUCCESS);
      navigatorKey.currentState.pop(true);
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
      CommonToast.show(msg: failedDescri, type: ToastIconType.FAILED);
    }
    notifyListeners();
  }

  void _applyOfficeCancelLeaseErrorCallBack(errorMsg) {
    LogUtils.printLog('接口返回失败');
    CommonToast.show(msg: errorMsg, type: ToastIconType.FAILED);
    notifyListeners();
  }

  ///
  /// 物品写字楼退租记录列表
  ///
  void loadOfficeCancelLeaseRecordList(ListPageModel pageModel, OfficeCancelLeaseFilterModel filterModel,
      {bool preRefresh = false}) {
    pageModel.listPage.listState = ListState.HINT_LOADING;
    if (preRefresh) notifyListeners();
    pageModel.listPage.currentPage = 1;
    pageModel.listPage.maxCount = false;
    pageModel.list.clear();
//    print('_orderAllMap[page.tag]:${_orderAllMap[page]}');
//    if (entranceHistoryList != null) entranceHistoryList.clear();
    _getOfficeCancelLeaseRecordList(pageModel, filterModel);
  }

//  Future<void> officeCancelLeaseRecordHandleRefresh({@required TaskPageController controller, bool preRefresh = false}) async {
//    loadTaskList(controller:controller,preRefresh: preRefresh);
//  }

  officeCancelLeaseRecordHandleLoadMore(ListPageModel pageModel, OfficeCancelLeaseFilterModel filterModel) {
    pageModel.listPage.currentPage++;
    if (!pageModel.listPage.maxCount) {
      _getOfficeCancelLeaseRecordList(pageModel, filterModel);
    }
  }

  _getOfficeCancelLeaseRecordList(ListPageModel pageModel, OfficeCancelLeaseFilterModel filterModel) async {
    Map<String, dynamic> params = new Map();
    params['current'] = pageModel.listPage.currentPage;
    params['pageSize'] = HttpOptions.pageSize.toString();
    params['projectId'] = stateModel.defaultProjectId;
    params['startTime'] = filterModel.startTime;
    params['endTime'] = filterModel.endTime;
//    params['customerId'] = stateModel.customerId;
//    params['status'] =  filterModel.statusList!=null&&filterModel.statusList.length>0?json.encode(filterModel.statusList):null;//转json文本
    params['status'] =  filterModel.statusList;
    String jsonData = json.encode(params);
LogUtils.printLog('$jsonData');
    HttpUtil.post(
        HttpOptions.officeCancelLeaseListUrl,
        (data) {
          _officeCancelLeaseRecordCallBack(data, pageModel);
        },
        jsonData: jsonData,
//        params: params,
        errorCallBack: (errorMsg) {
          _officeCancelLeaseRecordErrorCallBack(errorMsg, pageModel);
        });
  }

  void _officeCancelLeaseRecordCallBack(data, ListPageModel pageModel) {
    OfficeCancelLeaseRecordModel model = OfficeCancelLeaseRecordModel.fromJson(data);
    LogUtils.printLog('写字楼退租申请记录列表:$data');
    if (model.code == '0') {
      if (model.officeCancelLeaseList != null && model.officeCancelLeaseList.length > 0) {
        pageModel.listPage.listState = ListState.HINT_DISMISS;
        if(pageModel.listPage.currentPage==1){//刷新操作，清空数据再添加（防止多次刷新请求导致数据重复添加）
          pageModel.list.clear();
        }
        pageModel.list.addAll(model.officeCancelLeaseList);
        if (model.officeCancelLeaseList.length < HttpOptions.pageSize) pageModel.listPage.maxCount = true;
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

  void _officeCancelLeaseRecordErrorCallBack(errorMsg, ListPageModel pageModel) {
    LogUtils.printLog('接口返回失败');
    pageModel.listPage.listState = ListState.HINT_LOADED_FAILED_CLICK;
    notifyListeners();
  }

  ///
  /// 调用写字楼退租详情接口
  ///
  void getOfficeCancelLeaseDetail(
      int id,
      OfficeCancelLeasePageModel pageModel, {
        VoidCallback callBack,
      }) async {
    pageModel.pageState = ListState.HINT_LOADING;
    notifyListeners();
    Map<String, dynamic> params = new Map();
    params['officeSurrenderId'] = id;
    String jsonData = json.encode(params);

    HttpUtil.post(
        HttpOptions.officeCancelLeaseDetailUrl,
            (data) {
          _officeCancelLeaseDetailCallBack(data, pageModel);
        },
        jsonData: jsonData,
        errorCallBack: (errorMsg) {
          _officeCancelLeaseDetailErrorCallBack(errorMsg, pageModel);
        });
  }

  void _officeCancelLeaseDetailCallBack(data, OfficeCancelLeasePageModel pageModel) {
    OfficeCancelLeaseDetailModel model = OfficeCancelLeaseDetailModel.fromJson(data);
    LogUtils.printLog('物品放行详情:${json.encode(data)}');
    if (model.code == '0') {
      pageModel.officeCancelLeaseDetail = model.officeCancelLeaseDetail;
      pageModel.pageState = ListState.HINT_DISMISS;
    } else {
      pageModel.pageState = ListState.HINT_LOADED_FAILED_CLICK;
//      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
    }
    notifyListeners();
  }

  void _officeCancelLeaseDetailErrorCallBack(errorMsg, OfficeCancelLeasePageModel pageModel) {
    LogUtils.printLog('接口返回失败');
    pageModel.pageState = ListState.HINT_LOADED_FAILED_CLICK;
    notifyListeners();
  }

  ///
  /// 写字楼退租取消申请
  ///
  void cancelOfficeCancelLease(int id, {
    VoidCallback callBack,
  }) async {
    CommonToast.show();

    Map<String, dynamic> params = new Map();
    params['officeSurrenderId'] = id;
    params['operateStep'] = 'XZLTZ_QXSQ';
    String jsonData = json.encode(params);

    HttpUtil.post(
        HttpOptions.changeStatusOfficeCancelLeaseUrl,
            (data) {
          _cancelOfficeCancelLeaseCallBack(data, callBack: callBack);
        },
        jsonData: jsonData,
        errorCallBack: (errorMsg) {
          _cancelOfficeCancelLeaseErrorCallBack(errorMsg);
        });
  }

  void _cancelOfficeCancelLeaseCallBack(data, {VoidCallback callBack}) {
    CommonResultModel model = CommonResultModel.fromJson(data);
    LogUtils.printLog('写字楼退租取消申请:${json.encode(data)}');
    if (model.code == '0') {
      CommonToast.show(msg: '取消成功', type: ToastIconType.SUCCESS);
    if(callBack != null) callBack();
      navigatorKey.currentState.pop();
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
      CommonToast.show(msg: failedDescri, type: ToastIconType.FAILED);
    }
//    notifyListeners();
  }

  void _cancelOfficeCancelLeaseErrorCallBack(errorMsg) {
    LogUtils.printLog('接口返回失败');
    CommonToast.show(msg: errorMsg, type: ToastIconType.FAILED);
//    notifyListeners();
  }

  ///
  /// 整改完成
  ///
  void rectifyCompleteOfficeCancelLease(
      RectifyCompleteModel rectifyModel, {
        VoidCallback callBack,
      }) async {
    CommonToast.show();
    rectifyModel.operateStep = 'XZLTZ_ZGWC';
    String jsonData = json.encode(rectifyModel);

    HttpUtil.post(
        HttpOptions.changeStatusOfficeCancelLeaseUrl,
            (data) {
          _rectifyCompleteOfficeCancelLeaseCallBack(data, callBack: callBack);
        },
        jsonData: jsonData,
        errorCallBack: (errorMsg) {
          _rectifyCompleteOfficeCancelLeaseErrorCallBack(errorMsg);
        });
  }

  void _rectifyCompleteOfficeCancelLeaseCallBack(data, {VoidCallback callBack}) {
    CommonResultModel model = CommonResultModel.fromJson(data);
    LogUtils.printLog('写字楼退租整改完成:${json.encode(data)}');
    if (model.code == '0') {
      CommonToast.show(msg: '提交成功', type: ToastIconType.SUCCESS);
//      if(callBack != null) callBack();
      navigatorKey.currentState.pop(true);
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
      CommonToast.show(msg: failedDescri, type: ToastIconType.FAILED);
    }
//    notifyListeners();
  }

  void _rectifyCompleteOfficeCancelLeaseErrorCallBack(errorMsg) {
    LogUtils.printLog('接口返回失败');
    CommonToast.show(msg: errorMsg, type: ToastIconType.FAILED);
//    notifyListeners();
  }

  static OfficeCancelLeaseStateModel of(context) => ScopedModel.of<OfficeCancelLeaseStateModel>(context);
}
