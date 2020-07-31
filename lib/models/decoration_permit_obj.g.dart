// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'decoration_permit_obj.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DecorationPermitObj _$DecorationPermitObjFromJson(Map<String, dynamic> json) {
  return DecorationPermitObj(
    appCodes: (json['appCodes'] as List)?.map((e) => e as String)?.toList(),
    code: json['code'] as String,
    data: json['data'] == null
        ? null
        : DecorationPermitInfo.fromJson(json['data'] as Map<String, dynamic>),
    extStr: json['extStr'] as String,
    message: json['message'] as String,
    systemDate: json['systemDate'] as String,
    totalCount: json['totalCount'] as int,
  );
}

Map<String, dynamic> _$DecorationPermitObjToJson(
        DecorationPermitObj instance) =>
    <String, dynamic>{
      'appCodes': instance.appCodes,
      'code': instance.code,
      'data': instance.data,
      'extStr': instance.extStr,
      'message': instance.message,
      'systemDate': instance.systemDate,
      'totalCount': instance.totalCount,
    };

DecorationPermitInfo _$DecorationPermitInfoFromJson(Map<String, dynamic> json) {
  return DecorationPermitInfo(
    json['applyId'] as int,
    json['applyVo'] == null
        ? null
        : ApplyVo.fromJson(json['applyVo'] as Map<String, dynamic>),
    json['bpmCurrentRole'] as String,
    json['bpmCurrentState'] as String,
    json['checkRole'] as String,
    json['fromDate'] as String,
    json['delayDate'] as String,
    json['delayState'] as String,
    json['id'] as int,
    json['oddNumber'] as String,
    json['newNumber'] as String,
    json['operationCust'] as int,
    json['operationUser'] as int,
    json['postId'] as int,
    json['processId'] as String,
    json['status'] as String,
    json['userId'] as int,
    json['writeDate'] as String,
    json['writer'] as int,
    json['writerName'] as String,
    json['reason'] as String,
    json['remark'] as String,
    (json['applyHanders'] as List)
        ?.map((e) => e == null
            ? null
            : DecorateApplyHanderVo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DecorationPermitInfoToJson(
        DecorationPermitInfo instance) =>
    <String, dynamic>{
      'applyId': instance.applyId,
      'applyVo': instance.applyVo,
      'bpmCurrentRole': instance.bpmCurrentRole,
      'bpmCurrentState': instance.bpmCurrentState,
      'checkRole': instance.checkRole,
      'delayDate': instance.delayDate,
      'delayState': instance.delayState,
      'id': instance.id,
      'oddNumber': instance.oddNumber,
      'newNumber': instance.newNumber,
      'operationCust': instance.operationCust,
      'operationUser': instance.operationUser,
      'postId': instance.postId,
      'processId': instance.processId,
      'status': instance.status,
      'userId': instance.userId,
      'writeDate': instance.writeDate,
      'writer': instance.writer,
      'writerName': instance.writerName,
      'fromDate': instance.fromDate,
      'reason': instance.reason,
      'remark': instance.remark,
      'applyHanders': instance.applyHanders,
    };

ApplyVo _$ApplyVoFromJson(Map<String, dynamic> json) {
  return ApplyVo(
    json['agree'] as int,
    json['applyDate'] as String,
    json['applyType'] as int,
    json['beginWorkDate'] as String,
    json['bpmCurrentRole'] as String,
    json['bpmCurrentState'] as String,
    json['checkRole'] as String,
    json['companyPaperNumber'] as String,
    (json['companyPapers'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['credentialNumber'] as String,
    (json['credentialPapers'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['custId'] as int,
    json['custName'] as String,
    json['custPhone'] as String,
    json['decorateAcceptanceVo'] == null
        ? null
        : DecorateAcceptanceVo.fromJson(
            json['decorateAcceptanceVo'] as Map<String, dynamic>),
    json['decorateType'] as int,
    json['houseId'] as int,
    json['houseName'] as String,
    json['id'] as int,
    json['manager'] as String,
    json['managerIdCard'] as String,
    (json['managerIdCardPhotos'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['managerPhone'] as String,
    (json['nodeList'] as List)
        ?.map((e) =>
            e == null ? null : NodeList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['oddNumber'] as String,
    json['operationCust'] as int,
    json['operationUser'] as int,
    (json['otherPhotos'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['payPhotos'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['postId'] as int,
    json['processId'] as String,
    json['programDesc'] as String,
    json['programName'] as String,
    json['projectId'] as int,
    json['state'] as String,
    json['status'] as String,
    json['userId'] as int,
    json['workCompany'] as String,
    json['workDayLong'] as int,
    json['workPeopleNum'] as int,
  );
}

Map<String, dynamic> _$ApplyVoToJson(ApplyVo instance) => <String, dynamic>{
      'agree': instance.agree,
      'applyDate': instance.applyDate,
      'applyType': instance.applyType,
      'beginWorkDate': instance.beginWorkDate,
      'bpmCurrentRole': instance.bpmCurrentRole,
      'bpmCurrentState': instance.bpmCurrentState,
      'checkRole': instance.checkRole,
      'companyPaperNumber': instance.companyPaperNumber,
      'companyPapers': instance.companyPapers,
      'credentialNumber': instance.credentialNumber,
      'credentialPapers': instance.credentialPapers,
      'custId': instance.custId,
      'custName': instance.custName,
      'custPhone': instance.custPhone,
      'decorateAcceptanceVo': instance.decorateAcceptanceVo,
      'decorateType': instance.decorateType,
      'houseId': instance.houseId,
      'houseName': instance.houseName,
      'id': instance.id,
      'manager': instance.manager,
      'managerIdCard': instance.managerIdCard,
      'managerIdCardPhotos': instance.managerIdCardPhotos,
      'managerPhone': instance.managerPhone,
      'nodeList': instance.nodeList,
      'oddNumber': instance.oddNumber,
      'operationCust': instance.operationCust,
      'operationUser': instance.operationUser,
      'otherPhotos': instance.otherPhotos,
      'payPhotos': instance.payPhotos,
      'postId': instance.postId,
      'processId': instance.processId,
      'programDesc': instance.programDesc,
      'programName': instance.programName,
      'projectId': instance.projectId,
      'state': instance.state,
      'status': instance.status,
      'userId': instance.userId,
      'workCompany': instance.workCompany,
      'workDayLong': instance.workDayLong,
      'workPeopleNum': instance.workPeopleNum,
    };

DecorateAcceptanceVo _$DecorateAcceptanceVoFromJson(Map<String, dynamic> json) {
  return DecorateAcceptanceVo(
    json['applyId'] as int,
    json['backPrice'] as int,
    json['bpmCurrentRole'] as String,
    json['bpmCurrentState'] as String,
    json['checkDate'] as String,
    json['checkDesc'] as String,
    (json['checkPhotos'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['checkResult'] as int,
    json['checkRole'] as String,
    json['checkSecond'] as int,
    json['counter'] as int,
    json['createDate'] as String,
    json['custId'] as int,
    json['finishDate'] as String,
    json['id'] as int,
    json['isBack'] as int,
    json['manager'] as String,
    json['managerPhone'] as String,
    json['operationCust'] as int,
    json['operationUser'] as int,
    json['price'] as String,
    json['processId'] as String,
    json['quality'] as int,
    json['state'] as String,
    json['status'] as String,
    json['suggestion'] as String,
  );
}

Map<String, dynamic> _$DecorateAcceptanceVoToJson(
        DecorateAcceptanceVo instance) =>
    <String, dynamic>{
      'applyId': instance.applyId,
      'backPrice': instance.backPrice,
      'bpmCurrentRole': instance.bpmCurrentRole,
      'bpmCurrentState': instance.bpmCurrentState,
      'checkDate': instance.checkDate,
      'checkDesc': instance.checkDesc,
      'checkPhotos': instance.checkPhotos,
      'checkResult': instance.checkResult,
      'checkRole': instance.checkRole,
      'checkSecond': instance.checkSecond,
      'counter': instance.counter,
      'createDate': instance.createDate,
      'custId': instance.custId,
      'finishDate': instance.finishDate,
      'id': instance.id,
      'isBack': instance.isBack,
      'manager': instance.manager,
      'managerPhone': instance.managerPhone,
      'operationCust': instance.operationCust,
      'operationUser': instance.operationUser,
      'price': instance.price,
      'processId': instance.processId,
      'quality': instance.quality,
      'state': instance.state,
      'status': instance.status,
      'suggestion': instance.suggestion,
    };

DecorateApplyHanderVo _$DecorateApplyHanderVoFromJson(
    Map<String, dynamic> json) {
  return DecorateApplyHanderVo(
    json['mobile'] as String,
    json['postName'] as String,
    json['realname'] as String,
  );
}

Map<String, dynamic> _$DecorateApplyHanderVoToJson(
        DecorateApplyHanderVo instance) =>
    <String, dynamic>{
      'mobile': instance.mobile,
      'postName': instance.postName,
      'realname': instance.realname,
    };

NodeList _$NodeListFromJson(Map<String, dynamic> json) {
  return NodeList(
    json['applyId'] as int,
    (json['attFileList'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['createDate'] as String,
    json['id'] as int,
    json['logType'] as int,
    json['operation'] as String,
    json['operationCust'] as int,
    json['operationCustName'] as String,
    json['operationName'] as String,
    json['operationResult'] as String,
    json['operationUser'] as int,
    json['operationUserName'] as String,
    json['other'] as String,
    json['remark'] as String,
  );
}

Map<String, dynamic> _$NodeListToJson(NodeList instance) => <String, dynamic>{
      'applyId': instance.applyId,
      'attFileList': instance.attFileList,
      'createDate': instance.createDate,
      'id': instance.id,
      'logType': instance.logType,
      'operation': instance.operation,
      'operationCust': instance.operationCust,
      'operationCustName': instance.operationCustName,
      'operationName': instance.operationName,
      'operationResult': instance.operationResult,
      'operationUser': instance.operationUser,
      'operationUserName': instance.operationUserName,
      'other': instance.other,
      'remark': instance.remark,
    };
