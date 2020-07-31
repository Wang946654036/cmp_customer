// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pgc_topic_obj.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PgcTopicObj _$PgcTopicObjFromJson(Map<String, dynamic> json) {
  return PgcTopicObj(
    (json['appCodes'] as List)?.map((e) => e as String)?.toList(),
    json['code'] as String,
    json['data'] == null
        ? null
        : PgcTopicInfo.fromJson(json['data'] as Map<String, dynamic>),
    json['extStr'] as String,
    json['message'] as String,
    json['systemDate'] as String,
    json['totalCount'] as int,
  );
}

Map<String, dynamic> _$PgcTopicObjToJson(PgcTopicObj instance) =>
    <String, dynamic>{
      'appCodes': instance.appCodes,
      'code': instance.code,
      'data': instance.pgcTopicInfo,
      'extStr': instance.extStr,
      'message': instance.message,
      'systemDate': instance.systemDate,
      'totalCount': instance.totalCount,
    };

PgcTopicInfo _$PgcTopicInfoFromJson(Map<String, dynamic> json) {
  return PgcTopicInfo();
}

Map<String, dynamic> _$PgcTopicInfoToJson(PgcTopicInfo instance) =>
    <String, dynamic>{};
