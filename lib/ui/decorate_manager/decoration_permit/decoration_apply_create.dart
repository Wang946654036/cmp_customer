import 'package:cmp_customer/models/decoration_obj.dart';
import 'package:cmp_customer/models/project_setting_model.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/scoped_models/decoration_model.dart';
import 'package:cmp_customer/strings/strings_common.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_image_picker.dart';
import 'package:cmp_customer/ui/common/common_picker.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_text_field.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/common/copy_writing_page.dart';
import 'package:cmp_customer/ui/common/select_house_from_project_page.dart';
import 'package:cmp_customer/ui/decorate_manager/decoration_permit/decoration_apply_tips.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_state.dart';
import 'package:cmp_customer/ui/work_other/add_worker.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:cmp_customer/main.dart';
import '../decoration_ui.dart';
import 'decoration_apply_list_tab.dart';
import 'decoration_history_page.dart';

class DecorationApplyCreate extends StatefulWidget {
  DecorationModel _model = new DecorationModel();
  DecorationInfo decorationInfo;

  DecorationApplyCreate({this.decorationInfo});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DecorationApplyCreateState();
  }
}

class _DecorationApplyCreateState extends State<DecorationApplyCreate> {
  int step = 0;
  List<HouseInfo> _houseList; //默认项目下的房屋列表
  bool isOwner = false; //当前社区下房屋是否有业主身份
  String custProper;

  String owerName = '';
  TextEditingController _workPeopleNumController = TextEditingController();
  TextEditingController _workCompanyController = TextEditingController();

  TextEditingController _companyPaperNumberController = TextEditingController();
  TextEditingController _credentialNumberController = TextEditingController();
  TextEditingController _managerController = TextEditingController();
  TextEditingController _managerIdCardController = TextEditingController();
  TextEditingController _managerPhoneController = TextEditingController();
  TextEditingController _programNameController = TextEditingController();
  TextEditingController _programDescController = TextEditingController();
  List<Map> myList;

  //初始化数据，修改申请把加入详情数据，新建申请则初始化对象
  void _initData() {
    if (widget.decorationInfo != null) {
      _refreshHouseName(widget.decorationInfo);
      _workPeopleNumController.text = widget.decorationInfo.workPeopleNum?.toString() ?? '';
      _workCompanyController.text = widget.decorationInfo.workCompany ?? '';
      _companyPaperNumberController.text = widget.decorationInfo.companyPaperNumber ?? '';
      _credentialNumberController.text = widget.decorationInfo.credentialNumber ?? '';
      _managerController.text = widget.decorationInfo.manager ?? '';
      _managerIdCardController.text = widget.decorationInfo.managerIdCard ?? '';
      _managerPhoneController.text = widget.decorationInfo.managerPhone ?? '';
      _programNameController.text = widget.decorationInfo.programName ?? '';
      _programDescController.text = widget.decorationInfo.programDesc ?? '';
      owerName = widget.decorationInfo.houseCustName;
    } else {
      widget.decorationInfo = DecorationInfo();
    }
    isOwner = stateModel.customerProper == customerYZ;
    custProper = stateModel.customerProper;
    myList = [
      {'key': '装修公司', 'bool': false, 'type': '1'},
      {'key': '自装', 'bool': false, 'type': '2'}
    ];
    if (widget.decorationInfo.decorateType == null) {
      widget.decorationInfo.decorateType = 1;
    }
    if (widget.decorationInfo.decorateType == 1) {
      myList[0]['bool'] = true;
      myList[1]['bool'] = false;
    }
    if (widget.decorationInfo.decorateType == 2) {
      myList[0]['bool'] = false;
      myList[1]['bool'] = true;
    }

    _workPeopleNumController.addListener(() {
      try {
        int pn = int.parse(_workPeopleNumController.text);
        if (pn < 0) {
          CommonToast.show(type: ToastIconType.FAILED, msg: '人数不能少于0');
          setState(() {
            _workPeopleNumController.text = widget.decorationInfo.workPeopleNum?.toString() ?? '';
          });
          return;
        }
        if (pn > 99999) {
          CommonToast.show(type: ToastIconType.FAILED, msg: '人数过多');
          setState(() {
            _workPeopleNumController.text = widget.decorationInfo.workPeopleNum?.toString() ?? '';
          });
          return;
        }
        widget.decorationInfo.workPeopleNum = int.parse(_workPeopleNumController.text);
      } catch (e) {
        widget.decorationInfo.workPeopleNum = null;
      }
    });
    _workCompanyController.addListener(() {
      widget.decorationInfo.workCompany = _workCompanyController.text;
    });
    _companyPaperNumberController.addListener(() {
      widget.decorationInfo.companyPaperNumber = _companyPaperNumberController.text;
    });
    _credentialNumberController.addListener(() {
      widget.decorationInfo.credentialNumber = _credentialNumberController.text;
    });
    _managerController.addListener(() {
      widget.decorationInfo.manager = _managerController.text;
    });
    _managerIdCardController.addListener(() {
      widget.decorationInfo.managerIdCard = _managerIdCardController.text;
    });
    _managerPhoneController.addListener(() {
      widget.decorationInfo.managerPhone = _managerPhoneController.text;
    });
    _programNameController.addListener(() {
      widget.decorationInfo.programName = _programNameController.text;
    });
    _programDescController.addListener(() {
      widget.decorationInfo.programDesc = _programDescController.text;
    });
  }

  void _refreshHouseName(var info) {
    if (info is HouseInfo) {
      isOwner = info.custProper == customerYZ;
      custProper = info.custProper;
      owerName = info.custName ?? '';
      LogUtils.printLog('owerName:$owerName');
    }

    widget.decorationInfo.houseName = ((info is HouseInfo)
        ? (StringsHelper.getStringValue(info?.formerName) +
            StringsHelper.getStringValue(info?.buildName) +
            StringsHelper.getStringValue(info?.unitName) +
            StringsHelper.getStringValue(info?.houseNo))
        : StringsHelper.getStringValue(info?.houseName));
  }

  //获取当前项目下已认证的房屋列表
  void _initHouseList() {
    if (widget.decorationInfo.projectId == null) {
      widget.decorationInfo.projectId = stateModel.defaultProjectId;
    }
    stateModel.getCertifiedHouseByProject(callBack: ({List<HouseInfo> houseList, failedMsg}) {
      setState(() {
        if (failedMsg == null) {
          _houseList = houseList;
          //decorationInfo为空则为新建
          if (widget.decorationInfo == null) {
            _houseList.forEach((HouseInfo info) {
              if (info?.isDefaultHouse == '1') {
                //默认房屋
                widget.decorationInfo.houseId = info?.houseId;
                //业主成员标为业主，住户成员标为住户
                if (info?.custProper == customerYZ || info?.custProper == customerJTCY)
                  widget.decorationInfo.applyType = 1;
                else if (info?.custProper == customerZH || info?.custProper == customerZHCY)
                  widget.decorationInfo.applyType = 2;
                _refreshHouseName(info);
              }
              if (!isOwner && info?.custProper == customerYZ) {
                isOwner = true;
              }
              custProper = info.custProper;
            });
          }
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _initData();
    if (widget.decorationInfo.id == null) _initHouseList();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModel<DecorationModel>(
        model: widget._model,
        child: ScopedModelDescendant<DecorationModel>(builder: (context, child, model) {
          return CommonScaffold(
              popBack: () {
                if (step > 0) {
                  setState(() {
                    step = step - 1;
                  });
                } else {
                  Navigate.closePage();
                }
              },
              appTitle: "装修申请",
              appBarActions: <Widget>[
                Visibility(
                  visible: widget.decorationInfo.id == null,
                  child: FlatButton(
                    onPressed: () {
                      if (isOwner)
                        Navigate.toNewPage(DecorationApplyTabPage());
                      else
                        Navigate.toNewPage(DecorationHistoryPage());
                    },
                    child: Container(
                        alignment: Alignment.centerRight,
                        child: CommonText.text15("申请列表", color: UIData.themeBgColor, textAlign: TextAlign.center)),
                  ),
                ),
              ],
              bodyData: _buildContent(),
              bottomNavigationBar: StadiumSolidButton(
                step == 3 ? '提交' : "下一步",
                onTap: () {
                  if (checkData(widget.decorationInfo)) {
                    if (step < 3) {
                      setState(() {
                        step++;
                      });
                    } else {
                      if (widget.decorationInfo.custId == null) {
                        widget.decorationInfo.custId = stateModel.customerId;
                      }
                      if (widget.decorationInfo.applyType == null) {
                        if (isOwner || custProper == customerJTCY) {
                          widget.decorationInfo.applyType = 1;
                        } else {
                          widget.decorationInfo.applyType = 2;
                        }
                      }

                      ///调接口
                      if (widget.decorationInfo?.id != null) {
                        //修改
                        if (widget.decorationInfo.operationCust == null) {
                          widget.decorationInfo.operationCust = stateModel.customerId;
                        }
                        model.decorationIsPass(widget.decorationInfo.toJson(),
                            decorationType: DecorationHttpType.UPDATA);
                      } else {
                        //新建

                        model.decorationIsPass(widget.decorationInfo.toJson(),
                            decorationType: DecorationHttpType.SAVE);
                      }
                    }
                  }
                },
              ));
        }));
  }

  Widget _buildContent() {
    return ScopedModelDescendant<DecorationModel>(builder: (context, child, model) {
      return SingleChildScrollView(
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
                      step >= 0 ? CommonText.grey14Text('第一步') : CommonText.lightGrey14Text('第一步'),
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
                      step >= 1 ? CommonText.grey14Text('第二步') : CommonText.lightGrey14Text('第二步'),
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
                      step >= 2 ? CommonText.grey14Text('第三步') : CommonText.lightGrey14Text('第三步'),
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
                      step >= 3 ? CommonText.grey14Text('第四步') : CommonText.lightGrey14Text('第四步'),
                    ],
                  ),
                ),
              ],
            ),
          ),

          ///第一步

          Visibility(
            visible: step == 0,
            child: Container(
                color: UIData.primaryColor,
                padding: EdgeInsets.only(top: UIData.spaceSize12, bottom: UIData.spaceSize12),
                child: Column(children: <Widget>[
                  leftTextWidget(
                    text: '申请基本信息',
                    color: UIData.greyColor,
                    fontSize: UIData.fontSize17,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize16, vertical: UIData.spaceSize12),
                    color: Colors.white,
                    child: GestureDetector(
                      onTap: () {
                        if (widget.decorationInfo.id == null) {
                          if (_houseList != null && _houseList.length > 0)
                            Navigate.toNewPage(
                                SelectHouseFromProjectPage(_houseList, widget.decorationInfo?.houseId),
                                callBack: (HouseInfo houseinfo) {
                              setState(() {
                                if (houseinfo != null) {
                                  _refreshHouseName(houseinfo);
                                  LogUtils.printLog('houseId:${houseinfo?.houseId}');
                                  widget.decorationInfo?.houseId = houseinfo?.houseId;
//                                      if(houseinfo?.custId==stateModel.customerId){
//                                        isOwner=true;
//                                      }else{
//                                        isOwner=false;
//                                      }
                                }
                              });
                            });
                        }
                      },
                      child: Row(
                        children: <Widget>[
                          CommonText.darkGrey15Text('房屋        '),
                          SizedBox(
                            width: UIData.spaceSize30,
                          ),
                          Expanded(
                              child: (StringsHelper.isEmpty(widget.decorationInfo.houseName ?? ''))
                                  ? CommonText.lightGrey15Text(
                                      _houseList != null ? '请选择（必选）' : '加载中',
                                    )
                                  : CommonText.text15(widget.decorationInfo.houseName ?? '',
                                      overflow: TextOverflow.fade,
                                      color: widget.decorationInfo.id == null
                                          ? UIData.darkGreyColor
                                          : UIData.lightGreyColor)),
                          Visibility(
                              child: Icon(
                                Icons.keyboard_arrow_right,
                                color: UIData.iconGreyColor,
                              ),
                              visible: widget.decorationInfo.id == null),
                        ],
                      ),
                    ),
                  ),
                  CommonDivider(),
                  labelTextWidget(
                    label: '业主',
                    text: owerName ?? "暂无",
                    topSpacing: UIData.spaceSize12,
                    bottomSpacing: UIData.spaceSize12,
                  ),
                  CommonDivider(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: leftTextWidget(
                          text: decorateType,
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
                  CommonDivider(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize16, vertical: UIData.spaceSize12),
                    color: Colors.white,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push<CommonMap>(MaterialPageRoute(builder: (context) {
                          return AddWorker('预计工期', '1', (List<CommonMap> commonMaps) {
                            stateModel.queryProjectSettingDetail(callBack: (List<SettingVoList> settingVoLists) {
                              settingVoLists.forEach((SettingVoList info) {
                                commonMaps.add(CommonMap(info.code, info.name));
                              });
                            });
                          });
                        })).then((CommonMap commonMap) {
                          if (commonMap != null)
                            setState(() {
                              widget.decorationInfo?.workDayLong = int.parse(commonMap.complaintPropertyId);
                            });
                        });
                      },
                      child: Row(
                        children: <Widget>[
                          CommonText.darkGrey15Text('预计工期'),
                          SizedBox(
                            width: UIData.spaceSize30,
                          ),
                          Expanded(
                              child: (StringsHelper.isEmpty(widget.decorationInfo?.workDayLong?.toString() ?? ''))
                                  ? CommonText.lightGrey15Text('请选择（必填）')
                                  : CommonText.darkGrey15Text(
                                      (widget.decorationInfo?.workDayLong?.toString() ?? '') + '天')),
                          Icon(
                            Icons.keyboard_arrow_right,
                            color: UIData.iconGreyColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  CommonDivider(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize16, vertical: UIData.spaceSize12),
                    color: Colors.white,
                    child: GestureDetector(
                      onTap: () {
                        CommonPicker.datePickerModal(context, type: PickerDateTimeType.kYMD, needTime: true,
                            onConfirm: (String date) {
                          setState(() {
                            widget.decorationInfo?.beginWorkDate = date.split(' ')[0];
                          });
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          CommonText.darkGrey15Text('开工日期'),
                          SizedBox(
                            width: UIData.spaceSize30,
                          ),
                          Expanded(
                              child: (widget.decorationInfo?.beginWorkDate == null ||
                                      widget.decorationInfo?.beginWorkDate == '')
                                  ? CommonText.lightGrey15Text('请选择（必填）')
                                  : CommonText.darkGrey15Text(widget.decorationInfo?.beginWorkDate)),
                          Icon(
                            Icons.keyboard_arrow_right,
                            color: UIData.iconGreyColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  CommonDivider(),
                  CommonSingleInputRow(
                    workPeopleNum,
                    titleWidth: 87,
                    content: TextField(
                      controller: _workPeopleNumController,
                      style: CommonText.darkGrey15TextStyle(),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '请输入',
                        hintStyle: CommonText.lightGrey15TextStyle(),
                        isDense: true,
                      ),
                    ),
                    arrowVisible: false,
                  ),
                  CommonDivider(),
                  GestureDetector(
                    onTap: () {
                      Navigate.toNewPage(CopyWritingPage('装修办理温馨提示', CopyWritingType.TipsForDecoration));
//                          Navigate.toNewPage(DecorationApplyTips(
//                              title: '装修办理业务附件上传说明', data: apply_tips));
                    },
                    child: leftTextWidget(
                      text: '*温馨提示',
                      color: UIData.underlineBlueColor,
                      textDecoration: TextDecoration.underline,
                      fontSize: UIData.fontSize15,
                      topSpacing: UIData.spaceSize12,
                    ),
                  ),
                ])),
          ),

          ///第二步
          Visibility(
              visible: step == 1,
              child: Container(
                  color: UIData.primaryColor,
                  padding: EdgeInsets.only(bottom: UIData.spaceSize12),
                  child: Column(children: <Widget>[
                    CommonSingleInputRow(
                      workCompany,
                      titleWidth: 87,
                      content: TextField(
                        inputFormatters: [
                          //只能输入汉字或者字母或数字
                          LengthLimitingTextInputFormatter(50), //最大长度
                        ],
                        controller: _workCompanyController,
                        style: CommonText.darkGrey15TextStyle(),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: widget.decorationInfo?.decorateType == 1 ? '请输入(必填)' : '请输入',
                          hintStyle: CommonText.lightGrey15TextStyle(),
                          isDense: true,
                        ),
                      ),
                      arrowVisible: false,
                    ),
                    CommonDivider(),
                    CommonSingleInputRow(
                      companyPaperNumber,
                      titleWidth: 87,
                      content: TextField(
                        inputFormatters: [
                          //只能输入汉字或者字母或数字
                          LengthLimitingTextInputFormatter(50), //最大长度
                        ],
                        controller: _companyPaperNumberController,
                        style: CommonText.darkGrey15TextStyle(),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: widget.decorationInfo?.decorateType == 1 ? '请输入(必填)' : '请输入',
                          hintStyle: CommonText.lightGrey15TextStyle(),
                          isDense: true,
                        ),
                      ),
                      arrowVisible: false,
                    ),
                    CommonDivider(),
                    Container(
                        //上传照片
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            leftTextWidget(
                                text: widget.decorationInfo?.decorateType == 1 ? "证件照(必填)" : "证件照",
                                topSpacing: UIData.spaceSize16),
                            Container(
                              margin: EdgeInsets.all(UIData.spaceSize16),
                              child: CommonImagePicker(
                                attachmentList: widget.decorationInfo?.companyPapers,
                                callbackWithInfo: (List<Attachment> list) {
                                  widget.decorationInfo?.companyPapers = list;
                                },
                              ),
                            )
                          ],
                        )),
                    CommonDivider(),
                    CommonSingleInputRow(
                      credentialNumber,
                      titleWidth: 87,
                      content: TextField(
                        inputFormatters: [
                          //只能输入汉字或者字母或数字
                          LengthLimitingTextInputFormatter(50), //最大长度
                        ],
                        controller: _credentialNumberController,
                        style: CommonText.darkGrey15TextStyle(),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: widget.decorationInfo?.decorateType == 1 ? '请输入(必填)' : '请输入',
                          hintStyle: CommonText.lightGrey15TextStyle(),
                          isDense: true,
                        ),
                      ),
                      arrowVisible: false,
                    ),
                    CommonDivider(),
                    Container(
                        //上传照片
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            leftTextWidget(
                                text: widget.decorationInfo?.decorateType == 1 ? "资质证书(必填)" : "资质证书",
                                topSpacing: UIData.spaceSize16),
                            Container(
                              margin: EdgeInsets.all(UIData.spaceSize16),
                              child: CommonImagePicker(
                                attachmentList: widget.decorationInfo?.credentialPapers,
                                callbackWithInfo: (List<Attachment> list) {
                                  widget.decorationInfo?.credentialPapers = list;
                                },
                              ),
                            )
                          ],
                        )),
                    CommonDivider(),
                    CommonSingleInputRow(
                      manager,
                      titleWidth: 87,
                      content: TextField(
                        inputFormatters: [
                          //只能输入汉字或者字母或数字
                          LengthLimitingTextInputFormatter(20), //最大长度
                        ],
                        controller: _managerController,
                        style: CommonText.darkGrey15TextStyle(),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: widget.decorationInfo?.decorateType == 1 ? '用于办理出入证，请如实填写(必填)' : '请输入',
                          hintStyle: CommonText.lightGrey15TextStyle(),
                          isDense: true,
                        ),
                      ),
                      arrowVisible: false,
                    ),
                    CommonDivider(),
                    Container(
                        //上传照片
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            leftTextWidget(
                                text: widget.decorationInfo?.decorateType == 1
                                    ? "负责人身份证照(正反两面，必填)"
                                    : "负责人身份证照(正反两面)",
                                topSpacing: UIData.spaceSize16),
                            Container(
                              margin: EdgeInsets.all(UIData.spaceSize16),
                              child: CommonImagePicker(
                                maxCount: 2,
                                attachmentList: widget.decorationInfo?.managerIdCardPhotos,
                                callbackWithInfo: (List<Attachment> list) {
                                  widget.decorationInfo?.managerIdCardPhotos = list;
                                },
                              ),
                            )
                          ],
                        )),
                    CommonDivider(),
                    CommonSingleInputRow(
                      managerIdCard,
                      titleWidth: 87,
                      content: TextField(
                        inputFormatters: [
                          WhitelistingTextInputFormatter(RegExp("[A-Z0-9]")), //只能输入汉字或者字母或数字
                          LengthLimitingTextInputFormatter(18), //最大长度
                        ],
                        controller: _managerIdCardController,
                        style: CommonText.darkGrey15TextStyle(),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: widget.decorationInfo?.decorateType == 1 ? '请输入(必填)' : '请输入',
                          hintStyle: CommonText.lightGrey15TextStyle(),
                          isDense: true,
                        ),
                      ),
                      arrowVisible: false,
                    ),
                    CommonDivider(),
                    CommonSingleInputRow(
                      managerPhone,
                      titleWidth: 87,
                      content: TextField(
                        inputFormatters: [
                          WhitelistingTextInputFormatter(RegExp("[\-]|[0-9]")), //只能输入汉字或者字母或数字
                          LengthLimitingTextInputFormatter(13), //最大长度
                        ],
                        controller: _managerPhoneController,
                        style: CommonText.darkGrey15TextStyle(),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: widget.decorationInfo?.decorateType == 1 ? '用于授权办理出入证，请如实填写(必填)' : '请输入',
                          hintStyle: CommonText.lightGrey15TextStyle(),
                          isDense: true,
                        ),
                      ),
                      arrowVisible: false,
                    ),
                    CommonDivider(),
                    leftTextWidget(
                      text: widget.decorationInfo.decorateType == 1
                          ? '温馨提示：请如实填写施工负责人、手机号码等信息。物业评估通过后会有短信通知施工负责人，施工负责人可通过短信下载到家汇2.0APP，使用上述填写的联系电话注册并登录到家汇2.0APP后，施工负责人可自行办理装修工出入证。'
                          : '温馨提示：请在物业评估通过后，登录到家汇2.0App申请办理装修工出入证。',
                      color: UIData.themeBgColor,
                      fontSize: UIData.fontSize15,
                      rightSpacing: UIData.spaceSize16,
                      topSpacing: UIData.spaceSize12,
                    ),
                  ]))),

          ///第三步
          Visibility(
              visible: step == 2,
              child: Container(
                  color: UIData.primaryColor,
                  padding: EdgeInsets.only(bottom: UIData.spaceSize12),
                  child: Column(children: <Widget>[
                    CommonSingleInputRow(
                      programName,
                      titleWidth: 87,
                      content: TextField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(50), //最大长度
                        ],
                        controller: _programNameController,
                        style: CommonText.darkGrey15TextStyle(),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '请输入(必填)',
                          hintStyle: CommonText.lightGrey15TextStyle(),
                          isDense: true,
                        ),
                      ),
                      arrowVisible: false,
                    ),
                    CommonDivider(),
                    leftTextWidget(
                      text: programDesc,
                      color: UIData.darkGreyColor,
                      topSpacing: UIData.spaceSize12,
                    ),
                    inputWidget(
                      _programDescController,
                      hint_text: "请输入(必填)",
                      maxLength: 200,
                    ),
                    CommonDivider(),
                    Container(
                        //上传照片
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            leftTextWidget(text: "相关附件：建筑图纸等以及其他图片", topSpacing: UIData.spaceSize16),
                            Container(
                              margin: EdgeInsets.all(UIData.spaceSize16),
                              child: CommonImagePicker(
                                attachmentList: widget.decorationInfo?.otherPhotos,
                                callbackWithInfo: (List<Attachment> list) {
                                  widget.decorationInfo?.otherPhotos = list;
                                },
                              ),
                            )
                          ],
                        )),
                  ]))),

          ///第四步
          Visibility(
              visible: step == 3,
              child: Container(
                  color: UIData.primaryColor,
                  padding: EdgeInsets.only(bottom: UIData.spaceSize12),
                  child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigate.toNewPage(CopyWritingPage('装修施工承诺书', CopyWritingType.DecorationCommitment));
                      },
                      child: leftTextWidget(
                        text: '《装修施工承诺书》',
                        color: UIData.underlineBlueColor,
                        textDecoration: TextDecoration.underline,
                        fontSize: UIData.fontSize15,
                        topSpacing: UIData.spaceSize12,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigate.toNewPage(CopyWritingPage('安全防火责任书', CopyWritingType.FireSafetyResponsibility));
                      },
                      child: leftTextWidget(
                        text: '《安全防火责任书》',
                        color: UIData.underlineBlueColor,
                        textDecoration: TextDecoration.underline,
                        fontSize: UIData.fontSize15,
                        topSpacing: UIData.spaceSize12,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigate.toNewPage(CopyWritingPage('装修协议', CopyWritingType.DecorationAgreement));
                      },
                      child: leftTextWidget(
                        text: '《装修协议》',
                        color: UIData.underlineBlueColor,
                        textDecoration: TextDecoration.underline,
                        fontSize: UIData.fontSize15,
                        topSpacing: UIData.spaceSize12,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigate.toNewPage(CopyWritingPage('房屋装修业主担保书', CopyWritingType.DecorationGuarantee));
                      },
                      child: leftTextWidget(
                        text: '《房屋装修业主担保书》',
                        color: UIData.underlineBlueColor,
                        textDecoration: TextDecoration.underline,
                        fontSize: UIData.fontSize15,
                        topSpacing: UIData.spaceSize12,
                      ),
                    ),
                    Visibility(
                      visible: (isOwner != null && !isOwner && custProper != customerJTCY) ||
                          widget.decorationInfo?.applyType == 2,
                      child: leftTextWidget(
                        text: '*须知：装修办理需得到业主同意，请联系业主登录到家汇2.0App协助完成申请。',
                        color: UIData.redColor,
                        fontSize: UIData.fontSize15,
                        topSpacing: UIData.spaceSize12,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: vertical_spacing),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (widget.decorationInfo?.agree == null)
                              widget.decorationInfo?.agree = 1;
                            else {
                              if (widget.decorationInfo?.agree == 1) {
                                widget.decorationInfo?.agree = 0;
                              } else {
                                widget.decorationInfo?.agree = 1;
                              }
                            }
                          });
                        },
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: UIData.spaceSize16, right: UIData.spaceSize16),
                              child: (widget.decorationInfo?.agree ?? 0) == 1
                                  ? UIData.iconCheckBoxSelected
                                  : UIData.iconCheckBoxNormal,
                            ),
                            Expanded(
                              child: CommonText.text11(
                                  '本人保证在装修期间，遵守建设部《住宅室内装饰装修管理办法》，接受管理单位的管理和监督，严格按以上审核意见进行文明施工。',
                                  color: UIData.underlineBlueColor,
                                  overflow: TextOverflow.visible),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]))),
        ]),
      );
    });
  }

  bool checkData(DecorationInfo info) {
    String tips = '';
    switch (step) {
      case 0:
        if (info?.houseId == null) {
          tips = '房屋';
        } else if (info?.decorateType == null) {
          tips = decorateType;
        } else if (info?.workDayLong == null || info?.workDayLong == 0) {
          tips = workDayLong;
        } else if (info?.beginWorkDate == null) {
          tips = beginWorkDate;
        }
        break;
      case 1:
        if (info?.decorateType == 1) {
          if (StringsHelper.isEmpty(_workCompanyController.text)) {
            tips = workCompany;
          } else if (StringsHelper.isEmpty(_companyPaperNumberController.text)) {
            tips = companyPaperNumber;
          } else if (widget.decorationInfo?.companyPapers == null ||
              (widget.decorationInfo?.companyPapers?.length ?? -1) < 0) {
            tips = '证件照';
            CommonToast.show(type: ToastIconType.INFO, msg: '请上传${tips}');
            return false;
          } else if (StringsHelper.isEmpty(_credentialNumberController.text)) {
            tips = credentialNumber;
          } else if ((widget.decorationInfo?.credentialPapers?.length ?? -1) < 0) {
            tips = '资质证书';
            CommonToast.show(type: ToastIconType.INFO, msg: '请上传${tips}');
            return false;
          } else if (StringsHelper.isEmpty(_managerController.text)) {
            tips = manager;
          } else if ((widget.decorationInfo?.managerIdCardPhotos?.length ?? -1) < 0) {
            tips = '负责人身份证照';
            CommonToast.show(type: ToastIconType.INFO, msg: '请上传${tips}');
            return false;
          } else if (StringsHelper.isEmpty(_managerIdCardController.text)) {
            tips = managerIdCard;
          } else if (StringsHelper.isEmpty(_managerPhoneController.text)) {
            tips = managerPhone;
          }
        }
        break;
      case 2:
        if (StringsHelper.isEmpty(_programNameController.text)) {
          tips = programName;
        } else if (StringsHelper.isEmpty(_programDescController.text)) {
          tips = programDesc;
        }
        break;
      case 3:
        if ((info?.agree ?? 0) != 1) {
          CommonToast.show(type: ToastIconType.INFO, msg: '请同意签署并遵循装修相关协议！');
          return false;
        }
        break;
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
            myList.forEach((map) {
              map['bool'] = false;
            });
            myList[i]['bool'] = true;
            widget.decorationInfo.decorateType = i + 1;
            LogUtils.printLog(widget.decorationInfo.decorateType.toString());
          });
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(UIData.spaceSize12 + UIData.spaceSize3)),
      ));
    }

    return widgetList;
  }
}
