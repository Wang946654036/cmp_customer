// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entrance_card_house_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EntranceCardHouseResponse _$EntranceCardHouseResponseFromJson(
    Map<String, dynamic> json) {
  return EntranceCardHouseResponse(
    (json['data'] as List)
        ?.map((e) =>
            e == null ? null : HouseInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['extStr'] as String,
    json['systemDate'] as String,
    json['totalCount'] as int,
  )
    ..code = json['code'] as String
    ..message = json['message'] as String;
}

Map<String, dynamic> _$EntranceCardHouseResponseToJson(
        EntranceCardHouseResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.houseList,
      'extStr': instance.extStr,
      'systemDate': instance.systemDate,
      'totalCount': instance.totalCount,
    };
