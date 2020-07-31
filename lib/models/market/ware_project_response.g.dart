// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ware_project_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WareProjectResponse _$WareProjectResponseFromJson(Map<String, dynamic> json) {
  return WareProjectResponse(
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : ProjectInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )
    ..code = json['code'] as String
    ..message = json['message'] as String;
}

Map<String, dynamic> _$WareProjectResponseToJson(
        WareProjectResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

ProjectInfo _$ProjectInfoFromJson(Map<String, dynamic> json) {
  return ProjectInfo(
    area: json['area'] as String,
    city: json['city'] as String,
    projectId: json['projectId'] as int,
    projectCode: json['projectCode'] as String,
    name: json['name'] as String,
    status: json['status'] as String,
  );
}

Map<String, dynamic> _$ProjectInfoToJson(ProjectInfo instance) =>
    <String, dynamic>{
      'area': instance.area,
      'city': instance.city,
      'projectId': instance.projectId,
      'projectCode': instance.projectCode,
      'name': instance.name,
      'status': instance.status,
    };
