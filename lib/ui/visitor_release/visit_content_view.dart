import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/new_house_model.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/models/visit_setting.dart';
import 'package:cmp_customer/models/visitor_release_detail_model.dart';
import 'package:cmp_customer/scoped_models/new_house_state_model.dart';
import 'package:cmp_customer/scoped_models/visitor_release_state_model.dart';
import 'package:cmp_customer/strings/strings_house_auth.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_image_display.dart';
import 'package:cmp_customer/ui/common/common_image_picker.dart';
import 'package:cmp_customer/ui/common/common_picker.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_text_field.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/common/select_house_from_project_page.dart';
import 'package:cmp_customer/ui/decorate_manager/decoration_ui.dart';
import 'package:cmp_customer/ui/house_authentication/select_house_page.dart';
import 'package:cmp_customer/ui/me/community_search_page.dart';
import 'package:cmp_customer/ui/new_house/new_house_common_ui.dart';
import 'package:cmp_customer/ui/visitor_release/visitor_release_common_ui.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/date_util.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../main.dart';


///
/// Created by yangyangyang on 2020/4/9 3:30 PM.
/// 基本信息
/// [editable] 是否可编辑，
///
class VisitorReleaseContentView extends StatefulWidget {
  final bool editable;
  VisitorReleaseDetail visitorRelease;
  final VisitorReleaseStateModel model;
  VisitorReleaseContentView(this.editable, this.visitorRelease,this.model);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _VisitorReleaseContentView();
  }
}

class _VisitorReleaseContentView extends State<VisitorReleaseContentView> {
  VisitorReleaseDetail _visitorRelease;
  TextEditingController _custNameController = TextEditingController(); //name
  TextEditingController _custMobilController = TextEditingController(); //电话
  TextEditingController _releaseNameController = TextEditingController(); //到访name
  TextEditingController _releaseMobilController = TextEditingController(); //到访电话
  TextEditingController _releaseIdNumController = TextEditingController(); //证件号码
  TextEditingController _releasePeopleNumController = TextEditingController(); //到访人数
  TextEditingController _remarkController = TextEditingController(); //remark
  bool canEditProject = false;//不能编辑社区
  List<HouseInfo> _houseList;
  @override
  void initState() {
    super.initState();

    _initData();
    _setListener();

  }

  void _initData() {
    _visitorRelease = widget.visitorRelease;
//    if (_visitorRelease?.appointmentVisitId != null) canEditProject = false; //已提交后的社区不能编辑
    _custNameController.text = _visitorRelease?.custName;
    _custMobilController.text = _visitorRelease?.custPhone;
    _releaseNameController.text = _visitorRelease?.visitorName;
    _releaseMobilController.text = _visitorRelease?.visitorPhone;
    _releaseIdNumController.text = _visitorRelease?.paperNumber;
    if(_visitorRelease?.visitNum==null||_visitorRelease.visitNum<0){
      _visitorRelease?.visitNum = 1;
    }
    _releasePeopleNumController.text = _visitorRelease?.visitNum?.toString()??'1';
    _remarkController.text = _visitorRelease?.remark;
    if(_visitorRelease.effective==null){
      _visitorRelease.effective=1;
    }
    if(_visitorRelease?.driveCar==null){
      _visitorRelease?.driveCar=0;
    }
    if (widget.editable && _visitorRelease?.projectId == null) {
      _visitorRelease?.projectId = stateModel.defaultProjectId;
      _visitorRelease?.projectFormerName = stateModel.defaultProjectName;
      _visitorRelease?.projectName = stateModel.defaultProjectName;
      _visitorRelease?.houseId = stateModel.defaultHouseId;
      _visitorRelease?.unitId = stateModel.defaultUnitId;
      _visitorRelease?.buildId = stateModel.defaultBuildingId;
      _visitorRelease?.buildName = "${stateModel.defaultBuildingName??''}";
      _visitorRelease?.unitName = "${stateModel.defaultUnitName??''}";
      _visitorRelease?.houseName = "${stateModel.defaultHouseName??''}";
    }
  }

  _initHouseList({Function callback}){
    if(callback!=null){
      stateModel.getCertifiedHouseByProject(callBack: callback);
    }else
      stateModel.getCertifiedHouseByProject(callBack: ({List<HouseInfo> houseList, failedMsg}) {
      setState(() {
        if (failedMsg == null) {
          _houseList = houseList;
        }
      });
    });
  }
  _initMaxEffective({Function callback}){
    if(callback!=null){
      widget.model.getVisitorMaxEffective( callback:callback);
    }else{
      widget.model.getVisitorMaxEffective( callback:(VisitSettingInfo visitSettingInfo, failedMsg){
        setState(() {
          if (failedMsg == null) {
            _visitorRelease.maxEffective = visitSettingInfo.maxEffective;
          }
        });
      });
    }

  }
goToHouseChoose(){
  Navigate.toNewPage(
      SelectHouseFromProjectPage(_houseList, _visitorRelease?.houseId),
      callBack: (HouseInfo houseinfo) {
        setState(() {
          if (houseinfo != null) {

            _visitorRelease?.projectFormerName="${houseinfo?.formerName??''}";
            _visitorRelease?.projectName="${houseinfo?.projectName??''}";
            _visitorRelease?.buildName="${houseinfo?.buildName??''}";
            _visitorRelease?.unitName="${houseinfo?.unitName??''}";
          _visitorRelease?.houseName = "${houseinfo?.houseNo??''}";
            _visitorRelease?.houseId = houseinfo?.houseId;
            _visitorRelease?.unitId = houseinfo?.unitId;
            _visitorRelease?.buildId = houseinfo?.buildId;
            LogUtils.printLog('houseId:${houseinfo?.houseId}');
          }
        });
      });
}
  void _setListener() {
    _custNameController.addListener(() {
      _visitorRelease?.custName = _custNameController.text;
    });
    _custMobilController.addListener(() {
      _visitorRelease?.custPhone = _custMobilController.text;
    });
    _releaseIdNumController.addListener(() {
      _visitorRelease?.paperNumber = _releaseIdNumController.text;
    });
    _releaseNameController.addListener(() {
      _visitorRelease?.visitorName = _releaseNameController.text;
    });
    _releaseMobilController.addListener(() {
      _visitorRelease?.visitorPhone = _releaseMobilController.text;
    });
    _releasePeopleNumController.addListener(() {
      try{
        _visitorRelease?.visitNum = int.parse(_releasePeopleNumController.text??'');
      }catch(e){
        _visitorRelease?.visitNum =1;
        _releasePeopleNumController.text = '';
      }

    });
    _remarkController.addListener(() {
      _visitorRelease?.remark = _remarkController.text;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: UIData.spaceSize16),
      margin: EdgeInsets.only(bottom: UIData.spaceSize16),
      color: UIData.primaryColor,
      child: Column(
        children: <Widget>[
          TextWithLeftBorder('预约信息'),
          CommonSingleInputRow('社区',
              content: (_visitorRelease?.projectFormerName != null || _visitorRelease?.projectName != null)
                  ? CommonText.text15(_visitorRelease?.projectFormerName ?? (_visitorRelease?.projectName ?? ''),
                  color:
                  !widget.editable  ? UIData.lightGreyColor : UIData.darkGreyColor)
                  : CommonText.lightGrey15Text('请选择（必填）'), onTap: () {
                if (canEditProject) {
                  Navigate.toNewPage(
                    CommunitySearchPage(callback: (int projectId, String formerName) {
                      setState(() {
                        if (_visitorRelease?.projectId != projectId) {
                          _visitorRelease?.projectId = projectId;
                          _visitorRelease?.projectFormerName = formerName;
                          _visitorRelease?.houseName = '';
                          _visitorRelease?.buildName="";
                          _visitorRelease?.unitName="";
                          _visitorRelease?.houseId = null;
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
              content:
                  StringsHelper.isNotEmpty(_visitorRelease?.houseName)
                  ? CommonText.text15(
                  '${_visitorRelease?.buildName ?? ''}${_visitorRelease?.unitName ?? ''}${_visitorRelease?.houseName ?? ''}',
                  color: !widget.editable ? UIData.lightGreyColor : UIData.darkGreyColor)
                  : CommonText.lightGrey15Text('请选择（必填）'), onTap: () {
                if (widget.editable) {
                  if (_visitorRelease?.projectId == null) {
                    CommonToast.show(msg: '请先选择社区', type: ToastIconType.INFO);
                    return;
                  }
                  if(_houseList==null||_houseList.length==0){
                      CommonToast.show(msg: '获取中...');
                    _initHouseList(callback: ({List<HouseInfo> houseList, failedMsg}){
                      CommonToast.dismiss();
                      if(failedMsg==null){
                        _houseList=houseList;
                        goToHouseChoose();
                      }else{
                        CommonToast.show(type: ToastIconType.INFO,msg: failedMsg);
                      }
                    });
                  }else{
                    goToHouseChoose();
                  }

                }
              }, arrowVisible: widget.editable),
          CommonDivider(),

          CommonSelectSingleRow(
            '被访人姓名',
            content: widget.editable?CommonTextField(
                hintText: widget.editable?"请输入":'暂无',
                limitLength: 32,
                controller: _custNameController,
                enabled: widget.editable,
                textColor: !widget.editable ? UIData.lightGreyColor : UIData.darkGreyColor):CommonText.text15(_visitorRelease.custName??'',
                color: UIData.lightGreyColor),
                arrowVisible: false,
          ),
          CommonDivider(),
          CommonSelectSingleRow(
            '被访人电话',
            onTap: !widget.editable?(){
              if (StringsHelper.isNotEmpty(_visitorRelease.custPhone)) {
                stateModel.callPhone(_visitorRelease.custPhone);
              } else {
                CommonToast.show(type: ToastIconType.INFO, msg: '暂无信息');
              }
            }:null,
            content: widget.editable?CommonTextField(
                hintText: widget.editable?"请输入":'暂无',
                limitLength: 11,
                controller: _custMobilController,
                inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter(RegExp("[0-9]"))],
                keyboardType: TextInputType.number,
                textColor: !widget.editable ? UIData.lightGreyColor : UIData.darkGreyColor,
                enabled: widget.editable):CommonText.text15(_visitorRelease.custPhone??'',
                color: UIData.lightGreyColor),
            arrowVisible: !widget.editable,
            icon: Image.asset(UIData.imagePhone),
          ),
          CommonDivider(),
          CommonSingleInputRow('到访事由',
              content: _visitorRelease?.visitReason != null
                  ? CommonText.text15(documentMapForVisitReason[_visitorRelease?.visitReason],
                  color: !widget.editable ? UIData.lightGreyColor : UIData.darkGreyColor)
                  : CommonText.lightGrey15Text('请选择（必填）'), onTap: () {
                if (widget.editable)
                  CommonPicker.singlePickerModal(context, documentMapForVisitReason.values.toList(),
                      onConfirm: (int index, String data) {
                        setState(() {
                          _visitorRelease?.visitReason = documentMapForVisitReason.keys.toList()[index];
                        });
                      });
              }, arrowVisible: widget.editable),
          CommonDivider(),
          CommonSelectSingleRow('到访日期',
              hintText: '请选择（必填，往后30天内）',
              content: _visitorRelease?.visitDate,
              contentColor: !widget.editable ? UIData.lightGreyColor : UIData.darkGreyColor, onTap: () {
                if (widget.editable) {
                  CommonPicker.datePickerWithLimitModal(context, onConfirm: (String date) {
                    setState(() {
                      if (date != null && !DateUtils.isBefore(date))
                        _visitorRelease?.visitDate = date;
                      else
                        CommonToast.show(type: ToastIconType.INFO, msg: '请选择当前日期之后');
                    });
                  });
                }
              }, arrowVisible: widget.editable),
          CommonDivider(),
          CommonSingleInputRow('有效期',
              content: CommonText.text15((_visitorRelease.effective?.toString()??'1')+'天',
                  color: !widget.editable ? UIData.lightGreyColor : UIData.darkGreyColor)
                 , onTap: () {
                if (widget.editable) {
                  if(_visitorRelease?.maxEffective==null){
                    CommonToast.show(msg: '获取中...');

                    _initMaxEffective(callback: ({VisitSettingInfo visitSettingInfo, failedMsg}){
                      CommonToast.dismiss();
                      if(failedMsg==null){
                        _visitorRelease?.maxEffective=visitSettingInfo.maxEffective;
                        CommonPicker.singlePickerModal(context,
                            getLimitDatesStrings(_visitorRelease?.maxEffective ?? 1),
                            onConfirm: (int index, String data) {
                              setState(() {
                                data = data.replaceAll('天', '');
                                _visitorRelease?.effective = int.parse(data);
                              });
                            });
                      }else{
                        CommonToast.show(type: ToastIconType.INFO,msg: failedMsg);
                      }
                    });


                  }else{
                    CommonPicker.singlePickerModal(context,
                        getLimitDatesStrings(_visitorRelease?.maxEffective ?? 1),
                        onConfirm: (int index, String data) {
                          setState(() {
                            data = data.replaceAll('天', '');
                            _visitorRelease?.effective = int.parse(data);
                          });
                        });
                  }

                }
              }, arrowVisible: widget.editable),
          CommonDivider(),
          CommonSelectSingleRow(
            '访客姓名',
            content: CommonTextField(
                hintText: widget.editable?"请输入（必填）":'',
                limitLength: 32,
                controller: _releaseNameController,
                enabled: widget.editable,
                textColor: !widget.editable ? UIData.lightGreyColor : UIData.darkGreyColor),
            arrowVisible: false,
          ),
          CommonDivider(),

          CommonSelectSingleRow(
            '访客电话',
            onTap: !widget.editable?(){
              if (StringsHelper.isNotEmpty(_visitorRelease.visitorPhone)) {
                stateModel.callPhone(_visitorRelease.visitorPhone);
              } else {
                CommonToast.show(type: ToastIconType.INFO, msg: '暂无信息');
              }
            }:null,
            content: widget.editable?CommonTextField(
                hintText: "请输入（必填）",
                limitLength: 11,
                controller: _releaseMobilController,
                inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter(RegExp("[0-9]"))],
                keyboardType: TextInputType.number,
                textColor: !widget.editable ? UIData.lightGreyColor : UIData.darkGreyColor,
                enabled: widget.editable):CommonText.text15(_visitorRelease.visitorPhone??'',
                color: UIData.lightGreyColor),
            arrowVisible: !widget.editable,
              icon: Image.asset(UIData.imagePhone)
          ),
          CommonDivider(),
          CommonSingleInputRow('证件类型',
              content: _visitorRelease?.paperType != null
                  ? CommonText.text15(documentGRMap[_visitorRelease?.paperType]??'',
                  color: !widget.editable ? UIData.lightGreyColor : UIData.darkGreyColor)
                  : CommonText.lightGrey15Text('请选择（必填）'), onTap: () {
                if (widget.editable)
                  CommonPicker.singlePickerModal(context, documentGRMap.values.toList(),
                      onConfirm: (int index, String data) {
                        setState(() {
                          _visitorRelease?.paperType = documentGRMap.keys.toList()[index];
                        });
                      });
              }, arrowVisible: widget.editable),
          CommonDivider(),
          CommonSelectSingleRow(
            '证件号',
            content: CommonTextField(
                controller: _releaseIdNumController,
                limitLength: 20,
                hintText: '请输入（必填）',
                textColor: !widget.editable ? UIData.lightGreyColor : UIData.darkGreyColor,
                enabled: widget.editable),
            arrowVisible: false,
          ),
          CommonDivider(),
          CommonSelectSingleRow(
            '驾车到访',
            contentColor:!widget.editable?UIData.lightGreyColor:UIData.darkGreyColor,
            content: !widget.editable
                ? (_visitorRelease?.driveCar == 1 ? '是' : '否')
                : Row(
              children: <Widget>[
                CommonRadio(
                    text: '是',
                    value: 1,
                    groupValue: _visitorRelease.driveCar,
                    onChanged: (int value) {
                      setState(() {
                        _visitorRelease.driveCar = value;
                      });
                    }),
                SizedBox(width: UIData.spaceSize16),
                //不是托收就存XJ-现金
                CommonRadio(
                    text: '否',
                    value: 0,
                    groupValue: _visitorRelease.driveCar,
                    onChanged: (int value) {
                      setState(() {
                        _visitorRelease.driveCar = value;
                      });
                    }),
              ],
            ),
            arrowVisible: false,
          ),
          CommonDivider(),
          CommonSelectSingleRow(
            '车牌号',
            contentColor:!widget.editable?UIData.lightGreyColor:UIData.darkGreyColor,
            content: _visitorRelease.carNumber,
            hintText: !widget.editable? '' : null,
            onTap: () {
              widget.model.showCarNoInputView=!widget.model.showCarNoInputView;
              FocusScope.of(context).requestFocus(FocusNode());
              widget.model.setCarInfo(_visitorRelease.carNumber);
            },
            arrowVisible: false,
          ),
          CommonDivider(),
          CommonSelectSingleRow(
            '到访人数',
            content: widget.editable?CommonTextField(
                hintText: "请输入（必填）",
                limitLength: 2,
                controller: _releasePeopleNumController,
                inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter(RegExp("[0-9]"))],
                keyboardType: TextInputType.number,
                textColor: !widget.editable ? UIData.lightGreyColor : UIData.darkGreyColor,
                enabled: widget.editable):"${_visitorRelease.visitNum??''}人",
            arrowVisible: false,
            contentColor: !widget.editable ? UIData.lightGreyColor : UIData.darkGreyColor,
          ),
          CommonDivider(),
          ///备注
          Container(
            margin: EdgeInsets.only(bottom: UIData.spaceSize12),
            padding: EdgeInsets.only(bottom: UIData.spaceSize12),
            color: UIData.primaryColor,
            child: Column(
              children: <Widget>[
                leftTextWidget(
                  text: '备注',
                  fontSize: UIData.fontSize15,

                  topSpacing: UIData.spaceSize12,
                ),
                inputWidget(
                    _remarkController,
                    hint_text: widget.editable?"请输入":'暂无',
                    color: !widget.editable?UIData.lightGreyColor:UIData.darkGreyColor,
                    maxLength: widget.editable?200:null,
                    editable: widget.editable),
              ],
            ),
          ),
          Visibility(visible:!widget.editable,child:  CommonDivider(),),

          Visibility(visible:!widget.editable,child: CommonSelectSingleRow(
            '提交时间',
            contentColor: UIData.lightGreyColor,
            content: _visitorRelease?.createTime??' ',
            arrowVisible: false,
          ),),

          Visibility(visible:!widget.editable,child: CommonDivider(),),

          Visibility(visible:!widget.editable,child:  CommonSelectSingleRow(
            '业务单号',
            contentColor: UIData.lightGreyColor,
            content: _visitorRelease?.oddNumber??' ',
            arrowVisible: false,
          ),),
        ],
      ),
    );
  }
}
