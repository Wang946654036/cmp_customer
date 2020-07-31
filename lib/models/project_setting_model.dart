import 'package:json_annotation/json_annotation.dart';

part 'project_setting_model.g.dart';


@JsonSerializable()
class ProjectSettingModel extends Object {

  @JsonKey(name: 'appCodes')
  List<String> appCodes;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'data')
  ProjectSetting projectSetting;

  @JsonKey(name: 'extStr')
  String extStr;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'totalCount')
  int totalCount;

  ProjectSettingModel(this.appCodes,this.code,this.projectSetting,this.extStr,this.message,this.systemDate,this.totalCount,);

  factory ProjectSettingModel.fromJson(Map<String, dynamic> srcJson) => _$ProjectSettingModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProjectSettingModelToJson(this);

}


@JsonSerializable()
class ProjectSetting extends Object {

  @JsonKey(name: 'orgId')
  int orgId;

  @JsonKey(name: 'orgName')
  String orgName;

  @JsonKey(name: 'projectCode')
  String projectCode;

  @JsonKey(name: 'projectId')
  int projectId;

  @JsonKey(name: 'projectName')
  String projectName;

  @JsonKey(name: 'projectSettingId')
  int projectSettingId;

  @JsonKey(name: 'settingDetailList')
  List<SettingDetail> settingDetailList;

  @JsonKey(name: 'settingPostId')
  int settingPostId;

  @JsonKey(name: 'settingTime')
  String settingTime;

  @JsonKey(name: 'settingUserId')
  int settingUserId;

  ProjectSetting(this.orgId,this.orgName,this.projectCode,this.projectId,this.projectName,this.projectSettingId,this.settingDetailList,this.settingPostId,this.settingTime,this.settingUserId,);

  factory ProjectSetting.fromJson(Map<String, dynamic> srcJson) => _$ProjectSettingFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProjectSettingToJson(this);

}

@JsonSerializable()
class SettingDetail extends Object {

  @JsonKey(name: 'hotWorkTimeVo')
  HotWorkTimeInfo hotWorkTimeInfo;

  @JsonKey(name: 'projectSettingId')
  int projectSettingId;

  @JsonKey(name: 'settingCodeList')
  List<String> settingCodeList;

  @JsonKey(name: 'settingDetailId')
  int settingDetailId;

  @JsonKey(name: 'settingTypeId')
  int settingTypeId;

  @JsonKey(name: 'settingValue1')
  String settingValue1;

  @JsonKey(name: 'settingValue2')
  String settingValue2;

  @JsonKey(name: 'settingValue3')
  String settingValue3;

  @JsonKey(name: 'settingVoList')
  List<SettingVoList> settingVoList;

  @JsonKey(name: 'sortNo')
  int sortNo;

  @JsonKey(name: 'typeCode')
  String typeCode;

  @JsonKey(name: 'typeDesc')
  String typeDesc;

  @JsonKey(name: 'typeName')
  String typeName;

  @JsonKey(name: 'validFlag')
  String validFlag;

  SettingDetail(this.hotWorkTimeInfo,this.projectSettingId,this.settingCodeList,this.settingDetailId,this.settingTypeId,this.settingValue1,this.settingValue2,this.settingValue3,this.settingVoList,this.sortNo,this.typeCode,this.typeDesc,this.typeName,this.validFlag,);

  factory SettingDetail.fromJson(Map<String, dynamic> srcJson) => _$SettingDetailFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SettingDetailToJson(this);

}


@JsonSerializable()
class HotWorkTimeInfo extends Object {

  @JsonKey(name: 'applyDay')
  int applyDay;

  @JsonKey(name: 'endTime')
  String endTime;

  @JsonKey(name: 'startTime')
  String startTime;

  @JsonKey(name: 'workDay')
  int workDay;

  HotWorkTimeInfo(this.applyDay,this.endTime,this.startTime,this.workDay,);

  factory HotWorkTimeInfo.fromJson(Map<String, dynamic> srcJson) => _$HotWorkTimeInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HotWorkTimeInfoToJson(this);

}


@JsonSerializable()
class SettingVoList extends Object {

  @JsonKey(name: 'checked')
  String checked;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'name')
  String name;

  SettingVoList(this.checked,this.code,this.name,);

  factory SettingVoList.fromJson(Map<String, dynamic> srcJson) => _$SettingVoListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SettingVoListToJson(this);

}


