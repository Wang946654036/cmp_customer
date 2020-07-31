import 'dart:convert';
import 'package:cmp_customer/models/meetingroom/meeting_room_info_obj.dart';
import 'package:cmp_customer/scoped_models/reservation_state_model.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_image_display.dart';
import 'package:cmp_customer/ui/common/common_list_loading.dart';
import 'package:cmp_customer/ui/common/common_list_refresh.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_text_field.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/conference_room_reservation/room_information_ui.dart';
import 'package:cmp_customer/ui/conference_room_reservation/write_page.dart';
import 'package:cmp_customer/ui/decorate_manager/decoration_ui.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../main.dart';
import 'can_check_edit_list.dart';

///保存预定信息

class ReservationSavePage extends StatefulWidget {
  ReservationModel _model;
  int position;
  MeetingRoomInfo info;
  String orderDate;

  ReservationSavePage(this._model, this.info,
      {this.orderDate, this.position = -1});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ReservationSavePageState();
  }
}

class _ReservationSavePageState extends State<ReservationSavePage> {
  MeetingRoomInfo info;
  List<MeetingRoomInfo> expandStateList =
      new List(); //开展开的状态列表,ExpandStateBean是自定义的类
  List<Device> deviceList = new List();
  List<Service> serviceList = new List();
  List<Time> timeList = new List();
  int position;
  String times;

  String servise;

  String devices;

  TextEditingController peopleNumController = new TextEditingController(); //人数
  TextEditingController deviceController = new TextEditingController(); //设备
  TextEditingController serviceController = new TextEditingController(); //服务

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    position = widget.position;
    if (position == -1) {
      position = widget._model.saveInfoList?.length ?? 0;
    }
    if (widget.info != null) {
      info = MeetingRoomInfo.fromJson(
          jsonDecode(jsonEncode(widget.info.toJson())));
      if (info.deviceList != null && info.deviceList.length > 0) {
        deviceList.addAll(info.deviceList);
        devices = getStringFromDataList(2);
      }
      if (info.meetingSubOrderTimeVoList != null && info.meetingSubOrderTimeVoList.length > 0) {
        timeList.addAll(info.meetingSubOrderTimeVoList);
        times = getStringFromDataList(1);
      }else if(info.selectTimeList != null && info.selectTimeList.length > 0){
        timeList.addAll(info.selectTimeList);
        times = getStringFromDataList(1);
      }
      if (info.serviceList != null && info.serviceList.length > 0) {
        serviceList.addAll(info.serviceList);
        servise = getStringFromDataList(3);
      }
      peopleNumController.text = info.peopleNum?.toString() ?? '';
      deviceController.text = info.deviceOther ?? '';
      serviceController.text = info.serviceOther ?? '';
    } else {
      info = new MeetingRoomInfo();
    }
    if (info.orderDate == null) {
      if (widget.orderDate != null) {
        info.orderDate = widget.orderDate;
      } else
        info.orderDate = StringsHelper.formatterYMD.format(DateTime.now()); //今天
    }
    peopleNumController.addListener((){
      if (StringsHelper.isNotEmpty(peopleNumController.text)){
        info.peopleNum = int.parse(peopleNumController.text);
        if(info.peopleNum>info.capacity){
          CommonToast.show(type: ToastIconType.INFO, msg: '超出可允许的使用人数');
        }
      }
    });
    deviceController.addListener((){
      info.deviceOther = deviceController.text;
    });
    serviceController.addListener((){
      info.serviceOther = serviceController.text;
    });
    refresh();
  }
reflushData(MeetingRoomInfo initInfo){
  if (initInfo != null) {
    if (initInfo.deviceList != null && initInfo.deviceList.length > 0) {
      initInfo.deviceList.forEach((Device device){
        for(int i =0;i<deviceList.length;i++){
          if(device.code==deviceList[i].code){
            device.point = deviceList[i].point;
          }
        }
      });
      deviceList.clear();
      deviceList.addAll(initInfo.deviceList);
      devices = getStringFromDataList(2);
    }
    if(info.timeList!=null&& info.timeList.length > 0){//若有值则表示从详情进来的
      initInfo.selectTimeList = new List();
      initInfo.selectTimeList.addAll(info.timeList);
    }
    if (initInfo.selectTimeList != null && initInfo.selectTimeList.length > 0) {
      initInfo.selectTimeList.forEach((Time time){
        for(int i =0;i<timeList.length;i++){
          if(time.beginTime==timeList[i].beginTime){
            time.selected = timeList[i].selected ?? false;
          }
        }
      });
      timeList.clear();
      timeList.addAll(initInfo.selectTimeList);

      times = getStringFromDataList(1);
    }
    if (initInfo.serviceList != null && initInfo.serviceList.length > 0) {
      initInfo.serviceList.forEach((Service service){
        for(int i =0;i<serviceList.length;i++){
          if(service.code==serviceList[i].code){
            service.point = serviceList[i].point;
          }
        }
      });
      serviceList.clear();
      serviceList.addAll(initInfo.serviceList);
      servise = getStringFromDataList(3);
    }
//    peopleNumController.text = info.peopleNum?.toString() ?? '';
//    deviceController.text = info.deviceOther ?? '';
//    serviceController.text = info.serviceOther ?? '';
  } else {
    info = new MeetingRoomInfo();
  }
}
  Widget _buildContent() {
    return ScopedModelDescendant<ReservationModel>(
      builder: (context, child, model) {
        //弱耦合，获取失败依然给他编辑和保存
        switch (widget._model.meetinInfoListState) {
          case ListState.HINT_LOADING:
            return CommonListLoading();
            break;
          case ListState.HINT_NO_DATA_CLICK:
//            return CommonListRefresh(
//                state: ListState.HINT_NO_DATA_CLICK, callBack: _refresh);
//            break;
          case ListState.HINT_LOADED_FAILED_CLICK:
//            return CommonListRefresh(
//                state: ListState.HINT_LOADED_FAILED_CLICK, callBack: _refresh);
//            break;
          case ListState.HINT_DISMISS:
            return _buildList();
            break;
          default:
            return CommonListLoading();
            break;
        }
      },
    );
  }

  //刷新操作
  _refresh() {
    widget._model.canBookHandleRefresh(
        {'orderDate': info.orderDate, 'roomId': info.roomId}, expandStateList,
        preRefresh: true);
  }

  Future refresh() async {
    widget._model.canBookHandleRefresh(
        {'orderDate': info.orderDate, 'roomId': info.roomId}, expandStateList);
  }

  _buildList() {
    //刷新数据
    if (expandStateList != null && expandStateList.length > 0)
      reflushData(expandStateList[0]);
    return CommonScaffold(
      appTitle: '会议室预定',
      appBarActions: [
        FlatButton(
          child: CommonText.red15Text('费用说明'),
          onPressed: () {
            Navigate.toNewPage(
                WritingPage("会议室费用说明", widget._model.getPriceContent(expandStateList[0])));
          },
        )
      ],
      bodyData: SingleChildScrollView(
        child: Container(
          color: UIData.primaryColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CommonSelectSingleRow(
                '会议室${position + 1}',
                content: info.roomName ?? '',
                arrowVisible: false,
              ),
              CommonDivider(),
              CommonSelectSingleRow(
                '可容纳人数',
                content: "${info.capacity ?? ''}",
                arrowVisible: false,
              ),
              CommonDivider(),
              Visibility(
                visible:
                    info.roomPhotoList != null && info.roomPhotoList.length > 0,
                child: leftTextWidget(
                  text: '会议室图片',
                  topSpacing: UIData.spaceSize12,
                ),
              ),
              Visibility(
                visible:
                    info.roomPhotoList != null && info.roomPhotoList.length > 0,
                child: Container(
                  margin: EdgeInsets.all(UIData.spaceSize16),
                  child: CommonImageDisplay(
                      photoIdList: getFileList(info.roomPhotoList)),
                ),
              ),
              Visibility(
                visible:
                    info.roomPhotoList != null && info.roomPhotoList.length > 0,
                child: CommonDivider(),
              ),
              Visibility(
                visible: StringsHelper.isNotEmpty(info?.chargePhone),
                child: Container(
                  color: UIData.primaryColor,
                  margin: EdgeInsets.only(top: UIData.spaceSize12),
                  padding: EdgeInsets.symmetric(vertical: UIData.spaceSize12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: labelTextWidget(
                          label: '联系电话',
                          text: info?.chargePhone ?? '暂无',
                          icon: Icons.phone,
                          needArrow: false,
                          onIconClick: () {
                            if (StringsHelper.isNotEmpty(info?.chargePhone)) {
                              stateModel.callPhone(info?.chargePhone);
                            }
                          },
                          topSpacing: UIData.spaceSize12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: StringsHelper.isNotEmpty(info?.chargePhone),
                child: CommonDivider(),
              ),
              CommonSelectSingleRow(
                '预约日期',
                content: info.orderDate,
                arrowVisible: false,
              ),
              CommonDivider(),
              CommonSelectSingleRow(
                '预约时间',
                content: times,
                hintText: '请选择（必选）',
                onTap: () {
                  Navigate.toNewPage(
                      CanCheckAndEditList(
                        getCanCheckAndEditableObjListFromDates(1),
                        '可预约时间段',
                      ), callBack: (dataList) {
                    if (dataList != null &&
                        dataList is List<CanCheckAndEditableObj>) {
                      setState(() {
                        times =
                            getStringFromCanCheckAndEditableObjList(dataList);
                        timeList.clear();
                        dataList.forEach((CanCheckAndEditableObj obj) {
                          Time time = new Time();
                          List<String> strs = obj.name.split("-");
//                          try {
//                            time.timeSettingId = int.parse(obj.key);
//                          } catch (e) {
//                            LogUtils.printLog(
//                                "time.subOrderId = int.parse(obj.key:${obj.key})出错了");
//                          }
                          if (strs.length > 1) {
                            time.beginTime = strs[0];
                            time.endTime = strs[1];
                          }
                          time.price = obj.price;
                          time.selected = obj.checked;
                          timeList.add(time);
                        });
                      });
                    }
                  });
                },
                arrowVisible: true,
              ),
              CommonDivider(),
              CommonSelectSingleRow(
                '使用人数',
                content: CommonTextField(
                    controller: peopleNumController,
                    keyboardType: TextInputType.number,
                    limitLength: 3,
                    hintText: '请输入（必填）',
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter(RegExp("[0-9]")),
                    ]),
                arrowVisible: false,
              ),
              CommonDivider(),
              CommonSelectSingleRow(
                '常用设备',
                content: devices,
                hintText: '请选择',
                onTap: () {
                  Navigate.toNewPage(
                      CanCheckAndEditList(
                        getCanCheckAndEditableObjListFromDates(2),
                        '常用设备',
                      ), callBack: (dataList) {
                    if (dataList != null &&
                        dataList is List<CanCheckAndEditableObj>) {
                      setState(() {
                        LogUtils.printLog("$dataList");
                        deviceList.clear();
                        dataList.forEach((CanCheckAndEditableObj obj) {
                          Device device = new Device();
                          device.code = obj.key;
                          device.name = obj.name;
                          device.price = obj.price?.floor()?.toInt()??null;
                          device.measure = obj.utit;
                          try {
                            device.point = int.parse(obj.editContent);
                          } catch (e) {
                            LogUtils.printLog(
                                "device.point = int.parse(obj.editContent:${obj.editContent})出错了");
                            device.point=null;
                          }
                          if (device.point == null && obj.checked) {
                            device.point = 1;
                          }
                          deviceList.add(device);
                          devices =
                              getStringFromCanCheckAndEditableObjList(dataList);
                        });
                      });
                    }
                  });
                },
                arrowVisible: true,
              ),
              CommonDivider(),
              CommonSelectSingleRow(
                '其他设备',
                crossAxisAlignment: CrossAxisAlignment.start,
                content: CommonTextField(
                  controller: deviceController,
                  keyboardType: TextInputType.text,
                  limitLength: 500,
                  hintText: '请输入',
                  maxLength: 500,
                ),
                arrowVisible: false,
              ),
              CommonDivider(),
              CommonSelectSingleRow(
                '常用服务',
                content: servise,
                hintText: '请选择',
                onTap: () {
                  Navigate.toNewPage(
                      CanCheckAndEditList(
                        getCanCheckAndEditableObjListFromDates(3),
                        '常用服务',
                      ), callBack: (dataList) {
                    if (dataList != null &&
                        dataList is List<CanCheckAndEditableObj>) {
                      setState(() {

                        servise =
                            getStringFromCanCheckAndEditableObjList(dataList);
                        serviceList.clear();
                        dataList.forEach((CanCheckAndEditableObj obj) {
                          Service service = new Service();
                          service.code = obj.key;
                          service.name = obj.name;
                          service.price = obj.price?.toInt()??null;
                          service.measure = obj.utit;
                          try {
                            service.point = int.parse(obj.editContent);
                          } catch (e) {
                            LogUtils.printLog(
                                "service.point = int.parse(obj.editContent:${obj.editContent})出错了");
                            service.point=null;
                          }
                          if (service.point == null && obj.checked) {
                            service.point = 1;
                          }
                          serviceList.add(service);
                        });
                      });
                    }
                  });
                },
                arrowVisible: true,
              ),
              CommonDivider(),
              CommonSelectSingleRow(
                '其他服务',
                crossAxisAlignment: CrossAxisAlignment.start,
                content: CommonTextField(
                  controller: serviceController,
                  keyboardType: TextInputType.text,
                  limitLength: 500,
                  maxLength: 500,
                  hintText: '请输入',
                ),
                arrowVisible: false,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: StadiumSolidButton('保存', onTap: () {
        save();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModel<ReservationModel>(
        model: widget._model,
        child: ScopedModelDescendant<ReservationModel>(
            builder: (context, child, model) {
          return _buildContent();
        }));
  }

  List<CanCheckAndEditableObj> getCanCheckAndEditableObjListFromDates(
      int type) {
    //1times  2device 3service

    List<CanCheckAndEditableObj> objs = new List();
    switch (type) {
      case 1:
        for (int i = 0; i < timeList.length; i++) {
          Time time = timeList[i];
          CanCheckAndEditableObj obj = new CanCheckAndEditableObj();
          obj.editable = false;
//          obj.key = time.timeSettingId?.toString() ?? '$i';
          obj.type = CanCheckAndEditableEmun.str;
          obj.name = "${time.beginTime}-${time.endTime}";
          LogUtils.printLog('editContent:${obj.editContent}');
          obj.checked = time.selected ?? false;
          obj.price = time.price??null;
          objs.add(obj);
        }

        break;
      case 2:
        deviceList.forEach((Device device) {
          CanCheckAndEditableObj obj = new CanCheckAndEditableObj();
          obj.editable = true;

          if (device.name == '音乐' || device.name == '电脑演示')
            obj.editable = false;
          obj.key = device.code;
          obj.contentLength = 3;
          obj.type = CanCheckAndEditableEmun.numb0_9;
          obj.utit = device.measure ?? '';
          obj.name = device.name ?? '';
          obj.editContent = device.point?.toString() ?? '';
          obj.price = device.price?.toDouble()??null;
          obj.checked = false;
          if (device.point != null && device.point > 0) obj.checked = true;
          objs.add(obj);
        });
        break;
      case 3:
        serviceList.forEach((Service service) {
          CanCheckAndEditableObj obj = new CanCheckAndEditableObj();
          obj.editable = true;
          if (service.name == '加时使用空调')
            obj.editable = false;
          obj.key = service.code;
          obj.contentLength = 3;
          obj.type = CanCheckAndEditableEmun.numb0_9;
          obj.utit = service.measure ?? '';
          obj.name = service.name ?? '';
          obj.price = service.price?.toDouble()??null;
          obj.editContent = service.point?.toString() ?? '';
          obj.checked = false;
          if (service.point != null && service.point > 0) obj.checked = true;
          objs.add(obj);
        });
        break;
    }

    return objs;
  }

  String getStringFromDataList(int type) {
    //1times  2device 3service
    String data = '';
    switch (type) {
      case 1:
        timeList.forEach((Time obj) {
          if (obj.selected ?? false) {
            data = '$data${obj.beginTime}-${obj.endTime},';
          }
        });
        break;
      case 2:
        deviceList.forEach((Device obj) {
          if (obj.point != null && obj.point > 0) {
            if (obj.name == '音乐' || obj.name == '电脑演示') {
              data = '$data${obj.name},';
            }
            else
              data = '$data${obj.name}${obj.point}${obj.measure},';
          }
        });
        break;
      case 3:
        serviceList.forEach((Service obj) {
         if (obj.point != null && obj.point > 0) {
           if (obj.name == '加时使用空调') {
             data = '$data${obj.name},';
           }
           else
             data = '$data${obj.name}${obj.point}${obj.measure},';
         }
        });
        break;
    }
    return data;
  }

  String getStringFromCanCheckAndEditableObjList(
      List<CanCheckAndEditableObj> equipments) {
//    List<String> equipments = [
//      '多功能话筒',
//      '录像机',
//      'DVD',
//      '展台',
//      '投影仪',
//      '音乐',
//      '电脑演示',
//    ];
//    List<CanCheckAndEditableObj> objs = new List();
    String equipmentStr = '';
    equipments.forEach((CanCheckAndEditableObj obj) {
      if (obj.checked) {
        if(obj.name=='音乐' || obj.name == '电脑演示'||obj.name=='加时使用空调')
          equipmentStr = '$equipmentStr${obj.name},';
        else
        equipmentStr = '$equipmentStr${obj.name}${StringsHelper.isEmpty(obj.editContent)?'':obj.editContent}${StringsHelper.isEmpty(obj.editContent)?'':(obj.utit??'')},';
      }
    });
    if (equipmentStr.endsWith(',')) {
      equipmentStr.substring(0, equipmentStr.length - 1);
    }
    return equipmentStr;
  }

  void save() {
    info.deviceOther = deviceController.text;
    info.serviceOther = serviceController.text;
    if (info.serviceList != null)
      info.serviceList.clear();
    else
      info.serviceList = new List();
    serviceList.forEach((Service s){
      if(s.point!=null&&s.point>0){
        info.serviceList.add(s);
        LogUtils.printLog('s:${s.name}${s.point}');
      }
    });

    if (info.deviceList != null)
      info.deviceList.clear();
    else
      info.deviceList = new List();
    deviceList.forEach((Device s){
      if(s.point!=null&&s.point>0){
        info.deviceList.add(s);
        LogUtils.printLog('d:${s.name}${s.point}');
      }
    });

    if (timeList == null || timeList.length == 0) {
      CommonToast.show(type: ToastIconType.INFO, msg: '请选择预约时间');
      return;
    }
    if (info.meetingSubOrderTimeVoList != null)
      info.meetingSubOrderTimeVoList.clear();
    else
      info.meetingSubOrderTimeVoList = new List();
    timeList.forEach((Time time) {
      if (time.selected ?? false) {
        info.meetingSubOrderTimeVoList.add(time);
      }
    });
    if (info.meetingSubOrderTimeVoList.length == 0) {
      CommonToast.show(type: ToastIconType.INFO, msg: '请选择预约时间');
      return;
    }

    if (StringsHelper.isNotEmpty(peopleNumController.text)){
      info.peopleNum = int.parse(peopleNumController.text);
      if(info.peopleNum>info.capacity){
        CommonToast.show(type: ToastIconType.INFO, msg: '超出可允许的使用人数');
        return;
      }
    }else {
      CommonToast.show(type: ToastIconType.INFO, msg: '请输入使用人数');
      return;
    }

    bool needAdd = true;
    if (widget._model.saveInfoList == null) {
      widget._model.saveInfoList = new List();
    } else {
      for (int i = 0; i < widget._model.saveInfoList.length; i++) {
        if (widget._model.saveInfoList[i].roomId == info.roomId &&
            widget._model.saveInfoList[i].orderDate == info.orderDate) {
          widget._model.saveInfoList[i] = info;
          needAdd = false;
          LogUtils.printLog(
              ' widget._model.saveInfoList[i]${widget._model.saveInfoList[i]}');
        }
      }
    }
    if (needAdd) {
      widget._model.saveInfoList.add(info);
    }

    LogUtils.printLog(
        'widget._model.saveInfoList.length${widget._model.saveInfoList.length}');
    widget._model.notifyListeners();
    Navigate.closePage(widget._model.result_ok);
  }
}
