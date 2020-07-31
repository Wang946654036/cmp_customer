// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppInfoModel _$AppInfoModelFromJson(Map<String, dynamic> json) {
  return AppInfoModel(
    (json['appCodes'] as List)?.map((e) => e as String)?.toList(),
    json['code'] as String,
    json['data'] == null
        ? null
        : AppInfo.fromJson(json['data'] as Map<String, dynamic>),
    json['extStr'] as String,
    json['message'] as String,
    json['systemDate'] as String,
    json['totalCount'] as int,
  );
}

Map<String, dynamic> _$AppInfoModelToJson(AppInfoModel instance) =>
    <String, dynamic>{
      'appCodes': instance.appCodes,
      'code': instance.code,
      'data': instance.appInfo,
      'extStr': instance.extStr,
      'message': instance.message,
      'systemDate': instance.systemDate,
      'totalCount': instance.totalCount,
    };

AppInfo _$AppInfoFromJson(Map<String, dynamic> json) {
  return AppInfo(
    json['build'] as int,
    json['code'] as int,
    json['desc'] as String,
    json['id'] as int,
    json['isForce'] as int,
    json['otherUrl'] as String,
    json['systemType'] as String,
    json['type'] as String,
    json['url'] as String,
    json['version'] as String,
    json['size'] as String,
    json['disabledMenu'] as String,
    json['marketStatement'] as String,
  );
}

Map<String, dynamic> _$AppInfoToJson(AppInfo instance) => <String, dynamic>{
      'build': instance.build,
      'code': instance.code,
      'desc': instance.desc,
      'id': instance.id,
      'isForce': instance.isForce,
      'otherUrl': instance.otherUrl,
      'systemType': instance.systemType,
      'type': instance.type,
      'url': instance.url,
      'version': instance.version,
      'size': instance.size,
      'disabledMenu': instance.disabledMenu,
      'marketStatement': instance.marketStatement,
    };
