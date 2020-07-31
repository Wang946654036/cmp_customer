import 'package:json_annotation/json_annotation.dart';

import 'message_center_model.dart';

part 'message_with_count_model.g.dart';


@JsonSerializable()
class MessageWithCountModel extends Object {

  @JsonKey(name: 'appCodes')
  List<String> appCodes;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'data')
  MessageWithCount messageWithCount;

  @JsonKey(name: 'extStr')
  String extStr;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'totalCount')
  int totalCount;

  MessageWithCountModel(this.appCodes,this.code,this.messageWithCount,this.extStr,this.message,this.systemDate,this.totalCount,);

  factory MessageWithCountModel.fromJson(Map<String, dynamic> srcJson) => _$MessageWithCountModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MessageWithCountModelToJson(this);

}


@JsonSerializable()
class MessageWithCount extends Object {

  @JsonKey(name: 'messageSubVoList')
  List<MessageInfo> messageList;

  @JsonKey(name: 'yetReadMessageCount')
  int yetReadMessageCount;

  MessageWithCount(this.messageList,this.yetReadMessageCount,);

  factory MessageWithCount.fromJson(Map<String, dynamic> srcJson) => _$MessageWithCountFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MessageWithCountToJson(this);

}

