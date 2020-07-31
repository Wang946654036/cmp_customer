// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_with_count_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageWithCountModel _$MessageWithCountModelFromJson(
    Map<String, dynamic> json) {
  return MessageWithCountModel(
    (json['appCodes'] as List)?.map((e) => e as String)?.toList(),
    json['code'] as String,
    json['data'] == null
        ? null
        : MessageWithCount.fromJson(json['data'] as Map<String, dynamic>),
    json['extStr'] as String,
    json['message'] as String,
    json['systemDate'] as String,
    json['totalCount'] as int,
  );
}

Map<String, dynamic> _$MessageWithCountModelToJson(
        MessageWithCountModel instance) =>
    <String, dynamic>{
      'appCodes': instance.appCodes,
      'code': instance.code,
      'data': instance.messageWithCount,
      'extStr': instance.extStr,
      'message': instance.message,
      'systemDate': instance.systemDate,
      'totalCount': instance.totalCount,
    };

MessageWithCount _$MessageWithCountFromJson(Map<String, dynamic> json) {
  return MessageWithCount(
    (json['messageSubVoList'] as List)
        ?.map((e) =>
            e == null ? null : MessageInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['yetReadMessageCount'] as int,
  );
}

Map<String, dynamic> _$MessageWithCountToJson(MessageWithCount instance) =>
    <String, dynamic>{
      'messageSubVoList': instance.messageList,
      'yetReadMessageCount': instance.yetReadMessageCount,
    };
