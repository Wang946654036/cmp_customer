// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityModel _$CityModelFromJson(Map<String, dynamic> json) {
  return CityModel(
    (json['cityInfo'] as List)
        ?.map((e) =>
            e == null ? null : CityInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CityModelToJson(CityModel instance) => <String, dynamic>{
      'cityInfo': instance.cityList,
    };

CityInfo _$CityInfoFromJson(Map<String, dynamic> json) {
  return CityInfo(
    name: json['name'] as String,
    code: json['code'] as String,
    countryName: json['countryName'] as String,
    countryCode: json['countryCode'] as String,
    provinceCode: json['provinceCode'] as String,
    provinceName: json['provinceName'] as String,
    subName: json['subName'] as String,
    tagIndex: json['tagIndex'] as String,
    namePinyin: json['namePinyin'] as String,
  )..isShowSuspension = json['isShowSuspension'] as bool;
}

Map<String, dynamic> _$CityInfoToJson(CityInfo instance) => <String, dynamic>{
      'isShowSuspension': instance.isShowSuspension,
      'name': instance.name,
      'code': instance.code,
      'provinceName': instance.provinceName,
      'provinceCode': instance.provinceCode,
      'countryName': instance.countryName,
      'countryCode': instance.countryCode,
      'subName': instance.subName,
      'tagIndex': instance.tagIndex,
      'namePinyin': instance.namePinyin,
    };
