import 'dart:convert';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/articles_release_detail_model.dart';
import 'package:cmp_customer/models/articles_release_record_model.dart';
import 'package:cmp_customer/models/common/common_page_model.dart';
import 'package:cmp_customer/models/common_result_model.dart';
import 'package:cmp_customer/models/response/entrance_card_house_response.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/strings/strings_articles_release.dart';
import 'package:cmp_customer/strings/strings_house_auth.dart';
import 'package:cmp_customer/ui/articles_release/articles_release_apply_page.dart';
import 'package:cmp_customer/ui/articles_release/articles_release_detail_page.dart';
import 'package:cmp_customer/ui/articles_release/articles_release_record_page.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/house_authentication/my_house_page.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/failed_code_trans.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

mixin ArticlesReleaseStateModel on Model {
  ///
  /// 已经认证通过的房屋信息(指定项目下)
  /// [isOfficeCancelLease]是否写字楼退租调用
  ///
  void getCertifiedHouseByProject({Function callBack, bool isOfficeCancelLease = false}) async {
    Map<String, dynamic> params = new Map();
    params['projectId'] = stateModel.defaultProjectId;
    if (isOfficeCancelLease) params['flag'] = '1';
    String jsonData = json.encode(params);
    HttpUtil.post(
        HttpOptions.houseCertifiedList, (data) => _certifiedHouseByProjectCallBack(data, callBack: callBack),
        jsonData: jsonData,
        errorCallBack: (errorMsg) => _certifiedHouseByProjectErrorCallBack(errorMsg, callBack: callBack));
  }

  void _certifiedHouseByProjectCallBack(data, {Function callBack}) async {
    LogUtils.printLog('已经认证通过的房屋信息(指定项目下):$data');
    EntranceCardHouseResponse model = EntranceCardHouseResponse.fromJson(data);
    if (model.code == '0') {
      //客户（已有认证过的房屋）
      if (model?.houseList != null && model.houseList.length > 0) {
        if (callBack != null) callBack(houseList: model.houseList);
      } else {
        if (callBack != null) callBack(failedMsg: '当前社区下没有已认证房屋');
        CommonToast.show(type: ToastIconType.INFO, msg: '当前社区下没有已认证房屋');
      }
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
      if (callBack != null) callBack(failedMsg: failedDescri);
      CommonToast.show(type: ToastIconType.FAILED, msg: failedDescri);
    }
    notifyListeners();
  }

  void _certifiedHouseByProjectErrorCallBack(String errorMsg, {Function callBack}) {
    LogUtils.printLog('接口返回失败：$errorMsg');
//    if (callBack != null) callBack(errorMsg: errorMsg);
    if (callBack != null) callBack(failedMsg: errorMsg);
    CommonToast.show(type: ToastIconType.FAILED, msg: errorMsg);
    notifyListeners();
  }

  ///
  /// 调用申请物品放行接口
  ///
  void applyArticleRelease({
    @required ArticlesReleaseDetail applyModel,
    bool newCreate,
    VoidCallback callBack,
  }) async {
    CommonToast.show();

    String jsonData = json.encode(applyModel);

    String url;
    if (newCreate)
      url = HttpOptions.applyArticlesReleaseUrl;
    else
      url = HttpOptions.modifyArticlesReleaseUrl;
    HttpUtil.post(
        url,
        (data) {
          _applyArticleReleaseCallBack(data);
        },
        jsonData: jsonData,
        errorCallBack: (errorMsg) {
          _applyArticleReleaseErrorCallBack(errorMsg);
        });
  }

  void _applyArticleReleaseCallBack(data) {
    CommonResultModel model = CommonResultModel.fromJson(data);
    LogUtils.printLog('申请物品放行:${json.encode(data)}');
    if (model.code == '0') {
      CommonToast.show(msg: '申请成功', type: ToastIconType.SUCCESS);
      navigatorKey.currentState.pop(true);
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
      CommonToast.show(msg: failedDescri, type: ToastIconType.FAILED);
    }
    notifyListeners();
  }

  void _applyArticleReleaseErrorCallBack(errorMsg) {
    LogUtils.printLog('接口返回失败');
    CommonToast.show(msg: errorMsg, type: ToastIconType.FAILED);
    notifyListeners();
  }

  ///
  /// 物品放行申请记录列表
  ///
  void loadArticlesReleaseRecordList(
      ListPageModel pageModel, int customerType, ArticlesReleaseFilterModel filterModel,
      {bool preRefresh = false}) {
    pageModel.listPage.listState = ListState.HINT_LOADING;
    if (preRefresh) notifyListeners();
    pageModel.listPage.currentPage = 1;
    pageModel.listPage.maxCount = false;
    pageModel.list.clear();
//    print('_orderAllMap[page.tag]:${_orderAllMap[page]}');
//    if (entranceHistoryList != null) entranceHistoryList.clear();
    _getArticlesReleaseRecordList(pageModel, customerType, filterModel);
  }

//  Future<void> articlesReleaseRecordHandleRefresh({@required TaskPageController controller, bool preRefresh = false}) async {
//    loadTaskList(controller:controller,preRefresh: preRefresh);
//  }

  articlesReleaseRecordHandleLoadMore(
      ListPageModel pageModel, int customerType, ArticlesReleaseFilterModel filterModel) {
    pageModel.listPage.currentPage++;
    if (!pageModel.listPage.maxCount) {
      _getArticlesReleaseRecordList(pageModel, customerType, filterModel);
    }
  }

  _getArticlesReleaseRecordList(
      ListPageModel pageModel, int customerType, ArticlesReleaseFilterModel filterModel) async {
    Map<String, dynamic> params = new Map();
    params['current'] = pageModel.listPage.currentPage;
    params['pageSize'] = HttpOptions.pageSize.toString();
    params['projectId'] = stateModel.defaultProjectId;
    params['startTime'] = filterModel.startTime;
    params['endTime'] = filterModel.endTime;
    params['reasons'] = filterModel.reasonList;
    params['status'] = filterModel.statusList;
    //customerType为1时，提交customerId， 0时提交ownerId，放入customerId的值
    if (customerType == 1)
      params['customerId'] = stateModel.customerId;
    else
      params['ownerId'] = stateModel.customerId;
    String jsonData = json.encode(params);

    HttpUtil.post(
        HttpOptions.articlesReleaseListUrl,
        (data) {
          _articlesReleaseRecordCallBack(data, pageModel);
        },
        jsonData: jsonData,
        errorCallBack: (errorMsg) {
          _articlesReleaseRecordErrorCallBack(errorMsg, pageModel);
        });
  }

  void _articlesReleaseRecordCallBack(data, ListPageModel pageModel) {
    ArticlesReleaseRecordModel model = ArticlesReleaseRecordModel.fromJson(data);
    LogUtils.printLog('物品放行申请记录列表:$data');
    if (model.code == '0') {
      if (model.articlesReleaseList != null && model.articlesReleaseList.length > 0) {
        pageModel.listPage.listState = ListState.HINT_DISMISS;
        if (pageModel.listPage.currentPage == 1) {
          //刷新操作，清空数据再添加（防止多次刷新请求导致数据重复添加）
          pageModel.list.clear();
        }
        pageModel.list.addAll(model.articlesReleaseList);
        if (model.articlesReleaseList.length < HttpOptions.pageSize) pageModel.listPage.maxCount = true;
//        }
      } else {
        if (pageModel.list == null || pageModel.list.isEmpty) {
          //nodata
          pageModel.listPage.listState = ListState.HINT_NO_DATA_CLICK;
          pageModel.list.clear();
        } else {
          //已到列表最底
          pageModel.listPage.maxCount = true;
        }
      }
    } else {
//      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
      pageModel.listPage.listState = ListState.HINT_LOADED_FAILED_CLICK;
    }
    notifyListeners();
  }

  void _articlesReleaseRecordErrorCallBack(errorMsg, ListPageModel pageModel) {
    LogUtils.printLog('接口返回失败');
    pageModel.listPage.listState = ListState.HINT_LOADED_FAILED_CLICK;
    notifyListeners();
  }

  ///
  /// 调用物品放行详情接口
  ///
  void getArticlesReleaseDetail(
    int id,
    ArticlesReleasePageModel pageModel, {
    VoidCallback callBack,
  }) async {
    pageModel.pageState = ListState.HINT_LOADING;
    notifyListeners();
    Map<String, dynamic> params = new Map();
    params['releasePassId'] = id;
    String jsonData = json.encode(params);

    HttpUtil.post(
        HttpOptions.articlesReleaseDetailUrl,
        (data) {
          _articlesReleaseDetailCallBack(data, pageModel);
        },
        jsonData: jsonData,
        errorCallBack: (errorMsg) {
          _articlesReleaseDetailErrorCallBack(errorMsg, pageModel);
        });
  }

  void _articlesReleaseDetailCallBack(data, ArticlesReleasePageModel pageModel) {
    ArticlesReleaseDetailModel model = ArticlesReleaseDetailModel.fromJson(data);
    LogUtils.printLog('物品放行详情:${json.encode(data)}');
    if (model.code == '0') {
      pageModel.articlesReleaseDetail = model.articlesReleaseDetail;
      pageModel.pageState = ListState.HINT_DISMISS;
    } else {
      pageModel.pageState = ListState.HINT_LOADED_FAILED_CLICK;
//      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
    }
    notifyListeners();
  }

  void _articlesReleaseDetailErrorCallBack(errorMsg, ArticlesReleasePageModel pageModel) {
    LogUtils.printLog('接口返回失败');
    pageModel.pageState = ListState.HINT_LOADED_FAILED_CLICK;
    notifyListeners();
  }

  ///
  /// 物品放行修改状态
  /// [passFlag] 审核状态（业主审核） 0-不通过、1-通过
  ///
  void changeArticleReleaseStatus(
    int id,
    String processNodeCode, {
    String passFlag,
    String remark,
    List attWpSignList,
    VoidCallback callBack,
  }) async {
    CommonToast.show();

    Map<String, dynamic> params = new Map();
    params['releasePassId'] = id;
    params['operateStep'] = processNodeCode;
    if (processNodeCode == articleReleaseYZSH) {
      params['status'] = passFlag;
      params['remark'] = remark;
      if(passFlag == '1')
      params['attWpSignList'] = attWpSignList;
    }

    HttpUtil.post(
        HttpOptions.changeArticlesReleaseStatusUrl,
        (data) {
          _changeArticleReleaseStatusCallBack(data, callBack: callBack);
        },
        jsonData: json.encode(params),
        errorCallBack: (errorMsg) {
          _changeArticleReleaseStatusErrorCallBack(errorMsg);
        });
  }

  void _changeArticleReleaseStatusCallBack(data, {VoidCallback callBack}) {
    CommonResultModel model = CommonResultModel.fromJson(data);
    LogUtils.printLog('物品放行修改状态:${json.encode(data)}');
    if (model.code == '0') {
      CommonToast.show(msg: '提交成功', type: ToastIconType.SUCCESS);
      navigatorKey.currentState.pop(true);
      if (callBack != null) callBack();
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
      CommonToast.show(msg: failedDescri, type: ToastIconType.FAILED);
    }
//    notifyListeners();
  }

  void _changeArticleReleaseStatusErrorCallBack(errorMsg) {
    LogUtils.printLog('物品放行修改状态接口返回失败');
    CommonToast.show(msg: errorMsg, type: ToastIconType.FAILED);
//    notifyListeners();
  }

  static ArticlesReleaseStateModel of(context) => ScopedModel.of<ArticlesReleaseStateModel>(context);
}
