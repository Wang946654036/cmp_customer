// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_other_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkOtherList _$WorkOtherListFromJson(Map<String, dynamic> json) {
  return WorkOtherList(
    appCodes: (json['appCodes'] as List)?.map((e) => e as String)?.toList(),
    code: json['code'] as String,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : WorkOther.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    extStr: json['extStr'] as String,
    message: json['message'] as String,
    systemDate: json['systemDate'] as String,
    totalCount: json['totalCount'] as int,
  );
}

Map<String, dynamic> _$WorkOtherListToJson(WorkOtherList instance) =>
    <String, dynamic>{
      'appCodes': instance.appCodes,
      'code': instance.code,
      'data': instance.data,
      'extStr': instance.extStr,
      'message': instance.message,
      'systemDate': instance.systemDate,
      'totalCount': instance.totalCount,
    };
