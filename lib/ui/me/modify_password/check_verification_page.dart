import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_text_field.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';

import 'modify_pwd_page.dart';
//import 'package:toast/toast.dart';

class CheckVerificationPage extends StatefulWidget {
  final String mobile;
  final bool editMobile;

  CheckVerificationPage({this.mobile, this.editMobile = true});

  @override
  CheckVerificationPageState createState() => CheckVerificationPageState();
}

class CheckVerificationPageState extends State<CheckVerificationPage> {
  final TextEditingController _accountController = new TextEditingController();
  final TextEditingController _verController = new TextEditingController(); //验证码
//  bool _loginProgressVisible = false; //登录等待转圈圈

  FocusNode _accountFocusNode = FocusNode();
  FocusNode _verFocusNode = FocusNode(); //验证码

  String _phoneNo;
  String _verCode;

  @override
  void initState() {
    super.initState();
    if(StringsHelper.isNotEmpty(widget.mobile) && StringsHelper.isPhone(widget.mobile)){
      _phoneNo = widget.mobile;
      _accountController.text = widget.mobile;
    }
    _accountController.addListener((){
      setState(() {});
    });
  }

  _checkCode() {
    FocusScope.of(context).requestFocus(new FocusNode());
    _phoneNo = _accountController.text;
    if (_phoneNo == null || _phoneNo.isEmpty) {
      CommonToast.show(msg: '请输入手机号码', type: ToastIconType.INFO);
      return;
    } else if (!StringsHelper.isPhone(_phoneNo)) {
      CommonToast.show(msg: '请输入正确的手机号码', type: ToastIconType.INFO);
      return;
    }
    if (_verCode == null || _verCode.isEmpty) {
      CommonToast.show(msg: '请输入验证码', type: ToastIconType.INFO);
      return;
    }
//    _loginSuccess(true);//测试数据
//    setState(() {
//      _loginProgressVisible = true;
//    });
    stateModel.verificationCodeByModifyPwd(mobile: _phoneNo, code: _verCode,
        callBack: ({String errorMsg}) {
//          setState(() {
//            _loginProgressVisible = false;
//          });
          if (errorMsg == null) {
            Navigate.closePage();
            Navigate.toNewPage(ModifyPwdPage(mobile: _phoneNo));
          }
        });
//    stateModel.login(
//        mobile: _phoneNo,
//        code: _verCode,
//        callBack: ({String errorMsg}) {
////          setState(() {
////            _loginProgressVisible = false;
////          });
//          if (errorMsg == null) {
//            Navigate.toNewPage(ModifyPwdPage());
//          }
//        });
//    Navigator.of(context).pushReplacementNamed(Constant.pageMain); //测试数据
//    MainStateModel.of(context).login(UserLoginType.LOGIN_PAGE, callBack: _loginSuccess);
  }

  Widget _buildBody() {
    return Container(
      color: UIData.primaryColor,
      padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize18),
//      margin: EdgeInsets.only(top: UIData.spaceSize40),
      child: ListView(
        children: <Widget>[
//          Container(
//            padding: EdgeInsets.only(bottom: UIData.spaceSize16),
//            child: CommonText.darkGrey18Text('设置新密码-验证身份', textAlign: TextAlign.center),
//          ),
          Container(
//                    decoration: BoxDecoration(
//                        color: UIData.primaryColor,
//                        border: Border(bottom: BorderSide(color: UIData.dividerColor, width: 1))),
            child: LoginTypeTextField(
              //账号输入框
              controller: _accountController,
              hintText: '请输入手机号码',
              focusNode: _accountFocusNode,
              maxLength: 11,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
              enabled: widget.editMobile,
              onSubmitted: (value) {
                FocusScope.of(context).requestFocus(_verFocusNode);
              },
              onChanged: (String value) {
                setState(() {
                  _phoneNo = value;
                });
              },
            ),
          ),
          SizedBox(height: UIData.spaceSize4),
          Container(
//                    decoration: BoxDecoration(
//                        color: UIData.primaryColor,
//                        border: Border(bottom: BorderSide(color: UIData.dividerColor, width: 1))),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: LoginTypeTextField(
                  //验证码输入框
                  controller: _verController,
                  hintText: '请输入验证码',
                  focusNode: _verFocusNode,
                  maxLength: 4,
                  textInputAction: TextInputAction.go,
                  keyboardType: TextInputType.number,
                  showCancelBtn: false,
                  onSubmitted: (value) {
                    _checkCode();
                  },
                  onChanged: (String value) {
                    setState(() {
                      _verCode = value;
                    });
                  },
                )),
                CommonCountDownButton(phoneNo: _accountController.text, smsType: VerifySmsType.MODIFYPWD),
              ],
            ),
          ),
          SizedBox(height: UIData.spaceSize40),
          StadiumSolidButton(
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
//                          Visibility(
//                              visible: _loginProgressVisible,
//                              child: SizedBox(
//                                width: 15.0,
//                                height: 15.0,
//                                child: CircularProgressIndicator(
//                                    strokeWidth: 2.0, valueColor: AlwaysStoppedAnimation(UIData.primaryColor)),
//                              )),
                  SizedBox(width: 10.0),
                  CommonText.white17Text('下一步'),
                ],
              ), onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
//                    if (MainStateModel.of(context).userAccount == null ||
//                        MainStateModel.of(context).userAccount.isEmpty) {
//                      Toast.show('请输入手机号', context);
//                      return;
//                    }
//                    if (MainStateModel.of(context).password == null ||
//                        MainStateModel.of(context).password.isEmpty) {
//                      Toast.show('请输入密码', context);
//                      return;
//                    }
            _checkCode();
          }, margin: EdgeInsets.symmetric(vertical: UIData.spaceSize10))
        ],
      ),
    );
//    return SingleChildScrollView(
//        child: Column(
//          children: <Widget>[
////            SizedBox(
////              height: ScreenUtil().setHeight(80),
////            ),
//            Container(
//              color: UIData.primaryColor,
//              padding: EdgeInsets.fromLTRB(UIData.spaceSize18, 0.0, UIData.spaceSize18, UIData.spaceSize18),
//              margin: EdgeInsets.only(top: UIData.spaceSize40),
//              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.stretch,
//                children: <Widget>[
//                  Container(
////                    decoration: BoxDecoration(
////                        color: UIData.primaryColor,
////                        border: Border(bottom: BorderSide(color: UIData.dividerColor, width: 1))),
//                    child: LoginTypeTextField(
//                      //账号输入框
//                      controller: _accountController,
//                      hintText: '请输入手机号登录',
//                      focusNode: _accountFocusNode,
//                      maxLength: 11,
//                      textInputAction: TextInputAction.next,
//                      keyboardType: TextInputType.phone,
//                      onSubmitted: (value) {
//                        FocusScope.of(context).requestFocus(_verFocusNode);
//                      },
//                      onChanged: (String value) {
//                        setState(() {
//                          _phoneNo = value;
//                        });
//                      },
//                    ),
//                  ),
//                  SizedBox(height: UIData.spaceSize4),
//                  Container(
////                    decoration: BoxDecoration(
////                        color: UIData.primaryColor,
////                        border: Border(bottom: BorderSide(color: UIData.dividerColor, width: 1))),
//                    child: Row(
//                      children: <Widget>[
//                        Expanded(
//                            child: LoginTypeTextField(
//                              //验证码输入框
//                              controller: _verController,
//                              hintText: '请输入验证码',
//                              focusNode: _verFocusNode,
//                              maxLength: 4,
//                              textInputAction: TextInputAction.go,
//                              keyboardType: TextInputType.number,
//                              showCancelBtn: false,
//                              onSubmitted: (value) {
//                                _login();
//                              },
//                              onChanged: (String value) {
//                                setState(() {
//                                  _verCode = value;
//                                });
//                              },
//                            )),
//                        CommonCountDownButton(phoneNo: _phoneNo, smsType: VerifySmsType.MODIFYPWD),
//                      ],
//                    ),
//                  ),
//                  SizedBox(height: UIData.spaceSize40),
//                  RadiusSolidButton(
//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: <Widget>[
////                          Visibility(
////                              visible: _loginProgressVisible,
////                              child: SizedBox(
////                                width: 15.0,
////                                height: 15.0,
////                                child: CircularProgressIndicator(
////                                    strokeWidth: 2.0, valueColor: AlwaysStoppedAnimation(UIData.primaryColor)),
////                              )),
//                          SizedBox(width: 10.0),
//                          CommonText.white17Text('下一步'),
//                        ],
//                      ), onTap: () {
//                    FocusScope.of(context).requestFocus(new FocusNode());
////                    if (MainStateModel.of(context).userAccount == null ||
////                        MainStateModel.of(context).userAccount.isEmpty) {
////                      Toast.show('请输入手机号', context);
////                      return;
////                    }
////                    if (MainStateModel.of(context).password == null ||
////                        MainStateModel.of(context).password.isEmpty) {
////                      Toast.show('请输入密码', context);
////                      return;
////                    }
//                    _login();
//                  }, margin: EdgeInsets.symmetric(vertical: UIData.spaceSize10)),
//                ],
//              ),
//            ),
//          ],
//        ),
//    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      backGroundColor: UIData.primaryColor,
      appTitle: '验证身份',
      bodyData: _buildBody(),
    );
  }
}
