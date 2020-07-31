import 'package:cmp_customer/models/new_house_model.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/ui/common/common_animation.dart';
import 'package:cmp_customer/ui/common/common_image_display.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/parking/parking_card_ui.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';

import 'new_house_common_ui.dart';

///
/// Created by qianlx on 2020/3/28 2:38 PM.
/// 新房入伙办理进度节点界面
///
class NewHouseDetailNode extends StatefulWidget {
  final String title; //标题
  final List<RecordInfo> nodes; //流程节点
  NewHouseDetailNode(this.nodes, {this.title = '办理进度'});

  @override
  _NewHouseDetailNodeState createState() => _NewHouseDetailNodeState();
}

class _NewHouseDetailNodeState extends State<NewHouseDetailNode> with TickerProviderStateMixin {
  bool _isExpanded = false; //是否已拓展

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                        child: CommonText.text10(widget.nodes[position]?.operateStepName ?? '',
                            color: UIData.indicatorBlueColor),
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CommonText.text11(widget.nodes[position].createTime ?? "", color: UIData.greyColor),
//                          SizedBox(height: UIData.spaceSize4),
                          //待审核和待验收不显示状态
                          Visibility(
                            visible: widget.nodes[position].operateStep != null &&
                                widget.nodes[position].operateStep == newHouseOperateSH,
                            child: Container(
                              margin: EdgeInsets.only(top: UIData.spaceSize4),
                              child: CommonText.text13(
                                  '审核结果：${widget.nodes[position]?.operationStatus == '1' ? '通过' : '不通过'}'),
                            ),
                          ),
                          SizedBox(height: UIData.spaceSize4),
                          Visibility(
                              visible: widget.nodes[position]?.remark != null &&
                                  widget.nodes[position].remark.isNotEmpty,
                              child: CommonText.text13(
                                  '${widget.nodes[position].operateStep == newHouseOperateSH ? '审核意见' : '验收意见'}：${widget.nodes[position]?.remark ?? ''}')),
                          Visibility(
                              visible: widget.nodes[position].recordAttachmentList != null &&
                                  widget.nodes[position].recordAttachmentList.length > 0, //附件
                              child: Padding(
                                padding: EdgeInsets.only(top: UIData.spaceSize4),
                                child: CommonImageDisplay(
                                  photoIdList: widget?.nodes[position]?.recordAttachmentList
                                      ?.map((Attachment info) => info?.attachmentUuid)
                                      ?.toList(),
                                ),
                              )),
//                              Visibility(
//                                  child: Padding(
//                                    padding: EdgeInsets.only(top: UIData.spaceSize4),
//                                    child: CommonText.text13(widget.nodes[position]?.creator ?? ''),
//                                  ),
//                                  visible: widget.nodes[position].attWpSignList == null ||
//                                      widget.nodes[position].attWpSignList.length == 0),
//                              Visibility(
//                                  visible: widget.nodes[position].attWpfxmgList != null &&
//                                      widget.nodes[position].attWpfxmgList.length > 0, //签名图片
//                                  child: Padding(
//                                    padding: EdgeInsets.only(top: UIData.spaceSize4),
//                                    child: CommonImageDisplay(
//                                      photoIdList: widget?.nodes[position]?.attWpfxmgList
//                                          ?.map((Attachment info) => info?.attachmentUuid)
//                                          ?.toList(),
//                                    ),
//                                  )),
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
