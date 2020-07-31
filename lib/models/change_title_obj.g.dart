// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_title_obj.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangeTitleObj _$ChangeTitleObjFromJson(Map<String, dynamic> json) {
  return ChangeTitleObj(
    (json['appCodes'] as List)?.map((e) => e as String)?.toList(),
    json['code'] as String,
    json['data'] == null
        ? null
        : ChangeTitleInfo.fromJson(json['data'] as Map<String, dynamic>),
    json['extStr'] as String,
    json['message'] as String,
    json['systemDate'] as String,
    json['totalCount'] as int,
  );
}

Map<String, dynamic> _$ChangeTitleObjToJson(ChangeTitleObj instance) =>
    <String, dynamic>{
      'appCodes': instance.appCodes,
      'code': instance.code,
      'data': instance.changeTitleInfo,
      'extStr': instance.extStr,
      'message': instance.message,
      'systemDate': instance.systemDate,
      'totalCount': instance.totalCount,
    };

ChangeTitleInfo _$ChangeTitleInfoFromJson(Map<String, dynamic> json) {
  return ChangeTitleInfo(
    attApplyList: (json['attApplyList'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    assigneeId: json['assigneeId'] as int,
    assigneeIdNum: json['assigneeIdNum'] as String,
    assigneeIdNumMatchId: json['assigneeIdNumMatchId'] as int,
    assigneeIdTypeId: json['assigneeIdTypeId'] as String,
    assigneeMobileMatchId: json['assigneeMobileMatchId'] as int,
    assigneePhone: json['assigneePhone'] as String,
    assigneeRealname: json['assigneeRealname'] as String,
    attApplyPhotoList:
        (json['attApplyPhotoList'] as List)?.map((e) => e as String)?.toList(),
    attFileList: (json['attFileList'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    attPhotoList:
        (json['attPhotoList'] as List)?.map((e) => e as String)?.toList(),
    buildId: json['buildId'] as int,
    buildName: json['buildName'] as String,
    businessNo: json['businessNo'] as String,
    createTime: json['createTime'] as String,
    custSimpleVoAppByIdNum: json['custSimpleVoAppByIdNum'] == null
        ? null
        : CustSimpleVoAppByIdNum.fromJson(
            json['custSimpleVoAppByIdNum'] as Map<String, dynamic>),
    custSimpleVoAppByMobile: json['custSimpleVoAppByMobile'] == null
        ? null
        : CustSimpleVoAppByMobile.fromJson(
            json['custSimpleVoAppByMobile'] as Map<String, dynamic>),
    customerId: json['customerId'] as int,
    customerIdNum: json['customerIdNum'] as String,
    customerIdTypeId: json['customerIdTypeId'] as String,
    customerName: json['customerName'] as String,
    customerPhone: json['customerPhone'] as String,
    handoverTime: json['handoverTime'] as String,
    houseId: json['houseId'] as int,
    houseNo: json['houseNo'] as String,
    operateStep: json['operateStep'] as String,
    projectId: json['projectId'] as int,
    projectName: json['projectName'] as String,
    formerName: json['formerName'] as String,
    propertyChangeId: json['propertyChangeId'] as int,
    recordList: (json['recordList'] as List)
        ?.map((e) =>
            e == null ? null : RecordList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    remark: json['remark'] as String,
    status: json['status'] as String,
    unitId: json['unitId'] as int,
    unitName: json['unitName'] as String,
    updateTime: json['updateTime'] as String,
    promptInfo: json['promptInfo'] as String,
  );
}

Map<String, dynamic> _$ChangeTitleInfoToJson(ChangeTitleInfo instance) =>
    <String, dynamic>{
      'assigneeId': instance.assigneeId,
      'assigneeIdNum': instance.assigneeIdNum,
      'assigneeIdNumMatchId': instance.assigneeIdNumMatchId,
      'assigneeIdTypeId': instance.assigneeIdTypeId,
      'assigneeMobileMatchId': instance.assigneeMobileMatchId,
      'assigneePhone': instance.assigneePhone,
      'assigneeRealname': instance.assigneeRealname,
      'attApplyPhotoList': instance.attApplyPhotoList,
      'attFileList': instance.attFileList,
      'attApplyList': instance.attApplyList,
      'attPhotoList': instance.attPhotoList,
      'buildId': instance.buildId,
      'buildName': instance.buildName,
      'businessNo': instance.businessNo,
      'createTime': instance.createTime,
      'custSimpleVoAppByIdNum': instance.custSimpleVoAppByIdNum,
      'custSimpleVoAppByMobile': instance.custSimpleVoAppByMobile,
      'customerId': instance.customerId,
      'customerIdNum': instance.customerIdNum,
      'customerIdTypeId': instance.customerIdTypeId,
      'customerName': instance.customerName,
      'customerPhone': instance.customerPhone,
      'handoverTime': instance.handoverTime,
      'houseId': instance.houseId,
      'houseNo': instance.houseNo,
      'operateStep': instance.operateStep,
      'projectId': instance.projectId,
      'projectName': instance.projectName,
      'formerName': instance.formerName,
      'propertyChangeId': instance.propertyChangeId,
      'recordList': instance.recordList,
      'remark': instance.remark,
      'status': instance.status,
      'unitId': instance.unitId,
      'unitName': instance.unitName,
      'updateTime': instance.updateTime,
      'promptInfo': instance.promptInfo,
    };

CustSimpleVoAppByIdNum _$CustSimpleVoAppByIdNumFromJson(
    Map<String, dynamic> json) {
  return CustSimpleVoAppByIdNum(
    custId: json['custId'] as int,
    custIdNum: json['custIdNum'] as String,
    custName: json['custName'] as String,
    custPhone: json['custPhone'] as String,
    idTypeId: json['idTypeId'] as String,
  );
}

Map<String, dynamic> _$CustSimpleVoAppByIdNumToJson(
        CustSimpleVoAppByIdNum instance) =>
    <String, dynamic>{
      'custId': instance.custId,
      'custIdNum': instance.custIdNum,
      'custName': instance.custName,
      'custPhone': instance.custPhone,
      'idTypeId': instance.idTypeId,
    };

CustSimpleVoAppByMobile _$CustSimpleVoAppByMobileFromJson(
    Map<String, dynamic> json) {
  return CustSimpleVoAppByMobile(
    custId: json['custId'] as int,
    custIdNum: json['custIdNum'] as String,
    custName: json['custName'] as String,
    custPhone: json['custPhone'] as String,
    idTypeId: json['idTypeId'] as String,
  );
}

Map<String, dynamic> _$CustSimpleVoAppByMobileToJson(
        CustSimpleVoAppByMobile instance) =>
    <String, dynamic>{
      'custId': instance.custId,
      'custIdNum': instance.custIdNum,
      'custName': instance.custName,
      'custPhone': instance.custPhone,
      'idTypeId': instance.idTypeId,
    };

RecordList _$RecordListFromJson(Map<String, dynamic> json) {
  return RecordList(
    payFees: (json['payFees'] as num)?.toDouble(),
    attFileList: (json['attFileList'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    attPhotoList:
        (json['attPhotoList'] as List)?.map((e) => e as String)?.toList(),
    attachmentFlag: json['attachmentFlag'] as String,
    createTime: json['createTime'] as String,
    creator: json['creator'] as String,
    creatorId: json['creatorId'] as int,
    creatorType: json['creatorType'] as String,
    operateStep: json['operateStep'] as String,
    operateStepName: json['operateStepName'] as String,
    postId: json['postId'] as int,
    propertyChangeId: json['propertyChangeId'] as int,
    recordId: json['recordId'] as int,
    remark: json['remark'] as String,
    status: json['status'] as String,
    userId: json['userId'] as int,
    statusName: json['statusName'] as String,
  );
}

Map<String, dynamic> _$RecordListToJson(RecordList instance) =>
    <String, dynamic>{
      'attFileList': instance.attFileList,
      'attPhotoList': instance.attPhotoList,
      'attachmentFlag': instance.attachmentFlag,
      'createTime': instance.createTime,
      'creator': instance.creator,
      'creatorId': instance.creatorId,
      'creatorType': instance.creatorType,
      'operateStep': instance.operateStep,
      'operateStepName': instance.operateStepName,
      'postId': instance.postId,
      'propertyChangeId': instance.propertyChangeId,
      'recordId': instance.recordId,
      'remark': instance.remark,
      'status': instance.status,
      'statusName': instance.statusName,
      'userId': instance.userId,
      'payFees': instance.payFees,
    };
