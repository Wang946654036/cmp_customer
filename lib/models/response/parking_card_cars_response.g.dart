// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_card_cars_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingCardCarsResponse _$ParkingCardCarsResponseFromJson(
    Map<String, dynamic> json) {
  return ParkingCardCarsResponse(
    (json['data'] as List)?.map((e) => e as String)?.toList(),
  )
    ..code = json['code'] as String
    ..message = json['message'] as String;
}

Map<String, dynamic> _$ParkingCardCarsResponseToJson(
        ParkingCardCarsResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.custCars,
    };
