
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

 class CommonDatePicker{


   static void datePickerModal(BuildContext context,{int type = PickerDateTimeType.kYMD,Function onConfirm}) {
     Picker(
       confirmTextStyle: CommonText.red14TextStyle(),
       cancelTextStyle: CommonText.lightGrey16TextStyle(),
       adapter: new DateTimePickerAdapter(
           type: type,
           isNumberMonth: true,
           //strAMPM: const["上午", "下午"],
           yearSuffix: "年",
           monthSuffix: "月",
           daySuffix: "日"),
       onConfirm: (Picker picker, List value) {
         onConfirm(picker.adapter.text.split(' ')[0]);
       },
     ).showModal(context);

  }
}
