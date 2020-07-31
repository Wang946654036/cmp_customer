// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_setting_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectSettingModel _$ProjectSettingModelFromJson(Map<String, dynamic> json) {
  return ProjectSettingModel(
    (json['appCodes'] as List)?.map((e) => e as String)?.toList(),
    json['code'] as String,
    json['data'] == null
        ? null
        : ProjectSetting.fromJson(json['data'] as Map<String, dynamic>),
    json['extStr'] as String,
    json['message'] as String,
    json['systemDate'] as String,
    json['totalCount'] as int,
  );
}

Map<String, dynamic> _$ProjectSettingModelToJson(
        ProjectSettingModel instance) =>
    <String, dynamic>{
      'appCodes': instance.appCodes,
      'code': instance.code,
      'data': instance.projectSetting,
      'extStr': instance.extStr,
      'message': instance.message,
      'systemDate': instance.systemDate,
      'totalCount': instance.totalCount,
    };

ProjectSetting _$ProjectSettingFromJson(Map<String, dynamic> json) {
  return ProjectSetting(
    json['orgId'] as int,
    json['orgName'] as String,
    json['projectCode'] as String,
    json['projectId'] as int,
    json['projectName'] as String,
    json['projectSettingId'] as int,
    (json['settingDetailList'] as List)
        ?.map((e) => e == null
            ? null
            : SettingDetail.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['settingPostId'] as int,
    json['settingTime'] as String,
    json['settingUserId'] as int,
  );
}

Map<String, dynamic> _$ProjectSettingToJson(ProjectSetting instance) =>
    <String, dynamic>{
      'orgId': instance.orgId,
      'orgName': instance.orgName,
      'projectCode': instance.projectCode,
      'projectId': instance.projectId,
      'projectName': instance.projectName,
      'projectSettingId': instance.projectSettingId,
      'settingDetailList': instance.settingDetailList,
      'settingPostId': instance.settingPostId,
      'settingTime': instance.settingTime,
      'settingUserId': instance.settingUserId,
    };

SettingDetail _$SettingDetailFromJson(Map<String, dynamic> json) {
  return SettingDetail(
    json['hotWorkTimeVo'] == null
        ? null
        : HotWorkTimeInfo.fromJson(
            json['hotWorkTimeVo'] as Map<String, dynamic>),
    json['projectSettingId'] as int,
    (json['settingCodeList'] as List)?.map((e) => e as String)?.toList(),
    json['settingDetailId'] as int,
    json['settingTypeId'] as int,
    json['settingValue1'] as String,
    json['settingValue2'] as String,
    json['settingValue3'] as String,
    (json['settingVoList'] as List)
        ?.map((e) => e == null
            ? null
            : SettingVoList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['sortNo'] as int,
    json['typeCode'] as String,
    json['typeDesc'] as String,
    json['typeName'] as String,
    json['validFlag'] as String,
  );
}

Map<String, dynamic> _$SettingDetailToJson(SettingDetail instance) =>
    <String, dynamic>{
      'hotWorkTimeVo': instance.hotWorkTimeInfo,
      'projectSettingId': instance.projectSettingId,
      'settingCodeList': instance.settingCodeList,
      'settingDetailId': instance.settingDetailId,
      'settingTypeId': instance.settingTypeId,
      'settingValue1': instance.settingValue1,
      'settingValue2': instance.settingValue2,
      'settingValue3': instance.settingValue3,
      'settingVoList': instance.settingVoList,
      'sortNo': instance.sortNo,
      'typeCode': instance.typeCode,
      'typeDesc': instance.typeDesc,
      'typeName': instance.typeName,
      'validFlag': instance.validFlag,
    };

HotWorkTimeInfo _$HotWorkTimeInfoFromJson(Map<String, dynamic> json) {
  return HotWorkTimeInfo(
    json['applyDay'] as int,
    json['endTime'] as String,
    json['startTime'] as String,
    json['workDay'] as int,
  );
}

Map<String, dynamic> _$HotWorkTimeInfoToJson(HotWorkTimeInfo instance) =>
    <String, dynamic>{
      'applyDay': instance.applyDay,
      'endTime': instance.endTime,
      'startTime': instance.startTime,
      'workDay': instance.workDay,
    };

SettingVoList _$SettingVoListFromJson(Map<String, dynamic> json) {
  return SettingVoList(
    json['checked'] as String,
    json['code'] as String,
    json['name'] as String,
  );
}

Map<String, dynamic> _$SettingVoListToJson(SettingVoList instance) =>
    <String, dynamic>{
      'checked': instance.checked,
      'code': instance.code,
      'name': instance.name,
    };
