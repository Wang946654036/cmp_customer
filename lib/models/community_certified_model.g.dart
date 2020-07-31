// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_certified_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommunityCertifiedModel _$CommunityCertifiedModelFromJson(
    Map<String, dynamic> json) {
  return CommunityCertifiedModel(
    (json['appCodes'] as List)?.map((e) => e as String)?.toList(),
    json['code'] as String,
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : CommunityCertified.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['extStr'] as String,
    json['message'] as String,
    json['systemDate'] as String,
    json['totalCount'] as int,
  );
}

Map<String, dynamic> _$CommunityCertifiedModelToJson(
        CommunityCertifiedModel instance) =>
    <String, dynamic>{
      'appCodes': instance.appCodes,
      'code': instance.code,
      'data': instance.communityCertifiedList,
      'extStr': instance.extStr,
      'message': instance.message,
      'systemDate': instance.systemDate,
      'totalCount': instance.totalCount,
    };

CommunityCertified _$CommunityCertifiedFromJson(Map<String, dynamic> json) {
  return CommunityCertified(
    json['isDefaultProject'] as String,
    json['projectId'] as int,
    json['projectName'] as String,
    json['status'] as String,
    json['formerName'] as String,
  );
}

Map<String, dynamic> _$CommunityCertifiedToJson(CommunityCertified instance) =>
    <String, dynamic>{
      'isDefaultProject': instance.isDefaultProject,
      'projectId': instance.projectId,
      'projectName': instance.projectName,
      'formerName': instance.formerName,
      'status': instance.status,
    };
