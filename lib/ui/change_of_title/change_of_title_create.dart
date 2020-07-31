import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/property_change_user_param.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/scoped_models/change_of_title_model.dart';
import 'package:cmp_customer/strings/strings_common.dart';
import 'package:cmp_customer/ui/change_of_title/change_of_title_pending_list.dart';
import 'package:cmp_customer/ui/change_of_title/change_of_title_ui.dart';
import 'package:cmp_customer/ui/change_of_title/house_select.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_image_picker.dart';
import 'package:cmp_customer/ui/common/common_picker.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_text_field.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/common/copy_writing_page.dart';

import 'package:cmp_customer/ui/work_other/work_other_ui.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';

import 'package:flutter/material.dart';

import 'package:cmp_customer/models/change_title_obj.dart';
import 'package:scoped_model/scoped_model.dart';

///
/// 产权变更
///
class ChangeOfTitleCreate extends StatefulWidget {
  ChangeTitleInfo changeTitleInfo;

  ChangeOfTitleCreate({this.changeTitleInfo});

  @override
  _ChangeOfTitleCreateState createState() => _ChangeOfTitleCreateState(this.changeTitleInfo);
}

class _ChangeOfTitleCreateState extends State<ChangeOfTitleCreate> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _documentController = TextEditingController();
  ChangeTitleInfo changeTitleInfo;
  List<Attachment> attPhotoList = new List();

  _ChangeOfTitleCreateState(this.changeTitleInfo);

  ChangeOfTitleModel _stateModel;

  @override
  void initState() {
    super.initState();
    if (changeTitleInfo == null) {
      changeTitleInfo = new ChangeTitleInfo();
    }
    if (_stateModel == null) {
      _stateModel = new ChangeOfTitleModel();
      _stateModel.getHouseList();
    }
//    changeTitleInfo.projectId = stateModel.defaultProjectId;
//    changeTitleInfo.projectName = stateModel.defaultProjectName;
//    changeTitleInfo.unitName = stateModel.defaultUnitName;
//    changeTitleInfo.buildName = stateModel.defaultBuildingName;
//    changeTitleInfo.houseId = stateModel.defaultHouseId;
//    changeTitleInfo.houseNo = stateModel.defaultHouseName;
    _nameController.text = changeTitleInfo?.assigneeRealname;
    _documentController.text = changeTitleInfo?.assigneeIdNum;
    _phoneController.text = changeTitleInfo?.assigneePhone;
    getFileList();
  }

  ///
  /// 检查表单填写
  ///
  bool _checkData() {
//    if (changeTitleInfo?.projectId == null) {
//      CommonToast.show(msg: '请选择社区', type: ToastIconType.INFO);
//      return false;
//    }
    if (changeTitleInfo?.houseId == null) {
      CommonToast.show(msg: '请选择房号信息', type: ToastIconType.INFO);
      return false;
    }
    if (changeTitleInfo?.assigneeIdTypeId == null || changeTitleInfo.assigneeIdTypeId.isEmpty) {
      CommonToast.show(msg: '请选择证件类型', type: ToastIconType.INFO);
      return false;
    }
    if (changeTitleInfo?.assigneeIdNum == null || changeTitleInfo.assigneeIdNum.isEmpty) {
      CommonToast.show(msg: '请输入证件号', type: ToastIconType.INFO);
      return false;
    }
    if (changeTitleInfo?.assigneeRealname == null || changeTitleInfo.assigneeRealname.isEmpty) {
      CommonToast.show(msg: '请输入姓名', type: ToastIconType.INFO);
      return false;
    }

    if (changeTitleInfo?.assigneePhone == null || changeTitleInfo.assigneePhone.isEmpty) {
      CommonToast.show(msg: '请输入手机号码', type: ToastIconType.INFO);
      return false;
    }
    if (!StringsHelper.isPhone(changeTitleInfo.assigneePhone)) {
      CommonToast.show(msg: '请输入正确的手机号码', type: ToastIconType.INFO);
      return false;
    }
    bool flag = false;
    if (attPhotoList.length > 0) {
      if (StringsHelper.isEmpty(attPhotoList.length > 0 ? (attPhotoList[0]?.attachmentUuid ?? '') : '')) {
        CommonToast.show(type: ToastIconType.INFO, msg: '请添加证明资料');
        return false;
      }
      attPhotoList.forEach((info) {
        if (info == null) {
          CommonToast.show(type: ToastIconType.INFO, msg: '还有图片未上传');
          return false;
        }
      });
      flag = true;
    } else {
      CommonToast.show(type: ToastIconType.INFO, msg: '请添加附件图片');
      return false;
    }
    if (flag) {
      if (changeTitleInfo.attFileList == null)
        changeTitleInfo.attFileList = new List();
      else
        changeTitleInfo.attFileList.clear();
      attPhotoList.forEach((info) {
        changeTitleInfo.attFileList.add(new Attachment(
            attachmentType: info.attachmentType,
            attachmentName: info.attachmentName,
            attachmentUuid: info.attachmentUuid));
      });
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ChangeOfTitleModel>(
        model: _stateModel,
        child: ScopedModelDescendant<ChangeOfTitleModel>(builder: (context, child, model) {
          return CommonScaffold(
            appBarActions: <Widget>[
              Visibility(
                child: FlatButton(
                  onPressed: () {
                    Navigate.toNewPage(ChangeOfTitleListPage(_stateModel, (PropertyChangeUserParam param) {
                      param.custId = stateModel.customerId;
                    }));
                  },
                  child: Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: UIData.spaceSize16),
                      child: CommonText.text15("办理记录", color: UIData.themeBgColor, textAlign: TextAlign.center)),
                ),
                visible: changeTitleInfo?.propertyChangeId == null,
              ),
            ],
            appTitle: '产权变更申请',
            bodyData: Container(
              child: ListView(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: UIData.spaceSize12),
                    color: UIData.primaryColor,
                    child: leftTextWidget(
                      fontSize: UIData.fontSize17,
                      text: '转让房屋信息',
                      color: UIData.darkGreyColor,
                      topSpacing: UIData.spaceSize12,
                      bottomSpacing: UIData.spaceSize8,
                    ),
                  ),
                  CommonSingleInputRow('房号',
                      content: changeTitleInfo?.houseNo != null
                          ? '${changeTitleInfo?.formerName ?? ''}${changeTitleInfo?.buildName ?? ''}${changeTitleInfo?.unitName ?? ''}${changeTitleInfo?.houseNo ?? ''}'
                          : CommonText.lightGrey15Text('请选择'), onTap: () {
                    if (changeTitleInfo.propertyChangeId == null) {
                      if (model.houseList == null) {
                        CommonToast.show(type: ToastIconType.INFO, msg: '正在加载，请稍后再试');
                      } else if (model.houseList.length == 0) {
                        CommonToast.show(type: ToastIconType.INFO, msg: '未查询到您名下有房子');
                      } else {
                        Navigate.toNewPage(
                            HouseSelectPage(changeTitleInfo?.houseId, model.houseList, (HouseInfo info) {
                          setState(() {
                            changeTitleInfo.projectName = info.projectName;
                            changeTitleInfo.formerName = info.formerName;
                            changeTitleInfo.buildName = info.buildName;
                            changeTitleInfo.unitName = info.unitName;
                            changeTitleInfo.houseNo = info.houseNo;
                            changeTitleInfo.houseId = info.houseId;
                            changeTitleInfo.projectId = info.projectId;
                            changeTitleInfo.buildId = info.buildId;
                            changeTitleInfo.unitId = info.unitId;
                          });
                        }));
                      }
                    }
                  },
                      contentOverFlow: TextOverflow.fade,
                      arrowVisible: changeTitleInfo.propertyChangeId == null,
                      contentColor:
                          changeTitleInfo.propertyChangeId == null ? UIData.darkGreyColor : UIData.lightGreyColor),
                  Column(
                    children: <Widget>[
                      SizedBox(height: UIData.spaceSize12),
                      Container(
                        child: leftTextWidget(
                          text: '受让人信息',
                          color: UIData.darkGreyColor,
                          fontSize: UIData.fontSize17,
                          topSpacing: UIData.spaceSize12,
                          bottomSpacing: UIData.spaceSize8,
                        ),
                        color: UIData.primaryColor,
                      ),
                      CommonSingleInputRow(
                        '姓名',
                        content: TextField(
                          controller: _nameController,
                          style: CommonText.darkGrey15TextStyle(),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '请输入（必填）',
                            hintStyle: CommonText.lightGrey15TextStyle(),
                            isDense: true,
                          ),
                          onChanged: (String value) {
                            setState(() {
                              changeTitleInfo.assigneeRealname = value;
                            });
                          },
                        ),
                        arrowVisible: false,
                      ),
                      CommonDivider(),
                      CommonSingleInputRow(
                        '手机',
                        content: TextField(
                          controller: _phoneController,
                          style: CommonText.darkGrey15TextStyle(),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '请输入（必填）',
                            hintStyle: CommonText.lightGrey15TextStyle(),
                            isDense: true,
                          ),
                          onChanged: (String value) {
                            setState(() {
                              changeTitleInfo.assigneePhone = value;
                            });
                          },
                        ),
                        arrowVisible: false,
                      ),
                      CommonDivider(),
                      CommonSingleInputRow(
                        '证件类型',
                        content: changeTitleInfo.assigneeIdTypeId != null
                            ? CommonText.darkGrey15Text(getIDType(changeTitleInfo.assigneeIdTypeId))
                            : CommonText.lightGrey15Text('请选择（必选）'),
                        onTap: () => CommonPicker.singlePickerModal(context, documentMap.values.toList(),
                            onConfirm: (int index, String data) {
                          setState(() {
                            changeTitleInfo.assigneeIdTypeId = documentMap.keys.toList()[index];
                          });
                        }),
                      ),
                      CommonDivider(),
                      CommonSingleInputRow(
                        '证件号',
                        content: TextField(
                          controller: _documentController,
                          style: CommonText.darkGrey15TextStyle(),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '请输入（必填）',
                            hintStyle: CommonText.lightGrey15TextStyle(),
                            isDense: true,
                          ),
                          onChanged: (String value) {
                            setState(() {
                              changeTitleInfo.assigneeIdNum = value;
                            });
                          },
                        ),
                        arrowVisible: false,
                      ),
                    ],
                  ),
                  Container(
                      color: UIData.primaryColor,
                      margin: EdgeInsets.only(top: UIData.spaceSize12),
                      child: Column(
                        children: <Widget>[
                          leftTextWidget(
                            text: '证明资料',
                            topSpacing: UIData.spaceSize12,
                          ),
                          Container(
                            margin: EdgeInsets.all(UIData.spaceSize16),
                            child: CommonImagePicker(
                              attachmentList: attPhotoList,
                              callbackWithInfo: (List<Attachment> list) {
                                attPhotoList = list;
                              },
                            ),
                          ),
                        ],
                      )),
                  GestureDetector(
                      child: Container(
                        color: UIData.primaryColor,
                        padding: EdgeInsets.only(
                            left: UIData.spaceSize16,
                            right: UIData.spaceSize16,
                            top: UIData.spaceSize12,
                            bottom: UIData.spaceSize16),
                        child: CommonText.text12('产权变更注意事项', color: UIData.redColor),
                      ),
                      onTap: () =>
                          Navigate.toNewPage(CopyWritingPage('产权变更注意事项', CopyWritingType.PropertyChangeNotes))),
                ],
              ),
            ),
            bottomNavigationBar: StadiumSolidButton('提交申请', onTap: () {
              if (_checkData()) {
                _stateModel.checkUploadData(changeTitleInfo);
              }
            }),
          );
        }));
  }

  getFileList() {
    attPhotoList.clear();
    if (changeTitleInfo.attFileList != null)
      changeTitleInfo.attFileList.forEach((info) {
        attPhotoList.add(new Attachment(
            attachmentName: info.attachmentName,
            attachmentUuid: info.attachmentUuid,
            attachmentType: info.attachmentType));
      });
  }
}
