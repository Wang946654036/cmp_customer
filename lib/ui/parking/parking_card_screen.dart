import 'package:cmp_customer/scoped_models/parking_model/parking_history_state_model.dart';
import 'package:cmp_customer/scoped_models/parking_model/parking_mine_state_model.dart';
import 'package:cmp_customer/scoped_models/parking_model/parking_screen_state_model.dart';
import 'package:cmp_customer/scoped_models/parking_state_model.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/parking/parking_card_ui.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

//停车页面筛选布局
class ParkingCardScreenPage extends StatelessWidget {
//  ParkingHistoryStateModel _stateModel;
//  @override
//  State<StatefulWidget> createState() {
//    // TODO: implement createState
//    return ParkingCardScreen();
//  }
//}
//
////停车页面筛选布局
//class ParkingCardScreen extends State<ParkingCardScreenPage>{
  @override
  Widget build(BuildContext context) {
//    _stateModel = ParkingHistoryStateModel.of(context);
    // TODO: implement build
    return ScopedModelDescendant<ParkingHistoryStateModel>(
        builder: (context, child, model) {
      return CommonScaffold(
          showLeftButton: false,
          appTitle: Container(
            margin: EdgeInsets.only(left: screen_left_spacing),
            child: CommonText.darkGrey15Text(label_apply_deal_type),
          ),
          backGroundColor: UIData.primaryColor,
          bodyData: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: left_spacing),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ellipseBotton(
                        model.dealTypeList[0].name,
                        model.dealTypeList[0].selected,
                        onChanged: (value) {
                          model.setDealType(0, value);
                        },
                      ),
                    ),
                    Expanded(
                      child: ellipseBotton(
                        model.dealTypeList[1].name,
                        model.dealTypeList[1].selected,
                        onChanged: (value) {
                          model.setDealType(1, value);
                        },
                      ),
                    ),
                    Expanded(
                      child: ellipseBotton(
                        model.dealTypeList[2].name,
                        model.dealTypeList[2].selected,
                        onChanged: (value) {
                          model.setDealType(2, value);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              leftTextWidget(
                text: label_apply_deal_time,
                topSpacing: top_spacing,
                leftSpacing: screen_left_spacing,
                bottomSpacing: bottom_spacing,
              ),
            Row(children: <Widget>[
              Expanded(
                child: ellipseText(
                  model.selectedStartDate ?? label_apply_select_start_time,
                  textColor: model.selectedStartDate == null
                      ? UIData.lightGreyColor
                      : UIData.darkGreyColor,
                  leftSpacing: left_spacing,
                  rightSpacing: text_spacing,
                  onTap: () {
                    model.chooseStartDate(context);
                  },
                ),
              ),
              Text("—"),
              Expanded(
                child: ellipseText(
                  model.selectedEndDate ?? label_apply_select_end_time,
                  textColor: model.selectedEndDate == null
                      ? UIData.lightGreyColor
                      : UIData.darkGreyColor,
                  leftSpacing: text_spacing,
                  rightSpacing: right_spacing,
                  onTap: () {
                    model.chooseEndDate(context);
                  },
                ),
              )
            ]),
//            leftTextWidget(
//              text: label_apply_deal_type,
//              topSpacing: screen_top_spacing,
//              leftSpacing: screen_left_spacing,
//              bottomSpacing: bottom_spacing,
//            ),
              Container(
                margin:
                    EdgeInsets.only(left: left_spacing,top: top_spacing, bottom: bottom_spacing),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ellipseBotton(
                        model.applyTimeList[0].name,
                        model.applyTimeList[0].selected,
                        onChanged: (value) {
                          model.setApplyTime(0, value);
                        },
                      ),
                    ),
                    Expanded(
                      child: ellipseBotton(
                        model.applyTimeList[1].name,
                        model.applyTimeList[1].selected,
                        onChanged: (value) {
                          model.setApplyTime(1, value);
                        },
                      ),
                    ),
                    Expanded(
                      child: ellipseBotton(
                        model.applyTimeList[2].name,
                        model.applyTimeList[2].selected,
                        onChanged: (value) {
                          model.setApplyTime(2, value);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              leftTextWidget(
                text: label_apply_car_no,
                bottomSpacing: bottom_spacing,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: left_spacing),
                  child: GridView.builder(
//              shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: top_spacing,
                          childAspectRatio: 3.3
                          //                crossAxisSpacing: top_spacing,
                          ),
                      itemCount: model.carNoList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ellipseBotton(
                          model.carNoList[index].name,
                          model.carNoList[index].selected,
                          onChanged: (value) {
                            model.setCarNo(index, value);
                          },
                        );
                      }),
                ),
              )
            ],
          ),
          bottomNavigationBar: StadiumSolidWithTowButton(
            cancelText: "重置",
            onCancel: () {
              model.reset();
            },
            conFirmText: "确定",
            onConFirm: () {
              model.getScreenHistoryList();
              Navigator.of(context).pop();
            },
            padding: EdgeInsets.symmetric(
                horizontal: UIData.spaceSize30, vertical: UIData.spaceSize10),
          )
//        Row(
//          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//          children: <Widget>[
//            Expanded(
//                child: StadiumSolidButton(
//              "重置",
//              btnType: ButtonType.CANCEL,
//              onTap: () {
//                model.reset();
//              },
//                  margin: EdgeInsets.only(
//                      left: UIData.spaceSize30,
//                      right: UIData.spaceSize15,
//                      top: UIData.spaceSize10,
//                      bottom: UIData.spaceSize10),
//            )),
//            Expanded(
//                child: StadiumSolidButton(
//              "确定",
//              btnType: ButtonType.CONFIRM,
//              onTap: () {
//                model.getScreenHistoryList();
//                Navigator.of(context).pop();
//              },
//                  margin: EdgeInsets.only(
//                      left: UIData.spaceSize15,
//                      right: UIData.spaceSize30,
//                      top: UIData.spaceSize10,
//                      bottom: UIData.spaceSize10),
//            )),
//          ],
//        ),
          );
    });
  }
}
