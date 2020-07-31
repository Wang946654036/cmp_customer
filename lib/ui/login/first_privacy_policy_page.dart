import 'dart:io';

import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/shared_preferences_key.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'privacy_policy_page.dart';

///
/// Created by qianlx on 2019/12/10 4:17 PM.
/// 首次打开显示的隐私条款声明页面
///
class FirstPrivacyPolicyPage extends StatefulWidget {
  @override
  _FirstPrivacyPolicyPageState createState() => _FirstPrivacyPolicyPageState();
}

class _FirstPrivacyPolicyPageState extends State<FirstPrivacyPolicyPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildBody() {
    return Container(
      color: UIData.primaryColor,
      child: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize16, vertical: UIData.spaceSize16),
            child: CommonText.grey14Text('请您充分了解在注册后使用本软件过程中我们可能收集或使用您的个人信息的情形，希望您着重关注：',
                overflow: TextOverflow.fade, height: 1.5),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize40, vertical: UIData.spaceSize16),
            child: CommonText.darkGrey16Text('为您提供网上购物服务', overflow: TextOverflow.fade),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize40),
            child: CommonText.grey14Text('为完成创建账号，您需提供以下信息：您的姓名、电子邮箱地址、创建的用户名和密码。',
                overflow: TextOverflow.fade, height: 1.5),
          ),
          SizedBox(height: UIData.spaceSize16),
          Container(
            padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize40, vertical: UIData.spaceSize16),
            child: CommonText.darkGrey16Text('为改善产品或服务', overflow: TextOverflow.fade),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize40),
            child: CommonText.grey14Text('我们收集数据是根据您与我们的互动和您所做出的选择，包括您的隐私设置以及您使用的产品和功能。',
                overflow: TextOverflow.fade, height: 1.5),
          ),
          SizedBox(height: UIData.spaceSize30),
          Container(
            padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize16, vertical: UIData.spaceSize16),
            child: RichText(
                text: TextSpan(children: <TextSpan>[
              TextSpan(text: '关于您个人信息的相关问题请详见', style: CommonText.grey14TextStyle(height: 1.5)),
              TextSpan(
                  text: '《招商到家汇隐私条款》',
                  style: CommonText.red14TextStyle(),
                  recognizer: TapGestureRecognizer()..onTap = () => Navigate.toNewPage(PrivacyPolicyPage())),
              TextSpan(
                  text: '全文，请您认真阅读并充分理解。我们会不断完善技术和安全管理，并会尽全力保护您的个人信息安全可靠。',
                  style: CommonText.grey14TextStyle(height: 1.5))
            ])),
          ),
        ],
      ),
    );
  }


  Widget _buildBottomNavigationBar(){
    return StadiumSolidWithTowButton(
      cancelText: "不同意",
      onCancel: () {
        exit(0);
      },
      conFirmText: "同意",
      onConFirm: () async{
        SharedPreferences prefs = await SharedPreferencesKey.globalPrefs;
        prefs.setBool(SharedPreferencesKey.KEY_FIRST_TIME_OPEN, false);
        Navigator.of(context).pushReplacementNamed(Constant.pageLogin);
//        if (widget.callback != null) widget.callback();
//        Navigator.of(context).pop();
      },
      padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize30, vertical: UIData.spaceSize10),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      showLeftButton: false,
      appTitle: Expanded(
          child: Container(
        child: CommonText.darkGrey18Text('感谢下载到家汇'),
      )),
      bodyData: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}
