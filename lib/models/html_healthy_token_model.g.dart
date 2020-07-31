// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'html_healthy_token_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HtmlHealthyTokenModel _$HtmlHealthyTokenModelFromJson(
    Map<String, dynamic> json) {
  return HtmlHealthyTokenModel(
    json['data'] == null
        ? null
        : HealthyInfo.fromJson(json['data'] as Map<String, dynamic>),
  )
    ..code = json['code'] as String
    ..message = json['message'] as String;
}

Map<String, dynamic> _$HtmlHealthyTokenModelToJson(
        HtmlHealthyTokenModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.healthyInfo,
    };

HealthyInfo _$HealthyInfoFromJson(Map<String, dynamic> json) {
  return HealthyInfo(
    json['token'] as String,
    json['cid'] as String,
    json['url'] as String,
  );
}

Map<String, dynamic> _$HealthyInfoToJson(HealthyInfo instance) =>
    <String, dynamic>{
      'token': instance.token,
      'cid': instance.cid,
      'url': instance.url,
    };
