import 'dart:convert';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/models/process_main_node_list.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/failed_code_trans.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:scoped_model/scoped_model.dart';

mixin WorkOthersProcessNodeModel on Model{

  ListState processNodeState = ListState.HINT_LOADING;
  List<ProcessMainNode> processMainNodeList = new List();


  loadWorkOthersProcessNodeList(int workOtherId, {bool preRefresh = false}) {
    if (processNodeState ==
        ListState.HINT_LOADED_FAILED_CLICK ||
        processNodeState ==
            ListState.HINT_NO_DATA_CLICK) {
      preRefresh = true;
    }
    processNodeState = ListState.HINT_LOADING;
    if (preRefresh) notifyListeners();
//    print('_orderAllMap[page.tag]:${_orderAllMap[page]}');
    if (processMainNodeList != null)
      processMainNodeList.clear();
    _getWorkOthersProcessNode(workOtherId);
  }

  Future<void> payServiceInfoProcessNodeHandleRefresh(int workOtherId,
      {bool preRefresh = false}) async {
    return loadWorkOthersProcessNodeList(workOtherId, preRefresh: preRefresh);
  }


  _getWorkOthersProcessNode(int workOrderId,) async {
    processNodeState = ListState.HINT_LOADING;
    notifyListeners();
    Map<String, dynamic> params = {
      "workOrderId": workOrderId,
     };

    HttpUtil.post(
        HttpOptions.queryWorkOrderNodeListUrl,
            (data) {
          _getListCallBack(data);
        },
        jsonData: jsonEncode(params),
        errorCallBack: (errorMsg) {
          _getListErrorCallBack(errorMsg);
        });
  }

  _getListCallBack(data) {
    ProcessMainNodeList processNodes =
    ProcessMainNodeList.fromJson(data);
    LogUtils.printLog('节点列表:$data');
    if (processNodes.code == '0') {
      if (processNodes.data != null && processNodes.data.length > 0) {
        processNodeState =
            ListState.HINT_DISMISS;
        processMainNodeList.addAll(processNodes.data);

//        }
      } else {
          processNodeState =
              ListState.HINT_NO_DATA_CLICK;
          processMainNodeList.clear();
      }
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(
          failCode: processNodes.code.toString(), failMsg: processNodes.message);
      processNodeState =
          ListState.HINT_LOADED_FAILED_CLICK;
      LogUtils.printLog('节点列表失败:' + failedDescri);
    }

    notifyListeners();
  }

  _getListErrorCallBack(errorMsg) {
    LogUtils.printLog('接口返回失败');
    processNodeState =
        ListState.HINT_LOADED_FAILED_CLICK;
    notifyListeners();
  }
  cleanWorkOthersProcessNodesModel(){
    processNodeState = ListState.HINT_LOADING;
    processMainNodeList = new List();
  }
  static WorkOthersProcessNodeModel of(context) =>
      ScopedModel.of<WorkOthersProcessNodeModel>(context);

}