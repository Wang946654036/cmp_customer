import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/common/common_select_model.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';

///
/// 通用单选页面
///
class CommonSelectPage extends StatefulWidget {
  final String title;
  final List<String> list;
  final int index;

  CommonSelectPage(this.title,this.list, this.index);

  @override
  _CommonSelectState createState() => _CommonSelectState();
}

class _CommonSelectState extends State<CommonSelectPage> {
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
      child: ListView.separated(
        shrinkWrap: true,
          itemBuilder: (context, index) {
            String name = widget.list[index];
            return ListTile(
              title: CommonText.darkGrey15Text( name??""),
              trailing: widget.index == index ? UIData.iconTick : null,
              onTap: ()=> navigatorKey.currentState.pop(index),
            );
          }, separatorBuilder: (context, index) {
        return CommonDivider();
      }, itemCount: widget.list.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appTitle: widget.title??"",
      bodyData: _buildBody(),
    );
  }
}
