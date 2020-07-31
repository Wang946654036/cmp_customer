
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';


//停车协议
class DecorationApplyTips extends StatelessWidget {
String title;
String data;
  DecorationApplyTips({this.title,this.data});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CommonScaffold(
      appTitle:title?? "温馨提示",
      bodyData: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: UIData.spaceSize16, vertical: UIData.spaceSize12),
          child: Text(
            data??'',
            style: TextStyle(
                color: UIData.darkGreyColor, fontSize: UIData.fontSize16),
          ),
        ),
      ),
    );
  }
}
