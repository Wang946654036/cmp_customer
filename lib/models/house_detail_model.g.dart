// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'house_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HouseDetailModel _$HouseDetailModelFromJson(Map<String, dynamic> json) {
  return HouseDetailModel(
    json['code'] as String,
    json['message'] as String,
    json['systemDate'] as String,
    json['data'] == null
        ? null
        : HouseDetail.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$HouseDetailModelToJson(HouseDetailModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'systemDate': instance.systemDate,
      'data': instance.houseDetail,
    };

HouseDetail _$HouseDetailFromJson(Map<String, dynamic> json) {
  return HouseDetail(
    certifiedHouseInfo: json['myHouseRelationVoApp'] == null
        ? null
        : HouseInfo.fromJson(
            json['myHouseRelationVoApp'] as Map<String, dynamic>),
    unCertifiedHouseInfo: json['houseCustAuditVoApp'] == null
        ? null
        : HouseInfo.fromJson(
            json['houseCustAuditVoApp'] as Map<String, dynamic>),
    memberList: (json['custHouseRelationVoAppList'] as List)
        ?.map((e) =>
            e == null ? null : MemberInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$HouseDetailToJson(HouseDetail instance) =>
    <String, dynamic>{
      'myHouseRelationVoApp': instance.certifiedHouseInfo,
      'houseCustAuditVoApp': instance.unCertifiedHouseInfo,
      'custHouseRelationVoAppList': instance.memberList,
    };

HouseInfo _$HouseInfoFromJson(Map<String, dynamic> json) {
  return HouseInfo(
    custHouseRelationId: json['custHouseRelationId'] as int,
    custId: json['custId'] as int,
    houseId: json['houseId'] as int,
    projectId: json['projectId'] as int,
    buildId: json['buildId'] as int,
    unitId: json['unitId'] as int,
    custProper: json['custProper'] as String,
    settleStatus: json['settleStatus'] as String,
    repossessTime: json['repossessTime'] as String,
    status: json['status'] as String,
    isDefaultProject: json['isDefaultProject'] as String,
    isDefaultHouse: json['isDefaultHouse'] as String,
    creator: json['creator'] as String,
    projectName: json['projectName'] as String,
    buildName: json['buildName'] as String,
    unitName: json['unitName'] as String,
    floorName: json['floorName'] as String,
    houseNo: json['houseNo'] as String,
    custName: json['custName'] as String,
    custPhone: json['custPhone'] as String,
    auditStatus: json['auditStatus'] as String,
    custType: json['custType'] as String,
    houseCustAuditId: json['houseCustAuditId'] as int,
    custIdNum: json['custIdNum'] as String,
    idTypeId: json['idTypeId'] as String,
    auditDesc: json['auditDesc'] as String,
    createTime: json['createTime'] as String,
    floorId: json['floorId'] as int,
    creatorId: json['creatorId'] as int,
    matchType: json['matchType'] as String,
    formerName: json['formerName'] as String,
  );
}

Map<String, dynamic> _$HouseInfoToJson(HouseInfo instance) => <String, dynamic>{
      'auditStatus': instance.auditStatus,
      'custHouseRelationId': instance.custHouseRelationId,
      'custId': instance.custId,
      'houseId': instance.houseId,
      'projectId': instance.projectId,
      'buildId': instance.buildId,
      'unitId': instance.unitId,
      'custProper': instance.custProper,
      'settleStatus': instance.settleStatus,
      'repossessTime': instance.repossessTime,
      'status': instance.status,
      'isDefaultProject': instance.isDefaultProject,
      'isDefaultHouse': instance.isDefaultHouse,
      'creator': instance.creator,
      'projectName': instance.projectName,
      'formerName': instance.formerName,
      'buildName': instance.buildName,
      'unitName': instance.unitName,
      'floorName': instance.floorName,
      'houseNo': instance.houseNo,
      'custName': instance.custName,
      'custPhone': instance.custPhone,
      'custType': instance.custType,
      'idTypeId': instance.idTypeId,
      'custIdNum': instance.custIdNum,
      'houseCustAuditId': instance.houseCustAuditId,
      'auditDesc': instance.auditDesc,
      'matchType': instance.matchType,
      'floorId': instance.floorId,
      'createTime': instance.createTime,
      'creatorId': instance.creatorId,
    };

MemberInfo _$MemberInfoFromJson(Map<String, dynamic> json) {
  return MemberInfo(
    json['custHouseRelationId'] as int,
    json['custId'] as int,
    json['houseId'] as int,
    json['projectId'] as int,
    json['buildId'] as int,
    json['unitId'] as int,
    json['custProper'] as String,
    json['settleStatus'] as String,
    json['settleInTime'] as String,
    json['status'] as String,
    json['isDefaultProject'] as String,
    json['isDefaultHouse'] as String,
    json['projectName'] as String,
    json['buildName'] as String,
    json['unitName'] as String,
    json['floorName'] as String,
    json['houseNo'] as String,
    json['custName'] as String,
    json['custPhone'] as String,
  );
}

Map<String, dynamic> _$MemberInfoToJson(MemberInfo instance) =>
    <String, dynamic>{
      'custHouseRelationId': instance.custHouseRelationId,
      'custId': instance.custId,
      'houseId': instance.houseId,
      'projectId': instance.projectId,
      'buildId': instance.buildId,
      'unitId': instance.unitId,
      'custProper': instance.custProper,
      'settleStatus': instance.settleStatus,
      'settleInTime': instance.settleInTime,
      'status': instance.status,
      'isDefaultProject': instance.isDefaultProject,
      'isDefaultHouse': instance.isDefaultHouse,
      'projectName': instance.projectName,
      'buildName': instance.buildName,
      'unitName': instance.unitName,
      'floorName': instance.floorName,
      'houseNo': instance.houseNo,
      'custName': instance.custName,
      'custPhone': instance.custPhone,
    };
