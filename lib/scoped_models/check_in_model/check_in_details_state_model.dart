import 'dart:convert';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/models/response/base_response.dart';
import 'package:cmp_customer/models/response/check_in_details_response.dart';
import 'package:cmp_customer/ui/check_in/check_in_apply.dart';
import 'package:cmp_customer/ui/check_in/check_in_operation_step.dart';
import 'package:cmp_customer/ui/check_in/check_in_status.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:scoped_model/scoped_model.dart';

//租户入驻详情model
class CheckInDetailsModel extends Model {
  bool isEnterprise=false;//true：企业客户，false：个人客户
  CheckInDetails checkIndetails = new CheckInDetails();
  ListState detailsState=ListState.HINT_LOADING;


  //获取停详情
  getDetails(int id){
    Map<String, Object> params = new Map();
    params['rentingEnterId'] = id;
    HttpUtil.post(HttpOptions.checkInDetail, _getDetailsCallBack,
        jsonData: json.encode(params),errorCallBack: _getDetailsError);
  }
  //点击了确认按钮
  confirmOnDetailsTap(){
    if(checkIndetails.status==auditWaiting||checkIndetails.status==auditFailed){
      //重新修改操作
      Navigate.toNewPage(CheckInApplyPage(details:checkIndetails),callBack: (success){
        if(success??false){
          Navigate.closePage(true);
        }
      });
    }
  }
  //点击了取消按钮
  cancelOnDetailsTap(){
    if(checkIndetails.status==auditWaiting||checkIndetails.status==payWaiting||checkIndetails.status==auditFailed){
      //撤销操作
      CommonToast.show();
      Map<String, Object> params = new Map();
      params['rentingEnterId'] = checkIndetails.rentingEnterId;
      params['operateStep'] = check_in_step_cancel;//撤销
      HttpUtil.post(HttpOptions.changeCheckInStatus, _uploadCallBack,
          params: params,errorCallBack: _errorCallBack);
    }
  }

  //获取详情回调
  _getDetailsCallBack(data){
    CheckInDetailsResponse model = CheckInDetailsResponse.fromJson(data);
    if(model!=null){
      if(model.success() && model.details!=null){
        checkIndetails =model.details;
        isEnterprise = checkIndetails.rentType=="Q";
        detailsState=ListState.HINT_DISMISS;//加载完成，隐藏加载页面
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
    detailsState = ListState.HINT_LOADED_FAILED_CLICK;
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
        Navigate.closePage(true);
        return ;
      }else{
        CommonToast.show(type: ToastIconType.FAILED,msg:  model.message?? "");
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