
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/change_title_obj.dart';
import 'package:cmp_customer/models/property_change_user_param.dart';
import 'package:cmp_customer/scoped_models/change_of_title_model.dart';
import 'package:cmp_customer/ui/change_of_title/change_of_title_create.dart';
import 'package:cmp_customer/ui/change_of_title/change_of_title_ui.dart';
import 'package:cmp_customer/ui/change_of_title/node_listview.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_image_display.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/parking/parking_card_ui.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ChangeOfTitleDetail extends  StatefulWidget {
//  PageQueryType type;
  int infoId;
  ChangeOfTitleModel _model;
  ChangeOfTitleDetail(this._model,this.infoId);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ChangeOfTitleDetailState();
  }

}
class _ChangeOfTitleDetailState extends State<ChangeOfTitleDetail> {
double payFees = 0.00;
TextEditingController remarkController = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
if(widget._model==null){
  widget._model = new ChangeOfTitleModel();
}
    widget._model.getChangeOfTitleInfo('1',widget.infoId);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModel<ChangeOfTitleModel>(
model: widget._model,
        child: ScopedModelDescendant<ChangeOfTitleModel>(

            builder: (context, child, model) {
              ChangeTitleInfo info = model.changeOfTitleInfo;
              return CommonScaffold(
                  appTitle: "产权变更详情",
                  bodyData: _buildBody(),
                  bottomNavigationBar:
                  Visibility(visible:  widget._model.changeOfTitleInfoState==ListState.HINT_DISMISS,child:  Column(children: <Widget>[
                    Visibility(
                        visible:
//                      widget.type == PageQueryType.TODO &&
                        (info?.status??'')==auditWaiting,
                        child: StadiumSolidWithTowButton(
                          cancelText: "取消办理",
                          onCancel: () {
                            model.changeOfTitleIsPass(widget.infoId,callback: (){
                              widget._model.loadHistoryList(new PropertyChangeUserParam());
                            });
                          },
                          conFirmText: "修改申请",
                          onConFirm: () {
//                            Navigate.closePage(true);
                            Navigate.toNewPage(new ChangeOfTitleCreate(changeTitleInfo: info,)
                                ,callBack: (bool flag){
                                  if(flag)
                                    close();
//                              widget._model.getChangeOfTitleInfo('1',widget.infoId);
//                              widget._model.loadHistoryList(new PropertyChangeUserParam());
                                }
                            );
                          },
                        )

                    ),
                    Visibility(
                        visible:
//                      widget.type == PageQueryType.TODO &&
                        (info?.status??'')==auditFailed,
                        child: StadiumSolidWithThreeButton(
                          cancelText: "取消办理",
                          onCancel: () {
                            model.changeOfTitleIsPass(widget.infoId,callback: (){
                              widget._model.loadHistoryList(new PropertyChangeUserParam());
                            });
                          },
                          editText: '再次提交',
                          onEdit: (){
                            widget._model.checkUploadData(info,callback: (){
                              widget._model.loadHistoryList(new PropertyChangeUserParam());
                            });
                          },
                          conFirmText: "修改申请",
                          onConFirm: () {

                            Navigate.toNewPage(new ChangeOfTitleCreate(changeTitleInfo: info,)
                                ,callBack: (bool flag){
                                  if(flag)
                                    close();
//                              widget._model.getChangeOfTitleInfo('1',widget.infoId);
//                              widget._model.loadHistoryList(new PropertyChangeUserParam());
                                }
                            );

                          },
                        )

                    ),
                  ],),),

                  );
            }));
  }

  Widget _buildBody() {
    return ScopedModelDescendant<ChangeOfTitleModel>(
        builder: (context, child, model) {
          return CommonLoadContainer(
            state: widget._model.changeOfTitleInfoState,
            callback: () {
              widget._model.getChangeOfTitleInfo('1',widget.infoId);
            },
            content: _buildContent(),
          );
        });
  }

  Widget _buildContent() {
    return ScopedModelDescendant<ChangeOfTitleModel>(
        builder: (context, child, model) {
          ChangeTitleInfo info = model.changeOfTitleInfo;
          return SingleChildScrollView(
            child: Column(children: <Widget>[
              Container(
                  color: color_layout_bg,
                  padding: EdgeInsets.only(bottom: bottom_spacing),
                  child: Column(children: <Widget>[
                    labelTextWidget(
                      label: label_business_id,
                      text: info.businessNo ?? "",
                      topSpacing: top_spacing,
                    ),
                    labelTextWidget(
                      label: label_apply_time,
                      text: info.createTime ?? "",
                      topSpacing: top_spacing,
                    ),
                    labelTextWidget(
                      label: '转让房屋',
                      text:(info.formerName??'')+(info.buildName ?? "")+(info.unitName??'')+(info.houseNo??''),
                      topSpacing: top_spacing,
                    ),
                    labelTextWidget(
                      label: label_apply_deal_progress,
                      text: getStateStr(info.status),
                      topSpacing: top_spacing,
                    ),

                    Visibility(
                      visible:
                      payFees!=null,
                      child: Container(
                        margin: EdgeInsets.only(top: top_spacing),
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            labelTextWidget(
                              label: "费用",
                              unit: "元",
                              color: UIData.orangeColor,
                              text: StringsHelper.getDoubleToStringValue(
                                  payFees),
                            )
                          ],
                        ),
                      ),
                    ),
//                            leftTextWidget(
//                              text: label_photo_head, topSpacing: top_spacing,),
//                            Container(
//                              margin: EdgeInsets.all(left_spacing),
//                              child: CommonImageDisplay(null),
//                            ),
//                            leftTextWidget(text: label_photo_identity,
//                              topSpacing: top_spacing,),
//                            Container(
//                              margin: EdgeInsets.all(left_spacing),
//                              child: CommonImageDisplay(null),
//                            ),
                  ])),


              //受让人信息
              Container(
                  color: color_layout_bg,
                  margin: EdgeInsets.only(top: top_spacing),
                  padding: EdgeInsets.symmetric(vertical: vertical_spacing),
                  child:
                  Column(children: <Widget>[
                    leftTextWidget(text: '受让人信息',
                      color: color_text_gray,
                      ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              labelTextWidget(
                                label: label_name,
                                text: info.assigneeRealname?? "",
                                topSpacing: top_spacing,
                              ),
                              labelTextWidget(
                                label: label_contact_phone,
                                text: info.assigneePhone ?? "",
                                topSpacing: top_spacing,
                              ),
                              labelTextWidget(
                                label: label_IDtype,
                                text:getIDType(info.assigneeIdTypeId ?? "") ,
                                topSpacing: top_spacing,
                              ),
                              labelTextWidget(
                                label: label_IDNo,
                                text: info.assigneeIdNum ?? "",
                                topSpacing: top_spacing,
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Image.asset(UIData.imagePhone),
                          onPressed: (){
                            if(StringsHelper.isNotEmpty(info?.assigneeIdNum)){
                              stateModel.callPhone(info?.assigneeIdNum);
                            }
                          },
                        ),
                      ],
                    ),
                  ],)

              ),

              //转让人信息
//              Container(
//                color: color_layout_bg,
//                margin: EdgeInsets.only(top: line_height),
//                padding: EdgeInsets.symmetric(horizontal: horizontal_spacing,vertical: vertical_spacing),
//                child:
//                Column(children: <Widget>[
//                  leftTextWidget(text: '转让人信息',
//                    color: color_text_gray,
//                    topSpacing: top_spacing,),
//                  Row(
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    children: <Widget>[
//                      Expanded(
//                        child: Column(
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: <Widget>[
//                            labelTextWidget(
//                              label: label_name,
//                              text: info.customerName ?? "",
//                              topSpacing: top_spacing,
//                            ),
//                            labelTextWidget(
//                              label: label_contact_phone,
//                              text: info.customerPhone ?? "",
//                              topSpacing: top_spacing,
//                            ),
//                            labelTextWidget(
//                              label: label_IDtype,
//                              text: getIDType(info.customerIdTypeId ?? ""),
//                              topSpacing: top_spacing,
//                            ),
//                            labelTextWidget(
//                              label: label_IDNo,
//                              text: info.customerIdNum ?? "",
//                              topSpacing: top_spacing,
//                            ),
//                          ],
//                        ),
//                      ),
//                      IconButton(
//                        icon: Image.asset(UIData.imagePhone),
//                        onPressed: (){
//                          if(StringsHelper.isNotEmpty(info?.customerPhone)){
//                            stateModel.callPhone(info?.customerPhone);
//                          }
//                        },
//                      ),
//                    ],
//                  ),
//                                ],)
//
//              ),

//              Container( color: color_layout_bg,
//                margin: EdgeInsets.only(top: line_height),
//                padding: EdgeInsets.symmetric(horizontal: horizontal_spacing,vertical: vertical_spacing),
//              child: CommonText.lightGrey14Text((info.promptInfo??'')),),

              Container(
                  color: color_layout_bg,
                  margin: EdgeInsets.only(top: top_spacing),
                  padding: EdgeInsets.symmetric(vertical: vertical_spacing),
                  child:
                  Column(children: <Widget>[
                    leftTextWidget(
                      text: '证明资料', topSpacing: top_spacing,),
                    Container(
                      margin: EdgeInsets.all(left_spacing),
                      child: CommonImageDisplay(photoIdList:getFileList(info)),
                    ),
                  ],)

              ),



//              Visibility(
//                visible:
////                widget.type == PageQueryType.TODO &&
//                    info.status==auditWaiting,
//                child: Container(
//                  margin: EdgeInsets.only(top: top_spacing),
//                  padding: EdgeInsets.only(bottom: bottom_spacing),
//                  color: color_layout_bg,
//                  child: Column(
//                    children: <Widget>[
//                      leftTextWidget(
//                        text: label_apply_audit_opinion,
//                        color: color_text_gray,
//                        topSpacing: top_spacing,
//                      ),
//                      inputWidget(controller: remarkController,
//                          hint_text: "若审核不通过，请务必写明缘由"),
//                    ],
//                  ),
//                ),
//              ),

              Container(
                color: color_layout_bg,
                margin: EdgeInsets.only(top: top_spacing),
                child: ChangeOfTitleNodeListView(info.recordList),
              ),
            ]),
          );
        });
  }
List<String> getFileList(ChangeTitleInfo changeTitleInfo) {
  List<String> strs = new List();
  if (changeTitleInfo.attApplyList != null){
    changeTitleInfo.attApplyList.forEach((info) {
      strs.add(info.attachmentUuid);
    });
    if(changeTitleInfo.attFileList==null||changeTitleInfo.attFileList.length==0){
      changeTitleInfo.attFileList = new List();
      changeTitleInfo.attFileList.addAll(changeTitleInfo.attApplyList);
    }
  }

  return strs;
}
Future<void> close () async{
  Navigate.closePage(true);
}
}