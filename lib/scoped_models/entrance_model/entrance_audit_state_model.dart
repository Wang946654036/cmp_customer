
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

class EntranceAuditStateModel extends Model {

  TextEditingController remarkController = new TextEditingController();//备注

  //审核通过
  confirmTap(int accessCardId){
    CommonToast.show();
    Map<String, Object> params = new Map();
    params['accessCardId'] = accessCardId;//门禁卡办理id
    params['operateStep'] = entrance_step_audit_yz;//业主审核
    params['status'] = 1;//0、不通过；1、通过
    params['remark'] = remarkController.text;//备注
    HttpUtil.post(HttpOptions.changeEntranceStatus, _auditCallBack,
        params: params,errorCallBack: _errorCallBack);

  }

  //审核不通过
  cancelTap(int accessCardId){
    CommonToast.show();
    Map<String, Object> params = new Map();
    params['accessCardId'] = accessCardId;//门禁卡办理id
    params['operateStep'] = entrance_step_audit_yz;//业主审核
    params['status'] = 0;//0、不通过；1、通过
    params['remark'] = remarkController.text;//备注
    HttpUtil.post(HttpOptions.changeEntranceStatus, _auditCallBack,
        params: params,errorCallBack: _errorCallBack);

  }
  //审核提交回调
  _auditCallBack(data){
    CommonToast.dismiss();
    try{
      BaseResponse model = BaseResponse.fromJson(data);
      if(model.success()){
        LogUtils.printLog("提交成功");
        CommonToast.show(type: ToastIconType.SUCCESS,msg:"门禁卡审核成功");
        Navigate.closePage(true);
        entrance_card_bus.emit(entrance_audit_refresh);//发送刷新事件
        return ;
      }else{
        CommonToast.show(type: ToastIconType.FAILED,msg: model.message??"");
      }
    }catch(e){
      CommonToast.show(type: ToastIconType.FAILED,msg: "提交失败");
    }
  }


  //通用提交回调
  _errorCallBack(data){
    CommonToast.show(type: ToastIconType.FAILED,msg: data?.toString());
  }

  
}