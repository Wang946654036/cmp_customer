
import 'dart:convert';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/pay_info_response.dart';
import 'package:cmp_customer/models/response/base_response.dart';
import 'package:cmp_customer/models/response/parking_card_details_response.dart';
import 'package:cmp_customer/models/response/parking_card_monthly_fee_response.dart';
import 'package:cmp_customer/models/response/parking_card_pay_info_response.dart';
import 'package:cmp_customer/models/response/parking_card_price_response.dart';
import 'package:cmp_customer/models/response/parking_card_prices_response.dart';
import 'package:cmp_customer/scoped_models/base_model.dart';
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

//在线支付
class PayStateModel extends BaseModel {
  static const String payReturnUrl="https://ukhomeclosepage";//目前随便定义(小写)，用于处理支付后返回

  //获取支付地址(后台没封装，只能自己传对应的url)
  getPayUrl(int businessId,String businessType, ValueChanged<String> callback){
    Map<String, dynamic> params = new Map();
    params["businessId"] = businessId;//业务id
    params["businessType"] = businessType;//业务类型：
    params["payType"] = "WAP";//固定的支付方式
    params["returnUrl"] = payReturnUrl;
    params["notifyUrl"] = "https://wushaoqin.imdo.co/ubms-foreign/foreign/cmPay/payResultNotify/brandName";//测试回调地址，绍钦花生壳回调
    params["totalFee"] = "1";//测试费用
    HttpUtil.post(HttpOptions.getCMPay, (data){
      _getPayUrlCallBack(data,callback);
    },
        jsonData: json.encode(params),errorCallBack: errorCallBack);
  }

  //获取支付地址回调
  _getPayUrlCallBack(data,ValueChanged<String> callback){
    CommonToast.dismiss();
    try{
      PayInfoResponse response = PayInfoResponse.fromJson(data);
      if(StringsHelper.isNotEmpty(response?.data?.payUrl)){
        callback(response.data.payUrl);
      }else{
        errorCallBack(response.message??"获取支付信息失败，请稍后重试");
      }
    }catch(e){
      errorCallBack("获取支付信息失败，请稍后重试");
    }

  }

}