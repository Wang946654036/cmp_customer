import 'package:cmp_customer/models/common/common_select_model.dart';
import 'package:cmp_customer/ui/check_in/check_in_status.dart';
import 'package:cmp_customer/ui/common/common_picker.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/date_util.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

mixin CheckInScreenStateModel on Model {
  int selectedTimeIndex = -1; //默认选中的时间项
  int selectedStateIndex = -1; //默认选中的状态项
//
  String selectedStartDate; //选中的开始时间
  String selectedEndDate; //选中的结束时间

  var applyStatusList = new List<CommonSelectModel>();
  var applyTimeList = new List<CommonSelectModel>();

  //初始化数据
  initScreenData() {
    applyStatusList.clear();
    applyStatusList.add(new CommonSelectModel(
        auditWaiting, getStateText(auditWaiting), false));
    applyStatusList.add(new CommonSelectModel(
        payWaiting, getStateText(payWaiting), false));
    applyStatusList.add(new CommonSelectModel(
        auditFailed, getStateText(auditFailed), false));
    applyStatusList.add(new CommonSelectModel(
        cancelled, getStateText(cancelled), false));
    applyStatusList.add(new CommonSelectModel(
        settledWaiting, getStateText(settledWaiting), false));
    applyStatusList.add(new CommonSelectModel(
        completed, getStateText(completed), false));

    applyTimeList.clear();
    applyTimeList.add(new CommonSelectModel(
        DateUtils.getMonthAgoDate(3), "最近三个月", false));
    applyTimeList.add(new CommonSelectModel(
        DateUtils.getMonthAgoDate(6), "最近半年", false));
    applyTimeList.add(new CommonSelectModel(
        DateUtils.getMonthAgoDate(12), "最近一年", false));
  }

  //申请状态设置
  setApplyStatus(int index, bool selected) {
    applyStatusList[index].selected = selected;
    if (selected) {
      //选中
      if (selectedStateIndex >= 0) {
        //取消原来选中的
        applyStatusList[selectedStateIndex].selected = false;
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


  //开始时间设置
  chooseStartDate(BuildContext context) {
    CommonPicker.datePickerModal(context,onConfirm: (date){
      if(StringsHelper.isNotEmpty(selectedEndDate)&&DateTime.parse(date).isAfter(DateTime.parse(selectedEndDate))){
        CommonToast.show(type: ToastIconType.INFO,msg:"截止时间不能小于起始时间");
      }else {
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
    CommonPicker.datePickerModal(context,onConfirm: (date){
      if(StringsHelper.isNotEmpty(selectedStartDate)&&DateTime.parse(selectedStartDate).isAfter(DateTime.parse(date))){
        CommonToast.show(type: ToastIconType.INFO,msg:"截止时间不能小于起始时间");
      }else{
        selectedEndDate=date;
        if (selectedTimeIndex >= 0) {
          //取消原来选中的
          applyTimeList[selectedTimeIndex].selected = false;
          selectedTimeIndex=-1;//取消最近时间的选择
        }
        notifyListeners();
      }
    });
  }

  //重置选项
  reset() {
    for (int i = 0; i < applyStatusList.length; i++) {
      applyStatusList[i].selected = false;
    }
    if (selectedTimeIndex >= 0) {
      applyTimeList[selectedTimeIndex].selected = false;
      selectedTimeIndex = -1;
    }
    selectedStateIndex = -1;
    selectedStartDate=null;
    selectedEndDate=null;
    notifyListeners();
  }
}


////申请时间筛选
//class CommonSelectModel {
////  int timeCode;//时间编码
//  String time; //时间
//  String timeName; //时间名称
//  bool selected; //是否选中
//  CommonSelectModel(this.time, this.timeName, this.selected);
//}
//
////申请状态筛选
//class CommonSelectModel {
//  String stateCode; //状态编码
//  String stateName; //状态名称
//  bool selected; //是否选中
//  CommonSelectModel(this.stateCode, this.stateName, this.selected);
//}
