import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/request/parking_card_apply_request.dart';
import 'package:cmp_customer/models/response/parking_card_details_response.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/scoped_models/parking_model/parking_apply_state_model.dart';
import 'package:cmp_customer/ui/common/car_number_input_keyboard.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_dialog.dart';
import 'package:cmp_customer/ui/common/common_image_picker.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/parking/parking_card_price.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'parking_card_ui.dart';

//停车卡申请
class ParkingCardApplyPage extends StatefulWidget {
  ParkingCardDetailsInfo detailsInfo;
  ParkingCardApplyPage({this.detailsInfo});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ParkingCardApply();
  }
}

class ParkingCardApply extends State<ParkingCardApplyPage> {
  ParkingApplyStateModel _stateModel;
  bool _showCarNoInputView = false; //是否显示车牌号键盘
//  bool checkboxState=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _stateModel = new ParkingApplyStateModel();
    if (widget.detailsInfo != null) {
      _stateModel.setDetailsInfo(widget.detailsInfo);
    } else {
      //默认申请人
      _stateModel.carOwnerNameController.text = stateModel.customerName;
      _stateModel.carOwnerPhoneController.text = stateModel.mobile;
    }
    _stateModel.getParkingPrices();
    _stateModel.getAgreementInfo();
    _stateModel.setApplyMonthListener();
  }

  //布局
  Widget _buildBody(ParkingCardApplyRequest applyInfo) {
    return CommonScaffold(
      appTitle: "停车办理",
      bodyData: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigate.toNewPage(ParkingCardPricePage(_stateModel));
              },
              child: Container(
                color: color_layout_bg,
                margin: EdgeInsets.only(top: vertical_spacing),
                padding: EdgeInsets.only(right: right_spacing),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(
                            left: left_spacing,
                            top: top_spacing,
                            bottom: bottom_spacing),
                        child: Text(
                          applyInfo.parkingPackage == null
                              ? "请选择停车场"
                              : StringsHelper.getStringValue(
                                      applyInfo.parkingLot) +
                                  " - " +
                                  StringsHelper.getStringValue(
                                      applyInfo.parkingPackage),
                          style: TextStyle(fontSize: normal_text_size),
                        ),
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_right,
                      size: normal_right_icon_size,
                      color: color_icon_right,
                    ),
//                        GestureDetector(
//                          child: Container(
//                            alignment: Alignment.centerLeft,
//                            margin: EdgeInsets.only(right: right_spacing),
//                            child: Text(
//                              label_apply_charge_standard,
//                              style: TextStyle(
//                                  color: color_text_red,
//                                  fontSize: normal_text_size),
//                            ),
//                          ),
//                          onTap: () {
//                            CommonDialog.showAlertDialog(context,
//                                content: model.agreementInfo.agreementContent??"",
//                                showNegativeBtn: false);
//                          },
//                        )
                  ],
                ),
              ),
            ),
//              Container(
//                  color: color_layout_bg,
//                  margin: EdgeInsets.only(top: vertical_spacing),
//                  child: Column(
//                    children: <Widget>[
//                      labelInputWidget(null, label: label_apply_persion,
//                          isRequired: true,
//                          topSpacing: top_spacing,
//                          bottomSpacing: bottom_spacing),
//                      Container(height: line_height,
//                          color: color_line,
//                          margin: EdgeInsets.symmetric(
//                              horizontal: horizontal_spacing)),
//                      labelInputWidget(null, label: label_apply_phone,
//                          isRequired: true,
//                          topSpacing: top_spacing,
//                          bottomSpacing: bottom_spacing),
//                    ],
//                  )
//              ),
            Container(
                color: color_layout_bg,
                margin: EdgeInsets.only(top: vertical_spacing),
                child: Column(
                  children: <Widget>[
//                    labelInputWidget(_stateModel.carNoController,
//                        label: label_apply_car_no,
//                        text: applyInfo.carNo ?? "",
//                        isRequired: true,
//                        topSpacing: top_spacing,
//                        bottomSpacing: bottom_spacing),
                    GestureDetector(
                      child:
                      labelTextWidget(
                        label: label_apply_car_no,
                        text: applyInfo.carNo ?? hint_text_required,
                        topSpacing: top_spacing,
                        labelColor: UIData.darkGreyColor,
                        color: StringsHelper.isEmpty(applyInfo.carNo)?UIData.lightGreyColor:UIData.darkGreyColor,
                        bottomSpacing: bottom_spacing,),
                      onTap: (){
                        setState(() {
                          FocusScope.of(context).requestFocus(FocusNode());
                          _showCarNoInputView = true;
                        });
                      },
                    ),
                    Container(
                      height: line_height,
                      color: color_line,
                      margin:
                          EdgeInsets.symmetric(horizontal: horizontal_spacing),
                    ),
                    labelInputWidget(_stateModel.carBrandController,
                        text: applyInfo.carBrand ?? "",
                        label: label_apply_car_brand,
                        topSpacing: top_spacing,
                        bottomSpacing: bottom_spacing),
                    Container(
                      height: line_height,
                      color: color_line,
                      margin:
                          EdgeInsets.symmetric(horizontal: horizontal_spacing),
                    ),
                    labelInputWidget(_stateModel.carColorController,
                        text: applyInfo.carColor ?? "",
                        label: label_apply_car_color,
                        topSpacing: top_spacing,
                        bottomSpacing: bottom_spacing),
                    Container(
                      height: line_height,
                      color: color_line,
                      margin:
                          EdgeInsets.symmetric(horizontal: horizontal_spacing),
                    ),
                    labelInputWidget(_stateModel.carOwnerNameController,
                        text: applyInfo.carOwnerName ?? "",
                        label: label_apply_driver_name,
                        isRequired: true,
                        topSpacing: top_spacing,
                        bottomSpacing: bottom_spacing),
                    Container(
                      height: line_height,
                      color: color_line,
                      margin:
                          EdgeInsets.symmetric(horizontal: horizontal_spacing),
                    ),
                    labelInputWidget(
                      _stateModel.carOwnerPhoneController,
                      text: applyInfo.carOwnerPhone ?? "",
                      label: label_apply_driver_phone,
                      isRequired: true,
                      topSpacing: top_spacing,
                      bottomSpacing: bottom_spacing,
                      keyboardType: TextInputType.phone,
                      limitLength: 11,
                    ),
                    Container(
                      height: line_height,
                      color: color_line,
                      margin:
                          EdgeInsets.symmetric(horizontal: horizontal_spacing),
                    ),
                    labelInputWidget(_stateModel.applyMonthsController,
                        text:
                            StringsHelper.getStringValue(applyInfo.applyMonths),
                        label: label_apply_time,
                        isRequired: true,
                        limitLength: 2,
                        unit: label_unit_month,
                        topSpacing: top_spacing,
                        bottomSpacing: bottom_spacing,
                        keyboardType: TextInputType.number),
                    Container(
                      height: line_height,
                      color: color_line,
                      margin:
                          EdgeInsets.symmetric(horizontal: horizontal_spacing),
                    ),
                    labelTextWidget(
                        label: label_apply_fee,
                        text: StringsHelper.getStringValue(applyInfo.payFees),
                        unit: label_unit_fee,
                        topSpacing: top_spacing,
                        bottomSpacing: bottom_spacing),
                  ],
                )),
            Container(
                color: color_layout_bg,
                margin: EdgeInsets.only(top: vertical_spacing),
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      margin:
                          EdgeInsets.only(left: left_spacing, top: top_spacing),
                      height: single_height,
                      child: Text(label_apply_upload_driving_license,
                          style: TextStyle(
                              fontSize: normal_text_size, color: color_text)),
                    ),
//                      Container(height: line_height,
//                        color: color_line,
//                        margin: EdgeInsets.symmetric(
//                            horizontal: horizontal_spacing),),
                    Container(
                      margin: EdgeInsets.all(horizontal_spacing),
                      child: CommonImagePicker(
                        photoIdList: applyInfo.attList,
                        callback: _stateModel.imagesCallback,
                      ),
                    ),
                    //                  GridView.builder(
                    //
                    //                  )
                  ],
                )),
            Container(
              margin: EdgeInsets.symmetric(vertical: vertical_spacing),
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      _stateModel.onChangeAgree();
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: left_spacing, right: text_spacing),
                      child: _stateModel.agree
                          ? UIData.iconCheckBoxSelected
                          : UIData.iconCheckBoxNormal,
                    ),
                  ),
//                    Checkbox(
//                      tristate: true,
//                      value: _stateModel.agree,
//                      onChanged: _stateModel.onChangeAgree,
//                    ),
                  Text(
                    "同意",
                    style: TextStyle(fontSize: UIData.fontSize11),
                  ),
                  GestureDetector(
                    onTap: () {
                      _stateModel.toAgreementPage();
                    },
                    child: Text(
                      label_apply_business_agreement,
                      style: TextStyle(
                          fontSize: UIData.fontSize11, color: color_text_red),
                    ),
                  )
                ],
              ),
            ),
            //          Container(
            //            margin: EdgeInsets.only(top: single_height),
            //            alignment: Alignment.center,
            //            child: RaisedButton(
            //              color: UIData.lightestRedColor,
            //              highlightColor: UIData.lightestRedColor,
            //            ),
            //          )
          ],
        ),
      ),
      bottomNavigationBar: StadiumSolidButton(
        label_submit,
        btnType: ButtonType.CONFIRM,
        onTap: () {
          _stateModel.checkUploadData();
        },
        enable: _stateModel.agree,
      ),
    );
  }

  //车牌号码键盘
  Widget _buildCarNoKeyboard() {
    return Theme(
        data: Theme.of(context).copyWith(),
        child: Material(
          color: Colors.transparent,
          child: Offstage(
            offstage: !_showCarNoInputView,
            child: CarNoInputKeyboard(
              carNo: _stateModel.applyInfo?.carNo ?? "",
              onCancel: () {
                setState(() {
                  _showCarNoInputView = false;
                });
              },
              onConfirm: (String carNo) {
                if (!StringsHelper.isCarNo(carNo)) {
                  CommonToast.show(msg: '请输入正确车牌号', type: ToastIconType.INFO);
                } else {
                  setState(() {
                    _showCarNoInputView = false;
                    _stateModel.applyInfo?.carNo = carNo;
                  });
                }
              },
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModel<ParkingApplyStateModel>(
        model: _stateModel,
        child: ScopedModelDescendant<ParkingApplyStateModel>(
            builder: (context, child, model) {
          ParkingCardApplyRequest applyInfo = model?.applyInfo;
          return Stack(
              children: <Widget>[_buildBody(applyInfo), _buildCarNoKeyboard()]);
        }));
  }
}

//const String parking_card_label_type="办理类型";
//const String parking_card_label_type="办理类型";
//const String parking_card_label_type="办理类型";
//const String parking_card_label_type="办理类型";

//横线
Widget horizontalLine = Container(
  height: 1,
  color: Colors.grey,
);
