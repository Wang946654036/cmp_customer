import 'dart:io';

import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/dictionary_list.dart';
import 'package:cmp_customer/ui/work_other/work_other_ui.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/share_util.dart';
import 'package:cmp_customer/utils/shared_preferences_key.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    stateModel.clearUserData();
    _init();
//    Future.delayed(Duration(seconds: 3)).whenComplete(() {
//      _init();
////      _go2Home(); //测试数据
//    });
//    stateModel.jPush.deleteAlias().then((map) {
//      LogUtils.printLog("deleteAlias success: $map");
//    }).catchError((error, stackTrace) {
//      LogUtils.printLog("deleteAlias error: $error");
//      reportError(error, stackTrace);
//    });
  }

  _init() async {
    SharedPreferences prefs = await SharedPreferencesKey.globalPrefs;
//    prefs.setBool(SharedPreferencesKey.KEY_FIRST_TIME_OPEN, true); //测试数据
    bool firstTime = prefs.getBool(SharedPreferencesKey.KEY_FIRST_TIME_OPEN) ?? true;
    if (firstTime) {
//      prefs.setBool(SharedPreferencesKey.KEY_FIRST_TIME_OPEN, false);
      Future.delayed(Duration(seconds: 2)).whenComplete(() {
        _go2Intro();
      });
    } else if (prefs.getString(SharedPreferencesKey.KEY_REFRESH_TOEKN) == null) {
      Future.delayed(Duration(seconds: 2)).whenComplete(() {
        _go2Login();
      });
    } else {
      Future.delayed(Duration(seconds: 1)).whenComplete(() {
        _go2Home();
      });
//      prefs.setString(SharedPreferencesKey.KEY_ACCESS_TOEKN, '111'); //测试数据
//      stateModel.getUserData(
//          loginTag: true,
//          callBack: ({String errorMsg}) {
////        if (errorMsg == null) {
////          //成功，跳转首页
////          _go2Home();
////        } else {
////          //失败，跳转登录页面
//////          _go2Login();
////          //失败，关闭应用
////          Future.delayed(Duration(seconds: 2)).whenComplete(() {
////            exit(0);
////          });
////        }
//          });
    }
  }

  _go2Login() {
    Navigator.of(context).pushReplacementNamed(Constant.pageLogin);
  }

  _go2Home() {
    Navigator.of(context).pushReplacementNamed(Constant.pageMain);
  }

  _go2Intro() {
    Navigator.of(context).pushReplacementNamed(Constant.pageIntro);
  }

  @override
  Widget build(BuildContext context) {
    //设置适配尺寸 (填入设计稿中设备的屏幕尺寸) 假如设计稿是按iPhone6的尺寸设计的(iPhone6 750*1334)
    ScreenUtil.instance = ScreenUtil(width: 375, height: 667, allowFontScaling: true)..init(context);
    //初始化分享控件
    ShareUtil.init();
    return Container(
      color: UIData.primaryColor,
      child: Image.asset(
        UIData.imageWelcome,
        fit: BoxFit.cover,
      ),
    );
  }
}
