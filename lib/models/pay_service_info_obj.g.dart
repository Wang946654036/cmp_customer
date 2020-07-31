// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pay_service_info_obj.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayServiceInfoObj _$PayServiceInfoObjFromJson(Map<String, dynamic> json) {
  return PayServiceInfoObj(
    (json['appCodes'] as List)?.map((e) => e as String)?.toList(),
    json['code'] as String,
    json['data'] == null
        ? null
        : PayServiceInfo.fromJson(json['data'] as Map<String, dynamic>),
    json['extStr'] as String,
    json['message'] as String,
    json['systemDate'] as String,
    json['totalCount'] as int,
  );
}

Map<String, dynamic> _$PayServiceInfoObjToJson(PayServiceInfoObj instance) =>
    <String, dynamic>{
      'appCodes': instance.appCodes,
      'code': instance.code,
      'data': instance.data,
      'extStr': instance.extStr,
      'message': instance.message,
      'systemDate': instance.systemDate,
      'totalCount': instance.totalCount,
    };
