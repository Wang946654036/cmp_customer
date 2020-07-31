import 'dart:convert';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/pgc/pgc_comment_obj.dart';
import 'package:cmp_customer/models/response/base_response.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/failed_code_trans.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:scoped_model/scoped_model.dart';

mixin PgcCommentModel on Model{

  ListState pgcCommentInfoListState = ListState.HINT_LOADING;
  List<PgcCommentInfo> pgcCommentInfos = List<PgcCommentInfo>();

  int _historyCurrentPage = 1;
  bool historyMaxCount = false;

  loadPgcCommentInfoHistoryList(
      Map<String, dynamic> map,
      {bool preRefresh = false,Function callback}) {

    if (pgcCommentInfoListState == ListState.HINT_LOADED_FAILED_CLICK ||
        pgcCommentInfoListState == ListState.HINT_NO_DATA_CLICK) {
      preRefresh = true;
    }
    pgcCommentInfoListState = ListState.HINT_LOADING;
    if (preRefresh) notifyListeners();
    _historyCurrentPage = 1;
    historyMaxCount = false;
    if (pgcCommentInfos != null) pgcCommentInfos.clear();
    _getPgcCommentInfoList( map,callback: callback);
  }

  Future<void> pgcCommentInfoListHistoryHandleRefresh(
      {bool preRefresh = true,
        String state,
        Map<String, dynamic> map,Function callback}) async {
    return loadPgcCommentInfoHistoryList(map,
        preRefresh: preRefresh,callback: callback);
  }

  Future<void> pgcCommentInfoListHandleLoadMore(
      {Map<String, dynamic> map,Function callback}) async {
    _historyCurrentPage++;
    if (!historyMaxCount) {
      _getPgcCommentInfoList(map,callback: callback);
    }
  }

  _getPgcCommentInfoList( Map<String, dynamic> map,{Function callback}) async {

    Map<String, dynamic> params = {
      "pageSize": HttpOptions.pageSize,
      "current": _historyCurrentPage,
    };
    if (map != null) {
      params.addAll(map);
    }
    LogUtils.printLog(json.encode(params));
    HttpUtil.post(HttpOptions.findCustomerPgcCommentPage, (data){_getListCallBack(data,callback:callback);},
        jsonData: json.encode(params), errorCallBack: _getListErrorCallBack);
  }

  _getListCallBack(data,{Function callback}) {
    PgcCommentObj commentObj;
    try {
      commentObj = PgcCommentObj.fromJson(data);
    } catch (e) {
      LogUtils.printLog('评论列表:$data');
      commentObj = new PgcCommentObj(code: '0');
    }

    if (commentObj.code == '0') {
      if (commentObj.pgcCommentInfoList != null &&commentObj.pgcCommentInfoList.length!=0 ) {
        pgcCommentInfoListState = ListState.HINT_DISMISS;
        if(_historyCurrentPage==1){//刷新操作，清空数据再添加（防止多次刷新请求导致数据重复添加）
          pgcCommentInfos.clear();
        }
        pgcCommentInfos.addAll(commentObj.pgcCommentInfoList);
        if(callback!=null){
          callback();
        }
        if (commentObj.pgcCommentInfoList.length < HttpOptions.pageSize) historyMaxCount = true;
//        }
      } else {
        if (pgcCommentInfos == null || pgcCommentInfos.isEmpty) {
          //nodata
          pgcCommentInfoListState = ListState.HINT_NO_DATA_CLICK;
          pgcCommentInfos.clear();
        } else {
          //已到列表最底
          historyMaxCount = true;
        }
      }
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(
          failCode: commentObj.code.toString(), failMsg: commentObj.message);
      pgcCommentInfoListState = ListState.HINT_LOADED_FAILED_CLICK;
      LogUtils.printLog('评论列表失败:' + failedDescri);
    }

    notifyListeners();
  }

  cleanPgcCommentInfoListModel() {
    pgcCommentInfoListState = ListState.HINT_LOADING;
    pgcCommentInfos = List<PgcCommentInfo>();
    _historyCurrentPage = 1;
    historyMaxCount = false;
  }

  void _getListErrorCallBack(errorMsg) {
    LogUtils.printLog('接口返回失败');
    pgcCommentInfoListState = ListState.HINT_LOADED_FAILED_CLICK;
    notifyListeners();
  }

//操作
  Future<void> changePgcComment(Map<String ,dynamic> params , {Function callback})async{

    HttpUtil.post(HttpOptions.changePgcComment, (data){_uploadApplyDataCallBack(data,callback: callback);},
        jsonData: jsonEncode(params),errorCallBack: _errorCallBack);
  }
  //通用网络请求错误回调
  _errorCallBack(data) {
    CommonToast.show(type: ToastIconType.FAILED,msg: "提交失败："+data?.toString());
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



  static PgcCommentModel of(context) =>
      ScopedModel.of<PgcCommentModel>(context);
}