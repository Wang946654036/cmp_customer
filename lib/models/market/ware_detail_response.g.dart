// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ware_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WareDetailResponse _$WareDetailResponseFromJson(Map<String, dynamic> json) {
  return WareDetailResponse(
    data: json['data'] == null
        ? null
        : WareDetailModel.fromJson(json['data'] as Map<String, dynamic>),
  )
    ..code = json['code'] as String
    ..message = json['message'] as String;
}

Map<String, dynamic> _$WareDetailResponseToJson(WareDetailResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
