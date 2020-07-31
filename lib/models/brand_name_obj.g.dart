// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_name_obj.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrandNameObj _$BrandNameObjFromJson(Map<String, dynamic> json) {
  return BrandNameObj(
    (json['appCodes'] as List)?.map((e) => e as String)?.toList(),
    json['code'] as String,
    json['data'] == null
        ? null
        : BrandNameInfo.fromJson(json['data'] as Map<String, dynamic>),
    json['extStr'] as String,
    json['message'] as String,
    json['systemDate'] as String,
    json['totalCount'] as int,
  );
}

Map<String, dynamic> _$BrandNameObjToJson(BrandNameObj instance) =>
    <String, dynamic>{
      'appCodes': instance.appCodes,
      'code': instance.code,
      'data': instance.brandNameInfo,
      'extStr': instance.extStr,
      'message': instance.message,
      'systemDate': instance.systemDate,
      'totalCount': instance.totalCount,
    };

BrandNameInfo _$BrandNameInfoFromJson(Map<String, dynamic> json) {
  return BrandNameInfo(
    spSettingList: (json['spSettingList'] as List)
        ?.map((e) =>
            e == null ? null : SettingList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    mpSettingList: (json['mpSettingList'] as List)
        ?.map((e) =>
            e == null ? null : SettingList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    applyManHouseProper: json['applyManHouseProper'] as String,
    applyManHouseProperName: json['applyManHouseProperName'] as String,
    applyManId: json['applyManId'] as int,
    applyManName: json['applyManName'] as String,
    applyManPhone: json['applyManPhone'] as String,
    applyType: json['applyType'] as String,
    applyTypeName: json['applyTypeName'] as String,
    attList: (json['attList'] as List)
        ?.map((e) =>
            e == null ? null : AttList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    brandNameId: json['brandNameId'] as int,
    buildId: json['buildId'] as int,
    buildName: json['buildName'] as String,
    businessNo: json['businessNo'] as String,
    createTime: json['createTime'] as String,
    houseId: json['houseId'] as int,
    houseNo: json['houseNo'] as String,
    mpApplyCount: json['mpApplyCount'] as int,
    mpContent: json['mpContent'] as String,
    operateStep: json['operateStep'] as String,
    operateStepName: json['operateStepName'] as String,
    payFees: (json['payFees'] as num)?.toDouble(),
    paymentTime: json['paymentTime'] as String,
    projectId: json['projectId'] as int,
    projectName: json['projectName'] as String,
    recordList: (json['recordList'] as List)
        ?.map((e) =>
            e == null ? null : RecordList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    remark: json['remark'] as String,
    settingId: json['settingId'] as int,
    settingList: (json['settingList'] as List)
        ?.map((e) =>
            e == null ? null : SettingList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    shouldPayMoney: (json['shouldPayMoney'] as num)?.toDouble(),
    spApplyCount: json['spApplyCount'] as int,
    spContent: json['spContent'] as String,
    status: json['status'] as String,
    statusName: json['statusName'] as String,
    unitId: json['unitId'] as int,
    unitName: json['unitName'] as String,
    updateTime: json['updateTime'] as String,
    useTime: json['useTime'] as String,
  );
}

Map<String, dynamic> _$BrandNameInfoToJson(BrandNameInfo instance) =>
    <String, dynamic>{
      'applyManHouseProper': instance.applyManHouseProper,
      'applyManHouseProperName': instance.applyManHouseProperName,
      'applyManId': instance.applyManId,
      'applyManName': instance.applyManName,
      'applyManPhone': instance.applyManPhone,
      'applyType': instance.applyType,
      'applyTypeName': instance.applyTypeName,
      'attList': instance.attList,
      'brandNameId': instance.brandNameId,
      'buildId': instance.buildId,
      'buildName': instance.buildName,
      'businessNo': instance.businessNo,
      'createTime': instance.createTime,
      'houseId': instance.houseId,
      'houseNo': instance.houseNo,
      'mpApplyCount': instance.mpApplyCount,
      'mpContent': instance.mpContent,
      'operateStep': instance.operateStep,
      'operateStepName': instance.operateStepName,
      'payFees': instance.payFees,
      'paymentTime': instance.paymentTime,
      'projectId': instance.projectId,
      'projectName': instance.projectName,
      'recordList': instance.recordList,
      'remark': instance.remark,
      'settingId': instance.settingId,
      'settingList': instance.settingList,
      'spSettingList': instance.spSettingList,
      'mpSettingList': instance.mpSettingList,
      'shouldPayMoney': instance.shouldPayMoney,
      'spApplyCount': instance.spApplyCount,
      'spContent': instance.spContent,
      'status': instance.status,
      'statusName': instance.statusName,
      'unitId': instance.unitId,
      'unitName': instance.unitName,
      'updateTime': instance.updateTime,
      'useTime': instance.useTime,
    };

AttList _$AttListFromJson(Map<String, dynamic> json) {
  return AttList(
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

Map<String, dynamic> _$AttListToJson(AttList instance) => <String, dynamic>{
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

SettingList _$SettingListFromJson(Map<String, dynamic> json) {
  return SettingList(
    attsCount: json['attsCount'] as int,
    createTime: json['createTime'] as String,
    creatorId: json['creatorId'] as int,
    isCustChoose: json['isCustChoose'] as String,
    markPrice: (json['markPrice'] as num)?.toDouble(),
    photoAttList: (json['photoAttList'] as List)
        ?.map((e) =>
            e == null ? null : PhotoAttList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    projectSimpleVoList: (json['projectSimpleVoList'] as List)
        ?.map((e) => e == null
            ? null
            : ProjectSimpleVoList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    settingDesc: json['settingDesc'] as String,
    settingId: json['settingId'] as int,
    settingTitle: json['settingTitle'] as String,
    settingTyepName: json['settingTyepName'] as String,
    settingType: json['settingType'] as String,
    status: json['status'] as String,
    updateTime: json['updateTime'] as String,
    updaterId: json['updaterId'] as int,
  );
}

Map<String, dynamic> _$SettingListToJson(SettingList instance) =>
    <String, dynamic>{
      'attsCount': instance.attsCount,
      'createTime': instance.createTime,
      'creatorId': instance.creatorId,
      'isCustChoose': instance.isCustChoose,
      'markPrice': instance.markPrice,
      'photoAttList': instance.photoAttList,
      'projectSimpleVoList': instance.projectSimpleVoList,
      'settingDesc': instance.settingDesc,
      'settingId': instance.settingId,
      'settingTitle': instance.settingTitle,
      'settingTyepName': instance.settingTyepName,
      'settingType': instance.settingType,
      'status': instance.status,
      'updateTime': instance.updateTime,
      'updaterId': instance.updaterId,
    };

PhotoAttList _$PhotoAttListFromJson(Map<String, dynamic> json) {
  return PhotoAttList(
    json['attachmentName'] as String,
    json['attachmentType'] as String,
    json['attachmentUuid'] as String,
    json['createTime'] as String,
    json['id'] as int,
    json['relatedId'] as int,
    json['source'] as String,
    json['status'] as String,
    json['type'] as String,
  );
}

Map<String, dynamic> _$PhotoAttListToJson(PhotoAttList instance) =>
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

ProjectSimpleVoList _$ProjectSimpleVoListFromJson(Map<String, dynamic> json) {
  return ProjectSimpleVoList(
    json['projectId'] as int,
    json['projectName'] as String,
  );
}

Map<String, dynamic> _$ProjectSimpleVoListToJson(
        ProjectSimpleVoList instance) =>
    <String, dynamic>{
      'projectId': instance.projectId,
      'projectName': instance.projectName,
    };
