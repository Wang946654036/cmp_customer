import 'dart:convert';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/decoration_obj_list.dart';
import 'package:cmp_customer/models/decoration_obj.dart';
import 'package:cmp_customer/models/property_change_user_param.dart';
import 'package:cmp_customer/models/response/base_response.dart';
import 'package:cmp_customer/ui/common/common_date_picker.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/decorate_manager/decoration_ui.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/date_util.dart';
import 'package:cmp_customer/utils/failed_code_trans.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

enum DecorationHttpType { SAVE, CHANGE, UPDATA,ACCEPTANCE,UPDATAACCEPTANCE }

class DecorationModel extends Model with DecorationScreenModel {
  ListState decorationInfoState = ListState.HINT_LOADING;

  ListState decorationInfoListState = ListState.HINT_LOADING;

  ListState decorationCommitState = ListState.HINT_DISMISS;
  DecorationInfo decorationInfo;

  int _listCurrentPage = 1; //从第一页开始
//  int historyTotalCount = 0;
  bool maxCount = false;

  List<DecorationRecord> decorationInfoList;

  ListState decorationInfoStateZK = ListState.HINT_LOADING;

  ListState decorationInfoListStateZK = ListState.HINT_LOADING;

  int _listCurrentPageZK = 1; //从第一页开始
//  int historyTotalCount = 0;
  bool maxCountZK = false;

  List<DecorationRecord> decorationInfoListZK;

  Future<void> decorationIsPass(Map<String, dynamic> params,
      {Function callback, DecorationHttpType decorationType,}) async {
    CommonToast.show();
    if(  decorationCommitState != ListState.HINT_LOADING) {
      decorationCommitState = ListState.HINT_LOADING;
      String url = HttpOptions.decorateApplySave;
      switch (decorationType) {
        case DecorationHttpType.SAVE:
          url = HttpOptions.decorateApplySave;
          break;
        case DecorationHttpType.CHANGE:
          url = HttpOptions.decorateApplyChangeState;
          break;
        case DecorationHttpType.UPDATA:
          url = HttpOptions.decorateApplyUpdate;
          break;
        case DecorationHttpType.ACCEPTANCE:
          url = HttpOptions.decorateSaveAcceptance;
          break;
        case DecorationHttpType.UPDATAACCEPTANCE:
          url = HttpOptions.decorateUpdateAcceptance;
          break;
        default:
          break;
      }
      params['operationCust']=stateModel.customerId;
      HttpUtil.post(url, (data) {
        _uploadApplyDataCallBack(data, callback: callback);
      }, jsonData: jsonEncode(params), errorCallBack: _errorCallBack);
    }
  }

  //通用网络请求错误回调
  _errorCallBack(data) {
    CommonToast.show(
        type: ToastIconType.FAILED, msg: "提交异常：" + data?.toString());
    decorationCommitState = ListState.HINT_DISMISS;
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
          }else{
            Navigate.closePage(true);
          }
        } else {
          CommonToast.show(
              type: ToastIconType.FAILED,
              msg: "提交失败:" + resultModel.message ?? "");
        }
      } else {
        CommonToast.show(type: ToastIconType.FAILED, msg: "提交失败");
      }
    } catch (e) {
      CommonToast.show(type: ToastIconType.FAILED, msg: "提交异常，请重试");
    } finally{
      decorationCommitState = ListState.HINT_DISMISS;
    }
  }

  ///获取详情
  Future<void> getDecorationInfo(int propertyChangeId,{Function callback}) async {
    decorationInfoState = ListState.HINT_LOADING;
    notifyListeners();
    Map<String, dynamic> params = new Map();
//    params['isCheckAssignee'] = isCheckAssignee;
    params['id'] = propertyChangeId;

    HttpUtil.post(HttpOptions.decorateApplyGetApply, (data){_getDetailCallBack(data,callback:callback);},
        jsonData: jsonEncode(params), errorCallBack: _getDetailErrorCallBack);
  }

  _getDetailCallBack(data,{Function callback}) {
    DecorationObj decorationObj = DecorationObj.fromJson(data);
    LogUtils.printLog('装修详情:$data');
    if (decorationObj.code == '0') {
      if (decorationObj.data != null) {
        decorationInfoState = ListState.HINT_DISMISS;
        decorationInfo = decorationObj.data;
//        if(workOther.paidServiceId!=null){
//          getPayinfo(workOther.paidServiceId.toString());
//        }
      if(callback!=null){
        callback(decorationInfo);
      }
      } else {
        //nodata
        decorationInfoState = ListState.HINT_NO_DATA_CLICK;
      }
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(
          failCode: decorationObj.code.toString(),
          failMsg: decorationObj.message);
      decorationInfoState = ListState.HINT_LOADED_FAILED_CLICK;
      LogUtils.printLog('详情获取失败:' + failedDescri);
    }

    notifyListeners();
  }

  void _getDetailErrorCallBack(errorMsg) {
    LogUtils.printLog('接口返回失败');
    decorationInfoState = ListState.HINT_LOADED_FAILED_CLICK;
    notifyListeners();
  }

  ///获取列表
  loadHistoryList(PropertyChangeUserParam param,
      {bool preRefresh = false}) async {
    if (decorationInfoListState == ListState.HINT_LOADED_FAILED_CLICK ||
        decorationInfoListState == ListState.HINT_NO_DATA_CLICK) {
      preRefresh = true;
    }
    decorationInfoListState = ListState.HINT_LOADING;
    if (preRefresh) notifyListeners();
    _listCurrentPage = 1;
    maxCount = false;
//    print('_orderAllMap[page.tag]:${_orderAllMap[page]}');
    if (decorationInfoList != null)
      decorationInfoList.clear();
    else
      decorationInfoList = new List();
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
    param.operationCust = stateModel.customerId;
    param.current = _listCurrentPage;
    param.pageSize = HttpOptions.pageSize;
    Map<String,dynamic> map=param.toJson();
    map["state"] = param.status;
//    map['applyBeginDate'] = param.startTime;
//    map['applyEndDate'] = param.endTime;
    HttpUtil.post(HttpOptions.ownerApplyList, _historyCallBack,
        jsonData: json.encode(map), errorCallBack: _historyErrorCallBack);
  }

  ///获取列表租客
  loadHistoryListZK(PropertyChangeUserParam param,
      {bool preRefresh = false}) async {
    if (decorationInfoListStateZK == ListState.HINT_LOADED_FAILED_CLICK ||
        decorationInfoListStateZK == ListState.HINT_NO_DATA_CLICK) {
      preRefresh = true;
    }
    decorationInfoListStateZK = ListState.HINT_LOADING;
    if (preRefresh) notifyListeners();
    _listCurrentPageZK = 1;
    maxCountZK = false;
//    print('_orderAllMap[page.tag]:${_orderAllMap[page]}');
    if (decorationInfoListZK != null)
      decorationInfoListZK.clear();
    else
      decorationInfoListZK = new List();
    _getHistoryListZK(param);
  }

  Future<void> historyHandleRefreshZK(PropertyChangeUserParam param,
      {bool preRefresh = false}) async {
    loadHistoryListZK(param, preRefresh: preRefresh);
  }

  quoteRecordHandleLoadMoreZK(PropertyChangeUserParam param) {
    if (!maxCountZK) {
      _getHistoryListZK(param);
    }
  }

  _getHistoryListZK(PropertyChangeUserParam param) {
    if (param == null) {
      param = new PropertyChangeUserParam();
    }
    param.operationCust = stateModel.customerId;
    param.current = _listCurrentPageZK;
    param.pageSize = HttpOptions.pageSize;
    Map<String,dynamic> map=param.toJson();
    map["state"] = param.status;
    HttpUtil.post(HttpOptions.lesseeApplyList, _historyCallBackZK,
        jsonData: json.encode(map), errorCallBack: _historyErrorCallBackZK);
  }

  void _historyCallBack(data) {
    DecorationObjList model;
//    LogUtils.printLog('门禁卡记录列表:$data');
    try {
      model = DecorationObjList.fromJson(data);
    } catch (e) {
      LogUtils.printLog('工单列表:$data');
      model = new DecorationObjList(code: '0');
    }
    if (model.code == '0') {
      if (model.data != null && model.data.length > 0) {
        decorationInfoListState = ListState.HINT_DISMISS;
        if (_listCurrentPage == 1) {
          //刷新操作，清空数据再添加（防止多次刷新请求导致数据重复添加）
          decorationInfoList.clear();
        }
        decorationInfoList.addAll(model.data);
        if (model.data.length < HttpOptions.pageSize)
          maxCount = true;
        else
          _listCurrentPage++; //页面加1，用于加载下一页
//        }
      } else {
        if (decorationInfoList == null || decorationInfoList.isEmpty) {
          //nodata
          decorationInfoListState = ListState.HINT_NO_DATA_CLICK;
          decorationInfoList.clear();
        } else {
          //已到列表最底
          maxCount = true;
        }
      }
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(
          failCode: model.code.toString(), failMsg: model.message);
      decorationInfoListState = ListState.HINT_LOADED_FAILED_CLICK;
//      Fluttertoast.showToast(msg: failedDescri);
    }
    notifyListeners();
  }

  void _historyErrorCallBack(errorMsg) {
    LogUtils.printLog('接口返回失败');
    decorationInfoListState = ListState.HINT_LOADED_FAILED_CLICK;
//    Fluttertoast.showToast(msg: errorMsg);
    notifyListeners();
  }

  void _historyCallBackZK(data) {
    DecorationObjList model;
//    LogUtils.printLog('门禁卡记录列表:$data');
    try {
      model = DecorationObjList.fromJson(data);
    } catch (e) {
      LogUtils.printLog('工单列表:$data');
      model = new DecorationObjList(code: '0');
    }
    if (model.code == '0') {
      if (model.data != null && model.data.length > 0) {
        decorationInfoListStateZK = ListState.HINT_DISMISS;
        if (_listCurrentPageZK == 1) {
          //刷新操作，清空数据再添加（防止多次刷新请求导致数据重复添加）
          decorationInfoListZK.clear();
        }
        decorationInfoListZK.addAll(model.data);
        if (model.data.length < HttpOptions.pageSize)
          maxCountZK = true;
        else
          _listCurrentPageZK++; //页面加1，用于加载下一页
//        }
      } else {
        if (decorationInfoListZK == null || decorationInfoListZK.isEmpty) {
          //nodata
          decorationInfoListStateZK = ListState.HINT_NO_DATA_CLICK;
          decorationInfoListZK.clear();
        } else {
          //已到列表最底
          maxCountZK = true;
        }
      }
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(
          failCode: model.code.toString(), failMsg: model.message);
      decorationInfoListStateZK = ListState.HINT_LOADED_FAILED_CLICK;
//      Fluttertoast.showToast(msg: failedDescri);
    }
    notifyListeners();
  }

  void _historyErrorCallBackZK(errorMsg) {
    LogUtils.printLog('接口返回失败');
    decorationInfoListStateZK = ListState.HINT_LOADED_FAILED_CLICK;
//    Fluttertoast.showToast(msg: errorMsg);
    notifyListeners();
  }

  static DecorationModel of(context) =>
      ScopedModel.of<DecorationModel>(context);
}

mixin DecorationScreenModel on Model {
  int selectedTimeIndex = -1; //默认选中的时间项
  int selectedStateIndex = -1; //默认选中的状态项
//
  String selectedStartDate; //选中的开始时间
  String selectedEndDate; //选中的结束时间

  var applyStateList = new List<DecorationScreenStateModel>();
  var applyTimeList = new List<DecorationScreenTimeModel>();

//  var applyTypeList = new List<DecorationScreenTypeModel>();

//  var wrapList=new List<WrapModel>();
//  var projectList = new List<ProjectInfo>();
  bool isProjectOpen = false; //是否打开项目选择

  ///const  wyauditWaiting = "WY_CHECK"; //待受理
  //const  wyauditFailed = "WY_CHECK_FAIL"; //客服会退
  //const  payWaiting = "PAYMENT_PENDING"; //待缴费
  //const  wyauditSuc = "WRITED"; //已签证
  //const  acceptance_check = "ACCEPTANCE_CHECK"; //验收待处理
  //const  acceptanceCheckFailed = "ACCEPTANCE_CHECK_FAIL"; //验收不通过
  //const  acceptanceCheckSuc = 'ACCEPTANCE_CHECK_SUCCESS';//验收通过
  //const  closed = 'CANCEL_REQUEST';//已经关单
  //初始化数据
  initScreenData() {
    applyStateList.add(
        new DecorationScreenStateModel(yzauditWaiting, getStateStr(yzauditWaiting), false));
    applyStateList.add(
        new DecorationScreenStateModel(yzauditFailed, getStateStr(yzauditFailed), false));
    applyStateList.add(new DecorationScreenStateModel(
        wyauditWaiting, getStateStr(wyauditWaiting), false));
    applyStateList.add(new DecorationScreenStateModel(
        wyauditFailed, getStateStr(wyauditFailed), false));
    applyStateList.add(new DecorationScreenStateModel(
        payWaiting, getStateStr(payWaiting), false));
    applyStateList.add(new DecorationScreenStateModel(
        wyauditSuc, getStateStr(wyauditSuc), false));
    applyStateList.add(new DecorationScreenStateModel(
        acceptance_check, getStateStr(acceptance_check), false));
    applyStateList.add(new DecorationScreenStateModel(
        acceptanceCheckFailed, getStateStr(acceptanceCheckFailed), false));
    applyStateList.add(new DecorationScreenStateModel(
        acceptanceCheckSuc, getStateStr(acceptanceCheckSuc), false));
    applyStateList.add(
        new DecorationScreenStateModel(closed, getStateStr(closed), false));

    applyTimeList.add(new DecorationScreenTimeModel(
        DateUtils.getMonthAgoDate(3), "最近三个月", false));
    applyTimeList.add(new DecorationScreenTimeModel(
        DateUtils.getMonthAgoDate(6), "最近半年", false));
    applyTimeList.add(new DecorationScreenTimeModel(
        DateUtils.getMonthAgoDate(12), "最近一年", false));

//    applyTypeList.add(new DecorationScreenTypeModel(
//        customerYZ, getCustomerTypeText(customerYZ), false));
//    applyTypeList.add(new DecorationScreenTypeModel(
//        customerZH, getCustomerTypeText(customerZH), false));
//    applyTypeList.add(new DecorationScreenTypeModel(
//        customerJTCY, getCustomerTypeText(customerJTCY), false));
//    applyTypeList.add(new DecorationScreenTypeModel(
//        customerZHCY, getCustomerTypeText(customerZHCY), false));
  }

//  //车牌列表数据设置
//  initCars(List<String> custCars){
//    carNoList.clear();
//    custCars.forEach((carNo){
//      carNoList.add(new DecorationScreenCarNoModel(carNo,false));
//    });
//    notifyListeners();
//  }
//
////车牌号选中设置
//  setCarNo(int index,bool selected){
//    carNoList[index].selected=selected;
//    notifyListeners();
//  }

//  //申请类型设置
//  setApplyType(int index, bool selected) {
//    applyTypeList[index].selected = selected;
//    notifyListeners();
//  }

  //申请状态设置
  setApplyState(int index, bool selected) {
    applyStateList[index].selected = selected;
    if (selected) {
      //选中
      if (selectedStateIndex >= 0) {
        //取消原来选中的
        applyStateList[selectedStateIndex].selected = false;
      }
      selectedStateIndex = index;
    } else {
      //取消
      selectedStateIndex = -1;
    }
    notifyListeners();
  }

  //申请时间设置(只能单选)
  setApplyTime(int index, bool selected) {
    applyTimeList[index].selected = selected;
    if (selected) {
      //选中
      if (selectedTimeIndex >= 0) {
        //取消原来选中的
        applyTimeList[selectedTimeIndex].selected = false;
      }
      selectedTimeIndex = index;
    } else {
      //取消
      selectedTimeIndex = -1;
    }
    selectedStartDate = null;
    selectedEndDate = null;
    notifyListeners();
  }

  //开始时间设置
  chooseStartDate(BuildContext context) {
    CommonDatePicker.datePickerModal(context, onConfirm: (date) {
      if (StringsHelper.isNotEmpty(selectedEndDate) &&
          DateTime.parse(date).isAfter(DateTime.parse(selectedEndDate))) {
        CommonToast.show(type: ToastIconType.INFO, msg: "截止时间不能小于起始时间");
      } else {
        selectedStartDate = date;
        if (selectedTimeIndex >= 0) {
          //取消原来选中的
          applyTimeList[selectedTimeIndex].selected = false;
          selectedTimeIndex = -1; //取消最近时间的选择
        }
        notifyListeners();
      }
    });
  }

  //结束时间设置
  chooseEndDate(BuildContext context) {
    CommonDatePicker.datePickerModal(context, onConfirm: (date) {
      if (StringsHelper.isNotEmpty(selectedStartDate) &&
          DateTime.parse(selectedStartDate).isAfter(DateTime.parse(date))) {
        CommonToast.show(type: ToastIconType.INFO, msg: "截止时间不能小于起始时间");
      } else {
        selectedEndDate = date;
        if (selectedTimeIndex >= 0) {
          //取消原来选中的
          applyTimeList[selectedTimeIndex].selected = false;
          selectedTimeIndex = -1; //取消最近时间的选择
        }
        notifyListeners();
      }
    });
  }

  //重置选项
  reset() {
    for (int i = 0; i < applyStateList.length; i++) {
      applyStateList[i].selected = false;
    }
    if(selectedStateIndex>=0){
      selectedStateIndex = -1;
    }
    if (selectedTimeIndex >= 0) {
      applyTimeList[selectedTimeIndex].selected = false;
      selectedTimeIndex = -1;
    }
    selectedStartDate = null;
    selectedEndDate = null;
//    wrapList.clear();
//    for(int i=0;i<carNoList.length;i++){
//      carNoList[i].selected=false;
//    }
    notifyListeners();
  }

  //设置WarpList
//  setWarpList(List<WrapModel> list){
//    if(list!=null)
//      wrapList=list;
//    setProjectOpen(false);
////    notifyListeners();
//  }

  //设置是否打开项目选择
  setProjectOpen(bool isOpen) {
    isProjectOpen = isOpen;
    notifyListeners();
  }

//  //获取已选的id
//  List<int> getSelectedIdList(){
//    return wrapList.map((model){
//      return StringsHelper.getIntValue(model.code);
//    }).toList();
//  }

//  //设置已选的项目
//  setSelectedPeojec(List<ProjectInfo> list){
//    projectList=list;
//    setWarpList();
//  }

  static DecorationScreenModel of(context) =>
      ScopedModel.of<DecorationScreenModel>(context);
}

//申请时间筛选
class DecorationScreenTimeModel {
//  int timeCode;//时间编码
  String time; //时间
  String timeName; //时间名称
  bool selected; //是否选中
  DecorationScreenTimeModel(this.time, this.timeName, this.selected);
}

//申请状态筛选
class DecorationScreenStateModel {
  String stateCode; //状态编码
  String stateName; //状态名称
  bool selected; //是否选中
  DecorationScreenStateModel(this.stateCode, this.stateName, this.selected);
}
