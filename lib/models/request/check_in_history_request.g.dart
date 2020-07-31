// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_in_history_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckInHistoryRequest _$CheckInHistoryRequestFromJson(
    Map<String, dynamic> json) {
  return CheckInHistoryRequest()
    ..pageSize = json['pageSize'] as int
    ..current = json['current'] as int
    ..endTime = json['endTime'] as String
    ..startTime = json['startTime'] as String
    ..status = (json['status'] as List)?.map((e) => e as String)?.toList()
    ..projectId = json['projectId'] as int;
}

Map<String, dynamic> _$CheckInHistoryRequestToJson(
        CheckInHistoryRequest instance) =>
    <String, dynamic>{
      'pageSize': instance.pageSize,
      'current': instance.current,
      'endTime': instance.endTime,
      'startTime': instance.startTime,
      'status': instance.status,
      'projectId': instance.projectId,
    };
