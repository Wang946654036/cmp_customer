import 'dart:convert';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/decoration_obj_list.dart';
import 'package:cmp_customer/models/decoration_obj.dart';
import 'package:cmp_customer/models/meetingroom/meeting_room_info_list_obj.dart';
import 'package:cmp_customer/models/meetingroom/meeting_room_info_obj.dart';
import 'package:cmp_customer/models/meetingroom/reserve_info.dart';
import 'package:cmp_customer/models/meetingroom/reserve_info_list_obj.dart';
import 'package:cmp_customer/models/meetingroom/reserve_info_obj.dart';
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

enum ReserveHttpType { SAVE, CHANGE, UPDATA, ACCEPTANCE, UPDATAACCEPTANCE }

class ReservationModel extends Model with ReservationScreenModel {
  int result_ok = 1;
  int result_fail = -1;
  int result_suc_create = 2;
  ListState reservationInfoState = ListState.HINT_LOADING;

  ListState reservationInfoListState = ListState.HINT_LOADING;
  ListState meetinInfoListState = ListState.HINT_DISMISS;
  ListState reservationCommitState = ListState.HINT_DISMISS;
  ReserveInfo reserveInfo;
  List<MeetingRoomInfo> saveInfoList; //本地保存的预约表单列表
  int _listCurrentPage = 1; //从第一页开始
  int _meetingRoomsCurrentPage = 1; //从第一页开始
//  int historyTotalCount = 0;
  bool maxCount = false;
  bool meetingRoomsMaxCount = false;
//  List<ReserveInfo> reserveInfoList; //已预约列表

// //会议室预约申请
//  static String createMeetingMainOrder = 'business/meetingmainorder/createMeetingMainOrder';
//  //已预约列表
//  static String findMeetingMainOrderPage = 'business/meetingmainorder/findMeetingMainOrderPage';
//  //预约详情
//  static String getMeetingMainOrder = 'business/meetingmainorder/getMeetingMainOrder';
//  //获取可预约的会议室
//  static String selectTimeList = 'business/meetingmainorder/selectTimeList';
//  business/meetingmainorder/changeMeetingMainOrderStatus
//
  Future<void> createMeetingMainOrder({Function callback}) async {
    CommonToast.show();
    if (reservationCommitState != ListState.HINT_LOADING) {
      reservationCommitState = ListState.HINT_LOADING;
      String url = HttpOptions.createMeetingMainOrder;
      Map<String, dynamic> params = {
        'meetingSubOrderVoList': saveInfoList,
        'applicantName': stateModel.customerName,
        'applicantMobile': stateModel.mobile,
      };
      HttpUtil.post(url, (data) {
        _uploadApplyDataCallBack(data, callback: callback);
      }, jsonData: jsonEncode(params), errorCallBack: _errorCallBack);
    }
  }
  Future<void> editMeetingMainOrder(int id,{Function callback}) async {
    CommonToast.show();
    if (reservationCommitState != ListState.HINT_LOADING) {
      reservationCommitState = ListState.HINT_LOADING;
      String url = HttpOptions.createMeetingMainOrder;
      Map<String, dynamic> params = {
        'meetingSubOrderVoList': saveInfoList,
        'applicantName': stateModel.customerName,
        'applicantMobile': stateModel.mobile,
        'orderId':id
      };
      HttpUtil.post(url, (data) {
        _uploadApplyDataCallBack(data, callback: callback);
      }, jsonData: jsonEncode(params), errorCallBack: _errorCallBack);
    }
  }

  Future<void> reserveIsPass(
      Map<String, dynamic> params, {
        Function callback,
      }) async {
    CommonToast.show();
    if (reservationCommitState != ListState.HINT_LOADING) {
      reservationCommitState = ListState.HINT_LOADING;
      String url = HttpOptions.changeMeetingMainOrderStatus;

      HttpUtil.post(url, (data) {
        _uploadApplyDataCallBack(data, callback: callback);
      }, jsonData: jsonEncode(params), errorCallBack: _errorCallBack);
    }
  }
  //通用网络请求错误回调
  _errorCallBack(data) {
    CommonToast.show(
        type: ToastIconType.FAILED, msg: "提交异常：" + data?.toString());
    reservationCommitState = ListState.HINT_DISMISS;
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
    } finally {
      reservationCommitState = ListState.HINT_DISMISS;
    }
  }

  ///获取详情
  Future<void> getReserveInfo(int propertyChangeId, {Function callback}) async {
    reservationInfoState = ListState.HINT_LOADING;
    notifyListeners();
    Map<String, dynamic> params = new Map();
//    params['isCheckAssignee'] = isCheckAssignee;
    params['orderId'] = propertyChangeId;

    HttpUtil.post(HttpOptions.getMeetingMainOrder, (data) {
      _getDetailCallBack(data, callback: callback);
    }, jsonData: jsonEncode(params), errorCallBack: _getDetailErrorCallBack);
  }

  _getDetailCallBack(data, {Function callback}) {
    ReserveInfoObj decorationObj = ReserveInfoObj.fromJson(data);
    LogUtils.printLog('详情:$data');
    if (decorationObj.code == '0') {
      if (decorationObj.data != null) {
        reservationInfoState = ListState.HINT_DISMISS;
        reserveInfo = decorationObj.data;
//        if(workOther.paidServiceId!=null){
//          getPayinfo(workOther.paidServiceId.toString());
//        }
        if (callback != null) {
          callback(reserveInfo);
        }
      } else {
        //nodata
        reservationInfoState = ListState.HINT_NO_DATA_CLICK;
      }
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(
          failCode: decorationObj.code.toString(),
          failMsg: decorationObj.message);
      reservationInfoState = ListState.HINT_LOADED_FAILED_CLICK;
      LogUtils.printLog('详情获取失败:' + failedDescri);
    }

    notifyListeners();
  }

  void _getDetailErrorCallBack(errorMsg) {
    LogUtils.printLog('接口返回失败');
    reservationInfoState = ListState.HINT_LOADED_FAILED_CLICK;
    notifyListeners();
  }

  ///==================获取以约定列表
  loadHistoryList(PropertyChangeUserParam param,List<ReserveInfo> list,
      {bool preRefresh = false}) async {
    if (reservationInfoListState == ListState.HINT_LOADED_FAILED_CLICK ||
        reservationInfoListState == ListState.HINT_NO_DATA_CLICK) {
      preRefresh = true;
    }
    reservationInfoListState = ListState.HINT_LOADING;
    if (preRefresh) notifyListeners();
    _listCurrentPage = 1;
    maxCount = false;
//    print('_orderAllMap[page.tag]:${_orderAllMap[page]}');
    if (list != null)
      list.clear();
    else
      list = new List();
    _getHistoryList(param,list);
  }

  Future<void> historyHandleRefresh(PropertyChangeUserParam param,List<ReserveInfo> list,
      {bool preRefresh = false}) async {
    loadHistoryList(param,list, preRefresh: preRefresh);
  }

  quoteRecordHandleLoadMore(PropertyChangeUserParam param,List<ReserveInfo> list) {
    if (!maxCount) {
      _getHistoryList(param,list);
    }
  }

  _getHistoryList(PropertyChangeUserParam param,List<ReserveInfo> list,) {
    if (param == null) {
      param = new PropertyChangeUserParam();
    }
    param.operationCust = stateModel.customerId;
    param.current = _listCurrentPage;
    param.pageSize = HttpOptions.pageSize;
    Map<String, dynamic> map = param.toJson();
    map["currentUser"] = stateModel.customerId;

    HttpUtil.post(HttpOptions.findMeetingMainOrderPage, (data){_historyCallBack(data,list);},
        jsonData: json.encode(map), errorCallBack: _historyErrorCallBack);
  }

  void _historyCallBack(data,List<ReserveInfo> list) {
    ReserveInfoListObj model;
//    LogUtils.printLog('门禁卡记录列表:$data');
    try {
      model = ReserveInfoListObj.fromJson(data);
    } catch (e) {
      LogUtils.printLog('订单列表:$data');
      model = new ReserveInfoListObj(code: '0');
    }
    if (model.code == '0') {
      if (model.data != null && model.data.length > 0) {
        reservationInfoListState = ListState.HINT_DISMISS;
        if (_listCurrentPage == 1) {
          //刷新操作，清空数据再添加（防止多次刷新请求导致数据重复添加）
          list.clear();
        }
        list.addAll(model.data);
        if (model.data.length < HttpOptions.pageSize)
          maxCount = true;
        else
          _listCurrentPage++; //页面加1，用于加载下一页
//        }
      } else {
        if (list == null || list.isEmpty) {
          //nodata
          reservationInfoListState = ListState.HINT_NO_DATA_CLICK;
          list.clear();
        } else {
          //已到列表最底
          maxCount = true;
        }
      }
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(
          failCode: model.code.toString(), failMsg: model.message);
      reservationInfoListState = ListState.HINT_LOADED_FAILED_CLICK;
//      Fluttertoast.showToast(msg: failedDescri);
    }
    notifyListeners();
  }

  void _historyErrorCallBack(errorMsg) {
    LogUtils.printLog('接口返回失败');
    reservationInfoListState = ListState.HINT_LOADED_FAILED_CLICK;
//    Fluttertoast.showToast(msg: errorMsg);
    notifyListeners();
  }
///====================
  ///获取可预约列表
  loadCanBookList(Map<String,dynamic> param,List<MeetingRoomInfo> expandStateList,
      {bool preRefresh = false}) async {
    if (meetinInfoListState == ListState.HINT_LOADED_FAILED_CLICK ||
        meetinInfoListState == ListState.HINT_NO_DATA_CLICK) {
      preRefresh = true;
    }
    meetinInfoListState = ListState.HINT_LOADING;
    if (preRefresh) notifyListeners();
    _meetingRoomsCurrentPage = 1;
    meetingRoomsMaxCount = false;

//    print('_orderAllMap[page.tag]:${_orderAllMap[page]}');
    if (expandStateList != null)
      expandStateList.clear();
    else
      expandStateList = new List();
    _getCanBookList(param,expandStateList);
  }

  Future<void> canBookHandleRefresh(Map<String,dynamic> param,List<MeetingRoomInfo> expandStateList,
      {bool preRefresh = false}) async {
    loadCanBookList(param,expandStateList, preRefresh: preRefresh);
  }

  quoteCanBookHandleLoadMore(Map<String,dynamic> param,List<MeetingRoomInfo> expandStateList) {
    if (!meetingRoomsMaxCount) {
      _getCanBookList(param,expandStateList);
    }
  }

  _getCanBookList(Map<String,dynamic> param,List<MeetingRoomInfo> expandStateList,{bool preRefresh = false}) {
    if (param == null) {
      param = new Map<String,dynamic>();
    }

    param["currentUser"] = stateModel.customerId;
    param["current"] = _meetingRoomsCurrentPage;
    param["pageSize"] = HttpOptions.pageSize;
    param["projectId"] = stateModel.defaultProjectId;
    HttpUtil.post(HttpOptions.selectTimeList, (data){
      _CanBookCallBack(data,expandStateList);
    },
        jsonData: json.encode(param), errorCallBack: _CanBookErrorCallBack);
  }

  void _CanBookCallBack(data,List<MeetingRoomInfo> expandStateList,) {
    MeetingRoomInfoListObj model;

    try {
      model = MeetingRoomInfoListObj.fromJson(data);
    } catch (e) {
      LogUtils.printLog('会议室列表:$data');
      model = new MeetingRoomInfoListObj(code: '0');
    }
    if (model.code == '0') {
      if (model.data != null && model.data.length > 0) {
        meetinInfoListState = ListState.HINT_DISMISS;
        if (_meetingRoomsCurrentPage == 1) {
          //刷新操作，清空数据再添加（防止多次刷新请求导致数据重复添加）
          expandStateList.clear();
        }
        expandStateList.addAll(model.data);
        if (model.data.length < HttpOptions.pageSize)
          meetingRoomsMaxCount = true;
        else
          _meetingRoomsCurrentPage++; //页面加1，用于加载下一页
//        }
      } else {
        if (expandStateList == null || expandStateList.isEmpty) {
          //nodata
          meetinInfoListState = ListState.HINT_NO_DATA_CLICK;

        } else {
          //已到列表最底
          meetingRoomsMaxCount = true;
        }
      }
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(
          failCode: model.code.toString(), failMsg: model.message);
      meetinInfoListState = ListState.HINT_LOADED_FAILED_CLICK;
//      Fluttertoast.showToast(msg: failedDescri);
    }
    notifyListeners();
  }

  void _CanBookErrorCallBack(errorMsg) {
    LogUtils.printLog('接口返回失败');
    meetinInfoListState = ListState.HINT_LOADED_FAILED_CLICK;
//    Fluttertoast.showToast(msg: errorMsg);
    notifyListeners();
  }
  /// =============================
  String getPriceContent(MeetingRoomInfo info) {
    String content = '\n\r';
    if (StringsHelper.isNotEmpty(info?.workDay)) {
      content = content + '开放日：';
      List<String> workdayList = info.workDay.split(',');
      workdayList.forEach((String day) {
        switch (day) {
          case '1':
            content = content + '周一、';
            break;
          case '2':
            content = content + '周二、';
            break;
          case '3':
            content = content + '周三、';
            break;
          case '4':
            content = content + '周四、';
            break;
          case '5':
            content = content + '周五、';
            break;
          case '6':
            content = content + '周六、';
            break;
          case '7':
            content = content + '周日、';
            break;
        }
      });
      if (content.endsWith('、')) {
        content.substring(0, content.length - 1);
      }
      content = content + '\n\r';
    }
    if (info?.workDayTimeList != null && info.workDayTimeList.length > 0) {
      content = content + '工作日可预约时间段：\n\r';
      info.workDayTimeList.forEach((Time time) {
        content = content +
            '${time.beginTime}-${time.endTime}，收费标准：${time.price}元/小时\n\r';
      });
      content = content + '\n\r';
    }
    if (info?.weekendTimeList != null && info.weekendTimeList.length > 0) {
      content = content + '双休日可预约时间段：\n\r';
      info.weekendTimeList.forEach((Time time) {
        content = content +
            '${time.beginTime}-${time.endTime}，收费标准：${time.price}元/小时\n\r';
      });
      content = content + '\n\r';
    }
    if (info?.deviceList != null && info.deviceList.length > 0) {
      content = content + '设备租用费标准：\n\r';
      info.deviceList.forEach((Device device) {
        content =
            content + '${device.name}：${device.price}元/${device.measure}\n\r';
      });
      content = content + '其他设备费用另议\n\r\n\r';
    }
    if (info?.serviceList != null && info.serviceList.length > 0) {
      content = content + '服务租用费标准：\n\r';
      info.serviceList.forEach((Service service) {
        content = content +
            '${service.name}：${service.price}元/${service.measure}\n\r';
      });
      content = content + '其他服务费用另议\n\r';
      content = content + '\n\r';
    }
    content = content +
        '其他说明：\n\r（1）非正常办公时间如需使用空调应填写《加时空调申请表》，并另行缴纳加时空调费；\n\r（2）租用时间不足半天按半天计。\n\r';
  return content;
  }

  static ReservationModel of(context) =>
      ScopedModel.of<ReservationModel>(context);
}

mixin ReservationScreenModel on Model {
  int selectedTimeIndex = -1; //默认选中的时间项
  int selectedStateIndex = -1; //默认选中的状态项
//
  String selectedStartDate; //选中的开始时间
  String selectedEndDate; //选中的结束时间

  var applyStateList = new List<ReserveScreenStateModel>();
  var applyTimeList = new List<ReserveScreenTimeModel>();

//  var applyTypeList = new List<ReserveScreenTypeModel>();

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
    applyStateList.add(new ReserveScreenStateModel(
        yzauditWaiting, getStateStr(yzauditWaiting), false));
    applyStateList.add(new ReserveScreenStateModel(
        yzauditFailed, getStateStr(yzauditFailed), false));
    applyStateList.add(new ReserveScreenStateModel(
        wyauditWaiting, getStateStr(wyauditWaiting), false));
    applyStateList.add(new ReserveScreenStateModel(
        wyauditFailed, getStateStr(wyauditFailed), false));
    applyStateList.add(new ReserveScreenStateModel(
        payWaiting, getStateStr(payWaiting), false));
    applyStateList.add(new ReserveScreenStateModel(
        wyauditSuc, getStateStr(wyauditSuc), false));
    applyStateList.add(new ReserveScreenStateModel(
        acceptance_check, getStateStr(acceptance_check), false));
    applyStateList.add(new ReserveScreenStateModel(
        acceptanceCheckFailed, getStateStr(acceptanceCheckFailed), false));
    applyStateList.add(new ReserveScreenStateModel(
        acceptanceCheckSuc, getStateStr(acceptanceCheckSuc), false));
    applyStateList
        .add(new ReserveScreenStateModel(closed, getStateStr(closed), false));

    applyTimeList.add(new ReserveScreenTimeModel(
        DateUtils.getMonthAgoDate(3), "最近三个月", false));
    applyTimeList.add(new ReserveScreenTimeModel(
        DateUtils.getMonthAgoDate(6), "最近半年", false));
    applyTimeList.add(new ReserveScreenTimeModel(
        DateUtils.getMonthAgoDate(12), "最近一年", false));

//    applyTypeList.add(new ReserveScreenTypeModel(
//        customerYZ, getCustomerTypeText(customerYZ), false));
//    applyTypeList.add(new ReserveScreenTypeModel(
//        customerZH, getCustomerTypeText(customerZH), false));
//    applyTypeList.add(new ReserveScreenTypeModel(
//        customerJTCY, getCustomerTypeText(customerJTCY), false));
//    applyTypeList.add(new ReserveScreenTypeModel(
//        customerZHCY, getCustomerTypeText(customerZHCY), false));
  }

//  //车牌列表数据设置
//  initCars(List<String> custCars){
//    carNoList.clear();
//    custCars.forEach((carNo){
//      carNoList.add(new ReserveScreenCarNoModel(carNo,false));
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
    if (selectedStateIndex >= 0) {
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

  static ReservationScreenModel of(context) =>
      ScopedModel.of<ReservationScreenModel>(context);
}

//申请时间筛选
class ReserveScreenTimeModel {
//  int timeCode;//时间编码
  String time; //时间
  String timeName; //时间名称
  bool selected; //是否选中
  ReserveScreenTimeModel(this.time, this.timeName, this.selected);
}

//申请状态筛选
class ReserveScreenStateModel {
  String stateCode; //状态编码
  String stateName; //状态名称
  bool selected; //是否选中
  ReserveScreenStateModel(this.stateCode, this.stateName, this.selected);
}
