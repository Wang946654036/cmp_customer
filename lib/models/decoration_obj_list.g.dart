// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'decoration_obj_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DecorationObjList _$DecorationObjListFromJson(Map<String, dynamic> json) {
  return DecorationObjList(
    appCodes: (json['appCodes'] as List)?.map((e) => e as String)?.toList(),
    code: json['code'] as String,
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : DecorationRecord.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    extStr: json['extStr'] as String,
    message: json['message'] as String,
    systemDate: json['systemDate'] as String,
    totalCount: json['totalCount'] as int,
  );
}

Map<String, dynamic> _$DecorationObjListToJson(DecorationObjList instance) =>
    <String, dynamic>{
      'appCodes': instance.appCodes,
      'code': instance.code,
      'data': instance.data,
      'extStr': instance.extStr,
      'message': instance.message,
      'systemDate': instance.systemDate,
      'totalCount': instance.totalCount,
    };

DecorationRecord _$DecorationRecordFromJson(Map<String, dynamic> json) {
  return DecorationRecord(
    agree: json['agree'] as int,
    applyDate: json['applyDate'] as String,
    applyType: json['applyType'] as int,
    beginWorkDate: json['beginWorkDate'] as String,
    bpmCurrentRole: json['bpmCurrentRole'] as String,
    bpmCurrentState: json['bpmCurrentState'] as String,
    companyPaperNumber: json['companyPaperNumber'] as String,
    credentialNumber: json['credentialNumber'] as String,
    custId: json['custId'] as int,
    custName: json['custName'] as String,
    custPhone: json['custPhone'] as String,
    decorateType: json['decorateType'] as int,
    houseId: json['houseId'] as int,
    houseName: json['houseName'] as String,
    id: json['id'] as int,
    manager: json['manager'] as String,
    managerIdCard: json['managerIdCard'] as String,
    managerPhone: json['managerPhone'] as String,
    oddNumber: json['oddNumber'] as String,
    postId: json['postId'] as int,
    processId: json['processId'] as String,
    programDesc: json['programDesc'] as String,
    programName: json['programName'] as String,
    projectId: json['projectId'] as int,
    state: json['state'] as String,
    userId: json['userId'] as int,
    workCompany: json['workCompany'] as String,
    workDayLong: json['workDayLong'] as int,
    workPeopleNum: json['workPeopleNum'] as int,
    businessNo: json['businessNo'] as String,
  );
}

Map<String, dynamic> _$DecorationRecordToJson(DecorationRecord instance) =>
    <String, dynamic>{
      'agree': instance.agree,
      'applyDate': instance.applyDate,
      'applyType': instance.applyType,
      'beginWorkDate': instance.beginWorkDate,
      'bpmCurrentRole': instance.bpmCurrentRole,
      'bpmCurrentState': instance.bpmCurrentState,
      'companyPaperNumber': instance.companyPaperNumber,
      'credentialNumber': instance.credentialNumber,
      'custId': instance.custId,
      'custName': instance.custName,
      'custPhone': instance.custPhone,
      'decorateType': instance.decorateType,
      'houseId': instance.houseId,
      'houseName': instance.houseName,
      'id': instance.id,
      'manager': instance.manager,
      'managerIdCard': instance.managerIdCard,
      'managerPhone': instance.managerPhone,
      'oddNumber': instance.oddNumber,
      'postId': instance.postId,
      'processId': instance.processId,
      'programDesc': instance.programDesc,
      'programName': instance.programName,
      'projectId': instance.projectId,
      'state': instance.state,
      'userId': instance.userId,
      'workCompany': instance.workCompany,
      'workDayLong': instance.workDayLong,
      'workPeopleNum': instance.workPeopleNum,
      'businessNo': instance.businessNo,
    };
