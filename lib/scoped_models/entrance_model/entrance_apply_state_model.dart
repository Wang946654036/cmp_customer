import 'dart:convert';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/common_result_model.dart';
import 'package:cmp_customer/models/request/base_request.dart';
import 'package:cmp_customer/models/request/entrance_card_apply_request.dart';
import 'package:cmp_customer/models/response/base_response.dart';
import 'package:cmp_customer/models/response/entrance_card_details_response.dart';
import 'package:cmp_customer/models/response/entrance_card_house_response.dart';
import 'package:cmp_customer/models/response/entrance_card_setting_response.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_apply.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_house_select.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_operation_step.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_state.dart';
import 'package:cmp_customer/ui/house_authentication/house_list.dart';
import 'package:cmp_customer/ui/parking/parking_card_state.dart';
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

class EntranceApplyStateModel extends Model {
//  BuildContext mContext;
//  EntranceApplyStateModel(this.mContext);
  EntranceCardApplyRequest applyInfo = new EntranceCardApplyRequest();
  TextEditingController applyPhoneController = new TextEditingController(); //申请人电话
  TextEditingController applyCountController = new TextEditingController(); //申请张数
  TextEditingController applyReasonController = new TextEditingController(); //申请原因
  EntranceApplyType applyType;
  bool existingOwner; //是否存在业主的房屋
  List<HouseInfo> houseList;
  int selectedIndex = -1; //选中的房屋
  bool needHeadInfo = false;
  String chargeDesc; //收费标准
  bool agree = false;
  //同意点击
  onChangeAgree(){
//    agree=checked??false;
    agree=!agree;
    notifyListeners();
  }

  //默认房屋客户类型设置
  setDefaultCustomerType() {
    applyType = stateModel.customerProper == customerYZ ? EntranceApplyType.landlord : EntranceApplyType.tenant;
    existingOwner = stateModel.customerProper == customerYZ;
  }

  //房屋选择
  chooseHouse() {
    if (houseList != null && houseList.isNotEmpty) {
      Navigate.toNewPage(EntranceCardHouseSelectPage(this));
    }
  }

  //设置选中的房屋
  setSelectedIndex(int index) {
    selectedIndex = index;
    applyInfo.houseId = houseList[selectedIndex].houseId;
    applyType =
        houseList[selectedIndex].custProper == customerYZ ? EntranceApplyType.landlord : EntranceApplyType.tenant;
    notifyListeners();
    Navigate.closePage();
  }

  //获取门禁卡方案
  getEntranceSetting() {
    Map<String, Object> params = new Map();
    params['projectId'] = stateModel.defaultProjectId; //项目编码id
    HttpUtil.post(HttpOptions.entranceSetting, _getEntranceSettingCallBack,
        params: params, errorCallBack: _errorCallBack);
  }

  //获取门禁卡方案成功
  _getEntranceSettingCallBack(data) {
    try {
      EntranceCardSettingResponse resultModel = EntranceCardSettingResponse.fromJson(data);
      if (resultModel.success() && resultModel.entranceCardSetting != null) {
        applyInfo.settingId = resultModel.entranceCardSetting.settingId;
        applyInfo.payFees = resultModel.entranceCardSetting.unitPrice;
        needHeadInfo = resultModel.entranceCardSetting.headIconFlag == "YES"; //是否需要头像信息
        chargeDesc = resultModel.entranceCardSetting.chargeDesc;
      } else {
        CommonToast.show(type: ToastIconType.FAILED, msg: resultModel?.message ?? "");
      }
    } catch (e) {
      CommonToast.show(type: ToastIconType.FAILED, msg: "请求失败");
    }
  }

  //提交申请数据
  checkUploadData() {
    bool canUpload = true;
    if (applyInfo.houseId == null) {
      CommonToast.show(msg: "请选择房屋", type: ToastIconType.INFO);
      canUpload = false;
    } else if (StringsHelper.isEmpty(applyPhoneController.text)) {
      CommonToast.show(msg: "请输入申请人电话", type: ToastIconType.INFO);
      canUpload = false;
    } else if (!StringsHelper.isPhone(applyPhoneController.text)) {
      CommonToast.show(msg: "请输入正确的电话", type: ToastIconType.INFO);
      canUpload = false;
    } else if (StringsHelper.isEmpty(applyCountController.text) ||
        StringsHelper.getIntValue(applyCountController.text) <= 0) {
      CommonToast.show(msg: "请输入正确的申请张数", type: ToastIconType.INFO);
      canUpload = false;
    } else if (needHeadInfo && (applyInfo.attHeadList == null || applyInfo.attHeadList.isEmpty)) {
      CommonToast.show(msg: "请上传头像", type: ToastIconType.INFO);
      canUpload = false;
    } else if (applyType == EntranceApplyType.tenant &&
        (applyInfo.attSfzList == null || applyInfo.attSfzList.isEmpty)) {
      CommonToast.show(msg: "请上传身份证证件", type: ToastIconType.INFO);
      canUpload = false;
    }

    if (applyInfo.attHeadList != null) {
      for (int i = 0; i < applyInfo.attHeadList.length; i++) {
        if (applyInfo.attHeadList[i] == null) {
          CommonToast.show(type: ToastIconType.FAILED, msg: "尚有未上传完成的图片");
          canUpload = false;
          break;
        }
      }
    }
    if (applyInfo.attSfzList != null) {
      for (int i = 0; i < applyInfo.attSfzList.length; i++) {
        if (applyInfo.attSfzList[i] == null) {
          CommonToast.show(type: ToastIconType.FAILED, msg: "尚有未上传完成的图片");
          canUpload = false;
          break;
        }
      }
    }
    if (applyInfo.attMjkfjList != null) {
      for (int i = 0; i < applyInfo.attMjkfjList.length; i++) {
        if (applyInfo.attMjkfjList[i] == null) {
          CommonToast.show(type: ToastIconType.FAILED, msg: "尚有未上传完成的图片");
          canUpload = false;
          break;
        }
      }
    }
    return canUpload;
  }

  //提交申请
  uploadApplyData() {
    applyInfo.reason = applyReasonController.text;
    applyInfo.remark = applyReasonController.text;
    applyInfo.customerPhone = applyPhoneController.text;
    applyInfo.applyCount = StringsHelper.getIntValue(applyCountController.text);
    CommonToast.show();
    String url;
    if (applyInfo.businessNo != null) {
      //业务单号不为空，则为编辑
      url = HttpOptions.entranceEdit;
    } else {
      //新增
      applyInfo.projectId = stateModel.defaultProjectId; //项目id
//      applyInfo.buildId=1;//楼栋id
//      applyInfo.unitId=1;//单元id
//      applyInfo.customerId=(applyType==EntranceApplyType.tenant?10:20);//申请人id 测试业主
      url = HttpOptions.entranceCreate;
    }
    ;
    String data = json.encode(applyInfo);
    HttpUtil.post(url, _uploadApplyDataCallBack, jsonData: data, errorCallBack: _errorCallBack);
  }

  //申请成功
  _uploadApplyDataCallBack(data) {
    CommonToast.dismiss();
    try {
      BaseResponse resultModel = BaseResponse.fromJson(data);
      if (resultModel.success()) {
        //请求成功
        LogUtils.printLog("门禁卡申请成功：" + resultModel.message);
        CommonToast.show(type: ToastIconType.SUCCESS, msg: "门禁卡申请成功");
        Navigate.closePage(true);
        entrance_card_bus.emit(entrance_refresh); //发送刷新事件
//        if(applyInfo.businessNo!=null) {
//          //编辑关闭详情页面
//          Navigate.closePage();
//        }
      } else {
        CommonToast.show(type: ToastIconType.FAILED, msg: resultModel.message ?? "");
      }
    } catch (e) {
      CommonToast.show(type: ToastIconType.FAILED, msg: "门禁卡申请失败");
    }
  }

  //获取房屋列表
  getHouseList() {
    EntranceCardApplyRequest request = new EntranceCardApplyRequest();
    request.projectId = stateModel.defaultProjectId;
    HttpUtil.post(HttpOptions.houseCertifiedList, _getEntranceHouseCallBack,
        jsonData: json.encode(request), errorCallBack: _errorCallBack);
  }

  //获取房屋列表成功
  _getEntranceHouseCallBack(data) {
    try {
      EntranceCardHouseResponse response = EntranceCardHouseResponse.fromJson(data);
      if (response.success()) {
        houseList = response.houseList;
        int length = houseList.length;
        for (int i = 0; i < length; i++) {
          if (applyInfo.businessNo == null) {
            //业务单号为空，新增才设置默认的房屋
            if (houseList[i].isDefaultHouse == "1") {
              //默认房屋
              selectedIndex = i;
              applyInfo.houseId = houseList[selectedIndex].houseId;
//              applyType=houseList[selectedIndex].custProper==customerYZ?EntranceApplyType.landlord:EntranceApplyType.tenant;
              notifyListeners();
            }
          }
          if (houseList[i].custProper == customerYZ) {
            existingOwner = true;
          }
          if (existingOwner && selectedIndex >= 0) {
            break;
          }
        }
      } else {
        CommonToast.show(type: ToastIconType.FAILED, msg: response?.message ?? "");
      }
    } catch (e) {
      CommonToast.show(type: ToastIconType.FAILED, msg: "获取房屋列表失败");
    }
  }

  //头像回调
  imagesHeadCallback(List<String> images) {
    applyInfo.attHeadList = images;
    notifyListeners();
  }

  //身份证回调
  imagesSfzCallback(List<String> images) {
    applyInfo.attSfzList = images;
    notifyListeners();
  }

  //相关附件
  imagesMjkfjCallback(List<Attachment> images) {
    applyInfo.attMjkfjList = images;
    notifyListeners();
  }

  //设置详情信息
  setDetailsInfo(EntranceCardDetailsInfo info) {
    applyInfo.accessCardId = info.accessCardId; //申请id
    applyInfo.applyCount = info.applyCount;
//    applyInfo.attHeadList = info.attHeadList;
//    applyInfo.attSfzList = info.attHeadList;
    applyInfo.businessNo = info.businessNo;
//    applyInfo.customerId = info.customerId;
    applyInfo.customerPhone = info.customerPhone;
//    applyInfo.customerType = info.customerType;
    applyInfo.houseId = info.houseId;
//    applyInfo.houseNo = info.houseNo;
    applyInfo.ownerId = info.ownerId;
    applyInfo.payFees = info.payFees;
    applyInfo.projectId = info.projectId;

    applyInfo.attHeadList = _getLastAttHeadList(info.recordList);
    applyInfo.attSfzList = _getLastAttSfzList(info.recordList);

    applyPhoneController.text = StringsHelper.getStringValue(info.customerPhone);
    applyCountController.text = StringsHelper.getStringValue(info.applyCount);
    applyReasonController.text = StringsHelper.getStringValue(info.reason);

    applyType = info.customerType == customerYZ ? EntranceApplyType.landlord : EntranceApplyType.tenant;
//    applyInfo.reason = info.reason;
//    applyInfo.remark = info.remark;
//    applyInfo.unitId = info.unitId;
//    applyMonthsController = new TextEditingController(text:StringsHelper.getStringValue(info.applyMonths));//申请月份
  }

//获取头像照片（最后一次修改的列表）
  _getLastAttHeadList(List<RecordList> list) {
    List<String> photos = new List();
    if (list != null) {
      for (int i = list.length - 1; i >= 0; i--) {
        if (list[i].operateStep == entrance_step_edit ||
            list[i].operateStep == entrance_step_apply ||
            list[i].operateStep == entrance_step_apply_yz ||
            list[i].operateStep == entrance_step_apply_zh) {
          if (list[i].attHeadList != null) {
            photos.addAll(list[i].attHeadList);
          }
//          list[i].attHeadList.forEach((att){
//            photos.add(att.attachmentUuid);
//          });
          break;
        }
      }
    }
    return photos;
  }

  //获取身份证照片（最后一次修改的列表）
  _getLastAttSfzList(List<RecordList> list) {
    List<String> photos = new List();
    if (list != null) {
      for (int i = list.length - 1; i >= 0; i--) {
        if (list[i].operateStep == entrance_step_edit ||
            list[i].operateStep == entrance_step_apply ||
            list[i].operateStep == entrance_step_apply_yz ||
            list[i].operateStep == entrance_step_apply_zh) {
          if (list[i].attSfzList != null) {
            photos.addAll(list[i].attSfzList);
          }
//          list[i].attSfzList.forEach((att){
//            photos.add(att.attachmentUuid);
//          });
          break;
        }
      }
    }
    return photos;
  }

//  //设置
//  initParkingPackageInfo(){
//    if(parkingCardPrices.isNotEmpty&&applyInfo?.applyMonths!=null){
//      int length=parkingCardPrices.length;
//      for(int i=0;i<length;i++){
//        if(parkingCardPrices[i].priceId==applyInfo.parkingPackageId){
//          applyInfo.parkingLot = parkingCardPrices[i].parkName;//停车场名称（创建时必填）
//          applyInfo.parkingLotId = parkingCardPrices[i].parkId;//停车场id（创建时必填）
//          applyInfo.parkingPackage = parkingCardPrices[i].priceName;//停车场套餐（创建时必填）
//          applyInfo.parkingPackageId = parkingCardPrices[i].priceId;//停车套餐id（创建时必填）
//          int month = applyInfo.applyMonths;
//          if(month>0){
//            applyMonthsController.text=StringsHelper.getStringValue(applyInfo.applyMonths);//申请月份
////            applyMonthsController = new TextEditingController(text:StringsHelper.getStringValue(applyInfo.applyMonths));
//            applyInfo.payFees = StringsHelper.getStringToDoubleValue(parkingCardPrices[i].price) *  month;//套餐费用
//          }
//          notifyListeners();
//          return;
//        }
//      }
//    }
//  }

  //设置张数监听
  setApplyCountListenr() {
//    applyMonthsController.addListener((){
//      int month=StringsHelper.getIntValue(applyMonthsController.text);
//      if(month>=0&&selectedPrices>=0){
//        applyInfo.payFees=month * StringsHelper.getStringToDoubleValue(parkingCardPrices[selectedPrices].price);
//      }else{
//        //输入错误
//      }
//      notifyListeners();
//    });
  }

  //通用网络请求错误回调
  _errorCallBack(data) {
    CommonToast.show(type: ToastIconType.FAILED, msg: data?.toString());
  }
}
