import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CommonListLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(UIData.imageLoading), fit: BoxFit.fill)
      ),
      child: Container(
        alignment: Alignment.center,
          child: const SpinKitFadingCircle(color: UIData.redGradient3),
//          margin: EdgeInsets.only(bottom: ScreenUtil.getInstance().setHeight(150))
      ),
    );
  }
}
