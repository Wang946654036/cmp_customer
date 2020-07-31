// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_card_pay_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingCardPayInfoResponse _$ParkingCardPayInfoResponseFromJson(
    Map<String, dynamic> json) {
  return ParkingCardPayInfoResponse(
    json['data'] as String,
    json['extStr'] as String,
  )
    ..code = json['code'] as String
    ..message = json['message'] as String;
}

Map<String, dynamic> _$ParkingCardPayInfoResponseToJson(
        ParkingCardPayInfoResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.url,
      'extStr': instance.extStr,
    };
