import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/models/work_order_vo.dart';
import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/ui/common/common_audio.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_image_picker.dart';
import 'package:cmp_customer/ui/common/common_picker.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/work_other/choose_house.dart';
import 'package:cmp_customer/ui/work_other/complain_history_list.dart';
import 'package:cmp_customer/ui/work_other/work_other_ui.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

///
/// 新建报障工单（政）since：2019/3/23
///
class ComplaintPage extends StatefulWidget {
  WorkOtherMainType ComplaintType;
  WorkOtherSubType sub;

  ComplaintPage(this.ComplaintType, {this.sub});

  @override
  _ComplaintPageState createState() => new _ComplaintPageState(ComplaintType);
}

class _ComplaintPageState extends State<ComplaintPage> {
  WorkOtherMainType ComplaintType;
  List<String> photos = new List();
  String file;
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  _ComplaintPageState(this.ComplaintType);

  WorkOrderVo workOrderVo = new WorkOrderVo();
  List<String> timeList;

  String time;
  String appointmentTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.text = "";
    controller2.text = "";
    workOrderVo.orderCategory='WY';
    if( ComplaintType == WorkOtherMainType.Repair){
      workOrderVo.customerAddress =
      '${stateModel?.defaultBuildingName ?? ''}${stateModel?.defaultUnitName ??
          ''}${stateModel?.defaultHouseName ?? ''}';
      workOrderVo.houseId = stateModel?.defaultHouseId;
      workOrderVo.projectId = stateModel?.defaultProjectId ?? -1;
      workOrderVo.buildId = stateModel?.defaultBuildingId ?? -1;
      workOrderVo.unitId = stateModel?.defaultUnitId ?? -1;
    }
//    MainStateModel.of(context).loadHightWordsList(ComplaintType);

    if(ComplaintType == WorkOtherMainType.Repair)
      initTime(DateTime.now());
  }
  initTime(DateTime today){
    String appointmentTime1 = "${today.year.toString()}-${today.month.toString().padLeft(2,'0')}-${today.day.toString().padLeft(2,'0')}";
    List timeList1 = getCanSelectTimeList(DateTime.parse(appointmentTime1));
    if (timeList1 != null && timeList1.length > 0) {
      String time1 = timeList1[0];
      appointmentTime = appointmentTime1;
      timeList = timeList1;
      time = time1;
      return;
    }else {
      DateTime tomollor  = today.add(new Duration(days: 1));
      initTime(tomollor);
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    stateModel.workOtherCreateState = ListState.HINT_DISMISS;
    stateModel.cleanHighFrequencyWordsStateModel();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainStateModel>(
      builder: (context, child, model){
        return new CommonScaffold(
            appTitle: getTitle(ComplaintType, 0, sub: widget.sub),
            bodyData: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    //语音内容

                      color: Colors.white,
                      padding: EdgeInsets.all(UIData.spaceSize16),
                      child: Row(
                        children: <Widget>[
                          CommonText.grey16Text("语音内容"),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: UIData.spaceSize10),
                              child: CommonAudio(recordCallback: (filename) {
                                file = filename;
                                if (workOrderVo.workOrderVoiceList == null) {
                                  workOrderVo.workOrderVoiceList = new List();
                                }
                                workOrderVo.workOrderVoiceList.clear();
                                if (file != null) {
                                  workOrderVo.workOrderVoiceList.add(file);
                                }
                                stateModel.hasUpload = false;
                              }),
                            ),
                          ),
                        ],
                      )),
                  CommonDivider(),
                  Visibility(
                    //保障地点
                      visible: ComplaintType == WorkOtherMainType.Warning,
                      child: Container(
                          padding: EdgeInsets.only(left: UIData.spaceSize16),
                          color: Colors.white,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              CommonText.grey16Text(lable_Warning_loction),
                              Expanded(
                                  child: inputWidget(
                                    hint_text: hint_text,
                                    topSpace: UIData.spaceSize12,
                                    leftSpace: UIData.spaceSize30,
                                    rightSpace: UIData.spaceSize16,
                                    bottomSpace: UIData.spaceSize12,
                                    controller: controller2,
                                  ))
                            ],
                          ))),
                  Visibility(
                    visible: ComplaintType == WorkOtherMainType.Warning,
                    child: CommonDivider(),
                  ),


                  Visibility(visible: ComplaintType == WorkOtherMainType.Repair,
                    child:

                    ///选择预约地点
                    Container(

                      margin: EdgeInsets.only(bottom: UIData.spaceSize12),
                      padding: EdgeInsets.symmetric(
                          horizontal: UIData.spaceSize16,
                          vertical: UIData.spaceSize12),
                      color: Colors.white,
                      child: GestureDetector(
                        onTap: () {
                          Navigate.toNewPage(ChooseHousePage(),callBack: (HouseInfo model) {
                            if (model != null) {
                                setState(() {
                                  LogUtils.printLog('报修房间：${model.formerName}');
                                  workOrderVo.customerAddress =
                                  '${model?.formerName ?? ''}${model?.buildName ?? ''}${model?.unitName ??
                                      ''}${model?.houseNo ?? ''}';
                                  workOrderVo.houseId = model?.houseId;
                                  workOrderVo.projectId = model?.projectId ?? -1;
                                  workOrderVo.buildId = model?.buildId ?? -1;
                                  workOrderVo.unitId = model?.unitId ?? -1;
                                });
                            }
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CommonText.darkGrey15Text('报修房间'),
                            SizedBox(width: UIData.spaceSize30,),
                            Expanded(
                                child: workOrderVo.houseId == null ||
                                    workOrderVo.customerAddress == null
                                    ? CommonText.lightGrey16Text(
                                    hint_text_no_choose)
                                    : CommonText.darkGrey16Text(
                                    workOrderVo.customerAddress, overflow: TextOverflow.fade)
                            ),
                            Icon(
                              Icons.keyboard_arrow_right,
                              color: UIData.iconGreyColor,
                            ),
                          ],
                        ),
                      ),
                    ),),

                  Visibility(
                    visible: ComplaintType == WorkOtherMainType.Repair,
                    child: CommonDivider(),
                  ),
                  ///选择预约时间
                  Visibility(
                    visible: ComplaintType == WorkOtherMainType.Repair,
                    child: Container(

                      padding: EdgeInsets.symmetric(
                          horizontal: UIData.spaceSize16,
                          vertical: UIData.spaceSize12),
                      color: Colors.white,
                      child: GestureDetector(
                        onTap: () {
                          CommonPicker.datePickerModal(context,

                              onConfirm: (String date) {
                                setState(() {

                                  timeList =
                                      getCanSelectTimeList(DateTime.parse(date));
                                  if (timeList != null && timeList.length > 0) {
                                    appointmentTime = date;
                                    time = timeList[0];
                                  }else {

                                    CommonToast.show(
                                        type: ToastIconType.FAILED,
                                        msg: '该日期暂无预约时间，请重新选择');
                                  }
                                });
                              });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CommonText.darkGrey15Text(appointment_time),
                            SizedBox(
                              width: UIData.spaceSize30,
                            ),
                            Expanded(
                                child: appointmentTime == null
                                    ? CommonText.lightGrey16Text(
                                    hint_text_choose_required)
                                    : CommonText.darkGrey16Text(
                                    appointmentTime)),
                            Icon(
                              Icons.keyboard_arrow_right,
                              color: UIData.iconGreyColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: ComplaintType == WorkOtherMainType.Repair,
                    child: CommonDivider(),
                  ),
                  Visibility(
                    visible: ComplaintType == WorkOtherMainType.Repair,
                    child: Container(
                      margin: EdgeInsets.only(bottom: UIData.spaceSize12),
                      padding: EdgeInsets.symmetric(
                          horizontal: UIData.spaceSize16,
                          vertical: UIData.spaceSize12),
                      color: Colors.white,
                      child: GestureDetector(
                        onTap: () {
                          if (timeList != null && timeList.length > 0)
                            CommonPicker.singlePickerModal(
                                context, timeList, onConfirm: (value, listvalue) {
                              setState(() {
                                time = listvalue.toString();
                              });
                            });
                          else {
                            CommonToast.show(
                                type: ToastIconType.FAILED, msg: '该日期暂无预约时间，请重新选择');
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CommonText.darkGrey15Text(appointment_time),
                            SizedBox(
                              width: UIData.spaceSize30,
                            ),
                            Expanded(
                                child: time == null
                                    ? CommonText.lightGrey16Text(
                                    hint_text_choose_required)
                                    : CommonText.darkGrey16Text(time)),
                            Icon(
                              Icons.keyboard_arrow_right,
                              color: UIData.iconGreyColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: ComplaintType == WorkOtherMainType.Repair,
                    child: CommonDivider(),
                  ),

                  Container(
                    //上传照片
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          leftTextWidget(
                              text: "上传照片", topSpacing: UIData.spaceSize16),
                          Container(
                            margin: EdgeInsets.all(UIData.spaceSize16),
                            child: CommonImagePicker(callback: (List<String> list) {
                              if (photos == null) {
                                photos = new List();
                              } else {
                                photos.clear();
                              }
                              photos.addAll(list);
                            }),
                          )
                        ],
                      )),
                  CommonDivider(),
                  Container(
                      color: Colors.white,
                      padding: EdgeInsets.only(right: UIData.spaceSize16),
                      margin: EdgeInsets.only(top: UIData.spaceSize12),
                      child: Column(
                        children: <Widget>[
                          leftTextWidget(
                            text: ComplaintType == WorkOtherMainType.Complaint
                                ? "投诉内容"
                                : ComplaintType == WorkOtherMainType.Warning
                                ? "报障内容"
                                : ComplaintType == WorkOtherMainType.Repair
                                ? "报修内容"
                                : ComplaintType == WorkOtherMainType.Praise
                                ? '表扬内容'
                                : widget.sub == WorkOtherSubType.Advice
                                ? '咨询建议内容'
                                : '反馈意见',
                            topSpacing: UIData.spaceSize16,
                          ),
                          inputWidget(
                            controller: controller,
                            hint_text: hint_text,
                            maxLength: 200,
                            bottomSpace: UIData.spaceSize16,
                            editTopPadding: UIData.spaceSize4,
                            editBotPadding: UIData.spaceSize30,
                          )
                        ],
                      )),
                  Container(
                    color: UIData.primaryColor,
                    child: Divider(color: UIData.dividerColor, height: 1.0),
                  ),
//              _buildList(),
                ],
              ),
            ),
            bottomNavigationBar: StadiumSolidButton(
              stateModel.workOtherCreateState!=ListState.HINT_LOADING?label_submit:'提交中',
              btnType: ButtonType.CONFIRM,
              enable: stateModel.workOtherCreateState!=ListState.HINT_LOADING,
              onTap: () {
                String contentStr = controller.text;
                String title;
                switch (ComplaintType) {
                  case WorkOtherMainType.Complaint:
                    title = "投诉";

                    break;
                  case WorkOtherMainType.Warning:
                    title = "公区报障";
                    String locationStr = controller2.text;
                    if (StringsHelper.isEmpty(locationStr)) {
                      CommonToast.show(
                          msg: "亲，请填写故障的地点!", type: ToastIconType.FAILED);
                      return;
                    }
                    break;
                  case WorkOtherMainType.Praise:
                    title = "表扬";
                    break;
                  case WorkOtherMainType.Repair:
                    title = "室内维修";
                    break;
                  case WorkOtherMainType.Advice:
                    if (widget.sub == WorkOtherSubType.Advice)
                      title = "咨询建议";
                    else
                      title = '反馈';
                    break;
                  default:
                    break;
                }
                if (ComplaintType == WorkOtherMainType.Repair) {
                  if (StringsHelper.isEmpty(appointmentTime)) {
                    CommonToast.show(
                        msg: "亲，请选择预约日期", type: ToastIconType.FAILED);
                    return;
                  }
                  if (StringsHelper.isEmpty(time)) {
                    CommonToast.show(
                        msg: "亲，请选择预约时间", type: ToastIconType.FAILED);
                    return;
                  }
                  if (StringsHelper.isNotEmpty(appointmentTime) &&
                      StringsHelper.isNotEmpty(time)) {
                    List<String> timeList = getCanSelectTimeList(
                        DateTime.parse(appointmentTime));
                    if (timeList == null || timeList.length == 0) {
                      CommonToast.show(
                          type: ToastIconType.FAILED, msg: '该日期暂无预约时间，请重新选择');
                      return;
                    }
                    int now = int.parse(timeList[0].substring(0, 2));
                    int choose = int.parse(time.substring(0, 2));
                    if (choose < now) {
                      CommonToast.show(type: ToastIconType.FAILED, msg: '预约超时，请重新选择');
                      return;
                    }
                    try {
                      List<String> times = time.split('-');
                      workOrderVo.appointmentTime =
                      '${appointmentTime} ${times[0]}:00,${appointmentTime} ${times[1]}:00';
                    } catch (e) {
                      CommonToast.show(type: ToastIconType.FAILED, msg: '预约超时，请重新选择');
                      return;
                    }
                  }
                }
                bool photosFlag = true;
                if (photos != null)
                  photos.forEach((str) {
                    if (str == null) {
                      CommonToast.show(
                          msg: "尚有未上传完成的图片", type: ToastIconType.FAILED);
                      photosFlag = false;
                      return;
                    }
                  });
                if (!photosFlag) {
                  return;
                }
                if (StringsHelper.isEmpty(file) &&
                    StringsHelper.isEmpty(contentStr)) {
                  CommonToast.show(
                      msg: "亲，请填写" + title + "内容或录音", type: ToastIconType.FAILED);
                  return;
                }


                workOrderVo.createSource = 'CreateByCustomerApp';
                workOrderVo.validFlag = '1';
                workOrderVo.reportSource =
                ComplaintType == WorkOtherMainType.Complaint
                    ? 'CustomerAPP'
                    : null;
                workOrderVo.customerType = stateModel.custType;
                workOrderVo.customerId = stateModel.customerId;
                workOrderVo.customerName = stateModel.customerName;
                workOrderVo.customerPhone = stateModel.userAccount;
                workOrderVo.projectId = stateModel.defaultProjectId ?? -1;
                workOrderVo.buildId = stateModel.defaultBuildingId ?? -1;
                workOrderVo.unitId = stateModel.defaultUnitId ?? -1;
                workOrderVo.houseId = stateModel.defaultHouseId;
                if(ComplaintType !=  WorkOtherMainType.Repair){
                  workOrderVo.customerAddress =controller2.text;
                }
                workOrderVo.urgentLevel = "1";
                workOrderVo.workOrderPhotoList = photos;

                workOrderVo.serviceType = getWorkOtherMainTypeStr(ComplaintType);
                workOrderVo.serviceSubType = getWorkSubTypeStr(
                    ComplaintType == WorkOtherMainType.Complaint
                        ? WorkOtherSubType.ProjectComplaint
                        : ComplaintType == WorkOtherMainType.Warning
                        ? WorkOtherSubType.MinorWarning
                        : ComplaintType == WorkOtherMainType.Repair
                        ? WorkOtherSubType.Repair
                        : ComplaintType == WorkOtherMainType.Praise
                        ? WorkOtherSubType.Praise
                        : widget.sub);
                workOrderVo.reportContent = contentStr;
                if (ComplaintType == WorkOtherMainType.Complaint) {
                  workOrderVo.complaintProperty = 'GeneralComplaints';
                  workOrderVo.reportSource = 'CustomerAPP';
                }
//            setState(() {
//              stateModel.workOtherCreateState = ListState.HINT_LOADING;
//            });
                stateModel.commitWorkOther(
                    workOther: workOrderVo,
                    callBack: () {
                      Navigator.of(context).pop();
                    });
              },
            ),
            appBarActions: [
              IconButton(
                  icon: UIData.iconMore2,
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return ComplainHistoryPage(ComplaintType);
                    }));
                  }),
            ]);
      },
    );
  }

  List<String> getCanSelectTimeList(DateTime time) {
    List<String> valueStrs = [
      '08:00-09:00',
      '09:00-10:00',
      '10:00-11:00',
      '11:00-12:00',
      '14:00-15:00',
      '15:00-16:00',
      '16:00-17:00',
      '17:00-18:00',
      '18:00-19:00',
      '19:00-20:00',
      '20:00-21:00',
    ];
    List<String> selectStrs = new List();
    DateTime today = DateTime.now();
    if (time.year < today.year ||
        (time.year == today.year && time.month < today.month) ||
        (time.year == today.year &&
            time.month == today.month &&
            time.day < today.day)) {
      return null;
    }

    if (time.year == today.year &&
        time.month == today.month&&time.day == today.day) {
      int house = today.hour;
      selectStrs.clear();
//      if (house < 5) {
//        selectStrs.addAll(valueStrs);
//      } else if (house >= 5 && house < 10) {
//        selectStrs.addAll(valueStrs.sublist((house - 4) - 1));
//      } else if (house == 10) {
//        selectStrs.addAll(valueStrs.sublist(4));
//      } else if (house == 11) {
//        selectStrs.addAll(valueStrs.sublist(4));
//      } else if (house >= 12 && house < 18) {
//        selectStrs.addAll(valueStrs.sublist(5 + (house - 12)));
//      } else
//        return null;
      for(int i =0;i<valueStrs.length;i++){
        String time = valueStrs[i].substring(0,2);
        int time1 = int.parse(time);
        if(time1>=house){
          selectStrs.addAll(valueStrs.sublist(i));
          break;
        }
      }

      return selectStrs;
    } else {
      return valueStrs;
    }
  }
//  Widget _buildList() {
//    return ScopedModelDescendant<MainStateModel>(
//        builder: (context, child, model) {
//      return Container(
//        color: Colors.white,
//        child: ListView.builder(
//          physics: NeverScrollableScrollPhysics(),
//          shrinkWrap: true,
//          itemCount: model.higtwordsList.length,
//          itemBuilder: (BuildContext context, int index) {
//            Data info = model.higtwordsList[index];
//            return GestureDetector(
//                onTap: () {
//                  setState(() {
//                    String text = controller.text;
//
//                    if (text.length + info.attachmentName.length >= 200)
//                      CommonToast.show("亲，超字数了!", context, duration: 2);
//                    else
//                      controller.text = text + info.attachmentName;
//                  });
//                },
//                child: Container(
//                  color: Colors.white,
//                  child: Column(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: <Widget>[
//                      Container(
//                        child: CommonText.grey16Text(info.attachmentName),
//                        padding: EdgeInsets.symmetric(
//                            vertical: UIData.spaceSize12,
//                            horizontal: UIData.spaceSize16),
//                      ),
//                      CommonDivider(),
//                    ],
//                  ),
//                ));
//          },
//        ),
//      );
//    });
//  }
}
