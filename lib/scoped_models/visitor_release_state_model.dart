import 'dart:convert';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/new_house_detail_list_model.dart';
import 'package:cmp_customer/models/new_house_model.dart';

import 'package:cmp_customer/models/property_change_user_param.dart';
import 'package:cmp_customer/models/response/base_response.dart';
import 'package:cmp_customer/models/visit_setting.dart';
import 'package:cmp_customer/models/visitor_release_detail_list_model.dart';
import 'package:cmp_customer/models/visitor_release_detail_model.dart';
import 'package:cmp_customer/ui/common/car_number_input_keyboard.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/failed_code_trans.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

enum VisitorReleaseHttpType { SAVE, ACCEPT }

class VisitorReleaseStateModel extends Model {
  ListState visitorReleaseInfoState = ListState.HINT_LOADING;

  ListState visitorReleaseInfoListState = ListState.HINT_LOADING;

  ListState visitorReleaseCommitState = ListState.HINT_DISMISS;
  VisitorReleaseDetail visitorReleaseDetail;

  int _listCurrentPage = 1; //从第一页开始
//  int historyTotalCount = 0;
  bool maxCount = false;

  List<VisitorReleaseDetail> visitorReleaseInfoList;
  String plateNumber; //用于车牌号输入框显示和赋值
  bool showCarNoInputView = false; //是否显示车牌号键盘
  GlobalKey<CarNoInputKeyboardState> carNoInputKey = GlobalKey();

  ///  //新建
//  static String createHouseJoin = 'business/housejoin/createHouseJoin';
//  //编辑
//  static String editHouseJoin = 'business/housejoin/editHouseJoin';
//  //分页获取-新房入伙业务办理操作记录表
//  static String findHouseJoinPage = 'business/housejoin/findHouseJoinPage';
//  //详情
//  static String getHouseJoinDetailById = 'business/housejoin/getHouseJoinDetailById';

  void setCarNo(String carNo) {
    plateNumber = carNo;
    showCarNoInputView = false;
    notifyListeners();
  }

  void setCarInfo(String carNo) {
    plateNumber = carNo;
    LogUtils.printLog('车牌号：${carNo}');
    showCarNoInputView = true;
    carNoInputKey.currentState.refreshCarNo(carNo ?? '');
    notifyListeners();
  }

  Future<void> visitorReleaseIsPass(
    Map<String, dynamic> params, {
    Function callback,
    VisitorReleaseHttpType visitorReleaseType,
  }) async {
    CommonToast.show();
    if (visitorReleaseCommitState != ListState.HINT_LOADING) {
      visitorReleaseCommitState = ListState.HINT_LOADING;
      String url = HttpOptions.addAppointmentVisitInfo;
      switch (visitorReleaseType) {
        case VisitorReleaseHttpType.SAVE:
          url = HttpOptions.addAppointmentVisitInfo;
          break;
//
        case VisitorReleaseHttpType.ACCEPT:
          url = HttpOptions.authorizeAppointmentVisit;
          break;
        default:
          break;
      }

      HttpUtil.post(url, (data) {
        _uploadApplyDataCallBack(data, callback: callback);
      }, jsonData: jsonEncode(params), errorCallBack: _errorCallBack);
    }
  }

//通用网络请求错误回调
  _errorCallBack(data) {
    CommonToast.show(
        type: ToastIconType.FAILED, msg: "提交异常：" + data?.toString());
    visitorReleaseCommitState = ListState.HINT_DISMISS;
  }

//申请成功
  _uploadApplyDataCallBack(data, {Function callback}) {
    try {
      BaseResponse resultModel = BaseResponse.fromJson(data);
      if (resultModel != null) {
        if (resultModel.success()) {
          CommonToast.show(type: ToastIconType.SUCCESS, msg: "提交成功");

          if (callback != null) {
            callback();
          } else {
            Navigate.closePage(true);
          }
        } else {
          CommonToast.show(
              type: ToastIconType.FAILED, msg: resultModel.message ?? "");
        }
      } else {
        CommonToast.show(type: ToastIconType.FAILED, msg: "提交失败");
      }
    } catch (e) {
      CommonToast.show(type: ToastIconType.FAILED, msg: "提交异常，请重试");
    } finally {
      visitorReleaseCommitState = ListState.HINT_DISMISS;
    }
  }

  ///获取最大期限
  Future<void> getVisitorMaxEffective( {Function callback})async{
    Map<String, dynamic> params = new Map();

    params['projectId'] = stateModel.defaultProjectId;

    HttpUtil.post(
        HttpOptions.findVisitSettingByProjectId, (data) => _findVisitSettingByProjectIdCallBack(data, callBack: callback),
        jsonData:  jsonEncode(params),
        errorCallBack: (errorMsg) => _findVisitSettingByProjectIdErrorCallBack(errorMsg, callBack: callback));

  }
  void _findVisitSettingByProjectIdCallBack(data, {Function callBack}) async {
    LogUtils.printLog('获取到的最大期限:$data');
    VisitSetting model = VisitSetting.fromJson(data);
    if (model.code == '0') {
      //客户（已有认证过的房屋）
      if (model?.data != null) {
        if (callBack != null) callBack(visitSettingInfo: model.data);
      } else {
        if (callBack != null) callBack(failedMsg: '未获取到数据');
        CommonToast.show(type: ToastIconType.INFO, msg: '未获取到数据');
      }
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
      if (callBack != null) callBack(failedMsg: failedDescri);
      CommonToast.show(type: ToastIconType.FAILED, msg: failedDescri);
    }
    notifyListeners();
  }
  void _findVisitSettingByProjectIdErrorCallBack(String errorMsg, {Function callBack}) {
    LogUtils.printLog('接口返回失败：$errorMsg');
//    if (callBack != null) callBack(errorMsg: errorMsg);
    if (callBack != null) callBack(failedMsg: errorMsg);
    CommonToast.show(type: ToastIconType.FAILED, msg: errorMsg);
    notifyListeners();
  }
  ///获取详情
  Future<void> getVisitorReleaseDetail(int propertyChangeId,
      {Function callback}) async {
    visitorReleaseInfoState = ListState.HINT_LOADING;
    notifyListeners();
    Map<String, dynamic> params = new Map();
//    params['isCheckAssignee'] = isCheckAssignee;
    params['appointmentVisitId'] = propertyChangeId;
    params['isQueryPassTime'] = '1';//获取放行时间

    HttpUtil.post(HttpOptions.getAppointmentVisitDetailById, (data) {
      _getDetailCallBack(data, callback: callback);
    }, jsonData: jsonEncode(params), errorCallBack: _getDetailErrorCallBack);
  }

  _getDetailCallBack(data, {Function callback}) {
    VisitorReleaseDetailModel visitorReleaseObj =
        VisitorReleaseDetailModel.fromJson(data);
    LogUtils.printLog('详情:$data');
    if (visitorReleaseObj.code == '0') {
      if (visitorReleaseObj.data != null) {
        visitorReleaseInfoState = ListState.HINT_DISMISS;
        visitorReleaseDetail = visitorReleaseObj.data;

        if (callback != null) {
          callback(visitorReleaseDetail);
        }
      } else {
//nodata
        visitorReleaseInfoState = ListState.HINT_NO_DATA_CLICK;
      }
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(
          failCode: visitorReleaseObj.code.toString(),
          failMsg: visitorReleaseObj.message);
      visitorReleaseInfoState = ListState.HINT_LOADED_FAILED_CLICK;
      LogUtils.printLog('详情获取失败:' + failedDescri);
    }

    notifyListeners();
  }

  void _getDetailErrorCallBack(errorMsg) {
    LogUtils.printLog('接口返回失败');
    visitorReleaseInfoState = ListState.HINT_LOADED_FAILED_CLICK;
    notifyListeners();
  }

  ///获取列表
  loadHistoryList(PropertyChangeUserParam param,
      {bool preRefresh = false}) async {
    if (visitorReleaseInfoListState == ListState.HINT_LOADED_FAILED_CLICK ||
        visitorReleaseInfoListState == ListState.HINT_NO_DATA_CLICK) {
      preRefresh = true;
    }
    visitorReleaseInfoListState = ListState.HINT_LOADING;
    if (preRefresh) notifyListeners();
    _listCurrentPage = 1;
    maxCount = false;
//    print('_orderAllMap[page.tag]:${_orderAllMap[page]}');
    if (visitorReleaseInfoList != null)
      visitorReleaseInfoList.clear();
    else
      visitorReleaseInfoList = new List();
    _getHistoryList(param);
  }

  Future<void> historyHandleRefresh(PropertyChangeUserParam param,
      {bool preRefresh = false}) async {
    loadHistoryList(param, preRefresh: preRefresh);
  }

  quoteRecordHandleLoadMore(PropertyChangeUserParam param) {
    if (!maxCount) {
      _getHistoryList(param);
    }
  }

  _getHistoryList(PropertyChangeUserParam param) {
    if (param == null) {
      param = new PropertyChangeUserParam();
    }
    param.currentUser = stateModel.customerId;
    param.current = _listCurrentPage;
    param.pageSize = HttpOptions.pageSize;
    Map<String, dynamic> map = param.toJson();

    HttpUtil.post(HttpOptions.findAppointmentApplyPage, _historyCallBack,
        jsonData: json.encode(map), errorCallBack: _historyErrorCallBack);
  }

  void _historyCallBack(data) {
    VisitorReleaseDetailListModel model;
//    LogUtils.printLog('门禁卡记录列表:$data');
    try {
      model = VisitorReleaseDetailListModel.fromJson(data);
    } catch (e) {
      LogUtils.printLog('列表:$data');
      model = new VisitorReleaseDetailListModel(code: '0');
    }
    if (model.code == '0') {
      if (model.data != null && model.data.length > 0) {
        visitorReleaseInfoListState = ListState.HINT_DISMISS;
        if (_listCurrentPage == 1) {
//刷新操作，清空数据再添加（防止多次刷新请求导致数据重复添加）
          visitorReleaseInfoList.clear();
        }
        visitorReleaseInfoList.addAll(model.data);
        if (model.data.length < HttpOptions.pageSize)
          maxCount = true;
        else
          _listCurrentPage++; //页面加1，用于加载下一页
//        }
      } else {
        if (visitorReleaseInfoList == null || visitorReleaseInfoList.isEmpty) {
//nodata
          visitorReleaseInfoListState = ListState.HINT_NO_DATA_CLICK;
          visitorReleaseInfoList.clear();
        } else {
//已到列表最底
          maxCount = true;
        }
      }
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(
          failCode: model.code.toString(), failMsg: model.message);
      visitorReleaseInfoListState = ListState.HINT_LOADED_FAILED_CLICK;
//      Fluttertoast.showToast(msg: failedDescri);
    }
    notifyListeners();
  }

  void _historyErrorCallBack(errorMsg) {
    LogUtils.printLog('接口返回失败');
    visitorReleaseInfoListState = ListState.HINT_LOADED_FAILED_CLICK;
//    Fluttertoast.showToast(msg: errorMsg);
    notifyListeners();
  }

  static VisitorReleaseStateModel of(context) =>
      ScopedModel.of<VisitorReleaseStateModel>(context);
}
