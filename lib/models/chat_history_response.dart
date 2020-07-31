import 'package:cmp_customer/models/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';


part 'chat_history_response.g.dart';


@JsonSerializable()
class ChatHistoryResponse extends BaseResponse {

  @JsonKey(name: 'data')
  ChatHistory data;

  ChatHistoryResponse(this.data);

  factory ChatHistoryResponse.fromJson(Map<String, dynamic> srcJson) => _$ChatHistoryResponseFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ChatHistoryResponseToJson(this);

}


@JsonSerializable()
class ChatHistory extends Object {

  @JsonKey(name: 'goodsId')
  int goodsId;

  @JsonKey(name: 'goodsPhotoId')
  String goodsPhotoId;

  @JsonKey(name: 'onLineChatId')
  int onLineChatId;

  @JsonKey(name: 'onLineChatRecordList')
  List<ChatRecord> onLineChatRecordList;

  @JsonKey(name: 'businessId')
  int businessId;

  @JsonKey(name: 'businessNickName')
  String businessNickName;

  @JsonKey(name: 'businessPhotoId')
  String businessPhotoId;

  @JsonKey(name: 'customerId')
  int customerId;

  @JsonKey(name: 'customerNickName')
  String customerNickName;

  @JsonKey(name: 'customerPhotoId')
  String customerPhotoId;

  @JsonKey(name: 'createTime')
  String createTime;

  @JsonKey(name: 'updateTime')
  String updateTime;

  @JsonKey(name: 'chatId')
  int chatId;

  @JsonKey(name: 'recvId')
  int recvId;

  @JsonKey(name: 'sendId')
  int sendId;

  @JsonKey(name: 'sendName')
  String sendName;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'pushTime')
  String pushTime;

  @JsonKey(name: 'unReadCount')
  int unReadCount;

  ChatHistory({this.goodsId,this.goodsPhotoId,this.onLineChatId,this.onLineChatRecordList,this.businessId,this.businessNickName,this.businessPhotoId,this.customerId,this.customerNickName,this.customerPhotoId,this.createTime,this.updateTime,this.chatId,this.recvId,this.sendId,this.message,this.sendName,this.pushTime,this.unReadCount});

  factory ChatHistory.fromJson(Map<String, dynamic> srcJson) => _$ChatHistoryFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ChatHistoryToJson(this);

}

@JsonSerializable()
class ChatRecord extends Object {

  @JsonKey(name: 'chatId')
  int chatId;

  @JsonKey(name: 'chatRecordId')
  int chatRecordId;

  @JsonKey(name: 'sendId')
  int sendId;

  @JsonKey(name: 'receiveId')
  int receiveId;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'sendTime')
  String sendTime;

  @JsonKey(name: 'senderPhotoId')
  String senderPhotoId;

  @JsonKey(name: 'sendName')
  String sendName;

  @JsonKey(name: 'showDateTime')
  bool showDateTime;

  @JsonKey(name: 'status')
  int status;//0未读，1已读

  ChatRecord({this.chatId,this.chatRecordId,this.sendId,this.receiveId,this.content,this.sendTime,this.senderPhotoId,this.sendName,this.showDateTime,this.status});

  factory ChatRecord.fromJson(Map<String, dynamic> srcJson) => _$ChatRecordFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ChatRecordToJson(this);

}



