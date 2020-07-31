import 'dart:io';

import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/response/entrance_card_details_response.dart';
import 'package:cmp_customer/scoped_models/entrance_model/entrance_audit_state_model.dart';
import 'package:cmp_customer/scoped_models/entrance_model/entrance_details_state_model.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_dialog.dart';
import 'package:cmp_customer/ui/common/common_image_picker.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_text_field.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_state.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_ui.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:cmp_customer/ui/parking/parking_card_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scoped_model/scoped_model.dart';

//门禁卡审核（业主）
///[accessCardId]//门禁卡id
///[detailsInfo]//门禁卡详情
//
class EntranceCardApplyAuditPage extends StatefulWidget {
  int accessCardId;
  EntranceCardDetailsInfo detailsInfo;

  EntranceCardApplyAuditPage(this.detailsInfo, this.accessCardId)
      : assert(detailsInfo == null || accessCardId == null);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _EntranceCardApplyAuditState();
  }
}

class _EntranceCardApplyAuditState extends State<EntranceCardApplyAuditPage> {
  EntranceAuditStateModel _auditModel = new EntranceAuditStateModel();
  EntranceDetailsStateModel _detailsModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (_detailsModel == null) {
      _detailsModel = new EntranceDetailsStateModel();
    }
    if (widget.detailsInfo == null) {
      _detailsModel.getDetails(widget.accessCardId);
    } else {
      _detailsModel.setDetailsInfo(widget.detailsInfo);
    }
  }

  Widget _buildBody() {
    return ScopedModelDescendant<EntranceDetailsStateModel>(
        builder: (context, child, model) {
      return CommonLoadContainer(
        state: _detailsModel.mineState,
        callback: () {
          _detailsModel.getDetails(widget.accessCardId);
        },
        content: _buildContent(),
      );
    });
  }

  Widget _buildContent() {
    return ScopedModelDescendant<EntranceDetailsStateModel>(
        builder: (context, child, model) {
      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: color_layout_bg,
              padding: EdgeInsets.symmetric(
                  horizontal: horizontal_spacing, vertical: vertical_spacing),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      width: ScreenUtil.getInstance().setWidth(35),
                      height: ScreenUtil.getInstance().setWidth(35),
                      margin: EdgeInsets.only(right: right_spacing),
                      child: ClipOval(
                        child: Image.asset(UIData.imagePortrait),
                      )),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CommonText.black16Text(StringsHelper.getStringValue(
                            model.detailsInfo?.customerName)),
                        CommonText.grey12Text(StringsHelper.getStringValue(
                                model.detailsInfo?.formerName) +
                            " " +
                            StringsHelper.getStringValue(
                                model.detailsInfo?.buildName) +
                            "-" +
                            StringsHelper.getStringValue(
                                model.detailsInfo?.unitName) +
                            "-" +
                            StringsHelper.getStringValue(
                                model.detailsInfo?.houseNo)),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Image.asset(UIData.imagePhone),
                    onPressed: () {
                      if (StringsHelper.isNotEmpty(
                          model.detailsInfo?.customerPhone)) {
                        stateModel.callPhone(model.detailsInfo?.customerPhone);
                      }
                    },
                  ),
                ],
              ),
            ),
            Visibility(
              visible: model.detailsInfo?.status != auditLandlordWaiting,
              child: Container(
                  color: color_layout_bg,
                  margin: EdgeInsets.only(top: top_spacing),
                  padding: EdgeInsets.only(right: right_spacing),
                  child: Column(
                    children: <Widget>[
                      labelTextWidget(
                        label: label_apply_time,
                        text: model.detailsInfo?.createTime ?? "",
                        topSpacing: top_spacing,
                      ),
                      labelTextWidget(
                        label: label_apply_card_count,
                        text: StringsHelper.getStringValue(
                                model.detailsInfo?.applyCount) +
                            "张",
                        topSpacing: top_spacing,
                      ),
                      labelTextWidget(
                        label: label_apply_reason,
                        text: model.detailsInfo?.reason ?? "",
                        topSpacing: top_spacing,
                      ),
                      labelTextWidget(
                        label: label_contact_phone,
                        text: model.detailsInfo?.customerPhone ?? "",
                        topSpacing: top_spacing,
                      ),
                      labelTextWidget(
                        label: label_apply_deal_progress,
                        text: model.detailsInfo?.statusDesc ?? "",
                        topSpacing: top_spacing,
                        bottomSpacing: bottom_spacing,
                      ),
                    ],
                  )),
            ),
            Visibility(
              visible: model.detailsInfo?.status == auditLandlordWaiting,
              child: Container(
                  color: color_layout_bg,
                  margin: EdgeInsets.only(top: top_spacing),
                  padding: EdgeInsets.only(right: right_spacing),
                  child: Column(
                    children: <Widget>[
                      labelTextWidget(
                          label: label_apply_card_count,
                          text: StringsHelper.getStringValue(
                                  model.detailsInfo?.applyCount) +
                              "张",
                          topSpacing: top_spacing,
                          bottomSpacing: bottom_spacing),
                      horizontalLineWidget(
                        spacing: horizontal_spacing,
                      ),
                      leftTextWidget(
                        text: label_apply_reason,
                        color: color_text_gray,
                        topSpacing: top_spacing,
                      ),
                      leftTextWidget(
                          text: model.detailsInfo?.reason ?? "",
                          bottomSpacing: bottom_spacing,
                          topSpacing: top_spacing)
                    ],
                  )),
            ),
            Visibility(
              visible: model.detailsInfo?.status == auditLandlordWaiting,
              child: Container(
                color: color_layout_bg,
                margin: EdgeInsets.only(top: top_spacing),
                padding: EdgeInsets.only(right: right_spacing),
                child: FormMultipleTextField(
                  label_mine_opinion,
                  controller: _auditModel.remarkController,
                  hintText: hint_text,
                  padding: EdgeInsets.only(
                      top: top_spacing,
                      left: left_spacing,
                      right: right_spacing),
//                      padding: EdgeInsets.only(top: top_spacing),
                ),
//                    Column(
//                      children: <Widget>[
//                        leftTextWidget(
//                          text: label_mine_opinion,
//                          topSpacing: top_spacing,
//                        ),
//                        inputWidget(
//                          hint_text: hint_text,
//                          controller: model.remarkController,
//                        )
//                      ],
//                    )
              ),
//            Visibility(
//              visible: operationType==0,
//              child: leftTextWidget(text: label_tip,topSpacing: top_spacing,),
//            ),
            ),
            Visibility(
              visible: model.detailsInfo?.status == auditLandlordWaiting,
              child: leftTextWidget(
                text: label_tip_audit_card1,
                color: color_text_gray,
                fontSize: UIData.fontSize12,
                topSpacing: top_spacing,
              ),
            ),
            Visibility(
              visible: model.detailsInfo?.status == auditLandlordWaiting,
              child: leftTextWidget(
                text: label_tip_audit_card2,
                color: color_text_gray,
                fontSize: UIData.fontSize12,
                bottomSpacing: bottom_spacing,
              ),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModel<EntranceDetailsStateModel>(
        model: _detailsModel,
        child: ScopedModelDescendant<EntranceDetailsStateModel>(
            builder: (context, child, model) {
          return CommonScaffold(
              appTitle: "门禁卡详情",
              bodyData: _buildBody(),
              bottomNavigationBar: Visibility(
                  visible:
                      _detailsModel.detailsInfo?.status == auditLandlordWaiting,
                  child: StadiumSolidWithTowButton(
                    cancelText: "不同意",
                    onCancel: () {
                      CommonDialog.showAlertDialog(context,
                          title: '拒绝该租户的门禁办理申请', onConfirm: () {
                        _auditModel
                            .cancelTap(_detailsModel.detailsInfo.accessCardId);
                      });
                    },
                    conFirmText: "同意",
                    onConFirm: () {
                      CommonDialog.showAlertDialog(context,
                          title: '同意该租户的门禁办理申请', onConfirm: () {
                        _auditModel
                            .confirmTap(_detailsModel.detailsInfo.accessCardId);
                      });
                    },
                  ))
//      Row(
//        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//        children: <Widget>[
//          Expanded(
//              child: StadiumSolidButton(
//            "不同意",
//            btnType: ButtonType.CANCEL,
//            onTap: () {
//              CommonDialog.showAlertDialog(context, title: '拒绝该租户的门禁办理申请',
//                  onConfirm: () {
//                model.cancelTap(detailsInfo.accessCardId);
//              });
//            },
//          )),
//          Expanded(
//              child: StadiumSolidButton(
//            "同意",
//            btnType: ButtonType.CONFIRM,
//            onTap: () {
//              CommonDialog.showAlertDialog(context, title: '同意该租户的门禁办理申请',
//                  onConfirm: () {
//                model.confirmTap(detailsInfo.accessCardId);
//              });
//            },
//          )),
//        ],
//      ),
              );
        }));
  }
}
