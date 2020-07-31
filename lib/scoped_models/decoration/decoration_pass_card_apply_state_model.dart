import 'dart:convert';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/models/hot_work_detail_model.dart';
import 'package:cmp_customer/models/response/base_response.dart';
import 'package:cmp_customer/models/response/check_in_details_response.dart';
import 'package:cmp_customer/models/response/decoration_pass_card_details_response.dart';
import 'package:cmp_customer/models/response/decoration_pass_card_effect_date_response.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/ui/check_in/check_in_agreement.dart';
import 'package:cmp_customer/ui/check_in/check_in_label.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/common/scrawl_page/scrawl_page.dart';
import 'package:cmp_customer/ui/decoration/decoration_pass_card_label.dart';
import 'package:cmp_customer/ui/home/tip_page.dart';
import 'package:cmp_customer/ui/house_authentication/select_house_page.dart';
import 'package:cmp_customer/ui/me/community_search_page.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/date_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../main.dart';
import '../images_state_model.dart';

//装修工出入证申请model
class DecorationPassCardApplyStateModel extends Model {
  DecorationPassCardDetails applyRequest = new DecorationPassCardDetails();
  TextEditingController applyCompanyController = new TextEditingController();//施工单位
//  TextEditingController applyCountController = new TextEditingController();//申请张数
  TextEditingController applyRemarkController = new TextEditingController();//备注

//  List<String> personList = new List();

  //初始化数据


//  //设置起始时间
//  setStartDate(String date){
//    applyRequest.beginDate=date;
//    notifyListeners();
//  }
//
//  //设置截止时间
//  setEndDate(String date){
//    applyRequest.endDate=date;
//    notifyListeners();
//  }

  //证件拍照回调
  imagesAttachmentCallback(List<Attachment> images){
    applyRequest.passPhotos=images;
    notifyListeners();
  }

//  //身份证拍照回调
//  imagesIDCallback(List<Attachment> images){
////    applyRequest.attZhrzList=images;
//    notifyListeners();
//  }

//  //头像拍照回调
//  imagesHeadCallback(List<Attachment> images){
////    applyRequest.attZhrzList=images;
//    notifyListeners();
//  }

//  //添加人员
//  addPerson(){
//
//  }

  //校验数据
  checkUploadData(){
//    if(applyRequest.passPhotos == null || applyRequest.passPhotos.isEmpty){
//      CommonToast.show(type: ToastIconType.FAILED,msg: "请上传证件照片");
//      return;
//    }else
    if(applyRequest.userList == null || applyRequest.userList.isEmpty){
      CommonToast.show(type: ToastIconType.FAILED,msg: "请添加装修人员");
      return;
    }else {
      int length=applyRequest.userList.length;
      for(int i=0;i<length;i++){
        if(StringsHelper.isEmpty(applyRequest.userList[i].name)){
          CommonToast.show(type: ToastIconType.FAILED,msg: "请输入第"+(i+1).toString()+"位装修人员的姓名");
          return;
        }else if(StringsHelper.isEmpty(applyRequest.userList[i].idCard)){
          CommonToast.show(type: ToastIconType.FAILED,msg: "请输入第"+(i+1).toString()+"位装修人员的身份证号");
          return;
        }else if(applyRequest.userList[i].idCardPhotos==null||applyRequest.userList[i].idCardPhotos.isEmpty){
          CommonToast.show(type: ToastIconType.FAILED,msg: "请上传第"+(i+1).toString()+"位装修人员的身份证照");
          return;
        }else if(applyRequest.userList[i].headPhotos==null||applyRequest.userList[i].headPhotos.isEmpty){
          CommonToast.show(type: ToastIconType.FAILED,msg: "请上传第"+(i+1).toString()+"位装修人员的正面头像");
          return;
        }else if(StringsHelper.isEmpty(applyRequest.userList[i].beginDate)){
          CommonToast.show(type: ToastIconType.INFO,msg: "请选择第"+(i+1).toString()+"位装修人员的证件有效开始时间");
          return;
        }else if(DateUtils.isBefore(applyRequest.userList[i].beginDate,applyRequest.beginDate)){
          CommonToast.show(type: ToastIconType.INFO,msg: "第"+(i+1).toString()+"位装修人员的证件有效开始时间不能小于"+label_apply_accreditation_start_date);
          return;
        }else if(StringsHelper.isEmpty(applyRequest.userList[i].endDate)){
          CommonToast.show(type: ToastIconType.INFO,msg: "请选择第"+(i+1).toString()+"位装修人员的证件有效结束时间");
          return;
        }else if(DateUtils.isAfterDay(applyRequest.userList[i].endDate,applyRequest.endDate)){
          CommonToast.show(type: ToastIconType.INFO,msg: "第"+(i+1).toString()+"位装修人员的证件有效结束时间不能大于于"+label_apply_accreditation_end_date);
          return;
        }
        if(applyRequest.userList[i].idCardPhotos!=null){
          for(int j=0;j<applyRequest.userList[i].idCardPhotos.length;j++){
            if(applyRequest.userList[i].idCardPhotos[j]==null){
              CommonToast.show(type: ToastIconType.FAILED,msg: "尚有未上传完成的图片");
              return ;
            }
          }
        }
        if(applyRequest.userList[i].headPhotos!=null){
          for(int j=0;j<applyRequest.userList[i].headPhotos.length;j++){
            if(applyRequest.userList[i].headPhotos[j]==null){
              CommonToast.show(type: ToastIconType.FAILED,msg: "尚有未上传完成的图片");
              return ;
            }
          }
        }
      }
    }
    if(applyRequest.passPhotos!=null){
      for(int i=0;i<applyRequest.passPhotos.length;i++){
        if(applyRequest.passPhotos[i]==null){
          CommonToast.show(type: ToastIconType.FAILED,msg: "尚有未上传完成的图片");
          return ;
        }
      }
    }
    //保存数据
    applyRequest.company=applyCompanyController.text.toString().trim();
    applyRequest.paperCount=applyRequest.userList?.length;
    applyRequest.remark=applyRemarkController.text.toString().trim();


    //需要签名才能申请
    Navigate.toNewPage(ScrawlPage(), callBack: (path) {
      if (path != null && path is String && StringsHelper.isNotEmpty(path)) {
        CommonToast.show();
        ImagesStateModel().uploadFile(path, (data) {
          Attachment info = Attachment.fromJson(data);
          applyRequest.creatorWriteUuid = info?.attachmentUuid;
          _uploadApplyData();
        }, (data) {
          CommonToast.show(type: ToastIconType.FAILED, msg: data?.toString() ?? "");
        });
      }
    });
  }

//提交申请
  _uploadApplyData(){
    String url;
    if(applyRequest.id!=null){//编辑
      url=HttpOptions.decorationPassCardUpdate;
    }else{//新增
      url=HttpOptions.decorationPassCardSave;
    };
    String data=json.encode(applyRequest);
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
              msg: resultModel.message ?? "");
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

  //设置详情信息
  setDetailsInfo(DecorationPassCardDetails info){
    applyRequest=info;
    applyCompanyController.text=applyRequest?.company??"";
//    applyCountController.text=applyRequest?.paperCount?.toString()??"";
    applyRemarkController.text=applyRequest?.remark??"";
    if(applyRequest.id==null && applyRequest.userList == null){
      //新增，默认增加一个员工信息
      applyRequest?.userList = List();
      applyRequest.userList.add(UserList());
    }
  }


  //获取有效的申请时间范围
  getEffectDate(){
    Map<String,dynamic> params = new Map();
    params['houseId']= applyRequest.houseId;
    HttpUtil.post(HttpOptions.decorationPassCardEffectDate, _getEffectDateCallBack,
        jsonData: json.encode(params),errorCallBack: _errorCallBack);
  }

  //获取有效的申请时间范围成功
  _getEffectDateCallBack(data){
    try {
      DecorationPassCardEffectDateResponse resultModel = DecorationPassCardEffectDateResponse.fromJson(data);
      if (resultModel != null) {
        if (resultModel.success()) {
          applyRequest.beginDate=resultModel.effectDate.fromDate;
          applyRequest.endDate=resultModel.effectDate.delayDate;
          notifyListeners();
        } else {
          CommonToast.show(type: ToastIconType.FAILED,
              msg: resultModel.message ?? "");
        }
      } else {
        CommonToast.show(type: ToastIconType.FAILED, msg: "提交失败,返回参数错误");
      }
    }catch(e){
      CommonToast.show(type: ToastIconType.FAILED, msg: "提交失败，返回参数错误");
    }
  }
}