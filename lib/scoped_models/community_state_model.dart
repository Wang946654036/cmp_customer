import 'dart:convert';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/common/common_page_model.dart';
import 'package:cmp_customer/models/common_result_model.dart';
import 'package:cmp_customer/models/community_activity_model.dart';
import 'package:cmp_customer/models/market/ware_detail_model.dart';
import 'package:cmp_customer/models/market/ware_list_response.dart';
import 'package:cmp_customer/models/pgc/pgc_infomation_list.dart';
import 'package:cmp_customer/models/pgc/pgc_infomation_obj.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/failed_code_trans.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:scoped_model/scoped_model.dart';

mixin CommunityStateModel on Model {
  List<ActivityInfo> activityHomePageList; //首页五条社区活动
  List<ActivityInfo> voteHomePageList; //首页三条投票
  List<ActivityInfo> questionnaireHomePageList; //首页三条问卷调查
  List<PgcInfomationInfo> pgcHomePageList; //首页三条社区资讯即pgc
  List<WareDetailModel> marketHomePageList; //首页三条集市
  bool marketAutoPlay = false; //集市是否自动滚动
  bool pgcAutoPlay = false; //pgc是否自动滚动
//  bool communityActivityAutoPlay = false; //社区活动是否自动滚动
  bool voteAutoPlay = false; //投票是否自动滚动
  bool questionnaireAutoPlay = false; //问卷调查是否自动滚动

  ///
  /// 社区活动列表（问卷调查、投票、活动报名）
  /// [activityType]活动类型：1=问卷调查 2=投票 3=活动报名
  ///
  void loadCommunityActivityList(ListPageModel pageModel, int activityType,
      {int findType = 0, bool preRefresh = false}) {
    pageModel.listPage.listState = ListState.HINT_LOADING;
    if (preRefresh) notifyListeners();
    pageModel.listPage.currentPage = 1;
    pageModel.listPage.maxCount = false;
    pageModel.list.clear();
    _getCommunityActivityList(pageModel, findType, activityType);
  }

//  Future<void> taskHandleRefresh({@required TaskPageController controller, bool preRefresh = false}) async {
//    loadTaskList(controller:controller,preRefresh: preRefresh);
//  }

  communityActivityHandleLoadMore(ListPageModel pageModel, int findType, int activityType) {
    pageModel.listPage.currentPage++;
    if (!pageModel.listPage.maxCount) {
      _getCommunityActivityList(pageModel, findType, activityType);
    }
  }

  _getCommunityActivityList(ListPageModel pageModel, int findType, int activityType) async {
    Map<String, dynamic> params = new Map();
    params['current'] = pageModel.listPage.currentPage;
    params['pageSize'] = HttpOptions.pageSize.toString();
    params['findType'] = findType;
    params['activityType'] = activityType;
    String jsonData = json.encode(params);

    HttpUtil.post(
        HttpOptions.communityActivityListUrl,
        (data) {
          _communityActivityListCallBack(data, pageModel);
        },
        jsonData: jsonData,
        errorCallBack: (errorMsg) {
          _communityActivityListErrorCallBack(errorMsg, pageModel);
        });
  }

  void _communityActivityListCallBack(data, ListPageModel pageModel) {
    CommunityActivityModel model = CommunityActivityModel.fromJson(data);
    LogUtils.printLog('社区活动列表（问卷调查、投票、活动报名）:$data');
    if (model.code == '0') {
      if (model.activityList != null && model.activityList.length > 0) {
        pageModel.listPage.listState = ListState.HINT_DISMISS;
        if (pageModel.listPage.currentPage == 1) {
          //刷新操作，清空数据再添加（防止多次刷新请求导致数据重复添加）
          pageModel.list.clear();
        }
        pageModel.list.addAll(model.activityList);
        if (model.activityList.length < HttpOptions.pageSize) pageModel.listPage.maxCount = true;
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
      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
      pageModel.listPage.listState = ListState.HINT_LOADED_FAILED_CLICK;
    }
    notifyListeners();
  }

  void _communityActivityListErrorCallBack(errorMsg, ListPageModel pageModel) {
    LogUtils.printLog('接口返回失败');
    pageModel.listPage.listState = ListState.HINT_LOADED_FAILED_CLICK;
    notifyListeners();
  }

  ///
  /// 首页查询社区活动
  ///
  getCommunityActivityListOnHomePage({Function callback}) async {
    if (activityHomePageList == null) activityHomePageList = List();
    else activityHomePageList.clear();
    notifyListeners();
    Map<String, dynamic> params = new Map();
    params['current'] = 1;
    params['pageSize'] = 5;
    params['findType'] = 0; //查询类别:0=查询全部
    params['activityType'] = 3; //活动类型：3=活动报名
    String jsonData = json.encode(params);

    HttpUtil.post(
        HttpOptions.communityActivityListUrl,
        (data) {
          _communityActivityListOnHomePageCallBack(data, callback: callback);
        },
        jsonData: jsonData,
        errorCallBack: (errorMsg) {
          _communityActivityListOnHomePageErrorCallBack(errorMsg, callback: callback);
        });
  }

  void _communityActivityListOnHomePageCallBack(data, {Function callback}) {
    CommunityActivityModel model = CommunityActivityModel.fromJson(data);
    LogUtils.printLog('活动报名列表首页五条:$data');
    if (model.code == '0') {
      if (model.activityList != null && model.activityList.length > 0) {
        if (activityHomePageList == null) activityHomePageList = List();
        else activityHomePageList.clear();
        activityHomePageList.addAll(model.activityList);
      } else {
        if (activityHomePageList != null) activityHomePageList.clear();
      }
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
      LogUtils.printLog('活动报名列表首页五条：$failedDescri');
      if (activityHomePageList != null) activityHomePageList.clear();
    }
    notifyListeners();
  }

  void _communityActivityListOnHomePageErrorCallBack(errorMsg, {Function callback}) {
    LogUtils.printLog('接口返回失败');
    if (callback != null) callback();
    notifyListeners();
  }

  ///
  /// 首页查询投票
  ///
  getVoteListOnHomePage({Function callback}) async {
    voteAutoPlay = false;
    if (voteHomePageList == null) voteHomePageList = List();
    else voteHomePageList.clear();
    notifyListeners();
    Map<String, dynamic> params = new Map();
    params['current'] = 1;
    params['pageSize'] = 3;
    params['findType'] = 0; //查询类别:0=查询全部
    params['activityType'] = 2; //活动类型：2=投票
    String jsonData = json.encode(params);

    HttpUtil.post(
        HttpOptions.communityActivityListUrl,
        (data) {
          _communityVoteListOnHomePageCallBack(data, callback: callback);
        },
        jsonData: jsonData,
        errorCallBack: (errorMsg) {
          _communityVoteListOnHomePageErrorCallBack(errorMsg, callback: callback);
        });
  }

  void _communityVoteListOnHomePageCallBack(data, {Function callback}) {
    voteAutoPlay = false;
    CommunityActivityModel model = CommunityActivityModel.fromJson(data);
    LogUtils.printLog('投票列表首页三条:$data');
    if (model.code == '0') {
      if (model.activityList != null && model.activityList.length > 0) {
        if (voteHomePageList == null) voteHomePageList = List();
        else voteHomePageList.clear();
        voteHomePageList.addAll(model.activityList);
        if (voteHomePageList.length > 1)
          voteAutoPlay = true;
        else
          voteAutoPlay = false;
      } else {
        voteAutoPlay = false;
        if (voteHomePageList != null) voteHomePageList.clear();
      }
    } else {
      voteAutoPlay = false;
      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
      LogUtils.printLog('投票列表首页三条：$failedDescri');
      if (voteHomePageList != null) voteHomePageList.clear();
    }
    notifyListeners();
  }

  void _communityVoteListOnHomePageErrorCallBack(errorMsg, {Function callback}) {
    if (voteHomePageList != null && voteHomePageList.length > 1)
      voteAutoPlay = true;
    else
      voteAutoPlay = false;
    LogUtils.printLog('投票列表首页三条接口返回失败：$errorMsg');
    if (callback != null) callback();
    notifyListeners();
  }

  ///
  /// 首页查询问卷调查
  ///
  getQuestionnaireListOnHomePage({Function callback}) async {
    questionnaireAutoPlay = false;
    if (questionnaireHomePageList == null) questionnaireHomePageList = List();
    else questionnaireHomePageList.clear();
    notifyListeners();
    Map<String, dynamic> params = new Map();
    params['current'] = 1;
    params['pageSize'] = 3;
    params['findType'] = 0; //查询类别:0=查询全部
    params['activityType'] = 1; //活动类型：1=问卷调查
    String jsonData = json.encode(params);

    HttpUtil.post(
        HttpOptions.communityActivityListUrl,
        (data) {
          _communityQuestionnaireListOnHomePageCallBack(data, callback: callback);
        },
        jsonData: jsonData,
        errorCallBack: (errorMsg) {
          _communityQuestionnaireListOnHomePageErrorCallBack(errorMsg, callback: callback);
        });
  }

  void _communityQuestionnaireListOnHomePageCallBack(data, {Function callback}) {
    CommunityActivityModel model = CommunityActivityModel.fromJson(data);
    LogUtils.printLog('问卷调查列表首页三条:$data');
    if (model.code == '0') {
      if (model.activityList != null && model.activityList.length > 0) {
        if (questionnaireHomePageList == null) questionnaireHomePageList = List();
        else questionnaireHomePageList.clear();
        questionnaireHomePageList.addAll(model.activityList);
        if (questionnaireHomePageList.length > 1)
          questionnaireAutoPlay = true;
        else
          questionnaireAutoPlay = false;
      } else {
        questionnaireAutoPlay = false;
        if (questionnaireHomePageList != null) questionnaireHomePageList.clear();
      }
    } else {
      questionnaireAutoPlay = false;
      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
      LogUtils.printLog('问卷调查列表首页三条：$failedDescri');
      if (questionnaireHomePageList != null) questionnaireHomePageList.clear();
    }
    notifyListeners();
  }

  void _communityQuestionnaireListOnHomePageErrorCallBack(errorMsg, {Function callback}) {
    if (questionnaireHomePageList != null && questionnaireHomePageList.length > 1)
      questionnaireAutoPlay = true;
    else
      questionnaireAutoPlay = false;
    LogUtils.printLog('问卷调查列表首页三条接口返回失败：$errorMsg');
    if (callback != null) callback();
    notifyListeners();
  }

  //社区资讯即pgc列表首页三条
  getPgcInformationListOnHomePage() {
    pgcAutoPlay = false;
    if (pgcHomePageList == null) pgcHomePageList = List();
    else pgcHomePageList.clear();
    notifyListeners();
    Map<String, dynamic> params = {
      "pageSize": 3,
      "current": 1,
      "custProjectId": stateModel.defaultProjectId,
      "searchType": '1', //按时间排序
    };
    LogUtils.printLog(json.encode(params));
    HttpUtil.post(HttpOptions.findCustomerPgcPage, _getPgcListCallBack,
        jsonData: json.encode(params), errorCallBack: _getPgcListErrorCallBack);
  }

  _getPgcListCallBack(data) {
    PgcInfomationList infos;
    LogUtils.printLog('社区资讯即pgc列表首页三条:$data');
    try {
      infos = PgcInfomationList.fromJson(data);
    } catch (e) {
      infos = new PgcInfomationList(code: '0');
    }
    if (infos.code == '0') {
      if (infos.pgcInfomationInfoList != null && infos.pgcInfomationInfoList.length > 0) {
        if (pgcHomePageList == null) pgcHomePageList = List();
        else pgcHomePageList.clear();
        pgcHomePageList.addAll(infos.pgcInfomationInfoList);
        if (pgcHomePageList.length > 1)
          pgcAutoPlay = true;
        else
          pgcAutoPlay = false;
      } else {
        pgcAutoPlay = false;
        if (pgcHomePageList != null) pgcHomePageList.clear();
      }
    } else {
      pgcAutoPlay = false;
      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: infos.code.toString(), failMsg: infos.message);
      if (pgcHomePageList != null) pgcHomePageList.clear();
      LogUtils.printLog('社区资讯即pgc列表首页三条失败:' + failedDescri);
    }
    notifyListeners();
  }

  void _getPgcListErrorCallBack(errorMsg) {
    if (pgcHomePageList != null && pgcHomePageList.length > 1)
      pgcAutoPlay = true;
    else
      pgcAutoPlay = false;
    LogUtils.printLog('社区资讯即pgc列表首页三条接口返回失败：$errorMsg');
    notifyListeners();
  }

  //集市列表首页三条
  getMarketListOnHomePage() {
    marketAutoPlay = false;
    if (marketHomePageList == null) marketHomePageList = List();
    else marketHomePageList.clear();
    notifyListeners();
    Map<String, dynamic> params = {
      "pageSize": 3,
      "current": 1,
      "projectId": stateModel.defaultProjectId,
      "regionFlag": 1, //如果是0，则代表“四合院”，如果是1，则代表“同城汇”，如果是2，则代表“本社区”,首页使用1同城汇
//      "projectId":stateModel.defaultProjectId,
    };
    LogUtils.printLog(json.encode(params));
    HttpUtil.post(HttpOptions.findWaresPage, _getMarketListCallBack,
        jsonData: json.encode(params), errorCallBack: _getMarketListErrorCallBack);
  }

  _getMarketListCallBack(data) {
    try {
      WareListResponse infos = WareListResponse.fromJson(data);
      LogUtils.printLog('集市列表首页三条:$data');
      if (infos.success()) {
        if (infos.data != null && infos.data.length > 0) {
          if (marketHomePageList == null) marketHomePageList = List();
          else marketHomePageList.clear();
          marketHomePageList.addAll(infos.data);
          if (marketHomePageList.length > 1)
            marketAutoPlay = true;
          else
            marketAutoPlay = false;
        } else {
          marketAutoPlay = false;
          if (marketHomePageList != null) marketHomePageList.clear();
        }
      } else {
        marketAutoPlay = false;
        String failedDescri =
            FailedCodeTrans.enTochsTrans(failCode: infos.code.toString(), failMsg: infos.message);
        if (marketHomePageList != null) marketHomePageList.clear();
        LogUtils.printLog('集市列表首页三条失败:' + failedDescri);
      }
      notifyListeners();
    } catch (e) {
      LogUtils.printLog('集市列表首页三条解析错误:$data');
      _getMarketListErrorCallBack("集市列表首页三条解析错误");
    }
  }

  void _getMarketListErrorCallBack(errorMsg) {
    if (marketHomePageList != null && marketHomePageList.length > 1)
      marketAutoPlay = true;
    else
      marketAutoPlay = false;
    LogUtils.printLog('集市列表首页三条接口返回失败：$errorMsg');
    notifyListeners();
  }

  ///
  /// 社区活动获取活动详情的H5授权访问接口
  ///
  void communityActivityGetH5(
    int id, {
    Function callBack,
  }) async {
    CommonToast.show(msg: '加载中');
    Map<String, dynamic> params = new Map();
    params['id'] = id;
    String jsonData = json.encode(params);

    HttpUtil.post(
        HttpOptions.communityActivityGetH5Url,
        (data) {
          _communityActivityGetH5CallBack(data, callback: callBack);
        },
        jsonData: jsonData,
        errorCallBack: (errorMsg) {
          _communityActivityGetH5ErrorCallBack(errorMsg);
        });
  }

  void _communityActivityGetH5CallBack(data, {Function callback}) {
    CommonResultModel model = CommonResultModel.fromJson(data);
    LogUtils.printLog('社区活动获取活动详情的H5授权访问:${json.encode(data)}');
    if (model.code == '0' && model.data != null && model.data.isNotEmpty) {
      CommonToast.dismiss();
      if (callback != null) callback(model.data);
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
      CommonToast.show(msg: failedDescri, type: ToastIconType.FAILED);
    }
  }

  void _communityActivityGetH5ErrorCallBack(errorMsg) {
    LogUtils.printLog('接口返回失败');
    CommonToast.show(msg: errorMsg, type: ToastIconType.FAILED);
  }

  static CommunityStateModel of(context) => ScopedModel.of<CommunityStateModel>(context);
}

class RequestBody {
  var body;

  RequestBody(this.body);

  dynamic toJson() => {
        'body': body,
      };
}
