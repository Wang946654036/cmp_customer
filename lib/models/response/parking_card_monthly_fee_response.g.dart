// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_card_monthly_fee_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingCardMonthlyFeeResponse _$ParkingCardMonthlyFeeResponseFromJson(
    Map<String, dynamic> json) {
  return ParkingCardMonthlyFeeResponse()
    ..code = json['code'] as String
    ..message = json['message'] as String
    ..data = json['data'] == null
        ? null
        : ParkingCardMonthly.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ParkingCardMonthlyFeeResponseToJson(
        ParkingCardMonthlyFeeResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
