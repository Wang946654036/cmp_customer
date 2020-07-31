import 'package:cmp_customer/models/decoration_obj.dart';
import 'package:cmp_customer/models/project_setting_model.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/scoped_models/decoration_model.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_image_picker.dart';
import 'package:cmp_customer/ui/common/common_picker.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_text_field.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/common/select_house_from_project_page.dart';
import 'package:cmp_customer/ui/decorate_manager/decoration_permit/decoration_apply_tips.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_state.dart';
import 'package:cmp_customer/ui/work_other/add_worker.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:cmp_customer/main.dart';
import '../decoration_ui.dart';

class DecorationCheckApply extends StatefulWidget {
  DecorationModel model = new DecorationModel();
  DecorationInfo decorationInfo;

  DecorationCheckApply({this.decorationInfo, this.model});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DecorationApplyCreateState();
  }
}

class _DecorationApplyCreateState extends State<DecorationCheckApply> {
  DecorationInfo info;

  TextEditingController feeController = TextEditingController();
  TextEditingController checkDescController = TextEditingController();

  TextEditingController _managerController = TextEditingController();

//  TextEditingController _managerIdCardController = TextEditingController();
  TextEditingController _managerPhoneController = TextEditingController();


  //初始化数据，修改申请把加入详情数据，新建申请则初始化对象
  void _initData() {
    if (widget.decorationInfo != null) {
      info = widget.decorationInfo;
      if (info.decorateAcceptanceVo == null) {
        info.decorateAcceptanceVo = new DecorateAcceptanceVo(
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null);
      }
      if (info.decorateAcceptanceVo.checkPhotos == null)
        info.decorateAcceptanceVo.checkPhotos = new List();
      info.decorateAcceptanceVo.applyId = info.id;
      info.decorateAcceptanceVo.custId = stateModel.customerId;

      feeController.text =
          widget.decorationInfo.decorateAcceptanceVo.price?.toString() ?? '';
      checkDescController.text =
          widget.decorationInfo.decorateAcceptanceVo.checkDesc;

      _managerController.text = widget.decorationInfo?.decorateAcceptanceVo?.manager ?? '';
      info.decorateAcceptanceVo.manager = widget.decorationInfo?.decorateAcceptanceVo?.manager ?? '';
//      _managerIdCardController.text = widget.decorationInfo.managerIdCard ?? '';
      _managerPhoneController.text = widget.decorationInfo?.decorateAcceptanceVo?.managerPhone ?? '';
      info.decorateAcceptanceVo.managerPhone = widget.decorationInfo?.decorateAcceptanceVo?.managerPhone ?? '';

    } else {
      widget.decorationInfo = DecorationInfo();
    }

    if (widget.decorationInfo.decorateType == null) {
      widget.decorationInfo.decorateType = 1;
    }

    feeController.addListener((){
      widget.decorationInfo.decorateAcceptanceVo.price = feeController.text;
    });
    checkDescController.addListener(() {
      info.decorateAcceptanceVo.checkDesc = checkDescController.text;
    });

    _managerController.addListener(() {
      info.decorateAcceptanceVo.manager = _managerController.text;
    });
//    _managerIdCardController.addListener((){
//      info.managerIdCard =_managerIdCardController.text;
//    });
    _managerPhoneController.addListener(() {
      info.decorateAcceptanceVo.managerPhone = _managerPhoneController.text;
    });

  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModel<DecorationModel>(
        model: widget.model,
        child: ScopedModelDescendant<DecorationModel>(
            builder: (context, child, model) {
          return CommonScaffold(
              appTitle: "验收申请",
              bodyData: _buildContent(),
              bottomNavigationBar: StadiumSolidButton(
                '提交申请',
                onTap: () {

                  if(info.decorateAcceptanceVo.id==null) {
                    Map<String, dynamic> map = info.decorateAcceptanceVo
                        .toJson();
                    model.decorationIsPass(map,
                        decorationType: DecorationHttpType.ACCEPTANCE,callback: (){
                          Navigate.closePage(true);
                        });
                  }else{
                    if (info.decorateAcceptanceVo.operationCust == null) {
                      info.decorateAcceptanceVo.operationCust =
                          stateModel.customerId;
                    }
                    info.decorateAcceptanceVo.status = '1';
                    info.decorateAcceptanceVo.checkRole = info.decorateAcceptanceVo.bpmCurrentRole;
//                    info.decorateAcceptanceVo.acceptanceId=info.acceptanceId;
//                    info.decorateAcceptanceVo.acceptanceCheckRole=info.acceptanceCheckRole;
                    Map<String, dynamic> map = info.decorateAcceptanceVo
                        .toJson();
                    model.decorationIsPass(map,
                        decorationType: DecorationHttpType.UPDATAACCEPTANCE,callback: (){
                          Navigate.closePage(true);
                        });
                  }
                },
              ));
        }));
  }

  Widget _buildContent() {
    return ScopedModelDescendant<DecorationModel>(
        builder: (context, child, model) {
      return SingleChildScrollView(
        child: Column(children: <Widget>[
          Container(
              color: UIData.primaryColor,
              padding: EdgeInsets.only(bottom: UIData.spaceSize12,top: UIData.spaceSize12),
              child: Column(children: <Widget>[
                leftTextWidget(
                  text: '申请基本信息',
                  color: UIData.greyColor,
                  fontSize: UIData.fontSize17,
                ),
                labelTextWidget(
                  label: houseName,
                  text: info.houseName ?? "",
                  topSpacing: UIData.spaceSize12,
                ),
                labelTextWidget(
                  label: programName,
                  text: info.programName ?? "",
                  topSpacing: UIData.spaceSize12,
                  bottomSpacing: UIData.spaceSize12,
                ),
CommonDivider(),
                feeInputWidget(
                  feeController,
                  label: price,
                  unit: '万元',
                  hint_text: '请输入',
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: UIData.spaceSize16,
                      vertical: UIData.spaceSize12),
                  color: Colors.white,
                  child: GestureDetector(
                    onTap: () {
                      CommonPicker.datePickerModal(context,
                          type: PickerDateTimeType.kYMD,
                          needTime: true, onConfirm: (String date) {
                        setState(() {
                          info.decorateAcceptanceVo.checkDate = date.split(' ')[0];
                        });
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        CommonText.darkGrey15Text('预约'+checkDate),
                        SizedBox(
                          width: UIData.spaceSize30,
                        ),
                        Expanded(
                            child: (info.decorateAcceptanceVo?.checkDate ==
                                        null ||
                                    info.decorateAcceptanceVo?.checkDate == '')
                                ? CommonText.lightGrey15Text('请选择（必填）')
                                : CommonText.darkGrey15Text(
                                    info.decorateAcceptanceVo.checkDate)),
                        Icon(
                          Icons.keyboard_arrow_right,
                          color: UIData.iconGreyColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ])),

//施工单位信息
          Container(
              color: UIData.primaryColor,
              margin: EdgeInsets.only(top: UIData.spaceSize12),
              padding: EdgeInsets.only(bottom: UIData.spaceSize12,top: UIData.spaceSize12),
              child: Column(children: <Widget>[
                leftTextWidget(
                  text: '施工单位信息',
                  color: UIData.greyColor,
                  fontSize: UIData.fontSize17,
                ),
                CommonSingleInputRow(
                  manager,
                  titleWidth: 87,
                  content: TextField(
                    controller: _managerController,
                    style: CommonText.darkGrey15TextStyle(),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText:'请输入',
                      hintStyle: CommonText.lightGrey15TextStyle(),
                      isDense: true,
                    ),
                  ),
                  arrowVisible: false,
                ),
                CommonSingleInputRow(
                  managerPhone,
                  titleWidth: 87,
                  content: TextField(
                    controller: _managerPhoneController,
                    style: CommonText.darkGrey15TextStyle(),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '请输入',
                      hintStyle: CommonText.lightGrey15TextStyle(),
                      isDense: true,
                    ),
                  ),
                  arrowVisible: false,
                ),
//                    CommonSingleInputRow(
//                      managerIdCard,
//                      titleWidth:87,
//                      content: TextField(
//                        controller: _managerIdCardController,
//                        style: CommonText.darkGrey15TextStyle(),
//                        decoration: InputDecoration(
//                          border: InputBorder.none,
//                          hintText: info?.decorateType == 1
//                              ? '请输入(必填)'
//                              : '请输入',
//                          hintStyle: CommonText.lightGrey15TextStyle(),
//                          isDense: true,
//                        ),
//                      ),
//                      arrowVisible: false,
//                    ),
//                    Container(
//                      //上传照片
//                        color: Colors.white,
//                        child: Column(
//                          children: <Widget>[
//                            leftTextWidget(
//                                text: "负责人身份证照", topSpacing: UIData.spaceSize16),
//                            Container(
//                              margin: EdgeInsets.all(UIData.spaceSize16),
//                              child: CommonImagePicker(
//                                attachmentList: widget
//                                    .decorationInfo?.managerIdCardPhotos,callbackWithInfo: (List<Attachment>list){
//                                info?.managerIdCardPhotos = list;
//                              },),
//                            )
//                          ],
//                        )),

                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: UIData.spaceSize16,
                      vertical: UIData.spaceSize12),
                  color: Colors.white,
                  child: GestureDetector(
                    onTap: () {
                      CommonPicker.datePickerModal(context,
                          type: PickerDateTimeType.kYMD,
                          needTime: true, onConfirm: (String date) {
                        setState(() {
                          info.decorateAcceptanceVo.finishDate =
                              date.split(' ')[0];
                        });
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        CommonText.darkGrey15Text(finishDate),
                        SizedBox(
                          width: UIData.spaceSize30,
                        ),
                        Expanded(
                            child: (info.decorateAcceptanceVo?.finishDate ==
                                        null ||
                                    info.decorateAcceptanceVo.finishDate == '')
                                ? CommonText.lightGrey15Text('请选择（必填）')
                                : CommonText.darkGrey15Text(
                                    info.decorateAcceptanceVo.finishDate)),
                        Icon(
                          Icons.keyboard_arrow_right,
                          color: UIData.iconGreyColor,
                        ),
                      ],
                    ),
                  ),
                ),

                Container(
                  padding: EdgeInsets.only(bottom: UIData.spaceSize12),
                  color: UIData.primaryColor,
                  child: Column(
                    children: <Widget>[
                      leftTextWidget(
                        text: checkDesc,
                        color: UIData.greyColor,
                        topSpacing: UIData.spaceSize12,
                      ),
                      inputWidget(
                        checkDescController,
                        hint_text: "请输入（必填）",
                        maxLength: 200,
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: UIData.spaceSize16,
                      vertical: UIData.spaceSize12),
                  color: Colors.white,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push<CommonMap>(
                          MaterialPageRoute(builder: (context) {
                        return AddWorker(quality, '1',
                            (List<CommonMap> commonMaps) {
                          commonMaps.clear();
                          for (int i = 1; i < 5; i++) {
                            CommonMap cm =
                                new CommonMap(i, getQualityString(i));
                            commonMaps.add(cm);
                          }
                        },alwaysShow: true,);
                      })).then((CommonMap commonMap) {
                        if (commonMap != null)
                          setState(() {
                            info.decorateAcceptanceVo.quality =
                                commonMap.complaintPropertyId;
                          });
                      });
                    },
                    child: Row(
                      children: <Widget>[
                        CommonText.darkGrey15Text(quality),
                        SizedBox(
                          width: UIData.spaceSize30,
                        ),
                        Expanded(
                            child: (info.decorateAcceptanceVo?.quality == null)
                                ? CommonText.lightGrey15Text('请选择')
                                : CommonText.darkGrey15Text(getQualityString(
                                    info.decorateAcceptanceVo?.quality))),
                        Icon(
                          Icons.keyboard_arrow_right,
                          color: UIData.iconGreyColor,
                        ),
                      ],
                    ),
                  ),
                ),

                Container(
                    //上传照片
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        leftTextWidget(
                            text: "附件上传：身份证、建筑图纸等以及其他图片",
                            topSpacing: UIData.spaceSize16),
                        Container(
                          margin: EdgeInsets.all(UIData.spaceSize16),
                          child: CommonImagePicker(
                            attachmentList: info?.decorateAcceptanceVo?.checkPhotos??[],
                            callbackWithInfo: (List<Attachment> list) {
                              info.decorateAcceptanceVo.checkPhotos= list;
                            },
                          ),
                        )
                      ],
                    )),
              ])),

          GestureDetector(
            onTap: () {
              Navigate.toNewPage(
                  DecorationApplyTips(title: '装修办理业务附件上传说明', data: apply_tips));
            },
            child: leftTextWidget(
              text: '*温馨提示：装修办理业务附件上传说明',
              color: UIData.underlineBlueColor,
              textDecoration: TextDecoration.underline,
              fontSize: UIData.fontSize15,
              topSpacing: UIData.spaceSize12,
            ),
          ),
        ]),
      );
    });
  }

  bool checkData(DecorationInfo info) {
    String tips = '';

if(StringsHelper.isEmpty(info.decorateAcceptanceVo.checkDate)){
  tips = checkDate;
}
    if(StringsHelper.isEmpty(info.decorateAcceptanceVo.finishDate)){
      tips = finishDate;
    }
    if (StringsHelper.isEmpty(checkDescController.text)) {
      tips = checkDesc;
    }

    if (StringsHelper.isNotEmpty(tips)) {
      CommonToast.show(type: ToastIconType.INFO, msg: '请填写${tips}');
      return false;
    } else {
      return true;
    }
  }

  List<String> getFileList(List<Attachment> attFileList) {
    List<String> strs = new List();
    if (attFileList != null)
      attFileList.forEach((info) {
        strs.add(info?.attachmentUuid);
      });
    return strs;
  }
}
