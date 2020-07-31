import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/me/common_me_single_row.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';

///
/// 性别
///
class SexSelectionPage extends StatefulWidget {
  @override
  _SexSelectionPageState createState() => _SexSelectionPageState();
}

class _SexSelectionPageState extends State<SexSelectionPage> {
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
      color: UIData.primaryColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          MeSingleLine('男', content: UIData.iconTick, arrowVisible: false),
          CommonDivider(),
          MeSingleLine('女', content: UIData.iconTick, arrowVisible: false),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appTitle: '性别',
      bodyData: _buildBody(),
      appBarActions: [
        IconButton(icon: CommonText.red16Text('保存'), onPressed: (){

        })
      ],
    );
  }
}
