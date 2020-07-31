// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_card_monthly_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingCardMonthlyResponse _$ParkingCardMonthlyResponseFromJson(
    Map<String, dynamic> json) {
  return ParkingCardMonthlyResponse()
    ..code = json['code'] as String
    ..message = json['message'] as String
    ..data = (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : ParkingCardMonthly.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ParkingCardMonthlyResponseToJson(
        ParkingCardMonthlyResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

ParkingCardMonthly _$ParkingCardMonthlyFromJson(Map<String, dynamic> json) {
  return ParkingCardMonthly(
    json['community'] as String,
    json['communityName'] as String,
    json['end'] as String,
    json['fee'] as int,
    json['mobile'] as String,
    json['name'] as String,
    json['park_id'] as int,
    json['park_name'] as String,
    json['plate'] as String,
    json['price'] as String,
    json['price_id'] as int,
    json['price_name'] as String,
    json['start'] as String,
  );
}

Map<String, dynamic> _$ParkingCardMonthlyToJson(ParkingCardMonthly instance) =>
    <String, dynamic>{
      'community': instance.community,
      'communityName': instance.communityName,
      'end': instance.end,
      'fee': instance.fee,
      'mobile': instance.mobile,
      'name': instance.name,
      'park_id': instance.parkId,
      'park_name': instance.parkName,
      'plate': instance.plate,
      'price': instance.price,
      'price_id': instance.priceId,
      'price_name': instance.priceName,
      'start': instance.start,
    };
