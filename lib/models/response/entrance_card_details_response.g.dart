// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entrance_card_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EntranceCardDetailsResponse _$EntranceCardDetailsResponseFromJson(
    Map<String, dynamic> json) {
  return EntranceCardDetailsResponse(
    json['systemDate'] as String,
    json['data'] == null
        ? null
        : EntranceCardDetailsInfo.fromJson(
            json['data'] as Map<String, dynamic>),
  )
    ..code = json['code'] as String
    ..message = json['message'] as String;
}

Map<String, dynamic> _$EntranceCardDetailsResponseToJson(
        EntranceCardDetailsResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'systemDate': instance.systemDate,
      'data': instance.entranceCardDetailsInfo,
    };

EntranceCardDetailsInfo _$EntranceCardDetailsInfoFromJson(
    Map<String, dynamic> json) {
  return EntranceCardDetailsInfo(
    accessCardId: json['accessCardId'] as int,
    projectId: json['projectId'] as int,
    houseId: json['houseId'] as int,
    ownerId: json['ownerId'] as int,
    settingId: json['settingId'] as int,
    businessNo: json['businessNo'] as String,
    customerId: json['customerId'] as int,
    customerType: json['customerType'] as String,
    customerPhone: json['customerPhone'] as String,
    applyCount: json['applyCount'] as int,
    reason: json['reason'] as String,
    payFees: (json['payFees'] as num)?.toDouble(),
    status: json['status'] as String,
    createTime: json['createTime'] as String,
    updateTime: json['updateTime'] as String,
    recordList: (json['recordList'] as List)
        ?.map((e) =>
            e == null ? null : RecordList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    formerName: json['formerName'] as String,
  )
    ..projectName = json['projectName'] as String
    ..buildName = json['buildName'] as String
    ..unitName = json['unitName'] as String
    ..houseNo = json['houseNo'] as String
    ..customerName = json['customerName'] as String
    ..statusDesc = json['statusDesc'] as String
    ..attHeadList =
        (json['attHeadList'] as List)?.map((e) => e as String)?.toList()
    ..attSfzList =
        (json['attSfzList'] as List)?.map((e) => e as String)?.toList()
    ..attJfpjList =
        (json['attJfpjList'] as List)?.map((e) => e as String)?.toList()
    ..attMjkfjList = (json['attMjkfjList'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$EntranceCardDetailsInfoToJson(
        EntranceCardDetailsInfo instance) =>
    <String, dynamic>{
      'accessCardId': instance.accessCardId,
      'projectId': instance.projectId,
      'projectName': instance.projectName,
      'formerName': instance.formerName,
      'buildName': instance.buildName,
      'unitName': instance.unitName,
      'houseNo': instance.houseNo,
      'houseId': instance.houseId,
      'ownerId': instance.ownerId,
      'settingId': instance.settingId,
      'businessNo': instance.businessNo,
      'customerId': instance.customerId,
      'customerName': instance.customerName,
      'customerType': instance.customerType,
      'customerPhone': instance.customerPhone,
      'applyCount': instance.applyCount,
      'reason': instance.reason,
      'payFees': instance.payFees,
      'status': instance.status,
      'statusDesc': instance.statusDesc,
      'createTime': instance.createTime,
      'updateTime': instance.updateTime,
      'attHeadList': instance.attHeadList,
      'attSfzList': instance.attSfzList,
      'attJfpjList': instance.attJfpjList,
      'attMjkfjList': instance.attMjkfjList,
      'recordList': instance.recordList,
    };

RecordList _$RecordListFromJson(Map<String, dynamic> json) {
  return RecordList(
    json['recordId'] as int,
    json['accessCardId'] as int,
    json['status'] as String,
    json['attachmentFlag'] as String,
    json['creatorId'] as int,
    json['createTime'] as String,
    (json['attHeadList'] as List)?.map((e) => e as String)?.toList(),
    (json['attSfzList'] as List)?.map((e) => e as String)?.toList(),
    json['remark'] as String,
    json['operateStep'] as String,
    (json['attJfpjList'] as List)?.map((e) => e as String)?.toList(),
  )
    ..operateStepDesc = json['operateStepDesc'] as String
    ..statusDesc = json['statusDesc'] as String
    ..attMjkfjList = (json['attMjkfjList'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$RecordListToJson(RecordList instance) =>
    <String, dynamic>{
      'recordId': instance.recordId,
      'accessCardId': instance.accessCardId,
      'status': instance.status,
      'attachmentFlag': instance.attachmentFlag,
      'creatorId': instance.creatorId,
      'createTime': instance.createTime,
      'attHeadList': instance.attHeadList,
      'attSfzList': instance.attSfzList,
      'remark': instance.remark,
      'operateStep': instance.operateStep,
      'operateStepDesc': instance.operateStepDesc,
      'statusDesc': instance.statusDesc,
      'attJfpjList': instance.attList,
      'attMjkfjList': instance.attMjkfjList,
    };

AttList _$AttListFromJson(Map<String, dynamic> json) {
  return AttList(
    json['id'] as int,
    json['source'] as String,
    json['type'] as String,
    json['relatedId'] as int,
    json['attachmentUuid'] as String,
    json['status'] as String,
    json['createTime'] as String,
  );
}

Map<String, dynamic> _$AttListToJson(AttList instance) => <String, dynamic>{
      'id': instance.id,
      'source': instance.source,
      'type': instance.type,
      'relatedId': instance.relatedId,
      'attachmentUuid': instance.attachmentUuid,
      'status': instance.status,
      'createTime': instance.createTime,
    };
