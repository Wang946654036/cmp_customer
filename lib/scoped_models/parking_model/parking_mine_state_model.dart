
import 'dart:convert';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/request/parking_card_history_request.dart';
import 'package:cmp_customer/models/response/parking_card_details_response.dart';
import 'package:cmp_customer/models/response/parking_card_history_response.dart';
import 'package:cmp_customer/models/response/parking_card_mine_response.dart';
import 'package:cmp_customer/models/response/parking_card_monthly_fee_response.dart';
import 'package:cmp_customer/models/response/parking_card_price_response.dart';
import 'package:cmp_customer/models/response/parking_card_prices_response.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/parking/parking_card_apply.dart';
import 'package:cmp_customer/ui/parking/parking_card_bind.dart';
import 'package:cmp_customer/ui/parking/parking_card_history.dart';
import 'package:cmp_customer/ui/parking/parking_card_operation.dart';
import 'package:cmp_customer/ui/parking/parking_card_select.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/shared_preferences_key.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

//我的月卡业务层
class ParkingMineStateModel extends Model{
//  BuildContext mContext;
//  ParkingMineStateModel(this.context);
  ListState mineState=ListState.HINT_LOADING;
  List<ParkingCardDetailsInfo> detailsList = new List<ParkingCardDetailsInfo>();//月卡列表信息
  ParkingCardDetailsInfo lastParkingApplyInfo;
  int selectedIndex=-1;//显示选中的第几张月卡



  Future<void> getMyCardsRefresh() async {
    getMyCards();
  }
  //获取我的月卡列表
   getMyCards(){
    Map<String, String> params = new Map();
//    params['customerId'] = customerId;
    HttpUtil.post(HttpOptions.parkingMyList, _getMyCardsSuccess,
        params: params,errorCallBack: _getMyCardsError);
  }
  //点击了确认按钮
  confirmOnMineTap(){
//    this.mContext=context;
    if(canParkingOperation()){//允许续费
      if(detailsList[selectedIndex].parkingPackageId!=null){
        //获取费用套餐
        _getParkingPrice(detailsList[selectedIndex].projectId,detailsList[selectedIndex].parkingLotId,detailsList[selectedIndex].parkingPackageId);
      }else{
        _getPlateMonthlyFee(detailsList[selectedIndex].projectId,detailsList[selectedIndex].parkingLotId,detailsList[selectedIndex].carNo);
      }
//      Navigate.toNewPage(ParkingCardOperationPage(OperationType.operationXF,detailsList[selectedIndex]));
    }
  }
  //点击了取消按钮
  cancelOnMineTap(){
    if(canParkingOperation()){//允许退租
      //退租申请
      Navigate.toNewPage(ParkingCardOperationPage(OperationType.operationTZ,detailsList[selectedIndex]));
//      CommonToast.show();
//      Map<String, String> params = new Map();
//      params['parkingId'] = detailsList[selectedIndex].parkingId.toString();
//      params['operateStep '] = parking_step_cancel;//取消操作
//      HttpUtil.post(HttpOptions.changeParkingStatus, _uploadCallBack,
//        params: params,errorCallBack: _errorCallBack);
    }
  }

  //获取我的月卡列表
  _getMyCardsSuccess(data) async{
    try {
      ParkingCardMineResponse model = ParkingCardMineResponse.fromJson(data);
//    ParkingCardDetailsModel model = ParkingCardDetailsModel.fromJson(data);
      if (model != null) {
        if (model.success()) {
          if(model.parkingCardDetailsList == null||model.parkingCardDetailsList.isEmpty){
            _getLastParkingApplyInfo();
            return ;
          }else{
            detailsList = model.parkingCardDetailsList;
            SharedPreferences prefs = await SharedPreferencesKey.globalPrefs;
            int selectedParkingId=prefs.getInt(SharedPreferencesKey.KEY_DEFAULT_PARKING_CARD);
            if(selectedParkingId!=null){
              int length=detailsList.length;
              for(int i=0;i<length;i++){
                if(detailsList[i].parkingId==selectedParkingId){
                  selectedIndex=i;
                  break;
                }
              }
            }
            if(selectedIndex<0){//未选中时，默认选择第一个
              selectedIndex = 0;
              prefs.setInt(SharedPreferencesKey.KEY_DEFAULT_PARKING_CARD, detailsList[selectedIndex].parkingId);
            }
            mineState = ListState.HINT_DISMISS; //加载完成，隐藏加载页面
          }
        }
      }
    }catch(e){
      _getMyCardsError(null);
    }
    notifyListeners();
  }

  //获取我的月卡失败
  _getMyCardsError(errorMsg) {
//    LogUtils.printLog('接口返回失败');
    mineState = ListState.HINT_LOADED_FAILED_CLICK;
//    Fluttertoast.showToast(msg: errorMsg);
    notifyListeners();
  }

  //获取最近一次办理记录（当不存在已生效的月卡时调用）
  _getLastParkingApplyInfo() {
    ParkingCardHistoryRequest request = new ParkingCardHistoryRequest();
    request.pageSize=1;
    request.current=1;
    HttpUtil.post(HttpOptions.parkingCustList, _getLastParkingCallBack,
        jsonData: json.encode(request), errorCallBack: _getLastParkingError);
  }

  //获取最近一次办理记录回调
  _getLastParkingCallBack(data){
    try {
      ParkingCardHistoryResponse model = ParkingCardHistoryResponse.fromJson(data);
      if (model.success()&&model.parkingCardHistoryList != null && model.parkingCardHistoryList.isNotEmpty) {
        lastParkingApplyInfo=model.parkingCardHistoryList[0];
        mineState = ListState.HINT_DISMISS; //加载完成，隐藏加载页面
      }else{
        _getLastParkingError(model.message);
      }
    }catch(e){
      _getLastParkingError(null);
    }
    notifyListeners();
  }

  //获取最近一次办理记录失败
  _getLastParkingError(errorMsg) {
    mineState = ListState.HINT_NO_DATA_CLICK;
    notifyListeners();
  }

  //选择其他月卡
  selectOtherCard(){
    Navigate.toNewPage(ParkingCardSelectPage(this));
//    Navigate.toNewPage(context, ParkingCardSelectPage());
  }
  //申请月卡
  applyNewCard(){
    Navigate.toNewPage( ParkingCardApplyPage());
  }

  //绑定月卡
  bindOldCard(){
    Navigate.toNewPage( ParkingCardBindPage());
  }

  //跳转到办理记录历史
  toParkingHistory(){
    Navigate.toNewPage(ParkingCardHistoryPage());
  }


//  //通用提交回调
//  _uploadCallBack(data){
//    BaseResponse model = BaseResponse.fromJson(data);
////    ParkingCardDetailsModel model = ParkingCardDetailsModel.fromJson(data);
//    if(model!=null){
//      if(model.success()){
////        LogUtils.printLog("提交成功");
//        CommonToast.show(type: ToastIconType.FAIL,msg: "提交异常");
//        return ;
//      }else{
////        _failTip(model.message);
//        CommonToast.show(type: ToastIconType.FAIL,msg: "提交失败：" + model.message);
//      }
//    }else{
//      CommonToast.show(type: ToastIconType.FAIL,msg: "提交失败：" + model.message);
//    }
//  }

//  //失败提示
//  _failTip(String tips){
//    if(StringsHelper.isNotEmpty(tips)){
//      LogUtils.printLog(tips);
//    }
//  }

  //设置选中的月卡
  setSelectedIndex(int index) async{
    selectedIndex=index;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferencesKey.globalPrefs;
    prefs.setInt(SharedPreferencesKey.KEY_DEFAULT_PARKING_CARD, detailsList[selectedIndex].parkingId);
    Navigate.closePage();
  }

  //判断是否能做续费或者退卡操作(一直都要存在)
  canParkingOperation(){
//    if(selectedIndex>=0) {
//      return (detailsList[selectedIndex].type==operationXK||detailsList[selectedIndex].type==operationXF)&&detailsList[selectedIndex].status==completed;
//    }else{
//      return false;
//    }
    return selectedIndex>=0;
  }

//  //获取当前套餐的最新费用
//  _getParkingPrices(int priceId){
//    CommonToast.show(msg: "查询当前套餐");
//    Map<String, Object> params = new Map();
//    params['community'] = stateModel.defaultProjectId;//项目编码id
//    params['priceId'] = priceId;//套餐id
//    HttpUtil.post(HttpOptions.parkingPrices, _getParkingPricesCallBack,
//        params: params,errorCallBack: _getParkingPricesError);
//  }

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
    try{
      bool exist=false;//当前套餐不存在
      ParkingCardPriceResponse response = ParkingCardPriceResponse.fromJson(data);
      if(response.success()&& response.prices!=null&&response.prices.isNotEmpty){
        response.prices.forEach((priceInfo) {
          if(detailsList[selectedIndex].parkingPackageId==priceInfo.priceId){
            exist=true;
            Navigate.toNewPage(ParkingCardOperationPage(OperationType.operationXF,detailsList[selectedIndex],fee: StringsHelper.getStringToDoubleValue(priceInfo.price)));
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
    CommonToast.show(type: ToastIconType.INFO,msg: "获取当前套餐异常，请稍后重试");
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
          Navigate.toNewPage(ParkingCardOperationPage(OperationType.operationXF,detailsList[selectedIndex],fee: response.data.fee.toDouble()/100));
          return;
      }else{
        CommonToast.show(type: ToastIconType.INFO,msg: "查询月卡费用失败，无法进行续费");
      }
    }catch(e){
      _getParkingPricesError(null);
    }
  }

//  //通用网络请求错误回调
//  _errorCallBack(data) {
//    CommonToast.show(type: ToastIconType.FAIL,msg: "提交异常");
//  }
//  //判断是否能做退租操作
//  _canParkingTZ(){
//    return (detailsList[selectedIndex].type==operationXK||detailsList[selectedIndex].type==operationXF)&&detailsList[selectedIndex].status==completed;
//  }



//重写of方法
  static ParkingMineStateModel of(context) =>
      ScopedModel.of<ParkingMineStateModel>(context);
}