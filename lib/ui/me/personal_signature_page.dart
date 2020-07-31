import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_text_field.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';

///
/// 个性签名
///
class PersonalSignaturePage extends StatefulWidget {
  @override
  _PersonalSignaturePageState createState() => _PersonalSignaturePageState();
}

class _PersonalSignaturePageState extends State<PersonalSignaturePage> {
  final TextEditingController _controller = new TextEditingController();

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
      margin: EdgeInsets.only(top: UIData.spaceSize16),
      padding: EdgeInsets.only(left: UIData.spaceSize16),
      color: UIData.primaryColor,
      child: LoginTypeTextField(
        controller: _controller,
        hintText: '来说点什么吧',
//        focusNode: _focusNode,
        maxLength: 20,
        textInputAction: TextInputAction.send,
        onSubmitted: (value) {
//              FocusScope.of(context).requestFocus(_pwdFocusNode);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appTitle: '个性签名',
      bodyData: _buildBody(),
      appBarActions: [IconButton(icon: CommonText.red16Text('保存'), onPressed: () {})],
    );
  }
}
