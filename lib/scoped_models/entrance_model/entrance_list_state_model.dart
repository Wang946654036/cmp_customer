import 'dart:convert';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/request/entrance_card_list_request.dart';
import 'package:cmp_customer/models/response/base_response.dart';
import 'package:cmp_customer/models/response/entrance_card_details_response.dart';
import 'package:cmp_customer/models/response/entrance_card_list_response.dart';
import 'package:cmp_customer/models/transport_driver_model.dart';
import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/ui/common/common_dialog.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_apply.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_operation_step.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_state.dart';
import 'package:cmp_customer/ui/parking/parking_card_apply.dart';
import 'package:cmp_customer/utils/common_event_bus.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/failed_code_trans.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/shared_preferences_key.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class EntranceListStateModel extends Model {
//  BuildContext mContext;
//  EntranceListStateModel(this.mContext);
  ListState listState = ListState.HINT_LOADING;
  int _listCurrentPage = 1;
//  int historyTotalCount = 0;
  bool maxCount = false;
//  EntranceCardListRequest listRequest = new EntranceCardListRequest();
  List<EntranceCardDetailsInfo> entranceList = new List<EntranceCardDetailsInfo>();
  String queryType;

  //设置查询类型
  initData(String type){
    queryType=type;
  }

  //门禁卡申请记录列表
  loadList({bool preRefresh = false}) {
    if (listState == ListState.HINT_LOADED_FAILED_CLICK ||
        listState == ListState.HINT_NO_DATA_CLICK) {
      preRefresh = true;
    }
    listState = ListState.HINT_LOADING;
    if (preRefresh) notifyListeners();
    _listCurrentPage = 1;
    maxCount = false;
//    print('_orderAllMap[page.tag]:${_orderAllMap[page]}');
    if (entranceList != null) entranceList.clear();
    _getList();
  }

  Future<void> historyHandleRefresh({bool preRefresh = false}) async {
    loadList(preRefresh: preRefresh);
  }

  quoteRecordHandleLoadMore() {
//    _listCurrentPage += HttpOptions.pageSize;
    if (!maxCount) {
      _getList();
    }
  }

  _getList()  async{
//    listRequest.current=_listCurrentPage;
//    listRequest.projectId=MainStateModel.of(mContext).projectId;
//
//    HttpUtil.post(HttpOptions.entranceList, _historyCallBack,
//        jsonData: json.encode(listRequest), errorCallBack: _historyErrorCallBack);
//    listRequest.current=_listCurrentPage;
//    listRequest.projectId=MainStateModel.of(mContext).projectId;

    Map<String, Object> params = new Map();
    params['current'] = _listCurrentPage;
    params['projectId'] = stateModel.defaultProjectId;
    params['queryType'] = queryType;
    HttpUtil.post(HttpOptions.entranceList, _historyCallBack,
        params: params, errorCallBack: _historyErrorCallBack);
  }

  void _historyCallBack(data) {
    try{
      EntranceCardListResponse model = EntranceCardListResponse.fromJson(data);
//    LogUtils.printLog('门禁卡记录列表:$data');
      if (model.success()) {
        if (model.entranceCardDetailsList != null && model.entranceCardDetailsList.length > 0) {
          listState = ListState.HINT_DISMISS;
          if(_listCurrentPage==1){//刷新操作，清空数据再添加（防止多次刷新请求导致数据重复添加）
            entranceList.clear();
          }
          entranceList.addAll(model.entranceCardDetailsList);
          if (model.entranceCardDetailsList.length < HttpOptions.pageSize) maxCount = true;
          else _listCurrentPage++;
//        }
        } else {
          if (entranceList == null || entranceList.isEmpty) {
            //nodata
            listState = ListState.HINT_NO_DATA_CLICK;
            entranceList.clear();
          } else {
            //已到列表最底
            maxCount = true;
          }
        }
      } else {
//      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
        listState = ListState.HINT_LOADED_FAILED_CLICK;
//      Fluttertoast.showToast(msg: failedDescri);
      }
    }catch(e){
      listState = ListState.HINT_LOADED_FAILED_CLICK;
    }
    notifyListeners();
  }

  void _historyErrorCallBack(errorMsg) {
    LogUtils.printLog('接口返回失败');
    listState = ListState.HINT_LOADED_FAILED_CLICK;
//    Fluttertoast.showToast(msg: errorMsg);
    notifyListeners();
  }


//  //申请门禁卡
//  applyNewCard(EntranceApplyType type){
//    Navigate.toNewPage( EntranceCardApplyPage(type));
//  }

//  //列表点击(accessCardId：门禁卡办理id)
//  onItemTap(){
//
//  }

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

//  //申请门禁卡
//  toEdit(EntranceApplyType type){
//    Navigate.toNewPage(mContext, EntranceCardApplyPage(applyType:type));
//  }

  static EntranceListStateModel of(context) => ScopedModel.of<EntranceListStateModel>(context);
}