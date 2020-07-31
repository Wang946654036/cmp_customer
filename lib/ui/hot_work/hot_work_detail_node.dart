import 'package:cmp_customer/models/hot_work_detail_model.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/strings/strings_hot_work.dart';
import 'package:cmp_customer/ui/common/common_animation.dart';
import 'package:cmp_customer/ui/common/common_image_display.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/parking/parking_card_ui.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';

///
/// 动火申请流程节点
///
class HotWorkNode extends StatefulWidget {
  final String title; //标题
  final List<RecordInfo> nodes; //流程节点
  HotWorkNode(this.nodes, {this.title = '申请进度'});

  @override
  _HotWorkNodeState createState() => _HotWorkNodeState();
}

class _HotWorkNodeState extends State<HotWorkNode> with TickerProviderStateMixin {
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
                        child: CommonText.text10(widget.nodes[position]?.processNodeName ?? '',
                            color: UIData.indicatorBlueColor),
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CommonText.text11(widget.nodes[position].processTime ?? "", color: UIData.greyColor),
                          SizedBox(height: UIData.spaceSize4),
                          Offstage(
                            offstage: widget.nodes[position].passFlag == null,
                            child: CommonText.text13(
                                '审核结果：${(widget.nodes[position]?.passFlag ?? '0') == '0' ? '不通过' : '通过'}'),
                          ),
                          SizedBox(height: UIData.spaceSize4),
                          Visibility(
                              visible: widget.nodes[position]?.processContent != null &&
                                  widget.nodes[position].processContent.isNotEmpty,
                              child: CommonText.text13('审核意见：${widget.nodes[position]?.processContent ?? ''}')),
                          Visibility(
                              visible: widget.nodes[position].attDhYzSignList != null &&
                                  widget.nodes[position].attDhYzSignList.length > 0, //业主签名图片
                              child: Padding(
                                padding: EdgeInsets.only(top: UIData.spaceSize4),
                                child: CommonImageDisplay(
                                  photoIdList: widget?.nodes[position]?.attDhYzSignList
                                      ?.map((Attachment info) => info?.attachmentUuid)
                                      ?.toList(),
                                ),
                              )),
                          Visibility(
                              visible: widget.nodes[position].attDhZhSignList != null &&
                                  widget.nodes[position].attDhZhSignList.length > 0, //租户签名图片
                              child: Padding(
                                padding: EdgeInsets.only(top: UIData.spaceSize4),
                                child: CommonImageDisplay(
                                  photoIdList: widget?.nodes[position]?.attDhZhSignList
                                      ?.map((Attachment info) => info?.attachmentUuid)
                                      ?.toList(),
                                ),
                              )),
                          Visibility(
                              child: Padding(
                                padding: EdgeInsets.only(top: UIData.spaceSize4),
                                child: CommonText.text13(widget.nodes[position]?.executorName ?? ''),
                              ),
                              visible: (widget.nodes[position].attDhYzSignList == null ||
                                      widget.nodes[position].attDhYzSignList.length == 0) &&
                                  (widget.nodes[position].attDhZhSignList == null ||
                                      widget.nodes[position].attDhZhSignList.length == 0) &&
                                  (widget?.nodes[position]?.processNodeCode != null) &&
                                  !(widget.nodes[position].processNodeCode.contains(hotWorkOperateStepProAudit)) &&
                                  (widget.nodes[position].processNodeCode != hotWorkOperateStepPassFinish))
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
