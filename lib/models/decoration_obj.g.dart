// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'decoration_obj.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DecorationObj _$DecorationObjFromJson(Map<String, dynamic> json) {
  return DecorationObj(
    appCodes: (json['appCodes'] as List)?.map((e) => e as String)?.toList(),
    code: json['code'] as String,
    data: json['data'] == null
        ? null
        : DecorationInfo.fromJson(json['data'] as Map<String, dynamic>),
    extStr: json['extStr'] as String,
    message: json['message'] as String,
    systemDate: json['systemDate'] as String,
    totalCount: json['totalCount'] as int,
  );
}

Map<String, dynamic> _$DecorationObjToJson(DecorationObj instance) =>
    <String, dynamic>{
      'appCodes': instance.appCodes,
      'code': instance.code,
      'data': instance.data,
      'extStr': instance.extStr,
      'message': instance.message,
      'systemDate': instance.systemDate,
      'totalCount': instance.totalCount,
    };

DecorationInfo _$DecorationInfoFromJson(Map<String, dynamic> json) {
  return DecorationInfo(
    agree: json['agree'] as int,
    applyDate: json['applyDate'] as String,
    applyType: json['applyType'] as int,
    beginWorkDate: json['beginWorkDate'] as String,
    bpmCurrentRole: json['bpmCurrentRole'] as String,
    bpmCurrentState: json['bpmCurrentState'] as String,
    checkRole: json['checkRole'] as String,
    companyPaperNumber: json['companyPaperNumber'] as String,
    companyPapers: (json['companyPapers'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    credentialNumber: json['credentialNumber'] as String,
    credentialPapers: (json['credentialPapers'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    custId: json['custId'] as int,
    custName: json['custName'] as String,
    custPhone: json['custPhone'] as String,
    decorateAcceptanceVo: json['decorateAcceptanceVo'] == null
        ? null
        : DecorateAcceptanceVo.fromJson(
            json['decorateAcceptanceVo'] as Map<String, dynamic>),
    decorateType: json['decorateType'] as int,
    houseId: json['houseId'] as int,
    houseName: json['houseName'] as String,
    id: json['id'] as int,
    manager: json['manager'] as String,
    managerIdCard: json['managerIdCard'] as String,
    managerIdCardPhotos: (json['managerIdCardPhotos'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    managerPhone: json['managerPhone'] as String,
    nodeList: (json['nodeList'] as List)
        ?.map((e) =>
            e == null ? null : NodeList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    oddNumber: json['oddNumber'] as String,
    operationCust: json['operationCust'] as int,
    operationUser: json['operationUser'] as int,
    otherPhotos: (json['otherPhotos'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    payPhotos: (json['payPhotos'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    postId: json['postId'] as int,
    processId: json['processId'] as String,
    programDesc: json['programDesc'] as String,
    programName: json['programName'] as String,
    projectId: json['projectId'] as int,
    state: json['state'] as String,
    status: json['status'] as String,
    userId: json['userId'] as int,
    workCompany: json['workCompany'] as String,
    workDayLong: json['workDayLong'] as int,
    workPeopleNum: json['workPeopleNum'] as int,
    houseCustName: json['houseCustName'] as String,
    acceptanceId: json['acceptanceId'] as int,
    acceptanceCheckRole: json['acceptanceCheckRole'] as String,
    canOperation: json['canOperation'] as bool,
  );
}

Map<String, dynamic> _$DecorationInfoToJson(DecorationInfo instance) =>
    <String, dynamic>{
      'agree': instance.agree,
      'applyDate': instance.applyDate,
      'applyType': instance.applyType,
      'beginWorkDate': instance.beginWorkDate,
      'bpmCurrentRole': instance.bpmCurrentRole,
      'bpmCurrentState': instance.bpmCurrentState,
      'acceptanceCheckRole': instance.acceptanceCheckRole,
      'acceptanceId': instance.acceptanceId,
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
      'houseCustName': instance.houseCustName,
      'canOperation': instance.canOperation,
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

NodeList _$NodeListFromJson(Map<String, dynamic> json) {
  return NodeList(
    json['applyId'] as int,
    json['createDate'] as String,
    json['id'] as int,
    json['logType'] as int,
    json['operation'] as String,
    json['operationCust'] as int,
    json['operationName'] as String,
    json['operationResult'] as String,
    json['operationUser'] as int,
    json['other'] as String,
    json['remark'] as String,
    (json['attFileList'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$NodeListToJson(NodeList instance) => <String, dynamic>{
      'applyId': instance.applyId,
      'createDate': instance.createDate,
      'id': instance.id,
      'logType': instance.logType,
      'operation': instance.operation,
      'operationCust': instance.operationCust,
      'operationName': instance.operationName,
      'operationResult': instance.operationResult,
      'operationUser': instance.operationUser,
      'other': instance.other,
      'remark': instance.remark,
      'attFileList': instance.attFileList,
    };
