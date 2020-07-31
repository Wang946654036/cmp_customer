// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'office_cancel_lease_record_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfficeCancelLeaseRecordModel _$OfficeCancelLeaseRecordModelFromJson(
    Map<String, dynamic> json) {
  return OfficeCancelLeaseRecordModel(
    (json['appCodes'] as List)?.map((e) => e as String)?.toList(),
    json['code'] as String,
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : OfficeCancelLeaseInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['extStr'] as String,
    json['message'] as String,
    json['systemDate'] as String,
    json['totalCount'] as int,
  );
}

Map<String, dynamic> _$OfficeCancelLeaseRecordModelToJson(
        OfficeCancelLeaseRecordModel instance) =>
    <String, dynamic>{
      'appCodes': instance.appCodes,
      'code': instance.code,
      'data': instance.officeCancelLeaseList,
      'extStr': instance.extStr,
      'message': instance.message,
      'systemDate': instance.systemDate,
      'totalCount': instance.totalCount,
    };

OfficeCancelLeaseInfo _$OfficeCancelLeaseInfoFromJson(
    Map<String, dynamic> json) {
  return OfficeCancelLeaseInfo(
    (json['attApplyList'] as List)?.map((e) => e as String)?.toList(),
    (json['attRectifyList'] as List)?.map((e) => e as String)?.toList(),
    (json['attSubmitList'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['buildIds'] as String,
    json['buildNames'] as String,
    json['businessNo'] as String,
    json['checkTime'] as String,
    json['createTime'] as String,
    json['custIds'] as String,
    json['custNames'] as String,
    json['customerId'] as int,
    json['customerName'] as String,
    json['customerTel'] as String,
    json['customerType'] as String,
    json['houseIds'] as String,
    json['houseNos'] as String,
    json['officeSurrenderId'] as int,
    json['operateStep'] as String,
    json['participatePerson'] as String,
    json['payMoney'] as String,
    json['projectId'] as int,
    json['projectName'] as String,
    (json['recordList'] as List)
        ?.map((e) =>
            e == null ? null : RecordInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['remark'] as String,
    json['status'] as String,
    json['statusTypeName'] as String,
    json['submitDate'] as String,
    json['submitHouse'] as String,
    json['submitRemark'] as String,
    json['submitResult'] as String,
    json['submitResultName'] as String,
    json['surrenderTime'] as String,
    json['unitIds'] as String,
    json['unitNames'] as String,
    json['updateTime'] as String,
    json['updator'] as String,
    json['updatorId'] as int,
  );
}

Map<String, dynamic> _$OfficeCancelLeaseInfoToJson(
        OfficeCancelLeaseInfo instance) =>
    <String, dynamic>{
      'attApplyList': instance.attApplyList,
      'attRectifyList': instance.attRectifyList,
      'attSubmitList': instance.attSubmitList,
      'buildIds': instance.buildIds,
      'buildNames': instance.buildNames,
      'businessNo': instance.businessNo,
      'checkTime': instance.checkTime,
      'createTime': instance.createTime,
      'custIds': instance.custIds,
      'custNames': instance.custNames,
      'customerId': instance.customerId,
      'customerName': instance.customerName,
      'customerTel': instance.customerTel,
      'customerType': instance.customerType,
      'houseIds': instance.houseIds,
      'houseNos': instance.houseNos,
      'officeSurrenderId': instance.officeSurrenderId,
      'operateStep': instance.operateStep,
      'participatePerson': instance.participatePerson,
      'payMoney': instance.payMoney,
      'projectId': instance.projectId,
      'projectName': instance.projectName,
      'recordList': instance.recordList,
      'remark': instance.remark,
      'status': instance.status,
      'statusTypeName': instance.statusTypeName,
      'submitDate': instance.submitDate,
      'submitHouse': instance.submitHouse,
      'submitRemark': instance.submitRemark,
      'submitResult': instance.submitResult,
      'submitResultName': instance.submitResultName,
      'surrenderTime': instance.surrenderTime,
      'unitIds': instance.unitIds,
      'unitNames': instance.unitNames,
      'updateTime': instance.updateTime,
      'updator': instance.updator,
      'updatorId': instance.updatorId,
    };
