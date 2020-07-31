import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///
/// 隐私权政策页面
///
class PrivacyPolicyPage extends StatefulWidget {
  @override
  _PrivacyPolicyPageState createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage>{
//  String pathPDF = "";
String _content;

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/files/privacy-policy.txt').then((value){
      setState(() {
        _content = value;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appTitle: '招商到家汇隐私条款',
      bodyData: Container(
        color: UIData.primaryColor,
        child: ListView(
        padding: EdgeInsets.only(left: UIData.spaceSize16, right: UIData.spaceSize16, bottom: UIData.spaceSize16),
          children: <Widget>[
            CommonText.darkGrey14Text(_content ?? '', overflow: TextOverflow.fade, height: 1.5)
          ],
        ),
      ),
    );
  }
}
