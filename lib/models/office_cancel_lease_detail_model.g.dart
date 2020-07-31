// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'office_cancel_lease_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfficeCancelLeaseDetailModel _$OfficeCancelLeaseDetailModelFromJson(
    Map<String, dynamic> json) {
  return OfficeCancelLeaseDetailModel(
    (json['appCodes'] as List)?.map((e) => e as String)?.toList(),
    json['code'] as String,
    json['data'] == null
        ? null
        : OfficeCancelLeaseDetail.fromJson(
            json['data'] as Map<String, dynamic>),
    json['extStr'] as String,
    json['message'] as String,
    json['systemDate'] as String,
    json['totalCount'] as int,
  );
}

Map<String, dynamic> _$OfficeCancelLeaseDetailModelToJson(
        OfficeCancelLeaseDetailModel instance) =>
    <String, dynamic>{
      'appCodes': instance.appCodes,
      'code': instance.code,
      'data': instance.officeCancelLeaseDetail,
      'extStr': instance.extStr,
      'message': instance.message,
      'systemDate': instance.systemDate,
      'totalCount': instance.totalCount,
    };

OfficeCancelLeaseDetail _$OfficeCancelLeaseDetailFromJson(
    Map<String, dynamic> json) {
  return OfficeCancelLeaseDetail(
    attApplyList:
        (json['attApplyList'] as List)?.map((e) => e as String)?.toList(),
    attRectifyList:
        (json['attRectifyList'] as List)?.map((e) => e as String)?.toList(),
    attSubmitList: (json['attSubmitList'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    buildIds: json['buildIds'] as String,
    buildNames: json['buildNames'] as String,
    businessNo: json['businessNo'] as String,
    checkTime: json['checkTime'] as String,
    createTime: json['createTime'] as String,
    custIds: json['custIds'] as String,
    custNames: json['custNames'] as String,
    customerId: json['customerId'] as int,
    customerName: json['customerName'] as String,
    customerTel: json['customerTel'] as String,
    customerType: json['customerType'] as String,
    houseIds: json['houseIds'] as String,
    houseNos: json['houseNos'] as String,
    officeSurrenderId: json['officeSurrenderId'] as int,
    operateStep: json['operateStep'] as String,
    participatePerson: json['participatePerson'] as String,
    payMoney: json['payMoney'] as String,
    projectId: json['projectId'] as int,
    projectName: json['projectName'] as String,
    recordList: (json['recordList'] as List)
        ?.map((e) =>
            e == null ? null : RecordInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    remark: json['remark'] as String,
    status: json['status'] as String,
    statusTypeName: json['statusTypeName'] as String,
    submitDate: json['submitDate'] as String,
    submitHouse: json['submitHouse'] as String,
    submitRemark: json['submitRemark'] as String,
    submitResult: json['submitResult'] as String,
    submitResultName: json['submitResultName'] as String,
    surrenderTime: json['surrenderTime'] as String,
    unitIds: json['unitIds'] as String,
    unitNames: json['unitNames'] as String,
    updateTime: json['updateTime'] as String,
    updator: json['updator'] as String,
    updatorId: json['updatorId'] as int,
  )..houseList = (json['houseList'] as List)
      ?.map((e) =>
          e == null ? null : HouseInfo.fromJson(e as Map<String, dynamic>))
      ?.toList();
}

Map<String, dynamic> _$OfficeCancelLeaseDetailToJson(
        OfficeCancelLeaseDetail instance) =>
    <String, dynamic>{
      'attApplyList': instance.attApplyList,
      'attRectifyList': instance.attRectifyList,
      'attSubmitList': instance.attSubmitList,
      'houseList': instance.houseList,
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

RecordInfo _$RecordInfoFromJson(Map<String, dynamic> json) {
  return RecordInfo(
    (json['attApplyList'] as List)?.map((e) => e as String)?.toList(),
    (json['attRectifyList'] as List)?.map((e) => e as String)?.toList(),
    (json['attSubmitList'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['attachmentFlag'] as String,
    json['auditResult'] as String,
    json['auditResultName'] as String,
    json['checkTime'] as String,
    json['createTime'] as String,
    json['creator'] as String,
    json['creatorId'] as int,
    json['creatorType'] as String,
    json['officeSurrenderId'] as int,
    json['operateStep'] as String,
    json['participatePerson'] as String,
    json['postId'] as int,
    json['recordId'] as int,
    json['remark'] as String,
    json['status'] as String,
    json['statusTypeName'] as String,
    json['submitDate'] as String,
    json['submitRemark'] as String,
    json['submitResult'] as String,
    json['submitResultName'] as String,
    json['userId'] as int,
  );
}

Map<String, dynamic> _$RecordInfoToJson(RecordInfo instance) =>
    <String, dynamic>{
      'attApplyList': instance.attApplyList,
      'attRectifyList': instance.attRectifyList,
      'attSubmitList': instance.attSubmitList,
      'attachmentFlag': instance.attachmentFlag,
      'auditResult': instance.auditResult,
      'auditResultName': instance.auditResultName,
      'checkTime': instance.checkTime,
      'createTime': instance.createTime,
      'creator': instance.creator,
      'creatorId': instance.creatorId,
      'creatorType': instance.creatorType,
      'officeSurrenderId': instance.officeSurrenderId,
      'operateStep': instance.operateStep,
      'participatePerson': instance.participatePerson,
      'postId': instance.postId,
      'recordId': instance.recordId,
      'remark': instance.remark,
      'status': instance.status,
      'statusTypeName': instance.statusTypeName,
      'submitDate': instance.submitDate,
      'submitRemark': instance.submitRemark,
      'submitResult': instance.submitResult,
      'submitResultName': instance.submitResultName,
      'userId': instance.userId,
    };
