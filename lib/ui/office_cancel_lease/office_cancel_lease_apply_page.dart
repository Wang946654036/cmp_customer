import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/office_cancel_lease_detail_model.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/strings/strings_common.dart';
import 'package:cmp_customer/strings/strings_office_cancel_lease.dart';
import 'package:cmp_customer/strings/strings_user.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_dialog.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_image_picker.dart';
import 'package:cmp_customer/ui/common/common_picker.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_text_field.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/common/common_wrap.dart';
import 'package:cmp_customer/ui/common/copy_writing_page.dart';
import 'package:cmp_customer/ui/office_cancel_lease/office_cancel_lease_record_page.dart';
import 'package:cmp_customer/ui/office_cancel_lease/select_house_group_by_building_page.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';

///
/// 写字楼退租申请
///
class OfficeCancelLeaseApplyPage extends StatefulWidget {
  final OfficeCancelLeaseDetail applyModel;

  OfficeCancelLeaseApplyPage({this.applyModel});

  @override
  _OfficeCancelLeaseApplyPageState createState() => _OfficeCancelLeaseApplyPageState();
}

class _OfficeCancelLeaseApplyPageState extends State<OfficeCancelLeaseApplyPage> {
  TextEditingController _remarkController = TextEditingController();
  OfficeCancelLeaseDetail _applyModel;
  List<HouseInfo> _houseList; //默认项目下的房屋列表
  bool _houseLoading = true; //房屋列表是否加载中

  @override
  void initState() {
    super.initState();
    _initData();
    _initHouseList();
    _remarkController.addListener(() {
      _applyModel.remark = _remarkController.text;
    });
  }

  //初始化数据，修改申请把加入详情数据，新建申请则初始化对象
  void _initData() {
    if (widget.applyModel != null) {
      _applyModel = OfficeCancelLeaseDetail.clone(widget.applyModel);
      _houseList = widget.applyModel?.houseList;
      _remarkController.text = _applyModel?.recordList?.lastWhere((RecordInfo info) {
        return info?.operateStep == officeCancelLeaseOperateStepMap.keys.toList()[0] ||
            info?.operateStep == officeCancelLeaseOperateStepMap.keys.toList()[1];
      })?.remark;
    } else
      _applyModel = OfficeCancelLeaseDetail();
  }

  //获取当前项目下已认证的房屋列表
  void _initHouseList() {
    stateModel.getCertifiedHouseByProject(
        isOfficeCancelLease: true,
        callBack: ({List<HouseInfo> houseList, failedMsg}) {
          setState(() {
            _houseLoading = false;
            if (failedMsg == null) {
              if (_houseList == null) _houseList = List();
              if (_applyModel.houseList == null) _applyModel.houseList = List();
              houseList.forEach((HouseInfo info) {
                //租户或者租户成员属性才可选的房屋列表
//            if (info.custProper == customerTypeMap.keys.toList()[1] ||
//                info.custProper == customerTypeMap.keys.toList()[3]) {
//            }
                List<String> houseIdList = _applyModel?.houseIds?.split(',');
                if (houseIdList != null && houseIdList.length > 0) {
                  String houseId = houseIdList.firstWhere((String houseId) => int.parse(houseId) == info?.houseId,
                      orElse: () => null);
                  if (houseId != null) {
                    _applyModel.houseList.add(info);
                    info.selected = true;
                  }
                }
                _houseList.add(info);
              });
            }
          });
//      if (_applyModel == null) {
//        _houseList.forEach((HouseInfo info) {
//          if (info.isDefaultHouse == '1') {
//            //默认房屋
//            setState(() {
//              _applyModel.houseId = info.houseId;
//              _refreshHouseName(info);
//            });
//          }
//        });
//      }
        });
  }

  bool _checkCommit() {
    if (_applyModel.houseList == null || _applyModel.houseList.isEmpty) {
      CommonToast.show(msg: '请选择房屋信息', type: ToastIconType.INFO);
      return false;
    }
    if (_applyModel.surrenderTime == null) {
      CommonToast.show(msg: '请选择退租日期', type: ToastIconType.INFO);
      return false;
    }
    if (_applyModel.attApplyList == null || _applyModel.attApplyList.isEmpty) {
      CommonToast.show(msg: '请选择相关资料图片', type: ToastIconType.INFO);
      return false;
    }
    return true;
  }

  Widget _buildBody() {
    return Container(
      color: UIData.primaryColor,
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize16),
            child: CommonText.darkGrey15Text('退租房号'),
          ),
          CommonSelectSingleRow(
            null,
            hintText: _houseLoading ? '加载中' : '请选择（必填）',
            content: _applyModel.houseList != null && _applyModel.houseList.length > 0
                ? Container(
                    padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize16),
                    child: CustomWrap(_applyModel?.houseList?.map((HouseInfo houseInfo) {
                      return CustomChip('${houseInfo?.buildName ?? ''}${houseInfo?.houseNo ?? ''}');
                    })?.toList()))
                : null,
            onTap: () {
              if (widget.applyModel == null)
              if (!_houseLoading) {
                if (_houseList == null) {
                  _initHouseList();
                } else if (_houseList != null && _houseList.length > 0)
                  Navigate.toNewPage(SelectHouseGroupByBuildingPage(_houseList, callback: (List<HouseInfo> info) {
                    setState(() {
                      _applyModel.houseList = info;
                    });
                  }));
                else
                  CommonToast.show(type: ToastIconType.INFO, msg: '当前社区下没有已认证房屋');
              }
            },
              arrowVisible: widget.applyModel == null,
              contentColor: widget.applyModel == null ? UIData.darkGreyColor : UIData.lightGreyColor
          ),
          CommonDivider(),
          CommonSelectSingleRow('退租日期',
              hintText: '请选择（必填）',
              content: _applyModel.surrenderTime,
              onTap: () => CommonPicker.datePickerModal(context, onConfirm: (String date) {
                    setState(() {
                      _applyModel.surrenderTime = date;
                    });
                  })),
          CommonDivider(),
          CommonSelectSingleRow('可交验日期',
              hintText: '请选择',
              content: _applyModel.checkTime,
              onTap: () => CommonPicker.datePickerModal(context, onConfirm: (String date) {
                    setState(() {
                      _applyModel.checkTime = date;
                    });
                  })),
          Container(height: UIData.spaceSize16, color: UIData.scaffoldBgColor),
          Container(
            padding: EdgeInsets.only(left: UIData.spaceSize16, top: UIData.spaceSize16),
            child: CommonText.darkGrey15Text('相关资料（开发商出具的退租通知书等）'),
          ),
          Container(
            margin: EdgeInsets.all(UIData.spaceSize16),
            child: CommonImagePicker(
              photoIdList: _applyModel.attApplyList,
              callback: (List<String> images) {
                _applyModel.attApplyList = images;
                LogUtils.printLog('attApplyList: ${_applyModel.attApplyList}');
//                if (_applyModel.attApplyList == null)
//                  _applyModel.attApplyList = List();
//                else
//                  _applyModel.attApplyList.clear();
//                _applyModel.attApplyList = images;
              },
            ),
          ),
          Container(height: UIData.spaceSize16, color: UIData.scaffoldBgColor),
          FormMultipleTextField('备注', controller: _remarkController),
          GestureDetector(
              child: Container(
                  color: UIData.scaffoldBgColor,
                  padding: EdgeInsets.all(UIData.spaceSize16),
                  child: CommonText.red14Text('写字楼退租注意事项')),
              onTap: () {
                Navigate.toNewPage(CopyWritingPage('写字楼退租注意事项', CopyWritingType.OfficeRentRefundNotes));
              }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appTitle: '退租申请',
      appBarActions: [
        Visibility(child: FlatButton(
            onPressed: () => Navigate.toNewPage(OfficeCancelLeaseRecordPage()),
            child: CommonText.red15Text('申请记录')),
        visible: widget.applyModel == null)

      ],
      bodyData: _buildBody(),
      bottomNavigationBar: StadiumSolidButton('提交申请', onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        if (_checkCommit()) {
          CommonDialog.showAlertDialog(context, title: '确认提交', content: '确定提交该退租申请？', onConfirm: () {
            _applyModel.operateStep = StringsHelper.enum2String(OfficeCancelLeaseOperateStep.XZLTZ_TJSQ);
            StringBuffer stringBuffer = StringBuffer();
            _applyModel.houseList.forEach((HouseInfo info) {
              stringBuffer.write('${info?.houseId},');
            });
            _applyModel.houseIds = stringBuffer.toString();
            _applyModel.houseIds = _applyModel.houseIds.substring(0, _applyModel.houseIds.length - 1);
            LogUtils.printLog('houseIDs:${_applyModel.houseIds}');
            stateModel.applyOfficeCancelLease(applyModel: _applyModel, newCreate: widget.applyModel == null);
          });
        }
      }),
    );
  }
}
