// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'house_all_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HouseAllModel _$HouseAllModelFromJson(Map<String, dynamic> json) {
  return HouseAllModel(
    (json['appCodes'] as List)?.map((e) => e as String)?.toList(),
    json['code'] as String,
    json['data'] == null
        ? null
        : HouseData.fromJson(json['data'] as Map<String, dynamic>),
    json['extStr'] as String,
    json['message'] as String,
    json['systemDate'] as String,
    json['totalCount'] as int,
  );
}

Map<String, dynamic> _$HouseAllModelToJson(HouseAllModel instance) =>
    <String, dynamic>{
      'appCodes': instance.appCodes,
      'code': instance.code,
      'data': instance.houseData,
      'extStr': instance.extStr,
      'message': instance.message,
      'systemDate': instance.systemDate,
      'totalCount': instance.totalCount,
    };

HouseData _$HouseDataFromJson(Map<String, dynamic> json) {
  return HouseData(
    (json['custLoginAfterDtoList'] as List)
        ?.map((e) => e == null
            ? null
            : HouseCertified.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['houseCustAuditVoAppList'] as List)
        ?.map((e) => e == null
            ? null
            : HouseCertificating.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$HouseDataToJson(HouseData instance) => <String, dynamic>{
      'custLoginAfterDtoList': instance.houseCertifiedList,
      'houseCustAuditVoAppList': instance.houseCertificatingList,
    };

HouseCertified _$HouseCertifiedFromJson(Map<String, dynamic> json) {
  return HouseCertified(
    json['buildId'] as int,
    json['buildName'] as String,
    json['createTime'] as String,
    json['creator'] as String,
    json['creatorId'] as int,
    json['custHouseRelationId'] as int,
    json['custId'] as int,
    json['custProper'] as String,
    json['floorName'] as String,
    json['houseId'] as int,
    json['houseNo'] as String,
    json['isDefaultHouse'] as String,
    json['isDefaultProject'] as String,
    json['memberNumber'] as String,
    json['projectId'] as int,
    json['projectName'] as String,
    json['rentEndTime'] as String,
    json['rentStartTime'] as String,
    json['repossessTime'] as String,
    json['settleInTime'] as String,
    json['settleStatus'] as String,
    json['status'] as String,
    json['unitId'] as int,
    json['unitName'] as String,
    json['updateTime'] as String,
    json['updator'] as String,
    json['updatorId'] as int,
    json['auditStatus'] as String,
    json['formerName'] as String,
  )..houseType = _$enumDecodeNullable(_$HouseTypeEnumMap, json['houseType']);
}

Map<String, dynamic> _$HouseCertifiedToJson(HouseCertified instance) =>
    <String, dynamic>{
      'houseType': _$HouseTypeEnumMap[instance.houseType],
      'buildId': instance.buildId,
      'buildName': instance.buildName,
      'createTime': instance.createTime,
      'creator': instance.creator,
      'creatorId': instance.creatorId,
      'custHouseRelationId': instance.custHouseRelationId,
      'custId': instance.custId,
      'custProper': instance.custProper,
      'floorName': instance.floorName,
      'houseId': instance.houseId,
      'houseNo': instance.houseNo,
      'isDefaultHouse': instance.isDefaultHouse,
      'isDefaultProject': instance.isDefaultProject,
      'memberNumber': instance.memberNumber,
      'projectId': instance.projectId,
      'projectName': instance.projectName,
      'formerName': instance.formerName,
      'rentEndTime': instance.rentEndTime,
      'rentStartTime': instance.rentStartTime,
      'repossessTime': instance.repossessTime,
      'settleInTime': instance.settleInTime,
      'settleStatus': instance.settleStatus,
      'status': instance.status,
      'unitId': instance.unitId,
      'unitName': instance.unitName,
      'updateTime': instance.updateTime,
      'updator': instance.updator,
      'updatorId': instance.updatorId,
      'auditStatus': instance.auditStatus,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$HouseTypeEnumMap = {
  HouseType.Certified: 'Certified',
  HouseType.Certificating: 'Certificating',
};

HouseCertificating _$HouseCertificatingFromJson(Map<String, dynamic> json) {
  return HouseCertificating(
    json['auditDesc'] as String,
    json['auditStatus'] as String,
    json['auditTime'] as String,
    json['auditor'] as String,
    json['auditorId'] as int,
    json['buildId'] as int,
    json['buildName'] as String,
    json['commitDesc'] as String,
    json['createTime'] as String,
    json['creator'] as String,
    json['creatorId'] as int,
    json['custId'] as int,
    json['custIdNum'] as String,
    json['custName'] as String,
    json['custPhone'] as String,
    json['custProper'] as String,
    json['custType'] as String,
    json['floorId'] as int,
    json['houseCustAuditId'] as int,
    json['houseId'] as int,
    json['houseNo'] as String,
    json['idTypeId'] as String,
    json['matchType'] as String,
    json['projectId'] as int,
    json['projectName'] as String,
    json['unitId'] as int,
    json['unitName'] as String,
    json['formerName'] as String,
  )..houseType = _$enumDecodeNullable(_$HouseTypeEnumMap, json['houseType']);
}

Map<String, dynamic> _$HouseCertificatingToJson(HouseCertificating instance) =>
    <String, dynamic>{
      'houseType': _$HouseTypeEnumMap[instance.houseType],
      'auditDesc': instance.auditDesc,
      'auditStatus': instance.auditStatus,
      'auditTime': instance.auditTime,
      'auditor': instance.auditor,
      'auditorId': instance.auditorId,
      'buildId': instance.buildId,
      'buildName': instance.buildName,
      'commitDesc': instance.commitDesc,
      'createTime': instance.createTime,
      'creator': instance.creator,
      'creatorId': instance.creatorId,
      'custId': instance.custId,
      'custIdNum': instance.custIdNum,
      'custName': instance.custName,
      'custPhone': instance.custPhone,
      'custProper': instance.custProper,
      'custType': instance.custType,
      'floorId': instance.floorId,
      'houseCustAuditId': instance.houseCustAuditId,
      'houseId': instance.houseId,
      'houseNo': instance.houseNo,
      'idTypeId': instance.idTypeId,
      'matchType': instance.matchType,
      'projectId': instance.projectId,
      'projectName': instance.projectName,
      'formerName': instance.formerName,
      'unitId': instance.unitId,
      'unitName': instance.unitName,
    };
