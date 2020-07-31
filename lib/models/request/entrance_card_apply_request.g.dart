// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entrance_card_apply_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EntranceCardApplyRequest _$EntranceCardApplyRequestFromJson(
    Map<String, dynamic> json) {
  return EntranceCardApplyRequest(
    accessCardId: json['accessCardId'] as int,
    applyCount: json['applyCount'] as int,
    attHeadList:
        (json['attHeadList'] as List)?.map((e) => e as String)?.toList(),
    attSfzList: (json['attSfzList'] as List)?.map((e) => e as String)?.toList(),
    buildId: json['buildId'] as int,
    businessNo: json['businessNo'] as String,
    createTime: json['createTime'] as String,
    customerId: json['customerId'] as int,
    customerPhone: json['customerPhone'] as String,
    customerType: json['customerType'] as String,
    houseId: json['houseId'] as int,
    houseNo: json['houseNo'] as String,
    ownerId: json['ownerId'] as int,
    payFees: (json['payFees'] as num)?.toDouble(),
    projectId: json['projectId'] as int,
    reason: json['reason'] as String,
    remark: json['remark'] as String,
    settingId: json['settingId'] as int,
    status: json['status'] as String,
    unitId: json['unitId'] as int,
    updateTime: json['updateTime'] as String,
  )..attMjkfjList = (json['attMjkfjList'] as List)
      ?.map((e) =>
          e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
      ?.toList();
}

Map<String, dynamic> _$EntranceCardApplyRequestToJson(
        EntranceCardApplyRequest instance) =>
    <String, dynamic>{
      'accessCardId': instance.accessCardId,
      'applyCount': instance.applyCount,
      'attHeadList': instance.attHeadList,
      'attSfzList': instance.attSfzList,
      'attMjkfjList': instance.attMjkfjList,
      'buildId': instance.buildId,
      'businessNo': instance.businessNo,
      'createTime': instance.createTime,
      'customerId': instance.customerId,
      'customerPhone': instance.customerPhone,
      'customerType': instance.customerType,
      'houseId': instance.houseId,
      'houseNo': instance.houseNo,
      'ownerId': instance.ownerId,
      'payFees': instance.payFees,
      'projectId': instance.projectId,
      'reason': instance.reason,
      'remark': instance.remark,
      'settingId': instance.settingId,
      'status': instance.status,
      'unitId': instance.unitId,
      'updateTime': instance.updateTime,
    };
