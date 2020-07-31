import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/login/login_background.dart';
import 'package:cmp_customer/ui/login/login_operation.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    //设置适配尺寸 (填入设计稿中设备的屏幕尺寸) 假如设计稿是按iPhone6的尺寸设计的(iPhone6 750*1334)
//    ScreenUtil.instance = ScreenUtil(width: 375, height: 667, allowFontScaling: true)..init(context);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    return CommonScaffold(
                showAppBar: false,
                appBarBackgroundColor: UIData.primaryColor,
                backGroundColor: UIData.primaryColor,
                bodyData: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    LoginBackground(),
                    LoginOperation(),
                  ],
                ),
              );
  }
}
