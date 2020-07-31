import 'dart:io';

import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/ui/common/common_dialog.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/me/common_me_single_row.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/shared_preferences_key.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'modify_password/check_verification_page.dart';

///
/// 设置页面
///
class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

//  void _clearToken() async {
//    SharedPreferences prefs = await SharedPreferencesKey.globalPrefs;
//    if (prefs.containsKey(SharedPreferencesKey.KEY_ACCESS_TOEKN))
//      prefs.remove(SharedPreferencesKey.KEY_ACCESS_TOEKN);
//    if (prefs.containsKey(SharedPreferencesKey.KEY_REFRESH_TOEKN))
//      prefs.remove(SharedPreferencesKey.KEY_REFRESH_TOEKN);
//  }

  Widget _buildBottomNavigationBar() {
    return FlatButton(
      onPressed: () {
        CommonDialog.showAlertDialog(context, title: '退出登录？', onConfirm: () {
          stateModel.logout();
//          stateModel.clearToken();
//          stateModel.clearUserData();
//          if (Platform.isIOS) {
//            stateModel.jPush.setBadge(0).then((map) {
//              LogUtils.printLog("setBadge success: $map");
//            }).catchError((error) {
//              LogUtils.printLog("setBadge error: $error");
//            });
//          }
//          stateModel.jPush.deleteAlias().then((map) {
////    stateModel.jPush.setAlias('18927571046').then((map) { //测试数据
//            LogUtils.printLog("deleteAlias success: $map");
//          }).catchError((error, stackTrace) {
//            LogUtils.printLog("deleteAlias error: $error");
//          });
//          Navigator.of(context).pushNamedAndRemoveUntil(Constant.pageLogin, ModalRoute.withName('/'));
        });
      },
      child: CommonText.red16Text('退出登录'),
      color: UIData.primaryColor,
    );
  }

  Widget _buildBody() {
    return Container(
      color: UIData.primaryColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
//          MeSingleLine('开门提示语音', content: CupertinoSwitch(
//            value: true,
//            activeColor: UIData.themeBgColor,
//            onChanged: (bool value){
//
//            },
//          ), arrowVisible: false),
      ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
        return Visibility(
            visible: model.baseDataLoaded == 1, //0=加载中，1=加载成功，2=加载失败
            child: MeSingleLine(
          '修改手机号',
          onTap: () => Navigator.of(context).pushNamed(Constant.pageCheckVerificationCode),
        ));
      }),
      CommonDivider(),
      ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
        return Visibility(
            visible: model.baseDataLoaded == 1, //0=加载中，1=加载成功，2=加载失败
            child: MeSingleLine('修改密码',
                backgroundColor: Colors.transparent,
                onTap: () =>
                    Navigate.toNewPage(CheckVerificationPage(mobile: stateModel.userAccount, editMobile: false))));
      })

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appTitle: '设置',
      bodyData: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}
