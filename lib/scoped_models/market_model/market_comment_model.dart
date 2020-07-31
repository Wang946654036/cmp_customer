import 'dart:convert';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/models/market/ware_comment_response.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/failed_code_trans.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:scoped_model/scoped_model.dart';

mixin MarketCommentModel on Model{

  ListState commentListState = ListState.HINT_LOADING;
  List<Record> records = List<Record>();

  int _historyCurrentPage = 1;
  bool historyMaxCount = false;

  loadCommentInfoHistoryList(
      Map<String, dynamic> map,
      {bool preRefresh = false,Function callback}) {

    if (commentListState == ListState.HINT_LOADED_FAILED_CLICK ||
        commentListState == ListState.HINT_NO_DATA_CLICK) {
      preRefresh = true;
    }
    commentListState = ListState.HINT_LOADING;
    if (preRefresh) notifyListeners();
    _historyCurrentPage = 1;
    historyMaxCount = false;
    if (records != null) records.clear();
    _getCommentInfoList( map,callback: callback);
  }

  Future<void> commentInfoListHistoryHandleRefresh(
      {bool preRefresh = true,
        String state,
        Map<String, dynamic> map,Function callback}) async {
    return loadCommentInfoHistoryList(map,
        preRefresh: preRefresh,callback: callback);
  }

  Future<void> commentInfoListHandleLoadMore(
      {Map<String, dynamic> map,Function callback}) async {
    if (!historyMaxCount) {
      _getCommentInfoList(map,callback: callback);
    }
  }

  _getCommentInfoList( Map<String, dynamic> map,{Function callback}) async {

    Map<String, dynamic> params = {
      "pageSize": HttpOptions.pageSize,
      "current": _historyCurrentPage,
    };
    if (map != null) {
      params.addAll(map);
    }
    LogUtils.printLog(json.encode(params));
    HttpUtil.post(HttpOptions.queryCustomerWareComment, (data){_getListCallBack(data,callback:callback);},
        jsonData: json.encode(params), errorCallBack: _getListErrorCallBack);
  }

  _getListCallBack(data,{Function callback}) {
    try {
      WareCommentResponse response = WareCommentResponse.fromJson(data);
      if (response.success()) {
        if (response.data?.page?.records?.isNotEmpty ?? false) {
          commentListState = ListState.HINT_DISMISS;
          if (_historyCurrentPage == 1) { //刷新操作，清空数据再添加（防止多次刷新请求导致数据重复添加）
            records.clear();
          }
          records.addAll(response.data?.page?.records);
          _historyCurrentPage++;
          if (callback != null) {
            callback();
          }
          if (response.data.page.records.length < HttpOptions.pageSize)
            historyMaxCount = true;
        } else {
          if (records == null || records.isEmpty) {
            //nodata
            commentListState = ListState.HINT_NO_DATA_CLICK;
//            records.clear();
          } else {
            //已到列表最底
            historyMaxCount = true;
          }
        }
      }else {
        String failedDescri = FailedCodeTrans.enTochsTrans(
            failCode: response.code.toString(), failMsg: response.message);
        commentListState = ListState.HINT_LOADED_FAILED_CLICK;
        _getListErrorCallBack(failedDescri);
      }
    } catch (e) {
      commentListState = ListState.HINT_LOADED_FAILED_CLICK;
    }
    notifyListeners();
  }

  void _getListErrorCallBack(errorMsg) {
    LogUtils.printLog('接口返回失败');
    commentListState = ListState.HINT_LOADED_FAILED_CLICK;
    notifyListeners();
  }
}