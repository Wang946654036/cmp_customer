import 'dart:convert';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/models/common_result_model.dart';
import 'package:cmp_customer/models/market/ware_detail_model.dart';
import 'package:cmp_customer/models/market/ware_list_response.dart';
import 'package:cmp_customer/models/pgc/pgc_infomation_list.dart';
import 'package:cmp_customer/models/pgc/pgc_infomation_obj.dart';
import 'package:cmp_customer/models/response/base_response.dart';
import 'package:cmp_customer/scoped_models/pgc_model/pgc_collect_state_model.dart';
import 'package:cmp_customer/scoped_models/pgc_model/pgc_comment_model.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/failed_code_trans.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../main.dart';
import '../base_model.dart';
import 'market_screen_model.dart';

class MarketListModel extends BaseModel with MarketScreenStateModel{
  ListState marketListState = ListState.HINT_LOADING;
  List<WareDetailModel> markets = List<WareDetailModel>();
  int _historyCurrentPage = 1;
  bool historyMaxCount = false;
  List<int> collectCheckedList = List<int>();//收藏的id列表
  bool isBulkCollectOperation = false;//是否批量收藏操作
  bool isBulkCollectPage = false;//是否批量收藏页面
  bool isMine = false;//是否我发布的商品
  Map<String, dynamic> params = Map();

  loadList(
      Map<String, dynamic> map,
      {bool preRefresh = false}) {

    if (marketListState == ListState.HINT_LOADED_FAILED_CLICK ||
        marketListState == ListState.HINT_NO_DATA_CLICK) {
      preRefresh = true;
    }
    marketListState = ListState.HINT_LOADING;
    if (preRefresh) notifyListeners();
    _historyCurrentPage = 1;
    historyMaxCount = false;
    if (markets != null) markets.clear();
    _getList( map);
  }

  Future<void> marketListHistoryHandleRefresh(
      {bool preRefresh = false,
        String state,
        Map<String, dynamic> map}) async {
    return loadList(map,
        preRefresh: preRefresh);
  }


  Future<void> marketListHandleLoadMore(
      {Map<String, dynamic> map}) async {
//    _historyCurrentPage++;
    if (!historyMaxCount) {
      _getList(map);
    }
  }
  _getList( Map<String, dynamic> map) async {
    Map<String, dynamic> params = {
      "pageSize": HttpOptions.pageSize,
      "current": _historyCurrentPage,
//      "projectId":stateModel.defaultProjectId,
    };
    if (map != null) {
      params.addAll(map);
    }
    LogUtils.printLog(json.encode(params));
    HttpUtil.post(isMine?HttpOptions.findMyWaresPage:(isBulkCollectPage?HttpOptions.findMyCollectWaresPage:HttpOptions.findWaresPage), _getListCallBack,
        jsonData: json.encode(params), errorCallBack: _getListErrorCallBack);
  }
  _getListCallBack(data) {
    try {
      WareListResponse infos = WareListResponse.fromJson(data);
      if (infos.success()) {
        if (infos.data != null && infos.data.length > 0) {
          marketListState = ListState.HINT_DISMISS;
          if(_historyCurrentPage==1){//刷新操作，清空数据再添加（防止多次刷新请求导致数据重复添加）
            markets.clear();
          }
          markets.addAll(infos.data);
          if (infos.data.length < HttpOptions.pageSize) historyMaxCount = true;
          else  _historyCurrentPage++;
//        }
        } else {
          if (markets == null || markets.isEmpty) {
            //nodata
            marketListState = ListState.HINT_NO_DATA_CLICK;
            markets.clear();
          } else {
            //已到列表最底
            historyMaxCount = true;
          }
        }
      } else {
        String failedDescri = FailedCodeTrans.enTochsTrans(
            failCode: infos.code.toString(), failMsg: infos.message);
        marketListState = ListState.HINT_LOADED_FAILED_CLICK;
        LogUtils.printLog('pgc列表失败:' + failedDescri);
      }
      notifyListeners();
    } catch (e) {
      LogUtils.printLog('pgc列表:$data');
      _getListErrorCallBack("解析错误");
    }
  }

  void _getListErrorCallBack(errorMsg) {
    LogUtils.printLog('接口返回失败');
    marketListState = ListState.HINT_LOADED_FAILED_CLICK;
    notifyListeners();
  }


  //设置多选操作
  changedBulkCollectOperation(){
    isBulkCollectOperation = !isBulkCollectOperation;
    notifyListeners();
  }

  //多选框操作
  changedCollectCheckbox(bool checked,int id){
    if(checked){
      collectCheckedList?.add(id);
    }else{
      collectCheckedList?.remove(id);
    }
    notifyListeners();
  }

  //多选框操作
  setAllCollected(bool checked){
    collectCheckedList.clear();
    if(checked){
      if(markets!=null){
        collectCheckedList.addAll(markets.map((info)=>info.waresId).toList());
      }
    }
    notifyListeners();
  }


  //设置查询数据
  setSearchWord(String text){
    params["title"] = text;
  }
  //获取筛选数据
  setScreenData() {
    String regionFlag;
//    StringBuffer tradingType = new StringBuffer();
//    StringBuffer waresType = new StringBuffer();
    List<String> tradingTypes = List();
    List<String> waresTypes = List();
    //发布范围
    rangeList?.forEach((model){
      if(model?.selected??false){
        regionFlag = model.code;
      }
    });

    //发布类型
    typeList?.forEach((model){
      if(model?.selected??false){
//        tradingType.write(",${model.code}");
        tradingTypes.add(model.code);
      }
    });

    //商品分类
    classificationList?.forEach((model){
      if(model?.selected??false){
//        waresType.write(",${model.code}");
        waresTypes.add(model.code);
      }
    });
    params["regionFlag"] = StringsHelper.getIntValue(regionFlag);
    params["tradingTypes"] = tradingTypes;
    params["waresTypes"] = waresTypes;

    marketListHistoryHandleRefresh(
        map: params,preRefresh: true);
  }



  //取消收藏
  cancelCollectList(List<int> collectIdList,int type,Function callback) {
    Map<String, Object> params = new Map();
    params['collectIds'] = collectIdList;//关联id列表
    params['collectType'] = "2";//集市商品我的收藏
    HttpUtil.post(HttpOptions.collectWare, (data){
      successCallBack(data,callback: callback);
    },
        jsonData: json.encode(params), errorCallBack: errorCallBack);
  }

  //是否可继续发布
  wareIsPublish(Function callback) {
    CommonToast.show(msg: "加载中...");
    HttpUtil.post(HttpOptions.wareIsPublish, (data){
      _publishCallBack(data,callback: callback);
    },
        jsonData: json.encode(params), errorCallBack: errorCallBack);
  }

  _publishCallBack(data,{Function callback}){
    CommonToast.dismiss();
    try {
      CommonResultModel resultModel = CommonResultModel.fromJson(data);
      if (resultModel != null) {
        if (resultModel.success()) {
          if(callback!=null){
            callback(true);
          }
        } else {
          if(callback!=null){
            callback(false);
          }
        }
      } else {
        CommonToast.show(type: ToastIconType.FAILED, msg: "加载失败，无参数返回");
      }
    }catch(e){
      CommonToast.show(type: ToastIconType.FAILED, msg: "加载失败，参数返回错误");
    }
  }

  static MarketListModel of(context) =>
      ScopedModel.of<MarketListModel>(context);
}
