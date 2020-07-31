// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MapInfoModel _$MapInfoModelFromJson(Map<String, dynamic> json) {
  return MapInfoModel(
    (json['longitude'] as num)?.toDouble(),
    (json['latitude'] as num)?.toDouble(),
    json['address'] as String,
    json['map'] as String,
  );
}

Map<String, dynamic> _$MapInfoModelToJson(MapInfoModel instance) =>
    <String, dynamic>{
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'address': instance.address,
      'map': instance.map,
    };
