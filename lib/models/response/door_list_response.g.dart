// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'door_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoorListResponse _$DoorListResponseFromJson(Map<String, dynamic> json) {
  return DoorListResponse(
    (json['data'] as List)
        ?.map((e) =>
            e == null ? null : DoorInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )
    ..code = json['code'] as String
    ..message = json['message'] as String;
}

Map<String, dynamic> _$DoorListResponseToJson(DoorListResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.doorList,
    };

DoorInfo _$DoorInfoFromJson(Map<String, dynamic> json) {
  return DoorInfo(
    (json['mode'] as List)
        ?.map(
            (e) => e == null ? null : Mode.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['project_id'] as String,
    json['project_name'] as String,
    json['user_type'] as String,
  );
}

Map<String, dynamic> _$DoorInfoToJson(DoorInfo instance) => <String, dynamic>{
      'mode': instance.mode,
      'project_id': instance.projectId,
      'project_name': instance.projectName,
      'user_type': instance.userType,
    };

Mode _$ModeFromJson(Map<String, dynamic> json) {
  return Mode(
    (json['device_list'] as List)
        ?.map((e) =>
            e == null ? null : DeviceInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['mode_name'] as String,
    json['mode_type'] as String,
  );
}

Map<String, dynamic> _$ModeToJson(Mode instance) => <String, dynamic>{
      'device_list': instance.deviceList,
      'mode_name': instance.modeName,
      'mode_type': instance.modeType,
    };

DeviceInfo _$DeviceInfoFromJson(Map<String, dynamic> json) {
  return DeviceInfo(
    json['projectId'] as int,
    json['lockid'] as String,
    json['device_code'] as String,
    json['device_name'] as String,
    json['mode_type'] as String,
    json['project_name'] as String,
    json['device_checked'] as bool,
    json['device_factory'] as String,
    json['hexkey'] as String,
  );
}

Map<String, dynamic> _$DeviceInfoToJson(DeviceInfo instance) =>
    <String, dynamic>{
      'projectId': instance.projectId,
      'lockid': instance.lockid,
      'device_code': instance.deviceCode,
      'device_name': instance.deviceName,
      'mode_type': instance.modeType,
      'project_name': instance.projectName,
      'device_checked': instance.checked,
      'device_factory': instance.deviceFactory,
      'hexkey': instance.hexKey,
    };

UsedDoor _$UsedDoorFromJson(Map<String, dynamic> json) {
  return UsedDoor(
    (json['data'] as List)
        ?.map((e) =>
            e == null ? null : DeviceInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$UsedDoorToJson(UsedDoor instance) => <String, dynamic>{
      'data': instance.usedList,
    };
