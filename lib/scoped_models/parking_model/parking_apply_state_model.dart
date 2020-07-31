
import 'dart:convert';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/common_result_model.dart';
import 'package:cmp_customer/models/request/parking_card_apply_request.dart';
import 'package:cmp_customer/models/response/agreement_response.dart';
import 'package:cmp_customer/models/response/base_response.dart';
import 'package:cmp_customer/models/response/parking_card_details_response.dart';
import 'package:cmp_customer/models/response/parking_card_prices_response.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/parking/parking_card_agreement.dart';
import 'package:cmp_customer/ui/parking/parking_card_operation_step.dart';
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

class ParkingApplyStateModel extends Model {
//  BuildContext mContext;
//  ParkingApplyStateModel(this.mContext);
  ParkingCardApplyRequest applyInfo = new ParkingCardApplyRequest();
//  TextEditingController carNoController = new TextEditingController();//车牌号
  TextEditingController carBrandController = new TextEditingController();//车牌品牌
  TextEditingController carColorController = new TextEditingController();//车辆颜色
  TextEditingController carOwnerNameController = new TextEditingController();//车主姓名
  TextEditingController carOwnerPhoneController = new TextEditingController();//车主电话
  TextEditingController applyMonthsController = new TextEditingController();//申请月份
  List<ParkingCardPrices> parkingCardPrices = new List<ParkingCardPrices>();//停车场套餐信息
  int selectedPrices=-1;//选中的停车场套餐信息
  bool agree=false;//同意标志
  AgreementInfo agreementInfo;//协议


  ListState parkingCardPriceListState = ListState.HINT_LOADING;


  //提交申请数据
  checkUploadData(){
    if(StringsHelper.isEmpty(applyInfo.parkingLot)){
      CommonToast.show(type: ToastIconType.INFO,msg:"请选择停车场");
//      applyInfo.parkingLot="01";
//      applyInfo.parkingLotId="1";
//      notifyListeners();
      return;
    }else if(StringsHelper.isEmpty(applyInfo.parkingPackage)){
      CommonToast.show(type: ToastIconType.INFO,msg:"请选择套餐");
//      applyInfo.parkingPackage="02";
//      applyInfo.payFees=88;
//      applyInfo.parkingPackageId="2";
      notifyListeners();
      return;
    }else if(StringsHelper.isEmpty(applyInfo?.carNo)){
      CommonToast.show(type: ToastIconType.INFO,msg:"请输入车牌号");
      return;
    }else if(!StringsHelper.isCarNo(applyInfo?.carNo)){
      CommonToast.show(type: ToastIconType.INFO,msg:"请输入正确的车牌号");
      return;
    }else if(StringsHelper.isEmpty(carOwnerNameController.text)){
      CommonToast.show(type: ToastIconType.INFO,msg:"请输入车主姓名");
      return;
    }else if(StringsHelper.isEmpty(carOwnerPhoneController.text)){
      CommonToast.show(type: ToastIconType.INFO,msg:"请输入车主电话");
      return;
    }else if(!StringsHelper.isPhone(carOwnerPhoneController.text)){
      CommonToast.show(type: ToastIconType.INFO,msg:"请输入正确的电话");
      return;
    }else if(StringsHelper.isEmpty(applyMonthsController.text)||StringsHelper.getIntValue(applyMonthsController.text)<=0){
      CommonToast.show(type: ToastIconType.INFO,msg:"请输入正确的申请时长");
      return;
    }else if(StringsHelper.getIntValue(applyMonthsController.text)>12){
      CommonToast.show(type: ToastIconType.INFO,msg:"申请时间不能超过12个月");
      return;
    }else if(applyInfo.attList==null||applyInfo.attList.isEmpty){
      CommonToast.show(type: ToastIconType.INFO,msg:"请上传行驶证");
      return;
    }

    if(applyInfo.attList!=null) {
      for (int i = 0; i < applyInfo.attList.length; i++) {
        if (applyInfo.attList[i] == null) {
          CommonToast.show(type: ToastIconType.FAILED, msg: "尚有未上传完成的图片");
          return ;
        }
      }
    }
    //构建上传对象
//    applyInfo.carNo=carNoController.text;
    applyInfo.carBrand=carBrandController.text;
    applyInfo.carColor=carColorController.text;
    applyInfo.carOwnerName=carOwnerNameController.text;
    applyInfo.carOwnerPhone=carOwnerPhoneController.text;
    applyInfo.applyMonths=StringsHelper.getIntValue(applyMonthsController.text);
    _uploadApplyData();
  }

  //提交申请
  _uploadApplyData(){
    CommonToast.show();
    String url;
    if(applyInfo.parkingId!=null){//编辑
      url=HttpOptions.parkingEdit;
    }else{//新增
      applyInfo.projectId=stateModel.defaultProjectId;//项目id
//      applyInfo.buildId=1;//楼栋id
//      applyInfo.unitId=1;//单元id
//      applyInfo.roomNo="1";//房屋号
      applyInfo.houseId=stateModel.defaultHouseId;
      applyInfo.type="XK";//办理类型
      applyInfo.customerId=1;//申请人id
      url=HttpOptions.parkingCreate;
    };
    String data=json.encode(applyInfo);
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
//      LogUtils.printLog("月卡申请成功："+resultModel.message);
          CommonToast.show(type: ToastIconType.SUCCESS, msg: "申请成功");
          Navigate.closePage(true);
          parking_card_bus.emit(parking_refresh); //发送刷新事件
        } else {
          //请求成功
//      LogUtils.printLog("月卡申请失败："+resultModel.message);
          CommonToast.show(type: ToastIconType.FAILED,
              msg: "申请失败:" + resultModel.message ?? "");
        }
      } else {
        CommonToast.show(type: ToastIconType.FAILED, msg: "申请失败");
      }
    }catch(e){
      CommonToast.show(type: ToastIconType.FAILED, msg: "申请异常，请重试");
    }
  }

  //获取套餐列表
  getParkingPrices(){

    parkingCardPriceListState = ListState.HINT_LOADING;
    notifyListeners();
    Map<String, Object> params = new Map();
    params['community'] = stateModel.defaultProjectId;//项目编码id
    HttpUtil.post(HttpOptions.parkingPrices, _getParkingPricesCallBack,
        params: params,errorCallBack: __getParkingPricesErrorCallBack);
  }

  __getParkingPricesErrorCallBack(data){
    LogUtils.printLog('获取套餐异常');
    parkingCardPriceListState = ListState.HINT_LOADED_FAILED_CLICK;
    notifyListeners();
  }
  //获取套餐列表
  _getParkingPricesCallBack(data){
    try{
      ParkingCardPricesResponse response = ParkingCardPricesResponse.fromJson(data);
      if(response.success()&& response.parkingCardPackages!=null&&response.parkingCardPackages.isNotEmpty){
        parkingCardPrices.clear();
        response.parkingCardPackages.forEach((package){
          package.prices.forEach((price){
            parkingCardPrices.add(new ParkingCardPrices(parkId:package.parkId,parkName:package.parkName,priceId:price.priceId,priceName:price.priceName,price:price.price));
          });
        });
        initParkingPackageInfo();
//
        parkingCardPriceListState = ListState.HINT_DISMISS;
      }else if(response.parkingCardPackages!=null&&!response.parkingCardPackages.isNotEmpty){
        //请求成功
//        LogUtils.printLog("获取套餐失败：" + response.message);
        parkingCardPriceListState = ListState.HINT_NO_DATA_CLICK;

      }else{
        CommonToast.show(type: ToastIconType.FAILED, msg: "获取套餐失败:"+response.message??"");
        parkingCardPriceListState = ListState.HINT_LOADED_FAILED_CLICK;
      }
    }catch(e){
      parkingCardPriceListState = ListState.HINT_LOADED_FAILED_CLICK;
      CommonToast.show(type: ToastIconType.FAILED, msg: "获取套餐异常");
    }
    notifyListeners();
  }

  //拍照回调
  imagesCallback(List<String> images){
    applyInfo.attList=images;
    notifyListeners();
  }

  //同意点击
  onChangeAgree(){
//    agree=checked??false;
    agree=!agree;
    notifyListeners();
  }

  //设置详情信息
  setDetailsInfo(ParkingCardDetailsInfo info){
//    applyInfo = info;
    applyInfo.parkingId = info.parkingId;//修改
    applyInfo.type = info.type;//修改
    applyInfo.applyMonths = info.applyMonths;//申请时长（创建时必填）
    applyInfo.buildId = info.buildId; //楼栋id（创建时必填）
    applyInfo.carBrand = info.carBrand;//车辆品牌
    applyInfo.carColor = info.carColor;//车辆颜色
    applyInfo.carNo = info.carNo;//车牌号（创建时必填）
    applyInfo.carOwnerName = info.carOwnerName;//车主姓名（创建时必填）
    applyInfo.carOwnerPhone = info.carOwnerPhone;//车主电话（创建时必填）
    applyInfo.customerId = info.customerId;//申请人id（创建时必填）
    applyInfo.customerName = info.carOwnerName;//申请人姓名（创建时必填）
    applyInfo.customerPhone = info.carOwnerPhone;//申请人电话（创建时必填）
    applyInfo.attList = _getLastAttList(info.recordList);//行驶证图片UUID列表
    applyInfo.parkingPackageId = info.parkingPackageId;//停车办理业务id（编辑时必填）
    applyInfo.projectId = info.projectId;//项目id（创建时必填）
    applyInfo.remark = info.remark;//备注
    applyInfo.houseNo = info.houseNo;//房屋号（创建时必填）
    applyInfo.houseId= info.houseId;
    applyInfo.unitId = info.unitId;//单元id（创建时必填）
    applyInfo.carNo = info.carNo;
//    carNoController = new TextEditingController(text:info.carNo);//车牌号
    carBrandController = new TextEditingController(text:info.carBrand);//车牌品牌
    carColorController = new TextEditingController(text:info.carColor);//车辆颜色
    carOwnerNameController = new TextEditingController(text:info.carOwnerName);//车主姓名
    carOwnerPhoneController = new TextEditingController(text:info.carOwnerPhone);//车主电话
//    applyMonthsController = new TextEditingController(text:StringsHelper.getStringValue(info.applyMonths));//申请月份
    initParkingPackageInfo();
  }

  //获取行驶证照片（最后一次修改的列表）
  _getLastAttList(List<RecordList> list){
    List<String> photos = new List();
    if(list!=null){
      for(int i=list.length-1;i>=0;i--){
        if(list[i].operateStep==parking_step_edit||list[i].operateStep==parking_step_apply){
          list[i].attList.forEach((att){
            photos.add(att.attachmentUuid);
          });
          break;
        }
      }
    }
    return photos;
  }


  //选择套餐
  selectParkingPackage(int index){
    selectedPrices = index;
    applyInfo.parkingLotId = parkingCardPrices[selectedPrices].parkId;//停车场id（创建时必填）
    applyInfo.parkingLot = parkingCardPrices[selectedPrices].parkName;//停车场名称（创建时必填）
    applyInfo.parkingPackageId = parkingCardPrices[selectedPrices].priceId;//停车套餐id（创建时必填）
    applyInfo.parkingPackage = parkingCardPrices[selectedPrices].priceName;//停车场套餐（创建时必填）
    int month = StringsHelper.getIntValue(applyMonthsController.text);
    if(month>0){
      applyInfo.payFees = StringsHelper.getStringToDoubleValue(parkingCardPrices[selectedPrices].price) * month;//套餐费用
    }
    notifyListeners();
    Navigate.closePage();
  }

  //设置停车场和套餐信息
  initParkingPackageInfo(){
    if(parkingCardPrices.isNotEmpty&&applyInfo?.applyMonths!=null){
      int length=parkingCardPrices.length;
      for(int i=0;i<length;i++){
        if(parkingCardPrices[i].priceId==applyInfo.parkingPackageId){
          selectedPrices=i;
          applyInfo.parkingLot = parkingCardPrices[i].parkName;//停车场名称（创建时必填）
          applyInfo.parkingLotId = parkingCardPrices[i].parkId;//停车场id（创建时必填）
          applyInfo.parkingPackage = parkingCardPrices[i].priceName;//停车场套餐（创建时必填）
          applyInfo.parkingPackageId = parkingCardPrices[i].priceId;//停车套餐id（创建时必填）
          int month = applyInfo.applyMonths;
          if(month>0){
            applyMonthsController.text=StringsHelper.getStringValue(applyInfo.applyMonths);//申请月份
//            applyMonthsController = new TextEditingController(text:StringsHelper.getStringValue(applyInfo.applyMonths));
            applyInfo.payFees = StringsHelper.getStringToDoubleValue(parkingCardPrices[i].price) *  month;//套餐费用
          }

          notifyListeners();
          return;
        }
      }
    }
  }

  //设置月份监听
  setApplyMonthListener(){
    applyMonthsController.addListener((){
      int month=StringsHelper.getIntValue(applyMonthsController.text);
      if(month>=0&&selectedPrices>=0){
        applyInfo.payFees=month * StringsHelper.getStringToDoubleValue(parkingCardPrices[selectedPrices].price);
      }else{
        //输入错误
        applyInfo.payFees = null;
      }
      notifyListeners();
    });
  }

  //获取停车协议
  getAgreementInfo(){
    Map<String, Object> params = new Map();
    params['projectId'] = stateModel.defaultProjectId;//项目编码id
    params['agreementType'] = "ParkingAgreement";//项目编码id
    HttpUtil.post(HttpOptions.agreementUrl, _getAgreementInfoCallBack,
        jsonData: json.encode(params));
  }

  //查看停车协议
  toAgreementPage(){
    Navigate.toNewPage(ParkingCardAgreementPage(agreementInfo));
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



  //通用网络请求错误回调
  _errorCallBack(data) {
    CommonToast.show(type: ToastIconType.FAILED,msg: "提交异常："+data?.toString());
  }
}