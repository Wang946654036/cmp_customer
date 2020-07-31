// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pgc_topic_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PgcTopicList _$PgcTopicListFromJson(Map<String, dynamic> json) {
  return PgcTopicList(
    appCodes: (json['appCodes'] as List)?.map((e) => e as String)?.toList(),
    code: json['code'] as String,
    pgcTopicInfoList: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : PgcTopicInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    extStr: json['extStr'] as String,
    message: json['message'] as String,
    systemDate: json['systemDate'] as String,
    totalCount: json['totalCount'] as int,
  );
}

Map<String, dynamic> _$PgcTopicListToJson(PgcTopicList instance) =>
    <String, dynamic>{
      'appCodes': instance.appCodes,
      'code': instance.code,
      'data': instance.pgcTopicInfoList,
      'extStr': instance.extStr,
      'message': instance.message,
      'systemDate': instance.systemDate,
      'totalCount': instance.totalCount,
    };
