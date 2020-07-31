
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/parking/parking_card_ui.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';

//房屋选择
class HouseSelectPage extends StatelessWidget {
  List<HouseInfo> houseList;
  int sekecthouseId;
  Function callback;
  HouseSelectPage(this.sekecthouseId,this.houseList,this.callback);
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
//    final statewidget = Scopedof<ParkingMineStatewidget>(context);
    return CommonScaffold(
        appTitle: "房屋选择",
        bodyData: ListView.separated(
            itemCount: houseList.length,
            separatorBuilder: (BuildContext context, int index) =>
                horizontalLineWidget(),
            itemBuilder: (BuildContext context, int index) {
              HouseInfo info = houseList[index];
              return GestureDetector(
                  onTap: () {
                    if(callback!=null)
                    callback(info);
                    Navigate.closePage();
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
                                      " - " +
                                      StringsHelper.getStringValue(
                                          info.houseNo)),
                            ),
                          ),
                          Visibility(
                              visible: sekecthouseId!=null&& sekecthouseId==info.houseId,
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
            }));
  }
}
