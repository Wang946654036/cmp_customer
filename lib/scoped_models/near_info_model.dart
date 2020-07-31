import 'dart:convert';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/near_info_list.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/failed_code_trans.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:scoped_model/scoped_model.dart';

mixin NearInfoModel on Model {
  ListState nearInfoListLoadState = ListState.HINT_LOADING;

  List<NearInfo> nearInfos = List<NearInfo>();
  NearInfo nearInfo;

  int _historyCurrentPage = 1;
  bool historyMaxCount = false;

  loadNearInfoHistoryList({bool preRefresh = false}) {
    if (nearInfoListLoadState == ListState.HINT_LOADED_FAILED_CLICK ||
        nearInfoListLoadState == ListState.HINT_NO_DATA_CLICK) {
      preRefresh = true;
    }
    nearInfoListLoadState = ListState.HINT_LOADING;
    if (preRefresh) notifyListeners();
    _historyCurrentPage = 1;
    historyMaxCount = false;
    if (nearInfos != null) nearInfos.clear();
    _getNearInfosList();
  }

  Future<void> nearInfoHistoryHandleRefresh({bool preRefresh = false}) async {
    return loadNearInfoHistoryList(preRefresh: preRefresh);
  }

  Future<void> nearInfoHandleLoadMore() async {
    _historyCurrentPage++;
    if (!historyMaxCount) {
      _getNearInfosList();
    }
  }

  _getNearInfosList() async {
//    if (stateModel.customerId == null) {
//      nearInfoListLoadState = ListState.HINT_NO_DATA_CLICK;
//      notifyListeners();
//      return;
//    }
    if (stateModel.defaultProjectId == null) {
      nearInfoListLoadState = ListState.HINT_NO_DATA_CLICK;
      notifyListeners();
      return;
    }
    Map<String, dynamic> params = {
      "pageSize": HttpOptions.pageSize,
      "current": _historyCurrentPage,
//      'currentUser': stateModel.customerId,
      'projectId': stateModel.defaultProjectId
    };
    LogUtils.printLog(json.encode(params));
    HttpUtil.post(HttpOptions.findNearListByProjectId, _getListCallBack,
        jsonData: json.encode(params), errorCallBack: _getListErrorCallBack);
  }

  _getListCallBack(data) {
    NearInfoList infos;
    try {
      infos = NearInfoList.fromJson(data);
    } catch (e) {
      LogUtils.printLog('工单列表:$data');
      infos = new NearInfoList(code: '0');
    }

    if (infos.code == '0') {
      if (infos.data != null && infos.data.length > 0) {
        nearInfoListLoadState = ListState.HINT_DISMISS;
        if (_historyCurrentPage == 1) {
          //刷新操作，清空数据再添加（防止多次刷新请求导致数据重复添加）
          nearInfos.clear();
        }
        nearInfos.addAll(infos.data);
        if (infos.data.length < HttpOptions.pageSize) historyMaxCount = true;
//        }
      } else {
        if (nearInfos == null || nearInfos.isEmpty) {
          //nodata
          nearInfoListLoadState = ListState.HINT_NO_DATA_CLICK;
          nearInfos.clear();
        } else {
          //已到列表最底
          historyMaxCount = true;
        }
      }
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(
          failCode: infos.code.toString(), failMsg: infos.message);
      nearInfoListLoadState = ListState.HINT_LOADED_FAILED_CLICK;
      LogUtils.printLog('工单列表失败:' + failedDescri);
    }

    notifyListeners();
  }

  cleanNearInfosListModel() {
    nearInfoListLoadState = ListState.HINT_LOADING;

    nearInfos = List<NearInfo>();
    nearInfo = null;

    _historyCurrentPage = 1;
    historyMaxCount = false;
  }

  void _getListErrorCallBack(errorMsg) {
    LogUtils.printLog('接口返回失败');
    nearInfoListLoadState = ListState.HINT_LOADED_FAILED_CLICK;
    notifyListeners();
  }

  static NearInfoModel of(context) => ScopedModel.of<NearInfoModel>(context);
}
