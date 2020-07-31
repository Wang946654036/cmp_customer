// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_center_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageCenterModel _$MessageCenterModelFromJson(Map<String, dynamic> json) {
  return MessageCenterModel(
    (json['appCodes'] as List)?.map((e) => e as String)?.toList(),
    json['code'] as String,
    (json['data'] as List)
        ?.map((e) =>
            e == null ? null : MessageInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['extStr'] as String,
    json['message'] as String,
    json['systemDate'] as String,
    json['totalCount'] as int,
  );
}

Map<String, dynamic> _$MessageCenterModelToJson(MessageCenterModel instance) =>
    <String, dynamic>{
      'appCodes': instance.appCodes,
      'code': instance.code,
      'data': instance.messageList,
      'extStr': instance.extStr,
      'message': instance.message,
      'systemDate': instance.systemDate,
      'totalCount': instance.totalCount,
    };

MessageInfo _$MessageInfoFromJson(Map<String, dynamic> json) {
  return MessageInfo(
    createTime: json['createTime'] as String,
    isDeleted: json['isDeleted'] as String,
    messageId: json['messageId'] as int,
    messageText: json['messageText'] as String,
    messageTitle: json['messageTitle'] as String,
    messageType: json['messageType'] as String,
    param: json['param'] as String,
    receiverId: json['receiverId'] as int,
    receiverType: json['receiverType'] as String,
    relatedId: json['relatedId'] as int,
    relatedTableName: json['relatedTableName'] as String,
    status: json['status'] as String,
    subMessageType: json['subMessageType'] as String,
    yetReadMessageCount: json['yetReadMessageCount'] as int,
    isRead: json['isRead'] as String,
  );
}

Map<String, dynamic> _$MessageInfoToJson(MessageInfo instance) =>
    <String, dynamic>{
      'createTime': instance.createTime,
      'isDeleted': instance.isDeleted,
      'messageId': instance.messageId,
      'messageText': instance.messageText,
      'messageTitle': instance.messageTitle,
      'messageType': instance.messageType,
      'param': instance.param,
      'receiverId': instance.receiverId,
      'receiverType': instance.receiverType,
      'relatedId': instance.relatedId,
      'relatedTableName': instance.relatedTableName,
      'status': instance.status,
      'subMessageType': instance.subMessageType,
      'yetReadMessageCount': instance.yetReadMessageCount,
      'isRead': instance.isRead,
    };
