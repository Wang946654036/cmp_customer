import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';

///
/// 有阴影的容器
///
class CommonShadowContainer extends Container {
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final bool borderVisible;
  final GestureTapCallback onTap;
  final DecorationImage image;
  final Color shadowColor;
  final double offsetX;
  final double offsetY;
  final double blurRadius;
  final double borderRadius;

  CommonShadowContainer(
      {Key key,
      Widget child,
      this.margin,
      this.padding,
      this.backgroundColor = UIData.primaryColor,
      this.borderVisible = false,
      this.onTap,
      this.image,
      this.shadowColor,
      this.offsetX,
      this.offsetY,
      this.blurRadius,
      this.borderRadius,})
      : super(key: key, child: child);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
          margin: margin ?? EdgeInsets.zero,
          padding: padding ?? EdgeInsets.zero,
          decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(borderRadius ?? 6.0),
              image: image,
              boxShadow: [
                BoxShadow(
                    color: shadowColor ?? UIData.dividerColor,
                    offset: Offset(offsetX ?? 0.0, offsetY ?? 5.0),
                    blurRadius: blurRadius ?? 5.0,
                    spreadRadius: 0.0)
              ],
              border: borderVisible ? Border.all(color: UIData.themeBgColor, width: 0.5) : null),
          child: child,
        ),
        onTap: onTap);
  }
}
