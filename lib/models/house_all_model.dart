import 'package:cmp_customer/ui/house_authentication/my_house_page.dart';
import 'package:json_annotation/json_annotation.dart';

part 'house_all_model.g.dart';

@JsonSerializable()
class HouseAllModel extends Object {
  @JsonKey(name: 'appCodes')
  List<String> appCodes;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'data')
  HouseData houseData;

  @JsonKey(name: 'extStr')
  String extStr;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'totalCount')
  int totalCount;

  HouseAllModel(
    this.appCodes,
    this.code,
    this.houseData,
    this.extStr,
    this.message,
    this.systemDate,
    this.totalCount,
  );

  factory HouseAllModel.fromJson(Map<String, dynamic> srcJson) => _$HouseAllModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HouseAllModelToJson(this);
}

@JsonSerializable()
class HouseData extends Object {
  @JsonKey(name: 'custLoginAfterDtoList')
  List<HouseCertified> houseCertifiedList;

  @JsonKey(name: 'houseCustAuditVoAppList')
  List<HouseCertificating> houseCertificatingList;

  HouseData(
    this.houseCertifiedList,
    this.houseCertificatingList,
  );

  factory HouseData.fromJson(Map<String, dynamic> srcJson) => _$HouseDataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HouseDataToJson(this);
}

@JsonSerializable()
class HouseCertified extends Object {
  HouseType houseType;

  @JsonKey(name: 'buildId')
  int buildId;

  @JsonKey(name: 'buildName')
  String buildName;

  @JsonKey(name: 'createTime')
  String createTime;

  @JsonKey(name: 'creator')
  String creator;

  @JsonKey(name: 'creatorId')
  int creatorId;

  @JsonKey(name: 'custHouseRelationId')
  int custHouseRelationId; //已认证的房屋用

  @JsonKey(name: 'custId')
  int custId;

  @JsonKey(name: 'custProper')
  String custProper;

  @JsonKey(name: 'floorName')
  String floorName;

  @JsonKey(name: 'houseId')
  int houseId;

  @JsonKey(name: 'houseNo')
  String houseNo;

  //0-非默认房屋，1-默认房屋
  @JsonKey(name: 'isDefaultHouse')
  String isDefaultHouse;

  @JsonKey(name: 'isDefaultProject')
  String isDefaultProject;

  @JsonKey(name: 'memberNumber')
  String memberNumber;

  @JsonKey(name: 'projectId')
  int projectId;

  @JsonKey(name: 'projectName')
  String projectName;

  @JsonKey(name: 'formerName')
  String formerName;

  @JsonKey(name: 'rentEndTime')
  String rentEndTime;

  @JsonKey(name: 'rentStartTime')
  String rentStartTime;

  @JsonKey(name: 'repossessTime')
  String repossessTime;

  @JsonKey(name: 'settleInTime')
  String settleInTime;

  @JsonKey(name: 'settleStatus')
  String settleStatus;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'unitId')
  int unitId;

  @JsonKey(name: 'unitName')
  String unitName;

  @JsonKey(name: 'updateTime')
  String updateTime;

  @JsonKey(name: 'updator')
  String updator;

  @JsonKey(name: 'updatorId')
  int updatorId;

  @JsonKey(name: 'auditStatus')
  String auditStatus;

  HouseCertified(
    this.buildId,
    this.buildName,
    this.createTime,
    this.creator,
    this.creatorId,
    this.custHouseRelationId,
    this.custId,
    this.custProper,
    this.floorName,
    this.houseId,
    this.houseNo,
    this.isDefaultHouse,
    this.isDefaultProject,
    this.memberNumber,
    this.projectId,
    this.projectName,
    this.rentEndTime,
    this.rentStartTime,
    this.repossessTime,
    this.settleInTime,
    this.settleStatus,
    this.status,
    this.unitId,
    this.unitName,
    this.updateTime,
    this.updator,
    this.updatorId,
    this.auditStatus,
    this.formerName,
  );

  factory HouseCertified.fromJson(Map<String, dynamic> srcJson) => _$HouseCertifiedFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HouseCertifiedToJson(this);
}

@JsonSerializable()
class HouseCertificating extends Object {
  HouseType houseType;

  @JsonKey(name: 'auditDesc')
  String auditDesc;

  @JsonKey(name: 'auditStatus')
  String auditStatus;

  @JsonKey(name: 'auditTime')
  String auditTime;

  @JsonKey(name: 'auditor')
  String auditor;

  @JsonKey(name: 'auditorId')
  int auditorId;

  @JsonKey(name: 'buildId')
  int buildId;

  @JsonKey(name: 'buildName')
  String buildName;

  @JsonKey(name: 'commitDesc')
  String commitDesc;

  @JsonKey(name: 'createTime')
  String createTime;

  @JsonKey(name: 'creator')
  String creator;

  @JsonKey(name: 'creatorId')
  int creatorId;

  @JsonKey(name: 'custId')
  int custId;

  @JsonKey(name: 'custIdNum')
  String custIdNum;

  @JsonKey(name: 'custName')
  String custName;

  @JsonKey(name: 'custPhone')
  String custPhone;

  @JsonKey(name: 'custProper')
  String custProper;

  @JsonKey(name: 'custType')
  String custType;

  @JsonKey(name: 'floorId')
  int floorId;

  @JsonKey(name: 'houseCustAuditId')
  int houseCustAuditId;

  @JsonKey(name: 'houseId')
  int houseId;

  @JsonKey(name: 'houseNo')
  String houseNo;

  @JsonKey(name: 'idTypeId')
  String idTypeId;

  @JsonKey(name: 'matchType')
  String matchType;

  @JsonKey(name: 'projectId')
  int projectId;

  @JsonKey(name: 'projectName')
  String projectName;

  @JsonKey(name: 'formerName')
  String formerName;

  @JsonKey(name: 'unitId')
  int unitId;

  @JsonKey(name: 'unitName')
  String unitName;

  HouseCertificating(
    this.auditDesc,
    this.auditStatus,
    this.auditTime,
    this.auditor,
    this.auditorId,
    this.buildId,
    this.buildName,
    this.commitDesc,
    this.createTime,
    this.creator,
    this.creatorId,
    this.custId,
    this.custIdNum,
    this.custName,
    this.custPhone,
    this.custProper,
    this.custType,
    this.floorId,
    this.houseCustAuditId,
    this.houseId,
    this.houseNo,
    this.idTypeId,
    this.matchType,
    this.projectId,
    this.projectName,
    this.unitId,
    this.unitName,
    this.formerName,
  );

  factory HouseCertificating.fromJson(Map<String, dynamic> srcJson) => _$HouseCertificatingFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HouseCertificatingToJson(this);
}
