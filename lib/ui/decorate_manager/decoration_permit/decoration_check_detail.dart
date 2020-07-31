///验收详情tab页面
///
/// 
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/change_title_obj.dart';
import 'package:cmp_customer/models/decoration_obj.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/scoped_models/decoration_model.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_image_display.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../decoration_ui.dart';
import 'node_listview.dart';

class DecorationCheckDetail extends StatefulWidget {
  int infoId;
  DecorationModel _model;

  DecorationCheckDetail(this._model, this.infoId);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DecorationCheckDetailState();
  }
}

class _DecorationCheckDetailState extends State<DecorationCheckDetail> {
//  double payFees = 500.00;
  TextEditingController remarkController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//if(widget._model.decorationInfo==null)
//    widget._model.getDecorationInfo(widget.infoId);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModel<DecorationModel>(
        model: widget._model,
        child: ScopedModelDescendant<DecorationModel>(
            builder: (context, child, model) {
              DecorationInfo info = model.decorationInfo;
              return  _buildBody();
            }));
  }

  Widget _buildBody() {
    return ScopedModelDescendant<DecorationModel>(
        builder: (context, child, model) {
          return CommonLoadContainer(
            state: widget._model.decorationInfoState,
            callback: () {
              widget._model.getDecorationInfo( widget.infoId);
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
                      text: info.houseName ?? '暂无',
                      topSpacing: UIData.spaceSize12,
                    ),
                    labelTextWidget(
                      label: programName,
                      text: info.programName ?? '暂无',
                      topSpacing: UIData.spaceSize12,
                    ),
                    labelTextWidget(
                      unit: '万元',
                      label: price,
                      text: info.decorateAcceptanceVo?.price?.toString() ?? '暂无',
                      topSpacing: UIData.spaceSize12,
                    ),
                    labelTextWidget(
                      label: checkDate,
                      text: info.decorateAcceptanceVo?.checkDate ?? '暂无',
                      topSpacing: UIData.spaceSize12,
                    ),
                    labelTextWidget(
                      label: label_apply_deal_progress,
                      text: getStateStr(info.decorateAcceptanceVo?.state),
                      topSpacing: UIData.spaceSize12,
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              labelTextWidget(
                                label: manager,
                                text: info.decorateAcceptanceVo?.manager ?? '暂无',
                                topSpacing: UIData.spaceSize12,
                              ),
                              labelTextWidget(
                                label: managerPhone,
                                text: info.decorateAcceptanceVo?.managerPhone ?? '暂无',
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
                      label: finishDate,
                      text: info. decorateAcceptanceVo?.finishDate??
                          '暂无',
                      topSpacing: UIData.spaceSize12,
                    ),

                    labelTextWidget(
                      label: checkDesc,
                      text: info. decorateAcceptanceVo?.checkDesc??
                          '暂无',
                      topSpacing: UIData.spaceSize12,
                    ),
                    labelTextWidget(
                      label: quality,
                      text: getQualityString(info. decorateAcceptanceVo?.quality),
                      topSpacing: UIData.spaceSize12,
                    ),
                    leftTextWidget(
                      text: '相关附件', topSpacing: UIData.spaceSize12,),
                    Container(
                      margin: EdgeInsets.all(UIData.spaceSize16),
                      child: CommonImageDisplay(photoIdList:getFileList(info.decorateAcceptanceVo?.checkPhotos)),
                    ),
                  ])),
              
              Visibility(
                visible:
                    info.status == acceptance_check,
                child: Container(
                  margin: EdgeInsets.only(top: UIData.spaceSize12),
                  padding: EdgeInsets.only(bottom: UIData.spaceSize12),
                  color: UIData.primaryColor,
                  child: Column(
                    children: <Widget>[
                      leftTextWidget(
                        text: label_apply_audit_opinion,
                        color: UIData.greyColor,
                        topSpacing: UIData.spaceSize12,
                      ),
                      inputWidget(remarkController, hint_text: "若审核不通过，请务必写明缘由",maxLength: 200,),
                    ],
                  ),
                ),
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
