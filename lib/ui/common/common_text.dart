import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';

class CommonText {
  //黑色26号字
  static Widget black26Text(text, {textAlign = TextAlign.center}) {
    return Text(
      text,
      style: TextStyle(color: UIData.blackColor, fontSize: UIData.fontSize26),
      textAlign: textAlign,
    );
  }

  //黑色16号字
  static Widget black16Text(text, {maxLines, overflow = TextOverflow.ellipsis, textAlign = TextAlign.center}) {
    return Text(
      text,
      style: TextStyle(color: UIData.blackColor, fontSize: UIData.fontSize16),
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
    );
  }

//浅黄色12号字
  static Widget lighterYellow12Text(text,
      {maxLines, overflow = TextOverflow.ellipsis, textAlign = TextAlign.center}) {
    return Text(
      text,
      style: TextStyle(color: UIData.lightOrangeColor, fontSize: UIData.fontSize12),
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
    );
  }
//浅红色12号字
  static Widget lighterRed12Text(text,
      {maxLines, overflow = TextOverflow.ellipsis, textAlign = TextAlign.center}) {
    return Text(
      text,
      style: TextStyle(color: UIData.lightRedColor, fontSize: UIData.fontSize12),
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
    );
  }
  //浅红色14号字
  static Widget lighterRed14Text(text,
      {maxLines, overflow = TextOverflow.ellipsis, textAlign = TextAlign.center}) {
    return Text(
      text,
      style: TextStyle(color: UIData.lightRedColor, fontSize: UIData.fontSize14),
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
    );
  }

  //浅红色15号字
  static Widget lighterRed15Text(text,
      {maxLines, overflow = TextOverflow.ellipsis, textAlign = TextAlign.center}) {
    return Text(
      text,
      style: TextStyle(color: UIData.lightRedColor, fontSize: UIData.fontSize15),
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
    );
  }

  //浅红色16号字
  static Widget lighterRed16Text(text,
      {maxLines, overflow = TextOverflow.ellipsis, textAlign = TextAlign.center}) {
    return Text(
      text,
      style: TextStyle(color: UIData.lightRedColor, fontSize: UIData.fontSize16),
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
    );
  }

  //红色24号字
  static Widget red24Text(text,
      {maxLines, overflow = TextOverflow.ellipsis, textAlign = TextAlign.center, FontWeight fontWeight}) {
    return Text(
      text,
      style: TextStyle(color: UIData.themeBgColor, fontSize: UIData.fontSize24, fontWeight: fontWeight),
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
    );
  }

  //红色20号字
  static Widget red20Text(text,
      {maxLines, overflow = TextOverflow.ellipsis, textAlign = TextAlign.center, FontWeight fontWeight}) {
    return Text(
      text,
      style: TextStyle(color: UIData.themeBgColor, fontSize: UIData.fontSize20, fontWeight: fontWeight),
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
    );
  }

  //红色16号字
  static Widget red16Text(text,
      {maxLines, overflow = TextOverflow.ellipsis, textAlign = TextAlign.center, FontWeight fontWeight}) {
    return Text(
      text,
      style: TextStyle(color: UIData.themeBgColor, fontSize: UIData.fontSize16, fontWeight: fontWeight),
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
    );
  }

  //红色15号字
  static Widget red15Text(text,
      {maxLines, overflow = TextOverflow.ellipsis, textAlign = TextAlign.center, FontWeight fontWeight}) {
    return Text(
      text,
      style: TextStyle(color: UIData.themeBgColor, fontSize: UIData.fontSize15, fontWeight: fontWeight),
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
    );
  }

  //红色14号字
  static Widget red14Text(text,
      {maxLines,
      overflow = TextOverflow.ellipsis,
      textAlign = TextAlign.left,
      height,
      decoration,
      FontWeight fontWeight}) {
    return Text(
      text,
      style: TextStyle(
          color: UIData.themeBgColor,
          fontSize: UIData.fontSize14,
          height: height,
          decoration: decoration,
          fontWeight: fontWeight),
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
    );
  }
  //红色12号字
  static Widget red12Text(text,
      {maxLines,
        overflow = TextOverflow.ellipsis,
        textAlign = TextAlign.left,
        height,
        decoration,
        FontWeight fontWeight}) {
    return Text(
      text,
      style: TextStyle(
          color: UIData.themeBgColor,
          fontSize: UIData.fontSize12,
          height: height,
          decoration: decoration,
          fontWeight: fontWeight),
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
    );
  }
  //深灰色18号字
  static Widget darkGrey18Text(text,
      {maxLines, overflow = TextOverflow.ellipsis, textAlign = TextAlign.center, FontWeight fontWeight}) {
    return Text(
      text,
      style: TextStyle(color: UIData.darkGreyColor, fontSize: UIData.fontSize18, fontWeight: fontWeight),
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
    );
  }

  //深灰色17号字
  static Widget darkGrey17Text(text,
      {maxLines, overflow = TextOverflow.ellipsis, textAlign = TextAlign.left, FontWeight fontWeight}) {
    return Text(
      text,
      style: TextStyle(color: UIData.darkGreyColor, fontSize: UIData.fontSize17, fontWeight: fontWeight),
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
    );
  }

  //深灰色16号字
  static Widget darkGrey16Text(text,
      {maxLines, overflow = TextOverflow.ellipsis, textAlign = TextAlign.left, FontWeight fontWeight}) {
    return Text(
      text,
      style: TextStyle(color: UIData.darkGreyColor, fontSize: UIData.fontSize16, fontWeight: fontWeight),
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
    );
  }

  //深灰色15号字
  static Widget darkGrey15Text(text,
      {maxLines, overflow = TextOverflow.ellipsis, textAlign = TextAlign.left, FontWeight fontWeight}) {
    return Text(
      text,
      style: TextStyle(color: UIData.darkGreyColor, fontSize: UIData.fontSize15, fontWeight: fontWeight),
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
    );
  }

  //深灰色14号字
  static Widget darkGrey14Text(text,
      {maxLines, overflow = TextOverflow.ellipsis, fontWeight, height, textAlign = TextAlign.left}) {
    return Text(
      text,
      style: TextStyle(
          color: UIData.darkGreyColor, fontSize: UIData.fontSize14, fontWeight: fontWeight, height: height),
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
    );
  }

  //深灰色12号字
  static Widget darkGrey12Text(text, {height}) {
    return Text(text, style: TextStyle(color: UIData.darkGreyColor, fontSize: UIData.fontSize12, height: height));
  }

  //灰色13号字
  static Widget grey13Text(text, {height, FontWeight fontWeight}) {
    return Text(text, style: TextStyle(color: UIData.greyColor, fontSize: UIData.fontSize13, height: height, fontWeight: fontWeight));
  }

  //灰色12号字
  static Widget grey12Text(text, {height}) {
    return Text(text, style: TextStyle(color: UIData.greyColor, fontSize: UIData.fontSize12, height: height));
  }

  //灰色14号字
  static Widget grey14Text(text, {height, overflow = TextOverflow.ellipsis}) {
    return Text(text, style: TextStyle(color: UIData.greyColor, fontSize: UIData.fontSize14, height: height),
      overflow: overflow,);
  }

  //灰色15号字
  static Widget grey15Text(text, {height}) {
    return Text(text, style: TextStyle(color: UIData.greyColor, fontSize: UIData.fontSize15, height: height));
  }

  //灰色16号字
  static Widget grey16Text(text,
      {maxLines, overflow = TextOverflow.ellipsis, textAlign = TextAlign.left, FontWeight fontWeight}) {
    return Text(
      text,
      style: TextStyle(color: UIData.greyColor, fontSize: UIData.fontSize16, fontWeight: fontWeight),
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
    );
  }

  //深灰色14号字左边蓝色边框
  static Widget darkGrey14LeftBorderBlueText(text) {
    return Container(
      padding: EdgeInsets.only(left: 10.0),
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: UIData.primaryColor, width: 4.0)),
      ),
      child: Text(
        text,
        style: TextStyle(color: UIData.darkGreyColor, fontSize: UIData.fontSize14),
      ),
    );
  }

  //浅灰色10号字
  static Widget lightGrey10Text(text, {overflow = TextOverflow.ellipsis,
    textAlign = TextAlign.start}) {
    return Text(text,
        style: TextStyle(color: UIData.lightGreyColor, fontSize: UIData.fontSize10), overflow: overflow,
      textAlign: textAlign,);
  }

  //浅灰色14号字
  static Widget lightGrey14Text(text, {height}) {
    return Text(text,
        softWrap: true,
        style: TextStyle(
          color: UIData.lightGreyColor,
          fontSize: UIData.fontSize14,
          height: height,
        ));
  }

  //浅灰色14号字
  static Widget lightGrey15Text(text, {height}) {
    return Text(text,
        softWrap: true,
        style: TextStyle(
          color: UIData.lightGreyColor,
          fontSize: UIData.fontSize15,
          height: height,
        ));
  }

  //浅灰色16号字
  static Widget lightGrey16Text(text, {height}) {
    return Text(text,
        softWrap: true,
        style: TextStyle(color: UIData.lightGreyColor, fontSize: UIData.fontSize16, height: height));
  }

  //浅灰色12号字
  static Widget lightGrey12Text(
    text, {
    maxLines,
    overflow = TextOverflow.ellipsis,
    height,
    textAlign = TextAlign.start,
  }) {
    return Text(
      text,
      style: TextStyle(color: UIData.lightGreyColor, fontSize: UIData.fontSize12, height: height),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  //浅灰色11号字
  static Widget lightGrey11Text(text, {height, textAlign = TextAlign.start}) {
    return Text(
      text,
      style: TextStyle(color: UIData.lightGreyColor, fontSize: UIData.fontSize11, height: height),
      textAlign: textAlign,
    );
  }

  //浅浅灰色12号字
  static Widget lighterGrey12Text(text, {height, textAlign = TextAlign.start}) {
    return Text(
      text,
      style: TextStyle(color: UIData.lighterGreyColor, fontSize: UIData.fontSize12, height: height),
      textAlign: textAlign,
    );
  }

  //白色18号字
  static Widget white18Text(text, {textAlign = TextAlign.center}) {
    return Text(text,
        style: TextStyle(color: Colors.white, fontSize: UIData.fontSize18),
        overflow: TextOverflow.clip,
        textAlign: textAlign);
  }

  //白色17号字
  static Widget white17Text(text, {textAlign = TextAlign.center}) {
    return Text(text,
        style: TextStyle(color: Colors.white, fontSize: UIData.fontSize17),
        overflow: TextOverflow.clip,
        textAlign: textAlign);
  }

  //白色16号字
  static Widget white16Text(text, {textAlign = TextAlign.center}) {
    return Text(text,
        style: TextStyle(color: Colors.white, fontSize: UIData.fontSize16),
        overflow: TextOverflow.clip,
        textAlign: textAlign);
  }

  //白色14号字
  static Widget white14Text(text, {textAlign = TextAlign.center}) {
    return Text(text,
        style: TextStyle(color: Colors.white, fontSize: UIData.fontSize14),
        overflow: TextOverflow.clip,
        textAlign: textAlign);
  }

  //白色12号字
  static Widget white12Text(text) {
    return Text(text, style: TextStyle(color: UIData.primaryColor, fontSize: UIData.fontSize12));
  }

  //白色10号字
  static Widget white10Text(text) {
    return Text(text, style: TextStyle(color: UIData.primaryColor, fontSize: UIData.fontSize10));
  }

  //橙色14号字
  static Widget orange14Text(text,{FontWeight fontWeight}) {
    return Text(text, style: TextStyle(color: UIData.orangeColor, fontSize: UIData.fontSize14,fontWeight: fontWeight));
  }

  //橙色12号字
  static Widget orange12Text(text) {
    return Text(text, style: TextStyle(color: UIData.orangeColor, fontSize: UIData.fontSize12));
  }

  //橙色10号字
  static Widget orange10Text(text) {
    return Text(text, style: TextStyle(color: UIData.orangeColor, fontSize: UIData.fontSize10));
  }

  //蓝色16号字
  static Widget blue16Text(text, {textAlign = TextAlign.center}) {
    return Text(
      text,
      style: TextStyle(color: UIData.indicatorBlueColor, fontSize: UIData.fontSize16),
      textAlign: textAlign,
    );
  }

  //蓝色14号字
  static Widget blue14Text(text, {textAlign = TextAlign.center}) {
    return Text(
      text,
      style: TextStyle(color: UIData.indicatorBlueColor, fontSize: UIData.fontSize14),
      textAlign: textAlign,
    );
  }
  //蓝色14号字
  static Widget blue15Text(text, {textAlign = TextAlign.center}) {
    return Text(
      text,
      style: TextStyle(color: UIData.indicatorBlueColor, fontSize: UIData.fontSize15),
      textAlign: textAlign,
    );
  }
  //深灰色16号字TextStyle
  static TextStyle darkGrey16TextStyle() {
    return TextStyle(color: UIData.darkGreyColor, fontSize: UIData.fontSize16);
  }

  //深灰色15号字TextStyle
  static TextStyle darkGrey15TextStyle() {
    return TextStyle(color: UIData.darkGreyColor, fontSize: UIData.fontSize15);
  }

  //自定义颜色15号字TextStyle
  static TextStyle textStyle15({color = UIData.darkGreyColor}) {
    return TextStyle(color: color, fontSize: UIData.fontSize15);
  }

  //深灰色14号字TextStyle
  static TextStyle darkGrey14TextStyle() {
    return TextStyle(color: UIData.darkGreyColor, fontSize: UIData.fontSize14);
  }

  //灰色12号字TextStyle
  static TextStyle grey12TextStyle({double height}) {
    return TextStyle(color: UIData.greyColor, fontSize: UIData.fontSize12, height: height);
  }

  //灰色13号字TextStyle
  static TextStyle grey13TextStyle({double height}) {
    return TextStyle(color: UIData.greyColor, fontSize: UIData.fontSize13, height: height);
  }

  //灰色14号字TextStyle
  static TextStyle grey14TextStyle({double height}) {
    return TextStyle(color: UIData.greyColor, fontSize: UIData.fontSize14, height: height);
  }

  //灰色16号字TextStyle
  static TextStyle grey16TextStyle() {
    return TextStyle(color: UIData.greyColor, fontSize: UIData.fontSize16);
  }

  //浅灰色16号字TextStyle
  static TextStyle lightGrey16TextStyle() {
    return TextStyle(color: UIData.lightGreyColor, fontSize: UIData.fontSize16);
  }

  //浅灰色15号字TextStyle
  static TextStyle lightGrey15TextStyle() {
    return TextStyle(color: UIData.lightGreyColor, fontSize: UIData.fontSize15);
  }

  //浅灰色14号字TextStyle
  static TextStyle lightGrey14TextStyle() {
    return TextStyle(color: UIData.lightGreyColor, fontSize: UIData.fontSize14);
  }

  //浅灰色12号字TextStyle
  static TextStyle lightGrey12TextStyle() {
    return TextStyle(color: UIData.lightGreyColor, fontSize: UIData.fontSize12);
  }

  //蓝色14号字TextStyle
  static TextStyle blue14TextStyle() {
    return TextStyle(color: UIData.primaryColor, fontSize: UIData.fontSize14);
  }

  //深灰色14号字TextStyle
  static TextStyle darkGrey14TextTextStyle() {
    return TextStyle(color: UIData.darkGreyColor, fontSize: UIData.fontSize14);
  }

  //主题色14号字TextStyle
  static TextStyle primary16TextTextStyle() {
    return TextStyle(color: UIData.primaryColor, fontSize: UIData.fontSize16);
  }

  //白色16号字TextStyle
  static TextStyle white16TextTextStyle() {
    return TextStyle(color: Colors.white, fontSize: UIData.fontSize16);
  }

  //红色16号字TextStyle
  static TextStyle red16TextStyle() {
    return TextStyle(color: UIData.themeBgColor, fontSize: UIData.fontSize16);
  }

  //红色14号字TextStyle
  static TextStyle red14TextStyle() {
    return TextStyle(color: UIData.themeBgColor, fontSize: UIData.fontSize14);
  }

  //红色13号字TextStyle
  static TextStyle red13TextStyle() {
    return TextStyle(color: UIData.themeBgColor, fontSize: UIData.fontSize13);
  }

  //红色12号字TextStyle
  static TextStyle red12TextStyle() {
    return TextStyle(color: UIData.themeBgColor, fontSize: UIData.fontSize12);
  }

  //自定义颜色18号字
  static Widget text18(text, {height, textAlign = TextAlign.start, color = UIData.darkGreyColor}) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: UIData.fontSize18, height: height),
      textAlign: textAlign,
    );
  }

//自定义颜色16号字
  static Widget text16(text, {height, textAlign = TextAlign.start, color = UIData.darkGreyColor, isBold = false}) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: UIData.fontSize16,
          height: height,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
      textAlign: textAlign,
    );
  }

//自定义颜色15号字
  static Widget text15(text, {height, textAlign = TextAlign.start, color = UIData.darkGreyColor,
    TextOverflow overflow = TextOverflow.ellipsis}) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: UIData.fontSize15, height: height),
      textAlign: textAlign,
      overflow: overflow,
    );
  }

  //自定义颜色14号字
  static Widget text14(text, {height, textAlign = TextAlign.start, color = UIData.darkGreyColor,TextDecoration textDecoration,
    TextOverflow overflow = TextOverflow.ellipsis}) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: UIData.fontSize14, height: height,
          decoration: textDecoration),
      textAlign: textAlign,
      overflow: overflow,
    );
  }

  //自定义颜色13号字
  static Widget text13(text,
      {height,
      textAlign = TextAlign.start,
      color = UIData.darkGreyColor,
      TextOverflow overflow = TextOverflow.ellipsis}) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: UIData.fontSize13, height: height),
      textAlign: textAlign,
      overflow: overflow,
    );
  }

  //自定义颜色12号字
  static Widget text12(text, {height, textAlign = TextAlign.start, color = UIData.darkGreyColor}) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: UIData.fontSize12, height: height),
      textAlign: textAlign,
    );
  }

  //自定义颜色11号字
  static Widget text11(text,
      {height, textAlign = TextAlign.start, color = UIData.darkGreyColor, FontWeight fontWeight,TextOverflow overflow}) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: UIData.fontSize11, height: height, fontWeight: fontWeight),
      textAlign: textAlign,
      overflow: overflow??TextOverflow.ellipsis,
    );
  }

  //自定义颜色10号字
  static Widget text10(text, {height, textAlign = TextAlign.start, color = UIData.darkGreyColor}) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: UIData.fontSize10, height: height),
      textAlign: textAlign,
    );
  }
}
