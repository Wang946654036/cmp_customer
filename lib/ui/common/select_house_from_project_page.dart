import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';

///
/// 指定项目底下的房屋列表
///
class SelectHouseFromProjectPage extends StatefulWidget {
  final List<HouseInfo> houseList;
  final int defaultId;

  SelectHouseFromProjectPage(this.houseList, this.defaultId);

  @override
  _SelectHouseFromProjectPageState createState() => _SelectHouseFromProjectPageState();
}

class _SelectHouseFromProjectPageState extends State<SelectHouseFromProjectPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildBody() {
    return Container(
      color: UIData.primaryColor,
      child: ListView.separated(
        shrinkWrap: true,
          itemBuilder: (context, index) {
            HouseInfo info = widget.houseList[index];
            return ListTile(
              title: CommonText.darkGrey15Text(StringsHelper.getStringValue(info?.buildName) + '-' +
                  StringsHelper.getStringValue(info?.unitName) + '-' +
                  StringsHelper.getStringValue(info?.houseNo)),
              trailing: widget.defaultId == info?.houseId ? UIData.iconTick : null,
              onTap: ()=> navigatorKey.currentState.pop(info),
            );
          }, separatorBuilder: (context, index) {
        return CommonDivider();
      }, itemCount: widget.houseList.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appTitle: '房屋选择',
      bodyData: _buildBody(),
    );
  }
}
