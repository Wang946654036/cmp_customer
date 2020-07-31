// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entrance_card_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EntranceCardListResponse _$EntranceCardListResponseFromJson(
    Map<String, dynamic> json) {
  return EntranceCardListResponse(
    json['systemDate'] as String,
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : EntranceCardDetailsInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )
    ..code = json['code'] as String
    ..message = json['message'] as String;
}

Map<String, dynamic> _$EntranceCardListResponseToJson(
        EntranceCardListResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'systemDate': instance.systemDate,
      'data': instance.entranceCardDetailsList,
    };
