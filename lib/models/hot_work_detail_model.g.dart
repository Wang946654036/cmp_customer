// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hot_work_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotWorkDetailModel _$HotWorkDetailModelFromJson(Map<String, dynamic> json) {
  return HotWorkDetailModel(
    (json['appCodes'] as List)?.map((e) => e as String)?.toList(),
    json['code'] as String,
    json['data'] == null
        ? null
        : HotWorkDetail.fromJson(json['data'] as Map<String, dynamic>),
    json['extStr'] as String,
    json['message'] as String,
    json['systemDate'] as String,
    json['totalCount'] as int,
  );
}

Map<String, dynamic> _$HotWorkDetailModelToJson(HotWorkDetailModel instance) =>
    <String, dynamic>{
      'appCodes': instance.appCodes,
      'code': instance.code,
      'data': instance.hotWorkDetail,
      'extStr': instance.extStr,
      'message': instance.message,
      'systemDate': instance.systemDate,
      'totalCount': instance.totalCount,
    };

HotWorkDetail _$HotWorkDetailFromJson(Map<String, dynamic> json) {
  return HotWorkDetail(
    constructionUnit: json['constructionUnit'] as String,
    createTime: json['createTime'] as String,
    customerId: json['customerId'] as int,
    customerName: json['customerName'] as String,
    customerPhone: json['customerPhone'] as String,
    firePreventMan: json['firePreventMan'] as String,
    fireWatchMan: json['fireWatchMan'] as String,
    hotWorkContent: json['hotWorkContent'] as String,
    hotWorkEndTime: json['hotWorkEndTime'] as String,
    hotWorkId: json['hotWorkId'] as int,
    hotWorkLocation: json['hotWorkLocation'] as String,
    hotWorkNo: json['hotWorkNo'] as String,
    hotWorkStartTime: json['hotWorkStartTime'] as String,
    houseBuildId: json['houseBuildId'] as int,
    houseId: json['houseId'] as int,
    houseName: json['houseName'] as String,
    houseUnitId: json['houseUnitId'] as int,
    onSiteLeader: json['onSiteLeader'] as String,
    ownerId: json['ownerId'] as int,
    ownerIdentityNo: json['ownerIdentityNo'] as String,
    ownerName: json['ownerName'] as String,
    ownerPhone: json['ownerPhone'] as String,
    processExecutor: json['processExecutor'] as String,
    processId: json['processId'] as String,
    processNodeCode: json['processNodeCode'] as String,
    processNodeName: json['processNodeName'] as String,
    processPostId: json['processPostId'] as int,
    processState: json['processState'] as String,
    processStateName: json['processStateName'] as String,
    processTime: json['processTime'] as String,
    processUserId: json['processUserId'] as int,
    projectId: json['projectId'] as int,
    projectName: json['projectName'] as String,
    formerName: json['formerName'] as String,
    remark: json['remark'] as String,
    updateTime: json['updateTime'] as String,
    welderList: (json['welderList'] as List)
        ?.map((e) =>
            e == null ? null : WelderInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    applyType: json['applyType'] as String,
    recordList: (json['applyRecordList'] as List)
        ?.map((e) =>
            e == null ? null : RecordInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    attDhYzSignList: (json['attDhYzSignList'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    attDhZhSignList: (json['attDhZhSignList'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$HotWorkDetailToJson(HotWorkDetail instance) =>
    <String, dynamic>{
      'constructionUnit': instance.constructionUnit,
      'createTime': instance.createTime,
      'customerId': instance.customerId,
      'customerName': instance.customerName,
      'customerPhone': instance.customerPhone,
      'firePreventMan': instance.firePreventMan,
      'fireWatchMan': instance.fireWatchMan,
      'hotWorkContent': instance.hotWorkContent,
      'hotWorkEndTime': instance.hotWorkEndTime,
      'hotWorkId': instance.hotWorkId,
      'hotWorkLocation': instance.hotWorkLocation,
      'hotWorkNo': instance.hotWorkNo,
      'hotWorkStartTime': instance.hotWorkStartTime,
      'houseBuildId': instance.houseBuildId,
      'houseId': instance.houseId,
      'houseName': instance.houseName,
      'houseUnitId': instance.houseUnitId,
      'onSiteLeader': instance.onSiteLeader,
      'ownerId': instance.ownerId,
      'ownerIdentityNo': instance.ownerIdentityNo,
      'ownerName': instance.ownerName,
      'ownerPhone': instance.ownerPhone,
      'processExecutor': instance.processExecutor,
      'processId': instance.processId,
      'processNodeCode': instance.processNodeCode,
      'processNodeName': instance.processNodeName,
      'processPostId': instance.processPostId,
      'processState': instance.processState,
      'processStateName': instance.processStateName,
      'processTime': instance.processTime,
      'processUserId': instance.processUserId,
      'projectId': instance.projectId,
      'projectName': instance.projectName,
      'formerName': instance.formerName,
      'remark': instance.remark,
      'updateTime': instance.updateTime,
      'welderList': instance.welderList,
      'applyType': instance.applyType,
      'applyRecordList': instance.recordList,
      'attDhYzSignList': instance.attDhYzSignList,
      'attDhZhSignList': instance.attDhZhSignList,
    };

WelderInfo _$WelderInfoFromJson(Map<String, dynamic> json) {
  return WelderInfo(
    certificateNo: json['certificateNo'] as String,
    hotWorkId: json['hotWorkId'] as int,
    idCardNo: json['idCardNo'] as String,
    welderCertPhotoList: (json['welderCertPhotoList'] as List)
        ?.map((e) => e as String)
        ?.toList(),
    welderId: json['welderId'] as int,
    welderIdPhotoList:
        (json['welderIdPhotoList'] as List)?.map((e) => e as String)?.toList(),
    welderName: json['welderName'] as String,
    workType: json['workType'] as String,
  );
}

Map<String, dynamic> _$WelderInfoToJson(WelderInfo instance) =>
    <String, dynamic>{
      'certificateNo': instance.certificateNo,
      'hotWorkId': instance.hotWorkId,
      'idCardNo': instance.idCardNo,
      'welderCertPhotoList': instance.welderCertPhotoList,
      'welderId': instance.welderId,
      'welderIdPhotoList': instance.welderIdPhotoList,
      'welderName': instance.welderName,
      'workType': instance.workType,
    };

RecordInfo _$RecordInfoFromJson(Map<String, dynamic> json) {
  return RecordInfo(
    json['executorName'] as String,
    json['hotWorkId'] as int,
    json['passFlag'] as String,
    json['processContent'] as String,
    json['processCustId'] as int,
    json['processExecutor'] as String,
    json['processNodeCode'] as String,
    json['processNodeName'] as String,
    json['processPostId'] as int,
    json['processPostName'] as String,
    json['processTime'] as String,
    json['processUserId'] as int,
    json['recordId'] as int,
    (json['attDhYzSignList'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['attDhZhSignList'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$RecordInfoToJson(RecordInfo instance) =>
    <String, dynamic>{
      'executorName': instance.executorName,
      'hotWorkId': instance.hotWorkId,
      'passFlag': instance.passFlag,
      'processContent': instance.processContent,
      'processCustId': instance.processCustId,
      'processExecutor': instance.processExecutor,
      'processNodeCode': instance.processNodeCode,
      'processNodeName': instance.processNodeName,
      'processPostId': instance.processPostId,
      'processPostName': instance.processPostName,
      'processTime': instance.processTime,
      'processUserId': instance.processUserId,
      'recordId': instance.recordId,
      'attDhYzSignList': instance.attDhYzSignList,
      'attDhZhSignList': instance.attDhZhSignList,
    };
