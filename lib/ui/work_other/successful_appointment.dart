import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/work_other/work_other_ui.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///有偿服务历史
class SuccessfulAppointmentPage extends StatefulWidget {
  SuccessfulAppointmentPage();

  @override
  _SuccessfulAppointmentPageState createState() =>
      new _SuccessfulAppointmentPageState();
}

class _SuccessfulAppointmentPageState extends State<SuccessfulAppointmentPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CommonScaffold(
        appTitle: successfulAppointment,
        bodyData: Container(
          color: Colors.white,
          width: ScreenUtil.screenWidth,
          padding: EdgeInsets.symmetric(
              vertical: UIData.spaceSize40 + UIData.spaceSize2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(UIData.spaceSize30),
                child: Container(
                  color: UIData.audioBtnRedColor,
                  height: UIData.spaceSize30 * 2,
                  width: UIData.spaceSize30 * 2,
                  child: Icon(IconData(0xe6e7, fontFamily: 'iconfont'),
                      color: Color(0xffF9320F), size: UIData.fontSize20),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: UIData.spaceSize16),
                child: CommonText.darkGrey16Text(successfulAppointment),
              ),
              Container(
                margin: EdgeInsets.only(top: UIData.spaceSize16),
                child: GestureDetector(child: CommonText.blue16Text('返回首页'),onTap: (){
                  Navigator.of(context).popUntil(ModalRoute.withName(Constant.pageMain));
                },) ,
              )
            ],
          ),
        ));
  }
}
