import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/hot_work_detail_model.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/scoped_models/images_state_model.dart';
import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/strings/strings_common.dart';
import 'package:cmp_customer/strings/strings_hot_work.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_dialog.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text_field.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/common/scrawl_page/scrawl_page.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_state.dart';
import 'package:cmp_customer/ui/hot_work/hot_work_apply_page.dart';
import 'package:cmp_customer/ui/hot_work/hot_work_detail_node.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/share_util.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

///
/// 动火申请详情
/// [customerType] 查询类型，业主查询租户申请：0，查询自己的申请：1
/// [isLicence]是否动火许可证
/// [welderName]动火作业人,进入动火许可证可用
/// [welderId]动火作业人id,进入动火许可证可用
/// [toOwnerAgree]消息推送和消息列表跳转进来使用，等于1是待业主同意，否则是0
///
class HotWorkDetailPage extends StatefulWidget {
  final int id;
  final Function callback;
  final int customerType;
  final bool isLicence;
  final HotWorkDetail hotWorkDetail;
  final String welderName;
  final int welderId;
  final String toOwnerAgree;

  HotWorkDetailPage(this.id,
      {this.customerType,
      this.callback,
      this.isLicence = false,
      this.hotWorkDetail,
      this.welderName,
      this.welderId,
      this.toOwnerAgree});

  @override
  _HotWorkDetailPageState createState() => _HotWorkDetailPageState();
}

class _HotWorkDetailPageState extends State<HotWorkDetailPage> {
  HotWorkPageModel _pageModel = HotWorkPageModel();
  final TextEditingController _remarkController = TextEditingController();
  final GlobalKey _shareWidgetKey = GlobalKey();

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
    if (widget.isLicence) {
      _pageModel.hotWorkDetail = widget.hotWorkDetail;
      _pageModel.pageState = ListState.HINT_DISMISS;
    } else {
      stateModel.getHotWorkDetail(widget.id, _pageModel);
    }
  }

  //动火许可证页面则显示二维码
  Widget _buildTop() {
    return Visibility(
        // 显示二维码：动火许可证
        visible: widget.isLicence,
        child: Container(
          color: UIData.primaryColor,
          child: Column(
            children: <Widget>[
              SizedBox(height: UIData.spaceSize12),
              QrImage(
                size: ScreenUtil.screenWidthDp / 3,
                padding: EdgeInsets.zero,
                version: 2,
                //二维码版本，越高可显示字符越多
                data: StringsHelper.enum2String(QRCodeType.HotWork) +
                    '_' +
                    widget.id.toString() +
                    '_' +
                    widget.welderId.toString(),
                onError: (ex) {
//                setState(() {
                  LogUtils.printLog('二维码生成失败：$ex');
//                });
                },
              ),
              SizedBox(height: UIData.spaceSize12),
            ],
          ),
        ));
  }

  Widget _buildDetail() {
    return Container(
      color: UIData.primaryColor,
      padding: EdgeInsets.all(UIData.spaceSize16),
      child: Column(
        children: <Widget>[
//          Visibility(child: DetailSingleRow('动火作业人', widget.welderName), visible: widget.isLicence),
          DetailSingleRow('业务单号', _pageModel.hotWorkDetail?.hotWorkNo),
          DetailSingleRow('办理进度', _pageModel.hotWorkDetail?.processStateName),
          DetailSingleRow('申请时间', _pageModel.hotWorkDetail?.createTime),
          DetailSingleRow(
              '房屋', (_pageModel.hotWorkDetail?.formerName ?? '') + (_pageModel.hotWorkDetail?.houseName ?? '')),
          DetailSingleRow('作业内容', _pageModel.hotWorkDetail?.hotWorkContent),
          DetailSingleRow('动火位置/地点', _pageModel.hotWorkDetail?.hotWorkLocation),
          DetailSingleRow('施工单位', _pageModel.hotWorkDetail?.constructionUnit),
          DetailSingleRow('现场负责人', _pageModel.hotWorkDetail?.onSiteLeader),
          DetailSingleRow('动火防火责任人', _pageModel.hotWorkDetail?.firePreventMan),
          DetailSingleRow('看火人', _pageModel.hotWorkDetail?.fireWatchMan),
          DetailSingleRow('动火开始时间', _pageModel.hotWorkDetail?.hotWorkStartTime),
          DetailSingleRow('动火结束时间', _pageModel.hotWorkDetail?.hotWorkEndTime),
        ],
      ),
    );
  }

  //动火许可证的内容
  Widget _buildLicenceDetail() {
    return Container(
      color: UIData.primaryColor,
      padding: EdgeInsets.all(UIData.spaceSize16),
      child: Column(
        children: <Widget>[
          DetailSingleRow('所属项目', _pageModel.hotWorkDetail?.formerName),
          DetailSingleRow('房号', _pageModel.hotWorkDetail?.houseName),
          DetailSingleRow(
              '动火时间',
              StringsHelper.subString2YMDHM(_pageModel.hotWorkDetail?.hotWorkStartTime) +
                  ' ~ ' +
                  StringsHelper.subString2YMDHM(_pageModel.hotWorkDetail?.hotWorkEndTime)),
          DetailSingleRow('动火位置/地点', _pageModel.hotWorkDetail?.hotWorkLocation),
          DetailSingleRow('施工单位', _pageModel.hotWorkDetail?.constructionUnit),
          DetailSingleRow('现场负责人', _pageModel.hotWorkDetail?.onSiteLeader),
          DetailSingleRow('看火人', _pageModel.hotWorkDetail?.fireWatchMan),
          DetailSingleRow('动火防火责任人', _pageModel.hotWorkDetail?.firePreventMan),
          DetailSingleRow('动火作业人员', widget.welderName),
          DetailSingleRow('作业内容', _pageModel.hotWorkDetail?.hotWorkContent),
        ],
      ),
    );
  }

//  //跟踪节点
  Widget _buildNode() {
    return Offstage(
        child: Container(
          color: UIData.primaryColor,
          child: HotWorkNode(_pageModel.hotWorkDetail?.recordList),
        ),
        offstage: widget.isLicence);
  }

  //动火员工列表
  Widget _buildWelderList() {
    return Visibility(
        visible: _pageModel?.hotWorkDetail?.welderList != null &&
            _pageModel.hotWorkDetail.welderList.length > 0 &&
            !widget.isLicence,
        child: ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: UIData.spaceSize16),
            itemCount: _pageModel?.hotWorkDetail?.welderList?.length ?? 0,
            itemBuilder: (context, index) {
//              WelderInfo welderInfo = _applyModel.welderList[index];
              return WelderCard(index, _pageModel?.hotWorkDetail, false);
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: UIData.spaceSize16);
            }));
  }

  Widget _buildContent() {
    return RepaintBoundary(
      key: _shareWidgetKey,
//      color: UIData.primaryColor,
      child: ListView(
//        padding: EdgeInsets.only(top: UIData.spaceSize16),
        shrinkWrap: true,
        children: <Widget>[
          _buildTop(),
          widget.isLicence ? _buildLicenceDetail() : _buildDetail(),
          _buildWelderList(),
          _buildRemark(),
          SizedBox(height: UIData.spaceSize12),
          _buildNode(),
        ],
      ),
    );
  }

  //审核意见
  Widget _buildRemark() {
    return Visibility(
        //待业主审核并且是租户申请才显示审核意见
        visible: (widget.customerType == 0 || widget.toOwnerAgree == '1') &&
            _pageModel.hotWorkDetail?.processState == hotWorkToOwnerAgree,
        child: Container(
          margin: EdgeInsets.only(top: UIData.spaceSize12),
          child: FormMultipleTextField('审核意见', hintText: '若审核不通过，请务必写明缘由', controller: _remarkController),
        ));
  }

  Widget _buildBody() {
    return CommonLoadContainer(
      state: _pageModel.pageState,
      content: _buildContent(),
      callback: _refreshData,
    );
  }

  //取消申请
  void _cancelAction() {
    CommonDialog.showAlertDialog(context,
        title: '取消申请',
        content: '确认取消该动火申请？',
        onConfirm: () =>
            stateModel.changeHotWorkStatus(widget.id, hotWorkOperateStepCancel, callBack: widget.callback));
  }

  Widget _buildBottomNavigationBar() {
    if (_pageModel.pageState == ListState.HINT_DISMISS) {
      ///除了已签证和已取消外都可以都显示取消申请按钮
      ///业主不同意、物业初审不通过、物业专审不通过都可以修改申请，
      ///本单是租户提交的并且是待业主同意，本单是业主提交的并且是待物业初审都可以修改申请
      if ((widget.customerType == 1 || widget.toOwnerAgree == "0") &&
          (_pageModel.hotWorkDetail?.processState != hotWorkHasApproved &&
              _pageModel.hotWorkDetail?.processState != hotWorkHasCancel)) {
        if ((_pageModel.hotWorkDetail?.processState == hotWorkOwnerDisagree ||
                _pageModel.hotWorkDetail?.processState == hotWorkProFirstAuditFail ||
                _pageModel.hotWorkDetail?.processState == hotWorkProSecondAuditFail) ||
            (_pageModel.hotWorkDetail?.applyType == customerYZ &&
                _pageModel.hotWorkDetail?.processState == hotWorkToProFirstAudit) ||
            (_pageModel.hotWorkDetail?.applyType == customerZH &&
                _pageModel.hotWorkDetail?.processState == hotWorkToOwnerAgree)) {
          return StadiumSolidWithTowButton(
              conFirmText: '修改申请',
              cancelText: '取消申请',
              onConFirm: () => Navigate.toNewPage(HotWorkApplyPage(applyModel: _pageModel.hotWorkDetail),
                      callBack: (bool value) {
                    if (value != null && value) {
                      _refreshData();
                      Navigate.closePage(true);
                    }
                  }),
              onCancel: () => _cancelAction());
        } else {
          return StadiumSolidButton('取消申请', onTap: () => _cancelAction());
        }
      }
      //待业主同意状态并且租户申请列表进来，则显示同意和不同意按钮
      else if ((widget.customerType == 0 || widget.toOwnerAgree == "1") &&
          _pageModel.hotWorkDetail?.processState == hotWorkToOwnerAgree)
        return StadiumSolidWithTowButton(
            conFirmText: '同意',
            cancelText: '不同意',
            onConFirm: () {
              Navigate.toNewPage(ScrawlPage(), callBack: (path) {
                if (path != null && path is String && StringsHelper.isNotEmpty(path))
                  ImagesStateModel().uploadFile(path, (data) {
                    CommonToast.dismiss();
                    Attachment info = Attachment.fromJson(data);
                    List attDhYzSignList = List();
                    attDhYzSignList.add(info);
                    stateModel.changeHotWorkStatus(widget.id, _pageModel.hotWorkDetail?.processNodeCode,
                        passFlag: 1,
                        remark: _remarkController.text,
                        callBack: widget.callback,
                        attDhYzSignList: attDhYzSignList);
                  }, (data) {
                    CommonToast.show(type: ToastIconType.FAILED, msg: data?.toString() ?? "");
                  });
              });
            },
            onCancel: () {
              if (_remarkController.text == null || _remarkController.text.isEmpty)
                CommonToast.show(msg: '请输入审核意见', type: ToastIconType.INFO);
              else {
                stateModel.changeHotWorkStatus(widget.id, _pageModel.hotWorkDetail?.processNodeCode,
                    passFlag: 0, remark: _remarkController.text, callBack: widget.callback);
              }
            });
      else if (widget.isLicence)
        return StadiumSolidButton('分享', onTap: () {
          ShareUtil.shareWidget(_shareWidgetKey);
        });
      else
        return null;
    } else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
      return CommonScaffold(
        appTitle: widget.isLicence ? '动火许可证' : '动火申请详情',
        bodyData: _buildBody(),
        //待审核和审核不通过才显示修改申请和取消办理按钮
        bottomNavigationBar: _buildBottomNavigationBar(),
      );
    });
  }
}

class HotWorkPageModel {
  HotWorkDetail hotWorkDetail = HotWorkDetail();
  ListState pageState = ListState.HINT_LOADING;
}
