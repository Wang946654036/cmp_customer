import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_text_field.dart';
import 'package:cmp_customer/ui/me/common_me_single_row.dart';
import 'package:cmp_customer/ui/me/modify_phone_no_page.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';

///
/// 验证验证码页面
///
class CheckVerificationCodePage extends StatefulWidget {
  @override
  _CheckVerificationCodePageState createState() => _CheckVerificationCodePageState();
}

class _CheckVerificationCodePageState extends State<CheckVerificationCodePage> {
  final FocusNode _codeFocusNode = FocusNode();
  String _code;

  ///
  /// 调验证验证码接口
  ///
  void _check() {
    FocusScope.of(context).requestFocus(FocusNode());
    stateModel.checkVerificationCode(
        mobile: stateModel.userAccount,
        code: _code,
        callBack: () => navigatorKey.currentState.pushReplacementNamed(Constant.pageModifyPhoneNo));
  }

  Widget _buildBody() {
    return Container(
//        color: UIData.primaryColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
              color: UIData.primaryColor,
              padding: EdgeInsets.all(UIData.spaceSize16),
              child: CommonText.darkGrey15Text('更换手机号前需要验证身份')),
          CommonSingleInputRow('手机号码', content: stateModel.userAccount, arrowVisible: false),
          CommonSingleInputRow('验证码',
              content: Row(
                children: <Widget>[
                  Expanded(
                      child: LoginTypeTextField(
                    //验证码输入框
//                      controller: _pwdController,
                    hintText: '请输入验证码',
                    focusNode: _codeFocusNode,
                    textInputAction: TextInputAction.go,
                    keyboardType: TextInputType.number,
                    showCancelBtn: false,
                    onSubmitted: (value) {
                      _check();
                    },
                    onChanged: (String value) {
                      setState(() {
                        _code = value;
                      });
                    },
                  )),
                  CommonCountDownButton(phoneNo: stateModel.userAccount),
//                  GestureDetector(
//                    child: Container(
//                      child: CommonText.red14Text('获取验证码'),
//                    ),
//                    onTap: (){
//                      if(_phoneNo == null || _phoneNo.isEmpty){
//                        Toast.show('请输入手机号', context);
//                        return;
//                      }
//                      MainStateModel.of(context).getVerificationCode(mobile: _phoneNo);
//                    },
//                  )
                ],
              ),
              arrowVisible: false),
          SizedBox(height: UIData.spaceSize30),
          StadiumSolidButton(
            '下一步',
            onTap: _check,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appTitle: '修改手机号',
      bodyData: _buildBody(),
    );
  }
}
