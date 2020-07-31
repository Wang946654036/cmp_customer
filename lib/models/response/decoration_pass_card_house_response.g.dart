// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'decoration_pass_card_house_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DecorationPassCardHouseResponse _$DecorationPassCardHouseResponseFromJson(
    Map<String, dynamic> json) {
  return DecorationPassCardHouseResponse()
    ..code = json['code'] as String
    ..message = json['message'] as String
    ..houseList = (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : DecorationPassCardHouse.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$DecorationPassCardHouseResponseToJson(
        DecorationPassCardHouseResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.houseList,
    };

DecorationPassCardHouse _$DecorationPassCardHouseFromJson(
    Map<String, dynamic> json) {
  return DecorationPassCardHouse(
    json['projectId'] as int,
    json['name'] as String,
    json['formerName'] as String,
    (json['houseVoList'] as List)
        ?.map((e) =>
            e == null ? null : HouseInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DecorationPassCardHouseToJson(
        DecorationPassCardHouse instance) =>
    <String, dynamic>{
      'projectId': instance.projectId,
      'name': instance.name,
      'formerName': instance.formerName,
      'houseVoList': instance.houseVoList,
    };
