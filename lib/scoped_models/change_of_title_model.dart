
import 'dart:convert';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/change_title_obj.dart';
import 'package:cmp_customer/models/change_title_obj_list.dart';
import 'package:cmp_customer/models/property_change_user_param.dart';
import 'package:cmp_customer/models/response/base_response.dart';
import 'package:cmp_customer/models/response/entrance_card_house_response.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/ui/change_of_title/change_of_title_ui.dart';
import 'package:cmp_customer/ui/common/common_picker.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/date_util.dart';
import 'package:cmp_customer/utils/failed_code_trans.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ChangeOfTitleModel extends Model with ChangeOfTitleScreenModel{

  ListState changeOfTitleInfoState = ListState.HINT_LOADING;

  ListState changeOfTitleInfoListState = ListState.HINT_LOADING;

  ChangeTitleInfo changeOfTitleInfo ;

  int _listCurrentPage = 1; //从第一页开始
//  int historyTotalCount = 0;
  bool maxCount = false;

  List<ChangeTitleInfo> changeTitleInfoList;

  List<HouseInfo> houseList;

  String customerYZ = "YZ"; //业主

  changeOfTitleIsPass(int id , {Function callback}){
    Map<String, dynamic> params = new Map();
    params['propertyChangeId'] = id;
    params['operateStep'] = 'CQBG_QXSQ';

    HttpUtil.post(HttpOptions.changeStatusByCust, (data){_uploadApplyDataCallBack(data,callback: callback);},
        jsonData: jsonEncode(params),errorCallBack: _errorCallBack);
  }




  //获取房屋列表
  Future<void> getHouseList(){
    Map<String,dynamic> request = {'custId':stateModel.customerId,'custProper':customerYZ};

    HttpUtil.post(HttpOptions.getAuditHouseInfoByCustProper, _getEntranceHouseCallBack,
        jsonData: json.encode(request),errorCallBack: _errorCallBack);
  }

  //获取房屋列表成功
  _getEntranceHouseCallBack(data){
    try{
      EntranceCardHouseResponse response = EntranceCardHouseResponse.fromJson(data);
      if(response.success()){
        if(houseList==null)
          houseList = new List();
        else
        houseList.clear();
        int length=response.houseList.length;
        for(int i=0;i<length;i++){
          if(response.houseList[i].custProper==customerYZ){
            houseList.add(response.houseList[i]);
          }
        }
      }else{
        CommonToast.show(type: ToastIconType.FAILED,msg: "获取房屋列表失败："+response?.message?.toString());
      }
    }catch(e){
      CommonToast.show(type: ToastIconType.FAILED,msg:"获取房屋列表失败");
    }
  }


  Future<void> getChangeOfTitleInfo(String isCheckAssignee, int propertyChangeId) async {
    changeOfTitleInfoState = ListState.HINT_LOADING;
    notifyListeners();
    Map<String, dynamic> params = new Map();
    params['isCheckAssignee'] = isCheckAssignee;
    params['propertyChangeId'] = propertyChangeId;



    HttpUtil.post(HttpOptions.findPropertyChangeDetail, _getDetailCallBack,
        jsonData: jsonEncode(params), errorCallBack: _getDetailErrorCallBack);
  }
  _getDetailCallBack(data) {
    ChangeTitleObj changceTitleObj = ChangeTitleObj.fromJson(data);
    LogUtils.printLog('变更详情:$data');
    if (changceTitleObj.code == '0') {
      if (changceTitleObj.changeTitleInfo != null) {
        changeOfTitleInfoState = ListState.HINT_DISMISS;
        changeOfTitleInfo = changceTitleObj.changeTitleInfo;
//        if(workOther.paidServiceId!=null){
//          getPayinfo(workOther.paidServiceId.toString());
//        }
      } else {
        //nodata
        changeOfTitleInfoState = ListState.HINT_NO_DATA_CLICK;
      }
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(
          failCode: changceTitleObj.code.toString(),
          failMsg: changceTitleObj.message);
      changeOfTitleInfoState = ListState.HINT_LOADED_FAILED_CLICK;
      LogUtils.printLog('详情获取失败:' + failedDescri);
    }

    notifyListeners();
  }
  void _getDetailErrorCallBack(errorMsg) {
    LogUtils.printLog('接口返回失败');
    changeOfTitleInfoState = ListState.HINT_LOADED_FAILED_CLICK;
    notifyListeners();
  }

  loadHistoryList(PropertyChangeUserParam param,{bool preRefresh = false}) async {
    if (changeOfTitleInfoListState == ListState.HINT_LOADED_FAILED_CLICK ||
        changeOfTitleInfoListState == ListState.HINT_NO_DATA_CLICK) {
      preRefresh = true;
    }
    changeOfTitleInfoListState = ListState.HINT_LOADING;
    if (preRefresh) notifyListeners();
    _listCurrentPage = 1;
    maxCount = false;
//    print('_orderAllMap[page.tag]:${_orderAllMap[page]}');
    if (changeTitleInfoList != null) changeTitleInfoList.clear();
    else changeTitleInfoList = new List();
    _getHistoryList(param);
  }

  Future<void> historyHandleRefresh(PropertyChangeUserParam param,{bool preRefresh = false}) async {
    loadHistoryList(param,preRefresh: preRefresh);
  }

  quoteRecordHandleLoadMore(PropertyChangeUserParam param) {
    if (!maxCount) {
      _getHistoryList(param);
    }
  }

  _getHistoryList(PropertyChangeUserParam param) {
    param.current = _listCurrentPage;
    param.pageSize = HttpOptions.pageSize;
    HttpUtil.post(HttpOptions.findPropertyChangePage, _historyCallBack,
        jsonData: json.encode(param), errorCallBack: _historyErrorCallBack);
  }

  void _historyCallBack(data) {
    ChangeTitleObjList model ;
//    LogUtils.printLog('门禁卡记录列表:$data');
    try {
      model = ChangeTitleObjList.fromJson(data);
    } catch (e) {
      LogUtils.printLog('工单列表:$data');
      model = new ChangeTitleObjList(code: '0');
    }
    if (model.code=='0') {
      if (model.data != null &&
          model.data.length > 0) {
        changeOfTitleInfoListState = ListState.HINT_DISMISS;
        if(_listCurrentPage==1){//刷新操作，清空数据再添加（防止多次刷新请求导致数据重复添加）
          changeTitleInfoList.clear();
        }
        changeTitleInfoList.addAll(model.data);
        if (model.data.length < HttpOptions.pageSize)
          maxCount = true;
        else
          _listCurrentPage++; //页面加1，用于加载下一页
//        }
      } else {
        if (changeTitleInfoList == null || changeTitleInfoList.isEmpty) {
          //nodata
          changeOfTitleInfoListState = ListState.HINT_NO_DATA_CLICK;
          changeTitleInfoList.clear();
        } else {
          //已到列表最底
          maxCount = true;
        }
      }
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(
          failCode: model.code.toString(), failMsg: model.message);
      changeOfTitleInfoListState = ListState.HINT_LOADED_FAILED_CLICK;
//      Fluttertoast.showToast(msg: failedDescri);
    }
    notifyListeners();
  }

  void _historyErrorCallBack(errorMsg) {
    LogUtils.printLog('接口返回失败');
    changeOfTitleInfoListState = ListState.HINT_LOADED_FAILED_CLICK;
//    Fluttertoast.showToast(msg: errorMsg);
    notifyListeners();
  }

  checkUploadData(ChangeTitleInfo info,{Function callback}){
    info.customerId = stateModel.customerId;
    _uploadApplyData(info);
  }
  //提交申请
  _uploadApplyData(ChangeTitleInfo info,{Function callback}){
    CommonToast.show();

    String data=json.encode(info);
    HttpUtil.post(HttpOptions.createPropertyChange, (data){_uploadApplyDataCallBack(data,callback:callback);},
        jsonData: data,errorCallBack: _errorCallBack);
  }

  //通用网络请求错误回调
  _errorCallBack(data) {
    CommonToast.show(type: ToastIconType.FAILED,msg: "提交异常："+data?.toString());
  }
  //申请成功
  _uploadApplyDataCallBack(data,{Function callback}){
    try {
      BaseResponse resultModel = BaseResponse.fromJson(data);
      if (resultModel != null) {
        if (resultModel.success()) {
          //请求成功
//      LogUtils.printLog("月卡申请成功："+resultModel.message);
          CommonToast.show(type: ToastIconType.SUCCESS, msg: "提交成功");
          Navigate.closePage(true);
          if(callback!=null){
            callback();
          }
        } else {
          //请求成功
//      LogUtils.printLog("月卡申请失败："+resultModel.message);
          CommonToast.show(type: ToastIconType.FAILED,
              msg: resultModel.message ?? "");
        }
      } else {
        CommonToast.show(type: ToastIconType.FAILED, msg: "提交失败");
      }
    }catch(e){
      CommonToast.show(type: ToastIconType.FAILED, msg: "提交异常，请重试");
    }
  }

//  imagesHeadCallback(List<String> images,ChangeTitleInfo info){
//    if(info.attFileList==null)
//      info.attFileList = new List();
//    else
//      info.attFileList.clear();
//    images.forEach((str){
//      AttFileList attFileList = new AttFileList(attachmentUuid:str,attachmentName: str ,attachmentType: 'jpg');
//      info.attFileList.add(attFileList);
//    });
//    notifyListeners();
//  }

  static ChangeOfTitleModel of(context) =>
      ScopedModel.of<ChangeOfTitleModel>(context);
}



mixin ChangeOfTitleScreenModel on Model {
  int selectedTimeIndex = -1; //默认选中的时间项
  int selectedStateIndex = -1; //默认选中的状态项
//
  String selectedStartDate; //选中的开始时间
  String selectedEndDate; //选中的结束时间

  var applyStateList = new List<ChangeOfTitleScreenStateModel>();
  var applyTimeList = new List<ChangeOfTitleScreenTimeModel>();
//  var applyTypeList = new List<ChangeOfTitleScreenTypeModel>();

//  var wrapList=new List<WrapModel>();
//  var projectList = new List<ProjectInfo>();
  bool isProjectOpen = false;//是否打开项目选择

  //初始化数据
  initScreenData() {
    applyStateList.add(new ChangeOfTitleScreenStateModel(
        auditWaiting, getStateStr(auditWaiting), false));
    applyStateList.add(new ChangeOfTitleScreenStateModel(
        auditFailed, getStateStr(auditFailed), false));
    applyStateList.add(new ChangeOfTitleScreenStateModel(
        auditSuc, getStateStr(auditSuc), false));
    applyStateList.add(new ChangeOfTitleScreenStateModel(
        completed, getStateStr(completed), false));
    applyStateList.add(new ChangeOfTitleScreenStateModel(
        cancelled, getStateStr(cancelled), false));
    applyStateList.add(new ChangeOfTitleScreenStateModel(
        closed, getStateStr(closed), false));

    applyTimeList.add(new ChangeOfTitleScreenTimeModel(
        DateUtils.getMonthAgoDate(3), "最近三个月", false));
    applyTimeList.add(new ChangeOfTitleScreenTimeModel(
        DateUtils.getMonthAgoDate(6), "最近半年", false));
    applyTimeList.add(new ChangeOfTitleScreenTimeModel(
        DateUtils.getMonthAgoDate(12), "最近一年", false));

//    applyTypeList.add(new ChangeOfTitleScreenTypeModel(
//        customerYZ, getCustomerTypeText(customerYZ), false));
//    applyTypeList.add(new ChangeOfTitleScreenTypeModel(
//        customerZH, getCustomerTypeText(customerZH), false));
//    applyTypeList.add(new ChangeOfTitleScreenTypeModel(
//        customerJTCY, getCustomerTypeText(customerJTCY), false));
//    applyTypeList.add(new ChangeOfTitleScreenTypeModel(
//        customerZHCY, getCustomerTypeText(customerZHCY), false));
  }
//  //车牌列表数据设置
//  initCars(List<String> custCars){
//    carNoList.clear();
//    custCars.forEach((carNo){
//      carNoList.add(new ChangeOfTitleScreenCarNoModel(carNo,false));
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
    selectedStartDate=null;
    selectedEndDate=null;
    notifyListeners();
  }


  //开始和结束时间设置
  chooseStartDate(BuildContext context) {
    CommonPicker.datePickerModal(context,onConfirm: (date){
      selectedStartDate=date;
      if (selectedTimeIndex >= 0) {
        //取消原来选中的
        applyTimeList[selectedTimeIndex].selected = false;
        selectedTimeIndex=-1;//取消最近时间的选择
      }
      notifyListeners();
    });
  }

  //开始和结束时间设置
  chooseEndDate(BuildContext context) {
    CommonPicker.datePickerModal(context,onConfirm: (date){
      selectedEndDate=date;
      if (selectedTimeIndex >= 0) {
        //取消原来选中的
        applyTimeList[selectedTimeIndex].selected = false;
        selectedTimeIndex=-1;//取消最近时间的选择
      }
      notifyListeners();
    });
  }

  //重置选项
  reset() {
    for (int i = 0; i < applyStateList.length; i++) {
      applyStateList[i].selected = false;
    }
    if (selectedTimeIndex >= 0) {
      applyTimeList[selectedTimeIndex].selected = false;
      selectedTimeIndex = -1;
    }
    selectedStartDate=null;
    selectedEndDate=null;
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
  setProjectOpen(bool isOpen){
    isProjectOpen=isOpen;
    notifyListeners();
  }

  //获取已选的id
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

  static ChangeOfTitleScreenModel of(context) =>
      ScopedModel.of<ChangeOfTitleScreenModel>(context);
}


//申请时间筛选
class ChangeOfTitleScreenTimeModel {
//  int timeCode;//时间编码
  String time; //时间
  String timeName; //时间名称
  bool selected; //是否选中
  ChangeOfTitleScreenTimeModel(this.time, this.timeName, this.selected);
}

//申请状态筛选
class ChangeOfTitleScreenStateModel {
  String stateCode; //状态编码
  String stateName; //状态名称
  bool selected; //是否选中
  ChangeOfTitleScreenStateModel(this.stateCode, this.stateName, this.selected);
}
