import 'dart:convert';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/models/market/ware_comment_response.dart';
import 'package:cmp_customer/models/market/ware_detail_model.dart';
import 'package:cmp_customer/models/market/ware_detail_response.dart';
import 'package:cmp_customer/models/response/base_response.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/failed_code_trans.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:scoped_model/scoped_model.dart';

import '../base_model.dart';
import 'market_comment_model.dart';

class MarketDetailModel extends BaseModel with MarketCommentModel{
  WareDetailModel marketInfo;

  getDetail(int waresId, {Function callBack}) async {
    listState = ListState.HINT_LOADING;
    notifyListeners();
    Map<String, dynamic> params = Map();
    params['waresId'] = waresId;
    LogUtils.printLog(json.encode(params));
    HttpUtil.post(HttpOptions.findWareDetail, (data) {
      _getDetailCallBack(data, callBack);
    }, jsonData: json.encode(params), errorCallBack: _getListErrorCallBack);
  }

  _getDetailCallBack(data, Function callBack) {
    try {
      WareDetailResponse info = WareDetailResponse.fromJson(data);
      if (info.success()) {
        if (info.data != null) {
          listState = ListState.HINT_DISMISS;
          marketInfo = info.data;
//          marketInfo.content =  marketInfo.content.replaceAll('\"', '"');
//          LogUtils.printLog('详情:${marketInfo.content}');
          //点赞和分享状态
//          hasDianzan = (marketInfo?.custLike??'0')=='0'?false:true;
//          hasSelected = (marketInfo?.custCollect??'0')=='0'?false:true;

          if (callBack != null) {
            callBack();
          }
        } else {
          //nodata
          listState = ListState.HINT_NO_DATA_CLICK;
        }
      } else {
        String failedDescri = FailedCodeTrans.enTochsTrans(
            failCode: info.code.toString(), failMsg: info.message);
        listState = ListState.HINT_LOADED_FAILED_CLICK;
        LogUtils.printLog('详情失败:' + failedDescri);
      }
      notifyListeners();
    } catch (e) {}
  }

  void _getListErrorCallBack(errorMsg) {
    LogUtils.printLog('接口返回失败');
    listState = ListState.HINT_LOADED_FAILED_CLICK;
    notifyListeners();
  }

  //上下架操作
  Future<void> updateWareStatus(Map<String, dynamic> map,
      {Function callback}) async {
    HttpUtil.post(HttpOptions.updateWareStatus, (data) {
      _uploadApplyDataCallBack(data, callback: callback);
    }, jsonData: jsonEncode(map), errorCallBack: _errorCallBack);
  }

  //收藏操作
  Future<void> collectWare(Map<String, dynamic> map,
      {Function callback}) async {
    HttpUtil.post(HttpOptions.collectWare, (data) {
      _uploadApplyDataCallBack(data, callback: callback);
    }, jsonData: jsonEncode(map), errorCallBack: _errorCallBack);
  }

  //点赞操作
  Future<void> likeWare(Map<String, dynamic> map, {Function callback}) async {
    HttpUtil.post(HttpOptions.likeWare, (data) {
      _uploadApplyDataCallBack(data, callback: callback);
    }, jsonData: jsonEncode(map), errorCallBack: _errorCallBack);
  }

  //发表留言
  Future<void> addWareComment(Map<String, dynamic> map, {Function callback}) async {
    HttpUtil.post(HttpOptions.addWareComment, (data) {
      _uploadApplyDataCallBack(data, callback: callback);
    }, jsonData: jsonEncode(map), errorCallBack: _errorCallBack);
  }

  //通用网络请求错误回调
  _errorCallBack(data) {
    CommonToast.show(type: ToastIconType.FAILED, msg: "提交失败");
    LogUtils.printLog("提交失败：" + data?.toString());
  }

  //操作成功
  _uploadApplyDataCallBack(data, {Function callback}) {
    CommonToast.dismiss();
    try {
      BaseResponse resultModel = BaseResponse.fromJson(data);
      if (resultModel != null) {
        if (resultModel.success()) {
          //请求成功
          if (callback != null) {
            callback();
          }
        } else {
          //请求成功
//      LogUtils.printLog("月卡申请失败："+resultModel.message);
          CommonToast.show(
              type: ToastIconType.FAILED,
              msg: "提交失败:" + resultModel.message ?? "");
        }
      } else {
        CommonToast.show(type: ToastIconType.FAILED, msg: "提交失败");
      }
    } catch (e) {
      CommonToast.show(type: ToastIconType.FAILED, msg: "提交异常，请重试");
    } finally {
      notifyListeners();
    }
  }

  static MarketDetailModel of(context) =>
      ScopedModel.of<MarketDetailModel>(context);
}
