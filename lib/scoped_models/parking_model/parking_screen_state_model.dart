
import 'package:cmp_customer/models/common/common_select_model.dart';
import 'package:cmp_customer/ui/common/common_picker.dart';
import 'package:cmp_customer/ui/parking/parking_card_state.dart';
import 'package:cmp_customer/utils/date_util.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

mixin ParkingScreenStateModel on Model {
  int selectedTimeIndex=-1;//默认选中的时间项

  var dealTypeList = new List<CommonSelectModel>();
  var applyTimeList = new List<CommonSelectModel>();
  var carNoList = new List<CommonSelectModel>();

  String selectedStartDate; //选中的开始时间
  String selectedEndDate; //选中的结束时间

  //开始时间设置
  chooseStartDate(BuildContext context) {
    CommonPicker.datePickerModal(context,onConfirm: (date){
      selectedStartDate=date;
      if(selectedTimeIndex>=0){//取消原来选中的
        applyTimeList[selectedTimeIndex].selected = false;
        selectedTimeIndex=-1;//取消最近时间的选择
      }
      notifyListeners();
    });
  }

  //结束时间设置
  chooseEndDate(BuildContext context) {
    CommonPicker.datePickerModal(context,onConfirm: (date){
      selectedEndDate=date;
      if(selectedTimeIndex>=0){//取消原来选中的
        applyTimeList[selectedTimeIndex].selected = false;
        selectedTimeIndex=-1;//取消最近时间的选择
      }
      notifyListeners();
    });
  }

  //初始化数据
  initScreenData(){
//    dealTypeList.add(new ParkingCardScreenTypeModel("XK","新卡申请",false));
//    dealTypeList.add(new ParkingCardScreenTypeModel("XF","续费",false));
//    dealTypeList.add(new ParkingCardScreenTypeModel("TZ","退租",false));
//
//    applyTimeList.add(new ParkingCardScreenTimeModel("2019-01-01","最近三个月",false));
//    applyTimeList.add(new ParkingCardScreenTimeModel("2018-10-01","最近半年",false));
//    applyTimeList.add(new ParkingCardScreenTimeModel("2018-04-01","最近一年",false));

    dealTypeList.add(new CommonSelectModel(operationXK, getOperationStateText(operationXK), false));
    dealTypeList.add(new CommonSelectModel(operationXF, getOperationStateText(operationXF), false));
    dealTypeList.add(new CommonSelectModel(operationTZ, getOperationStateText(operationTZ), false));

    applyTimeList
        .add(new CommonSelectModel(DateUtils.getMonthAgoDate(3), "最近三个月", false));
    applyTimeList
        .add(new CommonSelectModel(DateUtils.getMonthAgoDate(6), "最近半年", false));
    applyTimeList
        .add(new CommonSelectModel(DateUtils.getMonthAgoDate(12), "最近一年", false));
  }
  //车牌列表数据设置
  initCars(List<String> custCars){
    carNoList.clear();
    custCars.forEach((carNo){
      carNoList.add(new CommonSelectModel(carNo,carNo,false));
    });
    notifyListeners();
  }

//车牌号选中设置
  setCarNo(int index,bool selected){
    carNoList[index].selected=selected;
    notifyListeners();
  }



  //办理类型设置
  setDealType(int index,bool selected){
    dealTypeList[index].selected=selected;
    notifyListeners();
  }

  //申请时间设置(只能单选)
  setApplyTime(int index,bool selected){
    applyTimeList[index].selected = selected;
    if(selected){//选中
      if(selectedTimeIndex>=0){//取消原来选中的
        applyTimeList[selectedTimeIndex].selected = false;
      }
      selectedTimeIndex=index;
    }else{//取消
      selectedTimeIndex=-1;
    }
    selectedStartDate=null;
    selectedEndDate=null;
    notifyListeners();
  }

  //重置选项
  reset(){
    for(int i=0;i<dealTypeList.length;i++){
      dealTypeList[i].selected=false;
    }
    if(selectedTimeIndex>=0){
      applyTimeList[selectedTimeIndex].selected = false;
      selectedTimeIndex=-1;
    }
    for(int i=0;i<carNoList.length;i++){
      carNoList[i].selected=false;
    }
    selectedStartDate=null;
    selectedEndDate=null;
    notifyListeners();
  }


  static ParkingScreenStateModel of(context) => ScopedModel.of<ParkingScreenStateModel>(context);
}

////办理类型筛选
//class ParkingCardScreenTypeModel{
//  String typeCode;//类型编码
//  String typeName;//类型名称
//  bool selected;//是否选中
//  ParkingCardScreenTypeModel(this.typeCode,this.typeName,this.selected);
//}
////申请时间筛选
//class ParkingCardScreenTimeModel{
////  int timeCode;//时间编码
//  String time;//时间
//  String timeName;//时间名称
//  bool selected;//是否选中
//  ParkingCardScreenTimeModel(this.time,this.timeName,this.selected);
//}
////车牌号码
//class ParkingCardScreenCarNoModel{
//  String carNo;//时间名称
//  bool selected;//是否选中
//  ParkingCardScreenCarNoModel(this.carNo,this.selected);
//}

