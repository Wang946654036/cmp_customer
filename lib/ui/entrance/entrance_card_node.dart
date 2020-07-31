import 'dart:async';
import 'dart:io';

import 'package:cmp_customer/models/process_node.dart';
import 'package:cmp_customer/models/response/entrance_card_details_response.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/ui/common/common_animation.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_image_display.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_operation_step.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_ui.dart';
import 'package:cmp_customer/ui/parking/parking_card_ui.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

//门禁卡流程节点
class EntranceCardNodeWidget extends StatefulWidget {
  String title; //标题
  String customerType;//客户类型
  List<RecordList> nodes; //流程节点
  EntranceCardNodeWidget(this.nodes, {this.title = label_apply_deal_progress,this.customerType});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _EntranceCardNode();
  }
}

class _EntranceCardNode extends State<EntranceCardNodeWidget> {
  bool isExpaned = false; //是否已拓展
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //流程节点样式
    if (widget.nodes == null || widget.nodes.isEmpty) {
      return Container();
    } else {
      return Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontal_spacing
//                ,vertical: text_spacing
                ),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: CommonText.black16Text(widget.title,
                        textAlign: TextAlign.left)),

                ArrowRotateWidget((onChanged) {
                  setState(() {
                    isExpaned = onChanged;
                  });
                }),
//                GestureDetector(
//                  child: Icon(isExpaned ? Icons.keyboard_arrow_up : Icons
//                      .keyboard_arrow_down),
//                  onTap: () {
//                    setState(() {
//                      isExpaned = !isExpaned;
//                    });
//                  },
//                )
              ],
            ),
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: isExpaned ? widget.nodes.length : 1, //展开全部，收起只显示一项
            itemBuilder: (BuildContext contex, int index) {
              //列表样式
              int position = isExpaned
                  ? index
                  : widget.nodes.length - 1; //显示列表位置（主要用于收起时显示最后一项）
              return Stack(
                children: <Widget>[
                  Visibility(
                    visible: position != widget.nodes.length - 1, //最后一项不显示垂直线
                    child: Positioned(
                        top: 0,
                        bottom: 0,
                        left: left_spacing + node_left_spacing,
                        child: Container(
                          color: radius_solid_background,
                          width: node_line_width,
                        )),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: left_spacing,
                        right: right_spacing,
                        bottom: bottom_spacing),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: right_spacing),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  parking_state_half_height),
                              border:
                                  Border.all(color: UIData.lighterBlueColor),
                              color: UIData.primaryColor,
                            ),
                            padding:
                                EdgeInsets.symmetric(horizontal: text_spacing),
                            //                height: ScreenUtil.getInstance().setHeight(16),
                            alignment: Alignment.center,
                            child: CommonText.text11(widget.nodes[position].operateStepDesc??"",
                                color: UIData.indicatorBlueColor),
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              //                              CommonText.text15(widget.nodes[position].creator??""),
                              CommonText.text10(
                                  widget.nodes[position].createTime ?? "",
                                  color: UIData.greyColor),
//                              Visibility(
//                                visible: widget.nodes[position].operateStep ==
//                                        entrance_step_audit_yz ||
//                                    widget.nodes[position].operateStep ==
//                                        entrance_step_audit_wy,
//                                child: CommonText.text13(getEntranceStepContent(
//                                    widget.nodes[position].operateStep,
//                                    widget.nodes[position].status)),
//                              ),
                              Visibility(
                                visible: StringsHelper.isNotEmpty(widget.nodes[position].statusDesc) ,
                                child: CommonText.text13(widget.nodes[position].statusDesc??""),
                              ),
                              Visibility(
                                visible: StringsHelper.isNotEmpty(
                                    widget.nodes[position].remark),
                                child: CommonText.text13(
                                    widget.nodes[position].remark ?? "",overflow: TextOverflow.visible),
                              ),
//                              CommonText.text13(
//                                  widget.nodes[position].remark ?? ""),
                              Visibility(
                                  visible:
                                      widget.nodes[position].attachmentFlag ==
                                          "YES", //有附件
                                  child: Padding(
                                    padding: EdgeInsets.only(top: top_spacing),
                                    child: CommonImageDisplay(
                                      photoIdList: getAttUUIDList(
                                          widget.nodes[position].attHeadList,
                                          widget.nodes[position].attSfzList,
                                          widget.nodes[position].attList,
                                          widget.nodes[position].attMjkfjList),
                                      crossAxisCount: 4,
                                    ),
                                  ))
                            ],
                          ))
                        ]),
                  ),
                ],
              );
            },
          ),
        ],
      );
    }
  }
}

//获取流程节点里面的uuid列表
List<String> getAttUUIDList(
    List<String> attHeadList, List<String> attSfzList, List<String> attList,List<Attachment> attMjkfjList) {
  List<String> list = new List();
  if (attHeadList != null) {
    list.addAll(attHeadList);
  }
  if (attSfzList != null) {
    list.addAll(attSfzList);
  }
  if (attList != null) {
    list.addAll(attList);
  }
  if (attMjkfjList != null && attMjkfjList.isNotEmpty) {
    attMjkfjList.forEach((Attachment attHead) {
      list.add(attHead.attachmentUuid);
    });
  }
//  if (attSfzList != null && attSfzList.isNotEmpty) {
//    attSfzList.forEach((attSfz) {
//      list.add(attSfz.attachmentUuid);
//    });
//  }
//  if (attList != null && attList.isNotEmpty) {
//    attList.forEach((att) {
//      list.add(att.attachmentUuid);
//    });
//  }
  return list;
}
