import 'package:cmp_customer/models/new_house_model.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/scoped_models/new_house_state_model.dart';
import 'package:cmp_customer/ui/common/common_bottom_input_view/bottom_input_view.dart';
import 'package:cmp_customer/ui/common/common_bottom_input_view/pop_route.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_dialog.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_image_display.dart';
import 'package:cmp_customer/ui/common/common_image_picker.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_picker.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_text_field.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/date_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../main.dart';
import 'new_house_car_info_content.dart';
import 'new_house_common_ui.dart';
import 'new_house_content_stepview1.dart';
import 'new_house_cust_info_content.dart';
import 'new_house_detail_node.dart';
import 'new_house_pet_info_content.dart';
import 'new_house_step_page.dart';

///
/// Created by qianlx on 2020/3/28 1:35 PM.
/// 新房入伙详情页面
///
class NewHouseDetailPage extends StatefulWidget {
  final NewHouseStateModel stateModel;
  final int id;

  NewHouseDetailPage(this.stateModel, this.id);

  @override
  _NewHouseDetailPageState createState() => _NewHouseDetailPageState();
}

class _NewHouseDetailPageState extends State<NewHouseDetailPage> {
  final TextEditingController _remarkController = TextEditingController();
  List<Attachment> _attachmentList; //验收房屋验收问题登记表附件
//  String _joinDate;

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
    widget.stateModel.getNewHouseDetail(widget.id, callback: (NewHouseDetail detail) {
      if (detail.checkCollectAttachmentList != null && detail.checkCollectAttachmentList.length > 0) {
        if(_attachmentList == null) _attachmentList = List();
        else _attachmentList.clear();
        _attachmentList.addAll(detail.checkCollectAttachmentList);
      }
    });
  }

  //撤回
  void _cancelAction() {
    CommonDialog.showAlertDialog(context,
        title: '撤回',
        content: '确认撤回新房入伙申请？',
        onConfirm: () => widget.stateModel.newHouseIsPass(
                {'houseJoinId': widget.stateModel?.newHouseDetail?.houseJoinId},
                newHouseType: NewHouseHttpType.CANCEL, callback: () {
              CommonToast.show(type: ToastIconType.SUCCESS, msg: '提交成功');
              finishThisPage();
            }));
  }

  //验收
  void _acceptAction() {
//    getBottomSheet(context, '确认验收', callback: () {
//
//    });
    if (_attachmentList == null || _attachmentList.length == 0) {
      CommonToast.show(type: ToastIconType.FAILED, msg: '请上传房屋验收问题登记表');
    } else if (StringsHelper.isEmpty(_remarkController.text)) {
      CommonToast.show(type: ToastIconType.FAILED, msg: '请先输入验收意见');
    } else {
      widget.stateModel.newHouseIsPass({
        'houseJoinId': widget.stateModel?.newHouseDetail?.houseJoinId,
        'recordAttachList': _attachmentList,
        'remark': _remarkController.text,
      }, newHouseType: NewHouseHttpType.ACCEPT, callback: () {
        CommonToast.show(type: ToastIconType.SUCCESS, msg: '提交成功');
        _remarkController.text = '';
//        _joinDate = '';
        _attachmentList = new List();
        finishThisPage();
//        if (stateModel.customerType == 1) {
          stateModel.reLogin();
//        }
      });
    }
  }

  void finishThisPage() {
    Navigate.closePage(true);
  }

  //修改申请（补充信息）
  void _modifyAction() {
    Navigate.toNewPage(
        NewHouseStepPage(
            (widget.stateModel.newHouseDetail?.processStatus == newHouseStatusDQR ||
                    widget.stateModel.newHouseDetail?.processStatus == newHouseStatusDXG)
                ? 0
                : 1,
            newHouseDetail: widget.stateModel.newHouseDetail), callBack: (bool value) {
      if (value != null && value) {
        _refreshData();
      }
    });
  }

  //验收操作内容
  Widget _buildExamine() {
    return Visibility(
        visible: widget.stateModel.newHouseDetail?.processStatus == newHouseStatusDYS ||
            (_attachmentList != null && _attachmentList.length > 0),
        child: Container(
          color: UIData.primaryColor,
          margin: EdgeInsets.only(top: UIData.spaceSize8),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: UIData.spaceSize16, top: UIData.spaceSize16),
                child: CommonText.darkGrey15Text(
                    '房屋验收问题登记表${widget.stateModel.newHouseDetail?.processStatus == newHouseStatusDYS ? '（必填）' : ''}'),
              ),
              Container(
                margin: EdgeInsets.all(UIData.spaceSize16),
                child: CommonImagePicker(
                  enableAddImage: widget.stateModel.newHouseDetail?.processStatus == newHouseStatusDYS,
                  attachmentList: _attachmentList,
                  callbackWithInfo: (List<Attachment> images) {
                    if (_attachmentList == null)
                      _attachmentList = List();
                    else
                      _attachmentList.clear();
                    _attachmentList.addAll(images);
                  },
                ),
              ),
              Visibility(
                  child: CommonDivider(),
                  visible: widget.stateModel.newHouseDetail?.processStatus == newHouseStatusDYS),
              Visibility(
                  child: FormMultipleTextField('验收意见', hintText: '请输入验收意见', controller: _remarkController),
                  visible: widget.stateModel.newHouseDetail?.processStatus == newHouseStatusDYS)
            ],
          ),
        ));
  }

  Widget _buildTop() {
    return Container(
      color: UIData.primaryColor,
      padding: EdgeInsets.only(bottom: UIData.spaceSize16, left: UIData.spaceSize16, right: UIData.spaceSize16),
      margin: EdgeInsets.only(bottom: UIData.spaceSize8),
      child: CommonText.text15(widget.stateModel?.newHouseDetail?.processStatusName ?? '',
          color: newHouseStatusToColorMap[widget.stateModel?.newHouseDetail?.processStatus] ?? UIData.yellowColor),
    );
  }

  //跟踪节点
  Widget _buildNode() {
    return Container(
      color: UIData.primaryColor,
      child: NewHouseDetailNode(widget.stateModel?.newHouseDetail?.recordList),
    );
  }

  Widget _buildContent() {
    return Container(
      child: ListView(
        children: <Widget>[
          _buildTop(),
          NewHouseContentStepview1(2, widget.stateModel.newHouseDetail),
          SizedBox(height: UIData.spaceSize16),
          NewHouseCustInfoContent(2, widget.stateModel.newHouseDetail),
          SizedBox(height: UIData.spaceSize16),
          Visibility(
            visible: widget.stateModel.newHouseDetail?.newHouseCarInfoList != null &&
                widget.stateModel.newHouseDetail.newHouseCarInfoList.length > 0,
            child: NewHouseCarInfoContent(2, widget.stateModel.newHouseDetail, widget.stateModel),
          ),
          Visibility(
            visible: widget.stateModel.newHouseDetail?.newHouseCarInfoList != null &&
                widget.stateModel.newHouseDetail.newHouseCarInfoList.length > 0,
            child: SizedBox(height: UIData.spaceSize16),
          ),
          Visibility(
            visible: widget.stateModel.newHouseDetail?.newHousePetInfoList != null &&
                widget.stateModel.newHouseDetail.newHousePetInfoList.length > 0,
            child: NewHousePetInfoContent(2, widget.stateModel.newHouseDetail),
          ),
          Visibility(
            visible: widget.stateModel.newHouseDetail?.newHousePetInfoList != null &&
                widget.stateModel.newHouseDetail.newHousePetInfoList.length > 0,
            child: SizedBox(height: UIData.spaceSize16),
          ),
          _buildNode(),
          SizedBox(height: UIData.spaceSize16),
          Visibility(
            visible: StringsHelper.isNotEmpty(widget.stateModel.newHouseDetail?.decideDate),
            child: CommonSelectSingleRow('商定入伙时间',
                hintText: '', content: widget.stateModel.newHouseDetail?.decideDate ?? '', arrowVisible: false),
          ),
          _buildExamine(),
//          Visibility(
//            visible: widget.stateModel.newHouseDetail?.checkCollectAttachmentList != null &&
//                widget.stateModel.newHouseDetail.checkCollectAttachmentList.length > 0,
//            child: Container(
//              color: UIData.primaryColor,
//              margin: EdgeInsets.only(top: UIData.spaceSize8),
//              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.stretch,
//                children: <Widget>[
//                  Container(
//                    padding: EdgeInsets.only(left: UIData.spaceSize16, top: UIData.spaceSize16),
//                    child: CommonText.darkGrey15Text('上传房屋验收问题登记表'),
//                  ),
//                  Container(
//                    margin: EdgeInsets.all(UIData.spaceSize16),
//                    child: CommonImageDisplay(
//                        photoIdList: widget.stateModel.newHouseDetail?.checkCollectAttachmentList
//                            ?.map((Attachment attach) => attach?.attachmentUuid)
//                            ?.toList()),
//                  ),
////                  CommonDivider(),
////                  FormMultipleTextField('验收意见',
////                      hintText: '请输入验收意见', controller: _remarkController)
//                ],
//              ),
//            ),
//          ),
//          SizedBox(height: UIData.spaceSize16),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return CommonLoadContainer(
      state: widget.stateModel.newHouseInfoState,
      content: _buildContent(),
      callback: _refreshData,
    );
  }

  Widget _buildBottomNavigationBar() {
    if (widget.stateModel.newHouseInfoState == ListState.HINT_DISMISS) {
      /// 待审核、审核不通过有撤回和修改申请按钮
      if (widget.stateModel.newHouseDetail?.processStatus == newHouseStatusDQR ||
          widget.stateModel.newHouseDetail?.processStatus == newHouseStatusDXG) {
        return StadiumSolidWithTowButton(
            conFirmText: '修改申请',
            cancelText: '撤回',
            onConFirm: () => _modifyAction(),
            onCancel: () => _cancelAction());
      }
      //待验收有撤回、验收、补充信息三个按钮
      else if (widget.stateModel.newHouseDetail?.processStatus == newHouseStatusDYS)
        return StadiumSolidWithThreeButton(
            conFirmText: '验收',
            cancelText: '撤回',
            editText: '补充信息',
            onConFirm: () => _acceptAction(),
            onCancel: () => _cancelAction(),
            onEdit: () => _modifyAction());
      else
        return null;
    } else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<NewHouseStateModel>(
      model: widget.stateModel,
      child: ScopedModelDescendant<NewHouseStateModel>(
        builder: (context, child, model) {
          return CommonScaffold(
            appTitle: '新房入伙详情',
            bodyData: _buildBody(),
            bottomNavigationBar: _buildBottomNavigationBar(),
          );
        },
      ),
    );
  }
}
