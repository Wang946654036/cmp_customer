import 'package:cmp_customer/models/request/base_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'decoration_pass_card_history_request.g.dart';


@JsonSerializable()
class DecorationPassCardHistoryRequest extends BaseRequest {

  @JsonKey(name: 'projectId')
  String projectId;

  @JsonKey(name: 'ownerId')
  String ownerId;

  @JsonKey(name: 'customerId')
  String customerId;

  DecorationPassCardHistoryRequest();

  factory DecorationPassCardHistoryRequest.fromJson(Map<String, dynamic> srcJson) => _$DecorationPassCardHistoryRequestFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DecorationPassCardHistoryRequestToJson(this);

}


