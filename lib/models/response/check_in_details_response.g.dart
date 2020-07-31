// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_in_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckInDetailsResponse _$CheckInDetailsResponseFromJson(
    Map<String, dynamic> json) {
  return CheckInDetailsResponse(
    details: json['data'] == null
        ? null
        : CheckInDetails.fromJson(json['data'] as Map<String, dynamic>),
  )
    ..code = json['code'] as String
    ..message = json['message'] as String;
}

Map<String, dynamic> _$CheckInDetailsResponseToJson(
        CheckInDetailsResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.details,
    };

CheckInDetails _$CheckInDetailsFromJson(Map<String, dynamic> json) {
  return CheckInDetails(
    agreedReprocessTime: json['agreedReprocessTime'] as String,
    assigneeName: json['assigneeName'] as String,
    attJfpjList: (json['attJfpjList'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    attRzqrList: (json['attRzqrList'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    attRzqrhList: (json['attRzqrhList'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    attZhrzList: (json['attZhrzList'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    auditRemark: json['auditRemark'] as String,
    bookReprocessTime: json['bookReprocessTime'] as String,
    businessNo: json['businessNo'] as String,
    companyCreditCode: json['companyCreditCode'] as String,
    companyProp: json['companyProp'] as String,
    contactName: json['contactName'] as String,
    contactPhone: json['contactPhone'] as String,
    createTime: json['createTime'] as String,
    customerId: json['customerId'] as int,
    customerName: json['customerName'] as String,
    customerPhone: json['customerPhone'] as String,
    depositAccount: json['depositAccount'] as String,
    depositBank: json['depositBank'] as String,
    emerContactName: json['emerContactName'] as String,
    emerContactPhone: json['emerContactPhone'] as String,
    enterConfirmRemark: json['enterConfirmRemark'] as String,
    enterDate: json['enterDate'] as String,
    enterType: json['enterType'] as String,
    gender: json['gender'] as String,
    houseId: json['houseId'] as int,
    houseNo: json['houseNo'] as String,
    houseUsage: json['houseUsage'] as String,
    idNum: json['idNum'] as String,
    idType: json['idType'] as String,
    legalPersonName: json['legalPersonName'] as String,
    operateStep: json['operateStep'] as String,
    operateStepNext: json['operateStepNext'] as String,
    payConfirmRemark: json['payConfirmRemark'] as String,
    payFees: (json['payFees'] as num)?.toDouble(),
    postId: json['postId'] as int,
    processId: json['processId'] as String,
    projectId: json['projectId'] as int,
    projectName: json['projectName'] as String,
    formerName: json['formerName'] as String,
    recordList: (json['recordList'] as List)
        ?.map((e) =>
            e == null ? null : RecordList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    relationship: json['relationship'] as String,
    rentArea: json['rentArea'] as String,
    rentLocation: json['rentLocation'] as String,
    rentAddress: json['rentAddress'] as String,
    rentType: json['rentType'] as String,
    rentersName: json['rentersName'] as String,
    rentingEnterId: json['rentingEnterId'] as int,
    status: json['status'] as String,
    taxCategory: json['taxCategory'] as String,
    taxRate: json['taxRate'] as String,
    updateTime: json['updateTime'] as String,
    userId: json['userId'] as int,
  );
}

Map<String, dynamic> _$CheckInDetailsToJson(CheckInDetails instance) =>
    <String, dynamic>{
      'agreedReprocessTime': instance.agreedReprocessTime,
      'assigneeName': instance.assigneeName,
      'attJfpjList': instance.attJfpjList,
      'attRzqrList': instance.attRzqrList,
      'attRzqrhList': instance.attRzqrhList,
      'attZhrzList': instance.attZhrzList,
      'auditRemark': instance.auditRemark,
      'bookReprocessTime': instance.bookReprocessTime,
      'businessNo': instance.businessNo,
      'companyCreditCode': instance.companyCreditCode,
      'companyProp': instance.companyProp,
      'contactName': instance.contactName,
      'contactPhone': instance.contactPhone,
      'createTime': instance.createTime,
      'customerId': instance.customerId,
      'customerName': instance.customerName,
      'customerPhone': instance.customerPhone,
      'depositAccount': instance.depositAccount,
      'depositBank': instance.depositBank,
      'emerContactName': instance.emerContactName,
      'emerContactPhone': instance.emerContactPhone,
      'enterConfirmRemark': instance.enterConfirmRemark,
      'enterDate': instance.enterDate,
      'enterType': instance.enterType,
      'gender': instance.gender,
      'houseId': instance.houseId,
      'houseNo': instance.houseNo,
      'houseUsage': instance.houseUsage,
      'idNum': instance.idNum,
      'idType': instance.idType,
      'legalPersonName': instance.legalPersonName,
      'operateStep': instance.operateStep,
      'operateStepNext': instance.operateStepNext,
      'payConfirmRemark': instance.payConfirmRemark,
      'payFees': instance.payFees,
      'postId': instance.postId,
      'processId': instance.processId,
      'projectId': instance.projectId,
      'projectName': instance.projectName,
      'formerName': instance.formerName,
      'recordList': instance.recordList,
      'relationship': instance.relationship,
      'rentArea': instance.rentArea,
      'rentLocation': instance.rentLocation,
      'rentAddress': instance.rentAddress,
      'rentType': instance.rentType,
      'rentersName': instance.rentersName,
      'rentingEnterId': instance.rentingEnterId,
      'status': instance.status,
      'taxCategory': instance.taxCategory,
      'taxRate': instance.taxRate,
      'updateTime': instance.updateTime,
      'userId': instance.userId,
    };

RecordList _$RecordListFromJson(Map<String, dynamic> json) {
  return RecordList(
    (json['attJfpjList'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['attRzqrList'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['attRzqrhList'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['attZhrzList'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['attachmentFlag'] as String,
    json['createTime'] as String,
    json['creator'] as String,
    json['creatorId'] as int,
    json['creatorType'] as String,
    json['operateStep'] as String,
    json['postId'] as int,
    json['recordId'] as int,
    json['remark'] as String,
    json['rentingEnterId'] as int,
    json['status'] as String,
    json['userId'] as int,
  )
    ..operateStepDesc = json['operateStepDesc'] as String
    ..statusDesc = json['statusDesc'] as String;
}

Map<String, dynamic> _$RecordListToJson(RecordList instance) =>
    <String, dynamic>{
      'attJfpjList': instance.attJfpjList,
      'attRzqrList': instance.attRzqrList,
      'attRzqrhList': instance.attRzqrhList,
      'attZhrzList': instance.attZhrzList,
      'attachmentFlag': instance.attachmentFlag,
      'createTime': instance.createTime,
      'creator': instance.creator,
      'creatorId': instance.creatorId,
      'creatorType': instance.creatorType,
      'operateStep': instance.operateStep,
      'operateStepDesc': instance.operateStepDesc,
      'postId': instance.postId,
      'recordId': instance.recordId,
      'remark': instance.remark,
      'rentingEnterId': instance.rentingEnterId,
      'status': instance.status,
      'statusDesc': instance.statusDesc,
      'userId': instance.userId,
    };
