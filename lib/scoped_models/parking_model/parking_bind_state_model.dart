
import 'dart:convert';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/models/response/base_response.dart';
import 'package:cmp_customer/models/response/parking_card_monthly_response.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/parking/parking_card_state.dart';
import 'package:cmp_customer/utils/common_event_bus.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:scoped_model/scoped_model.dart';

import '../base_model.dart';

class ParkingBindStateModel extends BaseModel {

  //提交申请
  uploadBindData(){
    CommonToast.show();
    HttpUtil.post(HttpOptions.parkingBind, _uploadBindDataCallBack,
        jsonData: json.encode(list),errorCallBack: _errorCallBack);
  }

  //申请成功
  _uploadBindDataCallBack(data){
    try {
      CommonToast.dismiss();
      BaseResponse resultModel = BaseResponse.fromJson(data);
      if (resultModel != null) {
        if (resultModel.success()) {
          //请求成功
          CommonToast.show(type: ToastIconType.SUCCESS, msg: resultModel.message ?? "绑定成功");
          Navigate.closePage(true);
          parking_card_bus.emit(parking_refresh); //发送刷新事件
        } else {
          //请求成功
          CommonToast.show(type: ToastIconType.FAILED,
              msg: "绑定失败:" + resultModel.message ?? "");
        }
      } else {
        CommonToast.show(type: ToastIconType.FAILED, msg: "绑定失败");
      }
    }catch(e){
      CommonToast.show(type: ToastIconType.FAILED, msg: "绑定异常，参数返回错误");
    }
  }

  //校验数据
  checkData(String carNo){
    if(StringsHelper.isEmpty(carNo)){
      CommonToast.show(type: ToastIconType.INFO,msg:"请输入车牌号");
      return;
    }else if(!StringsHelper.isCarNo(carNo)){
      CommonToast.show(type: ToastIconType.INFO,msg:"请输入正确的车牌号");
      return;
    }
    _getOldParkingCardList(carNo);
  }

  //获取旧月卡列表数据
  _getOldParkingCardList(String carNo) {
    CommonToast.show();
    Map<String, dynamic> params = new Map();
    params["plate"] = carNo;
    HttpUtil.post(HttpOptions.parkingPlateMonthly, _historyCallBack,
        jsonData: json.encode(params), errorCallBack: _errorCallBack);
  }

  void _historyCallBack(data) {
    try{
      CommonToast.dismiss();
      ParkingCardMonthlyResponse model = ParkingCardMonthlyResponse.fromJson(data);
      if (model.success()) {
        if (model.data == null || model.data.isEmpty) {
          list.clear();
          CommonToast.show(type: ToastIconType.FAILED,msg: "查询不到月卡数据");
        }else {
          list.clear();
          list.addAll(model.data);
        }
      } else {
        _errorCallBack(model.message??"");
      }
    }catch(e){
      _errorCallBack("参数返回错误");
    }
    notifyListeners();
  }

  //通用网络请求错误回调
  _errorCallBack(data) {
    CommonToast.show(type: ToastIconType.FAILED,msg: data?.toString());
  }
}