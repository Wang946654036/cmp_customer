import 'package:cmp_customer/models/response/check_in_details_response.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/scoped_models/check_in_model/check_in_details_state_model.dart';
import 'package:cmp_customer/strings/strings_house_auth.dart';
import 'package:cmp_customer/ui/check_in/check_in_label.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_image_display.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/parking/parking_card_ui.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'check_in_node.dart';
import 'check_in_status.dart';

//租户入驻详情
class CheckInDetailsPage extends StatefulWidget {
  int id;
  CheckInDetailsPage(this.id);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CheckInDetails();
  }
}

class _CheckInDetails extends State<CheckInDetailsPage> {
  CheckInDetailsModel _detailsModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _detailsModel = new CheckInDetailsModel();
    _detailsModel.getDetails(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Widget _buildContent() {
      return ScopedModelDescendant<CheckInDetailsModel>(
          builder: (context, child, model) {
          CheckInDetails details = model.checkIndetails;
        return SingleChildScrollView(
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
                        isBold: true,),
                        labelTextWidget(
                          label: label_apply_tenant_type,
                          topSpacing: top_spacing,
                          bottomSpacing: bottom_spacing,
                          text: getRentTypeName(details.rentType),
                        ),
                        CommonDivider(),
                        labelTextWidget(
                            label: label_apply_entry_type,
                            topSpacing: top_spacing,
                            bottomSpacing: bottom_spacing,
                            text: entryTypeMap[details.enterType??""]??"",
                        ),
                        CommonDivider(),
                        labelTextWidget(
                          label: label_apply_apply_person,
                          topSpacing: top_spacing,
                          bottomSpacing: bottom_spacing,
                          text: details.customerName??"",
                        ),
                        CommonDivider(),
                        labelTextWidget(
                          label: label_apply_apply_phone,
                          topSpacing: top_spacing,
                          bottomSpacing: bottom_spacing,
                          text: details.customerPhone??"",
                        ),
                        CommonDivider(),
                        labelTextWidget(
                          label: label_apply_community,
                          topSpacing: top_spacing,
                          bottomSpacing: bottom_spacing,
                          text: details.formerName??"",
//                            text: applyRequest ?? label_please_select_community,
                        ),
                        CommonDivider(),
                        labelTextWidget(
                          label: label_apply_house,
                          topSpacing: top_spacing,
                          bottomSpacing: bottom_spacing,
                          text: details.houseNo??"",
                        ),
                        CommonDivider(),
                        leftTextWidget(
                          text: label_apply_letter,
                          topSpacing: top_spacing,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: horizontal_spacing),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: vertical_spacing),
                            child:CommonImageDisplay(
                                photoIdList: details.attRzqrhList?.map((Attachment attach) => attach?.attachmentUuid)
                                    ?.toList()??null,
                            ),
                          ),
                        ),
                        CommonDivider(),
                        labelTextWidget(
                            label: label_apply_appointment_time,
                            topSpacing: top_spacing,
                            bottomSpacing: bottom_spacing,
                          text: details.bookReprocessTime??"",
                        ),
                        CommonDivider(),
                        labelTextWidget(
                          label: label_apply_select_status,
                          topSpacing: top_spacing,
                          bottomSpacing: bottom_spacing,
                          text: getStateText(details.status),
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
                        labelTextWidget(
                          label: label_apply_house_tenant,
                          topSpacing: top_spacing,
                          bottomSpacing: bottom_spacing,
                          text: details.rentersName??"",
                        ),
                        CommonDivider(),
                    labelTextWidget(
                            label: label_apply_document_type,
                            topSpacing: top_spacing,
                            bottomSpacing: bottom_spacing,
                      text: model.isEnterprise?documentQYMap[details.idType]:documentGRMap[details.idType],
                        ),
                        CommonDivider(),
                        labelTextWidget(
                          label: label_apply_document_number,
                          topSpacing: top_spacing,
                          bottomSpacing: bottom_spacing,
                          text: details.idNum??"",
                        ),
                        Visibility(
                          visible: model.isEnterprise,
                          child:CommonDivider(),
                        ),
                        Visibility(
                          visible: model.isEnterprise,
                          child:labelTextWidget(
                            label: label_apply_enterprise_legal_person,
                            topSpacing: top_spacing,
                            bottomSpacing: bottom_spacing,
                            text: details.legalPersonName??"",
                          ),
                        ),
                        CommonDivider(),
                        labelTextWidget(
                          label: label_apply_gender,
                          topSpacing: top_spacing,
                          bottomSpacing: bottom_spacing,
                          text: details.gender=="1"?label_apply_gender_man:label_apply_gender_woman,
                        ),
                        Visibility(
                          visible: model.isEnterprise,
                          child:CommonDivider(),
                        ),
                        Visibility(
                          visible: model.isEnterprise,
                          child:labelTextWidget(
                            label: label_apply_contact_person,
                            topSpacing: top_spacing,
                            bottomSpacing: bottom_spacing,
                            text: details.contactName??"",
                          ),
                        ),
                        CommonDivider(),
                        labelTextWidget(
                          label: label_apply_contact_phone,
                          topSpacing: top_spacing,
                          bottomSpacing: bottom_spacing,
                          text: details.contactPhone??"",
                        ),
                        CommonDivider(),
                        labelTextWidget(
                            label: label_apply_house_use,
                          topSpacing: top_spacing,
                          bottomSpacing: bottom_spacing,
                          text: houseUseTypeMap[details.houseUsage]??"",
                        ),
                        CommonDivider(),
                        labelTextWidget(
                            label: label_apply_entry_time,
                            topSpacing: top_spacing,
                            bottomSpacing: bottom_spacing,
                          text: details.enterDate??"",
                        ),
                        CommonDivider(),
                        labelTextWidget(
                          label: model.isEnterprise?label_apply_primary_contact_person:label_apply_emergency_contact_person,
                          topSpacing: top_spacing,
                          bottomSpacing: bottom_spacing,
                          text: details.emerContactName??"",
                        ),
                        CommonDivider(),
                        labelTextWidget(
                          label: model.isEnterprise?label_apply_primary_contact_phone:label_apply_emergency_contact_phone,
                          topSpacing: top_spacing,
                          bottomSpacing: bottom_spacing,
                          text: details.emerContactPhone??"",
                        ),
                        Visibility(
                          visible: !model.isEnterprise,
                          child:CommonDivider(),
                        ),
                        Visibility(
                          visible: !model.isEnterprise,
                          child:labelTextWidget(
                            label: label_apply_emergency_contact_relation,
                            topSpacing: top_spacing,
                            bottomSpacing: bottom_spacing,
                            text: details.relationship??"",
                          ),
                        ),
                        CommonDivider(),
                        leftTextWidget(
                          text: label_apply_attachment_info,
                          topSpacing: top_spacing,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: horizontal_spacing,vertical: vertical_spacing),
                          child: CommonImageDisplay(
                                photoIdList: details.attZhrzList?.map((Attachment attach) => attach?.attachmentUuid)
                                    ?.toList()??null,
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
                          labelTextWidget(
                            label: label_apply_enterprise_nature,
                            topSpacing: top_spacing,
                            bottomSpacing: bottom_spacing,
                            text: details.companyProp??"",
                          ),
                          CommonDivider(),
                          labelTextWidget(
                            label: label_apply_property_area,
                            topSpacing: top_spacing,
                            bottomSpacing: bottom_spacing,
                            unit: "㎡",
                            text: details.rentArea??"",
                          ),
                          CommonDivider(),
                          labelTextWidget(
                            label: label_apply_property_location,
                            topSpacing: top_spacing,
                            bottomSpacing: bottom_spacing,
                            text: details.rentLocation??"",
                          ),
                          CommonDivider(),
                          labelTextWidget(
                            label: label_apply_property_address,
                            topSpacing: top_spacing,
                            bottomSpacing: bottom_spacing,
                            text: details.rentAddress??"",
                          ),
                          CommonDivider(),
                          labelTextWidget(
                            label: label_apply_bank_name,
                            topSpacing: top_spacing,
                            bottomSpacing: bottom_spacing,
                            text: details.depositBank??"",
                          ),
                          CommonDivider(),
                          labelTextWidget(
                            label: label_apply_bank_number,
                            topSpacing: top_spacing,
                            bottomSpacing: bottom_spacing,
                            text: details.depositAccount??"",
                          ),
                          CommonDivider(),
                          labelTextWidget(
                            label: label_apply_taxes,
                            topSpacing: top_spacing,
                            bottomSpacing: bottom_spacing,
                            text: details.taxRate??"",
                          ),
                          CommonDivider(),
                          labelTextWidget(
                            label: label_apply_taxes_type,
                            topSpacing: top_spacing,
                            bottomSpacing: bottom_spacing,
                            text: details.taxCategory??"",
                          ),
                          CommonDivider(),
                          labelTextWidget(
                            label: label_apply_enterprise_code,
                            topSpacing: top_spacing,
                            bottomSpacing: bottom_spacing,
                            text: details.companyCreditCode??"",
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: StringsHelper.isNotEmpty(details.agreedReprocessTime),
                    child: Container(
                      color: color_layout_bg,
                      margin: EdgeInsets.only(top: top_spacing),
                      child: labelTextWidget(
                        label: label_apply_agree_time,
                        labelColor: color_text,
                        topSpacing: top_spacing,
                        bottomSpacing: bottom_spacing,
                        text: details.agreedReprocessTime ?? "",
                      ),
                    ),
                  ),
                  //流程节点
                  Container(
                    color: color_layout_bg,
                    margin: EdgeInsets.only(top: top_spacing),
                    child: CheckInCardNodeWidget(details?.recordList),
                  ),
                ],
            ),
            );
      });
    }

    Widget _buildBody() {
      return ScopedModelDescendant<CheckInDetailsModel>(builder: (context, child, model) {
        return CommonLoadContainer(
            state: _detailsModel.detailsState,
            content: _buildContent(),
            callback: () {
              _detailsModel.getDetails(widget.id);
            });
      });
    }
    return ScopedModel<CheckInDetailsModel>(
        model: _detailsModel, child:
        CommonScaffold(
          appTitle: "租户入驻详情",
          bodyData: _buildBody(),
        bottomNavigationBar: ScopedModelDescendant<CheckInDetailsModel>(
    builder: (context, child, model) {
      CheckInDetails details = model.checkIndetails;
      return Visibility(
          visible: _bottomVisiable(details.status),
          child: StadiumSolidWithTowButton(
            cancelText: _getCancelButtonText(details.status),
            onCancel: () {
              model.cancelOnDetailsTap();
            },
            conFirmText: _getConfirmButtonText(details.status),
            onConFirm: () {
              model.confirmOnDetailsTap();
            },
          )
      );
    }),));
  }
}

//按钮是否显示
_bottomVisiable(String state) {
  return state == auditWaiting
      || state == auditFailed
      || state == payWaiting;
}
//确认按钮文字
_getConfirmButtonText(String state) {
  switch(state){
    case auditWaiting:
    case auditFailed:
      return "修改申请";
  }
  return null;
}
//取消按钮文字
_getCancelButtonText(String state) {
  switch(state){
    case auditWaiting:
    case auditFailed:
    case payWaiting:
      return "撤回";
  }
  return null;
}
