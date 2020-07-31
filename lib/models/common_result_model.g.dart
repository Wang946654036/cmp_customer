// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommonResultModel _$CommonResultModelFromJson(Map<String, dynamic> json) {
  return CommonResultModel(
    json['code'],
    json['message'] as String,
    json['data'],
  );
}

Map<String, dynamic> _$CommonResultModelToJson(CommonResultModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
