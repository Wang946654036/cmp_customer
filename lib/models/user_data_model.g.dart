// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDataModel _$UserDataModelFromJson(Map<String, dynamic> json) {
  return UserDataModel(
    (json['appCodes'] as List)?.map((e) => e as String)?.toList(),
    json['code'] as String,
    json['data'] == null
        ? null
        : UserInfo.fromJson(json['data'] as Map<String, dynamic>),
    json['extStr'] as String,
    json['message'] as String,
    json['systemDate'] as String,
    json['totalCount'] as int,
  );
}

Map<String, dynamic> _$UserDataModelToJson(UserDataModel instance) =>
    <String, dynamic>{
      'appCodes': instance.appCodes,
      'code': instance.code,
      'data': instance.userInfo,
      'extStr': instance.extStr,
      'message': instance.message,
      'systemDate': instance.systemDate,
      'totalCount': instance.totalCount,
    };

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) {
  return UserInfo(
    json['custBirth'] as String,
    json['custCode'] as String,
    json['custId'] as int,
    json['custKind'] as String,
    (json['custLoginAfterDtoList'] as List)
        ?.map((e) =>
            e == null ? null : HouseInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['custLoginAfterDtoListNotDefault'] as List)
        ?.map((e) =>
            e == null ? null : HouseInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['custName'] as String,
    json['custPhone'] as String,
    json['custType'] as String,
    json['customerAppInfo'] == null
        ? null
        : CustomerAppInfo.fromJson(
            json['customerAppInfo'] as Map<String, dynamic>),
    json['gender'] as String,
    json['marriageStatus'] as String,
    json['personalityDesc'] as String,
    json['platformStatus'] as int,
    json['renantRelationId'] as int,
    json['status'] as String,
    json['vipLevel'] as String,
    (json['managementNoticeVoList'] as List)
        ?.map((e) => e == null
            ? null
            : PropertyNotice.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['alldayTel'] as String,
    json['custPhoto'] as String,
    (json['customerMenuVoList'] as List)
        ?.map((e) =>
            e == null ? null : MenuInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'custBirth': instance.custBirth,
      'custCode': instance.custCode,
      'custPhoto': instance.custPhoto,
      'custId': instance.custId,
      'custKind': instance.custKind,
      'custLoginAfterDtoList': instance.houseDefaultCommunityList,
      'custLoginAfterDtoListNotDefault': instance.houseAllList,
      'custName': instance.custName,
      'custPhone': instance.custPhone,
      'custType': instance.custType,
      'customerAppInfo': instance.customerAppInfo,
      'gender': instance.gender,
      'marriageStatus': instance.marriageStatus,
      'personalityDesc': instance.personalityDesc,
      'platformStatus': instance.platformStatus,
      'renantRelationId': instance.renantRelationId,
      'status': instance.status,
      'vipLevel': instance.vipLevel,
      'alldayTel': instance.alldayTel,
      'managementNoticeVoList': instance.propertyNoticeList,
      'customerMenuVoList': instance.menuList,
    };

HouseInfo _$HouseInfoFromJson(Map<String, dynamic> json) {
  return HouseInfo(
    buildId: json['buildId'] as int,
    buildName: json['buildName'] as String,
    createTime: json['createTime'] as String,
    creator: json['creator'] as String,
    creatorId: json['creatorId'] as int,
    custHouseRelationId: json['custHouseRelationId'] as int,
    custId: json['custId'] as int,
    custProper: json['custProper'] as String,
    floorName: json['floorName'] as String,
    houseId: json['houseId'] as int,
    houseNo: json['houseNo'] as String,
    isDefaultHouse: json['isDefaultHouse'] as String,
    isDefaultProject: json['isDefaultProject'] as String,
    memberNumber: json['memberNumber'] as String,
    projectId: json['projectId'] as int,
    projectName: json['projectName'] as String,
    rentEndTime: json['rentEndTime'] as String,
    rentStartTime: json['rentStartTime'] as String,
    repossessTime: json['repossessTime'] as String,
    settleInTime: json['settleInTime'] as String,
    settleStatus: json['settleStatus'] as String,
    status: json['status'] as String,
    unitId: json['unitId'] as int,
    unitName: json['unitName'] as String,
    updateTime: json['updateTime'] as String,
    updator: json['updator'] as String,
    updatorId: json['updatorId'] as int,
    buildType: json['buildType'] as String,
    custName: json['custName'] as String,
    custPhone: json['custPhone'] as String,
    formerName: json['formerName'] as String,
  )..selected = json['selected'] as bool;
}

Map<String, dynamic> _$HouseInfoToJson(HouseInfo instance) => <String, dynamic>{
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
      'buildType': instance.buildType,
      'updatorId': instance.updatorId,
      'custName': instance.custName,
      'custPhone': instance.custPhone,
      'selected': instance.selected,
    };

PropertyNotice _$PropertyNoticeFromJson(Map<String, dynamic> json) {
  return PropertyNotice(
    (json['attachmentList'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['content'] as String,
    json['id'] as int,
    json['isTimed'] as int,
    (json['noticeScopeList'] as List)
        ?.map((e) =>
            e == null ? null : NoticeScope.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['orgId'] as int,
    json['scopeIds'] as String,
    json['sendScope'] as int,
    json['sendTarget'] as int,
    json['sendTime'] as String,
    json['sendUser'] as int,
    json['status'] as int,
    json['submitTime'] as String,
    json['suggestion'] as String,
    json['title'] as String,
    json['type'] as int,
  );
}

Map<String, dynamic> _$PropertyNoticeToJson(PropertyNotice instance) =>
    <String, dynamic>{
      'attachmentList': instance.attachmentList,
      'content': instance.content,
      'id': instance.id,
      'isTimed': instance.isTimed,
      'noticeScopeList': instance.noticeScopeList,
      'orgId': instance.orgId,
      'scopeIds': instance.scopeIds,
      'sendScope': instance.sendScope,
      'sendTarget': instance.sendTarget,
      'sendTime': instance.sendTime,
      'sendUser': instance.sendUser,
      'status': instance.status,
      'submitTime': instance.submitTime,
      'suggestion': instance.suggestion,
      'title': instance.title,
      'type': instance.type,
    };

Attachment _$AttachmentFromJson(Map<String, dynamic> json) {
  return Attachment(
    attachmentName: json['attachmentName'] as String,
    attachmentType: json['attachmentType'] as String,
    attachmentUuid: json['attachmentUuid'] as String,
    createTime: json['createTime'] as String,
    id: json['id'] as int,
    relatedId: json['relatedId'] as int,
    source: json['source'] as String,
    status: json['status'] as String,
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$AttachmentToJson(Attachment instance) =>
    <String, dynamic>{
      'attachmentName': instance.attachmentName,
      'attachmentType': instance.attachmentType,
      'attachmentUuid': instance.attachmentUuid,
      'createTime': instance.createTime,
      'id': instance.id,
      'relatedId': instance.relatedId,
      'source': instance.source,
      'status': instance.status,
      'type': instance.type,
    };

NoticeScope _$NoticeScopeFromJson(Map<String, dynamic> json) {
  return NoticeScope(
    json['receiveId'] as int,
    json['receiveName'] as String,
    json['receiveType'] as int,
  );
}

Map<String, dynamic> _$NoticeScopeToJson(NoticeScope instance) =>
    <String, dynamic>{
      'receiveId': instance.receiveId,
      'receiveName': instance.receiveName,
      'receiveType': instance.receiveType,
    };

CustomerAppInfo _$CustomerAppInfoFromJson(Map<String, dynamic> json) {
  return CustomerAppInfo(
    json['birthDate'] as String,
    json['custEnabled'] as bool,
    json['customerType'] as int,
    json['id'] as int,
    json['mobile'] as String,
    json['realname'] as String,
    (json['roleIds'] as List)?.map((e) => e as int)?.toList(),
    (json['roleInfoList'] as List)
        ?.map((e) =>
            e == null ? null : RoleInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['sex'] as int,
    json['signature'] as String,
    json['nickname'] as String,
  );
}

Map<String, dynamic> _$CustomerAppInfoToJson(CustomerAppInfo instance) =>
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
      'nickname': instance.nickname,
    };

RoleInfo _$RoleInfoFromJson(Map<String, dynamic> json) {
  return RoleInfo(
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

Map<String, dynamic> _$RoleInfoToJson(RoleInfo instance) => <String, dynamic>{
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

MenuInfo _$MenuInfoFromJson(Map<String, dynamic> json) {
  return MenuInfo(
    json['id'] as int,
    json['resourceName'] as String,
    json['relationType'] as String,
    json['linkUrl'] as String,
    json['type'] as int,
    json['enabled'] as bool,
    json['childrenType'] as int,
    (json['childrenList'] as List)
        ?.map((e) =>
            e == null ? null : MenuInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['icon'] as String,
    json['subTitle'] as String,
    json['order_no'] as int,
  )..parentId = json['parentId'] as int;
}

Map<String, dynamic> _$MenuInfoToJson(MenuInfo instance) => <String, dynamic>{
      'id': instance.id,
      'resourceName': instance.resourceName,
      'relationType': instance.relationType,
      'linkUrl': instance.linkUrl,
      'icon': instance.icon,
      'subTitle': instance.subTitle,
      'type': instance.type,
      'parentId': instance.parentId,
      'enabled': instance.enabled,
      'childrenType': instance.childrenType,
      'order_no': instance.orderNo,
      'childrenList': instance.children,
    };
