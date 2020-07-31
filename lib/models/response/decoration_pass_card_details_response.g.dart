// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'decoration_pass_card_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DecorationPassCardDetailsResponse _$DecorationPassCardDetailsResponseFromJson(
    Map<String, dynamic> json) {
  return DecorationPassCardDetailsResponse(
    details: json['data'] == null
        ? null
        : DecorationPassCardDetails.fromJson(
            json['data'] as Map<String, dynamic>),
  )
    ..code = json['code'] as String
    ..message = json['message'] as String;
}

Map<String, dynamic> _$DecorationPassCardDetailsResponseToJson(
        DecorationPassCardDetailsResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.details,
    };

DecorationPassCardDetails _$DecorationPassCardDetailsFromJson(
    Map<String, dynamic> json) {
  return DecorationPassCardDetails(
    beginDate: json['beginDate'] as String,
    bpmCurrentRole: json['bpmCurrentRole'] as String,
    bpmCurrentState: json['bpmCurrentState'] as String,
    checkRole: json['checkRole'] as String,
    company: json['company'] as String,
    createDate: json['createDate'] as String,
    custId: json['custId'] as int,
    custName: json['custName'] as String,
    custPhone: json['custPhone'] as String,
    endDate: json['endDate'] as String,
    houseId: json['houseId'] as int,
    houseName: json['houseName'] as String,
    id: json['id'] as int,
    nodeList: (json['nodeList'] as List)
        ?.map((e) =>
            e == null ? null : NodeList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    oddNumber: json['oddNumber'] as String,
    operationCust: json['operationCust'] as int,
    operationUser: json['operationUser'] as int,
    paperCount: json['paperCount'] as int,
    passPhotos: (json['passPhotos'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    postId: json['postId'] as int,
    processId: json['processId'] as String,
    projectId: json['projectId'] as int,
    remark: json['remark'] as String,
    state: json['state'] as String,
    status: json['status'] as String,
    type: json['type'] as int,
    userId: json['userId'] as int,
    userList: (json['userList'] as List)
        ?.map((e) =>
            e == null ? null : UserList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    formerName: json['formerName'] as String,
    creatorWriteUuid: json['creatorWriteUuid'] as String,
    ownerWriteUuid: json['ownerWriteUuid'] as String,
    checkUserUuid: json['checkUserUuid'] as String,
  )
    ..projectName = json['projectName'] as String
    ..stateString = json['stateString'] as String;
}

Map<String, dynamic> _$DecorationPassCardDetailsToJson(
        DecorationPassCardDetails instance) =>
    <String, dynamic>{
      'beginDate': instance.beginDate,
      'bpmCurrentRole': instance.bpmCurrentRole,
      'bpmCurrentState': instance.bpmCurrentState,
      'checkRole': instance.checkRole,
      'company': instance.company,
      'createDate': instance.createDate,
      'custId': instance.custId,
      'custName': instance.custName,
      'custPhone': instance.custPhone,
      'endDate': instance.endDate,
      'houseId': instance.houseId,
      'houseName': instance.houseName,
      'id': instance.id,
      'nodeList': instance.nodeList,
      'oddNumber': instance.oddNumber,
      'operationCust': instance.operationCust,
      'operationUser': instance.operationUser,
      'paperCount': instance.paperCount,
      'passPhotos': instance.passPhotos,
      'postId': instance.postId,
      'processId': instance.processId,
      'projectId': instance.projectId,
      'projectName': instance.projectName,
      'formerName': instance.formerName,
      'remark': instance.remark,
      'state': instance.state,
      'stateString': instance.stateString,
      'status': instance.status,
      'type': instance.type,
      'userId': instance.userId,
      'userList': instance.userList,
      'creatorWriteUuid': instance.creatorWriteUuid,
      'ownerWriteUuid': instance.ownerWriteUuid,
      'checkUserUuid': instance.checkUserUuid,
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
    json['checkUserUuid'] as String,
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
      'checkUserUuid': instance.checkUserUuid,
    };

UserList _$UserListFromJson(Map<String, dynamic> json) {
  return UserList(
    applyId: json['applyId'] as int,
    beginDate: json['beginDate'] as String,
    endDate: json['endDate'] as String,
    headPhotos: (json['headPhotos'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    id: json['id'] as int,
    idCard: json['idCard'] as String,
    idCardPhotos: (json['idCardPhotos'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    name: json['name'] as String,
    workType: json['workType'] as String,
  );
}

Map<String, dynamic> _$UserListToJson(UserList instance) => <String, dynamic>{
      'applyId': instance.applyId,
      'beginDate': instance.beginDate,
      'endDate': instance.endDate,
      'headPhotos': instance.headPhotos,
      'id': instance.id,
      'idCard': instance.idCard,
      'idCardPhotos': instance.idCardPhotos,
      'name': instance.name,
      'workType': instance.workType,
    };
