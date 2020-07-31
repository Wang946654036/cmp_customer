
import 'dart:convert';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/response/base_response.dart';
import 'package:cmp_customer/models/response/parking_card_details_response.dart';
import 'package:cmp_customer/models/response/parking_card_monthly_fee_response.dart';
import 'package:cmp_customer/models/response/parking_card_pay_info_response.dart';
import 'package:cmp_customer/models/response/parking_card_price_response.dart';
import 'package:cmp_customer/models/response/parking_card_prices_response.dart';
import 'package:cmp_customer/ui/common/common_dialog.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/html/html_page.dart';
import 'package:cmp_customer/ui/parking/parking_card_apply.dart';
import 'package:cmp_customer/ui/parking/parking_card_operation.dart';
import 'package:cmp_customer/ui/parking/parking_card_operation_step.dart';
import 'package:cmp_customer/ui/parking/parking_card_state.dart';
import 'package:cmp_customer/utils/common_event_bus.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

class ParkingDetailsStateModel extends Model {
  BuildContext mContext;
  ParkingDetailsStateModel(this.mContext);
  ParkingCardDetailsInfo detailsInfo = new ParkingCardDetailsInfo();
  ListState mineState=ListState.HINT_LOADING;
  int id;

  //获取停车卡详情
  getDetails(int parkingId){
    id=parkingId;
    mineState=ListState.HINT_LOADING;
    notifyListeners();
    Map<String, Object> params = new Map();
    params['parkingId'] = parkingId;
    HttpUtil.post(HttpOptions.parkingDetail, _getDetailsCallBack,
        jsonData: json.encode(params),errorCallBack: _getDetailsError);
  }
  //点击了确认按钮
  confirmOnDetailsTap(BuildContext context){
    if(detailsInfo.status==auditWaiting){//待审核状态
      if(operationXK==detailsInfo.type){//新卡申请
        //修改申请
        Navigate.toNewPage( ParkingCardApplyPage(detailsInfo: detailsInfo),callBack: (success){
          if(success??false){
            Navigate.closePage();
          }
        });
      }else if(operationXF==detailsInfo.type){//续费
        if(detailsInfo.parkingPackageId!=null){
          //获取当前套餐
          _getParkingPrice(detailsInfo.projectId,detailsInfo.parkingLotId,detailsInfo.parkingPackageId);
        }else{
          _getPlateMonthlyFee(detailsInfo.projectId,detailsInfo.parkingLotId,detailsInfo.carNo);
        }
//        //修改续费
//        Navigate.toNewPage( ParkingCardOperationPage(OperationType.operationXF,detailsInfo));
      }else if(operationTZ==detailsInfo.type){//退租
        //退租申请
        Navigate.toNewPage( ParkingCardOperationPage(OperationType.operationTZ,detailsInfo),callBack: (success){
          if(success??false){
            Navigate.closePage();
          }
        });
      }
    }else if(detailsInfo.status==auditFailed){//审核不通过状态
      if(operationXK==detailsInfo.type){//新卡申请
        //修改申请
        Navigate.toNewPage( ParkingCardApplyPage(detailsInfo: detailsInfo),callBack: (success){
          if(success??false){
            Navigate.closePage();
          }
        });
      }else if(operationXF==detailsInfo.type){//续费
//        //修改续费
//        Navigate.toNewPage( ParkingCardOperationPage(OperationType.operationXF,detailsInfo));
        //获取当前套餐
//        _getParkingPrice(detailsInfo.projectId,detailsInfo.parkingLotId,detailsInfo.parkingPackageId);
        if(detailsInfo.parkingPackageId!=null){
          //获取当前套餐
          _getParkingPrice(detailsInfo.projectId,detailsInfo.parkingLotId,detailsInfo.parkingPackageId);
        }else{
          _getPlateMonthlyFee(detailsInfo.projectId,detailsInfo.parkingLotId,detailsInfo.carNo);
        }
      }else if(operationTZ==detailsInfo.type){//退租
        //退租申请
        Navigate.toNewPage( ParkingCardOperationPage(OperationType.operationTZ,detailsInfo),callBack: (success){
          if(success??false){
            Navigate.closePage();
          }
        });
      }
    }else if(detailsInfo.status==payWaiting){//待支付状态
      //获取支付信息
      CommonToast.show();
      Map<String, Object> params = new Map();
      params['parkingId'] = detailsInfo.parkingId;//
      HttpUtil.post(HttpOptions.parkingPay, _getPayInfoCallBack,
          params: params,errorCallBack: _errorCallBack);
    }else if(detailsInfo.status==completed&&detailsInfo.type!=operationTZ){//已完成状态（非退卡）
      //获取当前套餐
      _getParkingPrice(detailsInfo.projectId,detailsInfo.parkingLotId,detailsInfo.parkingPackageId);
//      Navigate.toNewPage( ParkingCardOperationPage(OperationType.operationXF,detailsInfo));
    }else if(detailsInfo.status==tzAcceptWaiting){//待受理状态
      //退租修改
      Navigate.toNewPage( ParkingCardOperationPage(OperationType.operationTZ,detailsInfo),callBack: (success){
        if(success??false){
          Navigate.closePage();
        }
      });
    }else if(detailsInfo.status==tzConfirmWaiting){//待确认状态
      CommonDialog.showAlertDialog(context, title: '确定退租',
          onConfirm: () {
            CommonToast.show();
            //退租确认
            Map<String, String> params = new Map();
            params['parkingId'] = detailsInfo.parkingId.toString();
            params['operateStep'] = parking_step_confirm;//确认操作
            HttpUtil.post(HttpOptions.changeParkingStatus, _uploadCallBack,
                params: params,errorCallBack: _errorCallBack);
          });
    }
  }
  //点击了取消按钮
  cancelOnDetailsTap(BuildContext context){
    if(detailsInfo.status==auditWaiting||detailsInfo.status==auditFailed||detailsInfo.status==payWaiting||detailsInfo.status==tzAcceptWaiting||detailsInfo.status==tzConfirmWaiting){//待审核状态、
      CommonDialog.showAlertDialog(context, title: '确定取消办理',
          onConfirm: () {
            CommonToast.show();
            //取消办理
            Map<String, Object> params = new Map();
            params['parkingId'] = detailsInfo.parkingId;
            params['operateStep'] = parking_step_cancel;//取消操作
            HttpUtil.post(HttpOptions.changeParkingStatus, _uploadCallBack,
                params: params,errorCallBack: _errorCallBack);
          });
    }else if(detailsInfo.status==completed&&detailsInfo.type!=operationTZ){//已完成状态（非退卡）
      //退租
      Navigate.toNewPage( ParkingCardOperationPage(OperationType.operationTZ,detailsInfo),callBack: (success){
        if(success??false){
          Navigate.closePage();
        }
      });
    }
  }

  //获取详情回调
  _getDetailsCallBack(data){
    ParkingCardDetailsResponse model = ParkingCardDetailsResponse.fromJson(data);
//    ParkingCardDetailsModel model = ParkingCardDetailsModel.fromJson(data);
    if(model!=null){
      if(model.success() && model.parkingCardDetailsInfo!=null){
        detailsInfo =model.parkingCardDetailsInfo;
        mineState=ListState.HINT_DISMISS;//加载完成，隐藏加载页面
//        detailsInfo.type="XZ";
//        detailsInfo.status="YWC";
        notifyListeners();
      }else{
        _getDetailsError(model.message);
      }
    }else{
      _getDetailsError("获取详情失败");
    }
  }


  //获取详情失败
  _getDetailsError(errorMsg) {
    LogUtils.printLog('接口返回失败：'+errorMsg);
    mineState = ListState.HINT_LOADED_FAILED_CLICK;
//    Fluttertoast.showToast(msg: errorMsg);
    notifyListeners();
  }
  //获取支付信息回调
  _getPayInfoCallBack(data){
    CommonToast.dismiss();
    try{
      ParkingCardPayInfoResponse model = ParkingCardPayInfoResponse.fromJson(data);
      if(model!=null){
        if(model.success() && model.url!=null){
          //跳转到支付页面
          LogUtils.printLog('准备跳转微信支付' + model.url);
//          Navigate.toNewPage(HtmlPage('https://wxpay.wxutil.com/mch/pay/h5.v2.php', 'title'));
          Navigate.toNewPage(HtmlPage(model.url,"支付"),callBack: (data){
            LogUtils.printLog('支付后回调' + model.url);
            getDetails(id);
          });
        }else{
          CommonToast.show(type: ToastIconType.FAILED,msg: model.message??"");
        }
        return ;
      }
    }catch(e){
    }
    CommonToast.show(type: ToastIconType.FAILED,msg: "获取支付信息失败");
  }

  //获取当前套餐的最新费用
  _getParkingPrice(int projectId,int parkId,int priceId){
    CommonToast.show(msg: "查询当前套餐");
    Map<String, Object> params = new Map();
//    params['community'] = stateModel.defaultProjectId;//项目编码id
    params['community'] = projectId;//项目编码id
    params['park_id'] = parkId;//套餐id
    params['price_id'] = priceId;//套餐id
    HttpUtil.post(HttpOptions.parkingPrice, _getParkingPricesCallBack,
        params: params,errorCallBack: _getParkingPricesError);
  }

  //获取套餐成功
  _getParkingPricesCallBack(data){
    CommonToast.dismiss();
    try {
//      ParkingCardPricesResponse response = ParkingCardPricesResponse.fromJson(data);
//      if(response.success()&& response.parkingCardPackages!=null&&response.parkingCardPackages.isNotEmpty
//          && response.parkingCardPackages[0].prices!=null&&response.parkingCardPackages[0].prices.isNotEmpty){
//        //请求成功
//        CommonToast.dismiss();
//        Navigate.toNewPage(ParkingCardOperationPage(OperationType.operationXF,detailsInfo,fee: StringsHelper.getStringToDoubleValue(response.parkingCardPackages[0].prices[0].price)));
//
//      }else{
////        LogUtils.printLog("获取套餐失败：" + response.message);
//        CommonToast.show(type: ToastIconType.FAILED,msg: "当前套餐无效：不能使用此套餐续费");
//    }
      bool exist=false;//当前套餐不存在
      ParkingCardPriceResponse response = ParkingCardPriceResponse.fromJson(data);
      if(response.success()&& response.prices!=null&&response.prices.isNotEmpty){
        response.prices.forEach((priceInfo) {
        if(detailsInfo.parkingPackageId==priceInfo.priceId){
          exist=true;
          Navigate.toNewPage(ParkingCardOperationPage(OperationType.operationXF,detailsInfo,fee: StringsHelper.getStringToDoubleValue(priceInfo.price)),callBack: (success){
            if(success??false){
              Navigate.closePage();
            }
          });
          return;
        }
      });
    }
//        LogUtils.printLog("获取套餐失败：" + response.message);
      if(!exist)
        CommonToast.show(type: ToastIconType.INFO,msg: "当前套餐无效：不能使用此套餐续费");
    }catch(e){
      _getParkingPricesError(null);
    }
  }

  //获取套餐失败
  _getParkingPricesError(data){
    CommonToast.dismiss();
    CommonToast.show(type: ToastIconType.FAILED,msg: "获取当前套餐异常，请稍后重试:"+data?.toString());
  }


  //无套餐id情况下，获取月卡费用
  _getPlateMonthlyFee(int projectId,int parkId,String plate){
    CommonToast.show(msg: "查询当前套餐");
    Map<String, Object> params = new Map();
//    params['community'] = stateModel.defaultProjectId;//项目编码id
    params['community'] = projectId;//项目编码id
    params['park_id'] = parkId;//套餐id
    params['plate'] = plate;//车牌号
    HttpUtil.post(HttpOptions.parkingMonthlyFee, _getPlateMonthlyFeeCallBack,
        jsonData: json.encode(params),errorCallBack: _getParkingPricesError);
  }

  //获取月卡费用成功
  _getPlateMonthlyFeeCallBack(data){
    CommonToast.dismiss();
    try{
      ParkingCardMonthlyFeeResponse response = ParkingCardMonthlyFeeResponse.fromJson(data);
      if(response.success()&& response.data!=null&&response.data.fee!=null&&response.data.fee>0){
        Navigate.toNewPage(ParkingCardOperationPage(OperationType.operationXF,detailsInfo,fee: response.data.fee.toDouble()/100));
        return;
      }else{
        CommonToast.show(type: ToastIconType.INFO,msg: "当前套餐无效：不能使用此套餐续费");
      }
    }catch(e){
      _getParkingPricesError(null);
    }
  }

//  //续费操作
//  uploadXFData(int applyMonths,double fee){
//    PackingCardApplyModel info = new PackingCardApplyModel();
//    info.type="XF";
//    info.oldParkingId=detailsInfo.parkingId;
//    info.customerId=detailsInfo.customerId;
//    info.applyMonths=applyMonths;
//    info.payFees=fee;
//    String data=json.encode(info);
//    HttpUtil.post(HttpOptions.parkingCreate, _uploadCallBack,
//        jsonData: data);
//  }



  //通用提交回调
  _uploadCallBack(data){
    CommonToast.dismiss();
    try {
      BaseResponse model = BaseResponse.fromJson(data);
      if (model.success()) {
        CommonToast.show(type: ToastIconType.SUCCESS, msg: "提交成功");
        Navigate.closePage();
        parking_card_bus.emit(parking_refresh); //发送刷新事件
      } else {
        CommonToast.show(
            type: ToastIconType.FAILED, msg: model.message ?? "");
      }
      return;
    }catch(e){

    }
    CommonToast.show(
        type: ToastIconType.FAILED, msg: "提交失败");
  }

//  //失败提示
//  _failTip(String tips){
////    if(StringsHelper.isNotEmpty(tips)){
////      LogUtils.printLog(tips);
////    }
//    if(StringsHelper.isNotEmpty(tips)){
//      CommonToast.show(type: ToastIconType.FAILED,msg: tips);
//    }else{
//      CommonToast.dismiss();
//    }
//  }

  bool agree=false;//同意标志
  //同意点击
  onChangeAgree(checked){
    agree=checked??false;
    notifyListeners();
  }

  //通用网络请求错误回调
  _errorCallBack(data) {
    CommonToast.dismiss();
    CommonToast.show(type: ToastIconType.FAILED,msg: data?.toString());
  }
  
}