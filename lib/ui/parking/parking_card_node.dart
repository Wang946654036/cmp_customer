import 'dart:async';
import 'dart:io';
import 'package:cmp_customer/models/process_node.dart';
import 'package:cmp_customer/models/response/parking_card_details_response.dart';
import 'package:cmp_customer/ui/common/common_animation.dart';
import 'package:cmp_customer/ui/common/common_image_display.dart';
import 'package:cmp_customer/ui/common/common_image_picker.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/parking/parking_card_operation_step.dart';
import 'package:cmp_customer/ui/parking/parking_card_state.dart';
import 'package:cmp_customer/ui/parking/parking_card_ui.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//停车办理流程节点
class ParkingCardNodeWidget extends StatefulWidget {
  String title; //标题
  List<RecordList> nodes; //流程节点
  ParkingCardNodeWidget(this.nodes, {this.title = label_apply_deal_progress});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ParkingCardNode();
  }
}

class _ParkingCardNode extends State<ParkingCardNodeWidget>
    with TickerProviderStateMixin {
  bool isExpaned = false; //是否已拓展

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //流程节点样式
    if (widget.nodes == null || widget.nodes.isEmpty) {
      return Container(
        height: 0,
        width: 0,
      );
    } else {
      return Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontal_spacing),
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
//                  child: Icon(isExpaned?Icons.keyboard_arrow_up:Icons.keyboard_arrow_down),
//                  onTap: (){
//                    setState(() {
//                      isExpaned=!isExpaned;
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
                              CommonText.text11(
                                  widget.nodes[position].createTime ?? "",
                                  color: UIData.greyColor),
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
                              Visibility(
                                  visible:
                                      widget.nodes[position].attachmentFlag ==
                                          "YES", //有附件
                                  child: Padding(
                                    padding: EdgeInsets.only(top: text_spacing),
                                    child: CommonImageDisplay(
                                      photoIdList: getAttUUIDList(
                                          widget.nodes[position].attList),
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
List<String> getAttUUIDList(List<AttList> attList) {
  List<String> list = new List();
  if (attList != null && attList.isNotEmpty) {
    attList.forEach((att) {
      list.add(att.attachmentUuid);
    });
  }
  return list;
}
