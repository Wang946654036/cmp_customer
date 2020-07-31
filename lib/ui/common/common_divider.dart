import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';

class CommonDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: UIData.primaryColor,
      child: Divider(color: UIData.dividerColor, height: 0.5, indent: UIData.spaceSize16),
    );
  }
}
class CommonFullScaleDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: UIData.primaryColor,
      child: Divider(color: UIData.dividerColor, height: 0.5),
    );
  }
}

class CommonFullDottedScaleDivider extends StatelessWidget {
  final double height;
  final Color color;

  const CommonFullDottedScaleDivider({this.height = 0.5, this.color = UIData.dividerColor});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth()+10;
        final dashWidth = 8.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}
//竖线
class CommonVerticalDivider extends StatelessWidget{
  Color lineColor;
  CommonVerticalDivider({this.lineColor=UIData.dividerColor});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: UIData.blackColor,
      child: VerticalDivider(color: UIData.lightRedColor, width: 10, indent: UIData.spaceSize16),
    );
  }
}
//横线
class CommonHorizontalDivider extends StatelessWidget {
  Color lineColor;
  EdgeInsetsGeometry margin;
  CommonHorizontalDivider({this.lineColor=UIData.primaryColor,this.margin});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: lineColor,
      margin: margin,
      child: Divider(color: UIData.dividerColor, height: 0.5, indent: UIData.spaceSize16),
    );
  }
}

