import 'package:cmp_customer/models/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

import 'chat_history_response.dart';


part 'chat_list_response.g.dart';


@JsonSerializable()
class ChatListResponse extends BaseResponse {

  @JsonKey(name: 'data')
  List<ChatHistory> data;

  ChatListResponse(this.data);

  factory ChatListResponse.fromJson(Map<String, dynamic> srcJson) => _$ChatListResponseFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ChatListResponseToJson(this);

}



