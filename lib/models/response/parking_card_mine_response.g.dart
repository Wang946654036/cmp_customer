// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_card_mine_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingCardMineResponse _$ParkingCardMineResponseFromJson(
    Map<String, dynamic> json) {
  return ParkingCardMineResponse(
    parkingCardDetailsList: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : ParkingCardDetailsInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )
    ..code = json['code'] as String
    ..message = json['message'] as String;
}

Map<String, dynamic> _$ParkingCardMineResponseToJson(
        ParkingCardMineResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.parkingCardDetailsList,
    };
