import 'package:cmp_customer/scoped_models/market_model/market_list_model.dart';
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

//集市筛选布局
class MarketScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    _stateModel = ParkingHistoryStateModel.of(context);
    // TODO: implement build
    return ScopedModelDescendant<MarketListModel>(
        builder: (context, child, model) {
          return CommonScaffold(
              showLeftButton: false,
              appTitle: Container(
                margin: EdgeInsets.only(left: screen_left_spacing),
                child: CommonText.darkGrey15Text("发布范围"),
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
                            model.rangeList[0].name,
                            model.rangeList[0].selected,
                            onChanged: (value) {
                              model.setRang(0, value);
                            },
                          ),
                        ),
                        Expanded(
                          child: ellipseBotton(
                            model.rangeList[1].name,
                            model.rangeList[1].selected,
                            onChanged: (value) {
                              model.setRang(1, value);
                            },
                          ),
                        ),
                        Expanded(
                          child: ellipseBotton(
                            model.rangeList[2].name,
                            model.rangeList[2].selected,
                            onChanged: (value) {
                              model.setRang(2, value);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  leftTextWidget(
                    text: "发布类型",
                    topSpacing: top_spacing,
                    leftSpacing: screen_left_spacing,
                    bottomSpacing: bottom_spacing,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: left_spacing),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: ellipseBotton(
                            model.typeList[0].name,
                            model.typeList[0].selected,
                            onChanged: (value) {
                              model.setType(0, value);
                            },
                          ),
                        ),
                        Expanded(
                          child: ellipseBotton(
                            model.typeList[1].name,
                            model.typeList[1].selected,
                            onChanged: (value) {
                              model.setType(1, value);
                            },
                          ),
                        ),
                        Expanded(
                          child: ellipseBotton(
                            model.typeList[2].name,
                            model.typeList[2].selected,
                            onChanged: (value) {
                              model.setType(2, value);
                            },
                          ),
                        ),
                        Expanded(
                          child: ellipseBotton(
                            model.typeList[3].name,
                            model.typeList[3].selected,
                            onChanged: (value) {
                              model.setType(3, value);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  leftTextWidget(
                    text: "商品类型",
                    topSpacing: screen_top_spacing,
                    leftSpacing: screen_left_spacing,
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
                              childAspectRatio: 2.8
                            //                crossAxisSpacing: top_spacing,
                          ),
                          itemCount: model.classificationList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ellipseBotton(
                              model.classificationList[index].name,
                              model.classificationList[index].selected,
                              onChanged: (value) {
                                model.setClassification(index, value);
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
                  model.setScreenData();
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
