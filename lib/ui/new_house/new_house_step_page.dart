import 'dart:convert';

import 'package:cmp_customer/models/new_house_model.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/scoped_models/new_house_state_model.dart';
import 'package:cmp_customer/ui/common/car_number_input_keyboard.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_dialog.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'new_house_car_info_content.dart';
import 'new_house_common_ui.dart';
import 'new_house_cust_info_content.dart';
import 'new_house_content_stepview1.dart';
import 'new_house_list_Page.dart';
import 'new_house_list_page_tab.dart';
import 'new_house_pet_info_content.dart';

///
/// Created by qianlx on 2020/3/25 3:30 PM.
/// 新房入伙步骤页面
/// 新建、编辑、补充
/// [editable] 是否可编辑，0-全部可编辑，1-选填可编辑，2-不可编辑
///
class NewHouseStepPage extends StatefulWidget {
  final NewHouseDetail newHouseDetail;
  final int editable;

  NewHouseStepPage(this.editable, {this.newHouseDetail});

  @override
  _NewHouseStepPageState createState() => _NewHouseStepPageState();
}

class _NewHouseStepPageState extends State<NewHouseStepPage> {
  int step = 0;
  NewHouseStateModel _model = new NewHouseStateModel();
  NewHouseDetail _newHouseDetail;
  ScrollController _loadMoreScrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() {
    if (widget.newHouseDetail != null)
      _newHouseDetail = NewHouseDetail.fromJson(jsonDecode(jsonEncode(widget.newHouseDetail.toJson())));
    else {
      _newHouseDetail = NewHouseDetail(); //新增
    }
  }

  bool checkData(NewHouseDetail info) {
    String tips = '';
    switch (step) {
      case 0:
        //业主信息
        if (StringsHelper.isEmpty(_newHouseDetail.custName)) {
          tips = '请填写姓名';
        } else if (StringsHelper.isEmpty(_newHouseDetail.custPhone)) {
          tips = '请填写联系电话';
        } else if (StringsHelper.isEmpty(_newHouseDetail.idTypeId)) {
          tips = '请选择证件类型';
        } else if (StringsHelper.isEmpty(_newHouseDetail.custIdNum)) {
          tips = '请填写证件号码';
        } else if (_newHouseDetail.relatedAttachmentList == null ||
            _newHouseDetail.relatedAttachmentList.length == 0) {
          tips = '请上传附件信息（身份证、证件照等照片）';
        } else if (_newHouseDetail.relatedAttachmentList != null &&
            _newHouseDetail.relatedAttachmentList.any((Attachment att) => att == null)) {
          tips = '附件信息图片尚未上传完成，请稍候';
        } else if (StringsHelper.isEmpty(_newHouseDetail.projectId?.toString() ?? '')) {
          tips = '请选择社区';
        } else if (StringsHelper.isEmpty(_newHouseDetail.houseId?.toString() ?? '')) {
          tips = '请选择房屋';
        } else if (StringsHelper.isEmpty(_newHouseDetail.scheduleDate)) {
          tips = '请选择入伙日期';
        } else if (_newHouseDetail.confirmPhotoList == null || _newHouseDetail.confirmPhotoList.length == 0) {
          tips = '请上传入伙确认函';
        } else if (_newHouseDetail.confirmPhotoList != null &&
            _newHouseDetail.confirmPhotoList.any((Attachment att) => att == null)) {
          tips = '入伙确认函图片尚未上传完成，请稍候';
        }
        break;
      case 1:
        if (StringsHelper.isNotEmpty(_newHouseDetail.email) && !StringsHelper.isEMail(_newHouseDetail.email)) {
          tips = '请输入正确邮箱地址';
        } else if (_newHouseDetail.payType == newHousePayTypeTS) {
          if (StringsHelper.isEmpty(_newHouseDetail.accountName)) {
            tips = '请填写账号名';
          } else if (StringsHelper.isEmpty(_newHouseDetail.bankAccount)) {
            tips = '请填写银行账号';
          } else if (StringsHelper.isEmpty(_newHouseDetail.bank)) {
            tips = '请填写开户银行';
          } else if (_newHouseDetail.bankCollectAttachmentList == null ||
              _newHouseDetail.bankCollectAttachmentList.length == 0) {
            tips = '请上传银行卡复印件';
          } else if (_newHouseDetail.bankCollectAttachmentList != null &&
              _newHouseDetail.bankCollectAttachmentList.any((Attachment att) => att == null)) {
            tips = '银行卡复印件图片尚未上传完成，请稍候';
          }
        }
        break;
      case 2:
        if (_newHouseDetail.newHouseCarInfoList != null || _newHouseDetail.newHouseCarInfoList.length != 0) {
          //    this.carAttachmentList,
          //    this.carBrand,
          //    this.carColor,
          //    this.carId,
          //    this.carSize,
          //    this.houseJoinId,
          //    this.plateNumber,
          //    this.remark,
          _newHouseDetail.newHouseCarInfoList.forEach((NewHouseCarInfo info) {
            if (StringsHelper.isNotEmpty(info.carBrand) ||
                StringsHelper.isNotEmpty(info.carColor) ||
                StringsHelper.isNotEmpty(info.carSize) ||
                (info.carAttachmentList != null && info.carAttachmentList.length > 0)) {
              if (StringsHelper.isEmpty(info.plateNumber)) {
                tips = '请填写车牌号';
                return;
              }
            }
          });
          if (StringsHelper.isNotEmpty(tips)) {
            break;
          }
          _newHouseDetail.newHouseCarInfoList.removeWhere((NewHouseCarInfo info) {
            return StringsHelper.isEmpty(info.carBrand) &&
                StringsHelper.isEmpty(info.carColor) &&
                StringsHelper.isEmpty(info.carSize) &&
                StringsHelper.isEmpty(info.plateNumber) &&
                (info.carAttachmentList == null || info.carAttachmentList.length == 0);
          });
//          tips = '请上传入伙确认函';
        }
        break;
      case 3:
        _newHouseDetail.newHousePetInfoList.removeWhere((NewHousePetInfo info) {
          return (StringsHelper.isEmpty(info.isPetCertificated)||info.isPetCertificated=='0') &&StringsHelper.isEmpty(info.remark) &&
              StringsHelper.isEmpty(info.petVariety) &&
              StringsHelper.isEmpty(info.petColor) &&
              StringsHelper.isEmpty(info.petNickName) &&
              (info.petAttachmentList == null || info.petAttachmentList.length == 0);
        });
        break;
    }
    if (StringsHelper.isNotEmpty(tips)) {
      CommonToast.show(type: ToastIconType.INFO, msg: tips);
      return false;
    } else {
      return true;
    }
  }

  Widget _buildCarNoKeyboard() {
    return ScopedModelDescendant<NewHouseStateModel>(builder: (context, child, model) {
//      LogUtils.printLog('车牌号1：${model.newHouseCarInfo?.plateNumber}');
      return Theme(
          data: Theme.of(context).copyWith(),
          child: Material(
            color: Colors.transparent,
            child: Offstage(
              offstage: !_model.showCarNoInputView,
              child: CarNoInputKeyboard(
                key: _model.carNoInputKey,
                carNo: _model.newHouseCarInfo?.plateNumber ?? '',
                onCancel: () {
                  setState(() {
                    _model.showCarNoInputView = false;
                  });
                },
                onConfirm: (String carNo) {
                  if (!StringsHelper.isCarNo(carNo)) {
                    CommonToast.show(msg: '请输入正确车牌号', type: ToastIconType.INFO);
                  } else {
//                  setState(() {
//                    _model.showCarNoInputView = false;
                    _model.setCarNo(carNo);
//                  });
                  }
                },
              ),
            ),
          ));
    });
  }

  Widget getBottomNavigationBar(NewHouseStateModel model) {
    if (step == 0) {
      return StadiumSolidButton(
        step == 3 ? '提交' : "下一步",
        enable: _model.newHouseCommitState == ListState.HINT_DISMISS,
        onTap: () {
          if (checkData(_newHouseDetail)) {
            if (step < 3) {
              _loadMoreScrollController.animateTo(0, duration: new Duration(seconds: 1), curve: Curves.ease);
              setState(() {
                step++;
              });
            } else {
//                      ///调接口
              if (widget.newHouseDetail?.houseJoinId != null) {
                //修改

                model.newHouseIsPass(_newHouseDetail.toJson(), newHouseType: NewHouseHttpType.UPDATA);
              } else {
                //新建
                model.newHouseIsPass(_newHouseDetail.toJson(), newHouseType: NewHouseHttpType.SAVE);
              }
            }
          }
        },
      );
    } else if (step > 0) {
      return StadiumSolidWithTowButton(
        cancelText: '上一步',
        conFirmEnable: _model.newHouseCommitState == ListState.HINT_DISMISS,
        conFirmText: step == 3 ? '提交' : "下一步",
        onCancel: () {
          if (step > 0) {
            _loadMoreScrollController.animateTo(0, duration: new Duration(seconds: 1), curve: Curves.ease);
            setState(() {
              step = step - 1;
            });
          }
        },
        onConFirm: () {
          if (checkData(_newHouseDetail)) {
            if (step < 3) {
              _loadMoreScrollController.animateTo(0, duration: new Duration(seconds: 1), curve: Curves.ease);
              setState(() {
                step++;
              });
            } else {
//                      ///调接口
              if (widget.newHouseDetail?.houseJoinId != null) {
                //修改

                model.newHouseIsPass(_newHouseDetail.toJson(), newHouseType: NewHouseHttpType.UPDATA);
              } else {
                //新建
                model.newHouseIsPass(_newHouseDetail.toJson(), newHouseType: NewHouseHttpType.SAVE);
              }
            }
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModel<NewHouseStateModel>(
        model: _model,
        child: ScopedModelDescendant<NewHouseStateModel>(builder: (context, child, model) {
          return Stack(
            children: <Widget>[
              CommonScaffold(
                onWillPop: () {
                  CommonDialog.showAlertDialog(context,
                      content: _newHouseDetail.houseJoinId != null ? '放弃编辑？' : '放弃申请？', onConfirm: () {
                    Navigate.closePage();
                  }, negativeBtnText: '我再看看');
                },
                popBack: () {
                  CommonDialog.showAlertDialog(context,
                      content: _newHouseDetail.houseJoinId != null ? '放弃编辑？' : '放弃申请？', onConfirm: () {
                    Navigate.closePage();
                  }, negativeBtnText: '我再看看');
                },
                appTitle: "新房入伙申请",
                appBarActions: <Widget>[
                  Visibility(
                    visible: widget.editable == 0,
                    child: FlatButton(
                      onPressed: () {
                        Navigate.toNewPage(NewHouseInfoListTabPage(_model));
                      },
                      child: Container(
                          alignment: Alignment.centerRight,
                          child:
                              CommonText.text15("申请列表", color: UIData.themeBgColor, textAlign: TextAlign.center)),
                    ),
                  ),
                ],
                bodyData: _buildContent(),
                bottomNavigationBar: getBottomNavigationBar(model),
              ),
              _buildCarNoKeyboard()
            ],
          );
        }));
  }

  Widget _buildContent() {
    return ScopedModelDescendant<NewHouseStateModel>(builder: (context, child, model) {
      return SingleChildScrollView(
        controller: _loadMoreScrollController,
        child: Column(children: <Widget>[
          Container(
            color: UIData.primaryColor,
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(
              bottom: UIData.spaceSize12,
            ),
            padding: EdgeInsets.only(
                top: UIData.spaceSize16,
                bottom: UIData.spaceSize16,
                left: UIData.spaceSize20,
                right: UIData.spaceSize20),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(child: Container()),
                          Container(
                            height: UIData.spaceSize14,
                            width: UIData.spaceSize14,
                            child: Image.asset(step >= 0 ? UIData.iconRedCircle : UIData.iconRedCircle2),
                          ),
                          Expanded(
                              child: Container(
                            color: step > 0 ? UIData.redColor : UIData.lightestRedColor,
                            height: 1,
                          )),
                        ],
                      ),
                      SizedBox(
                        height: UIData.spaceSize8,
                      ),
                      step >= 0 ? CommonText.grey14Text('基本信息') : CommonText.lightGrey14Text('基本信息'),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                              child: Container(
                            color: step >= 1 ? UIData.redColor : UIData.lightestRedColor,
                            height: 1,
                          )),
                          Container(
                            height: UIData.spaceSize14,
                            width: UIData.spaceSize14,
                            child: Image.asset(step >= 1 ? UIData.iconRedCircle : UIData.iconRedCircle2),
                          ),
                          Expanded(
                              child: Container(
                            color: step >= 2 ? UIData.redColor : UIData.lightestRedColor,
                            height: 1,
                          )),
                        ],
                      ),
                      SizedBox(
                        height: UIData.spaceSize8,
                      ),
                      step >= 1 ? CommonText.grey14Text('业主信息') : CommonText.lightGrey14Text('业主信息'),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                              child: Container(
                            color: step >= 2 ? UIData.redColor : UIData.lightestRedColor,
                            height: 1,
                          )),
                          Container(
                            height: UIData.spaceSize14,
                            width: UIData.spaceSize14,
                            child: Image.asset(step >= 2 ? UIData.iconRedCircle : UIData.iconRedCircle2),
                          ),
                          Expanded(
                              child: Container(
                            color: step > 2 ? UIData.redColor : UIData.lightestRedColor,
                            height: 1,
                          )),
                        ],
                      ),
                      SizedBox(
                        height: UIData.spaceSize8,
                      ),
                      step >= 2 ? CommonText.grey14Text('车辆信息') : CommonText.lightGrey14Text('车辆信息'),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                              child: Container(
                            color: step >= 3 ? UIData.redColor : UIData.lightestRedColor,
                            height: 1,
                          )),
                          Container(
                            height: UIData.spaceSize14,
                            width: UIData.spaceSize14,
                            child: Image.asset(step >= 3 ? UIData.iconRedCircle : UIData.iconRedCircle2),
                          ),
                          Expanded(child: Container()),
                        ],
                      ),
                      SizedBox(
                        height: UIData.spaceSize8,
                      ),
                      step >= 3 ? CommonText.grey14Text('宠物信息') : CommonText.lightGrey14Text('宠物信息'),
                    ],
                  ),
                ),
              ],
            ),
          ),

          ///基本信息

          Visibility(
            visible: step == 0,
            child: NewHouseContentStepview1(widget.editable, _newHouseDetail),
          ),

          ///业主信息
          Visibility(visible: step == 1, child: NewHouseCustInfoContent(widget.editable, _newHouseDetail)),

          ///车辆信息
          Visibility(
              visible: step == 2,
              child: NewHouseCarInfoContent(
                widget.editable,
                _newHouseDetail,
                _model,
              )),

          ///宠物信息
          Visibility(visible: step == 3, child: NewHousePetInfoContent(widget.editable, _newHouseDetail)),
        ]),
      );
    });
  }
}
