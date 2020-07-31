// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_record_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseRecordList _$BaseRecordListFromJson(Map<String, dynamic> json) {
  return BaseRecordList(
    (json['attJfpjList'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['attRzqrList'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['attRzqrhList'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['attZhrzList'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['attachmentFlag'] as String,
    json['createTime'] as String,
    json['creator'] as String,
    json['creatorId'] as int,
    json['creatorType'] as String,
    json['operateStep'] as String,
    json['postId'] as int,
    json['recordId'] as int,
    json['remark'] as String,
    json['rentingEnterId'] as int,
    json['status'] as String,
    json['userId'] as int,
  )
    ..operateStepDesc = json['operateStepDesc'] as String
    ..statusDesc = json['statusDesc'] as String;
}

Map<String, dynamic> _$BaseRecordListToJson(BaseRecordList instance) =>
    <String, dynamic>{
      'attJfpjList': instance.attJfpjList,
      'attRzqrList': instance.attRzqrList,
      'attRzqrhList': instance.attRzqrhList,
      'attZhrzList': instance.attZhrzList,
      'attachmentFlag': instance.attachmentFlag,
      'createTime': instance.createTime,
      'creator': instance.creator,
      'creatorId': instance.creatorId,
      'creatorType': instance.creatorType,
      'operateStep': instance.operateStep,
      'operateStepDesc': instance.operateStepDesc,
      'postId': instance.postId,
      'recordId': instance.recordId,
      'remark': instance.remark,
      'rentingEnterId': instance.rentingEnterId,
      'status': instance.status,
      'statusDesc': instance.statusDesc,
      'userId': instance.userId,
    };
