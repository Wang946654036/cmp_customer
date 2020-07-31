// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tourist_account_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TouristAccountStatusModel _$TouristAccountStatusModelFromJson(
    Map<String, dynamic> json) {
  return TouristAccountStatusModel(
    json['code'] as String,
    json['message'] as String,
    json['systemDate'] as String,
    json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TouristAccountStatusModelToJson(
        TouristAccountStatusModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'systemDate': instance.systemDate,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    (json['customerAppInfoList'] as List)
        ?.map((e) => e == null
            ? null
            : TouristAccountStatus.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['custHouseRelationVoAppList'] as List)
        ?.map((e) =>
            e == null ? null : CustomerInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'custHouseRelationVoAppList': instance.customerList,
      'customerAppInfoList': instance.touristAccountStatusList,
    };

CustomerInfo _$CustomerInfoFromJson(Map<String, dynamic> json) {
  return CustomerInfo(
    json['custHouseRelationId'] as int,
    json['custId'] as int,
    json['houseId'] as int,
    json['projectId'] as int,
    json['buildId'] as int,
    json['unitId'] as int,
    json['custProper'] as String,
    json['settleStatus'] as String,
    json['repossessTime'] as String,
    json['status'] as String,
    json['isDefaultProject'] as String,
    json['isDefaultHouse'] as String,
    json['creator'] as String,
    json['projectName'] as String,
    json['buildName'] as String,
    json['unitName'] as String,
    json['floorName'] as String,
    json['houseNo'] as String,
    json['custName'] as String,
    json['custPhone'] as String,
  );
}

Map<String, dynamic> _$CustomerInfoToJson(CustomerInfo instance) =>
    <String, dynamic>{
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
      'buildName': instance.buildName,
      'unitName': instance.unitName,
      'floorName': instance.floorName,
      'houseNo': instance.houseNo,
      'custName': instance.custName,
      'custPhone': instance.custPhone,
    };

TouristAccountStatus _$TouristAccountStatusFromJson(Map<String, dynamic> json) {
  return TouristAccountStatus(
    json['birthDate'] as String,
    json['custEnabled'] as bool,
    json['customerType'] as int,
    json['id'] as int,
    json['mobile'] as String,
    json['realname'] as String,
    (json['roleIds'] as List)?.map((e) => e as int)?.toList(),
    (json['roleInfoList'] as List)
        ?.map((e) =>
            e == null ? null : RoleInfoList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['sex'] as int,
    json['signature'] as String,
  );
}

Map<String, dynamic> _$TouristAccountStatusToJson(
        TouristAccountStatus instance) =>
    <String, dynamic>{
      'birthDate': instance.birthDate,
      'custEnabled': instance.custEnabled,
      'customerType': instance.customerType,
      'id': instance.id,
      'mobile': instance.mobile,
      'realname': instance.realname,
      'roleIds': instance.roleIds,
      'roleInfoList': instance.roleInfoList,
      'sex': instance.sex,
      'signature': instance.signature,
    };

RoleInfoList _$RoleInfoListFromJson(Map<String, dynamic> json) {
  return RoleInfoList(
    (json['appResourceIds'] as List)?.map((e) => e as int)?.toList(),
    json['createTime'] as String,
    json['description'] as String,
    json['enabled'] as bool,
    json['enabledIds'] as String,
    json['id'] as int,
    json['orgId'] as int,
    json['orgType'] as int,
    json['orgTypeName'] as String,
    (json['resourceIds'] as List)?.map((e) => e as int)?.toList(),
    json['resources'] as String,
    json['roleCode'] as String,
    json['roleName'] as String,
    json['type'] as int,
    (json['webResourceIds'] as List)?.map((e) => e as int)?.toList(),
    json['whole'] as int,
  );
}

Map<String, dynamic> _$RoleInfoListToJson(RoleInfoList instance) =>
    <String, dynamic>{
      'appResourceIds': instance.appResourceIds,
      'createTime': instance.createTime,
      'description': instance.description,
      'enabled': instance.enabled,
      'enabledIds': instance.enabledIds,
      'id': instance.id,
      'orgId': instance.orgId,
      'orgType': instance.orgType,
      'orgTypeName': instance.orgTypeName,
      'resourceIds': instance.resourceIds,
      'resources': instance.resources,
      'roleCode': instance.roleCode,
      'roleName': instance.roleName,
      'type': instance.type,
      'webResourceIds': instance.webResourceIds,
      'whole': instance.whole,
    };
