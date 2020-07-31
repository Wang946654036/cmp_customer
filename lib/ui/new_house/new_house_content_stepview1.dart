import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/new_house_model.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/strings/strings_house_auth.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_image_display.dart';
import 'package:cmp_customer/ui/common/common_image_picker.dart';
import 'package:cmp_customer/ui/common/common_picker.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_text_field.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/house_authentication/select_house_page.dart';
import 'package:cmp_customer/ui/me/community_search_page.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/date_util.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'new_house_common_ui.dart';

///
/// Created by yangyangyang on 2020/3/25 3:30 PM.
/// 新房入伙基本信息
/// [editable] 是否可编辑，0-全部可编辑，1-选填可编辑，2-不可编辑
///
class NewHouseContentStepview1 extends StatefulWidget {
  final int editable;
  NewHouseDetail newHouseDetail;

  NewHouseContentStepview1(this.editable, this.newHouseDetail);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NewHouseContentStepview1();
  }
}

class _NewHouseContentStepview1 extends State<NewHouseContentStepview1> {
  NewHouseDetail _newHouseDetail;
  TextEditingController _custNameController = TextEditingController(); //name
  TextEditingController _custMobilController = TextEditingController(); //电话
  TextEditingController _custIdNumController = TextEditingController(); //证件号码
  bool canEditProject = true;

  @override
  void initState() {
    super.initState();

    _initData();
    _setListener();
  }

  void _initData() {
    _newHouseDetail = widget.newHouseDetail;
    if (_newHouseDetail?.houseJoinId != null) canEditProject = false; //已提交后的社区不能编辑
    _custNameController.text = _newHouseDetail?.custName;
    _custMobilController.text = _newHouseDetail?.custPhone;
    _custIdNumController.text = _newHouseDetail?.custIdNum;

    if (_newHouseDetail?.custType == null) {
      _newHouseDetail?.custType = 'G';
    }
    if (widget.editable == 0 && _newHouseDetail?.projectId == null) {
      _newHouseDetail?.projectId = stateModel.defaultProjectId;
      _newHouseDetail?.projectFormerName = stateModel.defaultProjectName;
    }
  }

  void _setListener() {
    _custNameController.addListener(() {
      _newHouseDetail?.custName = _custNameController.text;
    });
    _custMobilController.addListener(() {
      _newHouseDetail?.custPhone = _custMobilController.text;
    });
    _custIdNumController.addListener(() {
      _newHouseDetail?.custIdNum = _custIdNumController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: UIData.spaceSize16),
      color: UIData.primaryColor,
      child: Column(
        children: <Widget>[
          TextWithLeftBorder('基本信息'),
//          leftTextWidget(
//            text: '基本信息',
//            color: UIData.darkGreyColor,
//            fontSize: UIData.fontSize17,
//          ),
          Visibility(
            visible: widget.editable == 2,
            child: CommonSelectSingleRow(
              '客户类型',
              contentColor: widget.editable == 1 ? UIData.lightGreyColor : UIData.darkGreyColor,
              content: _newHouseDetail?.custType == 'G' ? '个人' : "企业",
              arrowVisible: false,
            ),
          ),
          Visibility(visible: widget.editable == 2, child: CommonDivider()),
          CommonSelectSingleRow(
            '客户姓名',
            content: CommonTextField(
                hintText: "请输入（必填）",
                limitLength: 32,
                controller: _custNameController,
                enabled: widget.editable == 0,
                textColor: widget.editable == 1 ? UIData.lightGreyColor : UIData.darkGreyColor),
            arrowVisible: false,
          ),
          CommonDivider(),
          CommonSelectSingleRow(
            '联系电话',
            content: CommonTextField(
                hintText: "请输入（必填）",
                limitLength: 11,
                controller: _custMobilController,
                inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter(RegExp("[0-9]"))],
                keyboardType: TextInputType.number,
                textColor: widget.editable == 1 ? UIData.lightGreyColor : UIData.darkGreyColor,
                enabled: widget.editable == 0),
            arrowVisible: false,
          ),
          CommonDivider(),
          CommonSingleInputRow('证件类型',
              content: _newHouseDetail?.idTypeId != null
                  ? CommonText.text15(documentGRMap[_newHouseDetail?.idTypeId],
                      color: widget.editable == 1 ? UIData.lightGreyColor : UIData.darkGreyColor)
                  : CommonText.lightGrey15Text('请选择（必填）'), onTap: () {
            if (widget.editable == 0)
              CommonPicker.singlePickerModal(context, documentGRMap.values.toList(),
                  onConfirm: (int index, String data) {
                setState(() {
                  _newHouseDetail?.idTypeId = documentGRMap.keys.toList()[index];
                });
              });
          }, arrowVisible: widget.editable == 0),
          CommonDivider(),
          CommonSelectSingleRow(
            '证件号',
            content: CommonTextField(
                controller: _custIdNumController,
                limitLength: 20,
                hintText: '请输入（必填）',
                textColor: widget.editable == 1 ? UIData.lightGreyColor : UIData.darkGreyColor,
                enabled: widget.editable == 0),
            arrowVisible: false,
          ),
          CommonDivider(),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: UIData.spaceSize16, top: UIData.spaceSize16),
            child: CommonText.darkGrey15Text('附件信息（身份证、证件照等图片${widget.editable == 2 ? '）' : '，必填）'}'),
          ),
          widget.editable == 2
              ? Container(
                  padding: EdgeInsets.only(
                      bottom: UIData.spaceSize12,
                      top: UIData.spaceSize8,
                      left: UIData.spaceSize16,
                      right: UIData.spaceSize16),
                  child: CommonImageDisplay(
                      photoIdList: _newHouseDetail?.relatedAttachmentList
                          ?.map((Attachment attach) => attach?.attachmentUuid)
                          ?.toList()),
                )
              : Container(
                  margin: EdgeInsets.all(UIData.spaceSize16),
                  child: CommonImagePicker(
                    enableAddImage: widget.editable == 0,
                    attachmentList: _newHouseDetail?.relatedAttachmentList,
                    callbackWithInfo: (List<Attachment> images) {
                      if (_newHouseDetail?.relatedAttachmentList == null)
                        _newHouseDetail?.relatedAttachmentList = List();
                      else
                        _newHouseDetail.relatedAttachmentList.clear();
                      _newHouseDetail.relatedAttachmentList.addAll(images);
                    },
                  ),
                ),
          CommonDivider(),
//          Visibility(
//            child:
          CommonSingleInputRow('社区',
              content: (_newHouseDetail?.projectFormerName != null || _newHouseDetail?.projectName != null)
                  ? CommonText.text15(_newHouseDetail?.projectFormerName ?? (_newHouseDetail?.projectName ?? ''),
                      color:
                          widget.editable != 2 && !canEditProject ? UIData.lightGreyColor : UIData.darkGreyColor)
                  : CommonText.lightGrey15Text('请选择（必填）'), onTap: () {
            if (canEditProject) {
              Navigate.toNewPage(
                CommunitySearchPage(callback: (int projectId, String formerName) {
                  setState(() {
                    if (_newHouseDetail?.projectId != projectId) {
                      _newHouseDetail?.projectId = projectId;
                      _newHouseDetail?.projectFormerName = formerName;
                      _newHouseDetail?.houseName = '';
                      _newHouseDetail?.houseId = null;
                      _newHouseDetail?.buildName = null;
                      _newHouseDetail?.unitName = null;
                      _newHouseDetail?.houseNo = null;
                      _newHouseDetail?.houseId = null;
                    }
                  });
                }),
              );
            }
//            else
//              CommonToast.show(type: ToastIconType.INFO, msg: '社区不能编辑');
          }, arrowVisible: canEditProject),
//            visible: canEditProject,
//          ),
          CommonDivider(),
          CommonSingleInputRow('房屋',
              content: StringsHelper.isNotEmpty(_newHouseDetail?.buildName) ||
                      StringsHelper.isNotEmpty(_newHouseDetail?.unitName) ||
                      StringsHelper.isNotEmpty(_newHouseDetail?.houseNo)
                  ? CommonText.text15(
                      '${_newHouseDetail?.buildName ?? ''}${_newHouseDetail?.unitName ?? ''}${_newHouseDetail?.houseNo ?? ''}',
                      color: widget.editable == 1 ? UIData.lightGreyColor : UIData.darkGreyColor)
                  : CommonText.lightGrey15Text('请选择（必填）'), onTap: () {
            if (widget.editable == 0) {
              if (_newHouseDetail?.projectId == null) {
                CommonToast.show(msg: '请先选择社区', type: ToastIconType.INFO);
                return;
              }
              Navigate.toNewPage(SelectHousePage(_newHouseDetail?.projectId, _newHouseDetail?.projectFormerName),
                  callBack: (HouseAddrModel model) {
                if (model != null) {
                  setState(() {
                    _newHouseDetail?.buildName = model?.buildingName;
                    _newHouseDetail?.unitName = model?.unitName;
                    _newHouseDetail?.houseNo = model?.roomName;
                    _newHouseDetail?.houseId = model?.roomId;
                  });
                }
              });
            }
          }, arrowVisible: widget.editable == 0),
          CommonDivider(),
          CommonSelectSingleRow('预约入伙日期',
              hintText: '请输入（必填）',
              content: _newHouseDetail?.scheduleDate,
              contentColor: widget.editable == 1 ? UIData.lightGreyColor : UIData.darkGreyColor, onTap: () {
            if (widget.editable == 0) {
              CommonPicker.datePickerModal(context, onConfirm: (String date) {
                setState(() {
                  if (date != null && !DateUtils.isBefore(date))
                    _newHouseDetail?.scheduleDate = date;
                  else
                    CommonToast.show(type: ToastIconType.INFO, msg: '请选择当前日期之后');
                });
              });
            }
          }, arrowVisible: widget.editable == 0),
          CommonDivider(),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: UIData.spaceSize16, top: UIData.spaceSize16),
            child: CommonText.darkGrey15Text('入伙确认函${widget.editable == 2 ? '' : '（必填）'}'),
          ),
          widget.editable == 2
              ? Container(
                  padding: EdgeInsets.only(
                      bottom: UIData.spaceSize12,
                      top: UIData.spaceSize8,
                      left: UIData.spaceSize16,
                      right: UIData.spaceSize16),
                  child: CommonImageDisplay(
                      photoIdList: _newHouseDetail?.confirmPhotoList
                          ?.map((Attachment attach) => attach?.attachmentUuid)
                          ?.toList()),
                )
              : Container(
                  margin: EdgeInsets.all(UIData.spaceSize16),
                  child: CommonImagePicker(
                    enableAddImage: widget.editable == 0,
                    attachmentList: _newHouseDetail?.confirmPhotoList,
                    callbackWithInfo: (List<Attachment> images) {
                      if (_newHouseDetail?.confirmPhotoList == null)
                        _newHouseDetail?.confirmPhotoList = List();
                      else
                        _newHouseDetail?.confirmPhotoList?.clear();
                      _newHouseDetail?.confirmPhotoList?.addAll(images);
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
