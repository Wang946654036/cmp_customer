import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_text_field.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

///
/// 昵称
///
class NicknamePage extends StatefulWidget {
  final Function callBack;

  NicknamePage({this.callBack});

  @override
  _NicknamePageState createState() => _NicknamePageState();
}

class _NicknamePageState extends State<NicknamePage> {
  final TextEditingController _controller = new TextEditingController();
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller.text = stateModel.personalInfo?.nickName;
//    FocusScope.of(context).requestFocus(_focusNode);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildBody() {
    return Container(
      margin: EdgeInsets.only(top: UIData.spaceSize16),
      padding: EdgeInsets.only(left: UIData.spaceSize16),
      color: UIData.primaryColor,
      child: LoginTypeTextField(
        controller: _controller,
        hintText: '请输入昵称',
        focusNode: _focusNode,
        textInputAction: TextInputAction.send,
        autoFocus: true,
//        onSubmitted: (value) {
////              FocusScope.of(context).requestFocus(_pwdFocusNode);
//        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appTitle: '昵称',
      bodyData: _buildBody(),
      appBarActions: [
        FlatButton(
            child: CommonText.red16Text('保存'),
            onPressed: () {
              if (StringsHelper.isEmpty(_controller.text)) {
                CommonToast.show(msg: '请输入昵称', type: ToastIconType.INFO);
              } else {
//                if (widget.callBack != null) widget.callBack(_controller.text);

                FocusScope.of(context).requestFocus(FocusNode());
                stateModel.modifyPersonalInfo(
                    type: 1,
                    nickname: _controller.text,
                    callBack: (int type) {
                      setState(() {
                        if (type == 1) {
                          stateModel.personalInfo?.nickName = _controller.text;
                          Navigate.closePage();
                        }
                      });
                    });
              }
            })
      ],
    );
  }
}
