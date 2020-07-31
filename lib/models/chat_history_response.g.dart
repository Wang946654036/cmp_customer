// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_history_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatHistoryResponse _$ChatHistoryResponseFromJson(Map<String, dynamic> json) {
  return ChatHistoryResponse(
    json['data'] == null
        ? null
        : ChatHistory.fromJson(json['data'] as Map<String, dynamic>),
  )
    ..code = json['code'] as String
    ..message = json['message'] as String;
}

Map<String, dynamic> _$ChatHistoryResponseToJson(
        ChatHistoryResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

ChatHistory _$ChatHistoryFromJson(Map<String, dynamic> json) {
  return ChatHistory(
    goodsId: json['goodsId'] as int,
    goodsPhotoId: json['goodsPhotoId'] as String,
    onLineChatId: json['onLineChatId'] as int,
    onLineChatRecordList: (json['onLineChatRecordList'] as List)
        ?.map((e) =>
            e == null ? null : ChatRecord.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    businessId: json['businessId'] as int,
    businessNickName: json['businessNickName'] as String,
    businessPhotoId: json['businessPhotoId'] as String,
    customerId: json['customerId'] as int,
    customerNickName: json['customerNickName'] as String,
    customerPhotoId: json['customerPhotoId'] as String,
    createTime: json['createTime'] as String,
    updateTime: json['updateTime'] as String,
    chatId: json['chatId'] as int,
    recvId: json['recvId'] as int,
    sendId: json['sendId'] as int,
    message: json['message'] as String,
    sendName: json['sendName'] as String,
    pushTime: json['pushTime'] as String,
    unReadCount: json['unReadCount'] as int,
  );
}

Map<String, dynamic> _$ChatHistoryToJson(ChatHistory instance) =>
    <String, dynamic>{
      'goodsId': instance.goodsId,
      'goodsPhotoId': instance.goodsPhotoId,
      'onLineChatId': instance.onLineChatId,
      'onLineChatRecordList': instance.onLineChatRecordList,
      'businessId': instance.businessId,
      'businessNickName': instance.businessNickName,
      'businessPhotoId': instance.businessPhotoId,
      'customerId': instance.customerId,
      'customerNickName': instance.customerNickName,
      'customerPhotoId': instance.customerPhotoId,
      'createTime': instance.createTime,
      'updateTime': instance.updateTime,
      'chatId': instance.chatId,
      'recvId': instance.recvId,
      'sendId': instance.sendId,
      'sendName': instance.sendName,
      'message': instance.message,
      'pushTime': instance.pushTime,
      'unReadCount': instance.unReadCount,
    };

ChatRecord _$ChatRecordFromJson(Map<String, dynamic> json) {
  return ChatRecord(
    chatId: json['chatId'] as int,
    chatRecordId: json['chatRecordId'] as int,
    sendId: json['sendId'] as int,
    receiveId: json['receiveId'] as int,
    content: json['content'] as String,
    sendTime: json['sendTime'] as String,
    senderPhotoId: json['senderPhotoId'] as String,
    sendName: json['sendName'] as String,
    showDateTime: json['showDateTime'] as bool,
    status: json['status'] as int,
  );
}

Map<String, dynamic> _$ChatRecordToJson(ChatRecord instance) =>
    <String, dynamic>{
      'chatId': instance.chatId,
      'chatRecordId': instance.chatRecordId,
      'sendId': instance.sendId,
      'receiveId': instance.receiveId,
      'content': instance.content,
      'sendTime': instance.sendTime,
      'senderPhotoId': instance.senderPhotoId,
      'sendName': instance.sendName,
      'showDateTime': instance.showDateTime,
      'status': instance.status,
    };
