import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
/// 菱形的点
///
class CommonDiamondDot extends StatelessWidget {
  final double size;
  final Color color;
  CommonDiamondDot({this.size = 5, this.color = UIData.themeBgColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      //菱形红点
      width: ScreenUtil.getInstance().setWidth(size),
      height: ScreenUtil.getInstance().setHeight(size),
//      margin: EdgeInsets.only(bottom: UIData.spaceSize16),
      decoration: ShapeDecoration(
          shape: BeveledRectangleBorder(
//                  side: const BorderSide(
//                    width: 1.0,
//                    style: BorderStyle.none,
//                  ),
            //每个角落的半径
            borderRadius: BorderRadius.circular(100.0),
          ),
          color: color),
    );
  }
}
