import 'package:cmp_customer/models/change_title_obj.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'brand_name_obj.g.dart';


@JsonSerializable()
class BrandNameObj extends Object {

  @JsonKey(name: 'appCodes')
  List<String> appCodes;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'data')
  BrandNameInfo brandNameInfo;

  @JsonKey(name: 'extStr')
  String extStr;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'totalCount')
  int totalCount;

  BrandNameObj(this.appCodes,this.code,this.brandNameInfo,this.extStr,this.message,this.systemDate,this.totalCount,);

  factory BrandNameObj.fromJson(Map<String, dynamic> srcJson) => _$BrandNameObjFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BrandNameObjToJson(this);

}


@JsonSerializable()
class BrandNameInfo extends Object {

  @JsonKey(name: 'applyManHouseProper')
  String applyManHouseProper;

  @JsonKey(name: 'applyManHouseProperName')
  String applyManHouseProperName;

  @JsonKey(name: 'applyManId')
  int applyManId;

  @JsonKey(name: 'applyManName')
  String applyManName;

  @JsonKey(name: 'applyManPhone')
  String applyManPhone;

  @JsonKey(name: 'applyType')
  String applyType;

  @JsonKey(name: 'applyTypeName')
  String applyTypeName;

  @JsonKey(name: 'attList')
  List<AttList> attList;

  @JsonKey(name: 'brandNameId')
  int brandNameId;

  @JsonKey(name: 'buildId')
  int buildId;

  @JsonKey(name: 'buildName')
  String buildName;

  @JsonKey(name: 'businessNo')
  String businessNo;

  @JsonKey(name: 'createTime')
  String createTime;

  @JsonKey(name: 'houseId')
  int houseId;

  @JsonKey(name: 'houseNo')
  String houseNo;

  @JsonKey(name: 'mpApplyCount')
  int mpApplyCount;

  @JsonKey(name: 'mpContent')
  String mpContent;

  @JsonKey(name: 'operateStep')
  String operateStep;

  @JsonKey(name: 'operateStepName')
  String operateStepName;

  @JsonKey(name: 'payFees')
  double payFees;

  @JsonKey(name: 'paymentTime')
  String paymentTime;

  @JsonKey(name: 'projectId')
  int projectId;

  @JsonKey(name: 'projectName')
  String projectName;

  @JsonKey(name: 'recordList')
  List<RecordList> recordList;

  @JsonKey(name: 'remark')
  String remark;

  @JsonKey(name: 'settingId')
  int settingId;

  @JsonKey(name: 'settingList')
  List<SettingList> settingList;

  @JsonKey(name: 'spSettingList')
  List<SettingList> spSettingList;

  @JsonKey(name: 'mpSettingList')
  List<SettingList> mpSettingList;

  @JsonKey(name: 'shouldPayMoney')
  double shouldPayMoney;

  @JsonKey(name: 'spApplyCount')
  int spApplyCount;

  @JsonKey(name: 'spContent')
  String spContent;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'statusName')
  String statusName;

  @JsonKey(name: 'unitId')
  int unitId;

  @JsonKey(name: 'unitName')
  String unitName;

  @JsonKey(name: 'updateTime')
  String updateTime;

  @JsonKey(name: 'useTime')
  String useTime;

  BrandNameInfo({this.spSettingList,this.mpSettingList,this.applyManHouseProper,this.applyManHouseProperName,this.applyManId,this.applyManName,this.applyManPhone,this.applyType,this.applyTypeName,this.attList,this.brandNameId,this.buildId,this.buildName,this.businessNo,this.createTime,this.houseId,this.houseNo,this.mpApplyCount,this.mpContent,this.operateStep,this.operateStepName,this.payFees,this.paymentTime,this.projectId,this.projectName,this.recordList,this.remark,this.settingId,this.settingList,this.shouldPayMoney,this.spApplyCount,this.spContent,this.status,this.statusName,this.unitId,this.unitName,this.updateTime,this.useTime,});

  factory BrandNameInfo.fromJson(Map<String, dynamic> srcJson) => _$BrandNameInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BrandNameInfoToJson(this);

}


@JsonSerializable()
class AttList extends Object {

  @JsonKey(name: 'attachmentName')
  String attachmentName;

  @JsonKey(name: 'attachmentType')
  String attachmentType;

  @JsonKey(name: 'attachmentUuid')
  String attachmentUuid;

  @JsonKey(name: 'createTime')
  String createTime;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'relatedId')
  int relatedId;

  @JsonKey(name: 'source')
  String source;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'type')
  String type;

  AttList({this.attachmentName,this.attachmentType,this.attachmentUuid,this.createTime,this.id,this.relatedId,this.source,this.status,this.type,});

  factory AttList.fromJson(Map<String, dynamic> srcJson) => _$AttListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AttListToJson(this);

}





@JsonSerializable()
class SettingList extends Object {

  @JsonKey(name: 'attsCount')
  int attsCount;

  @JsonKey(name: 'createTime')
  String createTime;

  @JsonKey(name: 'creatorId')
  int creatorId;

  @JsonKey(name: 'isCustChoose')
  String isCustChoose;

  @JsonKey(name: 'markPrice')
  double markPrice;

  @JsonKey(name: 'photoAttList')
  List<PhotoAttList> photoAttList;

  @JsonKey(name: 'projectSimpleVoList')
  List<ProjectSimpleVoList> projectSimpleVoList;

  @JsonKey(name: 'settingDesc')
  String settingDesc;

  @JsonKey(name: 'settingId')
  int settingId;

  @JsonKey(name: 'settingTitle')
  String settingTitle;

  @JsonKey(name: 'settingTyepName')
  String settingTyepName;

  @JsonKey(name: 'settingType')
  String settingType;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'updateTime')
  String updateTime;

  @JsonKey(name: 'updaterId')
  int updaterId;

  SettingList({this.attsCount,this.createTime,this.creatorId,this.isCustChoose,this.markPrice,this.photoAttList,this.projectSimpleVoList,this.settingDesc,this.settingId,this.settingTitle,this.settingTyepName,this.settingType,this.status,this.updateTime,this.updaterId,});

  factory SettingList.fromJson(Map<String, dynamic> srcJson) => _$SettingListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SettingListToJson(this);

}


@JsonSerializable()
class PhotoAttList extends Object {

  @JsonKey(name: 'attachmentName')
  String attachmentName;

  @JsonKey(name: 'attachmentType')
  String attachmentType;

  @JsonKey(name: 'attachmentUuid')
  String attachmentUuid;

  @JsonKey(name: 'createTime')
  String createTime;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'relatedId')
  int relatedId;

  @JsonKey(name: 'source')
  String source;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'type')
  String type;

  PhotoAttList(this.attachmentName,this.attachmentType,this.attachmentUuid,this.createTime,this.id,this.relatedId,this.source,this.status,this.type,);

  factory PhotoAttList.fromJson(Map<String, dynamic> srcJson) => _$PhotoAttListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PhotoAttListToJson(this);

}


@JsonSerializable()
class ProjectSimpleVoList extends Object {

  @JsonKey(name: 'projectId')
  int projectId;

  @JsonKey(name: 'projectName')
  String projectName;

  ProjectSimpleVoList(this.projectId,this.projectName,);

  factory ProjectSimpleVoList.fromJson(Map<String, dynamic> srcJson) => _$ProjectSimpleVoListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProjectSimpleVoListToJson(this);

}


