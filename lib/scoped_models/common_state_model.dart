import 'dart:convert';
import 'dart:io';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/models/ad_info_model.dart';
import 'package:cmp_customer/models/response/activity_info_response.dart';
import 'package:cmp_customer/models/response/agreement_response.dart';
import 'package:cmp_customer/strings/strings_common.dart';
import 'package:cmp_customer/ui/articles_release/articles_release_apply_page.dart';
import 'package:cmp_customer/ui/brand_name/brand_name_create.dart';
import 'package:cmp_customer/ui/change_of_title/change_of_title_create.dart';
import 'package:cmp_customer/ui/check_in/check_in_apply.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_dialog.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/common/copy_writing_page.dart';
import 'package:cmp_customer/ui/conference_room_reservation/reservation_list_tab.dart';
import 'package:cmp_customer/ui/decorate_manager/decoration_permit/decoration_apply_create.dart';
import 'package:cmp_customer/ui/decoration/decoration_pass_card_type.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_apply.dart';
import 'package:cmp_customer/ui/home/community_activity_page.dart';
import 'package:cmp_customer/ui/hot_work/hot_work_apply_page.dart';
import 'package:cmp_customer/ui/house_authentication/my_house_page.dart';
import 'package:cmp_customer/ui/html/html_page.dart';
import 'package:cmp_customer/ui/market/market_list_page.dart';
import 'package:cmp_customer/ui/near_info/near_info_list.dart';
import 'package:cmp_customer/ui/new_house/new_house_step_page.dart';
import 'package:cmp_customer/ui/office_cancel_lease/office_cancel_lease_apply_page.dart';
import 'package:cmp_customer/ui/parking/parking_card_mine.dart';
import 'package:cmp_customer/ui/pgc/pgc_infomation/pgc_infomation_list_page.dart';
import 'package:cmp_customer/ui/visitor_release/visitor_release_create.dart';
import 'package:cmp_customer/ui/work_other/complaint_page.dart';
import 'package:cmp_customer/ui/work_other/pay_service_list.dart';
import 'package:cmp_customer/ui/work_other/work_other_ui.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/failed_code_trans.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/shared_preferences_key.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../main.dart';
import 'activity_state_model.dart';

mixin CommonStateModel on Model {
  bool _marketStatementCheck = false; //邻里集市声明是否显示
  GlobalKey _marketStatementDialogKey = GlobalKey(); //邻里集市声明弹框的key
  ///
  /// 获取文案内容
  ///
  void getCopyWriting(int projectId, CopyWritingType type, CopyWritingPageModel pageModel,
      {Function callBack}) async {
    pageModel.pageState = ListState.HINT_LOADING;
    notifyListeners();
    String jsonData = json.encode({'projectId': projectId, 'agreementType': StringsHelper.enum2String(type)});

    HttpUtil.post(HttpOptions.agreementUrl, (data) => _copyWritingCallBack(data, pageModel, callBack: callBack),
        jsonData: jsonData,
        errorCallBack: (errorMsg) => _copyWritingErrorCallBack(errorMsg, pageModel, callBack: callBack));
  }

  void _copyWritingCallBack(data, CopyWritingPageModel pageModel, {Function callBack}) async {
    LogUtils.printLog('获取文案内容:$data');
    AgreementResponse model = AgreementResponse.fromJson(data);
    if (model.code == '0') {
      if (model.agreementInfo?.agreementContent != null && model.agreementInfo.agreementContent.isNotEmpty) {
        pageModel.pageState = ListState.HINT_DISMISS;
        pageModel.agreementInfo = model.agreementInfo;
//      if (callBack != null) callBack(model.agreementInfo);
      } else {
        pageModel.pageState = ListState.HINT_NO_DATA_CLICK;
      }
    } else if (model.code == '2') {
      pageModel.pageState = ListState.HINT_NO_DATA_CLICK;
    } else {
      pageModel.pageState = ListState.HINT_LOADED_FAILED_CLICK;
      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
//      if (callBack != null) callBack(errorMsg: failedDescri);
//      CommonToast.show(type: ToastIconType.FAILED, msg: failedDescri);
    }
    notifyListeners();
  }

  void _copyWritingErrorCallBack(String errorMsg, CopyWritingPageModel pageModel, {Function callBack}) {
    LogUtils.printLog('接口返回失败：$errorMsg');
    pageModel.pageState = ListState.HINT_LOADED_FAILED_CLICK;
//    if (callBack != null) callBack(errorMsg: errorMsg);
//    CommonToast.show(type: ToastIconType.FAILED, msg: errorMsg);
    notifyListeners();
  }


  //首页和服务点击跳转处理
  void tap2Module(String tag, {String title, BuildContext context}) async {
    LogUtils.printLog('tag:${tag}');
    switch (tag) {
      case '室内维修':
        Navigate.checkCustomerCertified(
            context,
            ComplaintPage(
              WorkOtherMainType.Repair,
              sub: WorkOtherSubType.Repair,
            ));
        break;
      case '咨询建议':
        Navigate.checkCustomerCertified(
            context,
            ComplaintPage(
              WorkOtherMainType.Advice,
              sub: WorkOtherSubType.Advice,
            ));
        break;
      case '表扬':
        Navigate.checkCustomerCertified(context, ComplaintPage(WorkOtherMainType.Praise));
        break;
      case '投诉':
        Navigate.checkCustomerCertified(context, ComplaintPage(WorkOtherMainType.Complaint));
        break;
      case '物品放行':
        Navigate.checkCustomerCertified(context, ArticlesReleaseApplyPage());
        break;
      case '社区通行':
        if (2 == stateModel?.customerType &&
            stateModel.customerId != null &&
            stateModel.defaultProjectId != null &&
            stateModel.defaultHouseId != null) {
          CommonToast.show(msg: '加载中');
          HttpUtil.refreshToken(callBack: ({String errorMsg}) async {
            CommonToast.dismiss();
            if (errorMsg == null) {
              stateModel.getAccessPassInfo();
            } else {
              CommonToast.show(type: ToastIconType.FAILED, msg: errorMsg);
            }
          });
        } else {
          CommonDialog.showUncertifiedDialog(context);
        }
        break;
      case '家政保洁':
        Navigate.checkCustomerCertified(
            context,
            PayServiceWorkOtherListPage(WorkOtherSubType.CleaningPaid, [
              WorkOtherSubType.InstallPaid,
              WorkOtherSubType.RepairPaid,
              WorkOtherSubType.CleaningPaid,
              WorkOtherSubType.HousePaid,
              WorkOtherSubType.OtherPaid
            ]));
        break;
      case '房屋租售':
        Navigate.toNewPage(HtmlPage(HttpOptions.houseShouYeUrl, title ?? tag ?? ''));
        break;
      case '预约挂号':
        stateModel.getHealthyToken(stateModel.customerType == 2 ? stateModel.mobile : stateModel.userAccount);
        break;
      case '预约挂号':
        stateModel.getHealthyToken(stateModel.customerType == 2 ? stateModel.mobile : stateModel.userAccount);
        break;
      case '物管缴费':
        Navigate.checkCustomerCertified(
          context, HtmlPage(HttpOptions.getPropertyPayUrl(), '物管缴费'));
        break;
      case '停车缴费':
        if (stateModel.defaultProjectId != null) {
        Navigate.toNewPage(HtmlPage(
            HttpOptions.getParkingPayUrl(stateModel.accountId, stateModel.defaultProjectId),
            title ?? tag ?? ''));
      } else {
        CommonToast.show(msg: '请选择社区！', type: ToastIconType.INFO);
      }
        break;
      case '到家钱包':
        stateModel.getPurseUrl(stateModel.accountId, callback: (bool value){
          if(value != null && !value)
            CommonDialog.showDevelopmentDialog(context);
        });
        break;
      case '房屋租售':
        Navigate.toNewPage(HtmlPage(HttpOptions.houseShouYeUrl, title ?? tag ?? ''));
        break;
      case '充值中心':
        stateModel.getBeeUrl();
        break;
      case '公区报障':
        Navigate.checkCustomerCertified(context, ComplaintPage(WorkOtherMainType.Warning));
        break;
      case '投票':
        Navigate.checkCustomerCertified(context, CommunityActivityPage(activityType: 2));
        break;
      case '我的房屋':
        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
          return MyHousePage();
        }));
        break;
      case '调查问卷':
        Navigate.checkCustomerCertified(context, CommunityActivityPage(activityType: 1));
        break;
      case '门禁卡申请':
        Navigate.checkCustomerCertified(context, EntranceCardApplyPage());
        break;
      case '停车办理':
        Navigate.checkCustomerCertified(context, ParkingCardMinePage());
        break;
      case '动火申请':
        Navigate.checkCustomerCertified(context, HotWorkApplyPage());
        break;
      case '产权变更':
        Navigate.checkCustomerCertified(context, ChangeOfTitleCreate());
        break;
      case '租户入驻':
        Navigate.toNewPage(CheckInApplyPage());
        break;
      case '装修申请':
        Navigate.checkCustomerCertified(context, DecorationApplyCreate());
        break;
      case '装修工出入证':
        Navigate.toNewPage(DecorationPassCardTypePage());
        break;
      case '会议室预定':
        Navigate.toNewPage(ReservationListTabPage());
        break;
      case '水牌名牌':
        Navigate.checkCustomerCertified(context, BrandNameCreate());
        break;
      case '写字楼退租':
        Navigate.checkCustomerCertified(context, OfficeCancelLeaseApplyPage());
        break;
      case '新房入伙':
        Navigate.toNewPage( NewHouseStepPage(0));
        break;
      case '预约到访':
        Navigate.toNewPage(VisitorReleaseCreate());
        break;
      case '家电安装':
        Navigate.checkCustomerCertified(
            context,
            PayServiceWorkOtherListPage(WorkOtherSubType.InstallPaid, [
              WorkOtherSubType.RepairPaid,
              WorkOtherSubType.InstallPaid,
              WorkOtherSubType.CleaningPaid,
              WorkOtherSubType.HousePaid,
              WorkOtherSubType.OtherPaid
            ]));
        break;
      case '家政维修':
        Navigate.checkCustomerCertified(
            context,
            PayServiceWorkOtherListPage(WorkOtherSubType.RepairPaid, [
              WorkOtherSubType.InstallPaid,
              WorkOtherSubType.RepairPaid,
              WorkOtherSubType.CleaningPaid,
              WorkOtherSubType.HousePaid,
              WorkOtherSubType.OtherPaid
            ]));
        break;
      case '房屋维修':
        Navigate.checkCustomerCertified(
            context,
            PayServiceWorkOtherListPage(WorkOtherSubType.HousePaid, [
              WorkOtherSubType.InstallPaid,
              WorkOtherSubType.RepairPaid,
              WorkOtherSubType.CleaningPaid,
              WorkOtherSubType.HousePaid,
              WorkOtherSubType.OtherPaid
            ]));
        break;
      case '其他服务':
        Navigate.checkCustomerCertified(
            context,
            PayServiceWorkOtherListPage(WorkOtherSubType.OtherPaid, [
              WorkOtherSubType.InstallPaid,
              WorkOtherSubType.RepairPaid,
              WorkOtherSubType.CleaningPaid,
              WorkOtherSubType.HousePaid,
              WorkOtherSubType.OtherPaid
            ]));
        break;
      case '周边信息':
        Navigate.toNewPage(NearInfoListPage());
        break;
      case '社区活动':
        Navigate.checkCustomerCertified(context, CommunityActivityPage());
        break;
      case '资讯':
        if(stateModel.defaultProjectId==null){
          CommonToast.show(type:ToastIconType.INFO,msg: '请先选择社区');
        }else{
          Navigate.toNewPage(PgcInfomationListPage());
        }
        break;
      case '社区商圈':
      case '社区商圈':
        if(stateModel.defaultProjectId == null){
          CommonToast.show(type: ToastIconType.INFO,msg: "请先选择社区");
        }else {
          SharedPreferences prefs = await SharedPreferencesKey.globalPrefs;
          String token = prefs.getString(SharedPreferencesKey.KEY_ACCESS_TOEKN);
          Navigate.toNewPage(HtmlPage("${HttpOptions.baseUrl.replaceAll(
              "ubms-customer/",
              "")}template/appShare/communityBusinessList.html?projectId=${stateModel
              .defaultProjectId}&token=$token", "", showTitle: false,));
        }
          break;
      case '说说':
        if(stateModel.defaultProjectId == null){
          CommonToast.show(type: ToastIconType.INFO,msg: "请先选择社区");
        }else {
          SharedPreferences prefs = await SharedPreferencesKey.globalPrefs;
          String token = prefs.getString(SharedPreferencesKey.KEY_ACCESS_TOEKN);
          Navigate.toNewPage(HtmlPage("${HttpOptions.baseUrl.replaceAll(
              "ubms-customer/",
              "")}template/appShare/talkAboutList.html?projectId=${stateModel
              .defaultProjectId}&token=$token", "", showTitle: false,));
        }
        break;
      case '社区话题':
      case '社区话题':
        if(stateModel.defaultProjectId == null){
          CommonToast.show(type: ToastIconType.INFO,msg: "请先选择社区");
        }else {
          SharedPreferences prefs = await SharedPreferencesKey.globalPrefs;
          String token = prefs.getString(SharedPreferencesKey.KEY_ACCESS_TOEKN);
          Navigate.toNewPage(HtmlPage("${HttpOptions.baseUrl.replaceAll(
              "ubms-customer/",
              "")}template/appShare/topicList.html?projectId=${stateModel
              .defaultProjectId}&token=$token", "", showTitle: false,));
        }
        break;
      case '邻里集市':
        if(stateModel.defaultProjectId==null){
          CommonToast.show(type:ToastIconType.INFO,msg: '请先选择社区');
        }else{
          SharedPreferences prefs = await SharedPreferencesKey.globalPrefs;
//                      prefs.setBool(SharedPreferencesKey.KEY_SHOW_MARKET_STATEMENT, true); //测试数据
          bool showMarketStatement =
              prefs.getBool(SharedPreferencesKey.KEY_SHOW_MARKET_STATEMENT) ?? true;
          if (showMarketStatement) {
            CommonDialog.showAlertDialog(context,
                title: '邻里集市免责申明',
                content: StatefulBuilder(
                    key: _marketStatementDialogKey,
                    builder: (context, state) {
                      return ListView(
                        shrinkWrap: true,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize16),
                            child: CommonText.darkGrey14Text(stateModel.marketStatement ?? '',
                                height: 1.2, overflow: TextOverflow.fade),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize8),
                            child: CommonCheckBox(
                                text: '我已充分了解以上申明，下次不再提示', fontSize: UIData.fontSize12,
                                value: _marketStatementCheck,
                                onChanged: (value) {
                                  _marketStatementDialogKey.currentState.setState(() {
                                    _marketStatementCheck = value;
//                                          prefs.setBool(SharedPreferencesKey.KEY_MARKET_STATEMENT, !value);
                                  });
                                }),
                          )
                        ],
                      );
                    }),
                showNegativeBtn: false,
                positiveBtnText: '我知道了', onConfirm: () {
                  if (_marketStatementCheck){
                    prefs.setBool(SharedPreferencesKey.KEY_SHOW_MARKET_STATEMENT, false);
                    _marketStatementCheck = false;
                  }
                  Navigate.toNewPage(MarketListPage());
                });
          } else {
            Navigate.toNewPage(MarketListPage());
          }
        }
        break;
      case '绿萝行动':
        if (2 == stateModel?.customerType && stateModel.hasHouse) {
          Navigate.toNewPage(HtmlPage(HttpOptions.getLvluoUrl(stateModel.userAccount), title ?? tag ?? ''));
        }else {
          CommonDialog.showUncertifiedDialog(context, content: '很抱歉，您当前身份是游客，\n请完成房屋认证后方可参加活动哦');
        }
        break;
      case '美伦体检':
        if (2 == stateModel?.customerType &&
            stateModel.customerId != null &&
            stateModel.defaultProjectId != null &&
            stateModel.defaultHouseId != null) {
          stateModel.getMeiLunUrl(callback: (String url){
            if(StringsHelper.isNotEmpty(url)){
            Navigate.toNewPage(HtmlPage(url, title ?? tag ?? ''));
            }else{
              CommonToast.show(msg: '暂无信息，请联系管理员', type: ToastIconType.INFO);
            }
          });
        } else {
          CommonDialog.showUncertifiedDialog(context);
        }
        break;
    }
  }


  void clearToken() async {
    SharedPreferences prefs = await SharedPreferencesKey.globalPrefs;
    if (prefs.containsKey(SharedPreferencesKey.KEY_ACCESS_TOEKN))
      prefs.remove(SharedPreferencesKey.KEY_ACCESS_TOEKN);
    if (prefs.containsKey(SharedPreferencesKey.KEY_REFRESH_TOEKN))
      prefs.remove(SharedPreferencesKey.KEY_REFRESH_TOEKN);
  }

  void logout(){
    clearToken();
    stateModel.clearUserData();
    if (Platform.isIOS) {
      stateModel.jPush.setBadge(0).then((map) {
        LogUtils.printLog("setBadge success: $map");
      }).catchError((error) {
        LogUtils.printLog("setBadge error: $error");
      });
    }
    stateModel.jPush.deleteAlias().then((map) {
//    stateModel.jPush.setAlias('18927571046').then((map) { //测试数据
      LogUtils.printLog("deleteAlias success: $map");
    }).catchError((error, stackTrace) {
      LogUtils.printLog("deleteAlias error: $error");
    });
    navigatorKey.currentState.pushNamedAndRemoveUntil(Constant.pageLogin, ModalRoute.withName('/'));
  }

  static CommonStateModel of(context) => ScopedModel.of<CommonStateModel>(context);
}
