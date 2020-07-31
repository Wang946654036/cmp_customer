import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/html/html_page.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';

///
/// 关于我们
///
class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String bottomStr = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage(UIData.imageAbout), context).whenComplete(() {
      setState(() {
        bottomStr = 'Copyright © 2019招商局物业管理有限公司版权所有 粤ICP备13077851号-1\n技术支持：广东亿迅科技有限公司（'
            '${HttpOptions.baseUrl == HttpOptions.urlProduction ? 'V' : ''}${stateModel.version}）';
      });
    });
    return CommonScaffold(
      appTitle: '关于我们',
//      bodyData: SingleChildScrollView(
//        child: Image(image: AssetImage(UIData.imageAbout), fit: BoxFit.fitWidth),
////        child: Stack(
////          alignment: Alignment.bottomCenter,
////          children: <Widget>[
////            Image(image: AssetImage(UIData.imageAbout), fit: BoxFit.fitWidth),
//////            Image.asset(UIData.imageAbout, fit: BoxFit.fitWidth),
////            Container(
////                margin: EdgeInsets.only(bottom: UIData.spaceSize16),
////                child: CommonText.lightGrey10Text(bottomStr,
////                    overflow: TextOverflow.fade, textAlign: TextAlign.center)),
////          ],
////        ),
//      ),
//      bottomNavigationBar: Container(
//          color: Color(0xFFF8F9FD),
//          padding: EdgeInsets.only(bottom: UIData.spaceSize16, top: UIData.spaceSize8),
//          child: Column(
//            children: <Widget>[
//              GestureDetector(
//                child: CommonText.text12('招商到家汇隐私条例', color: UIData.themeBgColor),
//                onTap: () => Navigate.toNewPage(HtmlPage(HttpOptions.urlAppShare + 'appText1.html', '招商到家汇隐私条例')),
//              ),
//              SizedBox(height: UIData.spaceSize4),
//              GestureDetector(
//                child: CommonText.text12('邻里集市免责申明', color: UIData.themeBgColor),
//                onTap: () => Navigate.toNewPage(HtmlPage(HttpOptions.urlAppShare + 'appText.html', '邻里集市免责申明')),
//              ),
//              SizedBox(height: UIData.spaceSize8),
//              CommonText.lightGrey10Text(bottomStr, overflow: TextOverflow.fade, textAlign: TextAlign.center)
//            ],
//          )),
      bodyData: ListView(
        children: <Widget>[
          Image(image: AssetImage(UIData.imageAbout), fit: BoxFit.fitWidth),
          Container(
              color: Color(0xFFF8F9FD),
              margin: EdgeInsets.only(bottom: UIData.spaceSize16),
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    child: CommonText.text12('招商到家汇隐私条例', color: UIData.themeBgColor),
                    onTap: () => Navigate.toNewPage(HtmlPage(HttpOptions.urlAppShare + 'appText1.html', '招商到家汇隐私条例')),
                  ),
                  SizedBox(height: UIData.spaceSize4),
                  GestureDetector(
                    child: CommonText.text12('邻里集市免责申明', color: UIData.themeBgColor),
                    onTap: () => Navigate.toNewPage(HtmlPage(HttpOptions.urlAppShare + 'appText.html', '邻里集市免责申明')),
                  ),
                  SizedBox(height: UIData.spaceSize8),
                  CommonText.lightGrey10Text(bottomStr, overflow: TextOverflow.fade, textAlign: TextAlign.center)
                ],
              )),
        ],
      ),
    );
  }
}
