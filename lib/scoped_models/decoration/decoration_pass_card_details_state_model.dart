import 'dart:convert';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/models/hot_work_detail_model.dart';
import 'package:cmp_customer/models/response/base_response.dart';
import 'package:cmp_customer/models/response/decoration_pass_card_details_response.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/ui/check_in/check_in_operation_step.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/common/scrawl_page/scrawl_page.dart';
import 'package:cmp_customer/ui/decoration/decoration_pass_card_apply.dart';
import 'package:cmp_customer/ui/decoration/decoration_pass_card_status.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

import '../images_state_model.dart';

//详情model
class DecorationPassCardDetailsModel extends Model {
  bool isEnterprise=false;//true：企业客户，false：个人客户
  DecorationPassCardDetails details = new DecorationPassCardDetails();
  ListState detailsState=ListState.HINT_LOADING;
  int customerType;
  TextEditingController applyRemarkController = new TextEditingController();//备注

  //设置查询客户类型
  setCustomerType(int type){
    customerType=type;
  }


  //获取详情
  getDetails(int id){
    Map<String, Object> params = new Map();
    params['id'] = id;
    HttpUtil.post(HttpOptions.decorationPassCardDetail, _getDetailsCallBack,
        jsonData: json.encode(params),errorCallBack: _getDetailsError);
  }
  //点击了确认按钮
  confirmOnDetailsTap(){
    if(customerType==0){
      //需要签名
      Navigate.toNewPage(ScrawlPage(), callBack: (path) {
        if (path != null && path is String && StringsHelper.isNotEmpty(path)) {
          CommonToast.show();
          ImagesStateModel().uploadFile(path, (data) {
            Attachment info = Attachment.fromJson(data);
            // 业主同意操作
            Map<String, Object> params = new Map();
            params['id'] = details.id;
            params['status'] = "1";//同意
            params['checkRole'] = details.bpmCurrentRole;
            params['nodeRemark'] = applyRemarkController.text.trim();
            params['ownerWriteUuid'] = info?.attachmentUuid;
            params['checkUserUuid'] = info?.attachmentUuid;//接口需要传递这个参数才能生成节点信息
            HttpUtil.post(HttpOptions.decorationPassCardChangeStatus, _uploadCallBack,
                jsonData: json.encode(params),errorCallBack: _errorCallBack);
          }, (data) {
            CommonToast.show(type: ToastIconType.FAILED, msg: data?.toString() ?? "");
          });
        }
      });
    }else{
//      if(details.state==auditLandlordWaiting||details.state==auditLandlordFailed||details.state==auditPropertyFailed){
        //重新修改操作
        Navigate.toNewPage(DecorationPassCardApplyPage(details),callBack: (success){
          if(success!=null&&success){
            Navigate.closePage(true);
          }
        });
//      }
    }
  }
  //点击了取消按钮
  cancelOnDetailsTap(){
    if(customerType==0){
      //业主审核操作
//      if(details.state==auditLandlordWaiting){
        if(StringsHelper.isEmpty(applyRemarkController.text.trim())){
          CommonToast.show(msg: "不同意申请，需填写缘由", type: ToastIconType.INFO);
        }else{
          //不同意
          CommonToast.show();
          Map<String, Object> params = new Map();
          params['id'] = details.id;
          params['status'] = "0";//不同意
          params['checkRole'] = details.bpmCurrentRole;
          params['nodeRemark'] = applyRemarkController.text.trim();
          HttpUtil.post(HttpOptions.decorationPassCardChangeStatus, _uploadCallBack,
              jsonData: json.encode(params),errorCallBack: _errorCallBack);
        }
//      }
    }else{
//      if(details.state==auditLandlordWaiting||details.state==auditLandlordFailed||details.state==auditPropertyFailed||details.state==payWaiting){
//      撤销操作
        CommonToast.show();
        Map<String, Object> params = new Map();
        params['id'] = details.id;
        params['status'] = "2";//撤销
        params['checkRole'] = details.bpmCurrentRole;
        HttpUtil.post(HttpOptions.decorationPassCardChangeStatus, _uploadCallBack,
            jsonData: json.encode(params),errorCallBack: _errorCallBack);
//      }
    }
  }

  //获取详情回调
  _getDetailsCallBack(data){
    DecorationPassCardDetailsResponse model = DecorationPassCardDetailsResponse.fromJson(data);
    if(model!=null){
      if(model.code=='0' && model.details!=null){
        details =model.details;
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