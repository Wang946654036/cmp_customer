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

import '../../../main.dart';

class ModifyPwdPage extends StatefulWidget {
  final String mobile;

  ModifyPwdPage({this.mobile});

  @override
  ModifyPwdPageState createState() => ModifyPwdPageState();
}

class ModifyPwdPageState extends State<ModifyPwdPage> {
  final TextEditingController _pwdController = new TextEditingController();
  final TextEditingController _confirmPwdController = new TextEditingController();

  FocusNode _pwdFocusNode = FocusNode();
  FocusNode _confirmPwdFocusNode = FocusNode();

  String _pwd;
  String _confirmPwd;

  int _pwdErrorIndex = -1; //密码错误规则

  @override
  void initState() {
    super.initState();
    _pwdController.addListener((){
      setState(() {});
    });
    _confirmPwdController.addListener((){
      setState(() {});
    });
  }

  void _setNewPwd() {
    FocusScope.of(context).requestFocus(new FocusNode());
    _pwd = _pwdController.text;
    _confirmPwd = _confirmPwdController.text;
    if (_pwd == null || _pwd.isEmpty) {
      CommonToast.show(msg: '请输入新密码', type: ToastIconType.INFO);
      return;
    }
    if (_confirmPwd == null || _confirmPwd.isEmpty) {
      CommonToast.show(msg: '请输入确认新密码', type: ToastIconType.INFO);
      return;
    }
    if (_pwd != _confirmPwd) {
      CommonToast.show(msg: '两次输入的密码不一致！', type: ToastIconType.INFO);
      return;
    }
    RegExp upCheck = RegExp(r".*[A-Z]+.*");
    RegExp lowCheck = RegExp(r".*[a-z]+.*");
    RegExp numberCheck = RegExp(r".*\d+.*");
//    RegExp sm = RegExp(r".*[_`~!@#$%^&*+=|{}':;',\\[\\].<>/?~！@#￥%……&*——+|{}【】‘；：’。，、？]+.*");
//    RegExp sm = RegExp(r".*[_`~!@#$%^&*+=|{}':;',\[\].<>/?~！@#￥%……&*——+|{}【】()（）‘；：’。，、？]+.*");
    RegExp sm = RegExp(".*[_`~!@#%^&*+=|{}:;,.<>\\\\/?~！@#￥%……&*——+|{}【】()（）“‘；：’”。，、？\$\'\"\\[\\]]+.*");
    int pwdCheck = 0;
    if (upCheck.hasMatch(_pwd)) {
      LogUtils.printLog('大写过');
      pwdCheck++;
    }
    if (lowCheck.hasMatch(_pwd)) {
      LogUtils.printLog('小写过');
      pwdCheck++;
    }
    if (numberCheck.hasMatch(_pwd)) {
      LogUtils.printLog('数字写过');
      pwdCheck++;
    }
    if (sm.hasMatch(_pwd)) {
      LogUtils.printLog('特殊字符过');
      pwdCheck++;
    }
    if (pwdCheck < 3) {
      setState(() {
        _pwdErrorIndex = 1;
      });
//      CommonToast.show(msg: '密码必须由三种不同字符类型组成，包含数字、小写字母、大写字母、特殊字符中至少3类', type: ToastIconType.INFO);
      return;
    }
    if (_pwd.length < 8 || _pwd.length > 16) {
      setState(() {
        _pwdErrorIndex = 2;
      });
//      CommonToast.show(msg: '密码长度必须在8-16位之间', type: ToastIconType.INFO);
      return;
    }
    if (StringsHelper.isSpecialChar(_pwd) || _pwd.contains(' ')) {
      setState(() {
        _pwdErrorIndex = 3;
      });
//      CommonToast.show(msg: '密码包含非法字符', type: ToastIconType.INFO);
      return;
    }

    stateModel.modifyPwd(mobile: widget.mobile, pwd: _pwd, callBack: (){
      Navigate.closePage();
    });
  }

  Widget _buildTip(String content, int index) {
    return Row(
      children: <Widget>[
        Icon(Icons.error,
            color: _pwdErrorIndex == index ? UIData.lightRedColor : UIData.lightGreyColor,
            size: UIData.fontSize13),
        CommonText.text13(content ?? '',
            color: _pwdErrorIndex == index ? UIData.lightRedColor : UIData.lightGreyColor),
        SizedBox(height: UIData.spaceSize4)
      ],
    );
  }

  Widget _buildBody() {
    return Container(
      color: UIData.primaryColor,
      padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize18),
//      margin: EdgeInsets.only(top: UIData.spaceSize40),
      child: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(vertical: UIData.spaceSize16),
            child: CommonText.darkGrey18Text('账号：${widget.mobile ?? ''}'),
          ),
          SizedBox(height: UIData.spaceSize4),
          Container(
            child: LoginTypeTextField(
              //密码输入框
              pwdVisible: true,
              controller: _pwdController,
              hintText: '请输入新密码',
              focusNode: _pwdFocusNode,
              maxLength: 50,
              textInputAction: TextInputAction.go,
              keyboardType: TextInputType.visiblePassword,
//                            showCancelBtn: false,
              onSubmitted: (value) {
                FocusScope.of(context).requestFocus(_confirmPwdFocusNode);
              },
              onChanged: (String value) {
                setState(() {
                  _pwd = value;
                });
              },
            ),
          ),
          SizedBox(height: UIData.spaceSize4),
          Container(
            child: LoginTypeTextField(
              //密码输入框
              pwdVisible: true,
              controller: _confirmPwdController,
              hintText: '请再次输入新密码',
              focusNode: _confirmPwdFocusNode,
              maxLength: 50,
              textInputAction: TextInputAction.go,
              keyboardType: TextInputType.visiblePassword,
//                            showCancelBtn: false,
              onSubmitted: (value) {
                FocusScope.of(context).requestFocus(new FocusNode());
                _setNewPwd();
              },
              onChanged: (String value) {
                setState(() {
                  _confirmPwd = value;
                });
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: UIData.spaceSize12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildTip('包含数字、小写字母、大写字母、特殊字符中至少3类', 1),
                _buildTip('长度为8~16个字符', 2),
                _buildTip("不能包含空格或（\$- ‘ ’ “ ” \' \"）符号类型", 3),
              ],
            ),
          ),
          SizedBox(height: UIData.spaceSize40),
          StadiumSolidButton(
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(width: 10.0),
                  CommonText.white17Text('确定'),
                ],
              ), onTap: () {
                setState(() {
                  _pwdErrorIndex = -1;
                });
            FocusScope.of(context).requestFocus(new FocusNode());
            _setNewPwd();
          }, margin: EdgeInsets.symmetric(vertical: UIData.spaceSize10))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      backGroundColor: UIData.primaryColor,
      appTitle: '设置新密码',
      bodyData: _buildBody(),
    );
  }
}
