import 'package:cmp_customer/models/process_node.dart';
import 'package:cmp_customer/models/response/entrance_card_details_response.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/scoped_models/entrance_model/entrance_details_state_model.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_dialog.dart';
import 'package:cmp_customer/ui/common/common_expansion_tile.dart';
import 'package:cmp_customer/ui/common/common_image_display.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_node.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_state.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_ui.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:cmp_customer/ui/parking/parking_card_ui.dart';
import 'package:scoped_model/scoped_model.dart';

//门禁卡详情
class EntranceCardDetailsPage extends StatelessWidget {
  EntranceDetailsStateModel _stateModel;
  int accessCardId;
  EntranceCardDetailsPage(this.accessCardId);

  Widget _buildBody() {
    return ScopedModelDescendant<EntranceDetailsStateModel>(
        builder: (context, child, model) {
      return CommonLoadContainer(
        state: _stateModel.mineState,
        callback: () {
          _stateModel.getDetails(accessCardId);
        },
        content: _buildContent(),
      );
    });
  }

  Widget _buildContent() {
    return ScopedModelDescendant<EntranceDetailsStateModel>(
        builder: (context, child, model) {
      EntranceCardDetailsInfo info = model.detailsInfo;
      bool existHeadList=info.attHeadList!=null&&info.attHeadList.isNotEmpty;
      bool existSfzList=info.attSfzList!=null&&info.attSfzList.isNotEmpty;
      bool existMjkfjList=info.attMjkfjList!=null&&info.attMjkfjList.isNotEmpty;
      return SingleChildScrollView(
        child: Column(children: <Widget>[
          Container(
              color: color_layout_bg,
              padding: EdgeInsets.only(bottom: bottom_spacing),
              child: Column(children: <Widget>[
                labelTextWidget(
                  label: label_business_id,
                  text: info.businessNo ?? "",
                  topSpacing: top_spacing,
                ),
                labelTextWidget(
                  label: label_apply_time,
                  text: info.createTime ?? "",
                  topSpacing: top_spacing,
                ),
                labelTextWidget(
                  label: label_apply_deal_progress,
                  text: info.statusDesc??"",
                  topSpacing: top_spacing,
                ),
                labelTextWidget(
                  label: label_contact_phone,
                  text: info.customerPhone ?? "",
                  topSpacing: top_spacing,
                ),
                labelTextWidget(
                  label: label_apply_card_count,
                  text: StringsHelper.getStringValue(info.applyCount) + " 张",
                  topSpacing: top_spacing,
                ),
                labelTextWidget(
                  label: label_apply_reason,
                  text: info?.reason ?? "",
                  topSpacing: top_spacing,
                ),
                Visibility(
                  visible: info.status == payWaiting,
                  child: labelTextWidget(
                    label: label_pay_waiting,
                    text: StringsHelper.getStringValue(info.payFees) + " 元",
                    topSpacing: top_spacing,
                  ),
                ),
                Visibility(
                  visible: info.status == payWaiting,
                  child: labelTextWidget(
                    label: label_pay_method,
                    text: tip_pay_method,
                    topSpacing: top_spacing,
                    color: color_text_orange,
                  ),
                )
              ])),
              Visibility(
                visible: existHeadList||existSfzList||existSfzList,
                child: Container(
                    color: color_layout_bg,
                    margin: EdgeInsets.only(top: top_spacing),
                    child:Column(
                      children: <Widget>[
                        Visibility(
                          visible: existHeadList,
                          child: Column(
                            children: <Widget>[
                              leftTextWidget(text: label_photo_head,topSpacing: top_spacing,),
                              Container(
                                margin: EdgeInsets.all(left_spacing),
                                child:CommonImageDisplay(photoIdList:info.attHeadList),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: existSfzList,
                          child: Column(
                            children: <Widget>[
                              horizontalLineWidget(spacing:horizontal_spacing),
                              leftTextWidget(text: label_photo_identity,topSpacing: top_spacing),
                              Container(
                                margin: EdgeInsets.all(left_spacing),
                                child:CommonImageDisplay(photoIdList: info.attSfzList,),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: existMjkfjList,
                          child: Column(
                            children: <Widget>[
                              horizontalLineWidget(spacing:horizontal_spacing),
                              leftTextWidget(text: label_photo_attachment,topSpacing: top_spacing),
                              Container(
                                margin: EdgeInsets.all(left_spacing),
                                child:CommonImageDisplay(photoIdList: info.attMjkfjList
                                    ?.map(
                                        (Attachment attach) => attach?.attachmentUuid)
                                    ?.toList() ??
                                    null,),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                ),
              ),

          Container(
            color: color_layout_bg,
            margin: EdgeInsets.only(top: top_spacing),
            child: EntranceCardNodeWidget(info.recordList,customerType:info.customerType),
          ),
          leftTextWidget(
            text: label_tip_entrance_card,
            color: color_text_gray,
            fontSize: UIData.fontSize12,
            bottomSpacing: bottom_spacing,
            topSpacing: top_spacing,
          ),
        ]),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (_stateModel == null) {
      _stateModel = new EntranceDetailsStateModel();
      _stateModel.getDetails(accessCardId);
    }
    return ScopedModel<EntranceDetailsStateModel>(
        model: _stateModel,
        child: CommonScaffold(
            appTitle: "门禁卡详情",
            bodyData: _buildBody(),
            bottomNavigationBar:
                ScopedModelDescendant<EntranceDetailsStateModel>(
                    builder: (context, child, model) {
              EntranceCardDetailsInfo info = model.detailsInfo;
              return Visibility(
                  visible: _confirmBottomVisiable(info.status) ||
                      _cancelBottomVisiable(info.status),
                  child: StadiumSolidWithTowButton(
                    cancelText: _getCancelText(info.status),
                    onCancel: () {
                      CommonDialog.showAlertDialog(context,
                          content: '撤销该门禁卡办理申请', onConfirm: () {
                        model.cancelOnDetailsTap();
                      });
                    },
                    conFirmText: _getConfirmText(info.status),
                    onConFirm: () {
                      model.confirmOnDetailsTap();
                    },
                  )
//                  Row(
//                    children: <Widget>[
//                      Visibility(
//                        visible: _cancelBottomVisiable(info.status),
//                        child: Expanded(
//                          child: StadiumSolidButton(
//                            _getCancelText(info.status),
//                            btnType: ButtonType.CANCEL,
//                            onTap: () {
//                              CommonDialog.showAlertDialog(context,
//                                  content: '撤销该门禁卡办理申请',
//                                  onConfirm: () {
//                                    model.cancelOnDetailsTap();
//                                  });
//
//                            },
//                          ),
//                        ),
//                      ),
//                      Visibility(
//                        visible: _confirmBottomVisiable(info.status),
//                        child: Expanded(
//                          child: StadiumSolidButton(
//                            _getConfirmText(info.status),
//                            btnType: ButtonType.CONFIRM,
//                            onTap: () {
//                              model.confirmOnDetailsTap();
//                            },
//                          ),
//                        ),
//                      ),
//                    ],
//                  )
                  );
            })));
  }
}

//确定按钮是否显示
_confirmBottomVisiable(String state) {
  return state == auditLandlordFailed || state == auditPropertyFailed;
}

//取消是否显示
_cancelBottomVisiable(String state) {
  return state == auditLandlordWaiting ||
      state == auditLandlordFailed ||
      state == auditPropertyWaiting ||
      state == auditPropertyFailed;
}

_getCancelText(String state) {
  var cancelText;
  switch (state) {
    case auditLandlordWaiting:
    case auditPropertyWaiting:
    case auditLandlordFailed:
    case auditPropertyFailed:
      cancelText = "撤销申请";
      break;
  }
  return cancelText;
}

_getConfirmText(String state) {
  var confirmText;
  switch (state) {
//    case auditLandlordWaiting:
//    case auditPropertyWaiting:
    case auditLandlordFailed:
    case auditPropertyFailed:
      confirmText = "重新申请";
      break;
  }
  return confirmText;
}
