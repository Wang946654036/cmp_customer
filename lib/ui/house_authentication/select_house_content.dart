import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/house_list_model.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/house_authentication/select_house_page.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';

///
/// 选择楼栋-单元-房号的切换内容页
///
class SelectHouseContent extends StatefulWidget {
  final List<HouseAddr> houseList;
  final HouseAddrPageModel pageModel;

  SelectHouseContent(this.houseList, this.pageModel);

  @override
  _SelectHouseContentState createState() => _SelectHouseContentState();
}

class _SelectHouseContentState extends State<SelectHouseContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: UIData.scaffoldBgColor,
      child: ListView.separated(
          itemCount: widget.houseList?.length ?? 0,
          itemBuilder: (context, index) {
            HouseAddr data = widget.houseList[index];
            return Container(
              color: UIData.primaryColor,
              child: ListTile(
                  title: CommonText.darkGrey15Text(
                      (data?.houseNo ?? data?.name) ?? ''),
                  trailing: Icon(Icons.keyboard_arrow_right, color: UIData.lighterGreyColor),
                  onTap: () {
                    widget.pageModel.titleList.add(data?.name ?? '');
                    switch (widget.pageModel.houseAddrType) {
                      case HouseAddrType.Building:
                        widget.pageModel.houseAddrModel.buildingId = data?.buildId;
                        widget.pageModel.houseAddrModel.buildingName = data?.name;
                        widget.pageModel.houseAddrType = HouseAddrType.Unit;
                        stateModel.getHouseList(data?.buildId, widget.pageModel);
                        break;
                      case HouseAddrType.Unit:
                        widget.pageModel.houseAddrModel.unitId = data?.unitId;
                        widget.pageModel.houseAddrModel.unitName = data?.name;
                        widget.pageModel.houseAddrType = HouseAddrType.Room;
                        stateModel.getHouseList(data?.unitId, widget.pageModel);
                        break;
                      case HouseAddrType.Room:
                        widget.pageModel.houseAddrModel.roomId = data?.houseId;
                        widget.pageModel.houseAddrModel.roomName = data?.houseNo;
                        navigatorKey.currentState.pop(widget.pageModel.houseAddrModel);
                        break;
                    }
                  }),
            );
          },
          separatorBuilder: (context, index) {
            return CommonDivider();
          }),
    );
  }
}
