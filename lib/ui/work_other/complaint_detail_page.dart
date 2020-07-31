import 'dart:convert';

import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/process_node.dart';
import 'package:cmp_customer/models/work_other_obj.dart';
import 'package:cmp_customer/models/work_task.dart';
import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/ui/common/common_animation.dart';
import 'package:cmp_customer/ui/common/common_audio_players.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_image_display.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_star_rating.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/work_other/node_listview.dart';
import 'package:cmp_customer/ui/work_other/work_other_ui.dart';
import 'package:cmp_customer/ui/work_other/work_other_ui.dart' as prefix0;
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

///
/// 所有工单的详情（政）since：2019/3/23
///
class ComplaintDetailPage extends StatefulWidget {
  WorkOtherMainType workOtherType;
  int workOrderId;
  String workOtherTypeStr;
  List<ProcessNode> nodes; //流程节点
  ComplaintDetailPage(this.workOtherTypeStr, this.workOrderId, {Key key})
      : super(key: key) {
    //
    switch (workOtherTypeStr) {
      case 'Complaint':
        workOtherType = WorkOtherMainType.Complaint;
        break;
      case 'Warning':
        workOtherType = WorkOtherMainType.Warning;
        break;
      case 'Paid':
        workOtherType = WorkOtherMainType.Paid;
        break;
      case 'Praise':
        workOtherType = WorkOtherMainType.Praise;
        break;
      case 'Advice':
        workOtherType = WorkOtherMainType.Advice;
        break;
      case 'Repair':
        workOtherType = WorkOtherMainType.Repair;
        break;
    }
  }

  @override
  ComplaintDetailPageState createState() =>
      new ComplaintDetailPageState(workOtherType, workOrderId);
}

class ComplaintDetailPageState extends State<ComplaintDetailPage> {
  static bool isOpen;
  WorkOtherMainType workOtherType;
  int workOrderId;
  WorkOtherStateType workOtherStateType;
  WorkOtherStateType workOtherStateTypeReal;
  WorkTask task = new WorkTask();
  String evaluate_tips = '';
  TextEditingController editController = TextEditingController();
  bool flag = false;
  bool isExpanedMaterial = false;

  ComplaintDetailPageState(this.workOtherType, this.workOrderId);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isOpen = true;
    stateModel.getWorkOthersDetail(workOrderId);
  }

  reflashDetailPage(int workOrderId) {
    setState(() {
      this.workOrderId = workOrderId;
      editController.clear();
      task = new WorkTask();
    });
    stateModel.getWorkOthersDetail(workOrderId);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    isOpen = false;
    if (flag) {
      stateModel.workOtherHistoryHandleRefresh(
          getWorkOtherMainTypeStr(workOtherType),
          preRefresh: true);
    }
//    stateModel.cleanWorkOthersDetailModel();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    switch (task.serviceGrade) {
      case 1:
        evaluate_tips = '非常不满意';
        break;
      case 2:
        evaluate_tips = '比较不满意';
        break;
      case 3:
        evaluate_tips = '一般';
        break;
      case 4:
        evaluate_tips = '满意';
        break;
      case 5:
        evaluate_tips = '非常满意';
        break;
      default:
        evaluate_tips = '非常满意';
        break;
    }

    return ScopedModelDescendant<MainStateModel>(
        builder: (context, child, model) {
      if (stateModel.workOther != null)
        workOtherStateType = getWorkOtherStateType(stateModel.workOther);
      workOtherStateTypeReal = getWorkOtherStateRealType(stateModel.workOther);
      return new CommonScaffold(
          popBack: () {
            LogUtils.printLog('============>' + flag.toString());

            Navigate.closePage();

//            Navigator.of(context).pop(flag);
          },
          appBarActions: <Widget>[
            Visibility(
                visible: workOtherStateTypeReal == WorkOtherStateType.accepting,
                child: FlatButton(
                    onPressed: () {
                      task.workOrderId = workOrderId;
                      task.processAction = '0';
                      flag = true;
                      stateModel.commitWorkTask(
                          task: task,
                          callBack: () {
                            _refresh();
                          });
                    },
                    child: CommonText.red15Text('撤单')))
          ],
          appTitle: getTitle(workOtherType, 2),
          bodyData: _buildContent(model));
    });
  }

//appBar:String

//Type:String
  Map<String, String> _getType(WorkOtherStateType workOtherStateType) {
    Map<String, String> tips = new Map();

    switch (workOtherStateType) {
      case WorkOtherStateType.accepting:
        tips['type'] = state_accepting;
        tips['tip'] = state_tip;
        break;
      case WorkOtherStateType.accepted:
        tips['type'] = state_accepted;
        tips['tip'] = state_tip;
        break;
      case WorkOtherStateType.finished:
        tips['type'] = state_finishe;
        tips['tip'] = state_tip2;
        break;
      case WorkOtherStateType.worked:
        tips['type'] = state_worked;
        tips['tip'] = state_tip2;
        break;
      case WorkOtherStateType.working:
        tips['type'] = state_working;
        tips['tip'] = state_tip2;
        break;
      case WorkOtherStateType.can_rate:
        tips['type'] = state_can_rat;
        tips['tip'] = state_tip3;
        break;
      case WorkOtherStateType.can_pay:
        tips['type'] = state_can_pay;
        tips['tip'] = state_tip4;
        break;
      case WorkOtherStateType.closed:
        tips['type'] = state_close;
        tips['tip'] = state_tip5;
        break;
      case WorkOtherStateType.cancel:
        tips['type'] = state_cance;
        tips['tip'] = "";
        break;
    }
    return tips;
  }

  Widget _buildContent(model) {
    return CommonLoadContainer(
        state: model.workOtherDetailLoadState,
        callback: _refresh,
        content: _buildWidget());
  }

  _refresh() async {
    stateModel.getWorkOthersDetail(workOrderId);
  }

  Widget _buildWidget() {
    return ListView(
      children: <Widget>[
        ///状态操作栏
        Container(
            color: Colors.white,
            padding: EdgeInsets.all(UIData.spaceSize16),
            child: Column(
              children: <Widget>[
                ///状态栏
                CommonText.darkGrey16Text(
                    _getType(workOtherStateType)['type'] ?? ''),
                Container(
                  padding: EdgeInsets.only(top: UIData.spaceSize8),
                  child: CommonText.lightGrey12Text(
                      _getType(workOtherStateType)['tip'] ?? ''),
                ),

                ///评价栏
                Visibility(
                    visible:
//                    (stateModel.workOther?.processNodeCode != null &&
//                        stateModel.workOther.processNodeCode == 'WO_EVALUATE')||
                        workOtherStateType == WorkOtherStateType.can_rate,
//                    visible: (model.workOther?.code ?? 0) == 0,
                    child: Container(
                        margin: EdgeInsets.only(top: UIData.spaceSize12),
                        child: Column(
                          children: <Widget>[
                            CommonFullScaleDivider(),
                            SizedBox(
                              height: UIData.spaceSize12,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                UIData.iconEntry,
                                Expanded(
                                  child: inputWidget(
                                    canEdit:
//                                    (stateModel.workOther?.processNodeCode != null &&
//                                        stateModel.workOther.processNodeCode == 'WO_EVALUATE')||
                                        workOtherStateType ==
                                            WorkOtherStateType.can_rate,
                                    controller: editController,
                                    hint_text: hint_text,
                                    bottomSpace: 0,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: UIData.spaceSize12,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                CommonStarRating(
                                  starSize: UIData.fontSize20,
                                  spacing: UIData.spaceSize8,
                                  enableClick: true,
                                  onStar: (int starCount) {
                                    setState(() {
                                      task.serviceGrade = starCount;
                                    });
                                  },
                                ),
                                CommonText.darkGrey14Text(evaluate_tips),
                                RadiusSolidText(
                                  text: label_submit,
                                  horizontalPadding: UIData.spaceSize16,
                                  verticalPadding: UIData.spaceSize4,
                                  onTap: () {
                                    task.workOrderId = workOrderId;
                                    task.processAction = '9';
                                    task.processContent =
                                        editController.text ?? '';
                                    if (task.serviceGrade == null) {
                                      task.serviceGrade = 5;
                                    }
                                    flag = true;
                                    stateModel.commitWorkTask(
                                        task: task,
                                        callBack: () {
                                          _refresh();
                                        });
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: UIData.spaceSize12,
                            ),
                          ],
                        ))),
              ],
            )),
        CommonFullScaleDivider(),

        ///节点栏
        NodeListView(widget.workOrderId,workOtherType: widget.workOtherType,),

        ///有偿服务栏
        Visibility(
            visible: stateModel.showPayInfo == ListState.HINT_DISMISS &&
                workOtherType == WorkOtherMainType.Paid,
            child: PayServiceCard(stateModel.payServiceInfo)),

        ///表单数据栏
        Container(
            color: Colors.white,
            margin: EdgeInsets.only(top: UIData.spaceSize12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ///预约数据
                Visibility(
                  visible: workOtherType == WorkOtherMainType.Paid,
                  child: Column(
                    children: <Widget>[
                      ///预约地点
                      Container(
                        padding: EdgeInsets.all(UIData.spaceSize16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            CommonText.darkGrey16Text('预约地点'),
                            SizedBox(
                              width: UIData.spaceSize20,
                            ),
                            CommonText.lightGrey16Text(
                                stateModel.workOther?.houseName ?? ''),
                          ],
                        ),
                      ),
                      CommonDivider(),

                      ///预约时间
                      Container(
                        padding: EdgeInsets.all(UIData.spaceSize16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            CommonText.darkGrey16Text('预约时间'),
                            SizedBox(
                              width: UIData.spaceSize20,
                            ),
                            Expanded(
                              child: CommonText.lightGrey16Text(
                                  replaceSecondTime(
                                      stateModel.workOther?.appointmentTime ??
                                          '')),
                            ),
                          ],
                        ),
                      ),
                      CommonDivider(),

                       ///预约类型
                      Container(
                        padding: EdgeInsets.all(UIData.spaceSize16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            CommonText.darkGrey16Text('订单类型'),
                            SizedBox(
                              width: UIData.spaceSize20,
                            ),
                            Expanded(
                              child: CommonText.lightGrey16Text(getListStr(
                                  stateModel.workOther?.paidStyleList)),
                            ),
                          ],
                        ),
                      ),
                      CommonDivider(),

                      ///预约类型
                      Container(
                        padding: EdgeInsets.all(UIData.spaceSize16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            CommonText.darkGrey16Text('服务名称'),
                            SizedBox(
                              width: UIData.spaceSize20,
                            ),
                            Expanded(
                              child: CommonText.lightGrey16Text(
                                  stateModel.workOther?.reportSource??''),
                            ),
                          ],
                        ),
                      ),
                      CommonDivider(),

                      ///预约类型
                      Container(
                        padding: EdgeInsets.all(UIData.spaceSize16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            CommonText.darkGrey16Text('服务描述'),
                            SizedBox(
                              width: UIData.spaceSize20,
                            ),
                            Expanded(
                              child: CommonText.lightGrey16Text(
                                  stateModel.workOther?.reportRemarks??''),
                            ),
                          ],
                        ),
                      ),
                      CommonDivider(),
                    ],
                  ),
                ),

                ///语音内容
                Visibility(
                    visible: (stateModel
                                    .workOther?.workOrderVoiceList?.length ??
                                0) >
                            0 &&
                        stateModel.workOther.workOrderVoiceList[0] != null &&
                        stateModel.workOther.workOrderVoiceList[0]
                            .containsKey('uuid') &&
                        stateModel.workOther.workOrderVoiceList[0]['uuid'] !=
                            null,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(UIData.spaceSize16),
                          child: Row(
                            children: <Widget>[
                              CommonText.darkGrey16Text('语音内容'),
                              Expanded(
                                  child: CommonAudioPlayers(((stateModel
                                                      .workOther
                                                      ?.workOrderVoiceList
                                                      ?.length ??
                                                  0) >
                                              0 &&
                                          stateModel.workOther
                                                  .workOrderVoiceList[0] !=
                                              null)
                                      ? stateModel.workOther
                                                      .workOrderVoiceList[0]
                                                  ['uuid'] !=
                                              null
                                          ? stateModel.workOther
                                              .workOrderVoiceList[0]['uuid']
                                          : ''
                                      : '')),
                            ],
                          ),
                        ),
                        CommonDivider(),
                      ],
                    )),

                ///文字内容
                Visibility(
                  visible: true,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(UIData.spaceSize16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
//                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            CommonText.darkGrey16Text(
                                getTitle(workOtherType, -1) + '内容'),
                            SizedBox(
                              width: UIData.spaceSize20,
                            ),
                            Expanded(
                              child: CommonText.lightGrey16Text(
                                  stateModel.workOther?.reportContent ?? ''),
                            ),
                          ],
                        ),
                      ),
                      CommonDivider(),
                    ],
                  ),
                ),
                Visibility(
                  visible: workOtherType == WorkOtherMainType.Advice &&
                      StringsHelper.isNotEmpty(
                          stateModel.workOther?.reportRemarks ?? ''),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(UIData.spaceSize16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
//                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            CommonText.darkGrey16Text('客服回复'),
                            SizedBox(
                              width: UIData.spaceSize20,
                            ),
                            Expanded(
                              child: CommonText.lightGrey16Text(
                                  stateModel.workOther?.reportRemarks ?? ''),
                            ),
                          ],
                        ),
                      ),
                      CommonDivider(),
                    ],
                  ),
                ),

                ///文字内容
//                Visibility(
//                  visible: StringsHelper.isNotEmpty(getAdviceContent()),
//                  child: Column(
//                    children: <Widget>[
//                      Container(
//                        padding: EdgeInsets.all(UIData.spaceSize16),
//                        child: Row(
//                          crossAxisAlignment: CrossAxisAlignment.start,
////                          mainAxisAlignment: MainAxisAlignment.start,
//                          children: <Widget>[
//                            CommonText.darkGrey16Text('客服回复'),
//                            SizedBox(
//                              width: UIData.spaceSize20,
//                            ),
//                            Expanded(
//                              child: CommonText.lightGrey16Text(
//                                  getAdviceContent() ?? ''),
//                            ),
//                          ],
//                        ),
//                      ),
//                      CommonDivider(),
//                    ],
//                  ),
//                ),

                ///报障地点
                Visibility(
                  visible: workOtherType == WorkOtherMainType.Warning,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(UIData.spaceSize16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            CommonText.darkGrey16Text('公区报障地点'),
                            SizedBox(
                              width: UIData.spaceSize20,
                            ),
                            Expanded(
                              child: CommonText.lightGrey16Text(
                                  stateModel.workOther?.customerAddress ?? ''),
                            ),
                          ],
                        ),
                      ),
                      CommonDivider(),
                    ],
                  ),
                ),

                ///报修房间
                Visibility(
                  visible: workOtherType == WorkOtherMainType.Repair,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(UIData.spaceSize16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            CommonText.darkGrey16Text('报修房间'),
                            SizedBox(
                              width: UIData.spaceSize20,
                            ),
                            Expanded(
                              child: CommonText.lightGrey16Text(
                                  stateModel.workOther?.houseName ?? ''),
                            ),
                          ],
                        ),
                      ),
                      CommonDivider(),
                    ],
                  ),
                ),
                Visibility(
                  visible: workOtherType == WorkOtherMainType.Repair,
                  child: CommonDivider(),
                ),
                Visibility(
                  visible: workOtherType == WorkOtherMainType.Repair,
                  child:

                      ///预约时间
                      Container(
                    padding: EdgeInsets.all(UIData.spaceSize16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CommonText.darkGrey16Text('预约时间'),
                        SizedBox(
                          width: UIData.spaceSize20,
                        ),
                        Expanded(
                          child: CommonText.lightGrey16Text(
                              replaceSecondTime(
                                  stateModel.workOther?.appointmentTime ??
                                      '')),
                        ),
                      ],
                    ),
                  ),
                ),

                Visibility(
                  child: Container(
                      padding: EdgeInsets.only(
                          top: UIData.spaceSize12,
                          left: UIData.spaceSize16,
                          right: UIData.spaceSize16,
                          bottom: UIData.spaceSize16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CommonText.darkGrey16Text('照片'),
                          SizedBox(
                            height: UIData.spaceSize8,
                          ),
                          CommonImageDisplay(photoIdList: getPhoto()),
                        ],
                      )),
                  visible: stateModel.workOther?.workOrderPhotoList != null &&
                      stateModel.workOther?.workOrderPhotoList.length > 0,
                ),
              ],
            )),

        ///单号、日期
        Container(
          color: Colors.white,
          margin: EdgeInsets.only(
              top: UIData.spaceSize12, bottom: UIData.spaceSize30),
          padding: EdgeInsets.all(UIData.spaceSize16),
          child: Column(
            children: <Widget>[
              Visibility(
                visible: stateModel.workOther?.materialNameList != null &&
                    stateModel.workOther?.materialNameList.length > 0,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CommonText.lightGrey14Text('维修用料'),
                      SizedBox(
                        width: UIData.spaceSize20,
                      ),
                      Expanded(
                        child: CommonText.lightGrey14Text(
                            (stateModel.workOther?.materialNameList != null &&
                                    stateModel.workOther?.materialNameList
                                            .length >
                                        0)
                                ? stateModel.workOther?.materialNameList[0]
                                : ''),
                      ),
                      ArrowRotateWidget((onChanged) {
                        setState(() {
                          isExpanedMaterial = onChanged;
                        });
                      }),
                    ],
                  ),
                ),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: isExpanedMaterial
                    ? stateModel.workOther?.materialNameList.length
                    : 0, //展开全部，收起只显示一项
                itemBuilder: (BuildContext contex, int index) {
                  return Visibility(
                    visible: index != 0,
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                CommonText.lightGrey14Text('           '),
                                SizedBox(
                                  width: UIData.spaceSize20,
                                ),
                                Expanded(
                                  child: CommonText.lightGrey14Text(stateModel
                                          .workOther?.materialNameList[index] ??
                                      ''),
                                ),
                              ],
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: UIData.spaceSize6,
                                horizontal: UIData.spaceSize16),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Visibility(
                visible: stateModel.workOther?.totalMaterialFee != null,
                child: Container(
                  margin: EdgeInsets.only(bottom: UIData.spaceSize6),
                  child: Row(
                    children: <Widget>[
                      CommonText.lightGrey14Text('总材料费'),
                      SizedBox(
                        width: UIData.spaceSize20,
                      ),
                      CommonText.lightGrey14Text(((stateModel
                                  .workOther?.totalMaterialFee
                                  ?.toString()) ??
                              '0') +
                          '元'),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: stateModel.workOther?.totalLaborFee != null,
                child: Container(
                  margin: EdgeInsets.only(bottom: UIData.spaceSize6),
                  child: Row(
                    children: <Widget>[
                      CommonText.lightGrey14Text('总人工费'),
                      SizedBox(
                        width: UIData.spaceSize20,
                      ),
                      CommonText.lightGrey14Text(
                          ((stateModel.workOther?.totalLaborFee?.toString()) ??
                                  '0') +
                              '元'),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: stateModel.workOther?.totalLaborFee != null ||
                    stateModel.workOther?.totalMaterialFee != null,
                child: Container(
                  margin: EdgeInsets.only(bottom: UIData.spaceSize6),
                  child: Row(
                    children: <Widget>[
                      CommonText.lightGrey14Text('总金额'),
                      SizedBox(
                        width: UIData.spaceSize20,
                      ),
                      CommonText.lightGrey14Text(
                          ((stateModel.workOther?.totalLaborFee ?? 0) +
                                      (stateModel.workOther?.totalMaterialFee ??
                                          0))
                                  .toString() +
                              '元'),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: UIData.spaceSize8),
                child: Row(
                  children: <Widget>[
                    CommonText.lightGrey12Text('日期'),
                    SizedBox(
                      width: UIData.spaceSize40,
                    ),
                    CommonText.lightGrey12Text(
                        stateModel.workOther?.createTime ?? ''),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  CommonText.lightGrey12Text('单号'),
                  SizedBox(
                    width: UIData.spaceSize40,
                  ),
                  CommonText.lightGrey12Text(
                      stateModel.workOther?.workOrderCode ?? ''),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<String> getPhoto() {
    List<String> photos = List<String>();
    if (stateModel.workOther?.workOrderPhotoList != null)
      stateModel.workOther.workOrderPhotoList.forEach((workOrderPhotoinfo) {
        photos.add(workOrderPhotoinfo['uuid']);
      });
    return photos;
  }

  String getListStr(List<String> list) {
    String listsrt = '';
    if (list != null) {
      list.forEach((str) {
        listsrt = listsrt + str + "、";
      });
    }
    return listsrt;
  }
  getWorkOtherStateRealType(WorkOther info) {
    WorkOtherStateType workOtherStateType;
    if (info?.hasEvaluate != null && info?.hasEvaluate == '1') {
      workOtherStateType = WorkOtherStateType.can_rate;
    } else if (info?.hasFinish != null && info?.hasFinish == '2') {
      workOtherStateType = WorkOtherStateType.finished;
    } else if (info?.hasDone != null && info?.hasDone == '2') {
      workOtherStateType = WorkOtherStateType.worked;
    } else if (info?.hasAccept != null && info?.hasAccept == '2') {
      workOtherStateType = WorkOtherStateType.accepted;
    } else {
      workOtherStateType = WorkOtherStateType.accepting;
    }
    return workOtherStateType;
  }
  getWorkOtherStateType(WorkOther info) {
    WorkOtherStateType workOtherStateType;
    if (info?.hasEvaluate != null && info?.hasEvaluate == '1') {
      workOtherStateType = WorkOtherStateType.can_rate;
    } else if (info?.hasFinish != null && info?.hasFinish == '2') {
      workOtherStateType = WorkOtherStateType.finished;
    } else if (info?.hasDone != null && info?.hasDone == '2') {
      workOtherStateType = WorkOtherStateType.worked;
    } else if (info?.hasAccept != null && info?.hasAccept == '2') {
      workOtherStateType = WorkOtherStateType.accepted;
    } else {
      workOtherStateType = WorkOtherStateType.accepting;
    }
    if (workOtherStateType != WorkOtherStateType.accepting&&info?.hasPaid != null && info?.hasPaid == '1') {
      workOtherStateType = WorkOtherStateType.can_pay;
    }
    if (info?.hasCancel != null && info?.hasCancel == '1') {
      workOtherStateType = WorkOtherStateType.cancel;
    }
    if (info?.hasClose != null && info?.hasClose == '2') {
      workOtherStateType = WorkOtherStateType.closed;
    }
    return workOtherStateType;
  }

//  String getAdviceContent() {
//    String tips = '';
//    if (workOtherType == WorkOtherMainType.Advice) if (stateModel
//                .processMainNodeList !=
//            null &&
//        stateModel.processMainNodeList.length > 0) {
//      stateModel.processMainNodeList.forEach((info) {
//        if (info?.nodeCode == 'WO_PROCESSING') {
//          tips = info?.processContent;
//        }
//        if (info?.nodeCode == 'WO_PROCESS_AUDIT' &&
//            (info?.passFlag ?? '') == '1') {
//          tips = info?.processContent ?? '';
//        }
//      });
//    }
//    return tips;
//  }
}
