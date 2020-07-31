import 'package:json_annotation/json_annotation.dart';

part 'message_center_model.g.dart';

@JsonSerializable()
class MessageCenterModel extends Object {
  @JsonKey(name: 'appCodes')
  List<String> appCodes;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'data')
  List<MessageInfo> messageList;

  @JsonKey(name: 'extStr')
  String extStr;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'totalCount')
  int totalCount;

  MessageCenterModel(
    this.appCodes,
    this.code,
    this.messageList,
    this.extStr,
    this.message,
    this.systemDate,
    this.totalCount,
  );

  factory MessageCenterModel.fromJson(Map<String, dynamic> srcJson) => _$MessageCenterModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MessageCenterModelToJson(this);
}

@JsonSerializable()
class MessageInfo extends Object {
  @JsonKey(name: 'createTime')
  String createTime;

  @JsonKey(name: 'isDeleted')
  String isDeleted;

  @JsonKey(name: 'messageId')
  int messageId;

  @JsonKey(name: 'messageText')
  String messageText;

  @JsonKey(name: 'messageTitle')
  String messageTitle;
  //消息类型： GDXX:工单消息 YWBL:业务办理 QTXX:其他消息 HDXX:互动消息 JSLT:集市聊天
  @JsonKey(name: 'messageType')
  String messageType;

  @JsonKey(name: 'param')
  String param;

  @JsonKey(name: 'receiverId')
  int receiverId;

  @JsonKey(name: 'receiverType')
  String receiverType;

  @JsonKey(name: 'relatedId')
  int relatedId;

  @JsonKey(name: 'relatedTableName')
  String relatedTableName;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'subMessageType')
  String subMessageType;

  @JsonKey(name: 'yetReadMessageCount')
  int yetReadMessageCount;

  //消息是否未读(0:未读 1：已读)
  @JsonKey(name: 'isRead')
  String isRead;

  MessageInfo({
    this.createTime,
    this.isDeleted,
    this.messageId,
    this.messageText,
    this.messageTitle,
    this.messageType,
    this.param,
    this.receiverId,
    this.receiverType,
    this.relatedId,
    this.relatedTableName,
    this.status,
    this.subMessageType,
    this.yetReadMessageCount,
      this.isRead,
  });

  factory MessageInfo.fromJson(Map<String, dynamic> srcJson) => _$MessageInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MessageInfoToJson(this);
}
