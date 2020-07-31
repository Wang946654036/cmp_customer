///申请详情
///
///
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/change_title_obj.dart';
import 'package:cmp_customer/models/decoration_obj.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/scoped_models/decoration_model.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_image_display.dart';
import 'package:cmp_customer/ui/common/common_image_picker.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/decorate_manager/decoration_permit/decoration_check_apply.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../decoration_ui.dart';
import 'decoration_apply_create.dart';
import 'decoration_permit_detail.dart';
import 'node_listview.dart';
//详情页面
class DecorationApplyDetailPage extends StatefulWidget {
  int infoId;
  DecorationModel _model;
bool isCheckZK ;
  DecorationApplyDetailPage(this._model, this.infoId, {this.isCheckZK=false});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DecorationApplyDetailPageState();
  }
}

class _DecorationApplyDetailPageState extends State<DecorationApplyDetailPage> {
//  double payFees = 500.00;
  List<Attachment> attPhotoList = new List();

  TextEditingController remarkController = new TextEditingController();
  TextEditingController feeController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    if (widget._model.decorationInfo == null)
      widget._model.getDecorationInfo(widget.infoId);
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModel<DecorationModel>(
        model: widget._model,
        child: ScopedModelDescendant<DecorationModel>(
            builder: (context, child, model) {
          DecorationInfo info = model.decorationInfo;
          return CommonScaffold(
              appTitle: "装修许可证申请详情",
              bodyData: _buildBody(),
              appBarActions: <Widget>[
                Visibility(
                    visible: (info?.state ?? '暂无') == wyauditSuc,
                    child: FlatButton(
                        onPressed: () {
                          Navigate.toNewPage(
                            new DecorationPermitDetail(info.id),
                          );
                        },
                        child: CommonText.red15Text('装修许可证')))
              ],
              bottomNavigationBar:model.decorationInfoState==ListState.HINT_DISMISS? Row(
                children: <Widget>[
                  //租客待业主审核，业主不通过
                  Visibility(
                    visible: (info?.canOperation??false)&&!widget.isCheckZK&&info?.applyType==2&&((info?.state ?? '暂无') == yzauditFailed||(info?.state ?? '暂无') == yzauditWaiting),
                    child:
                    Expanded(child: StadiumSolidWithTowButton(
                      cancelText: label_cansol,
                      onCancel: () {
                        model.decorationIsPass({
                          'id': info.id,
                          'status': '2',
                          'checkRole':info.bpmCurrentRole,
                          'acceptanceId':info.acceptanceId,
                          'acceptanceCheckRole':info.acceptanceCheckRole
                        }, decorationType: DecorationHttpType.CHANGE);
                      },
                      conFirmText: label_edit,
                      onConFirm: () {

                        Navigate.toNewPage(
                            new DecorationApplyCreate(
                              decorationInfo: info,
                            ), callBack: (flag) {
                          if(flag!=null&&flag is bool&&flag)
                            Navigate.closePage(true);
                        });
                      },
                    )),

                  ),
                  //二轮三轮待审核
                  Visibility(
                    visible: !widget.isCheckZK&&info?.bpmCurrentRole!='wuye1'&&(info?.state ?? '暂无') == wyauditWaiting,
                    child:
                    Expanded(child: StadiumSolidButton(
                      label_cansol,
                      btnType: ButtonType.CONFIRM,
                      onTap: () {
                        model.decorationIsPass({
                          'id': info.id,
                          'status': '2',
                          'checkRole':info.bpmCurrentRole,
                          'acceptanceId':info.acceptanceId,
                          'acceptanceCheckRole':info.acceptanceCheckRole
                        }, decorationType: DecorationHttpType.CHANGE);
                      },
                    ),),
                  ),
                  //一轮待审核(租户)
                  Visibility(
                    visible: !widget.isCheckZK&&info?.bpmCurrentRole=='wuye1'&&info?.applyType==2&&(info?.state ?? '暂无') == wyauditWaiting,
                    child:Expanded(child: StadiumSolidButton(
                      label_cansol,
                      btnType: ButtonType.CONFIRM,
                      onTap: () {
                        model.decorationIsPass({
                          'id': info.id,
                          'status': '2',
                          'checkRole':info.bpmCurrentRole,
                          'acceptanceId':info.acceptanceId,
                          'acceptanceCheckRole':info.acceptanceCheckRole
                        }, decorationType: DecorationHttpType.CHANGE);
                      },
                    ),),


                  ),
                  //一轮待审核(业主)
                  Visibility(
                      visible: !widget.isCheckZK&&info?.bpmCurrentRole=='wuye1'&&info?.applyType==1&&(info?.state ?? '暂无') == wyauditWaiting,
                      child:
                      Expanded(child: StadiumSolidWithTowButton(
                        cancelText: label_cansol,
                        onCancel: () {
                          model.decorationIsPass({
                            'id': info.id,
                            'status': '2',
                            'checkRole':info.bpmCurrentRole,
                            'acceptanceId':info.acceptanceId,
                            'acceptanceCheckRole':info.acceptanceCheckRole
                          }, decorationType: DecorationHttpType.CHANGE);
                        },
                        conFirmText: label_edit,
                        onConFirm: () {

                          Navigate.toNewPage(
                              new DecorationApplyCreate(
                                decorationInfo: info,
                              ), callBack: (flag) {
if(flag!=null&&flag is bool&&flag)
                            Navigate.closePage(true);
                          });
                        },
                      )),

                      ),
                  //审核不通过
                  Visibility(
                    visible: (info?.state ?? '暂无') == wyauditFailed,
                    child:
                    Expanded(child: StadiumSolidWithTowButton(
                      cancelText: label_cansol,
                      onCancel: () {
                        model.decorationIsPass({
                          'id': info.id,
                          'status': '2',
                          'checkRole':info.bpmCurrentRole,
                          'acceptanceId':info.acceptanceId,
                          'acceptanceCheckRole':info.acceptanceCheckRole
                        }, decorationType: DecorationHttpType.CHANGE);
                      },
                      conFirmText: label_edit,
                      onConFirm: () {

                        Navigate.toNewPage(
                            new DecorationApplyCreate(
                              decorationInfo: info,
                            ), callBack: (flag) {
                          if(flag!=null&&flag is bool&&flag)
                            Navigate.closePage(true);
                        });
                      },
                    )),

                  ),
                  Visibility(
                    visible: widget.isCheckZK&&(info?.state ?? '暂无') == yzauditWaiting,
                    child:
                    Expanded(child: StadiumSolidWithTowButton(
                      cancelText: label_disagree,
                      onCancel: () {
                        model.decorationIsPass({
                          'id': info.id,
                          'status': '0',
                          'checkRole':info.bpmCurrentRole,
                          'acceptanceId':info.acceptanceId,
                          'acceptanceCheckRole':info.acceptanceCheckRole
                        }, decorationType: DecorationHttpType.CHANGE);
                      },
                      conFirmText: label_agree,
                      onConFirm: () {
                        model.decorationIsPass({
                          'id': info.id,
                          'status': '1',
                          'checkRole':info.bpmCurrentRole,
                          'acceptanceId':info.acceptanceId,
                          'acceptanceCheckRole':info.acceptanceCheckRole
                        }, decorationType: DecorationHttpType.CHANGE);
                      },
                    )),

                  ),
              Visibility(
              visible: (info?.state ?? '暂无') == payWaiting,
              child:Expanded(child: StadiumSolidButton(
                label_cansol,
                btnType: ButtonType.CONFIRM,
                onTap: () {
                  model.decorationIsPass({
                    'id': info.id,
                    'status': '2',
                    'checkRole':info.bpmCurrentRole,
                    'acceptanceId':info.acceptanceId,
                    'acceptanceCheckRole':info.acceptanceCheckRole
                  }, decorationType: DecorationHttpType.CHANGE);
                },
              ),),


              ),


//发起验收
                  Visibility(
                    visible: !widget.isCheckZK&&(info?.state ?? '暂无') == wyauditSuc,
                    child:Expanded(child: StadiumSolidButton(
                      label_submit,
                      btnType: ButtonType.CONFIRM,
                      onTap: () {
                       Navigate.toNewPage(DecorationCheckApply(model: model,decorationInfo: info,),callBack: (flag){
                         if(flag!=null&&flag is bool&&flag)
                           Navigate.closePage(true);
                       });
                      },
                    ),),
                  ),
                ],
              ):null);
        }));
  }

  Widget _buildBody() {
    return ScopedModelDescendant<DecorationModel>(
        builder: (context, child, model) {
      return CommonLoadContainer(
        state:model.decorationInfoState,
        callback: () {
          model.getDecorationInfo(widget.infoId);
        },
        content: _buildContent(),
      );
    });
  }

  Widget _buildContent() {
    return ScopedModelDescendant<DecorationModel>(
        builder: (context, child, model) {
      DecorationInfo info = model.decorationInfo;
      return SingleChildScrollView(
        child: Column(children: <Widget>[
          //申请基本信息
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
                  label: oddNumber,
                  text: info.oddNumber ?? '暂无',
                  topSpacing: UIData.spaceSize12,
                ),
                labelTextWidget(
                  label: applyTime,
                  text: info.applyDate ?? '暂无',
                  topSpacing: UIData.spaceSize12,
                ),
                labelTextWidget(
                  label: houseName,
                  text: info.houseName ?? '暂无',
                  topSpacing: UIData.spaceSize12,
                ),
                labelTextWidget(
                  label: houseCustName,
                  text: info.houseCustName ?? '暂无',
                  topSpacing: UIData.spaceSize12,
                ),
                labelTextWidget(
                  label: decorateType,
                  text: (info.decorateType ?? 0) == 1 ? '装修公司' : '自装',
                  topSpacing: UIData.spaceSize12,
                ),
                labelTextWidget(
                  label: workDayLong,
                  text: info.workDayLong==null? '暂无':'${info.workDayLong.toString()}天',
                  topSpacing: UIData.spaceSize12,
                ),
                labelTextWidget(
                  label: beginWorkDate,
                  text: info.beginWorkDate ?? '暂无',
                  topSpacing: UIData.spaceSize12,
                ),
                labelTextWidget(
                  label: workPeopleNum,
                  text: info.workPeopleNum?.toString()?? '暂无',
                  topSpacing: UIData.spaceSize12,
                ),
                labelTextWidget(
                  label: label_apply_deal_progress,
                  text: getStateStr(info?.state??''),
                  topSpacing: UIData.spaceSize12,
                ),
              ])),

          //申请人信息
          Container(
              color: UIData.primaryColor,
              margin: EdgeInsets.only(top: UIData.spaceSize12),
              padding: EdgeInsets.symmetric(vertical: UIData.spaceSize12),
              child: Column(
                children: <Widget>[
                  leftTextWidget(
                    text: '申请人信息',
                    color: UIData.greyColor,
                    fontSize: UIData.fontSize17,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            labelTextWidget(
                              label: custName,
                              text: info.custName ?? '暂无',
                              topSpacing: UIData.spaceSize12,
                            ),
                            labelTextWidget(
                              label: custPhone,
                              text: info.custPhone ?? '暂无',
                              topSpacing: UIData.spaceSize12,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Image.asset(UIData.imagePhone),
                        onPressed: () {
                          if (StringsHelper.isNotEmpty(info?.custPhone)) {
                            stateModel.callPhone(info?.custPhone);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              )),

//施工单位信息
          Container(
              margin: EdgeInsets.only(top: UIData.spaceSize12),
              color: UIData.primaryColor,
              padding: EdgeInsets.only(bottom: UIData.spaceSize12,top: UIData.spaceSize12),
              child: Column(children: <Widget>[
                leftTextWidget(
                  text: '施工单位信息',
                  color: UIData.greyColor,
                  fontSize: UIData.fontSize17,
                ),
                labelTextWidget(
                  label: workCompany,
                  text: info.workCompany ?? '暂无',
                  topSpacing: UIData.spaceSize12,
                ),
                labelTextWidget(
                  label: companyPaperNumber,
                  text: info.companyPaperNumber ?? '暂无',
                  topSpacing: UIData.spaceSize12,
                ),
                Visibility(visible: info.companyPapers!=null&&info.companyPapers.length>0,child:  leftTextWidget(
                  text: '证件照',
                  topSpacing: UIData.spaceSize12,
                ),),

                Visibility(visible: info.companyPapers!=null&&info.companyPapers.length>0,child: Container(
                  margin: EdgeInsets.all(UIData.spaceSize16),
                  child: CommonImageDisplay(
                      photoIdList: getFileList(info.companyPapers)),
                ),),

                labelTextWidget(
                  label: credentialNumber,
                  text: info.credentialNumber ?? '暂无',
                  topSpacing: UIData.spaceSize12,
                ),
                Visibility(
                  visible: info.credentialPapers != null &&
                      info.credentialPapers.length > 0,
                  child: leftTextWidget(
                    text: '资质证书',
                    topSpacing: UIData.spaceSize12,
                  ),
                ),
                Visibility(
                  visible: info.credentialPapers != null &&
                      info.credentialPapers.length > 0,
                  child: Container(
                    margin: EdgeInsets.all(UIData.spaceSize16),
                    child: CommonImageDisplay(
                        photoIdList: getFileList(info.credentialPapers)),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          labelTextWidget(
                            label: manager,
                            text: info.manager ?? '暂无',
                            topSpacing: UIData.spaceSize12,
                          ),
                          labelTextWidget(
                            label: managerPhone,
                            text: info.managerPhone ?? '暂无',
                            topSpacing: UIData.spaceSize12,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Image.asset(UIData.imagePhone),
                      onPressed: () {
                        if (StringsHelper.isNotEmpty(info?.managerPhone)) {
                          stateModel.callPhone(info?.managerPhone);
                        }
                      },
                    ),
                  ],
                ),
                labelTextWidget(
                  label: managerIdCard,
                  text: info.managerIdCard ?? '暂无',
                  topSpacing: UIData.spaceSize12,
                ),
                Visibility(
                  visible: info?.managerIdCardPhotos != null &&
                      info?.managerIdCardPhotos.length > 0,
                  child: leftTextWidget(
                    text: '身份证照',
                    topSpacing: UIData.spaceSize12,
                  ),
                ),
                Visibility(
                  visible: info?.managerIdCardPhotos != null &&
                      info?.managerIdCardPhotos.length > 0,
                  child: Container(
                    margin: EdgeInsets.all(UIData.spaceSize16),
                    child: CommonImageDisplay(
                        photoIdList: getFileList(info.managerIdCardPhotos)),
                  ),
                ),
              ])),




          //施工项目信息
          Container(
              color: UIData.primaryColor,
              margin: EdgeInsets.only(top: UIData.spaceSize12),
              padding: EdgeInsets.only(bottom: UIData.spaceSize12,top: UIData.spaceSize12,),
              child: Column(children: <Widget>[
                leftTextWidget(
                  text: '施工项目信息',
                  color: UIData.greyColor,
                  fontSize: UIData.fontSize17,
                ),
                labelTextWidget(
                  label: programName,
                  text: info.programName ?? "暂无",
                  topSpacing: UIData.spaceSize12,
                ),
                labelTextWidget(
                  label: programDesc,
                  text: info.programDesc ?? '暂无',
                  topSpacing: UIData.spaceSize12,
                ),
                Visibility(
                  visible:
                      info.otherPhotos != null && info.otherPhotos.length > 0,
                  child: leftTextWidget(
                    text: '相关附件',
                    topSpacing: UIData.spaceSize12,
                  ),
                ),
                Visibility(
                  visible:
                      info.otherPhotos != null && info.otherPhotos.length > 0,
                  child: Container(
                    margin: EdgeInsets.all(UIData.spaceSize16),
                    child: CommonImageDisplay(
                        photoIdList: getFileList(info.otherPhotos)),
                  ),
                ),
              ])),
//          Visibility(
//            visible: info.state == payWaiting,
//            child: Container(
//              margin: EdgeInsets.only(top: UIData.spaceSize12),
//              padding: EdgeInsets.only(bottom: UIData.spaceSize12),
//              color: UIData.primaryColor,
//              child: Column(
//                children: <Widget>[
//                  feeInputWidget(
//                    feeController,
//                    label: '实付费用',
//                    hint_text: '请输入（必填）',
//                  ),
//                  leftTextWidget(text: "缴费凭据", topSpacing: UIData.spaceSize16),
//                  Container(
//                      margin: EdgeInsets.all(UIData.spaceSize16),
//                      child: CommonImagePicker(
//                        callbackWithInfo: (photos) {
//                          attPhotoList.clear();
//                          attPhotoList.addAll(photos);
//                        },
//                      ))
//                ],
//              ),
//            ),
//          ),
          Visibility(
            visible: widget.isCheckZK&&info.state == yzauditWaiting,
            child: Container(
              margin: EdgeInsets.only(top: UIData.spaceSize12),
              padding: EdgeInsets.only(bottom: UIData.spaceSize12),
              color: UIData.primaryColor,
              child: Column(
                children: <Widget>[
                  leftTextWidget(
                    text: remark,
                    color: UIData.greyColor,
                    topSpacing: UIData.spaceSize12,
                  ),
                  inputWidget(
                    remarkController,
                    hint_text: "请输入",
                    maxLength: 200,
                  ),

                  leftTextWidget(
                    text:'*须知：为保障您的权益，装修办理需先得到您的同意。请先与租户联系并确定信息后再同意申请。',
                    color: UIData.themeBgColor,
                    fontSize: UIData.fontSize15,
                    rightSpacing: UIData.spaceSize16,
                    topSpacing: UIData.spaceSize12,
                  ),
                ],
              ),
            ),
          ),

          Container(
            color: UIData.primaryColor,
            margin: EdgeInsets.only(top: UIData.spaceSize12),
            child: DecorationNodeListView(info.nodeList),
          ),
        ]),
      );
    });
  }

  List<String> getFileList(List<Attachment> attFileList) {
    List<String> strs = new List();
    if (attFileList != null)
      attFileList.forEach((info) {
        strs.add(info.attachmentUuid);
      });
    return strs;
  }
}
