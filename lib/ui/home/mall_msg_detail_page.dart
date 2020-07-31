import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';

///
/// Created by qianlx on 2020/6/18 3:12 PM.
/// 商城消息详情界面
///
class MallMsgDetailPage extends StatefulWidget {
  final String title;
  final String content;

  MallMsgDetailPage(this.title, this.content);

  @override
  _MallMsgDetailPageState createState() => _MallMsgDetailPageState();
}

class _MallMsgDetailPageState extends State<MallMsgDetailPage> {
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appTitle: '商城',
      bodyData: Container(
        color: UIData.primaryColor,
        padding: EdgeInsets.only(bottom: UIData.spaceSize16, left: UIData.spaceSize16, right: UIData.spaceSize16),
        child: ListView(
          children: <Widget>[
            CommonText.darkGrey16Text(widget.title ?? '', overflow: TextOverflow.fade),
            SizedBox(height: UIData.spaceSize12),
            CommonText.darkGrey14Text(widget.content ?? '', overflow: TextOverflow.fade),
          ]
        ),
      ),
    );
  }
}
