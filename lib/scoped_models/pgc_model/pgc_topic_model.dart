import 'dart:convert';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/models/pgc/pgc_topic_list.dart';
import 'package:cmp_customer/models/pgc/pgc_topic_obj.dart';
import 'package:cmp_customer/scoped_models/pgc_model/pgc_comment_model.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/failed_code_trans.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:scoped_model/scoped_model.dart';

class PgcTopicListModel extends Model with PgcCommentModel  {
  ListState pgcTopicListState = ListState.HINT_LOADING;

  List<PgcTopicInfo> pgcTopics = List<PgcTopicInfo>();

  int _historyCurrentPage = 1;
  bool historyMaxCount = false;
  List<int> collectCheckedList = List<int>();//收藏的id列表
  bool isBulkCollectOperation = false;//是否批量收藏操作
  bool isBulkCollectPage = false;//是否批量收藏页面

  loadPgcTopicInfoHistoryList(
      Map<String, dynamic> map,
      {bool preRefresh = false}) {

    if (pgcTopicListState == ListState.HINT_LOADED_FAILED_CLICK ||
        pgcTopicListState == ListState.HINT_NO_DATA_CLICK) {
      preRefresh = true;
    }
    pgcTopicListState = ListState.HINT_LOADING;
    if (preRefresh) notifyListeners();
    _historyCurrentPage = 1;
    historyMaxCount = false;
    if (pgcTopics != null) pgcTopics.clear();
    _getPgcTopicList( map);
  }

  Future<void> pgcTopicListHistoryHandleRefresh(
      {bool preRefresh = false,
        String state,
        Map<String, dynamic> map}) async {
    return loadPgcTopicInfoHistoryList(map,
        preRefresh: preRefresh);
  }

  Future<void> pgcTopicListHandleLoadMore(
      {Map<String, dynamic> map}) async {
    _historyCurrentPage++;
    if (!historyMaxCount) {
      _getPgcTopicList(map);
    }
  }

  _getPgcTopicList( Map<String, dynamic> map) async {

    Map<String, dynamic> params = {
      "pageSize": HttpOptions.pageSize,
      "current": _historyCurrentPage,
    };
    if (map != null) {
      params.addAll(map);
    }
    LogUtils.printLog(json.encode(params));
    HttpUtil.post(HttpOptions.pendingOrderListUrl, _getListCallBack,
        jsonData: json.encode(params), errorCallBack: _getListErrorCallBack);
  }

  _getListCallBack(data) {
    PgcTopicList infos;
    try {
      infos = PgcTopicList.fromJson(data);
    } catch (e) {
      LogUtils.printLog('工单列表:$data');
      infos = new PgcTopicList(code: '0');
    }

    if (infos.code == '0') {
      if (infos.pgcTopicInfoList != null && infos.pgcTopicInfoList.length > 0) {
        pgcTopicListState = ListState.HINT_DISMISS;
        if(_historyCurrentPage==1){//刷新操作，清空数据再添加（防止多次刷新请求导致数据重复添加）
          pgcTopics.clear();
        }
        pgcTopics.addAll(infos.pgcTopicInfoList);
        if (infos.pgcTopicInfoList.length < HttpOptions.pageSize) historyMaxCount = true;
//        }
      } else {
        if (pgcTopics == null || pgcTopics.isEmpty) {
          //nodata
          pgcTopicListState = ListState.HINT_NO_DATA_CLICK;
          pgcTopics.clear();
        } else {
          //已到列表最底
          historyMaxCount = true;
        }
      }
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(
          failCode: infos.code.toString(), failMsg: infos.message);
      pgcTopicListState = ListState.HINT_LOADED_FAILED_CLICK;
      LogUtils.printLog('工单列表失败:' + failedDescri);
    }

    notifyListeners();
  }

  cleanPgcTopicListModel() {
    pgcTopicListState = ListState.HINT_LOADING;
    pgcTopics = List<PgcTopicInfo>();
    _historyCurrentPage = 1;
    historyMaxCount = false;
  }

  void _getListErrorCallBack(errorMsg) {
    LogUtils.printLog('接口返回失败');
    pgcTopicListState = ListState.HINT_LOADED_FAILED_CLICK;
    notifyListeners();
  }

  static PgcTopicListModel of(context) =>
      ScopedModel.of<PgcTopicListModel>(context);
}
