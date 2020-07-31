import 'package:cmp_customer/models/response/parking_card_details_response.dart';
import 'package:cmp_customer/scoped_models/parking_model/parking_operation_state_model.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_picker.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'parking_card_ui.dart';

enum OperationType {
  //操作类型
  operationXF, //续费
  operationTZ //退租
}

//停车卡（续费和退租）
class ParkingCardOperationPage extends StatelessWidget {
  ParkingOperationStateModel _stateModel;
  OperationType type;
  ParkingCardDetailsInfo detailsInfo;
  double fee; //续费套餐金额
  ParkingCardOperationPage(this.type, this.detailsInfo, {this.fee});
//  @override
//  State<StatefulWidget> createState() {
//    // TODO: implement createState
//    return ParkingCardOperation();
//  }
//
//}
//
//class ParkingCardOperation extends State<ParkingCardOperationPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
//    _stateModel = ParkingOperationStateModel.of(context);
    if (_stateModel == null) {
      _stateModel = new ParkingOperationStateModel(fee);
      _stateModel.detailsInfo = detailsInfo;
//      _stateModel.setExpectStopDate(detailsInfo.cancelEndTime);
      _stateModel.getAgreementInfo();
      _stateModel.setApplyMonthListenr();
    }
    return ScopedModel<ParkingOperationStateModel>(
        model: _stateModel,
        child: ScopedModelDescendant<ParkingOperationStateModel>(
            builder: (context, child, model) {
          ParkingCardDetailsInfo info = detailsInfo;
          return CommonScaffold(
            appTitle: type == OperationType.operationXF ? "月卡续费" : "月卡退租",
            bodyData: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                      color: color_layout_bg,
                      child: Column(
                        children: <Widget>[
                          labelTextWidget(
                            label: label_apply_parking_place,
                            text: info.parkingLot ?? "",
                            topSpacing: top_spacing,
                          ),
                          labelTextWidget(
                            label: label_apply_parking_packages,
                            text: info.parkingPackage ?? "",
                            topSpacing: top_spacing,
                          ),
                          labelTextWidget(
                            label: label_apply_car_no,
                            text: info.carNo ?? "",
                            topSpacing: top_spacing,
                          ),
                          labelTextWidget(
                            label: label_apply_car_brand,
                            text: info.carBrand ?? "",
                            topSpacing: top_spacing,
                          ),
                          labelTextWidget(
                            label: label_apply_car_color,
                            text: info.carColor ?? "",
                            topSpacing: top_spacing,
                          ),
                          labelTextWidget(
                            label: label_apply_driver_name,
                            text: info.carOwnerName ?? "",
                            topSpacing: top_spacing,
                          ),
                          labelTextWidget(
                            label: label_apply_driver_phone,
                            text: info.carOwnerPhone,
                            topSpacing: top_spacing,
                          ),
                          labelTextWidget(
                            label: label_apply_old_start_n_stop_date,
                            text: StringsHelper.getStringValue(
                                    info.effectTime) +
                                "至" +
                                StringsHelper.getStringValue(info.validEndTime),
                            topSpacing: top_spacing,
                            bottomSpacing: bottom_spacing,
                          ),
                        ],
                      )),
                  Visibility(
                    visible: type == OperationType.operationTZ,
                    child: GestureDetector(
                      child: Container(
                          color: color_layout_bg,
                          margin: EdgeInsets.only(
                            top: card_spacing,
                          ),
                          child: Column(
                            children: <Widget>[
                              labelTextWidget(
                                label: label_apply_stop_date,
                                needArrow: true,
                                text: model.cancelEndTime ??
                                    hint_expect_stop_date,
                                topSpacing: top_spacing,
                                bottomSpacing: bottom_spacing,
                                color: model.cancelEndTime == null
                                    ? color_text_hint
                                    : color_text,
                              ),
                            ],
                          )),
                      onTap: () {
                        CommonPicker.datePickerModal(context,
                            onConfirm: (String date) {
                          model.setExpectStopDate(date);
                        });
                      },
                    ),
                  ),
                  Visibility(
                    visible: type == OperationType.operationXF,
                    child: Container(
                        color: color_layout_bg,
                        margin: EdgeInsets.only(top: card_spacing),
                        child: Column(
                          children: <Widget>[
                            labelInputWidget(
                              _stateModel.applyMonthsController,
                              label: label_apply_duration_renew,
                              isRequired: true,
                              unit: label_unit_month,
                              topSpacing: top_spacing,
                              bottomSpacing: bottom_spacing,
                            ),
                            horizontalLineWidget(
                              spacing: horizontal_spacing,
                            ),
                            labelTextWidget(
                                label: label_apply_fee,
                                text: StringsHelper.getStringValue(
                                    _stateModel.payFee),
                                unit: label_unit_fee,
                                topSpacing: top_spacing,
                                bottomSpacing: bottom_spacing),
                          ],
                        )),
                  ),
                  Visibility(
                      visible: type == OperationType.operationXF,
                      child:
//                      Container(
//                        //            margin: EdgeInsets.only(top: card_spacing),
//                        child: Row(
//                          children: <Widget>[
//                            Checkbox(
//                              tristate: true,
//                              value: model.agree,
//                              onChanged: model.onChangeAgree,
//                            ),
//                            Text(
//                              "同意",
//                              style: TextStyle(fontSize: little_text_size),
//                            ),
//                            GestureDetector(
//                              onTap: () {
//                                print("查看协议");
//                              },
//                              child: Text(
//                                label_apply_business_agreement,
//                                style: TextStyle(
//                                    fontSize: little_text_size,
//                                    color: color_text_red),
//                              ),
//                            )
//                          ],
//                        ),
//                      )
                    Container(
                      margin: EdgeInsets.symmetric(vertical: vertical_spacing),
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              model.onChangeAgree();
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: left_spacing, right: text_spacing),
                              child: model.agree
                                  ? UIData.iconCheckBoxSelected
                                  : UIData.iconCheckBoxNormal,
                            ),
                          ),
//                    Checkbox(
//                      tristate: true,
//                      value: model.agree,
//                      onChanged: model.onChangeAgree,
//                    ),
                          Text(
                            "同意",
                            style: TextStyle(fontSize: UIData.fontSize11),
                          ),
                          GestureDetector(
                            onTap: () {
                              model.toAgreementPage();
                            },
                            child: Text(
                              label_apply_business_agreement,
                              style: TextStyle(
                                  fontSize: UIData.fontSize11,
                                  color: color_text_red),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: StadiumSolidButton(
              label_submit,
              btnType: ButtonType.CONFIRM,
              onTap: () {
                if (type == OperationType.operationXF) {
                  model.uploadXFData();
                } else {
                  model.uploadTZData();
                }
              },
              enable: type == OperationType.operationXF ? model.agree : true,
            ),
          );
        }));
  }
}
