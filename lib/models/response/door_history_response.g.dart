// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'door_history_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoorHistoryResponse _$DoorHistoryResponseFromJson(Map<String, dynamic> json) {
  return DoorHistoryResponse(
    (json['data'] as List)
        ?.map((e) =>
            e == null ? null : DoorList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )
    ..code = json['code'] as String
    ..message = json['message'] as String;
}

Map<String, dynamic> _$DoorHistoryResponseToJson(
        DoorHistoryResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.doorList,
    };

DoorList _$DoorListFromJson(Map<String, dynamic> json) {
  return DoorList(
    json['id'] as int,
    json['name'] as String,
    json['mobile'] as String,
    json['userType'] as String,
    json['projectId'] as int,
    json['projectName'] as String,
    json['gateName'] as String,
    json['result'] as String,
    json['createTime'] as String,
  )..projectLocalName = json['projectLocalName'] as String;
}

Map<String, dynamic> _$DoorListToJson(DoorList instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'mobile': instance.mobile,
      'userType': instance.userType,
      'projectId': instance.projectId,
      'projectName': instance.projectName,
      'projectLocalName': instance.projectLocalName,
      'gateName': instance.gateName,
      'result': instance.result,
      'createTime': instance.createTime,
    };
