
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/process_main_node_list.dart';
import 'package:cmp_customer/models/process_sub_node_list.dart';
import 'package:cmp_customer/ui/common/common_animation.dart';
import 'package:cmp_customer/ui/common/common_star_rating.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/work_other/work_other_ui.dart';
import 'package:cmp_customer/ui/work_other/workother_precess_node.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NodeListView extends StatefulWidget {
  int workOtherId;
  WorkOtherMainType workOtherType;
  NodeListView(this.workOtherId,{this.workOtherType});

  @override
  _NodeListViewState createState() {
    // TODO: implement createState

    return _NodeListViewState();
  }
}

class _NodeListViewState extends State<NodeListView> {
  String WorkOtherProcessNodeTitle = '最新节点';

  bool isExpaned = false; //是否已拓展

  int starflag;
  int endflag;
int autoFlag = -1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stateModel.loadWorkOthersProcessNodeList(widget.workOtherId,preRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //流程节点样式
    if (stateModel.processNodeState != ListState.HINT_DISMISS) {
      return Container();
    } else {
      List<WorkOtherProcessNode> nodes =
          tran2WorkOtherProcessNodeList(stateModel.processMainNodeList);
      return Container(
        color: UIData.primaryColor,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(UIData.spaceSize16),
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
              itemCount: isExpaned ? nodes.length : endflag - starflag,
              //展开全部，收起后，若最后一条主节点有子节点只显示最后的主节点以及其下的所有子节点，若最后一条没有子节点则
              itemBuilder: (BuildContext contex, int index) {
                //列表样式
                int position = isExpaned
                    ? index
                    : starflag + index; //显示列表位置（主要用于收起时显示最后一项）
                WorkOtherProcessNode node = nodes[position];
                return Stack(
                  children: <Widget>[
                    Visibility(
                      visible: isExpaned
                          ? position != nodes.length - 1
                          : position != endflag - 1, //最后一项不显示垂直线
                      child: Positioned(
                          top: 0,
                          bottom: 0,
                          left: UIData.spaceSize20 + UIData.spaceSize20,
                          child: Container(
                            color: Color(0xFFDBEFFF),
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
                            Visibility(
                                visible: node.uiType == 1,
                                child: Container(
                                  constraints: BoxConstraints(minWidth: UIData.spaceSize48, ),
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(
                                      right: UIData.spaceSize16),
                                  child: Container(
                                    constraints: BoxConstraints(minWidth: UIData.spaceSize30, ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          ScreenUtil.getInstance()
                                              .setHeight(15)),
                                      border: Border.all(
                                          color: Color(0xFFDBEFFF)),
                                      color: UIData.primaryColor,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: ScreenUtil.getInstance()
                                            .setHeight(8)),
                                    //                height: ScreenUtil.getInstance().setHeight(16),
                                    alignment: Alignment.center,
                                    child:
                                        CommonText.text10(node.nodeName ?? '',color: Color(0xFF108EE9)),
                                  ),
                                )),
                            Expanded(child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Visibility(
                                  visible: StringsHelper.isNotEmpty(node.name),
                                  child: CommonText.text15(node.name),
                                ),
                                CommonText.text10(node.time ?? "",
                                    color: UIData.lightGreyColor),
                                Visibility(
                                  visible: StringsHelper.isNotEmpty(node.content),
                                  child:  CommonText.text13(node.content ?? "",overflow:TextOverflow.visible,height: null),
                                ),

                                ///打分
                                Visibility(
                                  visible: node.score != 0,


                                    child: CommonStarRating(

                                      count:node.score,
                                        ),

                                ),
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
  }

  List<WorkOtherProcessNode> tran2WorkOtherProcessNodeList(
      List<ProcessMainNode> processMainNodeList) {
    List<WorkOtherProcessNode> workOtherProcessNodes = List();
    for (int i = 0; i < processMainNodeList.length; i++) {
      if(processMainNodeList[i].nodeCode == 'WO_RETURN_VISIT'&&i!=processMainNodeList.length-1){
        if(StringsHelper.isEmpty(processMainNodeList[i].processUserName)){
          continue;
        }
      }
      Map map = getWorkOtherOperationStateType(processMainNodeList[i].nodeCode);
      String nodeName = processMainNodeList[i].processNodeName;
      int uiType = map['type'];
      String time = processMainNodeList[i].processTime ??(processMainNodeList[i].nodeCode=='WO_OPEN'?"": '至今');
      String name =
          ((processMainNodeList[i].nodeCode == 'WO_OPEN' ||
                  processMainNodeList[i].nodeCode == 'WO_CANCEL'||processMainNodeList[i].nodeCode == 'WO_EVALUATE'
          )
              ? (processMainNodeList[i].customerName ?? '')
              : '');
      int score = processMainNodeList[i].serviceGrade ?? 0;
//      if(StringsHelper.isEmpty(nodeName)){
//        nodeName = processMainNodeList[i].processNodeName;
//      }
      if(
      processMainNodeList[i].nodeCode == 'WO_EVALUATE'&&StringsHelper.isNotEmpty(processMainNodeList[i].processRemarks)){
        name=processMainNodeList[i].customerName ?? '默认评价';
      }
      StringBuffer content = new StringBuffer();
//      if (processMainNodeList[i].passFlag != null) {
//        String passStr;
//        if (processMainNodeList[i].passFlag == '0') {
//          if (processMainNodeList[i].nodeCode == 'WO_HANG_AUDIT')
//            passStr = '审核结果：驳回';
//          else
//            if (processMainNodeList[i].nodeCode == 'WO_RETURN_VISIT')
//            passStr = '回访结果：不满意';
//          else
//            passStr = '审核结果：不通过';
//        } else if (processMainNodeList[i].passFlag == '1') {
//          if (processMainNodeList[i].nodeCode == 'WO_HANG_AUDIT')
//            passStr = '审核结果：同意挂起';
//          else
//            if (processMainNodeList[i].nodeCode == 'WO_RETURN_VISIT')
//            passStr = '回访结果：满意';
//          else
//            passStr = '审核结果：通过';
//        }
//        content.write(passStr + '\n');
//      }

      if (processMainNodeList[i].validFlag != null) {
        String valid;
        if (processMainNodeList[i].validFlag == '0') {
          valid = '工单是否有效：无效';
        } else if (processMainNodeList[i].validFlag == '1') {
          valid = '工单是否有效：有效';
        }
        content.write(valid + '\n');
      }


      if(processMainNodeList[i].materialNameList!=null&&processMainNodeList[i].materialNameList.length>0){
        String meterialNameStr = '维修用料：';
        processMainNodeList[i].materialNameList.forEach((str){
          meterialNameStr = meterialNameStr+str+',';
        });
        meterialNameStr = meterialNameStr.substring(0,meterialNameStr.lastIndexOf(','));
        content.write(meterialNameStr + '\n');
      }

      if (processMainNodeList[i].payType != null) {
        String dispatchPostName = '支付方式：';
        if (processMainNodeList[i].payType == '1') {
          dispatchPostName = dispatchPostName + '月结';
        } else if (processMainNodeList[i].payType == '2') {
          dispatchPostName = dispatchPostName + '其他';
        }
        content.write(dispatchPostName + '\n');
      }

      if (processMainNodeList[i].materialFee != null) {
        String dispatchPostName = '当次材料费：';
        dispatchPostName =
            dispatchPostName + processMainNodeList[i].materialFee.toString();
        content.write(dispatchPostName + '元\n');
      }
      if (processMainNodeList[i].laborFee != null) {
        String dispatchPostName = '当次人工费：';
        dispatchPostName =
            dispatchPostName + processMainNodeList[i].laborFee.toString();
        content.write(dispatchPostName + '元\n');
      }

      if (processMainNodeList[i].payPrice != null) {
        String dispatchPostName = '当次总金额：';
        dispatchPostName =
            dispatchPostName + processMainNodeList[i].payPrice.toString();
        content.write(dispatchPostName + '元\n');
      }

      if (StringsHelper.isNotEmpty(processMainNodeList[i].processContent)&&(processMainNodeList[i].nodeCode == 'WO_OPEN' ||
          processMainNodeList[i].nodeCode == 'WO_CANCEL' ||
          processMainNodeList[i].nodeCode == 'WO_EVALUATE'
//          ||processMainNodeList[i].nodeCode == 'WO_RETURN_VISIT'
      )) {
        String processContent = processMainNodeList[i].processContent;
        content.write(processContent + '\n');
      }
      if ((processMainNodeList[i].nodeCode == 'WO_REPLY_FINISH'||processMainNodeList[i].nodeCode == 'WO_PROCESSING')&&StringsHelper.isNotEmpty(processMainNodeList[i].processContent)&&(widget.workOtherType == WorkOtherMainType.Repair||widget.workOtherType == WorkOtherMainType.Complaint||widget.workOtherType == WorkOtherMainType.Advice||widget.workOtherType == WorkOtherMainType.Warning)) {
        String processContent = "处理措施："+processMainNodeList[i].processContent;
        content.write(processContent + '\n');
      }
//      if (StringsHelper.isNotEmpty(processMainNodeList[i].processRemarks)&&(processMainNodeList[i].nodeCode == 'WO_OPEN' ||
//          processMainNodeList[i].nodeCode == 'WO_CANCEL' ||
//          processMainNodeList[i].nodeCode == 'WO_EVALUATE'
//      )) {
//        String processContent = processMainNodeList[i].processRemarks;
//        content.write(processContent + '\n');
//      }
      if(processMainNodeList[i].subNodeList!=null&&processMainNodeList[i].subNodeList.length>0) {
        for (int subPosition = 0; subPosition <
            processMainNodeList[i].subNodeList.length; subPosition++) {
          ProcessSubNode subNode = processMainNodeList[i]
              .subNodeList[subPosition];
          StringBuffer subcontent = new StringBuffer();
          if ((subNode.payPrice != null && subNode.payPrice != 0)||(subNode.materialFee != null && subNode.materialFee != 0)||(subNode.laborFee != null && subNode.laborFee != 0)) {
            if(subNode.materialNameList!=null&&subNode.materialNameList.length>0){
              String meterialNameStr = '维修用料：';
              subNode.materialNameList.forEach((str){
                meterialNameStr = meterialNameStr+str+',';
              });
              meterialNameStr = meterialNameStr.substring(0,meterialNameStr.lastIndexOf(','));
              subcontent.write(meterialNameStr + '\n');
            }
            if (subNode.payType != null) {
              String dispatchPostName = '支付方式：';
              if (subNode.payType == '1') {
                dispatchPostName = dispatchPostName + '月结';
              } else if (subNode.payType == '2') {
                dispatchPostName = dispatchPostName + '其他';
              }
              subcontent.write(dispatchPostName + '\n');
            }

            if (subNode.materialFee != null) {
              String dispatchPostName = '当次材料费：';
              dispatchPostName =
                  dispatchPostName + subNode.materialFee.toString();
              subcontent.write(dispatchPostName + '元\n');
            }
            if (subNode.laborFee != null) {
              String dispatchPostName = '当次人工费：';
              dispatchPostName =
                  dispatchPostName + subNode.laborFee.toString();
              subcontent.write(dispatchPostName + '元\n');
            }
            if (subNode.payPrice != null) {
              String dispatchPostName = '当次总金额：';
              dispatchPostName =
                  dispatchPostName + subNode.payPrice.toString();
              subcontent.write(dispatchPostName + '元\n');
            }
            WorkOtherProcessNode workOtherProcesssubNode = new WorkOtherProcessNode(
              nodeName: subNode.nodeCodeName??nodeName,
              uiType: uiType,
              time: subNode.processTime,
              name: name,
              score: 0,
              content: subcontent.toString(),);
            workOtherProcessNodes.add(workOtherProcesssubNode);
          }
        }
      }


      WorkOtherProcessNode workOtherProcessNode = new WorkOtherProcessNode(
          nodeName: nodeName,
          uiType: uiType,
          time: time,
          name: name,
          score: score,
          content: content.toString(),);
      workOtherProcessNodes.add(workOtherProcessNode);


      if (i == processMainNodeList.length - 1) {
        //记录当前节点前的一个节点
        starflag = workOtherProcessNodes.length - 1;
      }

      if (i == processMainNodeList.length - 1) {
        //记录当前节点前的一个节点
        endflag = workOtherProcessNodes.length;
      }

    }

    return workOtherProcessNodes;
  }

  /**
   * 工单模块操作环节：
   * 提单=WO_OPEN;
   * 撤单=WO_CANCEL；
   * ·派单=WO_DISPATCH；
   * ·接单=WO_RECEIPT；
   * ·处理=WO_PROCESSING；
   * ·协同处理=WO_COOPERATION；
   * ·挂起=WO_HANG_UP；
   * ·转派=WO_TRANSFER；
   * ·返工=WO_REWORK；
   * ·处理完成审核=WO_PRO_AUDIT；
   * `挂起审核=WO_HANG_AUDIT；
   * `解挂=WO_HANG_UP_CANCEL；
   * `督办=WO_SUPERVISE；
   * `支付=WO_PAY；
   * `评价=WO_EVALUATE；
   * `回访=WO_RETURN_VISIT；
   * `关单=WO_CLOSE；
   * 被知会=WO_NOTIFIED;
   * WO_CARBON_COPY：抄送
   * 加急=WO_URGENT；
   * 追记=WO_ADD_CONTENT；
   * 提交进度=WO_SUBMIT。
   */

  Map<String, dynamic> getWorkOtherOperationStateType(String type) {
    String name = '';
    int uiType = 1;
    switch (type) {
      case 'WO_OPEN':
        name = "提单";
        uiType = 1; //蓝色
        break;
      case 'WO_CANCEL':
        name = "撤单";
        uiType = 1; //蓝色
        break;
      case 'WO_DISPATCH':
        name = "派单";
        uiType = 1; //蓝色
        break;
      case 'WO_RECEIPT':
        name = '接单';
        uiType = 1;
        break;
      case 'WO_PROCESSING':
        name = '处理';
        uiType = 1;
        break;
      case 'WO_COOPERATION':
        name = '添加协同人员';
        uiType = 1;
        break;
      case 'WO_HANG_UP':
        name = '申请挂起';
        uiType = 1;
        break;
      case 'WO_TRANSFER':
        name = '转派';
        uiType = 1;
        break;
      case 'WO_REWORK':
        name = '返工';
        uiType = 1;
        break;
      case 'WO_PROCESS_AUDIT':
        name = '完工审核';
        uiType = 1;
        break;
      case 'WO_HANG_AUDIT':
        name = '挂起审核';
        uiType = 1;
        break;
      case 'WO_HANG_UP_CANCEL':
        name = '解挂';
        uiType = 1;
        break;
      case 'WO_SUPERVISE':
        name = '督办';
        uiType = 1;
        break;
      case 'WO_PAY':
        name = '支付';
        uiType = 1;
        break;
      case 'WO_EVALUATE':
        name = '评价';
        uiType = 1;
        break;
      case 'WO_RETURN_VISIT':
        name = '回访';
        uiType = 1;
        break;
      case 'WO_CLOSE':
        name = '关单申请';
        uiType = 1;
        break;
      case 'WO_CLOSE_AUDIT':
        name = '关单审核';
        uiType = 1;
        break;
      case 'WO_URGENT':
        name = '急';
        uiType = 3; //红色圆形
        break;
      case 'WO_ADD_CONTENT':
        name = '追';
        uiType = 4; //蓝色圆形
        break;
      case 'WO_SUBMIT':
        name = '处理';
        uiType = 1; //蓝色原型
        break;
      case 'WO_NOTIFIED':
        name = '阅'; //黄色原型
        uiType = 5;
        break;
      case 'WO_CARBON_COPY':
        name = '抄'; //灰色圆形
        uiType = 2;
        break;
      case 'WO_FINISH':
        name = '完结';
        uiType = 1;
        break;
    }
    return {'name': name, 'type': uiType};
  }
}
