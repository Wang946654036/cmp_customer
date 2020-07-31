import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/parking/parking_card_ui.dart';
import 'package:flutter/material.dart';

//文本提示页面
class TipPage extends StatelessWidget {
  String title;
  String tip;
  TipPage(this.title,this.tip);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CommonScaffold(
        appTitle: title??"提示",
        bodyData: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontal_spacing,vertical: vertical_spacing),
          child: CommonText.darkGrey16Text(tip??""),
        )
    );
  }
}
