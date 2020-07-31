import 'package:cmp_customer/models/user_data_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meeting_room_info_obj.g.dart';


@JsonSerializable()
class MeetingRoomInfoObj extends Object {

  @JsonKey(name: 'appCodes')
  List<String> appCodes;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'data')
  MeetingRoomInfo data;

  @JsonKey(name: 'extStr')
  String extStr;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'totalCount')
  int totalCount;

  MeetingRoomInfoObj({this.appCodes,this.code,this.data,this.extStr,this.message,this.systemDate,this.totalCount,});

  factory MeetingRoomInfoObj.fromJson(Map<String, dynamic> srcJson) => _$MeetingRoomInfoObjFromJson(srcJson);

}


@JsonSerializable()
class MeetingRoomInfo extends Object{

  @JsonKey(name: 'deviceOther')
  String deviceOther;

  @JsonKey(name: 'deviceSelectJson')
  String deviceSelectJson;

  @JsonKey(name: 'orderDate')
  String orderDate;

  @JsonKey(name: 'orderId')
  int orderId;

  @JsonKey(name: 'peopleNum')
  int peopleNum;

  @JsonKey(name: 'roomId')
  int roomId;

  @JsonKey(name: 'serviceOther')
  String serviceOther;

  @JsonKey(name: 'serviceSelectJson')
  String serviceSelectJson;

  @JsonKey(name: 'subOrderId')
  int subOrderId;


  @JsonKey(name: 'address')
  String address;

  @JsonKey(name: 'capacity')
  int capacity;

  @JsonKey(name: 'chargeName')
  String chargeName;

  @JsonKey(name: 'chargePhone')
  String chargePhone;

  @JsonKey(name: 'createTime')
  String createTime;

  @JsonKey(name: 'creatorId')
  int creatorId;

  @JsonKey(name: 'deviceList')
  List<Device> deviceList;

  @JsonKey(name: 'deviceSelectList')
  List<Device> deviceSelectList;

  @JsonKey(name: 'orgId')
  int orgId;

  @JsonKey(name: 'projectId')
  int projectId;

  @JsonKey(name: 'remark')
  String remark;


  @JsonKey(name: 'roomName')
  String roomName;

  @JsonKey(name: 'roomPhotoList')
  List<Attachment> roomPhotoList;

  @JsonKey(name: 'serviceList')
  List<Service> serviceList;
  @JsonKey(name: 'serviceSelectList')
  List<Service> serviceSelectList;
  @JsonKey(name: 'state')
  int state;

  @JsonKey(name: 'updateTime')
  String updateTime;

  @JsonKey(name: 'updaterId')
  int updaterId;

  @JsonKey(name: 'waitHour')
  int waitHour;

  @JsonKey(name: 'weekendTimeList')
  List<Time> weekendTimeList;

  @JsonKey(name: 'meetingSubOrderTimeVoList')
  List<Time> meetingSubOrderTimeVoList;

  @JsonKey(name: 'selectTimeList')
  List<Time> selectTimeList;
  @JsonKey(name: 'timeList')
  List<Time> timeList;
  @JsonKey(name: 'workDay')
  String workDay;

  @JsonKey(name: 'workDayTimeList')
  List<Time> workDayTimeList;


  MeetingRoomInfo({this.deviceOther, this.deviceSelectJson, this.orderDate,
      this.orderId, this.peopleNum, this.roomId, this.serviceOther,
      this.serviceSelectJson, this.subOrderId, this.address, this.capacity,
      this.chargeName, this.chargePhone, this.createTime, this.creatorId,
      this.deviceList,this.deviceSelectList, this.orgId, this.projectId, this.remark, this.roomName,
      this.roomPhotoList, this.serviceList,this.serviceSelectList, this.state, this.updateTime,
      this.updaterId, this.waitHour, this.weekendTimeList,
      this.meetingSubOrderTimeVoList, this.workDay, this.workDayTimeList,this.selectTimeList,this.timeList});

  factory MeetingRoomInfo.fromJson(Map<String, dynamic> srcJson) => _$MeetingRoomInfoFromJson(srcJson);
  Map<String, dynamic> toJson() => _$MeetingRoomInfoToJson(this);
}


@JsonSerializable()
class Device extends Object {

  @JsonKey(name: 'measure')
  String measure;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'point')
  int point;
  @JsonKey(name: 'price')
  int price;
  @JsonKey(name: 'code')
  String code;

  Device({this.measure,this.name,this.point,this.price,this.code});

  factory Device.fromJson(Map<String, dynamic> srcJson) => _$DeviceFromJson(srcJson);
  Map<String, dynamic> toJson() => _$DeviceToJson(this);
}


@JsonSerializable()
class Service extends Object {

  @JsonKey(name: 'measure')
  String measure;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'point')
  int point;

  @JsonKey(name: 'price')
  int price;
  @JsonKey(name: 'code')
  String code;
  Service({this.measure,this.name,this.point,this.price,this.code});

  factory Service.fromJson(Map<String, dynamic> srcJson) => _$ServiceFromJson(srcJson);
  Map<String, dynamic> toJson() => _$ServiceToJson(this);
}


@JsonSerializable()
class Time extends Object {

  @JsonKey(name: 'beginTime')
  String beginTime;

  @JsonKey(name: 'endTime')
  String endTime;

  @JsonKey(name: 'price')
  double price;

  @JsonKey(name: 'roomId')
  int roomId;

  @JsonKey(name: 'timeSettingId')
  int timeSettingId;

  @JsonKey(name: 'subOrderId')
  int subOrderId;

  @JsonKey(name: 'timeId')
  int timeId;

  @JsonKey(name:'selected')
  bool selected = false;
  Time({this.beginTime,this.endTime,this.price,this.roomId,this.subOrderId,this.timeSettingId,this.selected});

  factory Time.fromJson(Map<String, dynamic> srcJson) => _$TimeFromJson(srcJson);
  Map<String, dynamic> toJson() => _$TimeToJson(this);
}




  
