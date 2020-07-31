import 'package:cmp_customer/models/change_title_obj.dart';
import 'package:cmp_customer/ui/common/common_animation.dart';
import 'package:cmp_customer/ui/common/common_audio_player.dart';
import 'package:cmp_customer/ui/common/common_image_display.dart';
import 'package:cmp_customer/ui/common/common_star_rating.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/work_other/workother_precess_node.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BrandNameNodeListView extends StatefulWidget {
  List<RecordList> recordList;

  BrandNameNodeListView(this.recordList);

  @override
  _NodeListViewState createState() {
    // TODO: implement createState

    return _NodeListViewState();
  }
}

class _NodeListViewState extends State<BrandNameNodeListView> {
  String WorkOtherProcessNodeTitle = '最新节点';

  bool isExpaned = false; //是否已拓展

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //流程节点样式
    List<WorkOtherProcessNode> nodes = tran2WorkOtherProcessNodeList();
    return Container(
      color: UIData.primaryColor,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize16),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: CommonText.black16Text(WorkOtherProcessNodeTitle,
                        textAlign: TextAlign.left)),
                ArrowRotateWidget((onChanged) {
                  setState(() {
                    isExpaned = onChanged;
                    if (isExpaned)
                      WorkOtherProcessNodeTitle = '所有节点';
                    else
                      WorkOtherProcessNodeTitle = '最新节点';
                  });
                }),
              ],
            ),
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: isExpaned ? nodes.length : 1,
            //展开全部，收起后，若最后一条主节点有子节点只显示最后的主节点以及其下的所有子节点，若最后一条没有子节点则
            itemBuilder: (BuildContext contex, int index) {
              //列表样式
              int position =
                  isExpaned ? index : nodes.length - 1; //显示列表位置（主要用于收起时显示最后一项）
              WorkOtherProcessNode node = nodes[position];
              return Stack(
                children: <Widget>[
                  Visibility(
                    visible: position != nodes.length - 1, //最后一项不显示垂直线
                    child: Positioned(
                        top: 0,
                        bottom: 0,
                        left: UIData.spaceSize20 + UIData.spaceSize20,
                        child: Container(
                          color: UIData.lighterBlueColor,
                          width: UIData.spaceSize1,
                        )),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: UIData.spaceSize16,
                        right: UIData.spaceSize16,
                        bottom: UIData.spaceSize12),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ///节点名
                          Container(
                            constraints: BoxConstraints(
                              minWidth: UIData.spaceSize48,
                            ),
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(right: UIData.spaceSize16),
                            child: Container(
                              constraints: BoxConstraints(
                                minWidth: UIData.spaceSize30,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    ScreenUtil.getInstance().setHeight(15)),
                                border:
                                    Border.all(color: UIData.lighterBlueColor),
                                color: UIData.primaryColor,
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      ScreenUtil.getInstance().setHeight(8)),
                              //                height: ScreenUtil.getInstance().setHeight(16),
                              alignment: Alignment.center,
                              child: CommonText.text10(node.nodeName ?? '',
                                  color: UIData.themeBgColor),
                            ),
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
//                              Visibility(
////                                  visible: StringsHelper.isNotEmpty(node.name),
////                                  child: Row(
////                                    children: <Widget>[
////                                      CommonText.text15(node.name),
////                                      SizedBox(
////                                        width: UIData.spaceSize12,
////                                      ),
////                                      Visibility(
////                                        visible: node.uiType != null &&
////                                            node.uiType != -1,
////                                        child: CommonText.text15(
////                                            node.uiType == 0 ? '用户' : '客户'),
////                                      )
////                                    ],
////                                  )),
                              CommonText.text10(node.time ?? "",
                                  color: UIData.lightGreyColor),

                              CommonText.text13(node.content ?? "",overflow:TextOverflow.visible,
                                  height: null),

                              Visibility(
                                  visible: node.photoList != null &&
                                      node.photoList.length > 0, //有附件
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      CommonText.text13('图片:'),
                                      SizedBox(
                                        height: UIData.spaceSize4,
                                      ),
                                      CommonImageDisplay(
                                        photoIdList: node.photoList,
                                        crossAxisCount: 4,
                                      ),
                                    ],
                                  )),
                              Visibility(
                                  visible: node.fileList != null &&
                                      node.fileList.length > 0, //有附件
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      CommonText.text13('附件:'),
                                      SizedBox(
                                        height: UIData.spaceSize4,
                                      ),
                                      CommonImageDisplay(
                                        photoIdList: node.fileList,
                                        crossAxisCount: 4,
                                      ),
                                    ],
                                  )),
//                              Visibility(
//                                visible: node.voiceList != null &&
//                                    node.voiceList.length > 0, //有附件
//                                child: CommonAudioPlayer(node.voiceList == null
//                                    ? ''
//                                    : node.voiceList.length > 0
//                                        ? node.voiceList[0] ?? ''
//                                        : ''),
//                              ),
                            ],
                          ))
                        ]),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  List<WorkOtherProcessNode> tran2WorkOtherProcessNodeList() {
    List<WorkOtherProcessNode> workOtherProcessNodes = List();
    for (int i = 0; i < widget.recordList.length; i++) {
//      Map map =
//          getWorkOtherOperationStateType(widget.recordList[i].operateStep);
//      String nodeName = map['name'];
      String nodeName = widget.recordList[i].operateStepName;
//      int uiType =StringsHelper.isNotEmpty(widget.recordList[i].creatorType)?widget.recordList[i].creatorType=='CUST'?1:0:-1;

      String time = widget.recordList[i].createTime ?? '至今';

      StringBuffer content = new StringBuffer();
      if (widget.recordList[i].status != null) {
        String passStr;
        if (widget.recordList[i].status == 'KFTH') {
          passStr = widget.recordList[i].statusName;
        } else if (widget.recordList[i].status == 'DQRFA') {
          passStr = '受理';
        }
        if (StringsHelper.isNotEmpty(passStr)) content.write(passStr + '\n');
      }
      if(StringsHelper.isNotEmpty(widget.recordList[i].payFees?.toString()??'')){
        double payFees = widget.recordList[i].payFees;
        content.write('实付金额：${payFees}'+'\n');
      }
      LogUtils.printLog("${widget.recordList[i].remark}");
      if (StringsHelper.isNotEmpty(widget.recordList[i].remark)) {
//        String processContent = '${StringsHelper.isNotEmpty(map['contentTile'])?map['contentTile']:'备注'}：';
        String processContent =  (widget.recordList[i].operateStep=="SPMP_SLPG")?"备注说明":"备注";
        processContent = processContent + widget.recordList[i].remark;
        content.write(processContent + '\n');
      }
      List<String> workOrderPhotoList = new List();
      if (widget.recordList[i].attFileList != null &&
          widget.recordList[i].attFileList.length > 0) {
        widget.recordList[i].attFileList.forEach((obj) {
          workOrderPhotoList.add(obj.attachmentUuid);
        });
      }

      WorkOtherProcessNode workOtherProcessNode = new WorkOtherProcessNode(
        nodeName: nodeName,
//          uiType: uiType,
        time: time,
        name: widget.recordList[i].creator,
        content: content.toString(),
         photoList: workOrderPhotoList,
//          fileList: workOrderFileList
      );
      workOtherProcessNodes.add(workOtherProcessNode);
    }
    return workOtherProcessNodes;
  }

//  /**
//   * 操作环节：SPMP_TJSQ-提交申请、SPMP_SLPG-受理评估、SPMP_XGSQ-修改申请、SPMP_QRFA-确认方案、SPMP_QRZF-确认支付、SPMP_QXSQ-取消申请、SPMP_WGDJ-完工登记
//   */
//
//  Map<String, dynamic> getWorkOtherOperationStateType(String type) {
//    String name;
//    int uiType;
//    String contentTile = '';
//    switch (type) {
//      case 'SPMP_TJSQ':
//        name = "提交申请";
//        uiType = 1; //蓝色
//        break;
//      case 'SPMP_SLPG':
//        name = "受理评估";
//        uiType = 1; //蓝色
//        contentTile = '备注说明';
//        break;
//      case 'SPMP_XGSQ':
//        name = "修改申请";
//        uiType = 1; //蓝色
//        break;
//      case 'SPMP_QRFA':
//        name = '确认方案';
//        uiType = 1;
//        break;
//      case 'SPMP_QRZF':
//        name = '确认支付';
//        uiType = 1;
//        break;
//      case 'SPMP_QXSQ':
//        name = '取消申请';
//        uiType = 1;
//        break;
//      case 'SPMP_WGDJ':
//        name = '完工登记';
//        uiType = 1;
//        break;
//    }
//    return {'name': name, 'type': uiType, 'contentTile': contentTile};
//  }
}
