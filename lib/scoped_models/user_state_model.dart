import 'dart:convert';

import 'package:azlistview/azlistview.dart';
import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/ad_info_model.dart';
import 'package:cmp_customer/models/banner_model.dart';
import 'package:cmp_customer/models/common/common_page_model.dart';
import 'package:cmp_customer/models/common_result_model.dart';
import 'package:cmp_customer/models/home_menulist_model.dart';
import 'package:cmp_customer/models/login_model.dart';
import 'package:cmp_customer/models/menu_project_model.dart';
import 'package:cmp_customer/models/project_model.dart';
import 'package:cmp_customer/models/uncertified_community_model.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/ui/common/common_dialog.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/login/login_operation.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/failed_code_trans.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/shared_preferences_key.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LoginType { WELCOME_PAGE, LOGIN_PAGE }

mixin UserStateModel on Model {
  int baseDataLoaded = 0; //基础数据是否加载完成：0=加载中，1=加载成功，2=加载失败
  String baseDataLoadedFailedMsg = ''; //基础数据加载失败提示语
//  bool showRefreshTokenFailed = false; //进入首页后调用refresh token刷新是否成功，失败则弹框提示重新登录
  int menuDataLoaded = 0; //项目数据菜单是否加载完成：0=加载中，1=加载成功，2=加载失败
  String userAccount; //账号
//  String password;
  int defaultProjectId; //默认社区id
  String defaultProjectName; //默认社区
  int defaultHouseId; //默认房屋id
  int defaultBuildingId;
  int defaultUnitId;
  String defaultBuildingName; //默认楼栋名称
  String defaultUnitName; //默认单元名称
  String defaultHouseName; //默认房号名称
  String customerName; //客户姓名
  String mobile; //手机号
  String customerProper; //客户属性:YZ-业主，ZH-租户，JTCY-业主成员，ZHCY-租户成员
  int customerType; //1–游客;2–已经经过认证的客户
  int customerId; //客户id
  int accountId; //账号id
  String custType; //客户类型:G-个人，Q-企业
  String allDayTel; //专属客服
  String portrait; //头像
  PersonalInfo personalInfo;
  List<PropertyNotice> propertyNoticeList; //物业通知列表
  List<UncertifiedCommunity> uncertifiedCommunityList; //未认证社区列表，本地缓存中获取
  bool isSettle = false; //是否存在"在住"状态的房屋
  bool uncertifiedDefault = false; //未认证社区是否被设为默认社区
  List<MenuInfo> menuList; //首页功能菜单列表，配置菜单
  List<MenuInfo> menuGlobalList; //首页全局功能菜单列表，配置菜单
  List<MenuInfo> menuServiceList; //服务的菜单列表，配置菜单
  bool showMarket = true; //是否显示集市
  bool hasHouse = false; //是否存在“在住/暂离”状态的房屋
//  int bannerTotalCount = 1; //banner总数量
  List<BannerInfo> bannerList; //banner列表
  bool bannerAutoPlay = false; //banner是否自动滚动
  String marketStatement = ''; //邻里集市声明

  Future<void> refreshUserData(UserInfo data) async {
    clearUserData();
    customerId = data?.custId;
    SharedPreferences prefs = await SharedPreferencesKey.globalPrefs;
    prefs.setInt(SharedPreferencesKey.KEY_CUSTOMER_ID, customerId);
    accountId = data?.customerAppInfo?.id;
    customerName = data?.custName;
    customerType = data?.customerAppInfo?.customerType;
    custType = data?.custType;
    userAccount = data?.customerAppInfo?.mobile;
    mobile = data?.custPhone;
    allDayTel = data?.alldayTel;
    portrait = data?.custPhoto;
    LogUtils.printLog('账号信息：${data?.customerAppInfo?.mobile}----${data?.custPhone}');
    if (personalInfo == null) personalInfo = PersonalInfo();
//    personalInfo.birth = data?.customerAppInfo?.birthDate; //游客生日
    personalInfo.birth =
        data?.custBirth != null ? StringsHelper.formatterYMD.format(DateTime.parse(data?.custBirth)) : ''; //客户生日
    personalInfo.sex =
        data?.customerAppInfo?.sex != null ? data?.customerAppInfo?.sex == 1 ? '男' : '女' : ''; //游客性别
    personalInfo.sex = data?.gender != null ? data.gender == '1' ? '男' : '女' : ''; //客户性别
    personalInfo.nickName = data?.customerAppInfo?.nickname; //昵称
//    personalInfo.signature = data?.customerAppInfo?.signature;
//    if(data?.houseList == null){

    if (uncertifiedCommunityList == null)
      uncertifiedCommunityList = List();
    else
      uncertifiedCommunityList.clear();
//    if (uncertifiedCommunityList == null || uncertifiedCommunityList.length == 0) {
    String jsonCommunity = prefs.getString(SharedPreferencesKey.KEY_UNCERTIFIED_COMMUNITY);
    if (jsonCommunity != null && jsonCommunity.isNotEmpty) {
      UncertifiedCommunityModel model = UncertifiedCommunityModel();
      model = UncertifiedCommunityModel.fromJson(json.decode(jsonCommunity));
      if (uncertifiedCommunityList == null) uncertifiedCommunityList = List();
      UncertifiedCommunityList uncertifiedCommunityInfo = model?.list?.firstWhere(
          (UncertifiedCommunityList info) => info?.account == stateModel.userAccount,
          orElse: () => null);
      if (uncertifiedCommunityInfo != null) {
        if (uncertifiedCommunityInfo.uncertifiedCommunityList != null &&
            uncertifiedCommunityInfo.uncertifiedCommunityList.length > 0)
          uncertifiedCommunityList.addAll(uncertifiedCommunityInfo.uncertifiedCommunityList);
      }
    }

//      uncertifiedCommunityList?.forEach((UncertifiedCommunity community) {
//        if (community.isDefault) {
//          uncertifiedDefault = true;
//          defaultProjectId = community.projectId;
//          defaultProjectName = community.projectName;
//          defaultBuildingName = null;
//          defaultUnitName = null;
//          defaultHouseName = null;
//          defaultHouseId = null;
////            customerType = 1;
//        }
//      });
//    }
//    }else
//    if (data?.houseList != null && data.houseList.length > 0 && !uncertifiedDefault) {
//      defaultProjectId = data?.houseList[0].projectId;
//      defaultProjectName = data?.houseList[0].projectName;
//      data.houseList.forEach((HouseInfo info) {
//        //查找未认证社区列表是否有与已认证社区重复的社区，有的话就把未认证社区删除掉
//        UncertifiedCommunity uncertifiedCommunity = uncertifiedCommunityList
//            ?.firstWhere((UncertifiedCommunity data) => data.projectId == info.projectId, orElse: () => null);
//        if (uncertifiedCommunity != null) {
//          uncertifiedCommunityList.remove(uncertifiedCommunity);
//        }
//        if (info?.isDefaultHouse == '1') {
//          customerProper = info?.custProper;
//          defaultHouseId = info?.houseId;
//          defaultBuildingId = info.buildId;
//          defaultUnitId = info.unitId;
//          defaultBuildingName = info?.buildName;
//          defaultUnitName = info?.unitName;
//          defaultHouseName = info?.houseNo;
//        }
//
//        //存在
//        if (!isSettle && info?.settleStatus == '1') {
//          isSettle = true;
//        }
//      });
//    }

    isSettle = false;
    hasHouse = false;
    if (data.houseAllList != null && data.houseAllList.length > 0) {
      hasHouse = true;
      //对返回的房屋列表数据做处理，跟本地缓存的社区列表做比对，本地社区有设置默认则优先使用本地，没有默认则用返回的房屋作为默认
      uncertifiedDefault = false;
      data.houseAllList?.forEach((HouseInfo houseInfo) {
        if (uncertifiedCommunityList != null && uncertifiedCommunityList.length > 0) {
          for (int i = uncertifiedCommunityList.length - 1; i >= 0; i--) {
            UncertifiedCommunity uncertifiedCommunity = uncertifiedCommunityList[i];
            //如果本地缓存默认社区和返回房屋列表的有相同社区，则删除本地缓存的这条数据，并把这个社区调用接口设置为默认社区
            if (uncertifiedCommunity.projectId == houseInfo.projectId) {
              if (uncertifiedCommunity.isDefault) {
                stateModel.changeDefaultCommunity(uncertifiedCommunity?.projectId, showToast: false, callBack: () {
//                stateModel.setUncertifiedCommunityFalse();
                  uncertifiedDefault = false;
                  stateModel.reLogin();
                });
              }
              uncertifiedCommunityList.remove(uncertifiedCommunity);
            } else if (uncertifiedCommunity.isDefault) {
              uncertifiedDefault = true;
              defaultProjectId = uncertifiedCommunity.projectId;
              prefs.setInt(SharedPreferencesKey.KEY_PROJECT_ID, defaultProjectId);
              defaultProjectName = uncertifiedCommunity.formerName;
              defaultBuildingName = null;
              defaultUnitName = null;
              defaultHouseName = null;
              defaultHouseId = null;
            }
          }
        }
        //如果没有未认证社区是默认社区则把默认的已认证社区赋值
        if (!uncertifiedDefault && houseInfo.isDefaultHouse == '1') {
          defaultProjectId = houseInfo.projectId;
          prefs.setInt(SharedPreferencesKey.KEY_PROJECT_ID, defaultProjectId);
          defaultProjectName = houseInfo.formerName;
          customerProper = houseInfo?.custProper;
          defaultHouseId = houseInfo?.houseId;
          prefs.setInt(SharedPreferencesKey.KEY_HOUSE_ID, defaultHouseId);
          defaultBuildingId = houseInfo.buildId;
          defaultUnitId = houseInfo.unitId;
          defaultBuildingName = houseInfo?.buildName;
          defaultUnitName = houseInfo?.unitName;
          defaultHouseName = houseInfo?.houseNo;
        }
        //存在
        if (!isSettle && houseInfo?.settleStatus == '1') {
          //settleStatus : 0-迁出，1-在住，2-暂离
          isSettle = true;
        }
      });
    } else {
      if (uncertifiedCommunityList != null && uncertifiedCommunityList.length > 0) {
        UncertifiedCommunity info = uncertifiedCommunityList
            .firstWhere((UncertifiedCommunity info) => info.isDefault == true, orElse: () => null);
        if (info != null) {
          uncertifiedDefault = true;
          defaultProjectId = info.projectId;
          prefs.setInt(SharedPreferencesKey.KEY_PROJECT_ID, defaultProjectId);
          defaultProjectName = info.formerName;
          defaultBuildingName = null;
          defaultUnitName = null;
          defaultHouseName = null;
          defaultHouseId = null;
        }
      }
    }
    stateModel.saveUnCertifiedCommunity();
    //如果是客户并且没有默认社区，就要查看有没有房屋列表，有就要设置一个默认社区
    if (defaultProjectId == null &&
        customerType == 2 &&
        data?.houseAllList != null &&
        data.houseAllList.length > 0) {
      stateModel.changeDefaultHouse(data.houseAllList[0].houseId, callBack: () => reLogin());
    }
    stateModel.reloadUsedDoor();
    if (data?.propertyNoticeList != null && data.propertyNoticeList.length > 0) {
      if (propertyNoticeList == null)
        propertyNoticeList = List();
      else
        propertyNoticeList.clear();
      data.propertyNoticeList.forEach((PropertyNotice notice) {
        if (propertyNoticeList.length == 1) return;
        propertyNoticeList.add(notice);
      });
    }
    notifyListeners();
  }

  void clearUserData() {
    defaultProjectId = null;
    userAccount = null;
    defaultProjectName = null;
    defaultHouseId = null;
    defaultBuildingName = null;
    defaultUnitName = null;
    defaultHouseName = null;
    customerName = null;
    mobile = null;
    customerProper = null;
    customerType = null;
    customerId = null;
    accountId = null;
    custType = null;
    allDayTel = null;
    portrait = null;
    personalInfo = null;
    if (propertyNoticeList != null) propertyNoticeList.clear();

    if (menuList == null)
      menuList = List();
    else
      menuList.clear();
    if (menuGlobalList == null)
      menuGlobalList = List();
    else
      menuGlobalList.clear();
    if (menuServiceList == null)
      menuServiceList = List();
    else
      menuServiceList.clear();
  }

  //清空accessToken再去获取基础数据，不然数据不刷新
  void clearAccessToken() async {
    SharedPreferences prefs = await SharedPreferencesKey.globalPrefs;
    if (prefs.containsKey(SharedPreferencesKey.KEY_ACCESS_TOEKN))
      prefs.remove(SharedPreferencesKey.KEY_ACCESS_TOEKN);
//    prefs.setString(SharedPreferencesKey.KEY_ACCESS_TOEKN, null);
  }

  //清空accessToken重新登录
  void reLogin({Function callBack}) {
    clearAccessToken();
    getUserData(callBack: callBack);
  }

  ///
  /// 获取验证码接口（除登录获取验证码外全部用这个接口获取验证码）
  ///
  void getVerificationCode({@required String mobile, VoidCallback callBack}) async {
//    if (callBack != null) _taskDetailUICallBack = callBack;
//    Map<String, dynamic> params = new Map();
//    params['mobile'] = mobile;
    String jsonData = json.encode({
      'mobile': mobile,
      'templateId': 306490,
    });
//    FormData formData = FormData.from({
//      'mobile': mobile.toString(),
//    });

    HttpUtil.post(HttpOptions.getVerificationCodeUrl, _verificationCodeCallBack,
        jsonData: jsonData, errorCallBack: _verificationCodeErrorCallBack);
  }

  void _verificationCodeCallBack(data) {
    CommonResultModel model = CommonResultModel.fromJson(data);
    LogUtils.printLog('获取验证码:$data');
    if (model.code == '0') {
//      todoTaskCount = model.data.count;
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
//      Fluttertoast.showToast(msg: failedDescri);
    }
    notifyListeners();
  }

  void _verificationCodeErrorCallBack(errorMsg) {
    LogUtils.printLog('接口返回失败');
//    Fluttertoast.showToast(msg: errorMsg);
    notifyListeners();
  }

  ///
  /// 注册
  ///[mobile]手机号，[code]验证码
  ///
  void register({@required String mobile, @required String code, VoidCallback callBack}) async {
//    if (callBack != null) _taskDetailUICallBack = callBack;
//    Map<String, dynamic> params = new Map();
//    params['mobile'] = mobile;
    CommonToast.show();
    String jsonData = json.encode({
      'mobile': mobile,
      'code': code,
    });

    HttpUtil.post(HttpOptions.registerUrl, _registerCallBack,
        jsonData: jsonData, errorCallBack: _registerErrorCallBack);
  }

  void _registerCallBack(data) {
    CommonResultModel model = CommonResultModel.fromJson(data);
    LogUtils.printLog('注册:$data');
    if (model.code == '0') {
      CommonToast.show(type: ToastIconType.SUCCESS, msg: '注册成功');
      navigatorKey.currentState.pop();

//      todoTaskCount = model.data.count;
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
      CommonToast.show(type: ToastIconType.FAILED, msg: failedDescri);
//      Fluttertoast.showToast(msg: failedDescri);
//    Toast.show(failedDescri, context);
    }
    notifyListeners();
  }

  void _registerErrorCallBack(errorMsg) {
    LogUtils.printLog('接口返回失败');
//    Fluttertoast.showToast(msg: errorMsg);
    notifyListeners();
  }

  ///
  /// 登录获取验证码前交验账号是否存在
  ///
  void checkMobileExist(String mobile, {Function callBack}) async {
    String jsonData = json.encode({
      'mobile': mobile,
    });
    HttpUtil.post(HttpOptions.checkMobileExistUrl, (data) => _checkMobileExistCallBack(data, callBack: callBack),
        jsonData: jsonData,
        errorCallBack: (errorMsg) => _checkMobileExistErrorCallBack(errorMsg, callBack: callBack));
  }

  void _checkMobileExistCallBack(data, {Function callBack}) async {
    LogUtils.printLog('登录获取验证码前交验账号是否存在:$data');
    CommonResultModel model = CommonResultModel.fromJson(data);
    if (model.data is bool) {
      if (model.data) {
        if (callBack != null) callBack(true);
      } else {
        if (callBack != null) callBack(false);
        CommonToast.show(type: ToastIconType.FAILED, msg: '请先注册再登录！');
      }
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
      CommonToast.show(type: ToastIconType.FAILED, msg: failedDescri);
    }
//    notifyListeners();
  }

  void _checkMobileExistErrorCallBack(String errorMsg, {Function callBack}) {
    LogUtils.printLog('登录获取验证码前交验账号是否存在接口返回失败：$errorMsg');
    if (callBack != null) callBack(false);
    String failedDescri = FailedCodeTrans.enTochsTrans(failMsg: errorMsg);
    CommonToast.show(type: ToastIconType.FAILED, msg: failedDescri);
//    notifyListeners();
  }

  ///
  /// 获取验证码接口（仅限于登录用）
  ///
  void getVerificationCodeForLogin({@required String mobile, VoidCallback callBack}) async {
    Map<String, dynamic> params = new Map();
    params['mobile'] = mobile;
    params['templateId'] = 306490;

    HttpUtil.get(
        HttpOptions.getVerificationCodeForLoginUrl,
        (data) {
          _verificationCodeForLoginCallBack(data, callback: callBack);
        },
        params: params,
        errorCallBack: (errorMsg) {
          _verificationCodeForLoginErrorCallBack(errorMsg, callback: callBack);
        });
  }

  void _verificationCodeForLoginCallBack(data, {Function callback}) {
    LogUtils.printLog('获取验证码(登录):$data');
    if (data == 200) {
//      CommonToast.show(
//          msg: '${HttpOptions.baseUrl}${HttpOptions.getVerificationCodeForLoginUrl}---$data',
//          type: ToastIconType.SUCCESS);
    } else {
//      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
      if (callback != null) callback(failedMsg: data);
      CommonToast.show(msg: data ?? '', type: ToastIconType.FAILED);
    }
    notifyListeners();
  }

  void _verificationCodeForLoginErrorCallBack(errorMsg, {Function callback}) {
    LogUtils.printLog('接口返回失败');
    if (callback != null) callback(failedMsg: errorMsg);
    CommonToast.show(msg: errorMsg, type: ToastIconType.FAILED);
    notifyListeners();
  }

  ///
  /// 登录
  ///[mobile]手机号，[code]验证码
  ///
  void login({@required String mobile, String code, Function callBack, UserLoginType loginType}) async {
//    if (callBack != null) _taskDetailUICallBack = callBack;

    String url = loginType == UserLoginType.Verification ? HttpOptions.loginUrl : HttpOptions.loginByPwdUrl;
    Map<String, dynamic> params = new Map();
    if (loginType == UserLoginType.Verification) {
      params['mobile'] = mobile;
      params['smsCode'] = code;
    } else {
      params['username'] = '$mobile,type=1';
//      params['username'] = '$mobile'; //测试数据
      params['password'] = code;
    }

    HttpUtil.post(url, (data) => _loginCallBack(data, callBack: callBack),
        params: params, errorCallBack: (errorMsg) => _loginErrorCallBack(errorMsg, callBack: callBack));
  }

  void _loginCallBack(data, {Function callBack}) async {
    LogUtils.printLog('登录:$data');
    LoginModel model = LoginModel.fromJson(data);
    SharedPreferences prefs = await SharedPreferencesKey.globalPrefs;
    prefs.setString(SharedPreferencesKey.KEY_ACCESS_TOEKN, model.accessToken);
    prefs.setString(SharedPreferencesKey.KEY_REFRESH_TOEKN, model.refreshToken);
    if(callBack != null) callBack();
//    getUserData(callBack: callBack, loginTag: true);
//    notifyListeners();
  }

  void _loginErrorCallBack(String errorMsg, {Function callBack}) {
    LogUtils.printLog('接口返回失败：$errorMsg');
    if(errorMsg != '密码未设置')
    CommonToast.show(type: ToastIconType.FAILED, msg: errorMsg);
    if (callBack != null) callBack(errorMsg: errorMsg);
//    notifyListeners();
  }

  ///
  /// 用户基础数据
  /// [loginTag]是否登录时调用
  ///
  Future<void> getUserData({Function callBack, bool loginTag = false}) async {
    if(loginTag) {
      baseDataLoaded = 0; //0=加载中，1=加载成功，2=加载失败
      baseDataLoadedFailedMsg = '';
//      stateModel.showRefreshTokenFailed = false;
      notifyListeners();
    }
    await HttpUtil.post(HttpOptions.userDataUrl, (data) => _userDataCallBack(data, callBack: callBack, loginTag: loginTag),
        errorCallBack: (errorMsg) => _userDataErrorCallBack(errorMsg, callBack: callBack, loginTag: loginTag));
  }

  void _userDataCallBack(data, {Function callBack, bool loginTag = false}) async {
    LogUtils.printLog('用户数据:$data');
    UserDataModel model = UserDataModel.fromJson(data);
    if (model.code == '0') {
      LogUtils.printLog('基础数据返回时间：${StringsHelper.formatterYMDHms.format(DateTime.now())}');
      await refreshUserData(model.userInfo);
      stateModel.getUnReadMessageTotalCount();
      stateModel.uploadDeviceInfo();
      stateModel.getMarketListOnHomePage();
      stateModel.getPgcInformationListOnHomePage();
      stateModel.getCommunityActivityListOnHomePage();
      stateModel.getVoteListOnHomePage();
      stateModel.getQuestionnaireListOnHomePage();
      stateModel.getBanner();
      stateModel.getMenuProjectList(loginTag: loginTag);
//      setMenuList(model?.userInfo?.menuList, model?.userInfo?.menuProjectList);

      if (menuGlobalList == null)
        menuGlobalList = List();
      else
        menuGlobalList.clear();
      menuGlobalList.addAll(model?.userInfo?.menuList);
      if (menuGlobalList != null && menuGlobalList.length > 0) {
        menuGlobalList.sort((left, right) {
          if (left.orderNo != null && right.orderNo != null) {
            return left?.orderNo?.compareTo(right?.orderNo);
          } else
            return 0;
        });
      }
      if (callBack != null) callBack();
      if(loginTag){
        baseDataLoaded = 1; //0=加载中，1=加载成功，2=加载失败
      }
        notifyListeners();
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
      if (callBack != null)
        callBack(errorMsg: failedDescri);
      else
        CommonToast.show(type: ToastIconType.FAILED, msg: failedDescri); //此处提示不能再欢迎页弹出，否则跳转到登录页后无法输入
      if (loginTag) {
        baseDataLoaded = 2; //0=加载中，1=加载成功，2=加载失败
        baseDataLoadedFailedMsg = failedDescri;
      }
      notifyListeners();
    }
//    notifyListeners();
  }

  void _userDataErrorCallBack(String errorMsg, {Function callBack, bool loginTag = false}) {
    LogUtils.printLog('基础数据接口返回失败：$errorMsg');
//    CommonToast.show(type: TipDialogType.FAIL, msg: errorMsg);
    String failedDescri = FailedCodeTrans.enTochsTrans(failMsg: errorMsg);
    if (callBack != null) callBack(errorMsg: failedDescri);
//    CommonToast.show(type: ToastIconType.FAILED, msg: errorMsg);
//    notifyListeners();
    if (loginTag) {
      baseDataLoaded = 2; //0=加载中，1=加载成功，2=加载失败
      baseDataLoadedFailedMsg = errorMsg;
    }
    notifyListeners();
  }


  List<ProjectInfo> projectInfoList = List();

  ///
  /// 根据项目名模糊搜索项目列表
  ///
  void searchProject(
      {bool preRefresh = false, @required ListPageModel pageModel, String keyword, String cityCode}) {
    pageModel.listPage.listState = ListState.HINT_LOADING;
    if (preRefresh) notifyListeners();
    pageModel.listPage.currentPage = 1;
    pageModel.listPage.maxCount = false;
    pageModel.list.clear();
    _getProjectList(pageModel, keyword: keyword, cityCode: cityCode);
  }

//  Future<void> taskHandleRefresh({@required TaskPageController controller, bool preRefresh = false}) async {
//    loadTaskList(controller:controller,preRefresh: preRefresh);
//  }

  searchProjectHandleLoadMore(ListPageModel pageModel, {String keyword = '', String cityCode}) {
    pageModel.listPage.currentPage++;
    if (!pageModel.listPage.maxCount) {
      _getProjectList(pageModel, keyword: keyword, cityCode: cityCode);
    }
  }

  _getProjectList(ListPageModel pageModel, {String keyword = '', String cityCode}) async {
    projectInfoList.clear();
    //查询全部数据
    String jsonData = json.encode({
//      'current': pageModel.listPage.currentPage,
//      'pageSize': HttpOptions.pageSize.toString(),
//      'name': keyword,
      'formerName': keyword,
      'cityCode': cityCode,
      'isCommunity': '1', //过滤掉撤管项目
    });

    HttpUtil.post(
        HttpOptions.searchProjectUrl,
        (data) {
          _searchProjectCallBack(data, pageModel);
        },
        jsonData: jsonData,
        errorCallBack: (errorMsg) {
          _searchProjectErrorCallBack(errorMsg, pageModel);
        });
  }

  void _searchProjectCallBack(data, ListPageModel pageModel) {
    ProjectModel model = ProjectModel.fromJson(data);
    if (model.code == '0') {
      if (model.projectList != null && model.projectList.length > 0) {
        pageModel.listPage.listState = ListState.HINT_DISMISS;
        if (pageModel.listPage.currentPage == 1) {
          //刷新操作，清空数据再添加（防止多次刷新请求导致数据重复添加）
          pageModel.list.clear();
        }
        pageModel.list.addAll(model.projectList);
        //字母排序
        _handleList(pageModel.list);
        if (model.projectList.length < HttpOptions.pageSize) pageModel.listPage.maxCount = true;
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

  void _handleList(List list) {
    if (list == null || list.isEmpty) return;
    projectInfoList.clear();
    for (int i = 0, length = list.length; i < length; i++) {
      ProjectInfo info = list[i];
      if (info != null && info.projectId != null) {
        if (info.formerName != null) {
          String pinyin = PinyinHelper.getPinyinE(info.formerName);
          if (StringsHelper.isNotEmpty(pinyin)) {
            String tag = pinyin.substring(0, 1).toUpperCase();
            if (RegExp("[A-Z]").hasMatch(tag)) {
              info.tagIndex = tag;
            } else {
              info.tagIndex = "#";
            }
          } else {
            info.tagIndex = "#";
          }
        } else {
          info.tagIndex = "#";
        }
        projectInfoList
            .add((ProjectInfo(projectId: info.projectId, formerName: info.formerName, tagIndex: info.tagIndex)));
      }
    }
    //根据A-Z排序
    SuspensionUtil.sortListBySuspensionTag(projectInfoList);
  }

  void _searchProjectErrorCallBack(errorMsg, ListPageModel pageModel) {
    LogUtils.printLog('接口返回失败');
    pageModel.listPage.listState = ListState.HINT_LOADED_FAILED_CLICK;
    notifyListeners();
  }

  ///
  /// 修改手机号
  ///[mobile]手机号，[code]验证码
  ///
  void changeMobile({@required String mobile, @required String code, VoidCallback callBack}) async {
    CommonToast.show();
    String jsonData = json.encode({
      'mobile': mobile,
      'code': code,
    });

    HttpUtil.post(
        HttpOptions.changeMobileUrl,
        (data) {
          _changeMobileCallBack(data, callBack: callBack);
        },
        jsonData: jsonData,
        errorCallBack: (errorMsg) {
          _changeMobileErrorCallBack(errorMsg, callBack: callBack);
        });
  }

  void _changeMobileCallBack(data, {VoidCallback callBack}) {
    CommonResultModel model = CommonResultModel.fromJson(data);
    LogUtils.printLog('修改手机号:$data');
    if (model.code == '0') {
      CommonToast.show(type: ToastIconType.SUCCESS, msg: '修改成功');
      stateModel.userAccount = model.data['mobile'];
//      getUserData();
      stateModel.reLogin();
      navigatorKey.currentState.pop();
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
      CommonToast.show(type: ToastIconType.FAILED, msg: failedDescri);
    }
    notifyListeners();
  }

  void _changeMobileErrorCallBack(errorMsg, {VoidCallback callBack}) {
    LogUtils.printLog('接口返回失败');
    notifyListeners();
  }

  ///
  /// 验证验证码是否正确
  ///[mobile]手机号，[code]验证码
  ///
  void checkVerificationCode({@required String mobile, @required String code, VoidCallback callBack}) async {
    CommonToast.show();
    String jsonData = json.encode({
      'mobile': mobile,
      'code': code,
    });

    HttpUtil.post(
        HttpOptions.checkVerificationCodeUrl,
        (data) {
          _checkVerificationCodeCallBack(data, callBack: callBack);
        },
        jsonData: jsonData,
        errorCallBack: (errorMsg) {
          _checkVerificationCodeErrorCallBack(errorMsg, callBack: callBack);
        });
  }

  void _checkVerificationCodeCallBack(data, {VoidCallback callBack}) {
    CommonResultModel model = CommonResultModel.fromJson(data);
    LogUtils.printLog('验证验证码是否正确:$data');
    if (model.code == '0') {
      CommonToast.dismiss();
      if (callBack != null) callBack();
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
      CommonToast.show(type: ToastIconType.FAILED, msg: failedDescri);
    }
    notifyListeners();
  }

  void _checkVerificationCodeErrorCallBack(errorMsg, {VoidCallback callBack}) {
    LogUtils.printLog('接口返回失败');
    notifyListeners();
  }

  ///
  /// 获取banner
  ///
  void getBanner({Function callBack}) async {
    LogUtils.printLog('调用banner接口时间：${StringsHelper.formatterYMDHms.format(DateTime.now())}');
    bannerAutoPlay = false;
    if (bannerList == null) bannerList = List();
    else bannerList.clear();
    notifyListeners();
    String jsonData = json.encode({'projectId': stateModel.defaultProjectId});
//    String jsonData = json.encode({'projectId': null});
    HttpUtil.post(HttpOptions.getBannerUrl, (data) => _bannerCallBack(data, callBack: callBack),
        jsonData: jsonData, errorCallBack: (errorMsg) => _bannerErrorCallBack(errorMsg, callBack: callBack));
  }

  void _bannerCallBack(data, {Function callBack}) async {
    LogUtils.printLog('调用banner接口回调01时间：${StringsHelper.formatterYMDHms.format(DateTime.now())}');
    LogUtils.printLog('获取banner:$data');
    BannerModel model = BannerModel.fromJson(data);
    if (model.code == '0' && model.bannerList != null && model.bannerList.length > 0) {

//      if (bannerList == null) bannerList = List();
//      else bannerList.clear();
//      bannerList.addAll(model.bannerList);
      bannerList = model.bannerList;
      if (bannerList.length > 1)
        bannerAutoPlay = true;
      else
        bannerAutoPlay = false;
//      bannerTotalCount = model.bannerList.length;
//      if (callBack != null) callBack(bannerList: model.bannerList);
      LogUtils.printLog('调用banner接口回调02时间：${StringsHelper.formatterYMDHms.format(DateTime.now())}');
    } else {
      bannerAutoPlay = false;
      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
      if (callBack != null) callBack(errorMsg: failedDescri);
//      CommonToast.show(type: ToastIconType.FAILED, msg: failedDescri);
    }
    notifyListeners();
  }

  void _bannerErrorCallBack(String errorMsg, {Function callBack}) {
    if (bannerList != null && bannerList.length > 1)
      bannerAutoPlay = true;
    else
      bannerAutoPlay = false;
    LogUtils.printLog('接口返回失败：$errorMsg');
//    CommonToast.show(type: TipDialogType.FAIL, msg: errorMsg);
    if (callBack != null) callBack(errorMsg: errorMsg);
    notifyListeners();
  }

  ///
  /// 获取项目对应菜单，首页九个位置和服务
  ///
  void getMenuProjectList({Function callBack, bool loginTag = false}) async {
    LogUtils.printLog('调用项目对应菜单');
    menuDataLoaded = 0;
    notifyListeners();
    String jsonData = json.encode({'projectId': stateModel.defaultProjectId});
//    String jsonData = json.encode({'projectId': null});
    HttpUtil.post(
        HttpOptions.menuProjectUrl, (data) => _menuProjectCallBack(data, callBack: callBack, loginTag: loginTag),
        jsonData: jsonData,
        errorCallBack: (errorMsg) => _menuProjectErrorCallBack(errorMsg, callBack: callBack, loginTag: loginTag));
  }

  void _menuProjectCallBack(data, {Function callBack, bool loginTag = false}) async {
    LogUtils.printLog('获取项目对应菜单:$data');
    MenuProjectModel model = MenuProjectModel.fromJson(data);
    if (model.code == '0') {
      if (menuList == null)
        menuList = List();
      else
        menuList.clear();
      if (menuServiceList == null)
        menuServiceList = List();
      else
        menuServiceList.clear();
      if (model.menuProjectList != null && model.menuProjectList.length > 0) {
        List<MenuInfo> menuServiceProjectList = model.menuProjectList.where((MenuInfo menuInfo) =>
        menuInfo?.relationType == 'FW')?.toList();
        if(menuServiceProjectList != null && menuServiceProjectList.length > 0){
          menuServiceProjectList.sort((left, right) {
            if (left.orderNo != null && right.orderNo != null) {
              return left?.orderNo?.compareTo(right?.orderNo);
            } else
              return 0;
          });
          menuServiceProjectList.forEach((MenuInfo child) {
            child?.children?.sort((left, right) {
              if (left.orderNo != null && right.orderNo != null) {
                return left?.orderNo?.compareTo(right?.orderNo);
              } else
                return 0;
            });
          });
        menuServiceList.addAll(menuServiceProjectList);
        }
        List<MenuInfo> menuHomeProjectList = model.menuProjectList.where((MenuInfo menuInfo) =>
        menuInfo?.relationType == 'SY')?.toList();
        if(menuHomeProjectList != null && menuHomeProjectList.length > 0){
          menuHomeProjectList.sort((left, right) {
            if (left.orderNo != null && right.orderNo != null) {
              return left?.orderNo?.compareTo(right?.orderNo);
            } else
              return 0;
          });
            menuList.addAll(menuHomeProjectList);
          if (menuHomeProjectList.length > 9) {
            menuList.sublist(0, 9);
          }else if (menuHomeProjectList.length < 9) {
            //项目菜单小于9个就用全局菜单补全9个
            menuGlobalList = menuGlobalList.where((MenuInfo menuInfo) {
              MenuInfo menuTemp = menuHomeProjectList.firstWhere((MenuInfo homeProjectMenu) =>
              homeProjectMenu.id == menuInfo.id, orElse: () => null);
              return menuTemp == null;
            })?.toList();
            int count = 9 - menuHomeProjectList.length;
            if (count != 0) {
              menuList.addAll(menuGlobalList.sublist(0, count));
            }
          }
        }else {
          menuList.addAll(menuGlobalList);
        }
      }else {
        //项目没有配置菜单使用全局菜单
        menuList.addAll(menuGlobalList);
      }
      menuDataLoaded = 1;
      //把首页菜单放入缓存，下次登录加载中显示使用
      SharedPreferences prefs = await SharedPreferencesKey.globalPrefs;
      HomeMenuListModel menuListModel = HomeMenuListModel();
      if(menuListModel.menuList == null)
        menuListModel.menuList = List();
      else menuListModel.menuList.clear();
      menuListModel.menuList.addAll(menuList);
      prefs.setString(SharedPreferencesKey.KEY_HOME_MENULIST, json.encode(menuListModel));
    } else {
      menuDataLoaded = 2;
      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
      if (callBack != null) callBack(errorMsg: failedDescri);
      LogUtils.printLog('获取项目对应菜单接口返回失败1：$failedDescri');

      if (mainContext != null && loginTag) {
        CommonDialog.showAlertDialog(mainContext, content: '首页菜单加载失败，请尝试下拉刷新', contentFontSize: UIData.fontSize16,
            positiveBtnText: '我知道了',
            onConfirm: () {
            }, showNegativeBtn: false);
      }
    }
    notifyListeners();
  }

  void _menuProjectErrorCallBack(String errorMsg, {Function callBack, bool loginTag = false}) {
    LogUtils.printLog('获取项目对应菜单接口返回失败2：$errorMsg');
//    CommonToast.show(type: TipDialogType.FAIL, msg: errorMsg);
    menuDataLoaded = 2;
    if (callBack != null) callBack(errorMsg: errorMsg);
    if (mainContext != null && loginTag) {
      CommonDialog.showAlertDialog(mainContext, content: '首页菜单加载失败，请尝试下拉刷新', contentFontSize: UIData.fontSize16,
          positiveBtnText: '我知道了',
          onConfirm: () {
          }, showNegativeBtn: false);
    }
    notifyListeners();
  }

  ///
  /// 修改个人资料（头像和昵称）
  /// [type]修改类型，1：昵称，2：头像
  ///
  void modifyPersonalInfo(
      {String nickname, String custPhoto, @required int type, Function callBack, bool showToast = true}) async {
    if (showToast) CommonToast.show();
    String jsonData = json.encode({
      'nickname': nickname,
      'custPhoto': custPhoto,
    });

    HttpUtil.post(
        HttpOptions.modifyPersonalInfoUrl,
        (data) {
          _modifyPersonalInfoCallBack(data, type, callBack: callBack);
        },
        jsonData: jsonData,
        errorCallBack: (errorMsg) {
          _modifyPersonalInfoErrorCallBack(errorMsg);
        });
  }

  void _modifyPersonalInfoCallBack(data, int type, {Function callBack}) {
    CommonToast.dismiss();
    CommonResultModel model = CommonResultModel.fromJson(data);
    LogUtils.printLog('修改个人资料:$data');
    if (model.code == '0') {
      if (callBack != null) callBack(type);
      if (type == 2) CommonToast.show(type: ToastIconType.SUCCESS, msg: '头像上传成功');
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
      CommonToast.show(type: ToastIconType.FAILED, msg: failedDescri);
//      Fluttertoast.showToast(msg: failedDescri);
//    Toast.show(failedDescri, context);
    }
    notifyListeners();
  }

  void _modifyPersonalInfoErrorCallBack(errorMsg) {
    CommonToast.dismiss();
    LogUtils.printLog('修改个人资料接口返回失败');
//    Fluttertoast.showToast(msg: errorMsg);
    notifyListeners();
  }

  //获取广告弹框信息
  void getAd({Function callback}) async {
    HttpUtil.post(HttpOptions.getAdUrl, (data) => _adInfoCallBack(data, callback: callback),
        jsonData: json.encode({}),
        errorCallBack: (errorMsg) => _adInfoErrorCallBack(errorMsg, callback: callback));
  }

  void _adInfoCallBack(data, {Function callback}) {
    AdInfoModel model = AdInfoModel.fromJson(data);
    LogUtils.printLog('广告弹框内容:${json.encode(data)}');
    if (model.code == '0') {
      if (callback != null && model?.adInfo != null && model.adInfo.length > 0) callback(model?.adInfo[0]);
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
      LogUtils.printLog('广告弹框内容失败：$failedDescri');
//      CommonToast.show(msg: '广告弹框内容获取失败：$failedDescri', type: ToastIconType.FAILED);
    }
    notifyListeners();
  }

  void _adInfoErrorCallBack(errorMsg, {Function callback}) {
    LogUtils.printLog('广告弹框内容接口返回失败');
//    CommonToast.show(msg: '版本信息获取失败：$errorMsg', type: ToastIconType.FAILED);
    notifyListeners();
  }

  static UserStateModel of(context) => ScopedModel.of<UserStateModel>(context);
}

//个人信息，主要用于个人资料页面显示
class PersonalInfo {
  String nickName; //昵称
  String sex;
  String birth;
  String signature; //个性签名
}
