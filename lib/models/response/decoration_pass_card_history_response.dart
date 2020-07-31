import 'package:json_annotation/json_annotation.dart';

import 'base_response.dart';
import 'decoration_pass_card_details_response.dart';

part 'decoration_pass_card_history_response.g.dart';


@JsonSerializable()
class DecorationPassCardHistoryResponse extends BaseResponse{

  @JsonKey(name: 'data')
  List<DecorationPassCardDetails> historyList;

  DecorationPassCardHistoryResponse();

  factory DecorationPassCardHistoryResponse.fromJson(Map<String, dynamic> srcJson) => _$DecorationPassCardHistoryResponseFromJson(srcJson);

}


