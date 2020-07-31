
import 'package:cmp_customer/models/common/common_select_model.dart';
import 'package:cmp_customer/ui/common/common_picker.dart';
import 'package:cmp_customer/ui/parking/parking_card_state.dart';
import 'package:cmp_customer/utils/date_util.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../main.dart';

mixin MarketScreenStateModel on Model {
  int selectedRangeIndex=0;//默认选中的范围

  var rangeList = new List<CommonSelectModel>();//发布范围
  var typeList = new List<CommonSelectModel>();//发布类型
  var classificationList = new List<CommonSelectModel>();//商品分类

  //初始化数据
  initScreenData(){
    rangeList.clear();
    typeList.clear();
    classificationList.clear();
    rangeList.add(new CommonSelectModel("1", "同城汇", true));
    rangeList.add(new CommonSelectModel("2", "本社区", false));
    rangeList.add(new CommonSelectModel("0", "四合院", false));

    typeList.add(new CommonSelectModel("XSY", "小生意", false));
    typeList.add(new CommonSelectModel("ES", "二手", false));
    typeList.add(new CommonSelectModel("ZJ", "租借", false));
    typeList.add(new CommonSelectModel("ZS", "赠送", false));

    if(stateModel.wareGoodsTypeList == null){
      stateModel.findWareDataDictionaryList(callback: (){
        _initClassification();
      });
    }else{
      _initClassification();
    }
  }

  void _initClassification(){
    if(stateModel.wareGoodsTypeList != null){
      stateModel.wareGoodsTypeList.forEach((dictionary){
        classificationList.add(new CommonSelectModel(dictionary.dataCode,dictionary.dataName,false));
      });
      notifyListeners();
    }
  }

  //获取商品类型数据



  //发布范围(只能单选)
  setRang(int index,bool selected){
    if(selected){//选中
      rangeList[index].selected = selected;
      if(selectedRangeIndex>=0){//取消原来选中的
        rangeList[selectedRangeIndex].selected = false;
      }
      selectedRangeIndex=index;
    }else{
      //不允许取消
//      selectedRangeIndex=-1;
    }
    notifyListeners();
  }
  //发布范围
  setType(int index,bool selected){
    typeList[index].selected=selected;
    notifyListeners();
  }

  //商品分类
  setClassification(int index,bool selected){
    if(index<(classificationList.length??0)){
      classificationList[index].selected=selected;
      notifyListeners();
    }
  }


  //重置选项
  reset(){
    rangeList[0].selected=true;//默认设置第一个
    selectedRangeIndex=0;
    for(int i=1;i<rangeList.length;i++){
      rangeList[i].selected=false;
    }
    for(int i=0;i<typeList.length;i++){
      typeList[i].selected=false;
    }
    for(int i=0;i<classificationList.length;i++){
      classificationList[i].selected=false;
    }
    notifyListeners();
  }


  static MarketScreenStateModel of(context) => ScopedModel.of<MarketScreenStateModel>(context);
}
