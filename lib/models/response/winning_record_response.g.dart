// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'winning_record_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WinningRecordResponse _$WinningRecordResponseFromJson(
    Map<String, dynamic> json) {
  return WinningRecordResponse(
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : WinningRecord.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )
    ..code = json['code'] as String
    ..message = json['message'] as String;
}

Map<String, dynamic> _$WinningRecordResponseToJson(
        WinningRecordResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

WinningRecord _$WinningRecordFromJson(Map<String, dynamic> json) {
  return WinningRecord(
    json['activityId'] as int,
    json['activityName'] as String,
    json['houseId'] as int,
    json['houseName'] as String,
    json['orgId'] as int,
    json['prizeName'] as String,
    json['projectId'] as int,
    json['projectName'] as String,
    json['sendStatus'] as String,
    json['userId'] as int,
    json['winningManagementId'] as int,
    json['winningTime'] as String,
  );
}

Map<String, dynamic> _$WinningRecordToJson(WinningRecord instance) =>
    <String, dynamic>{
      'activityId': instance.activityId,
      'activityName': instance.activityName,
      'houseId': instance.houseId,
      'houseName': instance.houseName,
      'orgId': instance.orgId,
      'prizeName': instance.prizeName,
      'projectId': instance.projectId,
      'projectName': instance.projectName,
      'sendStatus': instance.sendStatus,
      'userId': instance.userId,
      'winningManagementId': instance.winningManagementId,
      'winningTime': instance.winningTime,
    };
