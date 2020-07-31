import 'package:cmp_customer/models/response/parking_card_details_response.dart';
import 'package:cmp_customer/scoped_models/parking_model/parking_mine_state_model.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/parking/parking_card_ui.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

//月卡选择（车牌号和停车场）
class ParkingCardSelectPage extends StatelessWidget {
  ParkingMineStateModel stateModel;
  ParkingCardSelectPage(this.stateModel);
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
    return ScopedModel<ParkingMineStateModel>(
        model: stateModel,
        child: CommonScaffold(
            appTitle: "其他月卡",
            bodyData: ScopedModelDescendant<ParkingMineStateModel>(
                builder: (context, child, model) {
              return ListView.separated(
                  itemCount: model.detailsList.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      horizontalLineWidget(),
                  itemBuilder: (BuildContext context, int index) {
                    ParkingCardDetailsInfo info = model.detailsList[index];
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
                                                info.carNo) +
                                            " - " +
                                            StringsHelper.getStringValue(
                                                info.parkingLot)),
                                  ),
                                ),
                                Visibility(
                                    visible: model.selectedIndex == index,
                                    child: Container(
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
