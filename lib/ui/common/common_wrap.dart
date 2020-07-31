import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';

///
/// 普通的Wrap
///
class CustomWrap extends StatelessWidget {
  final List<Widget> list;

  CustomWrap(this.list);

  @override
  Widget build(BuildContext context) {
    return list != null ?Wrap(
      alignment: WrapAlignment.start,
      runAlignment: WrapAlignment.start,
      spacing: UIData.spaceSize10,
//                            runSpacing: UIData.spaceSize3 * 2,
      children: list,
    ) : Container();
  }
}

///
/// 普通的Chip
///
class CustomChip extends StatelessWidget {
  final String text;
  final GestureTapCallback onTap;

  CustomChip(this.text, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return InputChip(
        label: CommonText.text11(text, color: UIData.darkGreyColor),
        onPressed: onTap,
//        onDeleted: () {
//          setState(() {
//          });
//        },
        deleteIconColor: UIData.lightGreyColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0)),
        backgroundColor: UIData.scaffoldBgColor);
  }
}
