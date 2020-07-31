
import 'dart:convert';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/models/common_result_model.dart';
import 'package:cmp_customer/models/request/entrance_card_apply_request.dart';
import 'package:cmp_customer/models/response/base_response.dart';
import 'package:cmp_customer/models/response/entrance_card_details_response.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_apply.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_operation_step.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_state.dart';
import 'package:cmp_customer/utils/common_event_bus.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tip_dialog/tip_dialog.dart';
import 'package:toast/toast.dart';

class EntranceDetailsStateModel extends Model {
//  BuildContext mContext;
//  EntranceDetailsStateModel(this.mContext);
  EntranceCardDetailsInfo detailsInfo = new EntranceCardDetailsInfo();
  ListState mineState=ListState.HINT_LOADING;

  //设置详情
  setDetailsInfo(EntranceCardDetailsInfo info){
    detailsInfo = info;
    mineState=ListState.HINT_DISMISS;//加载完成，隐藏加载页面
    notifyListeners();
  }

  //获取停车卡详情
  getDetails(int accessCardId){
    Map<String, Object> params = new Map();
    params['accessCardId'] = accessCardId;
    HttpUtil.post(HttpOptions.entranceDetail, _getDetailsCallBack,
        jsonData: json.encode(params),errorCallBack: _getDetailsError);
  }
  //点击了确认按钮
  confirmOnDetailsTap(){
    if(detailsInfo.status==auditLandlordFailed||detailsInfo.status==auditPropertyFailed){
      //重新修改操作
//      Navigate.toNewPage(EntranceCardApplyPage(getEntranceApplyType(detailsInfo.customerType),detailsInfo:detailsInfo));
      Navigate.toNewPage(EntranceCardApplyPage(detailsInfo:detailsInfo),callBack: (success){
        if(success != null && success){
          Navigate.closePage();
        }
      });
    }
  }
  //点击了取消按钮
  cancelOnDetailsTap(){
    if(detailsInfo.status==auditLandlordWaiting||detailsInfo.status==auditLandlordFailed||detailsInfo.status==auditPropertyWaiting||detailsInfo.status==auditPropertyFailed){
      //撤销操作
      CommonToast.show();
      Map<String, Object> params = new Map();
      params['accessCardId'] = detailsInfo.accessCardId;
      params['operateStep'] = entrance_step_cancel;//撤销
      HttpUtil.post(HttpOptions.changeEntranceStatus, _uploadCallBack,
          params: params,errorCallBack: _errorCallBack);

    }
  }

  //获取详情回调
  _getDetailsCallBack(data){
    EntranceCardDetailsResponse model = EntranceCardDetailsResponse.fromJson(data);
    if(model!=null){
      if(model.success() && model.entranceCardDetailsInfo!=null){
        setDetailsInfo(model.entranceCardDetailsInfo);
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
    notifyListeners();
  }

  //通用提交回调
  _uploadCallBack(data){
    CommonToast.dismiss();
//    EntranceCardDetailsModel model = EntranceCardDetailsModel.fromJson(data);
    try{
      BaseResponse model = BaseResponse.fromJson(data);
      if(model.success()){
        LogUtils.printLog("提交成功");
        Navigate.closePage();
        entrance_card_bus.emit(entrance_refresh);//发送刷新事件
        return ;
      }else{
        CommonToast.show(type: ToastIconType.FAILED,msg:  model.message?? "");
      }
    }catch(e){
      CommonToast.show(type: ToastIconType.FAILED,msg: "提交失败");
    }
  }

//  //失败提示
//  _failTip(String tips){
//    if(StringsHelper.isNotEmpty(tips)){
//      LogUtils.printLog(tips);
//    }
//  }


  //通用提交回调
  _errorCallBack(data){
    CommonToast.show(type: ToastIconType.FAILED,msg: data?.toString());
  }

  
}