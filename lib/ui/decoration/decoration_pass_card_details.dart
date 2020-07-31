import 'package:cmp_customer/models/hot_work_detail_model.dart';
import 'package:cmp_customer/models/response/decoration_pass_card_details_response.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/scoped_models/decoration/decoration_pass_card_details_state_model.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_image_display.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_node.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_text_field.dart';
import 'package:cmp_customer/ui/parking/parking_card_ui.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'decoration_pass_card.dart';
import 'decoration_pass_card_label.dart';
import 'decoration_pass_card_node.dart';
import 'decoration_pass_card_status.dart';
import 'decoration_pass_card_worker_item.dart';

//申请记录
/// [customerType] 查询类型，业主查询租户申请：0，查询自己的申请：1
//装修工出入证详情
class DecorationPassCardDetailsPage extends StatefulWidget {
  int id;
  final int customerType;
  DecorationPassCardDetailsPage(this.id, this.customerType);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DecorationPassCardDetails();
  }
}

class _DecorationPassCardDetails extends State<DecorationPassCardDetailsPage> {
  DecorationPassCardDetailsModel _detailsModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _detailsModel = new DecorationPassCardDetailsModel();
    _detailsModel.setCustomerType(widget.customerType);
    _detailsModel.getDetails(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    Widget _buildContent() {
      DecorationPassCardDetails details = _detailsModel.details;
      return Column(
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
                labelTextWidget(
                  label: label_apply_construction_scope,
                  text: details.houseName ?? "",
                  topSpacing: top_spacing,
                  bottomSpacing: bottom_spacing,
                ),
                CommonDivider(),
                labelTextWidget(
                  label: label_apply_construction,
                  text: details.company ?? "",
                  topSpacing: top_spacing,
                  bottomSpacing: bottom_spacing,
                ),
                CommonDivider(),
                labelTextWidget(
                  label: label_apply_document_count,
                  text: details.paperCount?.toString() ?? "",
                  topSpacing: top_spacing,
                  bottomSpacing: bottom_spacing,
                ),
                CommonDivider(),
                labelTextWidget(
                  label: label_apply_accreditation_start_date,
                  topSpacing: top_spacing,
                  bottomSpacing: bottom_spacing,
                  text: details.beginDate ?? "",
                ),
                CommonDivider(),
                labelTextWidget(
                  label: label_apply_accreditation_end_date,
                  topSpacing: top_spacing,
                  bottomSpacing: bottom_spacing,
                  text: details.endDate ?? "",
                ),
                CommonDivider(),
                labelTextWidget(
                  label: label_apply_select_status,
                  topSpacing: text_spacing,
                  bottomSpacing: text_spacing,
                  text: details.stateString ?? "",
                  color: getStateColor(details?.state) ?? UIData.lightGreyColor,
                ),
                CommonDivider(),
                leftTextWidget(
                  text: label_detatils_attachment_photos,
                  topSpacing: top_spacing,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: horizontal_spacing),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: vertical_spacing),
                    child: CommonImageDisplay(
                      photoIdList: details.passPhotos
                              ?.map(
                                  (Attachment attach) => attach?.attachmentUuid)
                              ?.toList() ??
                          null,
//                      callbackWithInfo: _detailsModel.imagesAttachmentCallback,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    //员工列表
    Widget _buildWorkerList() {
      return ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(top: top_spacing),
          itemCount: _detailsModel?.details?.userList?.length ?? 0,
          itemBuilder: (context, index) {
//              WelderInfo welderInfo = _detailsModel.welderList[index];
            return DecorationPassCardWorkerItemPage(
                index, _detailsModel.details, false);
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: vertical_spacing);
          });
    }

    //流程节点
    Widget _buildNode() {
      return Container(
        color: UIData.primaryColor,
        margin: EdgeInsets.only(top: top_spacing),
        child: DecorationPassCardNodeWidget(_detailsModel.details?.nodeList),
      );
    }

    //备注
    Widget _buildRemark() {
      return Visibility(
        visible: _remarkVisiable(_detailsModel.details.state),
        child: Container(
          color: color_layout_bg,
          margin: EdgeInsets.only(top: top_spacing),
          child: FormMultipleTextField(
            label_apply_remark,
            padding: EdgeInsets.only(
                top: top_spacing, left: left_spacing, right: right_spacing),
            controller: _detailsModel.applyRemarkController,
            hintText: hint_text,
          ),
        ),
      );
    }

    Widget _buildBody() {
      return ScopedModelDescendant<DecorationPassCardDetailsModel>(
          builder: (context, child, model) {
        return CommonLoadContainer(
            state: _detailsModel.detailsState,
            content: ListView(
              shrinkWrap: true,
              children: <Widget>[
                _buildContent(),
                _buildWorkerList(),
                _buildNode(),
                _buildRemark()
              ],
            ),
            callback: () {
              _detailsModel.getDetails(widget.id);
            });
//            HotWorkDetail detail = model.detail;
      });
    }

    return ScopedModel<DecorationPassCardDetailsModel>(
        model: _detailsModel,
        child: ScopedModelDescendant<DecorationPassCardDetailsModel>(
            builder: (context, child, model) {
          return CommonScaffold(
            appTitle: "装修工出入证详情",
            bodyData: _buildBody(),
            appBarActions: <Widget>[
              Builder(builder: (context) {
                return Visibility(
                    visible: _detailsModel.details.state == completed,
                    child: FlatButton(
                        onPressed: () {
                          Navigate.toNewPage(
                              DecorationPassCardPage(_detailsModel.details));
                        },
                        child: CommonText.text15("出入证",
                            color: color_text_red,
                            textAlign: TextAlign.center)));
              })
            ],
            bottomNavigationBar:
                ScopedModelDescendant<DecorationPassCardDetailsModel>(
                    builder: (context, child, model) {
              DecorationPassCardDetails details = model.details;
              return Visibility(
                  visible: _bottomVisiable(details.state),
                  child: StadiumSolidWithTowButton(
                    cancelText: _getCancelButtonText(details.state),
                    onCancel: () {
                      model.cancelOnDetailsTap();
                    },
                    conFirmText: _getConfirmButtonText(details.state),
                    onConFirm: () {
                      model.confirmOnDetailsTap();
                    },
                  ));
            }),
          );
        }));
  }

//按钮是否显示
  _bottomVisiable(String state) {
    if (widget.customerType == 0) {
      return state == auditLandlordWaiting;
    } else {
      return state == auditLandlordWaiting ||
          state == auditLandlordFailed ||
          state == auditPropertyWaiting ||
          state == auditPropertyFailed ||
          state == payWaiting;
    }
  }

//确认按钮文字
  _getConfirmButtonText(String state) {
    if (widget.customerType == 0) {
      if (state == auditLandlordWaiting) {
        return "同意";
      }
    } else {
      if (state == auditLandlordWaiting ||
          state == auditLandlordFailed ||
          (state == auditPropertyWaiting && _detailsModel.details.type == 1 ) ||  //业主申请的可以修改申请
          state == auditPropertyFailed) {
        return "修改申请";
      }
    }
    return null;
  }

//取消按钮文字
  _getCancelButtonText(String state) {
    if (widget.customerType == 0) {
      if (state == auditLandlordWaiting) {
        return "不同意";
      }
    } else {
      if (state == auditLandlordWaiting ||
          state == auditLandlordFailed ||
          state == auditPropertyWaiting ||
          state == auditPropertyFailed ||
          state == payWaiting) {
        return "撤单";
      }
    }
    return null;
  }

//审核备注是否显示
  _remarkVisiable(String state) {
    return widget.customerType == 0 && state == auditLandlordWaiting;
  }
}
