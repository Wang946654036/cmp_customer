import 'package:cmp_customer/models/response/decoration_pass_card_details_response.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/ui/common/common_animation.dart';
import 'package:cmp_customer/ui/common/common_image_display.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/parking/parking_card_ui.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';

//流程节点
class DecorationPassCardNodeWidget extends StatefulWidget {
  String title; //标题
  List<NodeList> nodes; //流程节点
  DecorationPassCardNodeWidget(this.nodes, {this.title = label_apply_deal_progress});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DecorationPassCardNode();
  }
}

class _DecorationPassCardNode extends State<DecorationPassCardNodeWidget> {
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
                            child: CommonText.text11(widget.nodes[position].operation ?? "",
//                                getCheckInStepName(
//                                    widget.nodes[position].operateStep,widget.customerType),
                                color: UIData.indicatorBlueColor),
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              //                              CommonText.text15(widget.nodes[position].creator??""),
                              CommonText.text10(
                                  widget.nodes[position].createDate ?? "",
                                  color: UIData.greyColor),
                              Visibility(
                                visible: StringsHelper.isNotEmpty(widget.nodes[position].operationResult),
                                child: CommonText.text13(widget.nodes[position].operationResult??""),
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
                                  visible: widget.nodes[position]?.attFileList?.isNotEmpty??false,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: top_spacing),
                                    child: CommonImageDisplay(
                                      photoIdList: widget.nodes[position]?.attFileList?.map((Attachment attach) => attach?.attachmentUuid)
                                              ?.toList()??null,
                                      crossAxisCount: 4,
                                    ),
                                  )),
                              Visibility(
                                  visible: StringsHelper.isNotEmpty(widget.nodes[position]?.operationName)&&StringsHelper.isEmpty(widget.nodes[position]?.checkUserUuid)&&widget.nodes[position].operationUser == null,
                                child: Padding(
                                  padding: EdgeInsets.only(top: UIData.spaceSize4),
                                  child: CommonText.text13(widget.nodes[position]?.operationName ?? ''),
                                ),),
                              Visibility(
                                  visible: widget.nodes[position]?.checkUserUuid!=null && widget.nodes[position].operationUser == null,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: top_spacing),
                                    child: CommonImageDisplay(
                                      photoIdList: [widget.nodes[position]?.checkUserUuid],
                                      crossAxisCount: 4,
                                    ),
                                  )),


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

////获取流程节点里面的uuid列表
//List<String> getAttUUIDList(List<String> attList1,List<String> attList2,List<String> attList3,List<String> attList4) {
//  List<String> list = new List();
//  if (attList1 != null) {
//    list.addAll(attList1);
//  }
//  if (attList2 != null) {
//    list.addAll(attList2);
//  }
//  if (attList3 != null) {
//    list.addAll(attList3);
//  }
//  if (attList4 != null) {
//    list.addAll(attList4);
//  }
//  return list;
//}
