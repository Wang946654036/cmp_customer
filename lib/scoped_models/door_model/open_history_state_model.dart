import 'dart:convert';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/models/request/base_request.dart';
import 'package:cmp_customer/models/response/door_history_response.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:scoped_model/scoped_model.dart';

class OpenDoorHistoryModel extends Model {
  ListState historyListState = ListState.HINT_LOADING;
  int _historyCurrentPage = 1;//从第一页开始
  List<DoorList> listData = new List();//开门的列表
  bool maxCount = false;

  //记录列表
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
    if (listData != null) listData.clear();
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

  //请求
  _getHistoryList() {
    BaseRequest request = BaseRequest();
    request.current=_historyCurrentPage;
    HttpUtil.post(HttpOptions.openDoorHistory,_historyCallBack,jsonData:json.encode(request), errorCallBack: _historyErrorCallBack);
  }

  void _historyCallBack(data) {
    try{
      DoorHistoryResponse model = DoorHistoryResponse.fromJson(data);
      if (model.success()) {
        if (model.doorList != null && model.doorList.length > 0) {
          historyListState = ListState.HINT_DISMISS;
          if(_historyCurrentPage==1){//刷新操作，清空数据再添加（防止多次刷新请求导致数据重复添加）
            listData.clear();
          }
          listData.addAll(model.doorList);
          if (model.doorList.length < HttpOptions.pageSize) maxCount = true;
          else _historyCurrentPage++;//页面加1，用于加载下一页
//        }
        } else {
          if (listData == null || listData.isEmpty) {
            //nodata
            historyListState = ListState.HINT_NO_DATA_CLICK;
            listData.clear();
          } else {
            //已到列表最底
            maxCount = true;
          }
        }
      } else {
//        String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
        historyListState = ListState.HINT_LOADED_FAILED_CLICK;
      }
    }catch(e){
      historyListState = ListState.HINT_LOADED_FAILED_CLICK;
    }
    notifyListeners();
  }

  void _historyErrorCallBack(errorMsg) {
    historyListState = ListState.HINT_LOADED_FAILED_CLICK;
//    Fluttertoast.showToast(msg: errorMsg);
    notifyListeners();
  }
}
