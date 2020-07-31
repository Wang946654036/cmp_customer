import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_text_field.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';

///
/// 注册
///
class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _phoneNoController = new TextEditingController();
  final FocusNode _codeFocusNode = FocusNode();
  String _phoneNo;
  String _code;

  ///
  /// 调注册接口
  ///
  void _register() {
    FocusScope.of(context).requestFocus(FocusNode());
    stateModel.register(mobile: _phoneNo, code: _code);
  }

  Widget _buildBody() {
    return Container(
//        color: UIData.primaryColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CommonSingleInputRow('手机号码',
              content: LoginTypeTextField(
                //账号输入框
                controller: _phoneNoController,
                hintText: '请输入手机号码',
//              focusNode: _accountFocusNode,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                onSubmitted: (value) {
                  FocusScope.of(context).requestFocus(_codeFocusNode);
                },
                onChanged: (String value) {
                  setState(() {
                    _phoneNo = value;
                  });
                },
              ),
              arrowVisible: false),
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
                      _register();
                    },
                    onChanged: (String value) {
                      setState(() {
                        _code = value;
                      });
                    },
                  )),
                  CommonCountDownButton(phoneNo: _phoneNo),
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
            '确认',
            onTap: _register,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appTitle: '注册',
      bodyData: _buildBody(),
    );
  }
}
