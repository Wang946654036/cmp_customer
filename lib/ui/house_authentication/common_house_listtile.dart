import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
/// 房屋通用行
/// [showAll] 是否显示全部信息，否则title只展示最后一个字，其余用星号代替，subtitle星号屏蔽第四位~第七位
///
class CommonHouseListTile extends StatelessWidget {
  final bool subTitleIconVisible;
  final String title;
  final String subTitle;
  final String label;
  final bool trailingOnTapVisible;
  final GestureTapCallback trailingOnTap;
  final bool showAll;

  CommonHouseListTile({
    this.subTitleIconVisible = false,
    this.title = '',
    this.subTitle = '',
    this.label,
    this.trailingOnTap,
    this.trailingOnTapVisible = false,
    this.showAll = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: UIData.spaceSize12),
        child: Row(
          children: <Widget>[
            ClipOval(
              child: Image.asset(UIData.imagePortrait,
                  width: ScreenUtil.getInstance().setWidth(34), height: ScreenUtil.getInstance().setHeight(34)),
            ),
            SizedBox(width: UIData.spaceSize8),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
//                    CommonText.darkGrey15Text(showAll? title: title.replaceAll(r'/.(?=/.)g', '*')),
                    CommonText.darkGrey15Text(showAll ? title : _getStarTitle(title)),
                    SizedBox(width: UIData.spaceSize4),
                    Visibility(
                        visible: label != null,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: UIData.spaceSize4, vertical: UIData.spaceSize2),
                          decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0)),
                              color: UIData.dividerColor),
                          child: CommonText.grey12Text(label ?? ''),
                        ))
                  ],
                ),
                SizedBox(height: UIData.spaceSize4),
                Row(
                  children: <Widget>[
                    subTitleIconVisible ? UIData.iconLocation : Container(),
                    CommonText.lightGrey12Text(showAll
                        ? subTitle
                        : (StringsHelper.isNotEmpty(subTitle)
                            ? subTitle.replaceFirst(RegExp(r'\d{4}'), '****', 3)
                            : ''))
                  ],
                ),
              ],
            )),
            Visibility(
                visible: trailingOnTapVisible,
                child: IconButton(icon: UIData.iconMoveOut, onPressed: trailingOnTap)),
          ],
        ));
  }

  //转换成最后一个字符以前为星号
  String _getStarTitle(String str) {
    if (StringsHelper.isNotEmpty(str)) {
      String star = '*' * (str.length - 1);
      return star + str.substring(str.length - 1, str.length);
    } else
      return '';
  }
}
