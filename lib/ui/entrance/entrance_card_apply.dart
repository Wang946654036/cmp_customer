import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/request/entrance_card_apply_request.dart';
import 'package:cmp_customer/models/request/parking_card_apply_request.dart';
import 'package:cmp_customer/models/response/entrance_card_details_response.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/scoped_models/entrance_model/entrance_apply_state_model.dart';
import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/strings/strings_common.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_dialog.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_image_picker.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_text_field.dart';
import 'package:cmp_customer/ui/common/copy_writing_page.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_history.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_list_landlord.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_list_tenant.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_state.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_ui.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:cmp_customer/ui/parking/parking_card_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scoped_model/scoped_model.dart';

enum EntranceApplyType {
  tenant, //租户申请
  landlord, //业主申请
}

//门禁卡申请
class EntranceCardApplyPage extends StatelessWidget {
  EntranceCardDetailsInfo detailsInfo;
  EntranceCardApplyPage({this.detailsInfo});
  EntranceApplyStateModel _stateModel;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (_stateModel == null) {
      _stateModel = new EntranceApplyStateModel();
      _stateModel.getEntranceSetting();
      _stateModel.setDefaultCustomerType();
    }
    if (detailsInfo != null) {//修改申请，不需要获取房屋列表，因为不能修改房屋
      _stateModel.setDetailsInfo(detailsInfo);
    }else{
      _stateModel.getHouseList();
    }
    bool isAuditPropertyFailed=detailsInfo != null && detailsInfo.status == auditPropertyFailed;
//    if(!detailsInfo != null){//非业主不通过，需要获取房屋列表
//      _stateModel.getHouseList();
//    }
    return ScopedModel<EntranceApplyStateModel>(
        model: _stateModel,
        child: ScopedModelDescendant<EntranceApplyStateModel>(
            builder: (context, child, model)
    {
      EntranceCardApplyRequest applyInfo = model.applyInfo;
      HouseInfo houseInfo;
      if (detailsInfo!=null) {//修改申请
        houseInfo = new HouseInfo(buildName: detailsInfo.buildName,
            unitName: detailsInfo.unitName,
            houseNo: detailsInfo.houseNo);
      } else {
        houseInfo = model.selectedIndex >= 0
          ? model.houseList[model.selectedIndex]
          : null;
      }
          return CommonScaffold(
            appTitle: "门禁卡申请",
            bodyData: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      if(detailsInfo==null||detailsInfo.status!=auditPropertyFailed){
                        //物业不通过不能更改房屋信息
                        model.chooseHouse();
                      }
                    },
                    child: Container(
                      color: color_layout_bg,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
//                            child: GestureDetector(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(
                                  left: left_spacing,
                                  top: top_spacing,
                                  bottom: bottom_spacing),
                              child: Text(
                                houseInfo == null
                                    ? "请选择房屋"
                                    : StringsHelper.getStringValue(
                                    houseInfo.buildName) +
                                        " - " +
                                        StringsHelper.getStringValue(
                                            houseInfo.unitName) +
                                        " - " +
//                                        StringsHelper.getStringValue(
//                                            detailsInfo.floorName) +
                                        StringsHelper.getStringValue(
                                            houseInfo.houseNo),
                                style: TextStyle(fontSize: normal_text_size,color: detailsInfo != null?color_text_hint:color_text),
                              ),
                            ),
//                              onTap: () {
////                          print("房屋选择");
//                                model.chooseHouse();
//                              },
//                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_right,
                            size: normal_right_icon_size,
                            color: color_icon_right,
                          ),
                          GestureDetector(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(right: right_spacing),
                              child: Text(
                                label_apply_charge_standard,
                                style: TextStyle(
                                    color: color_text_red,
                                    fontSize: normal_text_size),
                              ),
                            ),
                            onTap: () {
                              CommonDialog.showAlertDialog(context,
                                  content: model.chargeDesc ?? "",
                                  showNegativeBtn: false);
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                      color: color_layout_bg,
                      margin: EdgeInsets.only(top: top_spacing),
                      child: Column(
                        children: <Widget>[
                          labelInputWidget(model.applyPhoneController,
                              label: label_apply_phone,
                              isRequired: true,
                              topSpacing: top_spacing,
                              limitLength: 11,
                              bottomSpacing: bottom_spacing,
                              keyboardType: TextInputType.phone),
                          horizontalLineWidget(spacing: horizontal_spacing),
                          labelInputWidget(
                            model.applyCountController,
                            label: label_apply_card_count,
                            isRequired: true,
                            topSpacing: top_spacing,
                            bottomSpacing: bottom_spacing,
                            unit: label_unit_card,
                            keyboardType: TextInputType.number,
                            //除租户申请物业不通过外，其他都可以修改，钱钱改
                            enable: !(isAuditPropertyFailed && model.applyType == EntranceApplyType.tenant),
                            //租户申请物业不通过不能改显示灰色，钱钱改
                            color: (isAuditPropertyFailed && model.applyType == EntranceApplyType.tenant)?color_text_hint:null,
                            limitLength: 4,
                          ),
                          horizontalLineWidget(
                            spacing: horizontal_spacing),
                          FormMultipleTextField(
                            label_apply_reason,
                            padding: EdgeInsets.only(top: top_spacing,left: left_spacing,right: right_spacing),
                            controller: model.applyReasonController,
                            hintText: hint_text,
                          ),
//                          Visibility(
//                            visible:
//                                model.applyType == EntranceApplyType.tenant,
//                            child: leftTextWidget(
//                              text: label_apply_reason,
//                              topSpacing: top_spacing,
//                            ),
//                          ),
//                          Visibility(
//                              visible:
//                                  model.applyType == EntranceApplyType.tenant,
//                              child: inputWidget(
//                                controller: model.applyReasonController,
//                                hint_text: hint_text,
//                              ))
                        ],
                      )),
                  Container(
                    color: color_layout_bg,
                    margin: EdgeInsets.only(top: top_spacing),
                    child: Column(children: <Widget>[
                      leftTextWidget(
                        text: label_photo_head,
                        topSpacing: top_spacing,
                      ),
                      Container(
                        margin: EdgeInsets.all(horizontal_spacing),
                        child: CommonImagePicker(
                          photoIdList: applyInfo.attHeadList,
                          callback: model.imagesHeadCallback,
                        ),
                      ),

                      leftTextWidget(
                        text: label_photo_tips,
                        color: color_text_gray,
                        fontSize: UIData.fontSize12,
                        bottomSpacing: bottom_spacing,
                      ),
                      Visibility(
                        visible: model.applyType == EntranceApplyType.tenant,
//                          visible:true,
                        child: Container(
                            color: color_layout_bg,
                            child: Column(
                              children: <Widget>[
                                Visibility(
                                  visible: model.needHeadInfo,
                                  child: horizontalLineWidget(
                                      spacing: horizontal_spacing),
                                ),
                                leftTextWidget(
                                  text: label_photo_identity,
                                  topSpacing: top_spacing,
                                ),
                                leftTextWidget(
                                  text: label_tip_entrance_card,
                                  color: color_text_gray,
                                  fontSize: UIData.fontSize12,
                                  bottomSpacing: bottom_spacing,
                                ),
                                Container(
                                  margin: EdgeInsets.all(horizontal_spacing),
                                  child: CommonImagePicker(
                                    photoIdList: applyInfo.attSfzList,
                                    callback: model.imagesSfzCallback,
                                  ),
                                ),
                              ],
                            )),
                      ),
                      leftTextWidget(
                        text: label_photo_attachment,
                        topSpacing: top_spacing,
                      ),
                      Container(
                        margin: EdgeInsets.all(horizontal_spacing),
                        child: CommonImagePicker(
                          attachmentList: applyInfo.attMjkfjList,
                          callbackWithInfo: model.imagesMjkfjCallback,
                        ),
                      ),
                      leftTextWidget(
                        text: label_tip_attachment,
                        color: color_text_gray,
                        fontSize: UIData.fontSize12,
                        bottomSpacing: bottom_spacing,
                      ),



                    ]),
                  ),
//            Visibility(
//              visible: operationType==0,
//              child: leftTextWidget(text: label_tip,topSpacing: top_spacing,),
//            ),

                  leftTextWidget(
                    text: label_tip_entrance_card,
                    color: color_text_gray,
                    fontSize: UIData.fontSize12,
                    topSpacing: top_spacing,
                  ),
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
                            Navigate.toNewPage(CopyWritingPage(label_apply_agreement, CopyWritingType.EntranceCardAgreement));
                          },
                          child: Text(
                            label_apply_agreement,
                            style: TextStyle(
                                fontSize: UIData.fontSize11, color: color_text_red),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: StadiumSolidButton(
              label_submit,
              enable: _stateModel.agree,
              btnType: ButtonType.CONFIRM,
              onTap: () {
                if (_stateModel.checkUploadData()) {
                  CommonDialog.showAlertDialog(context,
                      content: _stateModel.applyType == EntranceApplyType.tenant && !isAuditPropertyFailed
                          ? label_tip_apply_tenant
                          : label_tip_apply_landlord, onConfirm: () {
                    _stateModel.uploadApplyData();
                  });
                }
              },
            ),
            appBarActions: detailsInfo==null?<Widget>[
              Builder(builder: (context) {
                return FlatButton(
                    onPressed: () {
                      if (_stateModel.existingOwner) {
                        Navigate.toNewPage(EntranceCardListLandlordPage());
                      } else {
                        Navigate.toNewPage(EntranceCardListTenantPage());
                      }
                    },
//                    child: Container(
//                        alignment: Alignment.centerRight,
//                        padding: EdgeInsets.only(right: right_spacing),
                        child: CommonText.text15("申请列表",
                            color: color_text_red,
                            textAlign: TextAlign.center)
//                )
                );
              })
            ]:null,
          );
        }));
  }
}
