import 'package:cmp_customer/models/response/check_in_details_response.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/scoped_models/check_in_model/check_in_apply_state_model.dart';
import 'package:cmp_customer/strings/strings_house_auth.dart';
import 'package:cmp_customer/ui/check_in/check_in_history.dart';
import 'package:cmp_customer/ui/check_in/check_in_label.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_image_picker.dart';
import 'package:cmp_customer/ui/common/common_picker.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/parking/parking_card_ui.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../main.dart';

//租户入驻申请
class CheckInApplyPage extends StatefulWidget {
  CheckInDetails details;

  CheckInApplyPage({this.details});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CheckInApply();
  }
}

class _CheckInApply extends State<CheckInApplyPage> {
  CheckInApplyModel _applyModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _applyModel = new CheckInApplyModel();
    if (widget.details != null) {
      _applyModel.setDetailsInfo(widget.details);
    } else {
      _applyModel.setGender("1"); //设置默认的性别
      _applyModel.applyRequest.projectId = stateModel.defaultProjectId; //默认带出项目id
      _applyModel.applyRequest.formerName = stateModel.defaultProjectName; //默认带出项目名称
//      _applyModel.getHouseList();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    Widget _buildContent() {
      return ScopedModelDescendant<CheckInApplyModel>(builder: (context, child, model) {
        CheckInDetails applyRequest = model.applyRequest;
        return CommonScaffold(
            appTitle: label_apply_tenant_entry_apply,
            bodyData: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    color: color_layout_bg,
                    margin: EdgeInsets.only(top: top_spacing),
                    child: Column(
                      children: <Widget>[
                        leftTextWidget(
                          text: label_apply_base_info,
                          topSpacing: top_spacing,
                          isBold: true,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              margin:
                                  EdgeInsets.only(left: left_spacing, top: top_spacing, bottom: bottom_spacing),
                              width: label_width,
                              child: CommonText.darkGrey15Text(label_apply_tenant_type),
                            ),
                            ChoiceChip(
                              label: CommonText.text14(label_apply_individual_customer,
                                  color: model.isEnterprise ? UIData.darkGreyColor : UIData.primaryColor),
                              selected: !model.isEnterprise,
                              selectedColor: UIData.themeBgColor,
                              onSelected: (selected) {
                                //新建才可以修改
                                if (model.applyRequest.rentingEnterId == null) {
                                  model.setCustomerType(CustomerType.individual);
                                }
                              },
                            ),
                            Container(
                              width: ScreenUtil.getInstance().setWidth(30),
                            ),
                            ChoiceChip(
                              label: CommonText.text14(label_apply_enterprise_customer,
                                  color: model.isEnterprise ? UIData.primaryColor : UIData.darkGreyColor),
                              selected: model.isEnterprise,
                              selectedColor: UIData.themeBgColor,
                              onSelected: (selected) {
                                //新建才可以修改
                                if (model.applyRequest.rentingEnterId == null) {
                                  model.setCustomerType(CustomerType.enterprise);
                                }
                              },
                            ),
                          ],
                        ),
                        CommonDivider(),
                        GestureDetector(
                          child: labelTextWidget(
                            label: label_apply_entry_type,
                            labelColor: color_text,
                            needArrow: true,
                            topSpacing: top_spacing,
                            bottomSpacing: bottom_spacing,
                            text: entryTypeMap[applyRequest.enterType] ?? label_please_select_type,
                          ),
                          onTap: () {
                            CommonPicker.singlePickerModal(context, entryTypeMap.values.toList(),
                                onConfirm: (int index, String data) {
                              model.setEntryType(index);
                            });
                          },
                        ),
                        CommonDivider(),
                        labelInputWidget(
                          model.applyNameController,
                          topSpacing: top_spacing,
                          bottomSpacing: bottom_spacing,
                          label: label_apply_apply_person,
                          isRequired: true,
                        ),
                        CommonDivider(),
                        labelInputWidget(model.applyPhoneController,
                            topSpacing: top_spacing,
                            bottomSpacing: bottom_spacing,
                            label: label_apply_apply_phone,
                            isRequired: true,
                            limitLength: 13,
                            keyboardType: TextInputType.phone),
                        CommonDivider(),
//                        labelTextWidget(
//                          label: label_apply_community,
//                          labelColor: color_text,
//                          topSpacing: top_spacing,
//                          bottomSpacing: bottom_spacing,
//                          text: stateModel.defaultProjectName ?? "",
//                        ),
                        GestureDetector(
                          child: labelTextWidget(
                            label: label_apply_community,
                            labelColor: color_text,
                            needArrow: model.applyRequest.rentingEnterId == null ? true : false,
                            topSpacing: top_spacing,
                            bottomSpacing: bottom_spacing,
                            text: applyRequest.formerName ?? label_please_select_community,
                            color: model.applyRequest.rentingEnterId == null
                                ? UIData.darkGreyColor
                                : UIData.lightGreyColor,
                          ),
                          onTap: () {
                            //新建才可以修改社区
                            if (model.applyRequest.rentingEnterId == null) {
                              model.selectCommunity();
                            }
                          },
                        ),
                        CommonDivider(),
                        GestureDetector(
                          child: labelTextWidget(
                            label: label_apply_house,
                            labelColor: color_text,
                            needArrow: model.applyRequest.rentingEnterId == null,
                            topSpacing: top_spacing,
                            bottomSpacing: bottom_spacing,
//                            text: model.isLoadingHouse? "加载中" : applyRequest.houseNo??label_please_select_house,
                            text: applyRequest.houseNo ?? label_please_select_house,
                            color: model.applyRequest.rentingEnterId == null
                                ? UIData.darkGreyColor
                                : UIData.lightGreyColor,
                          ),
                          onTap: () {
                            if (model.applyRequest.rentingEnterId == null) model.selectHouse();
                          },
                        ),
                        CommonDivider(),
                        leftTextWidget(
                          text: label_apply_letter_required,
                          topSpacing: top_spacing,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: horizontal_spacing),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: vertical_spacing),
                            child: CommonImagePicker(
                              attachmentList: applyRequest.attRzqrhList ?? null,
                              callbackWithInfo: model.imagesLetterCallback,
                            ),
                          ),
                        ),
                        CommonDivider(),
                        GestureDetector(
                          child: labelTextWidget(
                            label: label_apply_appointment_time,
                            labelColor: color_text,
                            topSpacing: top_spacing,
                            bottomSpacing: bottom_spacing,
                            needArrow: true,
                            text: applyRequest.bookReprocessTime ?? label_please_select_time,
                          ),
                          onTap: () {
                            CommonPicker.datePickerModal(context, type: PickerDateTimeType.kYMDHM, needTime: true,
                                onConfirm: (String date) {
                              model.setAppointmentTime(date);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: color_layout_bg,
                    margin: EdgeInsets.only(top: top_spacing),
                    child: Column(
                      children: <Widget>[
                        leftTextWidget(
                          text: label_apply_customer_info,
                          topSpacing: top_spacing,
                          isBold: true,
                        ),
                        labelInputWidget(
                          model.tenantNameController,
                          topSpacing: top_spacing,
                          bottomSpacing: bottom_spacing,
                          label: label_apply_house_tenant,
                          isRequired: true,
                        ),
                        CommonDivider(),
                        GestureDetector(
                          child: labelTextWidget(
                            label: label_apply_document_type,
                            labelColor: color_text,
                            needArrow: true,
                            topSpacing: top_spacing,
                            bottomSpacing: bottom_spacing,
                            text: (model.isEnterprise
                                    ? documentQYMap[applyRequest.idType]
                                    : documentGRMap[applyRequest.idType]) ??
                                label_please_select_type,
                          ),
                          onTap: () {
                            CommonPicker.singlePickerModal(context,
                                model.isEnterprise ? documentQYMap.values.toList() : documentGRMap.values.toList(),
                                onConfirm: (int index, String data) {
                              model.setDocumentType(index);
                            });
                          },
                        ),
                        CommonDivider(),
                        labelInputWidget(
                          model.documentNumberController,
                          topSpacing: top_spacing,
                          bottomSpacing: bottom_spacing,
                          label: label_apply_document_number,
                          isRequired: true,
                          limitLength: 30,
                        ),
                        Visibility(
                          visible: model.isEnterprise,
                          child: CommonDivider(),
                        ),
                        Visibility(
                          visible: model.isEnterprise,
                          child: labelInputWidget(
                            model.legalController,
                            label: label_apply_enterprise_legal_person,
                          ),
                        ),
                        CommonDivider(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              margin:
                                  EdgeInsets.only(left: left_spacing, top: top_spacing, bottom: bottom_spacing),
                              width: label_width,
                              child: CommonText.darkGrey15Text(label_apply_gender),
                            ),
                            ChoiceChip(
                              label: CommonText.text14(label_apply_gender_man,
                                  color: applyRequest.gender == "1" ? UIData.primaryColor : UIData.darkGreyColor),
                              selected: applyRequest.gender == "1",
                              selectedColor: UIData.themeBgColor,
                              onSelected: (selected) {
                                model.setGender("1");
                              },
                            ),
                            Container(
                              width: ScreenUtil.getInstance().setWidth(30),
                            ),
                            ChoiceChip(
                              label: CommonText.text14(label_apply_gender_woman,
                                  color: applyRequest.gender == "2" ? UIData.primaryColor : UIData.darkGreyColor),
                              selected: applyRequest.gender == "2",
                              selectedColor: UIData.themeBgColor,
                              onSelected: (selected) {
                                model.setGender("2");
                              },
                            ),
                          ],
                        ),
                        Visibility(
                          visible: model.isEnterprise,
                          child: CommonDivider(),
                        ),
                        Visibility(
                          visible: model.isEnterprise,
                          child: labelInputWidget(
                            model.contactNameController,
                            label: label_apply_contact_person,
                          ),
                        ),
                        CommonDivider(),
                        labelInputWidget(model.contactPhoneController,
                            topSpacing: top_spacing,
                            bottomSpacing: bottom_spacing,
                            label: label_apply_contact_phone,
                            limitLength: 11,
                            keyboardType: TextInputType.phone),
                        CommonDivider(),
                        GestureDetector(
                          child: labelTextWidget(
                            label: label_apply_house_use,
                            labelColor: color_text,
                            needArrow: true,
                            topSpacing: top_spacing,
                            bottomSpacing: bottom_spacing,
                            text: houseUseTypeMap[applyRequest.houseUsage] ?? label_please_select_type,
                          ),
                          onTap: () {
                            CommonPicker.singlePickerModal(context, houseUseTypeMap.values.toList(),
                                onConfirm: (int index, String data) {
                              model.houseUseType(index);
                            });
                          },
                        ),
                        CommonDivider(),
                        GestureDetector(
                          child: labelTextWidget(
                            label: label_apply_entry_time,
                            labelColor: color_text,
                            needArrow: true,
                            topSpacing: top_spacing,
                            bottomSpacing: bottom_spacing,
                            text: applyRequest.enterDate ?? label_please_select_time,
                          ),
                          onTap: () {
                            CommonPicker.datePickerModal(context, onConfirm: (String date) {
                              model.setEntryTime(date);
                            });
                          },
                        ),
                        CommonDivider(),
                        labelInputWidget(
                          model.emergencyNameController,
                          topSpacing: top_spacing,
                          bottomSpacing: bottom_spacing,
                          label: model.isEnterprise
                              ? label_apply_primary_contact_person
                              : label_apply_emergency_contact_person,
                          isRequired: true,
                        ),
                        CommonDivider(),
                        labelInputWidget(model.emergencyPhoneController,
                            topSpacing: top_spacing,
                            bottomSpacing: bottom_spacing,
                            label: model.isEnterprise
                                ? label_apply_primary_contact_phone
                                : label_apply_emergency_contact_phone,
                            isRequired: true,
                            limitLength: 11,
                            keyboardType: TextInputType.phone),
                        Visibility(
                          visible: !model.isEnterprise,
                          child: CommonDivider(),
                        ),
                        Visibility(
                          visible: !model.isEnterprise,
                          child: labelInputWidget(
                            model.relationController,
                            topSpacing: top_spacing,
                            bottomSpacing: bottom_spacing,
                            label: label_apply_emergency_contact_relation,
                            isRequired: true,
                          ),
                        ),
                        CommonDivider(),
                        leftTextWidget(
                          text: label_apply_attachment_info,
                          topSpacing: top_spacing,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: horizontal_spacing, vertical: vertical_spacing),
                          child: CommonImagePicker(
                            attachmentList: applyRequest.attZhrzList ?? null,
                            callbackWithInfo: model.imagesAttachmentCallback,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: model.isEnterprise,
                    child: Container(
                      color: color_layout_bg,
                      margin: EdgeInsets.only(top: top_spacing),
                      child: Column(
                        children: <Widget>[
                          leftTextWidget(
                            text: label_apply_enterprise_info,
                            topSpacing: top_spacing,
                            isBold: true,
                          ),
                          labelInputWidget(
                            model.enterpriseNatureController,
                            label: label_apply_enterprise_nature,
                            hint: '国营/私营',
                          ),
                          CommonDivider(),
                          labelInputWidget(
                            model.propertyAreaController,
                            label: label_apply_property_area,
                            unit: "㎡",
                          ),
                          CommonDivider(),
                          labelInputWidget(
                            model.propertyLocationController,
                            label: label_apply_property_location,
                          ),
                          CommonDivider(),
                          labelInputWidget(
                            model.propertyAddressController,
                            label: label_apply_property_address,
                          ),
                          CommonDivider(),
                          labelInputWidget(
                            model.bankNameController,
                            label: label_apply_bank_name,
                          ),
                          CommonDivider(),
                          labelInputWidget(
                            model.bankNumberController,
                            label: label_apply_bank_number,
                          ),
                          CommonDivider(),
                          labelInputWidget(
                            model.taxesController,
                            label: label_apply_taxes,
                          ),
                          CommonDivider(),
                          labelInputWidget(
                            model.taxesTypeController,
                            label: label_apply_taxes_type,
                          ),
                          CommonDivider(),
                          labelInputWidget(
                            model.enterpriseCodeController,
                            label: label_apply_enterprise_code,
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      child: Container(
                          color: UIData.scaffoldBgColor,
                          padding: EdgeInsets.all(UIData.spaceSize16),
                          child: Row(
                            children: <Widget>[
                              UIData.iconInfoOutline,
                              SizedBox(width: UIData.spaceSize4),
                              CommonText.text12(label_apply_entry_tip, color: color_text_red)
                            ],
                          )),
                      onTap: () {
                        model.toEntryTipPage();
                      }),
                ],
              ),
            ),
            bottomNavigationBar: StadiumSolidButton(
              label_submit,
              btnType: ButtonType.CONFIRM,
              onTap: () {
                model.checkUploadData();
              },
            ),
            appBarActions: <Widget>[
              Builder(builder: (context) {
                return FlatButton(
                    onPressed: () {
                      Navigate.toNewPage(CheckInHistoryPage());
                    },
//                    child: Container(
//                        alignment: Alignment.centerRight,
//                        padding: EdgeInsets.only(right: right_spacing),
                    child: CommonText.text15("申请列表", color: color_text_red, textAlign: TextAlign.center)
//                )
                    );
              })
            ]);
      });
    }

//    Widget _buildBody() {
//      return ScopedModelDescendant<CheckInApplyModel>(builder: (context, child, model) {
//        return CommonLoadContainer(
//            state: _applyModel.listState,
//            content: _buildContent(),
//            callback: () {
//            });
//      });
//    }
    return ScopedModel<CheckInApplyModel>(model: _applyModel, child: _buildContent());
  }
}
