// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reserve_info_obj.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReserveInfoObj _$ReserveInfoObjFromJson(Map<String, dynamic> json) {
  return ReserveInfoObj(
    appCodes: (json['appCodes'] as List)?.map((e) => e as String)?.toList(),
    code: json['code'] as String,
    data: json['data'] == null
        ? null
        : ReserveInfo.fromJson(json['data'] as Map<String, dynamic>),
    extStr: json['extStr'] as String,
    message: json['message'] as String,
    systemDate: json['systemDate'] as String,
    totalCount: json['totalCount'] as int,
  );
}

Map<String, dynamic> _$ReserveInfoObjToJson(ReserveInfoObj instance) =>
    <String, dynamic>{
      'appCodes': instance.appCodes,
      'code': instance.code,
      'data': instance.data,
      'extStr': instance.extStr,
      'message': instance.message,
      'systemDate': instance.systemDate,
      'totalCount': instance.totalCount,
    };
