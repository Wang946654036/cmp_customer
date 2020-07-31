import 'package:cmp_customer/ui/common/common_shadow_container.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';

///
/// 房屋信息卡片
///
class HouseInfoCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool trailingVisible;
  final GestureTapCallback trailingOnTap;

  HouseInfoCard({this.subTitle = '', this.title = '', this.trailingOnTap, this.trailingVisible = false});

  @override
  Widget build(BuildContext context) {
    return CommonShadowContainer(
        //房屋信息
        margin: EdgeInsets.symmetric(horizontal: UIData.spaceSize16),
        child: ListTile(
//              isThreeLine: true,
//              dense: true,
          contentPadding: EdgeInsets.only(left: UIData.spaceSize16),
          title: CommonText.darkGrey16Text(title),
          subtitle: CommonText.grey14Text(subTitle),
          trailing: Visibility(
              visible: trailingVisible,
              child: IconButton(icon: UIData.iconChangeDefaultHouse, onPressed: trailingOnTap)),
        ));
  }
}
