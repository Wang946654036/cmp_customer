// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_card_history_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingCardHistoryResponse _$ParkingCardHistoryResponseFromJson(
    Map<String, dynamic> json) {
  return ParkingCardHistoryResponse(
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : ParkingCardDetailsInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )
    ..code = json['code'] as String
    ..message = json['message'] as String;
}

Map<String, dynamic> _$ParkingCardHistoryResponseToJson(
        ParkingCardHistoryResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.parkingCardHistoryList,
    };
