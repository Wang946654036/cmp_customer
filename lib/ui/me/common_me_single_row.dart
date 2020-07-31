import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';

class MeSingleLine extends StatelessWidget {
  final String title;
  final content;
  final GestureTapCallback onTap;
  final arrowVisible;
  final backgroundColor;

  MeSingleLine(this.title, {this.content, this.onTap, this.arrowVisible = true, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? UIData.primaryColor,
      child: ListTile(
        dense: true,
        title: CommonText.grey16Text(title),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            content != null ? content is String ? CommonText.darkGrey16Text(content) : content : Container(),
            Visibility(
                visible: arrowVisible,
                child: Icon(
                  Icons.keyboard_arrow_right,
                  color: UIData.lighterGreyColor,
                ))
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
