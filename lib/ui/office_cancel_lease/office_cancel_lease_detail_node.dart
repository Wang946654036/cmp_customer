import 'package:cmp_customer/models/office_cancel_lease_detail_model.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/strings/strings_office_cancel_lease.dart';
import 'package:cmp_customer/ui/common/common_animation.dart';
import 'package:cmp_customer/ui/common/common_image_display.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/parking/parking_card_ui.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';

///
/// 物品放行流程节点
///
class OfficeCancelLeaseNode extends StatefulWidget {
  final String title; //标题
  final List<RecordInfo> nodes; //流程节点
  OfficeCancelLeaseNode(this.nodes, {this.title = '申请进度'});

  @override
  _OfficeCancelLeaseNodeState createState() => _OfficeCancelLeaseNodeState();
}

class _OfficeCancelLeaseNodeState extends State<OfficeCancelLeaseNode> with TickerProviderStateMixin {
  bool _isExpanded = false; //是否已拓展

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
                Expanded(child: CommonText.black16Text(widget.title, textAlign: TextAlign.left)),
                ArrowRotateWidget((onChanged) {
                  setState(() {
                    _isExpanded = onChanged;
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
            itemCount: _isExpanded ? widget.nodes.length : 1, //展开全部，收起只显示一项
            itemBuilder: (BuildContext contex, int index) {
              //列表样式
              int position = _isExpanded ? index : widget.nodes.length - 1; //显示列表位置（主要用于收起时显示最后一项）
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
                    padding: EdgeInsets.only(left: left_spacing, right: right_spacing, bottom: bottom_spacing),
                    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: right_spacing),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(parking_state_half_height),
                          border: Border.all(color: UIData.lighterBlueColor),
                          color: UIData.primaryColor,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: text_spacing),
//                height: ScreenUtil.getInstance().setHeight(16),
                        alignment: Alignment.center,
                        child: CommonText.text10(
                            officeCancelLeaseOperateStepMap[widget.nodes[position]?.operateStep] ?? '',
                            color: UIData.indicatorBlueColor),
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CommonText.text11(widget.nodes[position].createTime ?? "", color: UIData.greyColor),
                          Offstage(
                            //待审核和取消申请不显示审核结果
                            offstage:
                                widget.nodes[position].status == officeCancelLeaseStatusMap.keys.toList()[0] ||
                                    widget.nodes[position].status == officeCancelLeaseStatusMap.keys.toList()[5],
                            child: CommonText.text13(widget.nodes[position]?.statusTypeName ?? ''),
                          ),
                          CommonText.text13(widget.nodes[position]?.remark ?? ''),
                          Visibility(
                            //代交验拿整改完成的图片列表,交验不通过或交验通过拿交验登记的图片列表
                            visible:
                            widget.nodes[position].status == officeCancelLeaseStatusMap.keys.toList()[1] ||
                                widget.nodes[position].status == officeCancelLeaseStatusMap.keys.toList()[3] ||
                                widget.nodes[position].status == officeCancelLeaseStatusMap.keys.toList()[4],
                            child: CommonImageDisplay(
                              photoIdList:
                              widget.nodes[position].status == officeCancelLeaseStatusMap.keys.toList()[1]
                                  ? widget.nodes[position].attRectifyList
                                  : widget.nodes[position].attSubmitList
                                  ?.map((Attachment attach) => attach.attachmentUuid)
                                  ?.toList(),
                              crossAxisCount: 5,
                            ),
                          ),
//                          Visibility(
//                              visible: widget.nodes[position].attachmentFlag == "YES", //有附件
//                              child: Padding(
//                                padding: EdgeInsets.only(top: text_spacing),
//                                child: CommonImageDisplay(
//                                  photoIdList: getAttUUIDList(widget.nodes[position].attList),
//                                  crossAxisCount: 4,
//                                ),
//                              ))
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
