// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_house_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewHouseModel _$NewHouseModelFromJson(Map<String, dynamic> json) {
  return NewHouseModel(
    (json['appCodes'] as List)?.map((e) => e as String)?.toList(),
    json['code'] as String,
    json['data'] == null
        ? null
        : NewHouseDetail.fromJson(json['data'] as Map<String, dynamic>),
    json['extStr'] as String,
    json['message'] as String,
    json['systemDate'] as String,
    json['totalCount'] as int,
  );
}

Map<String, dynamic> _$NewHouseModelToJson(NewHouseModel instance) =>
    <String, dynamic>{
      'appCodes': instance.appCodes,
      'code': instance.code,
      'data': instance.newHouseDetail,
      'extStr': instance.extStr,
      'message': instance.message,
      'systemDate': instance.systemDate,
      'totalCount': instance.totalCount,
    };

NewHouseDetail _$NewHouseDetailFromJson(Map<String, dynamic> json) {
  return NewHouseDetail(
    projectId: json['projectId'] as int,
    projectName: json['projectName'] as String,
    projectFormerName: json['projectFormerName'] as String,
    houseName: json['houseName'] as String,
    buildName: json['buildName'] as String,
    unitName: json['unitName'] as String,
    houseNo: json['houseNo'] as String,
    accountName: json['accountName'] as String,
    auditTime: json['auditTime'] as String,
    auditor: json['auditor'] as String,
    auditorId: json['auditorId'] as int,
    bank: json['bank'] as String,
    bankAccount: json['bankAccount'] as String,
    bankCollectAttachmentList: (json['bankCollectAttachmentList'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    checkCollectAttachmentList: (json['checkCollectAttachmentList'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    businessNo: json['businessNo'] as String,
    confirmPhotoList: (json['confirmPhotoList'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    createTime: json['createTime'] as String,
    creatorId: json['creatorId'] as int,
    custBirth: json['custBirth'] as String,
    custIdNum: json['custIdNum'] as String,
    custName: json['custName'] as String,
    custNative: json['custNative'] as String,
    custPhone: json['custPhone'] as String,
    custProper: json['custProper'] as String,
    custType: json['custType'] as String,
    decideDate: json['decideDate'] as String,
    email: json['email'] as String,
    gender: json['gender'] as String,
    houseId: json['houseId'] as int,
    newHouseCarInfoList: (json['houseJoinCarList'] as List)
        ?.map((e) => e == null
            ? null
            : NewHouseCarInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    houseJoinId: json['houseJoinId'] as int,
    newHousePetInfoList: (json['houseJoinPetList'] as List)
        ?.map((e) => e == null
            ? null
            : NewHousePetInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    idTypeId: json['idTypeId'] as String,
    joinDate: json['joinDate'] as String,
    payType: json['payType'] as String,
    personalityDesc: json['personalityDesc'] as String,
    propertyParkList: (json['propertyParkList'] as List)
        ?.map((e) => e == null
            ? null
            : PropertyParkInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    regAddr: json['regAddr'] as String,
    country: json['country'] as String,
    relatedAttachmentList: (json['relatedAttachmentList'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    remark: json['remark'] as String,
    scheduleDate: json['scheduleDate'] as String,
    processStatus: json['processStatus'] as String,
    processStatusName: json['processStatusName'] as String,
    updateTime: json['updateTime'] as String,
    updator: json['updator'] as String,
    updatorId: json['updatorId'] as int,
    updatorType: json['updatorType'] as String,
    workUnit: json['workUnit'] as String,
    workAddr: json['workAddr'] as String,
    recordList: (json['recordList'] as List)
        ?.map((e) =>
            e == null ? null : RecordInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )..custNation = json['custNation'] as String;
}

Map<String, dynamic> _$NewHouseDetailToJson(NewHouseDetail instance) =>
    <String, dynamic>{
      'projectId': instance.projectId,
      'projectName': instance.projectName,
      'projectFormerName': instance.projectFormerName,
      'houseName': instance.houseName,
      'buildName': instance.buildName,
      'unitName': instance.unitName,
      'houseNo': instance.houseNo,
      'accountName': instance.accountName,
      'auditTime': instance.auditTime,
      'auditor': instance.auditor,
      'auditorId': instance.auditorId,
      'bank': instance.bank,
      'bankAccount': instance.bankAccount,
      'bankCollectAttachmentList': instance.bankCollectAttachmentList,
      'checkCollectAttachmentList': instance.checkCollectAttachmentList,
      'businessNo': instance.businessNo,
      'confirmPhotoList': instance.confirmPhotoList,
      'createTime': instance.createTime,
      'creatorId': instance.creatorId,
      'custBirth': instance.custBirth,
      'custIdNum': instance.custIdNum,
      'custName': instance.custName,
      'custNation': instance.custNation,
      'custNative': instance.custNative,
      'custPhone': instance.custPhone,
      'custProper': instance.custProper,
      'custType': instance.custType,
      'decideDate': instance.decideDate,
      'email': instance.email,
      'gender': instance.gender,
      'houseId': instance.houseId,
      'houseJoinCarList': instance.newHouseCarInfoList,
      'houseJoinId': instance.houseJoinId,
      'houseJoinPetList': instance.newHousePetInfoList,
      'idTypeId': instance.idTypeId,
      'joinDate': instance.joinDate,
      'payType': instance.payType,
      'personalityDesc': instance.personalityDesc,
      'propertyParkList': instance.propertyParkList,
      'regAddr': instance.regAddr,
      'country': instance.country,
      'relatedAttachmentList': instance.relatedAttachmentList,
      'remark': instance.remark,
      'scheduleDate': instance.scheduleDate,
      'processStatus': instance.processStatus,
      'processStatusName': instance.processStatusName,
      'updateTime': instance.updateTime,
      'updator': instance.updator,
      'updatorId': instance.updatorId,
      'updatorType': instance.updatorType,
      'workUnit': instance.workUnit,
      'workAddr': instance.workAddr,
      'recordList': instance.recordList,
    };

NewHouseCarInfo _$NewHouseCarInfoFromJson(Map<String, dynamic> json) {
  return NewHouseCarInfo(
    carAttachmentList: (json['carAttachmentList'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    carBrand: json['carBrand'] as String,
    carColor: json['carColor'] as String,
    carId: json['carId'] as int,
    carSize: json['carSize'] as String,
    houseJoinId: json['houseJoinId'] as int,
    plateNumber: json['plateNumber'] as String,
    remark: json['remark'] as String,
  );
}

Map<String, dynamic> _$NewHouseCarInfoToJson(NewHouseCarInfo instance) =>
    <String, dynamic>{
      'carAttachmentList': instance.carAttachmentList,
      'carBrand': instance.carBrand,
      'carColor': instance.carColor,
      'carId': instance.carId,
      'carSize': instance.carSize,
      'houseJoinId': instance.houseJoinId,
      'plateNumber': instance.plateNumber,
      'remark': instance.remark,
    };

NewHousePetInfo _$NewHousePetInfoFromJson(Map<String, dynamic> json) {
  return NewHousePetInfo(
    houseJoinId: json['houseJoinId'] as int,
    isPetCertificated: json['isPetCertificated'] as String,
    petAttachmentList: (json['petAttachmentList'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    petColor: json['petColor'] as String,
    petId: json['petId'] as int,
    petNickName: json['petNickName'] as String,
    petVariety: json['petVariety'] as String,
    remark: json['remark'] as String,
  );
}

Map<String, dynamic> _$NewHousePetInfoToJson(NewHousePetInfo instance) =>
    <String, dynamic>{
      'houseJoinId': instance.houseJoinId,
      'isPetCertificated': instance.isPetCertificated,
      'petAttachmentList': instance.petAttachmentList,
      'petColor': instance.petColor,
      'petId': instance.petId,
      'petNickName': instance.petNickName,
      'petVariety': instance.petVariety,
      'remark': instance.remark,
    };

PropertyParkInfo _$PropertyParkInfoFromJson(Map<String, dynamic> json) {
  return PropertyParkInfo(
    houseJoinId: json['houseJoinId'] as int,
    number: json['number'] as String,
    projectId: json['projectId'] as int,
    propertyParkId: json['propertyParkId'] as int,
  );
}

Map<String, dynamic> _$PropertyParkInfoToJson(PropertyParkInfo instance) =>
    <String, dynamic>{
      'houseJoinId': instance.houseJoinId,
      'number': instance.number,
      'projectId': instance.projectId,
      'propertyParkId': instance.propertyParkId,
    };

RecordInfo _$RecordInfoFromJson(Map<String, dynamic> json) {
  return RecordInfo(
    json['attachmentFlag'] as String,
    json['createTime'] as String,
    json['creator'] as String,
    json['creatorId'] as int,
    json['creatorType'] as String,
    json['houseJoinId'] as int,
    json['operateStep'] as String,
    json['operateStepName'] as String,
    json['postId'] as int,
    json['processStatus'] as String,
    json['processStatusName'] as String,
    (json['recordAttachmentList'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['recordId'] as int,
    json['remark'] as String,
    json['userId'] as int,
    json['operationStatus'] as String,
  );
}

Map<String, dynamic> _$RecordInfoToJson(RecordInfo instance) =>
    <String, dynamic>{
      'attachmentFlag': instance.attachmentFlag,
      'createTime': instance.createTime,
      'creator': instance.creator,
      'creatorId': instance.creatorId,
      'creatorType': instance.creatorType,
      'houseJoinId': instance.houseJoinId,
      'operateStep': instance.operateStep,
      'operationStatus': instance.operationStatus,
      'operateStepName': instance.operateStepName,
      'postId': instance.postId,
      'processStatus': instance.processStatus,
      'processStatusName': instance.processStatusName,
      'recordAttachmentList': instance.recordAttachmentList,
      'recordId': instance.recordId,
      'remark': instance.remark,
      'userId': instance.userId,
    };
