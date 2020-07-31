import 'package:cmp_customer/models/new_house_model.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/strings/strings_common.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_image_display.dart';
import 'package:cmp_customer/ui/common/common_image_picker.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_text_field.dart';
import 'package:cmp_customer/ui/common/copy_writing_page.dart';
import 'package:cmp_customer/ui/decorate_manager/decoration_ui.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';

import 'new_house_common_ui.dart';

///
/// Created by qianlx on 2020/3/26 11:27 AM.
/// 新房入伙宠物信息内容
/// [editable] 是否可编辑，0-全部可编辑，1-选填可编辑，2-不可编辑
///
class NewHousePetInfoContent extends StatefulWidget {
  final int editable;
  final NewHouseDetail newHouseDetail;

  NewHousePetInfoContent(this.editable, this.newHouseDetail);

  @override
  _NewHousePetInfoContentState createState() => _NewHousePetInfoContentState();
}

class _NewHousePetInfoContentState extends State<NewHousePetInfoContent> {
  NewHouseDetail _newHouseDetail;
  List<Widget> _petsWidgetList; //宠物信息控件列表

  @override
  void initState() {
    super.initState();

    _initData();
  }

  void _initData() {
    _newHouseDetail = widget.newHouseDetail;

    if (_newHouseDetail.newHousePetInfoList != null && _newHouseDetail.newHousePetInfoList.length > 0) {
      _newHouseDetail.newHousePetInfoList?.forEach((NewHousePetInfo newHousePetInfo) {
        _petsWidgetAdd();
      });
    } else {
      _petsAdd();
      _petsWidgetAdd();
    }
  }

  void _petsAdd() {
    if (_newHouseDetail.newHousePetInfoList == null) _newHouseDetail.newHousePetInfoList = List();
    _newHouseDetail.newHousePetInfoList.add(NewHousePetInfo());
  }

  void _petsWidgetAdd() {
    if (_petsWidgetList == null) _petsWidgetList = List();
    _petsWidgetList.add(PetCard(_petsWidgetList.length, _newHouseDetail, widget.editable, callback: (int index) {
      setState(() {
        LogUtils.printLog('去掉$index');
        _newHouseDetail.newHousePetInfoList.removeAt(index);
        _petsWidgetList.removeAt(index);
      });
    }, key: GlobalKey()));
  }

  //物品列表
  Widget _buildPetsList() {
    return Visibility(
        visible: _newHouseDetail?.newHousePetInfoList != null && _newHouseDetail.newHousePetInfoList.length > 0,
        child: ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
//            padding: EdgeInsets.only(top: UIData.spaceSize16),
            itemCount: _newHouseDetail?.newHousePetInfoList?.length ?? 0,
            itemBuilder: (context, index) {
//              WelderInfo welderInfo = _applyModel.welderList[index];
              return _petsWidgetList[index];
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: UIData.spaceSize16);
            }));
  }

  //添加宠物按钮
  Widget _buildAddPetsButton() {
    return Visibility(
        child: Container(
          padding: EdgeInsets.only(top: UIData.spaceSize16),
          color: UIData.scaffoldBgColor,
          child: Container(
            color: UIData.primaryColor,
            child: FlatButton(
                onPressed: () {
                  setState(() {
                    _petsAdd();
                    _petsWidgetAdd();
                  });
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.add_circle, color: UIData.themeBgColor),
                    SizedBox(width: UIData.spaceSize4),
                    CommonText.red15Text('添加宠物'),
                  ],
                )),
          ),
        ),
        visible: widget.editable != 2);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: UIData.spaceSize16),
      color: UIData.primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextWithLeftBorder('宠物信息'),
//          leftTextWidget(
//            text: '宠物信息',
//            color: UIData.darkGreyColor,
//            fontSize: UIData.fontSize17,
//          ),
          SizedBox(height: UIData.spaceSize16),
          _buildPetsList(),
          _buildAddPetsButton(),
          Visibility(
              child: GestureDetector(
                  child: Container(
                      color: UIData.scaffoldBgColor,
                      padding: EdgeInsets.all(UIData.spaceSize16),
                      child: Row(
                        children: <Widget>[
                          UIData.iconInfoOutline,
                          SizedBox(width: UIData.spaceSize4),
                          CommonText.red14Text('业主公约')
                        ],
                      )),
                  onTap: () {
                    Navigate.toNewPage(CopyWritingPage('业主公约', CopyWritingType.OwnerPledge));
                  }),
              visible: widget.editable != 2),
        ],
      ),
    );
  }
}

///
/// 单个新房入伙宠物信息卡片
/// [canOperate]是否可操作，详情不可操作，新建或修改可以编辑和删除
/// [editable] 是否可编辑，0-全部可编辑，1-选填可编辑，2-不可编辑
///
class PetCard extends StatefulWidget {
  final int index;
  final NewHouseDetail model;
  final Function callback;
  final int customerType;
  final int editable;

  PetCard(this.index, this.model, this.editable, {Key key, this.callback, this.customerType}) : super(key: key);

  @override
  _PetCardState createState() => _PetCardState();
}

class _PetCardState extends State<PetCard> {
  TextEditingController _petNickNameController = TextEditingController(); //宠物昵称
  TextEditingController _petVarietyController = TextEditingController(); //宠物品种
  TextEditingController _petColorController = TextEditingController(); //宠物颜色
  NewHousePetInfo _petInfo;

  @override
  void initState() {
    super.initState();
    _initData();

    if (widget.editable != 2) {
      _setListener();
    }
  }

  void _initData() {
    _petInfo = widget.model?.newHousePetInfoList[widget.index];

      _petNickNameController.text = _petInfo?.petNickName;
      _petVarietyController.text = _petInfo?.petVariety;
      _petColorController.text = _petInfo?.petColor;

  }

  void _setListener() {
    _petNickNameController.addListener(() {
      _petInfo.petNickName = _petNickNameController.text;
    });
    _petVarietyController.addListener(() {
      _petInfo.petVariety = _petVarietyController.text;
    });
    _petColorController.addListener(() {
      _petInfo.petColor = _petColorController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
//    _initData();
    return Container(
      color: UIData.primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            color: UIData.scaffoldBgColor,
            child: ListTile(
              contentPadding: EdgeInsets.only(left: UIData.spaceSize16),
              dense: true,
              title: Container(
                  child: CommonText.darkGrey15Text('宠物${widget.model.newHousePetInfoList.indexOf(_petInfo) + 1}')),
              trailing: widget.editable != 2
                  ? Offstage(
                      offstage: widget.index == 0,
                      child: IconButton(
                          icon: UIData.iconCloseOutline,
                          onPressed: () {
                            if (widget.callback != null)
                              widget.callback(widget.model.newHousePetInfoList.indexOf(_petInfo));
                          }))
                  : null,
            ),
          ),
          CommonDivider(),
          CommonSelectSingleRow(
            '宠物昵称',
            content: CommonTextField(
                hintText: widget.editable == 2 ? '' : null,
                controller: _petNickNameController,
                enabled: widget.editable != 2),
            arrowVisible: false,
          ),
          CommonDivider(),
          CommonSelectSingleRow(
            '种类及品种',
            content:CommonTextField(
                hintText: widget.editable == 2 ? '' : null,
                controller: _petVarietyController,
                enabled: widget.editable != 2),
            arrowVisible: false,
          ),
          CommonDivider(),
          CommonSelectSingleRow(
            '颜色',
            content: CommonTextField(
                hintText: widget.editable == 2 ? '' : null,
                controller: _petColorController,
                enabled: widget.editable != 2),
            arrowVisible: false,
          ),
          CommonDivider(),
          //是否办理证件:0-否，1-是
          CommonSelectSingleRow(
            '办理证件',
            content: widget.editable == 2
                ? (_petInfo.isPetCertificated == '1' ? '是' : '否')
                : Row(
                    children: <Widget>[
                      CommonRadio(
                          text: '是',
                          value: '1',
                          groupValue: _petInfo.isPetCertificated,
                          onChanged: (String value) {
                            setState(() {
                              _petInfo.isPetCertificated = value;
                            });
                          }),
                      SizedBox(width: UIData.spaceSize16),
                      //不是托收就存XJ-现金
                      CommonRadio(
                          text: '否',
                          value: '0',
                          groupValue: _petInfo.isPetCertificated,
                          onChanged: (String value) {
                            setState(() {
                              _petInfo.isPetCertificated = value;
                            });
                          }),
                    ],
                  ),
            arrowVisible: false,
          ),
          CommonDivider(),
          Container(
            padding: EdgeInsets.only(left: UIData.spaceSize16, top: UIData.spaceSize16),
            child: CommonText.darkGrey15Text('附件（宠物照片/证件资料）'),
          ),
          widget.editable == 2
              ? Container(
                  padding: EdgeInsets.only(
                      bottom: UIData.spaceSize12,
                      top: UIData.spaceSize8,
                      left: UIData.spaceSize16,
                      right: UIData.spaceSize16),
                  child: CommonImageDisplay(
                      photoIdList: _petInfo.petAttachmentList
                          ?.map((Attachment attach) => attach?.attachmentUuid)
                          ?.toList()),
                )
              : Container(
                  margin: EdgeInsets.all(UIData.spaceSize16),
                  child: CommonImagePicker(
                    attachmentList: _petInfo.petAttachmentList,
                    callbackWithInfo: (List<Attachment> images) {
                      if (_petInfo.petAttachmentList == null)
                        _petInfo.petAttachmentList = List();
                      else
                        _petInfo.petAttachmentList.clear();
                      _petInfo.petAttachmentList.addAll(images);
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
