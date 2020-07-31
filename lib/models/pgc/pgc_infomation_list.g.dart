// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pgc_infomation_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PgcInfomationList _$PgcInfomationListFromJson(Map<String, dynamic> json) {
  return PgcInfomationList(
    appCodes: (json['appCodes'] as List)?.map((e) => e as String)?.toList(),
    code: json['code'] as String,
    pgcInfomationInfoList: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : PgcInfomationInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    extStr: json['extStr'] as String,
    message: json['message'] as String,
    systemDate: json['systemDate'] as String,
    totalCount: json['totalCount'] as int,
  );
}

Map<String, dynamic> _$PgcInfomationListToJson(PgcInfomationList instance) =>
    <String, dynamic>{
      'appCodes': instance.appCodes,
      'code': instance.code,
      'data': instance.pgcInfomationInfoList,
      'extStr': instance.extStr,
      'message': instance.message,
      'systemDate': instance.systemDate,
      'totalCount': instance.totalCount,
    };
