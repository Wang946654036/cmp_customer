import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/office_cancel_lease_detail_model.dart';
import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/strings/strings_articles_release.dart';
import 'package:cmp_customer/strings/strings_office_cancel_lease.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_dialog.dart';
import 'package:cmp_customer/ui/common/common_image_display.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text_field.dart';
import 'package:cmp_customer/ui/office_cancel_lease/office_cancel_lease_apply_page.dart';
import 'package:cmp_customer/ui/office_cancel_lease/office_cancel_lease_detail_node.dart';
import 'package:cmp_customer/ui/office_cancel_lease/rectify_complete_page.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

///
/// 物品放行详情
///
class OfficeCancelLeaseDetailPage extends StatefulWidget {
  final int officeSurrenderId;
  final Function callback;

  OfficeCancelLeaseDetailPage(this.officeSurrenderId, {this.callback});

  @override
  _OfficeCancelLeaseDetailPageState createState() => _OfficeCancelLeaseDetailPageState();
}

class _OfficeCancelLeaseDetailPageState extends State<OfficeCancelLeaseDetailPage> {
  OfficeCancelLeasePageModel _pageModel = OfficeCancelLeasePageModel();

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _refreshData() {
    stateModel.getOfficeCancelLeaseDetail(widget.officeSurrenderId, _pageModel);
  }

//  Widget _buildTop() {
//    return Container(
//      color: UIData.primaryColor,
////      padding: EdgeInsets.only(bottom: UIData.spaceSize16),
//      child: Column(
//        crossAxisAlignment: CrossAxisAlignment.center,
//        children: <Widget>[
//          CommonText.darkGrey18Text(officeCancelLeaseStatusMap[_pageModel.officeCancelLeaseDetail?.status] ?? ''),
//          SizedBox(height: UIData.spaceSize12),
//          Visibility(
//              // 显示二维码：审核通过/放行通过/放行不通过
//              visible: _pageModel.officeCancelLeaseDetail?.status == articlesReleaseStatusMap.keys.toList()[2] ||
//                  _pageModel.officeCancelLeaseDetail?.status == articlesReleaseStatusMap.keys.toList()[3] ||
//                  _pageModel.officeCancelLeaseDetail?.status == articlesReleaseStatusMap.keys.toList()[4],
//              child: Column(
//                children: <Widget>[
//                  QrImage(
//                    size: ScreenUtil.screenWidthDp / 3,
//                    padding: EdgeInsets.zero,
//                    version: 2,
//                    //二维码版本，越高可显示字符越多
//                    data: StringsHelper.enum2String(QRCodeType.ArticlesRelease) +
//                        '_' +
//                        widget.releasePassId.toString(),
//                    onError: (ex) {
//                      setState(() {
//                        LogUtils.printLog('二维码生成失败：$ex');
//                      });
//                    },
//                  ),
//                  SizedBox(height: UIData.spaceSize12),
//                  CommonText.red14Text(_pageModel.officeCancelLeaseDetail?.outTime != null
//                      ? '有效期${StringsHelper.formatterYMD.format(DateTime.parse(_pageModel.officeCancelLeaseDetail?.outTime).add(Duration(days: -1)))}'
//                          '至${StringsHelper.formatterYMD.format(DateTime.parse(_pageModel.officeCancelLeaseDetail?.outTime).add(Duration(days: 1)))}'
//                      : ''),
//                  SizedBox(height: UIData.spaceSize12),
//                ],
//              )),
//          Visibility(
//              // 温馨提示和分享：审核通过显示
//              visible: _pageModel.officeCancelLeaseDetail?.status == articlesReleaseStatusMap.keys.toList()[2],
//              child: Column(
//                children: <Widget>[
//                  CommonText.lightGrey12Text('温馨提示：1、出门时，请向门岗出示此二维码；\n2、请在有效期内使用，否则门岗将不允放行。'),
//                  SizedBox(height: UIData.spaceSize12),
//                  CommonFullScaleDivider(),
//                  FlatButton(onPressed: () {}, child: CommonText.red16Text('分享')),
//                ],
//              )),
//          Visibility(//审核不通过显示审核意见
//              visible: _pageModel.officeCancelLeaseDetail?.status == articlesReleaseStatusMap.keys.toList()[1],
//              child: CommonText.grey14Text(_pageModel.officeCancelLeaseDetail?.remark ?? ''))
//        ],
//      ),
//    );
//  }

  Widget _buildDetail() {
    return Container(
      color: UIData.primaryColor,
      padding: EdgeInsets.all(UIData.spaceSize16),
      child: Column(
        children: <Widget>[
          DetailSingleRow('业务单号', _pageModel.officeCancelLeaseDetail?.businessNo ?? ''),
          DetailSingleRow('办理进度', officeCancelLeaseStatusMap[_pageModel.officeCancelLeaseDetail?.status] ?? ''),
          //审核意见：审核不通过才显示
          Visibility(
              visible: _pageModel.officeCancelLeaseDetail?.status == officeCancelLeaseStatusMap.keys.toList()[2],
              child: DetailSingleRow('审核意见', _pageModel.officeCancelLeaseDetail?.remark ?? '')),
          DetailSingleRow('退租房屋', _pageModel.officeCancelLeaseDetail?.submitHouse?.replaceAll(',', '\n') ?? ''),
          DetailSingleRow('申请时间', _pageModel.officeCancelLeaseDetail?.createTime ?? ''),
          DetailSingleRow('退租日期', _pageModel.officeCancelLeaseDetail?.surrenderTime ?? ''),
          DetailSingleRow('可交验日期', _pageModel.officeCancelLeaseDetail?.checkTime ?? ''),
          DetailSingleRow('证明资料', null),
          Container(
            padding: EdgeInsets.only(bottom: UIData.spaceSize12),
            child: CommonImageDisplay(photoIdList: _pageModel.officeCancelLeaseDetail?.attApplyList),
          ),
          DetailSingleRow(
              '备注',
              _pageModel.officeCancelLeaseDetail?.recordList?.lastWhere((RecordInfo info) {
                return info?.operateStep == officeCancelLeaseOperateStepMap.keys.toList()[0] ||
                    info?.operateStep == officeCancelLeaseOperateStepMap.keys.toList()[1];
              })?.remark)
        ],
      ),
    );
  }

  //跟踪节点
  Widget _buildNode() {
    return Container(
      color: UIData.primaryColor,
      child: OfficeCancelLeaseNode(_pageModel.officeCancelLeaseDetail?.recordList),
    );
  }

  Widget _buildContent() {
    return Container(
//      color: UIData.primaryColor,
      child: ListView(
//        padding: EdgeInsets.only(top: UIData.spaceSize16),
        shrinkWrap: true,
        children: <Widget>[
//          _buildTop(),
          SizedBox(height: UIData.spaceSize8),
          _buildDetail(),
          SizedBox(height: UIData.spaceSize8),
          _buildNode(),
          SizedBox(height: UIData.spaceSize8),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return CommonLoadContainer(
      state: _pageModel.pageState,
      content: _buildContent(),
      callback: _refreshData,
    );
  }

  //修改申请的提交
  void _modifyApplication() {
    Navigate.toNewPage(OfficeCancelLeaseApplyPage(applyModel: _pageModel.officeCancelLeaseDetail),
        callBack: (bool value) {
      if (value != null && value) {
        LogUtils.printLog('OfficeCancelLeaseApplyPage callBack');
        _refreshData();
        if (widget.callback != null) widget.callback();
      }
    });
  }

  //取消申请
  void _cancelApplication() {
    CommonDialog.showAlertDialog(context,
        title: '取消申请',
        content: '确认取消该退租申请？',
        onConfirm: () => stateModel.cancelOfficeCancelLease(widget.officeSurrenderId, callBack: widget.callback));
  }

  //再次提交申请
  void _reApply() {
    CommonDialog.showAlertDialog(context, title: '确认提交', content: '确定提交该退租申请？', onConfirm: () {
      stateModel.applyOfficeCancelLease(applyModel: _pageModel.officeCancelLeaseDetail, newCreate: false);
    });
  }

  //跳转到整改完成
  void _go2RectifyComplete() {
    Navigate.toNewPage(RectifyCompletePage(_pageModel.officeCancelLeaseDetail?.officeSurrenderId),
        callBack: (bool value) {
      if (value != null && value) {
        _refreshData();
        if (widget.callback != null) widget.callback();
      }
    });
  }

  Widget _buildBottomNavigationBar(String status) {
    //待审核：显示修改申请和取消申请两个按钮
    if (status == officeCancelLeaseStatusMap.keys.toList()[0]) {
      return StadiumSolidWithTowButton(
          conFirmText: '修改申请',
          cancelText: '取消申请',
          onConFirm: () => _modifyApplication(),
          onCancel: () => _cancelApplication());
    } else if (status == officeCancelLeaseStatusMap.keys.toList()[2]) {
      //审核不通过显示修改申请，再次提交，取消申请三个按钮
      return StadiumSolidWithThreeButton(
          conFirmText: '修改申请',
          editText: '再次提交',
          cancelText: '取消申请',
          onConFirm: () => _modifyApplication(),
          onEdit: () => _reApply(),
          onCancel: () => _cancelApplication());
    } else if (status == officeCancelLeaseStatusMap.keys.toList()[3]) {
      //交验不通过时显示整改完成按钮
      return StadiumSolidButton('整改完成', onTap: () => _go2RectifyComplete());
    } else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
      return CommonScaffold(
        appTitle: '写字楼退租详情',
        bodyData: _buildBody(),
        //待审核和审核不通过才显示修改申请和取消办理按钮
        bottomNavigationBar: _pageModel.pageState == ListState.HINT_DISMISS
            ? _buildBottomNavigationBar(_pageModel.officeCancelLeaseDetail?.status)
            : null,
      );
    });
  }
}

class OfficeCancelLeasePageModel {
  OfficeCancelLeaseDetail officeCancelLeaseDetail = OfficeCancelLeaseDetail();
  ListState pageState = ListState.HINT_LOADING;
}
