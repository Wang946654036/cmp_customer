import 'dart:convert';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/new_house_detail_list_model.dart';
import 'package:cmp_customer/models/new_house_model.dart';

import 'package:cmp_customer/models/property_change_user_param.dart';
import 'package:cmp_customer/models/response/base_response.dart';
import 'package:cmp_customer/ui/common/car_number_input_keyboard.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/failed_code_trans.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

enum NewHouseHttpType { SAVE, UPDATA, CANCEL, ACCEPT }

class NewHouseStateModel extends Model{
  ListState newHouseInfoState = ListState.HINT_LOADING;

  ListState newHouseInfoListState = ListState.HINT_LOADING;

  ListState newHouseCommitState = ListState.HINT_DISMISS;
  NewHouseDetail newHouseDetail;

  int _listCurrentPage = 1; //从第一页开始
//  int historyTotalCount = 0;
  bool maxCount = false;

  List<NewHouseDetail> newHouseInfoList;
  NewHouseCarInfo newHouseCarInfo; //用于车牌号输入框显示和赋值
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

  void setCarNo(String carNo){
    newHouseCarInfo.plateNumber = carNo;
    showCarNoInputView = false;
    notifyListeners();
  }

  void setCarInfo(NewHouseCarInfo carInfo){
    newHouseCarInfo = carInfo;
    LogUtils.printLog('车牌号：${carInfo.plateNumber}');
    showCarNoInputView = true;
    carNoInputKey.currentState.refreshCarNo(carInfo.plateNumber ?? '');
    notifyListeners();
  }

  Future<void> newHouseIsPass(Map<String, dynamic> params,
      {Function callback, NewHouseHttpType newHouseType,}) async {
    CommonToast.show();
    if(  newHouseCommitState != ListState.HINT_LOADING) {
      newHouseCommitState = ListState.HINT_LOADING;
      String url = HttpOptions.createHouseJoin;
      switch (newHouseType) {
        case NewHouseHttpType.SAVE:
          url = HttpOptions.createHouseJoin;
          break;
        case NewHouseHttpType.UPDATA:
          url = HttpOptions.editHouseJoin;
          break;
        case NewHouseHttpType.CANCEL:
          url = HttpOptions.changeHouseJoinStatus;
          params['currentUser']=stateModel.customerId;
          params['operation']='CH';
          break;
          //业主验收
        case NewHouseHttpType.ACCEPT:
          url = HttpOptions.changeHouseJoinStatus;
          params['currentUser']=stateModel.customerId;
          params['operation']='YS';
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
    newHouseCommitState = ListState.HINT_DISMISS;
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
              msg: resultModel.message ?? "");
        }
      } else {
        CommonToast.show(type: ToastIconType.FAILED, msg: "提交失败");
      }
    } catch (e) {
      CommonToast.show(type: ToastIconType.FAILED, msg: "提交异常，请重试");
    } finally{
      newHouseCommitState = ListState.HINT_DISMISS;
    }
  }

  ///获取详情
  Future<void> getNewHouseDetail(int propertyChangeId,{Function callback}) async {
    newHouseInfoState = ListState.HINT_LOADING;
    notifyListeners();
    Map<String, dynamic> params = new Map();
//    params['isCheckAssignee'] = isCheckAssignee;
    params['houseJoinId'] = propertyChangeId;

    HttpUtil.post(HttpOptions.getHouseJoinDetailById, (data){_getDetailCallBack(data,callback:callback);},
        jsonData: jsonEncode(params), errorCallBack: _getDetailErrorCallBack);
  }

  _getDetailCallBack(data,{Function callback}) {
    NewHouseModel newHouseObj = NewHouseModel.fromJson(data);
    LogUtils.printLog('详情:$data');
    if (newHouseObj.code == '0') {
      if (newHouseObj.newHouseDetail != null) {
        newHouseInfoState = ListState.HINT_DISMISS;
        newHouseDetail = newHouseObj.newHouseDetail;

        if(callback!=null){
          callback(newHouseDetail);
        }
      } else {
        //nodata
        newHouseInfoState = ListState.HINT_NO_DATA_CLICK;
      }
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(
          failCode: newHouseObj.code.toString(),
          failMsg: newHouseObj.message);
      newHouseInfoState = ListState.HINT_LOADED_FAILED_CLICK;
      LogUtils.printLog('详情获取失败:' + failedDescri);
    }

    notifyListeners();
  }

  void _getDetailErrorCallBack(errorMsg) {
    LogUtils.printLog('接口返回失败');
    newHouseInfoState = ListState.HINT_LOADED_FAILED_CLICK;
    notifyListeners();
  }

  ///获取列表
  loadHistoryList(PropertyChangeUserParam param,
      {bool preRefresh = false}) async {
    if (newHouseInfoListState == ListState.HINT_LOADED_FAILED_CLICK ||
        newHouseInfoListState == ListState.HINT_NO_DATA_CLICK) {
      preRefresh = true;
    }
    newHouseInfoListState = ListState.HINT_LOADING;
    if (preRefresh) notifyListeners();
    _listCurrentPage = 1;
    maxCount = false;
//    print('_orderAllMap[page.tag]:${_orderAllMap[page]}');
    if (newHouseInfoList != null)
      newHouseInfoList.clear();
    else
      newHouseInfoList = new List();
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
    Map<String,dynamic> map=param.toJson();

    HttpUtil.post(HttpOptions.findHouseJoinPage, _historyCallBack,
        jsonData: json.encode(map), errorCallBack: _historyErrorCallBack);
  }



  void _historyCallBack(data) {
    NewHouseDetailListModel model;
//    LogUtils.printLog('门禁卡记录列表:$data');
    try {
      model = NewHouseDetailListModel.fromJson(data);
    } catch (e) {
      LogUtils.printLog('列表:$data');
      model = new NewHouseDetailListModel(code: '0');
    }
    if (model.code == '0') {
      if (model.data != null && model.data.length > 0) {
        newHouseInfoListState = ListState.HINT_DISMISS;
        if (_listCurrentPage == 1) {
          //刷新操作，清空数据再添加（防止多次刷新请求导致数据重复添加）
          newHouseInfoList.clear();
        }
        newHouseInfoList.addAll(model.data);
        if (model.data.length < HttpOptions.pageSize)
          maxCount = true;
        else
          _listCurrentPage++; //页面加1，用于加载下一页
//        }
      } else {
        if (newHouseInfoList == null || newHouseInfoList.isEmpty) {
          //nodata
          newHouseInfoListState = ListState.HINT_NO_DATA_CLICK;
          newHouseInfoList.clear();
        } else {
          //已到列表最底
          maxCount = true;
        }
      }
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(
          failCode: model.code.toString(), failMsg: model.message);
      newHouseInfoListState = ListState.HINT_LOADED_FAILED_CLICK;
//      Fluttertoast.showToast(msg: failedDescri);
    }
    notifyListeners();
  }

  void _historyErrorCallBack(errorMsg) {
    LogUtils.printLog('接口返回失败');
    newHouseInfoListState = ListState.HINT_LOADED_FAILED_CLICK;
//    Fluttertoast.showToast(msg: errorMsg);
    notifyListeners();
  }


  static NewHouseStateModel of(context) =>
      ScopedModel.of<NewHouseStateModel>(context);
}


