// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_card_price_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingCardPriceResponse _$ParkingCardPriceResponseFromJson(
    Map<String, dynamic> json) {
  return ParkingCardPriceResponse()
    ..code = json['code'] as String
    ..message = json['message'] as String
    ..prices = (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : ParkingCardPrices.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ParkingCardPriceResponseToJson(
        ParkingCardPriceResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.prices,
    };

ParkingCardPrices _$ParkingCardPricesFromJson(Map<String, dynamic> json) {
  return ParkingCardPrices(
    parkId: json['park_id'] as int,
    parkName: json['park_name'] as String,
    priceId: json['price_id'] as int,
    priceName: json['name'] as String,
    price: json['price'] as String,
  );
}

Map<String, dynamic> _$ParkingCardPricesToJson(ParkingCardPrices instance) =>
    <String, dynamic>{
      'park_name': instance.parkName,
      'park_id': instance.parkId,
      'name': instance.priceName,
      'price_id': instance.priceId,
      'price': instance.price,
    };
