// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invitation_record_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvitationRecordResponse _$InvitationRecordResponseFromJson(
    Map<String, dynamic> json) {
  return InvitationRecordResponse()
    ..code = json['code'] as String
    ..message = json['message'] as String
    ..data = (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : InvitationRecord.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$InvitationRecordResponseToJson(
        InvitationRecordResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

InvitationRecord _$InvitationRecordFromJson(Map<String, dynamic> json) {
  return InvitationRecord(
    json['createTime'] as String,
    json['custId'] as int,
    json['id'] as int,
    json['phone'] as String,
    json['rewardTime'] as String,
    json['status'] as String,
    json['statusName'] as String,
    json['toNickname'] as String,
    json['updateTime'] as String,
    json['updateDate'] as String,
  );
}

Map<String, dynamic> _$InvitationRecordToJson(InvitationRecord instance) =>
    <String, dynamic>{
      'createTime': instance.createTime,
      'custId': instance.custId,
      'id': instance.id,
      'phone': instance.phone,
      'rewardTime': instance.rewardTime,
      'status': instance.status,
      'statusName': instance.statusName,
      'toNickname': instance.toNickname,
      'updateTime': instance.updateTime,
      'updateDate': instance.updateDate,
    };
