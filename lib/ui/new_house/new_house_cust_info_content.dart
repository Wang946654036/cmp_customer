import 'package:cmp_customer/models/new_house_model.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/strings/strings_house_auth.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_image_display.dart';
import 'package:cmp_customer/ui/common/common_image_picker.dart';
import 'package:cmp_customer/ui/common/common_picker.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_text_field.dart';
import 'package:cmp_customer/ui/decorate_manager/decoration_ui.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'new_house_common_ui.dart';

///
/// Created by qianlx on 2020/3/26 11:27 AM.
/// 新房入伙业主信息内容
/// [editable] 是否可编辑，0-全部可编辑，1-选填可编辑，2-不可编辑
///
class NewHouseCustInfoContent extends StatefulWidget {
  final int editable;
  final NewHouseDetail newHouseDetail;

  NewHouseCustInfoContent(this.editable, this.newHouseDetail);

  @override
  _NewHouseCustInfoContentState createState() => _NewHouseCustInfoContentState();
}

class _NewHouseCustInfoContentState extends State<NewHouseCustInfoContent> {
  NewHouseDetail _newHouseDetail;
  TextEditingController _custCountryController = TextEditingController(); //国籍
  TextEditingController _custNativeController = TextEditingController(); //籍贯
  TextEditingController _personalityDescController = TextEditingController(); //个性
  TextEditingController _emailaddrController = TextEditingController(); //电子邮箱
  TextEditingController _addrController = TextEditingController(); //通讯地址
  TextEditingController _workUnitController = TextEditingController(); //工作单位
  TextEditingController _workAddrController = TextEditingController(); //单位地址
  TextEditingController _accountNameController = TextEditingController(); //账号名
  TextEditingController _bankAccountController = TextEditingController(); //银行账号
  TextEditingController _bankController = TextEditingController(); //开户银行

  TextEditingController _propertyParkController = TextEditingController(); //产权车位
  @override
  void initState() {
    super.initState();

    _initData();
    _setListener();
  }

  void _initData() {
    _newHouseDetail = widget.newHouseDetail;

    _custCountryController.text = _newHouseDetail.custNation;
    _custNativeController.text = _newHouseDetail.custNative;
    _emailaddrController.text = _newHouseDetail.email;
    _addrController.text = _newHouseDetail.regAddr;
    _accountNameController.text = _newHouseDetail.accountName;
    _bankAccountController.text = _newHouseDetail.bankAccount;
    _bankController.text = _newHouseDetail.bank;

    _workUnitController.text = _newHouseDetail.workUnit;
    _workAddrController.text = _newHouseDetail.workAddr;
    _personalityDescController.text = _newHouseDetail.personalityDesc;
    if (_newHouseDetail.propertyParkList != null && _newHouseDetail.propertyParkList.length > 0)
      _propertyParkController.text = _newHouseDetail.propertyParkList[0].number;
    if (_newHouseDetail.gender == null) {
      _newHouseDetail.gender = '1';
    }
    if (_newHouseDetail.payType == null) {
      _newHouseDetail.payType = newHousePayTypeTS;
    }
  }

  void _setListener() {
    _custCountryController.addListener(() {
      _newHouseDetail.custNation = _custCountryController.text;
    });
    _custNativeController.addListener(() {
      _newHouseDetail.custNative = _custNativeController.text;
    });
    _personalityDescController.addListener(() {
      _newHouseDetail.personalityDesc = _personalityDescController.text;
    });
    _emailaddrController.addListener(() {
      _newHouseDetail.email = _emailaddrController.text;
    });
    _addrController.addListener(() {
      _newHouseDetail.regAddr = _addrController.text;
    });
    _workUnitController.addListener(() {
      _newHouseDetail.workUnit = _workUnitController.text;
    });
    _workAddrController.addListener(() {
      _newHouseDetail.workAddr = _workAddrController.text;
    });
    _accountNameController.addListener(() {
      _newHouseDetail.accountName = _accountNameController.text;
    });
    _bankAccountController.addListener(() {
      _newHouseDetail.bankAccount = _bankAccountController.text;
    });
    _bankController.addListener(() {
      _newHouseDetail.bank = _bankController.text;
    });
    _propertyParkController.addListener(() {
      if (_newHouseDetail.propertyParkList == null) {
        _newHouseDetail.propertyParkList = new List();
      } else {
        _newHouseDetail.propertyParkList.clear();
      }
      PropertyParkInfo info = new PropertyParkInfo(number: _propertyParkController.text);
      _newHouseDetail.propertyParkList.add(info);
    });
  }

//  Widget _buildChoiceTap(String tag, String key, String value, {GestureTapCallback onTap}) {
//    return GestureDetector(
//        child: Container(
//          decoration: ShapeDecoration(
//            shape: StadiumBorder(),
//            color: key == tag ? UIData.themeBgColor : UIData.dividerColor,
//          ),
//          padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize16, vertical: UIData.spaceSize6),
//          child: CommonText.text15(value, color: key == tag ? UIData.primaryColor : UIData.lightGreyColor),
//        ),
//        onTap: onTap);
//  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: UIData.spaceSize16),
      color: UIData.primaryColor,
      child: Column(
        children: <Widget>[
          TextWithLeftBorder('业主信息'),
//          leftTextWidget(
//            text: '业主信息',
//            color: UIData.darkGreyColor,
//            fontSize: UIData.fontSize17,
//          ),
          //国籍
          CommonSelectSingleRow(
            '国籍',
            content: CommonTextField(
                hintText: widget.editable == 2 ? '' : null,
                controller: _custCountryController,
                enabled: widget.editable != 2),
            arrowVisible: false,
          ),
          CommonDivider(),
          //籍贯
          CommonSelectSingleRow(
            '籍贯',
            content: CommonTextField(
                hintText: widget.editable == 2 ? '' : null,
                controller: _custNativeController,
                enabled: widget.editable != 2),
            arrowVisible: false,
          ),
          CommonDivider(),
          //户口所在地
          CommonSelectSingleRow(
            '户口所在地',
            content: CommonTextField(
                hintText: widget.editable == 2 ? '' : null,
                controller: _addrController,
                enabled: widget.editable != 2),
            arrowVisible: false,
          ),
          CommonDivider(),
          //出生日期
          CommonSelectSingleRow('出生日期',
              hintText: widget.editable == 2 ? '' : null, content: _newHouseDetail.custBirth, onTap: () {
            if (widget.editable != 2) {
              CommonPicker.datePickerModal(context, onConfirm: (String date) {
                setState(() {
                  _newHouseDetail.custBirth = date;
                });
              });
            }
          }, arrowVisible: widget.editable != 2),
          CommonDivider(),

          //性别:1-男，2-女
          CommonSelectSingleRow('性别',
              content: widget.editable == 2
                  ? (_newHouseDetail?.gender == '1' ? '男' : '女')
                  : Row(
                      children: <Widget>[
                        ChoiceTap('1', _newHouseDetail.gender, '男', onTap: () {
                          setState(() {
                            _newHouseDetail.gender = '1';
                          });
                        }),
                        SizedBox(width: UIData.spaceSize16),
                        ChoiceTap('2', _newHouseDetail.gender, '女', onTap: () {
                          setState(() {
                            _newHouseDetail.gender = '2';
                          });
                        }),
                      ],
                    ),
              arrowVisible: false),
          CommonDivider(),

          //工作单位
          CommonSelectSingleRow(
            '工作单位',
            content: CommonTextField(
                hintText: widget.editable == 2 ? '' : null,
                controller: _workUnitController,
                enabled: widget.editable != 2),
            arrowVisible: false,
          ),
          CommonDivider(),
          CommonSelectSingleRow(
            '单位地址',
            content: CommonTextField(
                hintText: widget.editable == 2 ? '' : null,
                controller: _workAddrController,
                enabled: widget.editable != 2),
            arrowVisible: false,
          ),
          CommonDivider(),
          //电子邮箱
          CommonSelectSingleRow(
            '电子邮箱',
            content: CommonTextField(
                hintText: widget.editable == 2 ? '' : null,
                controller: _emailaddrController,
                enabled: widget.editable != 2),
            arrowVisible: false,
          ),
          CommonDivider(),
          CommonSelectSingleRow(
            '产权车位',
            content: CommonTextField(
                hintText: widget.editable == 2 ? '' : null,
                controller: _propertyParkController,
                enabled: widget.editable != 2),
            arrowVisible: false,
          ),
          CommonDivider(),
          //个性描述
          widget.editable == 2
              ? CommonSelectSingleRow(
                  '个性描述',
                  content: _newHouseDetail.personalityDesc ?? '',
                  hintText: '',
                  arrowVisible: false,
                )
              : FormMultipleTextField('个性描述',
                  controller: _personalityDescController, hintText: '兴趣爱好、生活习惯、对物业态度等'),
          CommonDivider(),
          CommonSelectSingleRow(
            '是否托收',
            content: widget.editable == 2
                ? (_newHouseDetail?.payType == newHousePayTypeTS ? '是' : '否')
                : Row(
                    children: <Widget>[
                      CommonRadio(
                          text: '是',
                          value: newHousePayTypeTS,
                          groupValue: _newHouseDetail.payType,
                          onChanged: (String value) {
                            setState(() {
                              _newHouseDetail.payType = value;
                            });
                          }),
                      SizedBox(width: UIData.spaceSize16),
                      //不是托收就存XJ-现金
                      CommonRadio(
                          text: '否',
                          value: newHousePayTypeXJ,
                          groupValue: _newHouseDetail.payType,
                          onChanged: (String value) {
                            setState(() {
                              _newHouseDetail.payType = value;
                            });
                          }),
                    ],
                  ),
            arrowVisible: false,
          ),
          CommonDivider(),
          CommonSelectSingleRow(
            '账号名',
            content: CommonTextField(
                controller: _accountNameController,
                hintText:
                    widget.editable == 2 ? '' : _newHouseDetail.payType == newHousePayTypeTS ? '请输入（必填）' : '请输入',
                enabled: widget.editable != 2),
            arrowVisible: false,
          ),
          CommonDivider(),
          CommonSelectSingleRow(
            '银行账号',
            content: CommonTextField(
                controller: _bankAccountController,
                hintText:
                    widget.editable == 2 ? '' : _newHouseDetail.payType == newHousePayTypeTS ? '请输入（必填）' : '请输入',
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter(RegExp("[0-9]")),
                ],
                keyboardType: TextInputType.number,
                enabled: widget.editable != 2),
            arrowVisible: false,
          ),
          CommonDivider(),
          CommonSelectSingleRow(
            '开户银行',
            content: CommonTextField(
                controller: _bankController,
                hintText:
                    widget.editable == 2 ? '' : _newHouseDetail.payType == newHousePayTypeTS ? '请输入（必填）' : '请输入',
                enabled: widget.editable != 2),
            arrowVisible: false,
          ),
          CommonDivider(),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: UIData.spaceSize16, top: UIData.spaceSize16),
            child: CommonText.darkGrey15Text(
                '银行卡复印件（可拍照上传${_newHouseDetail.payType == newHousePayTypeTS ? '，必填）' : '）'}'),
          ),
          widget.editable == 2
              ? Container(
                  padding: EdgeInsets.only(
                      bottom: UIData.spaceSize12,
                      top: UIData.spaceSize8,
                      left: UIData.spaceSize16,
                      right: UIData.spaceSize16),
                  child: CommonImageDisplay(
                      photoIdList: _newHouseDetail.bankCollectAttachmentList
                          ?.map((Attachment attach) => attach?.attachmentUuid)
                          ?.toList()),
                )
              : Container(
                  margin: EdgeInsets.all(UIData.spaceSize16),
                  child: CommonImagePicker(
                    attachmentList: _newHouseDetail.bankCollectAttachmentList,
                    callbackWithInfo: (List<Attachment> images) {
                      if (_newHouseDetail.bankCollectAttachmentList == null)
                        _newHouseDetail.bankCollectAttachmentList = List();
                      else
                        _newHouseDetail.bankCollectAttachmentList.clear();
                      _newHouseDetail.bankCollectAttachmentList.addAll(images);
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
