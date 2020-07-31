import 'dart:convert';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/models/common_result_model.dart';
import 'package:cmp_customer/models/market/ware_detail_model.dart';
import 'package:cmp_customer/models/market/ware_list_response.dart';
import 'package:cmp_customer/models/pgc/pgc_infomation_list.dart';
import 'package:cmp_customer/models/pgc/pgc_infomation_obj.dart';
import 'package:cmp_customer/models/response/base_response.dart';
import 'package:cmp_customer/models/response/talk_list_response.dart';
import 'package:cmp_customer/models/response/topic_list_response.dart';
import 'package:cmp_customer/models/response/winning_record_response.dart';
import 'package:cmp_customer/scoped_models/pgc_model/pgc_collect_state_model.dart';
import 'package:cmp_customer/scoped_models/pgc_model/pgc_comment_model.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/failed_code_trans.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:scoped_model/scoped_model.dart';
import 'base_model.dart';

class WinningRecordListModel extends BaseModel {

  loadList(
      Map<String, dynamic> map,
      {bool preRefresh = false}) {

    if (listState == ListState.HINT_LOADED_FAILED_CLICK ||
        listState == ListState.HINT_NO_DATA_CLICK) {
      preRefresh = true;
    }
    listState = ListState.HINT_LOADING;
    if (preRefresh) notifyListeners();
    listCurrentPage = 1;
    maxCount = false;
    if (list != null) list.clear();
    _getList( map);
  }

  Future<void> listHistoryHandleRefresh(
      {bool preRefresh = false,
        String state,
        Map<String, dynamic> map}) async {
    return loadList(map,
        preRefresh: preRefresh);
  }


  Future<void> listHandleLoadMore(
      {Map<String, dynamic> map}) async {
//    listCurrentPage++;
    if (!maxCount) {
      _getList(map);
    }
  }
  _getList( Map<String, dynamic> map) async {
    Map<String, dynamic> params = {
      "pageSize": HttpOptions.pageSize,
      "current": listCurrentPage,
//      "projectId":stateModel.defaultProjectId,
    };
    if (map != null) {
      params.addAll(map);
    }
    LogUtils.printLog(json.encode(params));
    HttpUtil.post(HttpOptions.findAppWinningManagement, _getListCallBack,
        jsonData: json.encode(params), errorCallBack: _getListErrorCallBack);
  }
  _getListCallBack(data) {
    try {
      WinningRecordResponse response = WinningRecordResponse.fromJson(data);
      if (response.success()) {
        if (response.data != null && response.data.length > 0) {
          listState = ListState.HINT_DISMISS;
          if(listCurrentPage==1){//刷新操作，清空数据再添加（防止多次刷新请求导致数据重复添加）
            list.clear();
          }
          list.addAll(response.data);
          if (response.data.length < HttpOptions.pageSize) maxCount = true;
          else  listCurrentPage++;
//        }
        } else {
          if (list == null || list.isEmpty) {
            //nodata
            listState = ListState.HINT_NO_DATA_CLICK;
            list.clear();
          } else {
            //已到列表最底
            maxCount = true;
          }
        }
      } else {
        String failedDescri = FailedCodeTrans.enTochsTrans(
            failCode: response.code.toString(), failMsg: response.message);
        listState = ListState.HINT_LOADED_FAILED_CLICK;
        LogUtils.printLog('列表失败:' + failedDescri);
      }
      notifyListeners();
    } catch (e) {
      LogUtils.printLog('列表:$data');
      _getListErrorCallBack("解析错误");
    }
  }

  void _getListErrorCallBack(errorMsg) {
    LogUtils.printLog('接口返回失败');
    listState = ListState.HINT_LOADED_FAILED_CLICK;
    notifyListeners();
  }
  

  static WinningRecordListModel of(context) =>
      ScopedModel.of<WinningRecordListModel>(context);
}
