// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ware_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WareListResponse _$WareListResponseFromJson(Map<String, dynamic> json) {
  return WareListResponse(
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : WareDetailModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )
    ..code = json['code'] as String
    ..message = json['message'] as String;
}

Map<String, dynamic> _$WareListResponseToJson(WareListResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
