import 'package:cmp_customer/models/response/decoration_pass_card_details_response.dart';
import 'package:cmp_customer/scoped_models/decoration/decoration_pass_card_apply_state_model.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_image_picker.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_text_field.dart';
import 'package:cmp_customer/ui/parking/parking_card_ui.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'decoration_pass_card_label.dart';
import 'decoration_pass_card_worker_item.dart';

//装修工出入证申请
class DecorationPassCardApplyPage extends StatefulWidget {
  DecorationPassCardDetails details;
  DecorationPassCardApplyPage([this.details]);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DecorationPassCardApply();
  }
}

class _DecorationPassCardApply extends State<DecorationPassCardApplyPage> {
  DecorationPassCardApplyStateModel _applyModel;
  List<Widget> _userWidgetList; //装修工控件列表
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (_applyModel == null)
      _applyModel = new DecorationPassCardApplyStateModel();
    if (widget.details != null) {
      //初始化数据，修改申请把加入详情数据，新建申请则初始化对象
      _applyModel.setDetailsInfo(widget.details);
      _applyModel.getEffectDate();
        widget.details?.userList?.forEach((UserList user){
          _userWidgetAdd();
        });
    }
  }

  void _userWidgetAdd() {
    if(_userWidgetList == null) _userWidgetList = List();
    int index = _userWidgetList.length;
    _userWidgetList.add(DecorationPassCardWorkerItemPage(
        index, _applyModel.applyRequest, true, callback: (int index) {
      setState(() {
        _applyModel.applyRequest.userList.removeAt(index);
        _userWidgetList.removeAt(index);
      });
    }, key: GlobalKey()));
  }

  void _userAdd(){
    if (_applyModel.applyRequest?.userList == null)
      _applyModel.applyRequest?.userList = List();
    _applyModel.applyRequest.userList.add(UserList());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    Widget _buildContent() {
      DecorationPassCardDetails applyRequest = _applyModel.applyRequest;
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
                  text: applyRequest.houseName ?? "",
                  topSpacing: top_spacing,
                  bottomSpacing: bottom_spacing,
                ),
                CommonDivider(),
                labelInputWidget(
                  _applyModel.applyCompanyController,
                  label: label_apply_construction,
                  topSpacing: top_spacing,
                  bottomSpacing: bottom_spacing,
                ),
                CommonDivider(),
                labelTextWidget(
                    label: label_apply_document_count,
                    topSpacing: top_spacing,
                    bottomSpacing: bottom_spacing,
                    text: applyRequest.userList?.length?.toString()??""),
                CommonDivider(),
                labelTextWidget(
                  label: label_apply_accreditation_start_date,
                  labelColor: color_text,
                  topSpacing: top_spacing,
                  bottomSpacing: bottom_spacing,
                  text: applyRequest.beginDate ?? "加载中",
                ),
                CommonDivider(),
                labelTextWidget(
                  label: label_apply_accreditation_end_date,
                  labelColor: color_text,
                  topSpacing: top_spacing,
                  bottomSpacing: bottom_spacing,
                  text: applyRequest.endDate ?? "加载中",
                ),
//                GestureDetector(
//                  child: labelTextWidget(
//                    label: label_apply_accreditation_start_date,
//                    labelColor: color_text,
//                    topSpacing: top_spacing,
//                    bottomSpacing: bottom_spacing,
//                    needArrow: true,
//                    text: applyRequest.beginDate ??
//                        label_please_select_time,
//                  ),
//                  onTap: () {
//                    CommonPicker.datePickerModal(context,
//                        onConfirm: (String date) {
//                      _applyModel.setStartDate(date);
//                    });
//                  },
//                ),
//                CommonDivider(),
//                GestureDetector(
//                  child: labelTextWidget(
//                    label: label_apply_accreditation_end_date,
//                    labelColor: color_text,
//                    topSpacing: top_spacing,
//                    bottomSpacing: bottom_spacing,
//                    needArrow: true,
//                    text:
//                        applyRequest.endDate ?? label_please_select_time,
//                  ),
//                  onTap: () {
//                    CommonPicker.datePickerModal(context,
//                        onConfirm: (String date) {
//                      _applyModel.setEndDate(date);
//                    });
//                  },
//                ),
                CommonDivider(),
                FormMultipleTextField(
                  label_apply_remark,
                  padding: EdgeInsets.only(
                      top: top_spacing,
                      left: left_spacing,
                      right: right_spacing),
                  controller: _applyModel.applyRemarkController,
                  hintText: hint_text,
                ),
                CommonDivider(),
                leftTextWidget(
                  text: label_apply_attachment_photos,
                  topSpacing: top_spacing,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: horizontal_spacing),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: vertical_spacing),
                    child: CommonImagePicker(
                      attachmentList: applyRequest.passPhotos??null,
                      callbackWithInfo: _applyModel.imagesAttachmentCallback,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }


    //添加员工按钮
    Widget _buildAddWorkerButton() {
      return Container(
        color: UIData.primaryColor,
        margin: EdgeInsets.symmetric(vertical: vertical_spacing),
        child: FlatButton(
            onPressed: () {
              setState(() {
                _userAdd();
                _userWidgetAdd();
              });
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.add_circle, color: UIData.themeBgColor),
                SizedBox(width: UIData.spaceSize4),
                CommonText.red15Text('添加装修人员'),
              ],
            )),
      );
    }

    //员工列表
    Widget _buildWorkerList() {
      return Visibility(
          visible: _applyModel?.applyRequest?.userList != null &&
              _applyModel.applyRequest.userList.length > 0,
          child: ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(top: top_spacing),
              itemCount: _applyModel?.applyRequest?.userList?.length ?? 0,
              itemBuilder: (context, index) {
//              WelderInfo welderInfo = _applyModel.welderList[index];
                return _userWidgetList[index];
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: vertical_spacing);
              }));
    }

    Widget _buildBody() {
      return ScopedModelDescendant<DecorationPassCardApplyStateModel>(
          builder: (context, child, model) {
//            HotWorkDetail applyRequest = model.applyRequest;
        return ListView(
          shrinkWrap: true,
          children: <Widget>[
            _buildContent(),
            _buildWorkerList(),
            _buildAddWorkerButton(),
          ],
        );
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
    return ScopedModel<DecorationPassCardApplyStateModel>(
        model: _applyModel,
        child: CommonScaffold(
          appTitle: label_apply_pass_card_apply,
          bodyData: _buildBody(),
          bottomNavigationBar: StadiumSolidButton(
            label_submit,
            btnType: ButtonType.CONFIRM,
            onTap: () {
              _applyModel.checkUploadData();
            },
          ),
        ));
  }
}
