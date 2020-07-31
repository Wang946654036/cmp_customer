// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerModel _$BannerModelFromJson(Map<String, dynamic> json) {
  return BannerModel(
    (json['appCodes'] as List)?.map((e) => e as String)?.toList(),
    json['code'] as String,
    (json['data'] as List)
        ?.map((e) =>
            e == null ? null : BannerInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['extStr'] as String,
    json['message'] as String,
    json['systemDate'] as String,
    json['totalCount'] as int,
  );
}

Map<String, dynamic> _$BannerModelToJson(BannerModel instance) =>
    <String, dynamic>{
      'appCodes': instance.appCodes,
      'code': instance.code,
      'data': instance.bannerList,
      'extStr': instance.extStr,
      'message': instance.message,
      'systemDate': instance.systemDate,
      'totalCount': instance.totalCount,
    };

BannerInfo _$BannerInfoFromJson(Map<String, dynamic> json) {
  return BannerInfo(
    json['bannerId'] as int,
    json['id'] as int,
    json['type'] as int,
    json['url'] as String,
    json['uuid'] as String,
    json['imgTitle'] as String,
  );
}

Map<String, dynamic> _$BannerInfoToJson(BannerInfo instance) =>
    <String, dynamic>{
      'bannerId': instance.bannerId,
      'id': instance.id,
      'type': instance.type,
      'url': instance.url,
      'uuid': instance.uuid,
      'imgTitle': instance.title,
    };
