import 'package:cmp_customer/strings/strings_common.dart';
import 'package:cmp_customer/strings/strings_office_cancel_lease.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_picker.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/office_cancel_lease/office_cancel_lease_record_page.dart';
import 'package:cmp_customer/ui/parking/parking_card_ui.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/date_util.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';

///
/// 写字楼退租申请列表筛选侧滑
///
class OfficeCancelLeaseRecordFilter extends StatefulWidget {
  final Function callback;
  final OfficeCancelLeaseFilterModel filterModel;

  OfficeCancelLeaseRecordFilter(this.filterModel, {this.callback});
  @override
  _OfficeCancelLeaseRecordFilterState createState() => _OfficeCancelLeaseRecordFilterState();
}

class _OfficeCancelLeaseRecordFilterState extends State<OfficeCancelLeaseRecordFilter> {
  OfficeCancelLeaseFilterModel _filterModel;
  String _nowDate = StringsHelper.formatterYMD.format(DateTime.now()); //今天

  @override
  void initState() {
    super.initState();
    _filterModel = widget.filterModel;
//    if (widget.filterModel.startTime != null && widget.filterModel.startTime.isNotEmpty)
//      _startTime = widget.filterModel.startTime;
//    if (widget.filterModel.endTime != null && widget.filterModel.endTime.isNotEmpty)
//      _endTime = widget.filterModel.endTime;
//    if (widget.filterModel.reasonList != null) _reasonList = widget.filterModel.reasonList;
//    if (widget.filterModel.statusList != null) _statusList = widget.filterModel.statusList;
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
        appTitle: Container(
          margin: EdgeInsets.only(left: UIData.spaceSize16),
          child: CommonText.darkGrey15Text('申请时间'),
        ),
        showLeftButton: false,
        backGroundColor: UIData.primaryColor,
        bodyData: Container(
          padding: EdgeInsets.only(left: UIData.spaceSize16),
          child: Column(
            children: <Widget>[
              //时间段选择框
              Container(
                child: Row(children: <Widget>[
                  Expanded(
                    child: ellipseText(
                      _filterModel?.startTime ?? label_apply_select_start_time,
                      textColor: _filterModel?.startTime == null ? UIData.lightGreyColor : UIData.darkGreyColor,
//                leftSpacing: left_spacing,
                      rightSpacing: text_spacing,
                      onTap: () {
                        CommonPicker.datePickerModal(context, onConfirm: (String date) {
                          setState(() {
                            _filterModel.startTime = date;
                          });
                        });
                      },
                    ),
                  ),
                  Text("—"),
                  Expanded(
                    child: ellipseText(
                      _filterModel?.endTime ?? label_apply_select_end_time,
                      textColor: _filterModel?.endTime == null ? UIData.lightGreyColor : UIData.darkGreyColor,
                      leftSpacing: text_spacing,
                      rightSpacing: right_spacing,
                      onTap: () {
                        CommonPicker.datePickerModal(context, onConfirm: (String date) {
                          setState(() {
                            _filterModel.endTime = date;
                          });
                        });
                      },
                    ),
                  )
                ]),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: UIData.spaceSize16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: timeIntervalMap.keys.map((int monthAgo) {
                    return Expanded(
                        child: ellipseBotton(
                          timeIntervalMap[monthAgo],
                          _filterModel?.startTime == DateUtils.getMonthAgoDate(monthAgo) && _filterModel.endTime == _nowDate,
                          onChanged: (value) {
                            setState(() {
                              if (value) {
                                _filterModel.startTime = DateUtils.getMonthAgoDate(monthAgo);
                                _filterModel.endTime = _nowDate;
                              } else {
                                _filterModel.startTime = null;
                                _filterModel.endTime = null;
                              }
                              LogUtils.printLog('startTime: $_filterModel.startTime');
                            });
                          },
                        ));
                  }).toList(),
                ),
              ),
              CommonFullScaleDivider(),
              leftTextWidget(
                text: '状态',
                topSpacing: top_spacing,
                leftSpacing: 0,
//                bottomSpacing: bottom_spacing,
              ),
              Container(
                margin: EdgeInsets.only(top: top_spacing, bottom: bottom_spacing),
                child: GridView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, childAspectRatio: 3, mainAxisSpacing: UIData.spaceSize12),
                    children: officeCancelLeaseStatusMap.keys.map((String status) {
                      return ellipseBotton(
                        officeCancelLeaseStatusMap[status],
                        _filterModel.statusList.contains(status),
                        onChanged: (value) {
                          setState(() {
                            if (value) {
                              _filterModel.statusList.add(status);
                            } else {
                              _filterModel.statusList.remove(status);
                            }
                          });
                        },
                      );
                    }).toList()),
              ),
            ],
          ),
        ),
        bottomNavigationBar: StadiumSolidWithTowButton(
          cancelText: "重置",
          onCancel: () {
            setState(() {
              _filterModel.startTime = null;
              _filterModel.endTime = null;
              _filterModel.statusList = List();
            });
          },
          conFirmText: "确定",
          onConFirm: () {
            if (widget.callback != null) widget.callback();
            Navigator.of(context).pop();
          },
          padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize30, vertical: UIData.spaceSize10),
        ));
  }
}