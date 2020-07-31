import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';

import 'common_scaffold.dart';
import 'common_text.dart';

class ErrorPage extends StatelessWidget {
  final FlutterErrorDetails error;

  ErrorPage(this.error);

  Widget _buildBody() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 100.0,
            margin: EdgeInsets.only(bottom: 15.0),
            child: Image(image: AssetImage(UIData.imageError), fit: BoxFit.fitWidth,)),
          CommonText.lightGrey15Text('页面错误，请联系客服'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appTitle: '错误提示',
      bodyData: _buildBody(),
    );
  }
}
