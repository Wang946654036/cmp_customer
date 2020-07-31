import 'dart:convert';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/models/response/base_response.dart';
import 'package:cmp_customer/models/response/check_in_details_response.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/home/tip_page.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:scoped_model/scoped_model.dart';

//租户入驻申请同意model
class CheckInAgreementModel extends Model {
  bool agree=false;//同意标志
  CheckInAgreementModel();

  //同意点击
  onChangeAgree(){
    agree=!agree;
    notifyListeners();
  }

  //提交申请
  uploadApplyData(CheckInDetails request){
    if(!agree){
      CommonToast.show(type: ToastIconType.FAILED,msg: "请查阅并同意签署以上协议");
      return;
    }
    CommonToast.show();
    String url;
    if(request.rentingEnterId!=null){//编辑
      url=HttpOptions.checkInEdit;
    }else{//新增
      url=HttpOptions.checkInCreate;
    };
    String data=json.encode(request);
    HttpUtil.post(url, _uploadApplyDataCallBack,
        jsonData: data,errorCallBack: _errorCallBack);
  }

  //申请成功
  _uploadApplyDataCallBack(data){
    try {
      BaseResponse resultModel = BaseResponse.fromJson(data);
      if (resultModel != null) {
        if (resultModel.success()) {
          //请求成功
          CommonToast.show(type: ToastIconType.SUCCESS, msg: "申请成功");
          Navigate.closePage(true);
        } else {
          CommonToast.show(type: ToastIconType.FAILED,
              msg: "提交失败:" + resultModel.message ?? "");
        }
      } else {
        CommonToast.show(type: ToastIconType.FAILED, msg: "提交失败,返回参数错误");
      }
    }catch(e){
      CommonToast.show(type: ToastIconType.FAILED, msg: "提交失败，返回参数错误");
    }
  }

  //通用网络请求错误回调
  _errorCallBack(data) {
    CommonToast.show(type: ToastIconType.FAILED,msg: "提交异常："+data?.toString());
  }

  //跳转到协议提示页面
  toAgrementTipPage(String title,String tip){
    Navigate.toNewPage(TipPage(title, tip));
  }
}