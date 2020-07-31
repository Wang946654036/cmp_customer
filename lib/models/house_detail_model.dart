import 'package:json_annotation/json_annotation.dart';

part 'house_detail_model.g.dart';

@JsonSerializable()
class HouseDetailModel extends Object {
  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'data')
  HouseDetail houseDetail;

  HouseDetailModel(
    this.code,
    this.message,
    this.systemDate,
    this.houseDetail,
  );

  factory HouseDetailModel.fromJson(Map<String, dynamic> srcJson) => _$HouseDetailModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HouseDetailModelToJson(this);
}

@JsonSerializable()
class HouseDetail extends Object {
  @JsonKey(name: 'myHouseRelationVoApp')
  HouseInfo certifiedHouseInfo;

  @JsonKey(name: 'houseCustAuditVoApp')
  HouseInfo unCertifiedHouseInfo;

  @JsonKey(name: 'custHouseRelationVoAppList')
  List<MemberInfo> memberList;

  HouseDetail({
    this.certifiedHouseInfo,
    this.unCertifiedHouseInfo,
    this.memberList,
  });

  factory HouseDetail.fromJson(Map<String, dynamic> srcJson) => _$HouseDetailFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HouseDetailToJson(this);
}

@JsonSerializable()
class HouseInfo extends Object {
  @JsonKey(name: 'auditStatus')
  String auditStatus;

  @JsonKey(name: 'custHouseRelationId')
  int custHouseRelationId;

  @JsonKey(name: 'custId')
  int custId;

  @JsonKey(name: 'houseId')
  int houseId;

  @JsonKey(name: 'projectId')
  int projectId;

  @JsonKey(name: 'buildId')
  int buildId;

  @JsonKey(name: 'unitId')
  int unitId;

  @JsonKey(name: 'custProper')
  String custProper;

  @JsonKey(name: 'settleStatus')
  String settleStatus;

  @JsonKey(name: 'repossessTime')
  String repossessTime;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'isDefaultProject')
  String isDefaultProject;

  @JsonKey(name: 'isDefaultHouse')
  String isDefaultHouse;

  @JsonKey(name: 'creator')
  String creator;

  @JsonKey(name: 'projectName')
  String projectName;

  @JsonKey(name: 'formerName')
  String formerName;

  @JsonKey(name: 'buildName')
  String buildName;

  @JsonKey(name: 'unitName')
  String unitName;

  @JsonKey(name: 'floorName')
  String floorName;

  @JsonKey(name: 'houseNo')
  String houseNo;

  @JsonKey(name: 'custName')
  String custName;

  @JsonKey(name: 'custPhone')
  String custPhone;

  @JsonKey(name: 'custType')
  String custType;

  @JsonKey(name: 'idTypeId')
  String idTypeId;

  @JsonKey(name: 'custIdNum')
  String custIdNum;

  @JsonKey(name: 'houseCustAuditId')
  int houseCustAuditId;

  @JsonKey(name: 'auditDesc')
  String auditDesc;

  @JsonKey(name: 'matchType')
  String matchType;

  @JsonKey(name: 'floorId')
  int floorId;

  @JsonKey(name: 'createTime')
  String createTime;

  @JsonKey(name: 'creatorId')
  int creatorId;

  HouseInfo({
    this.custHouseRelationId,
    this.custId,
    this.houseId,
    this.projectId,
    this.buildId,
    this.unitId,
    this.custProper,
    this.settleStatus,
    this.repossessTime,
    this.status,
    this.isDefaultProject,
    this.isDefaultHouse,
    this.creator,
    this.projectName,
    this.buildName,
    this.unitName,
    this.floorName,
    this.houseNo,
    this.custName,
    this.custPhone,
    this.auditStatus,
    this.custType,
    this.houseCustAuditId,
    this.custIdNum,
    this.idTypeId,
    this.auditDesc,
    this.createTime,
    this.floorId,
    this.creatorId,
    this.matchType,
    this.formerName,
  });

  factory HouseInfo.fromJson(Map<String, dynamic> srcJson) => _$HouseInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HouseInfoToJson(this);
}

@JsonSerializable()
class MemberInfo extends Object {
  @JsonKey(name: 'custHouseRelationId')
  int custHouseRelationId;

  @JsonKey(name: 'custId')
  int custId;

  @JsonKey(name: 'houseId')
  int houseId;

  @JsonKey(name: 'projectId')
  int projectId;

  @JsonKey(name: 'buildId')
  int buildId;

  @JsonKey(name: 'unitId')
  int unitId;

  @JsonKey(name: 'custProper')
  String custProper;

  @JsonKey(name: 'settleStatus')
  String settleStatus;

  @JsonKey(name: 'settleInTime')
  String settleInTime;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'isDefaultProject')
  String isDefaultProject;

  @JsonKey(name: 'isDefaultHouse')
  String isDefaultHouse;

  @JsonKey(name: 'projectName')
  String projectName;

  @JsonKey(name: 'buildName')
  String buildName;

  @JsonKey(name: 'unitName')
  String unitName;

  @JsonKey(name: 'floorName')
  String floorName;

  @JsonKey(name: 'houseNo')
  String houseNo;

  @JsonKey(name: 'custName')
  String custName;

  @JsonKey(name: 'custPhone')
  String custPhone;

  MemberInfo(
    this.custHouseRelationId,
    this.custId,
    this.houseId,
    this.projectId,
    this.buildId,
    this.unitId,
    this.custProper,
    this.settleStatus,
    this.settleInTime,
    this.status,
    this.isDefaultProject,
    this.isDefaultHouse,
    this.projectName,
    this.buildName,
    this.unitName,
    this.floorName,
    this.houseNo,
    this.custName,
    this.custPhone,
  );

  factory MemberInfo.fromJson(Map<String, dynamic> srcJson) => _$MemberInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MemberInfoToJson(this);
}
