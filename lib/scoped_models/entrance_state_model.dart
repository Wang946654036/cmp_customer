//import 'dart:convert';
//
//import 'package:cmp_customer/http/http_options.dart';
//import 'package:cmp_customer/http/http_util.dart';
//import 'package:cmp_customer/models/transport_driver_model.dart';
//import 'package:cmp_customer/utils/constant.dart';
//import 'package:cmp_customer/utils/failed_code_trans.dart';
//import 'package:cmp_customer/utils/log_util.dart';
//import 'package:scoped_model/scoped_model.dart';
//
//
//class EntranceListStateModel extends Model {
//
//  ListState historyListState = ListState.HINT_LOADING;
//  int _historyCurrentPage = 1;
////  int historyTotalCount = 0;
//  bool historyMaxCount = false;
//  List<TransportDriverInfo> entranceHistoryList;
//
//
//
//  //门禁卡申请记录列表
//  loadHistoryList({bool preRefresh = false}) {
//    if (historyListState == ListState.HINT_LOADED_FAILED_CLICK ||
//        historyListState == ListState.HINT_NO_DATA_CLICK) {
//      preRefresh = true;
//    }
//    historyListState = ListState.HINT_LOADING;
//    if (preRefresh) notifyListeners();
//    _historyCurrentPage = 0;
//    historyMaxCount = false;
////    print('_orderAllMap[page.tag]:${_orderAllMap[page]}');
//    if (entranceHistoryList != null) entranceHistoryList.clear();
//    _getHistoryList();
//  }
//
//  Future<void> historyHandleRefresh({bool preRefresh = false}) async {
//    loadHistoryList(preRefresh: preRefresh);
//  }
//
//  quoteRecordHandleLoadMore() {
//    _historyCurrentPage += HttpOptions.pageSize;
//    if (!historyMaxCount) {
//      _getHistoryList();
//    }
//  }
//
//  _getHistoryList() async {
//    Map<String, String> params = new Map();
//    params['current'] = _historyCurrentPage.toString();
//    params['pageSize'] = HttpOptions.pageSize.toString();
//
//    HttpUtil.post(HttpOptions.loginUrl, _historyCallBack,
//        params: params, errorCallBack: _historyErrorCallBack);
//  }
//
//  void _historyCallBack(data) {
//    TransportDriverModel model = TransportDriverModel.fromJson(json.decode(data));
//    LogUtils.printLog('门禁卡记录列表:$data');
//    if (model.code == '0') {
//      if (model.transportDriverList != null && model.transportDriverList.length > 0) {
//        historyListState = ListState.HINT_DISMISS;
//        entranceHistoryList.addAll(model.transportDriverList);
//        if (model.transportDriverList.length < HttpOptions.pageSize) historyMaxCount = true;
////        }
//      } else {
//        if (entranceHistoryList == null || entranceHistoryList.isEmpty) {
//          //nodata
//          historyListState = ListState.HINT_NO_DATA_CLICK;
//          entranceHistoryList.clear();
//        } else {
//          //已到列表最底
//          historyMaxCount = true;
//        }
//      }
//    } else {
//      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
//      historyListState = ListState.HINT_LOADED_FAILED_CLICK;
////      Fluttertoast.showToast(msg: failedDescri);
//    }
//    notifyListeners();
//  }
//
//  void _historyErrorCallBack(errorMsg) {
//    LogUtils.printLog('接口返回失败');
//    historyListState = ListState.HINT_LOADED_FAILED_CLICK;
////    Fluttertoast.showToast(msg: errorMsg);
//    notifyListeners();
//  }
//
//  static EntranceStateModel of(context) => ScopedModel.of<EntranceStateModel>(context);
//}