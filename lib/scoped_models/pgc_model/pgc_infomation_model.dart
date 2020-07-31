import 'dart:convert';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/models/pgc/pgc_infomation_list.dart';
import 'package:cmp_customer/models/pgc/pgc_infomation_obj.dart';
import 'package:cmp_customer/models/response/base_response.dart';
import 'package:cmp_customer/scoped_models/pgc_model/pgc_collect_state_model.dart';
import 'package:cmp_customer/scoped_models/pgc_model/pgc_comment_model.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/failed_code_trans.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../main.dart';

class PgcInfomationListModel extends PgcCollectStateModel{
  ListState pgcInfomationListState = ListState.HINT_LOADING;
  List<PgcInfomationInfo> pgcInfomations = List<PgcInfomationInfo>();
  int _historyCurrentPage = 1;
  bool historyMaxCount = false;
  List<int> collectCheckedList = List<int>();//收藏的id列表
  bool isBulkCollectOperation = false;//是否批量收藏操作
  bool isBulkCollectPage = false;//是否批量收藏页面

  Future<void> pgcInfomationListHistoryHandleRefresh(
      {bool preRefresh = false,
        String state,
        Map<String, dynamic> map}) async {
    return loadPgcInfomationInfoHistoryList(map,
        preRefresh: preRefresh);
  }

  loadPgcInfomationInfoHistoryList(
      Map<String, dynamic> map,
      {bool preRefresh = false}) {

    if (pgcInfomationListState == ListState.HINT_LOADED_FAILED_CLICK ||
        pgcInfomationListState == ListState.HINT_NO_DATA_CLICK) {
      preRefresh = true;
    }
    pgcInfomationListState = ListState.HINT_LOADING;
    if (preRefresh) notifyListeners();
    _historyCurrentPage = 1;
    historyMaxCount = false;
    if (pgcInfomations != null) pgcInfomations.clear();
    _getPgcInfomationList( map);
  }


  Future<void> pgcInfomationListHandleLoadMore(
      {Map<String, dynamic> map}) async {
//    _historyCurrentPage++;
    if (!historyMaxCount) {
      _getPgcInfomationList(map);
    }
  }
  _getPgcInfomationList( Map<String, dynamic> map) async {

    Map<String, dynamic> params = {
      "pageSize": HttpOptions.pageSize,
      "current": _historyCurrentPage,
      "custProjectId":stateModel.defaultProjectId,
    };
    if (map != null) {
      params.addAll(map);
    }
    LogUtils.printLog(json.encode(params));
    HttpUtil.post(isBulkCollectPage?HttpOptions.findCustomerCollectList:HttpOptions.findCustomerPgcPage, _getListCallBack,
        jsonData: json.encode(params), errorCallBack: _getListErrorCallBack);
  }
  _getListCallBack(data) {
    PgcInfomationList infos;
    try {
      infos = PgcInfomationList.fromJson(data);
    } catch (e) {
      LogUtils.printLog('pgc列表:$data');
      infos = new PgcInfomationList(code: '0');
    }

    if (infos.code == '0') {
      if (infos.pgcInfomationInfoList != null && infos.pgcInfomationInfoList.length > 0) {
        pgcInfomationListState = ListState.HINT_DISMISS;
        if(_historyCurrentPage==1){//刷新操作，清空数据再添加（防止多次刷新请求导致数据重复添加）
          pgcInfomations.clear();
        }
        pgcInfomations.addAll(infos.pgcInfomationInfoList);
        if (infos.pgcInfomationInfoList.length < HttpOptions.pageSize) historyMaxCount = true;
        else  _historyCurrentPage++;
//        }
      } else {
        if (pgcInfomations == null || pgcInfomations.isEmpty) {
          //nodata
          pgcInfomationListState = ListState.HINT_NO_DATA_CLICK;
          pgcInfomations.clear();
        } else {
          //已到列表最底
          historyMaxCount = true;
        }
      }
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(
          failCode: infos.code.toString(), failMsg: infos.message);
      pgcInfomationListState = ListState.HINT_LOADED_FAILED_CLICK;
      LogUtils.printLog('pgc列表失败:' + failedDescri);
    }
    notifyListeners();
  }

  void _getListErrorCallBack(errorMsg) {
    LogUtils.printLog('接口返回失败');
    pgcInfomationListState = ListState.HINT_LOADED_FAILED_CLICK;
    notifyListeners();
  }


  //设置多选操作
  changedBulkCollectOperation(){
    isBulkCollectOperation = !isBulkCollectOperation;
    notifyListeners();
  }

  //多选框操作
  changedCollectCheckbox(bool checked,int id){
    if(checked){
      collectCheckedList?.add(id);
    }else{
      collectCheckedList?.remove(id);
    }
    notifyListeners();
  }

  //多选框操作
  setAllCollected(bool checked){
    collectCheckedList.clear();
    if(checked){
      if(pgcInfomations!=null){
        collectCheckedList.addAll(pgcInfomations.map((info)=>info.pgcId).toList());
      }
    }
    notifyListeners();
  }

  static PgcInfomationListModel of(context) =>
      ScopedModel.of<PgcInfomationListModel>(context);
}


class PgcInfomationDetailModel extends Model with PgcCommentModel {
  ListState pgcInfomationDetailState = ListState.HINT_LOADING;
  PgcInfomationInfo pgcInfomation = PgcInfomationInfo();
  bool hasSelected = false;
  bool hasDianzan = false;

  Future<void> pgcInfomationDetailHandleRefresh(
      {bool preRefresh = false,
        String state,
        Map<String, dynamic> map,Function callBack}) async {
    return loadPgcInfomationInfo(map,callBack,
        preRefresh: preRefresh);
  }
  loadPgcInfomationInfo(
      Map<String, dynamic> map,Function callBack,
      {bool preRefresh = false}) {

    if (pgcInfomationDetailState == ListState.HINT_LOADED_FAILED_CLICK ||
        pgcInfomationDetailState == ListState.HINT_NO_DATA_CLICK) {
      preRefresh = true;
    }
    pgcInfomationDetailState = ListState.HINT_LOADING;
    if (preRefresh) notifyListeners();

    if (pgcInfomation != null) pgcInfomation= PgcInfomationInfo();
    _getPgcInfomationDetail( map,callBack);
  }

  _getPgcInfomationDetail( Map<String, dynamic> map,Function callBack) async {

    Map<String, dynamic> params = {
    };
    if (map != null) {
      params.addAll(map);
    }
    LogUtils.printLog(json.encode(params));
    HttpUtil.post(HttpOptions.pgcGet, (data){
      _getListCallBack(data,callBack);
    },
        jsonData: json.encode(params), errorCallBack: _getListErrorCallBack);
  }
  _getListCallBack(data,Function callBack) {
    PgcInfomationObj infomationObj;
    try {
      infomationObj = PgcInfomationObj.fromJson(data);
    } catch (e) {

      infomationObj = new PgcInfomationObj(code: '0');
    }

    if (infomationObj.code == '0') {
      if (infomationObj.pgcInfomationInfo != null ) {
        pgcInfomationDetailState = ListState.HINT_DISMISS;
        pgcInfomation = infomationObj.pgcInfomationInfo;
        pgcInfomation.content =  pgcInfomation.content.replaceAll('\"', '"');
        LogUtils.printLog('pgc详情:${pgcInfomation.content}');
        //点赞和分享状态
        hasDianzan = (pgcInfomation?.custLike??'0')=='0'?false:true;
        hasSelected = (pgcInfomation?.custCollect??'0')=='0'?false:true;

        if(callBack!=null){
          callBack();
        }
      } else {
          //nodata
          pgcInfomationDetailState = ListState.HINT_NO_DATA_CLICK;
          pgcInfomation = PgcInfomationInfo();
      }
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(
          failCode: infomationObj.code.toString(), failMsg: infomationObj.message);
      pgcInfomationDetailState = ListState.HINT_LOADED_FAILED_CLICK;
      LogUtils.printLog('pgc详情失败:' + failedDescri);
    }
    notifyListeners();
  }

  void _getListErrorCallBack(errorMsg) {
    LogUtils.printLog('接口返回失败');
    pgcInfomationDetailState = ListState.HINT_LOADED_FAILED_CLICK;
    notifyListeners();
  }
//操作
  Future<void> createCustomerOperation(Map<String ,dynamic> map , {Function callback})async{
    Map<String, dynamic> params = {
      'projectId':stateModel.defaultProjectId
    };
    if (map != null) {
      params.addAll(map);
    }

    HttpUtil.post(HttpOptions.createCustomerOperation, (data){_uploadApplyDataCallBack(data,callback: callback);},
        jsonData: jsonEncode(params),errorCallBack: _errorCallBack);
  }
  //通用网络请求错误回调
  _errorCallBack(data) {
    CommonToast.show(type: ToastIconType.FAILED,msg: "提交失败");
  LogUtils.printLog("提交失败："+data?.toString());
  }
  //操作成功
  _uploadApplyDataCallBack(data,{Function callback}){
    try {
      BaseResponse resultModel = BaseResponse.fromJson(data);
      if (resultModel != null) {
        if (resultModel.success()) {
          //请求成功
          if(callback!=null){
            callback();
          }
        } else {
          //请求成功
//      LogUtils.printLog("月卡申请失败："+resultModel.message);
          CommonToast.show(type: ToastIconType.FAILED,
              msg: "提交失败:" + resultModel.message ?? "");
        }
      } else {
        CommonToast.show(type: ToastIconType.FAILED, msg: "提交失败");
      }
    }catch(e){
      CommonToast.show(type: ToastIconType.FAILED, msg: "提交异常，请重试");
    }finally{
      notifyListeners();
    }
  }



  static PgcInfomationDetailModel of(context) =>
      ScopedModel.of<PgcInfomationDetailModel>(context);
}
