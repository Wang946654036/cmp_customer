import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/scoped_models/check_in_model/check_in_history_state_model.dart';
import 'package:cmp_customer/scoped_models/entrance_state_model.dart';
import 'package:cmp_customer/ui/check_in/check_in_label.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/parking/parking_card_ui.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

//租户入驻筛选布局
class CheckInScreenPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CheckInScreen();
  }
}

class _CheckInScreen extends State<CheckInScreenPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModelDescendant<CheckInHistoryStateModel>(
        builder: (context, child, model) {
      return CommonScaffold(
          showLeftButton: false,
//          showAppBar: false,
          appTitle: Container(
            margin: EdgeInsets.only(left: screen_left_spacing),
            child: CommonText.darkGrey15Text(label_apply_select_status),
          ),
          backGroundColor: UIData.primaryColor,
          bodyData: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: left_spacing),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ellipseBotton(
                        model.applyStatusList[0].name,
                        model.applyStatusList[0].selected,
                        onChanged: (value) {
                          model.setApplyStatus(0, value);
                        },
                      ),
                    ),
                    Expanded(
                      child: ellipseBotton(
                        model.applyStatusList[1].name,
                        model.applyStatusList[1].selected,
                        onChanged: (value) {
                          model.setApplyStatus(1, value);
                        },
                      ),
                    ),
                    Expanded(
                      child: ellipseBotton(
                        model.applyStatusList[2].name,
                        model.applyStatusList[2].selected,
                        onChanged: (value) {
                          model.setApplyStatus(2, value);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: left_spacing,top: top_spacing),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ellipseBotton(
                        model.applyStatusList[3].name,
                        model.applyStatusList[3].selected,
                        onChanged: (value) {
                          model.setApplyStatus(3, value);
                        },
                      ),
                    ),
                    Expanded(
                      child: ellipseBotton(
                        model.applyStatusList[4].name,
                        model.applyStatusList[4].selected,
                        onChanged: (value) {
                          model.setApplyStatus(4, value);
                        },
                      ),
                    ),
                    Expanded(
                      child: ellipseBotton(
                        model.applyStatusList[5].name,
                        model.applyStatusList[5].selected,
                        onChanged: (value) {
                          model.setApplyStatus(5, value);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              leftTextWidget(
                text: label_apply_deal_time,
                topSpacing: screen_top_spacing,
                leftSpacing: screen_left_spacing,
                bottomSpacing: bottom_spacing,
              ),
              Row(
                children: <Widget>[
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
                ],
              ),
              Container(
                margin: EdgeInsets.only(
                  left: left_spacing,
                  top: top_spacing,
                ),
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

            ],
          ),
//          appBarActions: <Widget>[Container()],
          bottomNavigationBar: StadiumSolidWithTowButton(
            cancelText: "重置",
            onCancel: () {
              model.reset();
            },
            conFirmText: "确定",
            onConFirm: () {
              model.getScreenList();
              Navigator.of(context).pop();
            },
            padding: EdgeInsets.symmetric(
                horizontal: UIData.spaceSize30, vertical: UIData.spaceSize10),
          ));
    });
  }
}
