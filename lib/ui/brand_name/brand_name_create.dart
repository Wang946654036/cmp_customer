import 'dart:convert';

import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/brand_name_obj.dart';
import 'package:cmp_customer/models/property_change_user_param.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/scoped_models/brand_name_model.dart';
import 'package:cmp_customer/strings/strings_common.dart';
import 'package:cmp_customer/ui/brand_name/brand_name_history.dart';
import 'package:cmp_customer/ui/common/copy_writing_page.dart';
import 'package:cmp_customer/ui/work_other/work_other_ui.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/date_util.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_image_picker.dart';
import 'package:cmp_customer/ui/common/common_picker.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_text_field.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:cmp_customer/utils/navigate.dart';

class BrandNameCreate extends StatefulWidget {
  BrandNameInfo brandNameInfo;

  BrandNameCreate({this.brandNameInfo});

  @override
  _BrandNameCreateCreateState createState() =>
      _BrandNameCreateCreateState();
}

class _BrandNameCreateCreateState extends State<BrandNameCreate> {
  BrandNameInfo brandNameInfo;
  BrandNameModel _stateModel;

  _BrandNameCreateCreateState();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _nameCountController = TextEditingController();
  TextEditingController _waterController = TextEditingController();
  TextEditingController _waterCountController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  List<Attachment> attPhotoList = new List();
  List<Map> myList;

  @override
  void initState() {
    super.initState();
    if (widget.brandNameInfo == null) {
      brandNameInfo = new BrandNameInfo(
          projectId: stateModel.defaultProjectId,
          houseId: stateModel.defaultHouseId,
          applyManId: stateModel.customerId);
      myList = [
        {'key': '水牌', 'bool': true},
        {'key': '名牌', 'bool': true}
      ];
    }else{
      brandNameInfo = BrandNameInfo.fromJson(jsonDecode(jsonEncode(widget.brandNameInfo.toJson())));
      myList = [
        {'key': '水牌', 'bool': (brandNameInfo?.spApplyCount??0)>0},
        {'key': '名牌', 'bool': (brandNameInfo?.mpApplyCount??0)>0}
      ];
    }
    if (_stateModel == null) {
      _stateModel = new BrandNameModel();
    }

    _nameController.text = brandNameInfo?.mpContent;
    _nameCountController.text = (brandNameInfo?.mpApplyCount?.toString() ?? '');
    _contentController.text = brandNameInfo?.remark;
    _waterController.text = brandNameInfo?.spContent;
    _waterCountController.text = (brandNameInfo.spApplyCount?.toString() ?? '');
    getFileList();

  }

  ///
  /// 检查表单填写
  ///
  bool _checkData() {
    int i = 0;
    if (StringsHelper.isEmpty(brandNameInfo?.useTime)) {
      CommonToast.show(msg: '请选择使用日期', type: ToastIconType.INFO);
      return false;
    }
    if (myList[0]['bool']) {
      i = 1;
      if (StringsHelper.isEmpty(_waterCountController.text)) {
        CommonToast.show(msg: '请输入水牌数量', type: ToastIconType.INFO);
        return false;
      } else {
        try {
          brandNameInfo.spApplyCount = int.parse(_waterCountController.text);
          if (brandNameInfo.spApplyCount < 0) {
            CommonToast.show(msg: '水牌数量超过允许范围，请重新输入', type: ToastIconType.INFO);
            return false;
          } else if (brandNameInfo.spApplyCount > 9999) {
            CommonToast.show(msg: '水牌数量超过允许范围，请重新输入', type: ToastIconType.INFO);
            return false;
          }
        } catch (e) {
          CommonToast.show(msg: '水牌数量超过允许范围，请重新输入', type: ToastIconType.INFO);
          return false;
        }
      }
      if (StringsHelper.isEmpty(_waterController.text)) {
        CommonToast.show(msg: '请输入水牌内容', type: ToastIconType.INFO);
        return false;
      } else {
        brandNameInfo.spContent = _waterController.text;
      }
    }
    if (myList[1]['bool']) {
      if (i == 1) {
        i = 3;
      } else {
        i = 2;
      }
      if (StringsHelper.isEmpty(_nameCountController.text)) {
        CommonToast.show(msg: '请输入名牌数量', type: ToastIconType.INFO);
        return false;
      } else {
        try {
          brandNameInfo.mpApplyCount = int.parse(_nameCountController.text);
          if (brandNameInfo.mpApplyCount < 0) {
            CommonToast.show(msg: '名牌数量超过允许范围，请重新输入', type: ToastIconType.INFO);
            return false;
          } else if (brandNameInfo.mpApplyCount > 9999) {
            CommonToast.show(msg: '名牌数量超过允许范围，请重新输入', type: ToastIconType.INFO);
            return false;
          }
        } catch (e) {
          CommonToast.show(msg: '名牌数量超过允许范围，请重新输入', type: ToastIconType.INFO);
          return false;
        }
      }
      if (StringsHelper.isEmpty(_nameController.text)) {
        CommonToast.show(msg: '请输入名牌内容', type: ToastIconType.INFO);
        return false;
      } else {
        brandNameInfo.mpContent = _nameController.text;
      }
    }
    switch (i) {
      case 0:
        CommonToast.show(msg: '请选择水牌或名牌', type: ToastIconType.INFO);
        return false;
        break;
      case 1:
        brandNameInfo.applyType = 'SP';
        break;
      case 2:
        brandNameInfo.applyType = 'MP';
        break;
      case 3:
        brandNameInfo.applyType = 'SPMP';
        break;
    }
    if (StringsHelper.isNotEmpty(_contentController.text)) {
      brandNameInfo.remark = _contentController.text;
    }

if(!_stateModel.agree){
  CommonToast.show(type: ToastIconType.INFO, msg: '请先同意水牌名牌协议');
  return false;
}
    bool flag = false;
    if (attPhotoList.length > 0) {
      if (StringsHelper.isEmpty(attPhotoList.length > 0
          ? (attPhotoList[0]?.attachmentUuid ?? '')
          : '')) {
        CommonToast.show(type: ToastIconType.INFO, msg: '请添加附件图片');
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
      if (brandNameInfo.attList == null)
        brandNameInfo.attList = new List();
      else
        brandNameInfo.attList.clear();
      attPhotoList.forEach((info) {
        brandNameInfo.attList.add(new AttList(
            attachmentType: info.attachmentType,
            attachmentName: info.attachmentName,
            attachmentUuid: info.attachmentUuid));
      });
    }

    switch (i) {
      case 1:
        if(brandNameInfo.mpSettingList!=null)
        brandNameInfo.mpSettingList.clear();
        brandNameInfo.mpApplyCount=null;
        brandNameInfo.mpContent=null;
        break;
      case 2:
        if(brandNameInfo.spSettingList!=null)
          brandNameInfo.spSettingList.clear();
        brandNameInfo.spApplyCount=null;
        brandNameInfo.spContent=null;
        break;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<BrandNameModel>(
        model: _stateModel,
        child: ScopedModelDescendant<BrandNameModel>(
            builder: (context, child, model) {
          return CommonScaffold(
            appBarActions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigate.toNewPage(BrandNameListPage(_stateModel,
                        (PropertyChangeUserParam param) {
                      param.custId = stateModel.customerId;
                    }));
                  },
                  child: Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: UIData.spaceSize16),
                      child: CommonText.text15("申请列表",
                          color: UIData.themeBgColor,
                          textAlign: TextAlign.center))),

//              GestureDetector(
//                  onTap: () {
//                    Navigate.toNewPage(BrandNameListPage(_stateModel,
//                        (PropertyChangeUserParam param) {
//                      param.custId = stateModel.customerId;
//                    }));
//                  },
//                  child: Container(
//                      alignment: Alignment.centerRight,
//                      padding: EdgeInsets.only(right: UIData.spaceSize16),
//                      child: CommonText.text15("申请列表",
//                          color: UIData.themeBgColor,
//                          textAlign: TextAlign.center)))
            ],
            appTitle: '水牌名牌申请',
            bodyData: Container(
              child: ListView(
                children: <Widget>[
                  Container(
                    color: UIData.primaryColor,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: leftTextWidget(
                            text: '申请类型',
                            fontSize: UIData.fontSize15,
                            color: UIData.greyColor,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            runAlignment: WrapAlignment.start,
                            spacing: UIData.spaceSize10,
                            runSpacing: UIData.spaceSize3 * 2,
                            children: getSpcWidgetList(),
                          ),
                        ),
                      ],
                    ),
                  ),

                  CommonSingleInputRow(
                    '使用日期',
                    content: brandNameInfo?.useTime != null
                        ? CommonText.darkGrey15Text(
                            '${brandNameInfo?.useTime ?? ''}')
                        : CommonText.lightGrey15Text('请选择'),
                    onTap: () {
                      CommonPicker.datePickerModal(context,
                          onConfirm: (String date) {
                        if (DateUtils.isBefore(date)) {
                          CommonToast.show(
                              type: ToastIconType.INFO, msg: '不能选择早于当前日期');
                          return;
                        }
                        setState(() {
                          brandNameInfo.useTime = date;
                        });
                      });
                    },
                  ),

                  ///水牌
                  Visibility(
                    visible: myList[0]['bool'],
                    child: Container(
                      margin: EdgeInsets.only(top: UIData.spaceSize12),
                      color: UIData.primaryColor,
                      child: Column(
                        children: <Widget>[
                          CommonSingleInputRow(
                            '水牌数量',
                            content: TextField(
                              controller: _waterCountController,
                              style: CommonText.darkGrey15TextStyle(),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: '请输入（必填）',
                                hintStyle: CommonText.lightGrey15TextStyle(),
                                isDense: true,
                              ),
                            ),
                            arrowVisible: false,
                          ),
                          CommonDivider(),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: UIData.spaceSize12),
                            color: UIData.primaryColor,
                            child: Column(
                              children: <Widget>[
                                leftTextWidget(
                                  text: '水牌内容',
                                  color: UIData.greyColor,
                                  fontSize: UIData.fontSize15,
                                ),
                                inputWidget(
                                  controller: _waterController,
                                  hint_text: "请输入（必填）",
                                  maxLength: 200,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  ///名牌
                  Visibility(
                    visible: myList[1]['bool'],
                    child: Container(
                      margin: EdgeInsets.only(top: UIData.spaceSize12),
                      color: UIData.primaryColor,
                      child: Column(
                        children: <Widget>[
                          CommonSingleInputRow(
                            '名牌数量',
                            content: TextField(
                              controller: _nameCountController,
                              style: CommonText.darkGrey15TextStyle(),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: '请输入（必填）',
                                hintStyle: CommonText.lightGrey15TextStyle(),
                                isDense: true,
                              ),
                            ),
                            arrowVisible: false,
                          ),
                          CommonDivider(),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: UIData.spaceSize12),
                            color: UIData.primaryColor,
                            child: Column(
                              children: <Widget>[
                                leftTextWidget(
                                  text: '名牌内容',
                                  color: UIData.greyColor,
                                  fontSize: UIData.fontSize15,
                                ),
                                inputWidget(
                                  controller: _nameController,
                                  hint_text: "请输入（必填）",
                                  maxLength: 200,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  ///附件
                  Container(
                      color: UIData.primaryColor,
                      margin: EdgeInsets.only(top: UIData.spaceSize12),
                      child: Column(
                        children: <Widget>[
                          leftTextWidget(
                            fontSize: UIData.fontSize15,
                            text: '制作附件',
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

                  ///备注
                  Container(
                    margin: EdgeInsets.only(top: UIData.spaceSize12),
                    padding: EdgeInsets.only(bottom: UIData.spaceSize12),
                    color: UIData.primaryColor,
                    child: Column(
                      children: <Widget>[
                        leftTextWidget(
                          text: '备注',
                          fontSize: UIData.fontSize15,
                          color: UIData.greyColor,
                          topSpacing: UIData.spaceSize12,
                        ),
                        inputWidget(
                          controller: _contentController,
                          hint_text: "若有特殊的制作要求，请备注说明。",
                          maxLength: 200,
                        ),
                      ],
                    ),
                  ),
//            GestureDetector(
//              onTap: () {
//                model.toAgreementPage();
//              },
//              child: Text(
//                label_apply_business_agreement,
//                style: TextStyle(
//                    fontSize: UIData.fontSize11,
//                    color: color_text_red),
//              ),
//            )
                  Container(
                    margin: EdgeInsets.symmetric(vertical: UIData.spaceSize12),
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            _stateModel.onChangeAgree();
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: UIData.spaceSize16,
                                right: UIData.spaceSize8),
                            child: _stateModel.agree
                                ? UIData.iconCheckBoxSelected
                                : UIData.iconCheckBoxNormal,
                          ),
                        ),
                        Text(
                          "同意",
                          style: TextStyle(fontSize: UIData.fontSize11),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigate.toNewPage(CopyWritingPage('水牌名牌申请协议',
                                CopyWritingType.CardBrandApplication));
                          },
                          child: Text(
                            '水牌名牌申请协议',
                            style: TextStyle(
                                fontSize: UIData.fontSize11,
                                color: UIData.themeBgColor),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: StadiumSolidButton('提交申请', onTap: () {
              if (_checkData()) {
                if (brandNameInfo.operateStep == null) {
                  brandNameInfo.operateStep = 'SPMP_TJSQ';
                }
                _stateModel.checkUploadData(brandNameInfo);
              }
            }),
          );
        }));
  }

  getFileList() {
    attPhotoList.clear();
    if (brandNameInfo.attList != null)
      brandNameInfo.attList.forEach((info) {
        attPhotoList.add(new Attachment(
            attachmentName: info.attachmentName,
            attachmentUuid: info.attachmentUuid,
            attachmentType: info.attachmentType));
      });
  }

  List<Widget> getSpcWidgetList() {
    List<Widget> widgetList = new List();
    for (int i = 0; i < myList.length; i++) {
      widgetList.add(ChoiceChip(
        label: Text(myList[i]['key']),
        selected: myList[i]['bool'],
        selectedColor: UIData.themeBgColor,
        backgroundColor: Color(0xFFEFEFEF),
        labelStyle: myList[i]['bool']
            ? TextStyle(
                color: UIData.primaryColor,
                fontSize: UIData.fontSize14,
              )
            : TextStyle(
                color: UIData.lightGreyColor,
                fontSize: UIData.fontSize14,
              ),
        onSelected: (bool value) {
          setState(() {
            myList[i]['bool']
                ? myList[i]['bool'] = false
                : myList[i]['bool'] = true;
          });
        },
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(UIData.spaceSize12 + UIData.spaceSize3)),
      ));
    }

    return widgetList;
  }
}
