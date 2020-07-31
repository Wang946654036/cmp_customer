// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_project_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuProjectModel _$MenuProjectModelFromJson(Map<String, dynamic> json) {
  return MenuProjectModel(
    appCodes: (json['appCodes'] as List)?.map((e) => e as String)?.toList(),
    code: json['code'] as String,
    menuProjectList: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : MenuInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    extStr: json['extStr'] as String,
    message: json['message'] as String,
    systemDate: json['systemDate'] as String,
    totalCount: json['totalCount'] as int,
  );
}

Map<String, dynamic> _$MenuProjectModelToJson(MenuProjectModel instance) =>
    <String, dynamic>{
      'appCodes': instance.appCodes,
      'code': instance.code,
      'data': instance.menuProjectList,
      'extStr': instance.extStr,
      'message': instance.message,
      'systemDate': instance.systemDate,
      'totalCount': instance.totalCount,
    };
