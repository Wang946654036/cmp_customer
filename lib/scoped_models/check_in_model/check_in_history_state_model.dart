import 'dart:convert';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/models/request/check_in_history_request.dart';
import 'package:cmp_customer/models/response/base_response.dart';
import 'package:cmp_customer/models/response/check_in_history_response.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_operation_step.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_state.dart';
import 'package:cmp_customer/utils/common_event_bus.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../main.dart';
import 'check_in_screen_state_model.dart';


class CheckInHistoryStateModel extends Model with CheckInScreenStateModel{
  ListState listState = ListState.HINT_LOADING;
  int _listCurrentPage = 1;
  bool maxCount = false;
  List historyList =  new List();
  CheckInHistoryRequest request = new CheckInHistoryRequest();

  //申请记录列表
  loadHistoryList({bool preRefresh = false}) {
    if (listState == ListState.HINT_LOADED_FAILED_CLICK ||
        listState == ListState.HINT_NO_DATA_CLICK) {
      preRefresh = true;
    }
    listState = ListState.HINT_LOADING;
    if (preRefresh) notifyListeners();
    _listCurrentPage = 1;
    maxCount = false;
    if (historyList != null) historyList.clear();
    _getList();
  }

  Future<void> historyHandleRefresh({bool preRefresh = false}) async {
    loadHistoryList(preRefresh: preRefresh);
  }

  quoteRecordHandleLoadMore() {
    if (!maxCount) {
      _getList();
    }
  }

  _getList()  async{
    request.current = _listCurrentPage;
//    request.projectId = stateModel.defaultProjectId;
    HttpUtil.post(HttpOptions.checkInList, _historyCallBack,
        jsonData: json.encode(request), errorCallBack: _historyErrorCallBack);
  }

  void _historyCallBack(data) {
    try{

      CheckInHistoryResponse  model = CheckInHistoryResponse.fromJson(data);
//    LogUtils.printLog('门禁卡记录列表:$data');
      if (model.success()) {
        if (model.historyList != null && model.historyList.length > 0) {
          listState = ListState.HINT_DISMISS;
          if(_listCurrentPage==1){//刷新操作，清空数据再添加（防止多次刷新请求导致数据重复添加）
            historyList.clear();
          }
          historyList.addAll(model.historyList);
          if (model.historyList.length < HttpOptions.pageSize) maxCount = true;
          else _listCurrentPage++;
        } else {
          if (historyList == null || historyList.isEmpty) {
            //nodata
            listState = ListState.HINT_NO_DATA_CLICK;
            historyList.clear();
          } else {
            //已到列表最底
            maxCount = true;
          }
        }
      } else {
        listState = ListState.HINT_LOADED_FAILED_CLICK;
      }
    }catch(e){
      listState = ListState.HINT_LOADED_FAILED_CLICK;
    }
    notifyListeners();
  }

  void _historyErrorCallBack(errorMsg) {
    LogUtils.printLog('接口返回失败');
    listState = ListState.HINT_LOADED_FAILED_CLICK;
    notifyListeners();
  }

  //审核点击(accessCardId：门禁卡办理id;  status：0、不通过；1、通过)
  //注意此处的status并不是状态，而是审核的参数
  onAuditTap(int accessCardId,int status){
    CommonToast.show();
    Map<String, Object> params = new Map();
    params['accessCardId'] = accessCardId;
    params['operateStep'] = entrance_step_audit_yz;//业主审核
    params['status'] = status;
    HttpUtil.post(HttpOptions.changeEntranceStatus, _auditCallBack,
        params: params,errorCallBack: _errorCallBack);

  }
  //列表审核提交回调
  _auditCallBack(data){
    CommonToast.dismiss();
    try{
      BaseResponse model = BaseResponse.fromJson(data);
      if(model.success()){
        LogUtils.printLog("提交成功");
        entrance_card_bus.emit(entrance_audit_refresh);//发送列表审核刷新事件
//        Navigate.closePage();
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

  //停车卡客户所有车辆
  getScreenList() {
    //添加申请类型参数
    if(selectedStateIndex>=0){
      request.status = new List();
      request.status.add(applyStatusList[selectedStateIndex].code);
    }else{
      request.status=null;
    }
//    request.status = new List<String>();
//    applyStateList.forEach((info){
//      if(info.selected){
//        request.status.add(info.stateCode);
//      }
//    });
//    //添加申请类型参数
//    request.customerTypes = new List<String>();
//    applyTypeList.forEach((info){
//      if(info.selected){
//        request.customerTypes.add(info.typeCode);
//      }
//    });
    //添加开始时间参数
    if(selectedTimeIndex>=0){
      request.startTime=applyTimeList[selectedTimeIndex].code;
      request.endTime=null;
    }else {
      request.startTime = selectedStartDate;
      request.endTime = selectedEndDate;
    }
    loadHistoryList(preRefresh:true);
  }
}