// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting_room_info_obj.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeetingRoomInfoObj _$MeetingRoomInfoObjFromJson(Map<String, dynamic> json) {
  return MeetingRoomInfoObj(
    appCodes: (json['appCodes'] as List)?.map((e) => e as String)?.toList(),
    code: json['code'] as String,
    data: json['data'] == null
        ? null
        : MeetingRoomInfo.fromJson(json['data'] as Map<String, dynamic>),
    extStr: json['extStr'] as String,
    message: json['message'] as String,
    systemDate: json['systemDate'] as String,
    totalCount: json['totalCount'] as int,
  );
}

Map<String, dynamic> _$MeetingRoomInfoObjToJson(MeetingRoomInfoObj instance) =>
    <String, dynamic>{
      'appCodes': instance.appCodes,
      'code': instance.code,
      'data': instance.data,
      'extStr': instance.extStr,
      'message': instance.message,
      'systemDate': instance.systemDate,
      'totalCount': instance.totalCount,
    };

MeetingRoomInfo _$MeetingRoomInfoFromJson(Map<String, dynamic> json) {
  return MeetingRoomInfo(
    deviceOther: json['deviceOther'] as String,
    deviceSelectJson: json['deviceSelectJson'] as String,
    orderDate: json['orderDate'] as String,
    orderId: json['orderId'] as int,
    peopleNum: json['peopleNum'] as int,
    roomId: json['roomId'] as int,
    serviceOther: json['serviceOther'] as String,
    serviceSelectJson: json['serviceSelectJson'] as String,
    subOrderId: json['subOrderId'] as int,
    address: json['address'] as String,
    capacity: json['capacity'] as int,
    chargeName: json['chargeName'] as String,
    chargePhone: json['chargePhone'] as String,
    createTime: json['createTime'] as String,
    creatorId: json['creatorId'] as int,
    deviceList: (json['deviceList'] as List)
        ?.map((e) =>
            e == null ? null : Device.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    deviceSelectList: (json['deviceSelectList'] as List)
        ?.map((e) =>
            e == null ? null : Device.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    orgId: json['orgId'] as int,
    projectId: json['projectId'] as int,
    remark: json['remark'] as String,
    roomName: json['roomName'] as String,
    roomPhotoList: (json['roomPhotoList'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    serviceList: (json['serviceList'] as List)
        ?.map((e) =>
            e == null ? null : Service.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    serviceSelectList: (json['serviceSelectList'] as List)
        ?.map((e) =>
            e == null ? null : Service.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    state: json['state'] as int,
    updateTime: json['updateTime'] as String,
    updaterId: json['updaterId'] as int,
    waitHour: json['waitHour'] as int,
    weekendTimeList: (json['weekendTimeList'] as List)
        ?.map(
            (e) => e == null ? null : Time.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    meetingSubOrderTimeVoList: (json['meetingSubOrderTimeVoList'] as List)
        ?.map(
            (e) => e == null ? null : Time.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    workDay: json['workDay'] as String,
    workDayTimeList: (json['workDayTimeList'] as List)
        ?.map(
            (e) => e == null ? null : Time.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    selectTimeList: (json['selectTimeList'] as List)
        ?.map(
            (e) => e == null ? null : Time.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    timeList: (json['timeList'] as List)
        ?.map(
            (e) => e == null ? null : Time.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MeetingRoomInfoToJson(MeetingRoomInfo instance) =>
    <String, dynamic>{
      'deviceOther': instance.deviceOther,
      'deviceSelectJson': instance.deviceSelectJson,
      'orderDate': instance.orderDate,
      'orderId': instance.orderId,
      'peopleNum': instance.peopleNum,
      'roomId': instance.roomId,
      'serviceOther': instance.serviceOther,
      'serviceSelectJson': instance.serviceSelectJson,
      'subOrderId': instance.subOrderId,
      'address': instance.address,
      'capacity': instance.capacity,
      'chargeName': instance.chargeName,
      'chargePhone': instance.chargePhone,
      'createTime': instance.createTime,
      'creatorId': instance.creatorId,
      'deviceList': instance.deviceList,
      'deviceSelectList': instance.deviceSelectList,
      'orgId': instance.orgId,
      'projectId': instance.projectId,
      'remark': instance.remark,
      'roomName': instance.roomName,
      'roomPhotoList': instance.roomPhotoList,
      'serviceList': instance.serviceList,
      'serviceSelectList': instance.serviceSelectList,
      'state': instance.state,
      'updateTime': instance.updateTime,
      'updaterId': instance.updaterId,
      'waitHour': instance.waitHour,
      'weekendTimeList': instance.weekendTimeList,
      'meetingSubOrderTimeVoList': instance.meetingSubOrderTimeVoList,
      'selectTimeList': instance.selectTimeList,
      'timeList': instance.timeList,
      'workDay': instance.workDay,
      'workDayTimeList': instance.workDayTimeList,
    };

Device _$DeviceFromJson(Map<String, dynamic> json) {
  return Device(
    measure: json['measure'] as String,
    name: json['name'] as String,
    point: json['point'] as int,
    price: json['price'] as int,
    code: json['code'] as String,
  );
}

Map<String, dynamic> _$DeviceToJson(Device instance) => <String, dynamic>{
      'measure': instance.measure,
      'name': instance.name,
      'point': instance.point,
      'price': instance.price,
      'code': instance.code,
    };

Service _$ServiceFromJson(Map<String, dynamic> json) {
  return Service(
    measure: json['measure'] as String,
    name: json['name'] as String,
    point: json['point'] as int,
    price: json['price'] as int,
    code: json['code'] as String,
  );
}

Map<String, dynamic> _$ServiceToJson(Service instance) => <String, dynamic>{
      'measure': instance.measure,
      'name': instance.name,
      'point': instance.point,
      'price': instance.price,
      'code': instance.code,
    };

Time _$TimeFromJson(Map<String, dynamic> json) {
  return Time(
    beginTime: json['beginTime'] as String,
    endTime: json['endTime'] as String,
    price: (json['price'] as num)?.toDouble(),
    roomId: json['roomId'] as int,
    subOrderId: json['subOrderId'] as int,
    timeSettingId: json['timeSettingId'] as int,
    selected: json['selected'] as bool,
  )..timeId = json['timeId'] as int;
}

Map<String, dynamic> _$TimeToJson(Time instance) => <String, dynamic>{
      'beginTime': instance.beginTime,
      'endTime': instance.endTime,
      'price': instance.price,
      'roomId': instance.roomId,
      'timeSettingId': instance.timeSettingId,
      'subOrderId': instance.subOrderId,
      'timeId': instance.timeId,
      'selected': instance.selected,
    };
