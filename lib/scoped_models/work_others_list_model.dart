import 'dart:convert';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/work_other_list.dart';
import 'package:cmp_customer/models/work_other_obj.dart';
import 'package:cmp_customer/ui/work_other/work_other_ui.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/failed_code_trans.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:scoped_model/scoped_model.dart';

mixin WorkOthersListModel on Model {
  ListState workOtherListLoadState = ListState.HINT_LOADING;
  WorkOtherMainType complaintType;
  List<WorkOther> workOthers = List<WorkOther>();
  WorkOther workOther;

  int _historyCurrentPage = 1;
  bool historyMaxCount = false;



  loadWorkOtherHistoryList(String complaintTyp,String queryType,
      {bool preRefresh = false}) {
    if (workOtherListLoadState == ListState.HINT_LOADED_FAILED_CLICK ||
        workOtherListLoadState == ListState.HINT_NO_DATA_CLICK) {
      preRefresh = true;
    }
    workOtherListLoadState = ListState.HINT_LOADING;
    if (preRefresh) notifyListeners();
    _historyCurrentPage = 1;
    historyMaxCount = false;
//    print('_orderAllMap[page.tag]:${_orderAllMap[page]}');
    if (workOthers != null) workOthers.clear();
    _getWorkOthersList(complaintTyp);
  }

  Future<void> workOtherHistoryHandleRefresh(String complaintTyp,
      {bool preRefresh = false,String queryType}) async {
    return loadWorkOtherHistoryList(complaintTyp,queryType, preRefresh: preRefresh );
  }

  Future<void> workOtherHandleLoadMore(String complaintTyp ) async {
    _historyCurrentPage++;
    if (!historyMaxCount) {
      _getWorkOthersList(complaintTyp);
    }
  }

  _getWorkOthersList(String complaintType) async {


    Map<String, dynamic> params = {
      "pageSize": HttpOptions.pageSize,
      "current": _historyCurrentPage,
      'customerId':stateModel.customerId,
      'serviceType':complaintType
    };
    LogUtils.printLog(json.encode(params));
    HttpUtil.post(HttpOptions.pendingOrderListUrl, _getListCallBack,
        jsonData: json.encode(params), errorCallBack: _getListErrorCallBack);
  }

  _getListCallBack(data) {
    WorkOtherList infos;
    try {
      infos = WorkOtherList.fromJson(data);
    } catch (e) {
      LogUtils.printLog('工单列表:$data');
      infos = new WorkOtherList(code: '0');
    }

    if (infos.code == '0') {
      if (infos.data != null && infos.data.length > 0) {
        workOtherListLoadState = ListState.HINT_DISMISS;
        if(_historyCurrentPage==1){//刷新操作，清空数据再添加（防止多次刷新请求导致数据重复添加）
          workOthers.clear();
        }
        workOthers.addAll(infos.data);
        if (infos.data.length < HttpOptions.pageSize)
          historyMaxCount = true;
//        }
      } else {
        if (workOthers == null || workOthers.isEmpty) {
          //nodata
          workOtherListLoadState = ListState.HINT_NO_DATA_CLICK;
          workOthers.clear();
        } else {
          //已到列表最底
          historyMaxCount = true;
        }
      }
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(
          failCode: infos.code.toString(), failMsg: infos.message);
      workOtherListLoadState = ListState.HINT_LOADED_FAILED_CLICK;
      LogUtils.printLog('工单列表失败:' + failedDescri);
    }

    notifyListeners();
  }
  cleanWorkOthersListModel(){
    workOtherListLoadState = ListState.HINT_LOADING;
    complaintType=null;
    workOthers = List<WorkOther>();
    workOther=null;

    _historyCurrentPage = 1;
    historyMaxCount = false;
  }
  void _getListErrorCallBack(errorMsg) {
    LogUtils.printLog('接口返回失败');
    workOtherListLoadState = ListState.HINT_LOADED_FAILED_CLICK;
    notifyListeners();
  }
  static WorkOthersListModel of(context) =>
      ScopedModel.of<WorkOthersListModel>(context);
}
