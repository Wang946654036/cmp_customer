import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_dialog.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_text_field.dart';
import 'package:cmp_customer/ui/login/register_page.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/me/modify_password/check_verification_page.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tip_dialog/tip_dialog.dart';

import '../../main.dart';

//import 'package:toast/toast.dart';
//import 'package:toast/toast.dart';

enum UserLoginType {
  Password, //密码登录
  Verification, //验证码登录
}

class LoginOperation extends StatefulWidget {
  @override
  LoginOperationState createState() => LoginOperationState();
}

class LoginOperationState extends State<LoginOperation> {
  final TextEditingController _accountController = new TextEditingController();
  final TextEditingController _verController = new TextEditingController(); //验证码
  final TextEditingController _pwdController = new TextEditingController(); //密码
  bool _loginProgressVisible = false; //登录等待转圈圈

  FocusNode _accountFocusNode = FocusNode();
  FocusNode _verFocusNode = FocusNode(); //验证码
  FocusNode _pwdFocusNode = FocusNode(); //密码

  String _phoneNo;
  String _verCode;
  String _pwdCode;

  UserLoginType _loginType; //登录方式

  @override
  void initState() {
    super.initState();
    _loginType = UserLoginType.Verification;
    stateModel.clearUserData();
//    stateModel.jPush.deleteAlias();
    _accountController.addListener((){
      setState(() {});
    });
    _pwdController.addListener((){
      setState(() {});
    });
  }

  _login() {
//    Navigator.of(context).pushReplacementNamed(Constant.pageMain);
//    return;
    FocusScope.of(context).requestFocus(new FocusNode());
    _phoneNo = _accountController.text;
    _pwdCode = _pwdController.text;
    if (_phoneNo == null || _phoneNo.isEmpty) {
      CommonToast.show(
          msg: '请输入手机号码', type: ToastIconType.INFO);
      return;
    } else if (!StringsHelper.isPhone(_phoneNo)) {
      CommonToast.show(msg: '请输入正确的手机号码', type: ToastIconType.INFO);
      return;
    }
    if (_loginType == UserLoginType.Verification && (_verCode == null || _verCode.isEmpty)) {
      CommonToast.show(msg: '请输入验证码', type: ToastIconType.INFO);
      return;
    }
    if (_loginType == UserLoginType.Password && (_pwdCode == null || _pwdCode.isEmpty)) {
      CommonToast.show(msg: '请输入密码', type: ToastIconType.INFO);
      return;
    }
//    _loginSuccess(true);//测试数据
    setState(() {
      _loginProgressVisible = true;
    });
    MainStateModel.of(context).login(
        mobile: _phoneNo,
        code: _loginType == UserLoginType.Verification ? _verCode : _pwdCode,
        loginType: _loginType,
        callBack: ({String errorMsg}) {
          setState(() {
            _loginProgressVisible = false;
          });
          if (errorMsg == null) {
            Navigator.of(context).pushReplacementNamed(Constant.pageMain);
          } else {
            if(errorMsg == '密码未设置'){
                CommonDialog.showAlertDialog(context, content: '您的账号未设置密码哦', contentFontSize: UIData.fontSize17,
                    positiveBtnText: '立即设置密码',
                    onConfirm: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      Navigate.toNewPage(CheckVerificationPage(mobile: _accountController.text));
                    }, negativeBtnText: '我再想想');
            }else{
              CommonToast.show(type: ToastIconType.FAILED, msg: errorMsg);
            }
          }
        });
//    Navigator.of(context).pushReplacementNamed(Constant.pageMain); //测试数据
//    MainStateModel.of(context).login(LoginType.LOGIN_PAGE, callBack: _loginSuccess);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: ScreenUtil().setHeight(80),
            ),
            Container(
              color: UIData.primaryColor,
              padding: EdgeInsets.fromLTRB(UIData.spaceSize18, 0.0, UIData.spaceSize18, UIData.spaceSize18),
              margin: EdgeInsets.only(top: UIData.spaceSize40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  LoginTypeTextField(
                    //账号输入框
                    controller: _accountController,
                    hintText: '请输入手机号码',
                    focusNode: _accountFocusNode,
                    textInputAction: TextInputAction.next,
                    keyboardType: _loginType == UserLoginType.Verification ? TextInputType.phone : TextInputType.text,
                    maxLength: 11,
                    onSubmitted: (value) {
                      _loginType == UserLoginType.Verification
                          ? FocusScope.of(context).requestFocus(_verFocusNode)
                          : FocusScope.of(context).requestFocus(_pwdFocusNode);
                    },
                    onChanged: (String value) {
                      setState(() {
                        _phoneNo = value;
                      });
                    },
                  ),
                  SizedBox(height: UIData.spaceSize4),
                  _loginType == UserLoginType.Verification
                      ? Row(
                    children: <Widget>[
                      Expanded(
                          child: LoginTypeTextField(
                        //验证码输入框
                        controller: _pwdController,
                        hintText: '请输入验证码',
                        focusNode: _pwdFocusNode,
                        maxLength: 4,
                        textInputAction: TextInputAction.go,
                        keyboardType: TextInputType.number,
                        showCancelBtn: false,
                        onSubmitted: (value) {
                          _login();
                        },
                        onChanged: (String value) {
                          setState(() {
                            _verCode = value;
                          });
                        },
                      )),
                      CommonCountDownButton(phoneNo: _phoneNo, smsType: VerifySmsType.LOGIN),
                    ],
                  ) : LoginTypeTextField(
                    //密码输入框
                    pwdVisible: true,
                    controller: _pwdController,
                    hintText: '请输入密码',
                    focusNode: _pwdFocusNode,
                    maxLength: 50,
                    textInputAction: TextInputAction.go,
                    keyboardType: TextInputType.visiblePassword,
//                            showCancelBtn: false,
                    onSubmitted: (value) {
                      _login();
                    },
                    onChanged: (String value) {
                      setState(() {
                        _pwdCode = value;
                      });
                    },
                  ),
                  SizedBox(height: UIData.spaceSize40),
//                  StadiumSolidWithTowButton(conFirmText: '确定', cancelText: '取消',),
                  StadiumSolidButton(
                      //登录按钮
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Visibility(
                              visible: _loginProgressVisible,
                              child: SizedBox(
                                width: 15.0,
                                height: 15.0,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2.0, valueColor: AlwaysStoppedAnimation(UIData.primaryColor)),
                              )),
                          SizedBox(width: 10.0),
                          CommonText.white16Text('登录'),
                        ],
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 0),
                      onTap: () {
                    _login();
                  }),
                  SizedBox(height: UIData.spaceSize12),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Visibility(
                            child: GestureDetector(
                              child: CommonText.grey15Text('忘记密码？'),
                              onTap: () {
                                FocusScope.of(context).requestFocus(new FocusNode());
                                Navigate.toNewPage(CheckVerificationPage(mobile: _accountController.text));
                              },
                            ),
                            visible: _loginType == UserLoginType.Password),
                        GestureDetector(
                          child: CommonText.grey15Text(
                              _loginType == UserLoginType.Verification ? '使用密码登录' : '使用验证码登录'),
                          onTap: () {
                            setState(() {
                              FocusScope.of(context).requestFocus(new FocusNode());
                              _loginType == UserLoginType.Verification
                                  ? _loginType = UserLoginType.Password
                                  : _loginType = UserLoginType.Verification;
                              _loginType == UserLoginType.Verification
                                  ? _verController.text = ''
                                  : _pwdController.text = '';
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: UIData.spaceSize30),
                  GestureDetector(
                    child: Text.rich(
                        TextSpan(children: <TextSpan>[
                          TextSpan(text: '还没有账号，', style: CommonText.darkGrey14TextStyle()),
                          TextSpan(text: '去注册', style: CommonText.red14TextStyle())
                        ]),
                        textAlign: TextAlign.center),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                          return RegisterPage();
                        })),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
