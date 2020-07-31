
import 'dart:convert';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/request/parking_card_apply_request.dart';
import 'package:cmp_customer/models/response/agreement_response.dart';
import 'package:cmp_customer/models/response/base_response.dart';
import 'package:cmp_customer/models/response/parking_card_details_response.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/parking/parking_card_agreement.dart';
import 'package:cmp_customer/ui/parking/parking_card_state.dart';
import 'package:cmp_customer/utils/common_event_bus.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/date_util.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

class ParkingOperationStateModel extends Model {
  double fee;//费用单价
  double payFee;//支付的金额
  String cancelEndTime;//期望停止日期
  ParkingOperationStateModel(this.fee);
  ParkingCardDetailsInfo detailsInfo;
  TextEditingController applyMonthsController = new TextEditingController();
  AgreementInfo agreementInfo;//协议


//  //点击了确认按钮
//  confirmOnOperationTap(){
//
//  }
//  //点击了取消按钮
//  cancelOnOperationTap(){
//
//  }

  //续费操作
  uploadXFData(){
    int month=StringsHelper.getIntValue(applyMonthsController.text);
    ParkingCardApplyRequest info = new ParkingCardApplyRequest();
    if(month>0){
      info.applyMonths=month;
    }else{
      CommonToast.show(type: ToastIconType.INFO,msg: "请输入正确的申请月份");
      return ;
    }
    if(payFee==null){
      CommonToast.show(type: ToastIconType.INFO,msg: "费用计算错误");
      return ;
    }else{
      info.payFees=payFee;
    }
    CommonToast.show();
    String url="";
    info.type=operationXF;
    info.customerId=detailsInfo.customerId;
    info.parkingInfoId=detailsInfo.parkingInfoId;
    if(detailsInfo.status==auditWaiting||detailsInfo.status==auditFailed){
      //待审核或者审核不通过状态，调用续费修改接口
      info.parkingId=detailsInfo.parkingId;
      url=HttpOptions.parkingEdit;
      String data=json.encode(info);
      HttpUtil.post(url, _uploadCallBack,
          jsonData: data,errorCallBack: _errorCallBack);
    }else{
      //新卡申请续费操作
      info.oldParkingId=detailsInfo.parkingId;
      url=HttpOptions.parkingCreate;
      String data=json.encode(info);
      HttpUtil.post(url, _uploadCallBack,
          jsonData: data,errorCallBack: _errorCallBack);
    }
  }

  //退卡操作
  uploadTZData(){
    if(cancelEndTime==null){
      CommonToast.show(type: ToastIconType.INFO,msg: "请选择时间");
      return ;
    }else if(DateUtils.isBefore(cancelEndTime,detailsInfo?.effectTime)|| DateUtils.isBefore(detailsInfo?.validEndTime,cancelEndTime)){
      CommonToast.show(type: ToastIconType.INFO,msg: "停用时间必须在有效时间内");
      return ;
    }
    ParkingCardApplyRequest info = new ParkingCardApplyRequest();
    info.type=operationTZ;
    info.customerId=detailsInfo.customerId;
    info.parkingInfoId=detailsInfo.parkingInfoId;
    info.cancelEndTime=cancelEndTime;
    String url="";
    CommonToast.show();
    if(detailsInfo.status==tzAcceptWaiting){
      //待受理状态，调用退租修改接口
      info.parkingId=detailsInfo.parkingId;
      url=HttpOptions.parkingEdit;
      String data=json.encode(info);
      HttpUtil.post(url, _uploadCallBack,
          jsonData: data,errorCallBack: _errorCallBack);
    }else{
      //退租操作
      info.oldParkingId=detailsInfo.parkingId;
      url=HttpOptions.parkingCreate;
      String data=json.encode(info);
      HttpUtil.post(url, _uploadCallBack,
          jsonData: data,errorCallBack: _errorCallBack);
    }
  }
  //通用提交回调
  _uploadCallBack(data){
    try {
      BaseResponse model = BaseResponse.fromJson(data);
      if (model.success()) {
        CommonToast.show(type: ToastIconType.SUCCESS, msg: "提交成功");
        Navigate.closePage(true);
        parking_card_bus.emit(parking_refresh);//发送刷新事件
//        parking_card_bus.emit(parking_details_close);//发送详情关闭页面
      } else {
        CommonToast.show(
            type: ToastIconType.FAILED, msg: model.message ?? "");
      }
      return;
    }catch(e){
      CommonToast.show(
          type: ToastIconType.FAILED, msg: "提交失败");
    }
  }
//  //续费成功
//  _createCallBack(data){
//
//    try{
//      BaseResponse model = BaseResponse.fromJson(data);
////    ParkingCardDetailsModel model = ParkingCardDetailsModel.fromJson(data);
//      if(model!=null&&model.success()){
////        LogUtils.printLog("提交成功");
//          CommonToast.show(msg: "提交成功",type: ToastIconType.INFO);
//          parking_card_bus.emit(parking_refresh);//发送刷新事件
//          parking_card_bus.emit(parking_details_close);//发送详情关闭页面
//          Navigate.closePage();
//          return ;
//        }else{
////          _failTip(model.message);
//          CommonToast.show(msg: "提交失败：" + model.message,type: ToastIconType.INFO);
//        }
//    }catch(e){
//      CommonToast.show(msg: "提交失败",type: ToastIconType.INFO);
//    }
//  }


//  //通用提交回调
//  _uploadCallBack(data){
//    BaseResponse model = BaseResponse.fromJson(data);
////    ParkingCardDetailsModel model = ParkingCardDetailsModel.fromJson(data);
//    if(model!=null){
//      if(model.success()){
//        LogUtils.printLog("提交成功");
//        parking_card_bus.emit(parking_refresh);//发送刷新事件
//        Navigate.closePage();
//        return ;
//      }else{
//        _failTip(model.message);
//      }
//    }else{
//      _failTip("获取详情失败");
//    }
//  }

  //通用网络请求错误回调
  _errorCallBack(data) {
    CommonToast.show(type: ToastIconType.FAILED,msg: data?.toString());
  }

  //失败提示
  _failTip(String tips){
    if(StringsHelper.isNotEmpty(tips)){
      LogUtils.printLog(tips);
    }
  }

  bool agree=false;//同意标志

  //同意点击
  onChangeAgree(){
//    agree=checked??false;
    agree=!agree;
    notifyListeners();
  }

  //获取停车协议
  getAgreementInfo(){
    Map<String, Object> params = new Map();
    params['projectId'] = stateModel.defaultProjectId;//项目编码id
    params['agreementType'] = "ParkingAgreement";//项目编码id
    HttpUtil.post(HttpOptions.agreementUrl, _getAgreementInfoCallBack,
        jsonData: json.encode(params));
  }

  //获取协议回调
  _getAgreementInfoCallBack(data){
    try{
      AgreementResponse response = AgreementResponse.fromJson(data);
      if(response.success()&& response.agreementInfo!=null){
        agreementInfo=response.agreementInfo;
      }
    }catch(e){
    }
  }

  //查看停车协议
  toAgreementPage(){
    Navigate.toNewPage(ParkingCardAgreementPage(agreementInfo));
  }

  //设置期望停用日期
  setExpectStopDate(String date){
    cancelEndTime=date;
    notifyListeners();
  }

  //设置月份监听
  setApplyMonthListenr(){
    applyMonthsController.addListener((){
      int month=StringsHelper.getIntValue(applyMonthsController.text);
      if(month>0){
        payFee = month * fee;
      }else{
        payFee = null ;
      }
      notifyListeners();
    });
  }

}