// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_pass_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccessPassModel _$AccessPassModelFromJson(Map<String, dynamic> json) {
  return AccessPassModel(
    (json['appCodes'] as List)?.map((e) => e as String)?.toList(),
    json['code'] as String,
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : AccessPassInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['extStr'] as String,
    json['message'] as String,
    json['systemDate'] as String,
    json['totalCount'] as int,
  );
}

Map<String, dynamic> _$AccessPassModelToJson(AccessPassModel instance) =>
    <String, dynamic>{
      'appCodes': instance.appCodes,
      'code': instance.code,
      'data': instance.AccessPassList,
      'extStr': instance.extStr,
      'message': instance.message,
      'systemDate': instance.systemDate,
      'totalCount': instance.totalCount,
    };

AccessPassInfo _$AccessPassInfoFromJson(Map<String, dynamic> json) {
  return AccessPassInfo(
    json['buildId'] as int,
    json['buildName'] as String,
    json['cardType'] as String,
    json['cardTypeName'] as String,
    json['createTime'] as String,
    json['creatorId'] as int,
    json['custHouseRelationId'] as int,
    json['custIdNum'] as String,
    json['custName'] as String,
    json['custPhone'] as String,
    json['custProper'] as String,
    json['custProperName'] as String,
    json['custType'] as String,
    json['custTypeName'] as String,
    json['houseId'] as int,
    json['houseNo'] as String,
    json['id'] as int,
    json['idTypeId'] as String,
    json['idTypeIdName'] as String,
    json['mobile'] as String,
    json['projectId'] as int,
    json['projectName'] as String,
    json['qrCodeTime'] as String,
    json['status'] as String,
    json['unitId'] as int,
    json['unitName'] as String,
  );
}

Map<String, dynamic> _$AccessPassInfoToJson(AccessPassInfo instance) =>
    <String, dynamic>{
      'buildId': instance.buildId,
      'buildName': instance.buildName,
      'cardType': instance.cardType,
      'cardTypeName': instance.cardTypeName,
      'createTime': instance.createTime,
      'creatorId': instance.creatorId,
      'custHouseRelationId': instance.custHouseRelationId,
      'custIdNum': instance.custIdNum,
      'custName': instance.custName,
      'custPhone': instance.custPhone,
      'custProper': instance.custProper,
      'custProperName': instance.custProperName,
      'custType': instance.custType,
      'custTypeName': instance.custTypeName,
      'houseId': instance.houseId,
      'houseNo': instance.houseNo,
      'id': instance.id,
      'idTypeId': instance.idTypeId,
      'idTypeIdName': instance.idTypeIdName,
      'mobile': instance.mobile,
      'projectId': instance.projectId,
      'projectName': instance.projectName,
      'qrCodeTime': instance.qrCodeTime,
      'status': instance.status,
      'unitId': instance.unitId,
      'unitName': instance.unitName,
    };
