import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

///
///  选择器
///
class CommonPicker {
  ///
  /// 日期选择器
  ///
  static void datePickerModal(BuildContext context,
      {int type = PickerDateTimeType.kYMD, Function onConfirm, bool needTime = false}) {
    Picker(
      confirmTextStyle: CommonText.red16TextStyle(),
      cancelTextStyle: CommonText.lightGrey16TextStyle(),
      adapter: new DateTimePickerAdapter(
          type: type,
          isNumberMonth: true,
          //strAMPM: const["上午", "下午"],
          yearSuffix: "年",
          monthSuffix: "月",
          daySuffix: "日"),
      onConfirm: (Picker picker, List value) {
        if (!needTime)
          onConfirm(picker.adapter.text.split(' ')[0]);
        else
          onConfirm(picker.adapter.text.substring(0, picker.adapter.text.lastIndexOf(':')));
      },
    ).showModal(context);
  }
  ///
  /// 日期时间选择器（年月日时分）
  ///
  static void datePickerWithLimitModal(BuildContext context,
      {int type = PickerDateTimeType.kYMD, Function onConfirm, DateTime startTime, DateTime endTime,int limit}) {
//    LogUtils.printLog('minValue：${DateTime.now()}');
//    LogUtils.printLog('maxValue：${DateTime.now().add(Duration(days: 5))}');
    Picker(
      confirmTextStyle: CommonText.red16TextStyle(),
      cancelTextStyle: CommonText.lightGrey16TextStyle(),
      adapter: new DateTimePickerAdapter(
          type: type,
          isNumberMonth: true,
          //strAMPM: const["上午", "下午"],
          minValue: startTime??DateTime.now(),
          maxValue: endTime??DateTime.now().add(Duration(days: limit??30)),
          yearSuffix: "年",
          monthSuffix: "月",
          daySuffix: "日"),
      onConfirm: (Picker picker, List value) {
        LogUtils.printLog('日期时间：${picker.adapter.text}');
        if (type == PickerDateTimeType.kYMD) {
          onConfirm(picker.adapter.text.split(' ')[0]);
        }
      },
    ).showModal(context);
  }
  ///
  /// 日期时间选择器（年月日时分）
  ///
  static void dateTimePickerModal(BuildContext context,
      {int type = PickerDateTimeType.kYMDHM, Function onConfirm, DateTime startTime, DateTime endTime}) {
//    LogUtils.printLog('minValue：${DateTime.now()}');
//    LogUtils.printLog('maxValue：${DateTime.now().add(Duration(days: 5))}');
    Picker(
      confirmTextStyle: CommonText.red16TextStyle(),
      cancelTextStyle: CommonText.lightGrey16TextStyle(),
      adapter: new DateTimePickerAdapter(
          type: type,
          isNumberMonth: true,
          //strAMPM: const["上午", "下午"],
//          minValue: DateTime.now(),
//          maxValue: DateTime.now().add(Duration(days: 5)),
          yearSuffix: "年",
          monthSuffix: "月",
          daySuffix: "日"),
      onConfirm: (Picker picker, List value) {
        LogUtils.printLog('日期时间：${picker.adapter.text}');
        if (type == PickerDateTimeType.kYMDHM) {
          onConfirm(picker.adapter.text.substring(0, picker.adapter.text.lastIndexOf(':')));
        }
      },
    ).showModal(context);
  }

  ///
  /// 单项选择器
  ///
  static void singlePickerModal(BuildContext context, List list, {Function onConfirm, int initSelect}) {
    Picker(
      selecteds: [initSelect ?? 0],
      confirmTextStyle: CommonText.red16TextStyle(),
      cancelTextStyle: CommonText.lightGrey16TextStyle(),
      adapter: new PickerDataAdapter(pickerdata: list),
      onConfirm: (Picker picker, List value) {
        onConfirm(value[0], picker.adapter.getSelectedValues()[0]);
      },
    ).showModal(context);
  }
}
