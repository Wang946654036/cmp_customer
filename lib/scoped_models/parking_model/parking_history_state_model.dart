import 'dart:convert';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/request/parking_card_history_request.dart';
import 'package:cmp_customer/models/response/parking_card_cars_response.dart';
import 'package:cmp_customer/models/response/parking_card_details_response.dart';
import 'package:cmp_customer/models/response/parking_card_history_response.dart';
import 'package:cmp_customer/models/response/parking_card_pay_info_response.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/html/html_page.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/failed_code_trans.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:cmp_customer/scoped_models/parking_model/parking_screen_state_model.dart';
import 'package:tip_dialog/tip_dialog.dart';


class ParkingHistoryStateModel extends Model with ParkingScreenStateModel{

  ListState historyListState = ListState.HINT_LOADING;
  int _historyCurrentPage = 1;//从第一页开始
//  int historyTotalCount = 0;
  bool maxCount = false;
  List<ParkingCardDetailsInfo> parkingCardHistoryList = new List<ParkingCardDetailsInfo> ();

  ParkingCardHistoryRequest request = new ParkingCardHistoryRequest();


  //停车卡申请记录列表
  loadHistoryList({bool preRefresh = false}) async{
    if (historyListState == ListState.HINT_LOADED_FAILED_CLICK ||
        historyListState == ListState.HINT_NO_DATA_CLICK) {
      preRefresh = true;
    }
    historyListState = ListState.HINT_LOADING;
    if (preRefresh) notifyListeners();
    _historyCurrentPage = 1;
    maxCount = false;
//    print('_orderAllMap[page.tag]:${_orderAllMap[page]}');
    if (parkingCardHistoryList != null) parkingCardHistoryList.clear();
    _getHistoryList();
  }

  Future<void> historyHandleRefresh({bool preRefresh = false}) async {
    loadHistoryList(preRefresh: preRefresh);
  }

  quoteRecordHandleLoadMore() {
//    _historyCurrentPage += HttpOptions.pageSize;
    if (!maxCount) {
      _getHistoryList();
    }
  }

  _getHistoryList() {
    request.projectId=stateModel.defaultProjectId;//项目id
    request.customerId=1;//客户id
    request.current=_historyCurrentPage;//当前页
    HttpUtil.post(HttpOptions.parkingCustList, _historyCallBack,
        jsonData: json.encode(request), errorCallBack: _historyErrorCallBack);
  }

  void _historyCallBack(data) {
    try{
      ParkingCardHistoryResponse model = ParkingCardHistoryResponse.fromJson(data);
      LogUtils.printLog('停车办理记录列表:$data');
      if (model.success()) {
        if (model.parkingCardHistoryList != null && model.parkingCardHistoryList.length > 0) {
          historyListState = ListState.HINT_DISMISS;
          if(_historyCurrentPage==1){//刷新操作，清空数据再添加（防止多次刷新请求导致数据重复添加）
            parkingCardHistoryList.clear();
          }
          parkingCardHistoryList.addAll(model.parkingCardHistoryList);
          if (model.parkingCardHistoryList.length < HttpOptions.pageSize) maxCount = true;
          else _historyCurrentPage++;//页面加1，用于加载下一页
//        }
        } else {
          if (parkingCardHistoryList == null || parkingCardHistoryList.isEmpty) {
            //nodata
            historyListState = ListState.HINT_NO_DATA_CLICK;
            parkingCardHistoryList.clear();
          } else {
            //已到列表最底
            maxCount = true;
          }
        }
      } else {
        String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
        historyListState = ListState.HINT_LOADED_FAILED_CLICK;
//      Fluttertoast.showToast(msg: failedDescri);
      }
    }catch(e){
      historyListState = ListState.HINT_LOADED_FAILED_CLICK;
    }
    notifyListeners();
  }

  void _historyErrorCallBack(errorMsg) {
    LogUtils.printLog('接口返回失败');
    historyListState = ListState.HINT_LOADED_FAILED_CLICK;
//    Fluttertoast.showToast(msg: errorMsg);
    notifyListeners();
  }


  //停车卡客户所有车辆
  loadCustCars() async{
    Map<String, String> params = new Map();
    params['customerId'] = "1";
    HttpUtil.post(HttpOptions.parkingCustCars, _loadCustCarsCallBack,
        params:params,);
  }

  void _loadCustCarsCallBack(data){
    ParkingCardCarsResponse model = ParkingCardCarsResponse.fromJson(data);
    if(model!=null){
      if(model.success() && model.custCars!=null){
        initCars(model.custCars);
      }else{
        _failTip(model.message);
      }
    }else{
      _failTip("获取详情失败");
    }
  }


  //失败提示
  _failTip(String tips){
    if(StringsHelper.isNotEmpty(tips)){
      LogUtils.printLog(tips);
    }
  }

  //停车卡客户所有车辆
  getScreenHistoryList() {
    //添加申请类型参数
    request.types = new List<String>();
    dealTypeList.forEach((info){
      if(info.selected){
        request.types.add(info.code);
      }
    });
    //添加车牌号参数
    request.carNos = new List<String>();
    carNoList.forEach((info){
      if(info.selected){
        request.carNos.add(info.code);
      }
    });
    //添加开始时间参数
    if(selectedTimeIndex>=0){
      request.startTime=applyTimeList[selectedTimeIndex].code;
      request.endTime = null;
    }else{
      request.startTime = selectedStartDate;
      request.endTime = selectedEndDate;
    }
    loadHistoryList(preRefresh:true);
  }

  //获取支付信息
  getPayInfo(int parkingId){
    CommonToast.show();
    Map<String, Object> params = new Map();
    params['parkingId'] = parkingId;//
    HttpUtil.post(HttpOptions.parkingPay, _getPayInfoCallBack,
        params: params,errorCallBack: _errorCallBack);
  }

  //获取支付信息回调
  _getPayInfoCallBack(data){
    CommonToast.dismiss();
    try{
      ParkingCardPayInfoResponse model = ParkingCardPayInfoResponse.fromJson(data);
      if(model!=null){
        if(model.success() && model.url!=null){
          //跳转到支付页面
          Navigate.toNewPage(HtmlPage(model.url,"支付"),callBack: (data){
            loadHistoryList(preRefresh:true);
          });
        }else{
          CommonToast.show(type: ToastIconType.FAILED,msg: model.message??"");
        }
        return ;
      }
    }catch(e){
    }
    CommonToast.show(type: ToastIconType.FAILED,msg: "获取支付信息失败");
  }

  //通用网络请求错误回调
  _errorCallBack(data) {
    CommonToast.show(type: ToastIconType.FAILED,msg: data?.toString());
  }


  static ParkingHistoryStateModel of(context) => ScopedModel.of<ParkingHistoryStateModel>(context);
}
