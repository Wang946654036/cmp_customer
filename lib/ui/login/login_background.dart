import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'privacy_policy_page.dart';

class LoginBackground extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Flexible(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
//                margin: EdgeInsets.only(top: ScreenUtil().setHeight(52), bottom: ScreenUtil().setHeight(4)),
              margin: EdgeInsets.only(bottom: UIData.spaceSize4),
                width: ScreenUtil.getInstance().setWidth(74),
                height: ScreenUtil.getInstance().setHeight(74),
//                      margin: EdgeInsets.only(top: 30.0),
                child: Image.asset(
                  UIData.imageLoginLogo,
                  fit: BoxFit.contain,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
                      child: CommonText.darkGrey18Text('招商到家汇', fontWeight: FontWeight.bold)),
                ],
              ),
                  CommonText.darkGrey15Text('${HttpOptions.baseUrl ==
                      HttpOptions.urlProduction ? 'V' : ''}${stateModel.version}'),
            ],
          ),
        ),
        Flexible(
            flex: 3,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Visibility(
//                visible: model.loginBottomVisible,
                  child: Container(
                    padding: EdgeInsets.only(bottom: UIData.spaceSize30),
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CommonText.lightGrey12Text('登录即代表您已经同意'),
                        GestureDetector(
                          child: CommonText.grey12Text('招商到家汇隐私条款'),
                          onTap: ()=> Navigate.toNewPage(PrivacyPolicyPage()),
                        ),
                      ],
                    ),
                  )),
            ))
      ],
    );
  }
}
