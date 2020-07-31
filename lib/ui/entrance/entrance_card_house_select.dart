import 'package:cmp_customer/models/response/entrance_card_house_response.dart';
import 'package:cmp_customer/models/response/parking_card_details_response.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/scoped_models/entrance_model/entrance_apply_state_model.dart';
import 'package:cmp_customer/scoped_models/parking_model/parking_mine_state_model.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/house_authentication/house_list.dart';
import 'package:cmp_customer/ui/parking/parking_card_ui.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

//房屋选择
class EntranceCardHouseSelectPage extends StatelessWidget {
  EntranceApplyStateModel stateModel;
  EntranceCardHouseSelectPage(this.stateModel);
//  @override
//  State<StatefulWidget> createState() {
//    // TODO: implement createState
//    return ParkingCardSelect();
//  }
//
//}
//
//class ParkingCardSelect extends State<ParkingCardSelectPage>{
//  bool checkboxState=false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
//    final stateModel = ScopedModel.of<ParkingMineStateModel>(context);
    return ScopedModel<EntranceApplyStateModel>(
        model: stateModel,
        child: CommonScaffold(
            appTitle: "房屋选择",
            bodyData: ScopedModelDescendant<EntranceApplyStateModel>(
                builder: (context, child, model) {
              return ListView.separated(
                  itemCount: model.houseList.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      horizontalLineWidget(),
                  itemBuilder: (BuildContext context, int index) {
                    HouseInfo info = model.houseList[index];
                    return GestureDetector(
                        onTap: () {
                          model.setSelectedIndex(index);
                        },
                        child: Container(
                            color: Colors.white,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    color: Colors.white,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.all(left_spacing),
                                    child: CommonText.text15(
                                        StringsHelper.getStringValue(
                                                info.formerName) +
                                            "   " +
                                            StringsHelper.getStringValue(
                                                info.buildName) +
                                            " - " +
                                            StringsHelper.getStringValue(
                                                info.unitName) +
//                                            " - " +
//                                            StringsHelper.getStringValue(
//                                                info.floorName) +
                                            StringsHelper.getStringValue(
                                                info.houseNo)),
                                  ),
                                ),
                                Visibility(
                                    visible: model.selectedIndex == index,
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(right: right_spacing),
                                      color: Colors.white,
                                      child: Icon(
                                        Icons.check,
                                        color: UIData.themeBgColor,
                                        size: normal_right_icon_size,
                                      ),
                                    ))
                              ],
                            )));
                  });
            })));
  }
}
