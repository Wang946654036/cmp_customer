import 'dart:convert';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/common/common_page_model.dart';
import 'package:cmp_customer/models/common_result_model.dart';
import 'package:cmp_customer/models/community_certified_model.dart';
import 'package:cmp_customer/models/house_all_model.dart';
import 'package:cmp_customer/models/house_detail_model.dart';
import 'package:cmp_customer/models/house_list_model.dart';
import 'package:cmp_customer/models/tourist_account_status_model.dart';
import 'package:cmp_customer/models/uncertified_community_model.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/strings/strings_house_auth.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/house_authentication/house_auth_page.dart';
import 'package:cmp_customer/ui/house_authentication/house_detail_page.dart';
import 'package:cmp_customer/ui/house_authentication/my_house_page.dart';
import 'package:cmp_customer/ui/house_authentication/select_house_content.dart';
import 'package:cmp_customer/ui/house_authentication/select_house_page.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/failed_code_trans.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/shared_preferences_key.dart';
import 'package:scoped_model/scoped_model.dart';

mixin HouseStateModel on Model {
  ///
  /// 所有房屋(游客返回认证中的房屋 客户返回已经认证的房屋)
  ///  返回码 251:游客没有房屋认证记录; 252:游客有房屋认证记录; 253:客户有房屋认证记录; 254:客户没有房屋认证记录（显示暂无数据）
  ///
  Future<void> getAllHouseData(ListPageModel listPageModel, {Function callBack, bool preRefresh = false}) async {
    listPageModel.listPage.listState = ListState.HINT_LOADING;
    if (preRefresh) notifyListeners();
    if (listPageModel.list != null) listPageModel.list.clear();
    await HttpUtil.post(
        HttpOptions.allHouseUrl, (data) => _allHouseDataCallBack(data, listPageModel, callBack: callBack),
        errorCallBack: (errorMsg) => _allHouseDataErrorCallBack(errorMsg, listPageModel, callBack: callBack));
  }

  void _allHouseDataCallBack(data, ListPageModel listPageModel, {Function callBack}) async {
    LogUtils.printLog('所有房屋:$data');
    HouseAllModel model = HouseAllModel.fromJson(data);
    if (model.code == '253') {
      //客户（已有认证过的房屋）
      if (model?.houseData?.houseCertifiedList != null && model.houseData.houseCertifiedList.length > 0) {
        if (model.houseData.houseCertifiedList.every((HouseCertified info) => info.isDefaultHouse == '0')) {
          //如果custId是空先重新登录
          if (stateModel.customerId == null) {
            stateModel.reLogin(callBack: () {
              stateModel.changeDefaultHouse(model.houseData.houseCertifiedList[0].houseId, showLoadingToast: false,
                  callBack: () {
                getAllHouseData(listPageModel, callBack: callBack, preRefresh: true);
                stateModel.reLogin();
              });
            });
          } else {
            //没有默认房屋要调用接口设置一个默认房屋，再重新登录
            stateModel.changeDefaultHouse(model.houseData.houseCertifiedList[0].houseId, showLoadingToast: false,
                callBack: () {
              getAllHouseData(listPageModel, callBack: callBack, preRefresh: true);
              stateModel.reLogin();
            });
          }
        } else {
          model.houseData.houseCertifiedList.forEach((HouseCertified info) {
            info.houseType = HouseType.Certified;
            info.auditStatus = houseAuditSuccess;
            listPageModel.list.add(info);
          });
          //排序，把默认房屋置顶
          listPageModel?.list?.sort((a, b) => b.isDefaultHouse.compareTo(a.isDefaultHouse));
          //有已认证过的房屋，但是用户信息还是游客要重新登录刷新状态
          if (stateModel.customerType == 1) {
            stateModel.reLogin();
          }
        }
      }
      if (model?.houseData?.houseCertificatingList != null && model.houseData.houseCertificatingList.length > 0) {
        model.houseData.houseCertificatingList.forEach((HouseCertificating info) {
          info.houseType = HouseType.Certificating;
          listPageModel.list.add(info);
        });
      }
      listPageModel.listPage.listState = ListState.HINT_DISMISS;
      listPageModel.listPage.tag = model.code;
      if (callBack != null) callBack();
    } else if (model.code == '254') {
      //客户没有已认证房屋记录
      if (model?.houseData?.houseCertificatingList != null && model.houseData.houseCertificatingList.length > 0) {
        listPageModel.listPage.listState = ListState.HINT_DISMISS;
        model.houseData.houseCertificatingList.forEach((HouseCertificating info) {
          info.houseType = HouseType.Certificating;
          listPageModel.list.add(info);
        });
      } else {
        listPageModel.listPage.listState = ListState.HINT_NO_DATA_CLICK;
      }
      listPageModel.listPage.tag = model.code;
    } else if (model.code == '252') {
      //游客有房屋认证记录
      if (model?.houseData?.houseCertificatingList != null && model.houseData.houseCertificatingList.length > 0) {
        model.houseData.houseCertificatingList.forEach((HouseCertificating info) {
          info.houseType = HouseType.Certificating;
          listPageModel.list.add(info);
        });
      }
      listPageModel.listPage.listState = ListState.HINT_DISMISS;
      listPageModel.listPage.tag = model.code;
    } else if (model.code == '251') {
      //游客没有房屋认证记录
      listPageModel.listPage.listState = ListState.HINT_DISMISS;
      listPageModel.listPage.tag = model.code;
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
      if (callBack != null) callBack(errorMsg: failedDescri);
      listPageModel.listPage.listState = ListState.HINT_LOADED_FAILED_CLICK;
//      CommonToast.show(type: ToastIconType.FAILED, msg: failedDescri);
    }
    notifyListeners();
  }

  void _allHouseDataErrorCallBack(String errorMsg, ListPageModel listPageModel, {Function callBack}) {
    LogUtils.printLog('接口返回失败：$errorMsg');
//    CommonToast.show(type: TipDialogType.FAIL, msg: errorMsg);
    listPageModel.listPage.listState = ListState.HINT_LOADED_FAILED_CLICK;
    if (callBack != null) callBack(errorMsg: errorMsg);
//    CommonToast.show(type: ToastIconType.FAILED, msg: errorMsg);
    notifyListeners();
  }

  ///
  /// 房屋详情
  /// 若是待审核或者审核失败必填参数:[houseCustAuditId]
  /// 若是已认证必填参数:[custHouseRelationId]
  ///
  void getHouseDetail(int custHouseRelationId, int houseCustAuditId, HouseDetailPageModel pageModel,
      {Function callBack}) async {
    pageModel.pageState = ListState.HINT_LOADING;
    notifyListeners();
    String jsonData = json.encode({
      '${custHouseRelationId != null ? 'custHouseRelationId' : 'houseCustAuditId'}':
          custHouseRelationId != null ? custHouseRelationId : houseCustAuditId
    });

    HttpUtil.post(
        HttpOptions.houseCertifiedDetailUrl, (data) => _houseDetailCallBack(data, pageModel, callBack: callBack),
        jsonData: jsonData,
        errorCallBack: (errorMsg) => _houseDetailErrorCallBack(errorMsg, pageModel, callBack: callBack));
  }

  void _houseDetailCallBack(data, HouseDetailPageModel pageModel, {Function callBack}) async {
    LogUtils.printLog('房屋详情:${json.encode(data)}');
    HouseDetailModel model = HouseDetailModel.fromJson(data);
    if (model.code == '0') {
//      pageModel.houseDetail = model.houseDetail;
      pageModel.pageState = ListState.HINT_DISMISS;
      if (model?.houseDetail?.certifiedHouseInfo != null) {
        pageModel.houseInfo = model.houseDetail.certifiedHouseInfo;
        pageModel.houseInfo.auditStatus = houseAuditSuccess;
      } else {
        pageModel.houseInfo = model.houseDetail.unCertifiedHouseInfo;
      }
      if (model?.houseDetail?.memberList != null && model.houseDetail.memberList.length > 0) {
        if (pageModel.memberList == null) pageModel.memberList = List();
        pageModel.memberList = model.houseDetail.memberList;
        pageModel.memberPageState = ListState.HINT_DISMISS;
      } else {
        pageModel.memberPageState = ListState.HINT_NO_DATA_CLICK;
      }
    } else {
//      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
//      if (callBack != null) callBack(errorMsg: failedDescri);
//      CommonToast.show(type: ToastIconType.FAILED, msg: failedDescri);
      pageModel.pageState = ListState.HINT_LOADED_FAILED_CLICK;
    }
    notifyListeners();
  }

  void _houseDetailErrorCallBack(String errorMsg, HouseDetailPageModel pageModel, {Function callBack}) {
    LogUtils.printLog('接口返回失败：$errorMsg');
//    CommonToast.show(type: TipDialogType.FAIL, msg: errorMsg);
//    if (callBack != null) callBack(errorMsg: errorMsg);
    pageModel.pageState = ListState.HINT_LOADED_FAILED_CLICK;
//    CommonToast.show(type: ToastIconType.FAILED, msg: errorMsg);
    notifyListeners();
  }

  ///
  /// 游客手机号/证件匹配客户：450未匹配到客户 451:匹配到客户未关联账号 452:匹配到客户且关联账号
  /// [documentType]证件类型，[documentNo]证件号
  ///
  void getTouristAccountStatus({String documentType, String documentNo, Function callBack}) async {
    CommonToast.show(msg: '查询中', type: ToastIconType.LOADING);
    String jsonData;

    if (documentNo != null && documentNo.isNotEmpty) {
      jsonData = json.encode({'custIdNum': documentNo, 'idTypeId': documentType, 'checkHouse': 1});
    } else {
      jsonData = json.encode({'checkHouse': 1});
    }

    HttpUtil.post(
        HttpOptions.getTouristAccountStatusUrl, (data) => _touristAccountStatusCallBack(data, callBack: callBack),
        jsonData: jsonData,
        errorCallBack: (errorMsg) => _touristAccountStatusErrorCallBack(errorMsg, callBack: callBack));
  }

  void _touristAccountStatusCallBack(data, {Function callBack}) async {
    try {
      LogUtils.printLog('游客手机号/证件匹配客户:$data');
      TouristAccountStatusModel model = TouristAccountStatusModel.fromJson(data);
      if (model.code == '450' || model.code == '451' || model.code == '452') {
        CommonToast.dismiss();
        if (callBack != null)
//        if(model.code == '452')
          callBack(
              message: model.code,
              mobile: model?.data?.touristAccountStatusList?.first?.mobile,
              list: model?.data?.customerList);
      } else {
        String failedDescri =
            FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
//      if (callBack != null) callBack(errorMsg: failedDescri);
        CommonToast.show(type: ToastIconType.FAILED, msg: failedDescri);
      }
    } catch (e) {
//      LogUtils.printLog('11111111111111:$e');
//      String failedDescri = FailedCodeTrans.enTochsTrans(failMsg: e.toString());
////      if (callBack != null) callBack(errorMsg: failedDescri);
      CommonToast.show(type: ToastIconType.FAILED, msg: '数据出错，请联系管理员');
    } finally {
      notifyListeners();
    }
  }

  void _touristAccountStatusErrorCallBack(String errorMsg, {Function callBack}) {
    LogUtils.printLog('接口返回失败：$errorMsg');
//    if (callBack != null) callBack(errorMsg: errorMsg);
    CommonToast.show(type: ToastIconType.FAILED, msg: errorMsg);
    notifyListeners();
  }

  ///
  /// 获取房号信息：楼栋、单元、房号
  ///
  void getHouseList(int id, HouseAddrPageModel pageModel, {Function callBack}) async {
    pageModel.houseListState = ListState.HINT_LOADING;
    notifyListeners();
    String idStr;
    String url;
    switch (pageModel.houseAddrType) {
      case HouseAddrType.Building:
        url = HttpOptions.buildingListByProjectUrl;
        idStr = 'projectId';
        break;
      case HouseAddrType.Unit:
        url = HttpOptions.unitListByBuildingUrl;
        idStr = 'buildId';
        break;
      case HouseAddrType.Room:
        url = HttpOptions.roomListByUnitUrl;
        idStr = 'unitId';
        break;
    }
    String jsonData = json.encode({idStr: id});
    HttpUtil.post(url, (data) => _houseListCallBack(data, pageModel, callBack: callBack),
        jsonData: jsonData,
        errorCallBack: (errorMsg) => _houseListErrorCallBack(errorMsg, pageModel, callBack: callBack));
  }

  void _houseListCallBack(data, HouseAddrPageModel pageModel, {Function callBack}) async {
    LogUtils.printLog('房屋列表:$data');
    HouseListModel model = HouseListModel.fromJson(data);
    if (model.code == '0') {
      if (pageModel.houseListCreate == false && pageModel.dataList.isNotEmpty) {
        //false时要取出最后一条taskDetail，重新赋值，true时直接add
        pageModel.dataList.last = model?.houseList ?? List();
      } else {
        List<HouseAddr> houseList = model?.houseList ?? List();
        pageModel.dataList.add(houseList);
        SelectHouseContent selectHouseContent = SelectHouseContent(houseList, pageModel);
        pageModel.contentPageList.add(selectHouseContent);
      }
      pageModel.houseListState = ListState.HINT_DISMISS;
      pageModel.houseListCreate = true;
    } else {
      pageModel.houseListState = ListState.HINT_LOADED_FAILED_CLICK;
      pageModel.houseListCreate = false;
//      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
    }
    notifyListeners();
  }

  void _houseListErrorCallBack(String errorMsg, HouseAddrPageModel pageModel, {Function callBack}) {
    LogUtils.printLog('接口返回失败：$errorMsg');
//    if (callBack != null) callBack(errorMsg: errorMsg);
    CommonToast.show(type: ToastIconType.FAILED, msg: errorMsg);
    pageModel.houseListState = ListState.HINT_LOADED_FAILED_CLICK;
    pageModel.houseListCreate = false;
    notifyListeners();
  }

  ///
  /// 游客人工认证/客户添加房屋
  ///
  void createHouse(CreateHouseModel houseModel, {Function callBack}) async {
    CommonToast.show(msg: '提交中', type: ToastIconType.LOADING);
    String jsonData = json.encode(houseModel);

    HttpUtil.post(HttpOptions.artificialAuthUrl, (data) => _createHouseCallBack(data, callBack: callBack),
        jsonData: jsonData, errorCallBack: (errorMsg) => _createHouseErrorCallBack(errorMsg, callBack: callBack));
  }

  void _createHouseCallBack(data, {Function callBack}) async {
    LogUtils.printLog('游客人工认证/客户添加房屋:$data');
    CommonResultModel model = CommonResultModel.fromJson(data);
    if (model.code == '0') {
      CommonToast.show(msg: '提交成功，我们会尽快为您处理', type: ToastIconType.SUCCESS);
      navigatorKey.currentState.pop(true);
//      if (callBack != null) callBack();
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
//      if (callBack != null) callBack(errorMsg: failedDescri);
      CommonToast.show(type: ToastIconType.FAILED, msg: failedDescri);
    }
    notifyListeners();
  }

  void _createHouseErrorCallBack(String errorMsg, {Function callBack}) {
    LogUtils.printLog('接口返回失败：$errorMsg');
//    if (callBack != null) callBack(errorMsg: errorMsg);
    CommonToast.show(type: ToastIconType.FAILED, msg: errorMsg);
    notifyListeners();
  }

  ///
  /// 游客自动认证
  ///
  void houseAutoAuth(String smsCode, {Function callBack}) async {
    CommonToast.show(msg: '提交中', type: ToastIconType.LOADING);
    String jsonData = json.encode({
      'code': smsCode,
      'mobile': stateModel.userAccount,
    });

    HttpUtil.post(HttpOptions.autoAuthUrl, (data) => _autoAuthCallBack(data, callBack: callBack),
        jsonData: jsonData, errorCallBack: (errorMsg) => _autoAuthErrorCallBack(errorMsg, callBack: callBack));
  }

  void _autoAuthCallBack(data, {Function callBack}) {
    LogUtils.printLog('游客自动认证:$data');
    UserDataModel model = UserDataModel.fromJson(data);
    if (model.code == '0') {
      stateModel.reLogin(callBack: ({errorMsg}) {
        CommonToast.dismiss();
        navigatorKey.currentState.pop(true);
      });
//      stateModel.clearAccessToken();
//      stateModel.getUserData(callBack: ({errorMsg}) {
//        CommonToast.dismiss();
//        navigatorKey.currentState.pop(true);
//      });
//      if (callBack != null) callBack();
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
//      if (callBack != null) callBack(errorMsg: failedDescri);
      CommonToast.show(type: ToastIconType.FAILED, msg: failedDescri);
    }
    notifyListeners();
  }

  void _autoAuthErrorCallBack(String errorMsg, {Function callBack}) {
    LogUtils.printLog('接口返回失败：$errorMsg');
//    if (callBack != null) callBack(errorMsg: errorMsg);
    CommonToast.show(type: ToastIconType.FAILED, msg: errorMsg);
    notifyListeners();
  }

  ///
  /// 房屋详情-迁出房屋成员
  ///
  void moveOutMember(int custHouseRelationId, {Function callBack}) async {
    CommonToast.show();
    String jsonData = json.encode({'custHouseRelationId': custHouseRelationId, 'custId': stateModel.customerId});

    HttpUtil.post(HttpOptions.moveOutUrl, (data) => _moveOutCallBack(data, callBack: callBack),
        jsonData: jsonData, errorCallBack: (errorMsg) => _moveOutErrorCallBack(errorMsg, callBack: callBack));
  }

  void _moveOutCallBack(data, {Function callBack}) async {
    LogUtils.printLog('房屋详情-迁出房屋成员:$data');
    CommonResultModel model = CommonResultModel.fromJson(data);
    if (model.code == '0') {
      CommonToast.dismiss();
//      navigatorKey.currentState.pop(true);
      if (callBack != null) callBack();
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
//      if (callBack != null) callBack(errorMsg: failedDescri);
      CommonToast.show(type: ToastIconType.FAILED, msg: failedDescri);
    }
    notifyListeners();
  }

  void _moveOutErrorCallBack(String errorMsg, {Function callBack}) {
    LogUtils.printLog('接口返回失败：$errorMsg');
//    if (callBack != null) callBack(errorMsg: errorMsg);
    CommonToast.show(type: ToastIconType.FAILED, msg: errorMsg);
    notifyListeners();
  }

  ///
  /// 有认证房屋的社区列表
  ///
  void getCommunityCertifiedList(ListPageModel listPageModel, {Function callBack}) async {
    listPageModel.listPage.listState = ListState.HINT_LOADING;
    notifyListeners();
    if (listPageModel.list != null) listPageModel.list.clear();
    String jsonData = json.encode({'custId': stateModel.customerId});
    HttpUtil.post(HttpOptions.certifiedCommunityListUrl,
        (data) => _communityCertifiedCallBack(data, listPageModel, callBack: callBack),
        jsonData: jsonData,
        errorCallBack: (errorMsg) =>
            _communityCertifiedErrorCallBack(errorMsg, listPageModel, callBack: callBack));
  }

  void _communityCertifiedCallBack(data, ListPageModel listPageModel, {Function callBack}) async {
    LogUtils.printLog('有认证房屋的社区列表:$data');
    CommunityCertifiedModel model = CommunityCertifiedModel.fromJson(data);
    if (model.code == '0') {
      if (model?.communityCertifiedList != null && model.communityCertifiedList.length > 0) {
        if (model.communityCertifiedList
            .every((CommunityCertified communityCertified) => communityCertified.isDefaultProject == '0')) {
          //没有默认社区要调用接口设置一个默认社区，再重新登录
          stateModel.changeDefaultCommunity(model.communityCertifiedList[0]?.projectId, showToast: false,
              callBack: () {
            getCommunityCertifiedList(listPageModel, callBack: callBack);
            stateModel.reLogin();
          });
        }
        listPageModel.list.addAll(model.communityCertifiedList);
      }
      listPageModel.listPage.listState = ListState.HINT_DISMISS;
      listPageModel.listPage.tag = model.code;
      if (callBack != null) callBack();
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
      if (callBack != null) callBack(errorMsg: failedDescri);
      listPageModel.listPage.listState = ListState.HINT_LOADED_FAILED_CLICK;
//      CommonToast.show(type: ToastIconType.FAILED, msg: failedDescri);
    }
    notifyListeners();
  }

  void _communityCertifiedErrorCallBack(String errorMsg, ListPageModel listPageModel, {Function callBack}) {
    LogUtils.printLog('接口返回失败：$errorMsg');
//    CommonToast.show(type: TipDialogType.FAIL, msg: errorMsg);
    listPageModel.listPage.listState = ListState.HINT_LOADED_FAILED_CLICK;
    if (callBack != null) callBack(errorMsg: errorMsg);
//    CommonToast.show(type: ToastIconType.FAILED, msg: errorMsg);
    notifyListeners();
  }

  ///
  /// 更换默认社区
  ///
  void changeDefaultCommunity(int projectId, {Function callBack, bool showToast = true}) async {
    if (showToast) CommonToast.show();
    String jsonData = json.encode({'custId': stateModel.customerId, 'projectId': projectId});

    HttpUtil.post(
        HttpOptions.changeDefaultCommunityUrl, (data) => _changeDefaultCommunityCallBack(data, callBack: callBack),
        jsonData: jsonData,
        errorCallBack: (errorMsg) => _changeDefaultCommunityErrorCallBack(errorMsg, callBack: callBack));
  }

  void _changeDefaultCommunityCallBack(data, {Function callBack}) async {
    LogUtils.printLog('更换默认社区:$data');
    CommonResultModel model = CommonResultModel.fromJson(data);
    if (model.code == '0') {
      CommonToast.dismiss();
//      navigatorKey.currentState.pop(true);
      if (callBack != null) callBack();
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
//      if (callBack != null) callBack(errorMsg: failedDescri);
      CommonToast.show(type: ToastIconType.FAILED, msg: failedDescri);
    }
    notifyListeners();
  }

  void _changeDefaultCommunityErrorCallBack(String errorMsg, {Function callBack}) {
    LogUtils.printLog('接口返回失败：$errorMsg');
//    if (callBack != null) callBack(errorMsg: errorMsg);
    CommonToast.show(type: ToastIconType.FAILED, msg: errorMsg);
    notifyListeners();
  }

//  ///
//  ///设置未认证的社区，缓存本地
//  ///
//  void setUncertifiedCommunity(int projectId, String projectName) async {
//    SharedPreferences prefs = await SharedPreferencesKey.globalPrefs;
////    prefs.setString(SharedPreferencesKey.KEY_UNCERTIFIED_COMMUNITY, null); //测试数据
//    String jsonCommunity = prefs.getString(SharedPreferencesKey.KEY_UNCERTIFIED_COMMUNITY);
//    UncertifiedCommunityModel model = UncertifiedCommunityModel();
//    bool saved = false; //是否保存过这个社区
//    if (jsonCommunity != null && jsonCommunity.isNotEmpty) {
//      model = UncertifiedCommunityModel.fromJson(json.decode(jsonCommunity));
//      if (model.uncertifiedCommunityList != null && model.uncertifiedCommunityList.length > 0) {
//        model.uncertifiedCommunityList.forEach((UncertifiedCommunity data) {
//          if (projectId == data.projectId) {
//            saved = true;
//            data.isDefault = true;
//          } else {
//            data.isDefault = false;
//          }
//        });
//      }
//    }
//    if (!saved) {
//      UncertifiedCommunity community = UncertifiedCommunity();
//      community.projectId = projectId;
//      stateModel.defaultProjectId = projectId;
//      community.projectName = projectName;
//      stateModel.defaultProjectName = projectName;
//      community.isDefault = true;
////    stateModel.customerType = 1;
//      stateModel.defaultBuildingName = null;
//      stateModel.defaultUnitName = null;
//      stateModel.defaultHouseName = null;
//      stateModel.defaultHouseId = null;
//      if (model.uncertifiedCommunityList == null) model.uncertifiedCommunityList = List();
//      model.uncertifiedCommunityList.add(community);
//    }
//    stateModel.uncertifiedCommunityList = model.uncertifiedCommunityList;
//    saveUnCertifiedCommunity();
//    notifyListeners();
//  }

  ///
  /// 设置全部未认证社区为非默认
  ///
  void setUncertifiedCommunityFalse() {
    if (stateModel.uncertifiedCommunityList != null && stateModel.uncertifiedCommunityList.length > 0) {
      stateModel.uncertifiedCommunityList.forEach((UncertifiedCommunity community) {
        community.isDefault = false;
      });
    }
    saveUnCertifiedCommunity();
  }

  //保存未认证房屋的社区列表到SharedPreferences中
  void saveUnCertifiedCommunity() async {
    SharedPreferences prefs = await SharedPreferencesKey.globalPrefs;
    String jsonCommunity = prefs.getString(SharedPreferencesKey.KEY_UNCERTIFIED_COMMUNITY);
    UncertifiedCommunityModel model;
    if (jsonCommunity != null && jsonCommunity.isNotEmpty) {
      model = UncertifiedCommunityModel.fromJson(json.decode(jsonCommunity));
    }
    if (model == null) model = UncertifiedCommunityModel();
    UncertifiedCommunityList uncertifiedCommunityInfo = model?.list?.firstWhere(
        (UncertifiedCommunityList info) => info?.account == stateModel.userAccount,
        orElse: () => null);

    if (uncertifiedCommunityInfo == null) {
      uncertifiedCommunityInfo = UncertifiedCommunityList();
      uncertifiedCommunityInfo.account = stateModel.userAccount;
      if (uncertifiedCommunityInfo?.uncertifiedCommunityList == null)
        uncertifiedCommunityInfo?.uncertifiedCommunityList = List();
    } else {
      model.list?.remove(uncertifiedCommunityInfo);
    }
    if (uncertifiedCommunityInfo?.uncertifiedCommunityList == null)
      uncertifiedCommunityInfo?.uncertifiedCommunityList = List();
    else
      uncertifiedCommunityInfo?.uncertifiedCommunityList?.clear();
//    LogUtils.printLog('uncertifiedCommunityList:${stateModel.uncertifiedCommunityList}');
    uncertifiedCommunityInfo?.uncertifiedCommunityList?.addAll(stateModel.uncertifiedCommunityList);
    if (model?.list == null) model?.list = List();
    model.list?.add(uncertifiedCommunityInfo);
    prefs.setString(SharedPreferencesKey.KEY_UNCERTIFIED_COMMUNITY, json.encode(model));
  }

  void resetUnCertifiedCommunity() {
    stateModel.uncertifiedCommunityList = null;
    saveUnCertifiedCommunity();
  }

  ///
  /// 房屋详情-更换默认房屋
  ///
  void changeDefaultHouse(int houseId, {Function callBack, bool showLoadingToast = true}) async {
    if (showLoadingToast) CommonToast.show();
    String jsonData = json.encode({'custId': stateModel.customerId, 'houseId': houseId});

    HttpUtil.post(
        HttpOptions.changeDefaultHouseUrl, (data) => _changeDefaultHouseCallBack(data, callBack: callBack),
        jsonData: jsonData,
        errorCallBack: (errorMsg) => _changeDefaultHouseErrorCallBack(errorMsg, callBack: callBack));
  }

  void _changeDefaultHouseCallBack(data, {Function callBack}) async {
    LogUtils.printLog('房屋详情-更换默认房屋:$data');
    CommonResultModel model = CommonResultModel.fromJson(data);
    if (model.code == '0') {
      CommonToast.dismiss();
//      navigatorKey.currentState.pop(true);
      if (callBack != null) callBack();
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
//      if (callBack != null) callBack(errorMsg: failedDescri);
      CommonToast.show(type: ToastIconType.FAILED, msg: failedDescri);
    }
    notifyListeners();
  }

  void _changeDefaultHouseErrorCallBack(String errorMsg, {Function callBack}) {
    LogUtils.printLog('接口返回失败：$errorMsg');
//    if (callBack != null) callBack(errorMsg: errorMsg);
    CommonToast.show(type: ToastIconType.FAILED, msg: errorMsg);
    notifyListeners();
  }

  ///
  /// 我的房屋-删除客户认证失败的房屋记录
  /// [houseCustAuditId] 房屋认证记录id
  ///
  void deleteAuditFailedHouse(int houseCustAuditId, {Function callBack}) async {
    CommonToast.show();
    String jsonData = json.encode({'houseCustAuditId': houseCustAuditId});

    HttpUtil.post(
        HttpOptions.deleteAuditFailedHouseUrl, (data) => _deleteAuditFailedHouseCallBack(data, callBack: callBack),
        jsonData: jsonData,
        errorCallBack: (errorMsg) => _deleteAuditFailedHouseErrorCallBack(errorMsg, callBack: callBack));
  }

  void _deleteAuditFailedHouseCallBack(data, {Function callBack}) async {
    LogUtils.printLog('我的房屋-删除客户认证失败的房屋记录:$data');
    CommonResultModel model = CommonResultModel.fromJson(data);
    if (model.code == '0') {
      CommonToast.dismiss();
//      navigatorKey.currentState.pop(true);
      if (callBack != null) callBack();
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
//      if (callBack != null) callBack(errorMsg: failedDescri);
      CommonToast.show(type: ToastIconType.FAILED, msg: failedDescri);
    }
    notifyListeners();
  }

  void _deleteAuditFailedHouseErrorCallBack(String errorMsg, {Function callBack}) {
    LogUtils.printLog('接口返回失败：$errorMsg');
//    if (callBack != null) callBack(errorMsg: errorMsg);
    CommonToast.show(type: ToastIconType.FAILED, msg: errorMsg);
    notifyListeners();
  }

  static HouseStateModel of(context) => ScopedModel.of<HouseStateModel>(context);
}
