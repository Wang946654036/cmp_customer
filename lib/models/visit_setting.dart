import 'package:json_annotation/json_annotation.dart';

part 'visit_setting.g.dart';


@JsonSerializable()
class VisitSetting extends Object{

  @JsonKey(name: 'appCodes')
  List<String> appCodes;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'data')
  VisitSettingInfo data;

  @JsonKey(name: 'extStr')
  String extStr;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'totalCount')
  int totalCount;

  VisitSetting({this.appCodes,this.code,this.data,this.extStr,this.message,this.systemDate,this.totalCount,});

  factory VisitSetting.fromJson(Map<String, dynamic> srcJson) => _$VisitSettingFromJson(srcJson);

}


@JsonSerializable()
class VisitSettingInfo extends Object{

  @JsonKey(name: 'appointmentVisitSettingId')
  int appointmentVisitSettingId;

  @JsonKey(name: 'beginTime')
  String beginTime;

  @JsonKey(name: 'checkType')
  String checkType;

  @JsonKey(name: 'createTime')
  String createTime;

  @JsonKey(name: 'endTime')
  String endTime;

  @JsonKey(name: 'maxEffective')
  int maxEffective;

  @JsonKey(name: 'orgId')
  int orgId;

  @JsonKey(name: 'projectId')
  int projectId;

  VisitSettingInfo({this.appointmentVisitSettingId,this.beginTime,this.checkType,this.createTime,this.endTime,this.maxEffective,this.orgId,this.projectId,});

  factory VisitSettingInfo.fromJson(Map<String, dynamic> srcJson) => _$VisitSettingInfoFromJson(srcJson);

}


