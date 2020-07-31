// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_card_prices_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingCardPricesResponse _$ParkingCardPricesResponseFromJson(
    Map<String, dynamic> json) {
  return ParkingCardPricesResponse(
    appCodes: (json['appCodes'] as List)?.map((e) => e as String)?.toList(),
    parkingCardPackages: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : ParkingCardPackage.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    extStr: json['extStr'] as String,
    systemDate: json['systemDate'] as String,
    totalCount: json['totalCount'] as int,
  )
    ..code = json['code'] as String
    ..message = json['message'] as String;
}

Map<String, dynamic> _$ParkingCardPricesResponseToJson(
        ParkingCardPricesResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'appCodes': instance.appCodes,
      'data': instance.parkingCardPackages,
      'extStr': instance.extStr,
      'systemDate': instance.systemDate,
      'totalCount': instance.totalCount,
    };

ParkingCardPackage _$ParkingCardPackageFromJson(Map<String, dynamic> json) {
  return ParkingCardPackage(
    json['name'] as String,
    json['park_id'] as int,
    (json['price'] as List)
        ?.map((e) => e == null
            ? null
            : ParkingCardPrices.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ParkingCardPackageToJson(ParkingCardPackage instance) =>
    <String, dynamic>{
      'name': instance.parkName,
      'park_id': instance.parkId,
      'price': instance.prices,
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
