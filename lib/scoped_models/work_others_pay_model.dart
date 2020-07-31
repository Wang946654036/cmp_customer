import 'dart:convert';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/pay_service_info_list.dart';
import 'package:cmp_customer/ui/work_other/work_other_ui.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/failed_code_trans.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:scoped_model/scoped_model.dart';

class PayAdapter {
  ListState payServiceInfoListLoadState = ListState.HINT_LOADING;
  List<PayServiceInfo> payServiceInfos = List<PayServiceInfo>();
  int _historyCurrentPage = 1;
  bool historyMaxCount = false;
}

class WorkOthersPayModel extends Model {
  Map<WorkOtherSubType, PayAdapter> payAdapterMap;

  WorkOthersPayModel({List<WorkOtherSubType> list}) {
    if (list != null) {
      payAdapterMap = new Map<WorkOtherSubType, PayAdapter>();
      list.forEach((WorkOtherSubType type) {
        payAdapterMap.addAll({type: new PayAdapter()});
      });
    }
  }

  loadWorkOthersPayListList(WorkOtherSubType type, {bool preRefresh = false}) {
    if (payAdapterMap[type].payServiceInfoListLoadState ==
            ListState.HINT_LOADED_FAILED_CLICK ||
        payAdapterMap[type].payServiceInfoListLoadState ==
            ListState.HINT_NO_DATA_CLICK) {
      preRefresh = true;
    }
    payAdapterMap[type].payServiceInfoListLoadState = ListState.HINT_LOADING;
    if (preRefresh) notifyListeners();
    payAdapterMap[type]._historyCurrentPage = 1;
    payAdapterMap[type].historyMaxCount = false;
//    print('_orderAllMap[page.tag]:${_orderAllMap[page]}');
    if (payAdapterMap[type].payServiceInfos != null)
      payAdapterMap[type].payServiceInfos.clear();
    _getWorkOthersPayList(type);
  }

  Future<void> payServiceInfoPayListHandleRefresh(WorkOtherSubType complaintTyp,
      {bool preRefresh = false}) async {
    return loadWorkOthersPayListList(complaintTyp, preRefresh: preRefresh);
  }

  payServiceInfoPayHandleLoadMore(WorkOtherSubType type) {
    payAdapterMap[type]._historyCurrentPage += HttpOptions.pageSize;
    if (!payAdapterMap[type].historyMaxCount) {
      _getWorkOthersPayList(type);
    }
  }

  _getWorkOthersPayList(WorkOtherSubType type) async {
    payAdapterMap[type].payServiceInfoListLoadState = ListState.HINT_LOADING;
    notifyListeners();
    Map<String, dynamic> params = {
      "current": payAdapterMap[type]._historyCurrentPage,
      "hasRelease": "1",
      "pageSize": 10,
      "projectId":stateModel.defaultProjectId??1,
      "serviceType":getWorkSubTypeStr(type)
    };

    HttpUtil.post(
        HttpOptions.findServiceConfigListUrl,
            (data) {
          _getListCallBack(data, type);
        },
        jsonData: json.encode(params),
        errorCallBack: (errorMsg) {
          _getListErrorCallBack(errorMsg, type);
        });
  }

  _getListCallBack(data, type) {
    PayServiceInfoList workothers =
        PayServiceInfoList.fromJson(data);
    LogUtils.printLog('工单列表:$data');
    if (workothers.code == '0') {
      if (workothers.data != null && workothers.data.length > 0) {
        payAdapterMap[type].payServiceInfoListLoadState =
            ListState.HINT_DISMISS;
        payAdapterMap[type].payServiceInfos.addAll(workothers.data);
        if (workothers.data.length < HttpOptions.pageSize)
          payAdapterMap[type].historyMaxCount = true;
//        }
      } else {
        if (payAdapterMap[type].payServiceInfos == null ||
            payAdapterMap[type].payServiceInfos.isEmpty) {
          //nodata
          payAdapterMap[type].payServiceInfoListLoadState =
              ListState.HINT_NO_DATA_CLICK;
          payAdapterMap[type].payServiceInfos.clear();
        } else {
          //已到列表最底
          payAdapterMap[type].historyMaxCount = true;
        }
      }
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(
          failCode: workothers.code.toString(), failMsg: workothers.message);
      payAdapterMap[type].payServiceInfoListLoadState =
          ListState.HINT_LOADED_FAILED_CLICK;
      LogUtils.printLog('工单列表失败:' + failedDescri);
    }

    notifyListeners();
  }

  _getListErrorCallBack(errorMsg, type) {
    LogUtils.printLog('接口返回失败');
    payAdapterMap[type].payServiceInfoListLoadState =
        ListState.HINT_LOADED_FAILED_CLICK;
    notifyListeners();
  }
cleanWorkOthersPayModel(){
//  payAdapterMap.clear();
}
  static WorkOthersPayModel of(context) =>
      ScopedModel.of<WorkOthersPayModel>(context);
}
