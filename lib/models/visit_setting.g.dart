// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visit_setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisitSetting _$VisitSettingFromJson(Map<String, dynamic> json) {
  return VisitSetting(
    appCodes: (json['appCodes'] as List)?.map((e) => e as String)?.toList(),
    code: json['code'] as String,
    data: json['data'] == null
        ? null
        : VisitSettingInfo.fromJson(json['data'] as Map<String, dynamic>),
    extStr: json['extStr'] as String,
    message: json['message'] as String,
    systemDate: json['systemDate'] as String,
    totalCount: json['totalCount'] as int,
  );
}

Map<String, dynamic> _$VisitSettingToJson(VisitSetting instance) =>
    <String, dynamic>{
      'appCodes': instance.appCodes,
      'code': instance.code,
      'data': instance.data,
      'extStr': instance.extStr,
      'message': instance.message,
      'systemDate': instance.systemDate,
      'totalCount': instance.totalCount,
    };

VisitSettingInfo _$VisitSettingInfoFromJson(Map<String, dynamic> json) {
  return VisitSettingInfo(
    appointmentVisitSettingId: json['appointmentVisitSettingId'] as int,
    beginTime: json['beginTime'] as String,
    checkType: json['checkType'] as String,
    createTime: json['createTime'] as String,
    endTime: json['endTime'] as String,
    maxEffective: json['maxEffective'] as int,
    orgId: json['orgId'] as int,
    projectId: json['projectId'] as int,
  );
}

Map<String, dynamic> _$VisitSettingInfoToJson(VisitSettingInfo instance) =>
    <String, dynamic>{
      'appointmentVisitSettingId': instance.appointmentVisitSettingId,
      'beginTime': instance.beginTime,
      'checkType': instance.checkType,
      'createTime': instance.createTime,
      'endTime': instance.endTime,
      'maxEffective': instance.maxEffective,
      'orgId': instance.orgId,
      'projectId': instance.projectId,
    };
