import 'package:cmp_customer/models/hot_work_detail_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hot_work_record_model.g.dart';

@JsonSerializable()
class HotWorkRecordModel extends Object {
  @JsonKey(name: 'appCodes')
  List<String> appCodes;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'data')
  List<HotWorkInfo> hotWorkList;

  @JsonKey(name: 'extStr')
  String extStr;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'totalCount')
  int totalCount;

  HotWorkRecordModel(
    this.appCodes,
    this.code,
    this.hotWorkList,
    this.extStr,
    this.message,
    this.systemDate,
    this.totalCount,
  );

  factory HotWorkRecordModel.fromJson(Map<String, dynamic> srcJson) => _$HotWorkRecordModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HotWorkRecordModelToJson(this);
}

@JsonSerializable()
class HotWorkInfo extends Object {
  @JsonKey(name: 'constructionUnit')
  String constructionUnit;

  @JsonKey(name: 'createTime')
  String createTime;

  @JsonKey(name: 'customerId')
  int customerId;

  @JsonKey(name: 'customerName')
  String customerName;

  @JsonKey(name: 'customerPhone')
  String customerPhone;

  @JsonKey(name: 'firePreventMan')
  String firePreventMan;

  @JsonKey(name: 'fireWatchMan')
  String fireWatchMan;

  @JsonKey(name: 'hotWorkContent')
  String hotWorkContent;

  @JsonKey(name: 'hotWorkEndTime')
  String hotWorkEndTime;

  @JsonKey(name: 'hotWorkId')
  int hotWorkId;

  @JsonKey(name: 'hotWorkLocation')
  String hotWorkLocation;

  @JsonKey(name: 'hotWorkNo')
  String hotWorkNo;

  @JsonKey(name: 'hotWorkStartTime')
  String hotWorkStartTime;

  @JsonKey(name: 'houseBuildId')
  int houseBuildId;

  @JsonKey(name: 'houseId')
  int houseId;

  @JsonKey(name: 'houseName')
  String houseName;

  @JsonKey(name: 'houseUnitId')
  int houseUnitId;

  @JsonKey(name: 'onSiteLeader')
  String onSiteLeader;

  @JsonKey(name: 'ownerId')
  int ownerId;

  @JsonKey(name: 'ownerIdentityNo')
  String ownerIdentityNo;

  @JsonKey(name: 'ownerName')
  String ownerName;

  @JsonKey(name: 'ownerPhone')
  String ownerPhone;

  @JsonKey(name: 'processExecutor')
  String processExecutor;

  @JsonKey(name: 'processId')
  String processId;

  @JsonKey(name: 'processNodeCode')
  String processNodeCode;

  @JsonKey(name: 'processNodeName')
  String processNodeName;

  @JsonKey(name: 'processPostId')
  int processPostId;

  @JsonKey(name: 'processState')
  String processState;

  @JsonKey(name: 'processStateName')
  String processStateName;

  @JsonKey(name: 'processTime')
  String processTime;

  @JsonKey(name: 'processUserId')
  int processUserId;

  @JsonKey(name: 'projectId')
  int projectId;

  @JsonKey(name: 'projectName')
  String projectName;

  @JsonKey(name: 'formerName')
  String formerName;

  @JsonKey(name: 'remark')
  String remark;

  @JsonKey(name: 'updateTime')
  String updateTime;

  @JsonKey(name: 'welderList')
  List<WelderInfo> welderList;

  HotWorkInfo(
    this.constructionUnit,
    this.createTime,
    this.customerId,
    this.customerName,
    this.customerPhone,
    this.firePreventMan,
    this.fireWatchMan,
    this.hotWorkContent,
    this.hotWorkEndTime,
    this.hotWorkId,
    this.hotWorkLocation,
    this.hotWorkNo,
    this.hotWorkStartTime,
    this.houseBuildId,
    this.houseId,
    this.houseName,
    this.houseUnitId,
    this.onSiteLeader,
    this.ownerId,
    this.ownerIdentityNo,
    this.ownerName,
    this.ownerPhone,
    this.processExecutor,
    this.processId,
    this.processNodeCode,
    this.processNodeName,
    this.processPostId,
    this.processState,
    this.processStateName,
    this.processTime,
    this.processUserId,
    this.projectId,
    this.projectName,
    this.formerName,
    this.remark,
    this.updateTime,
    this.welderList,
  );

  factory HotWorkInfo.fromJson(Map<String, dynamic> srcJson) => _$HotWorkInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HotWorkInfoToJson(this);
}
