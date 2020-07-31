import 'package:json_annotation/json_annotation.dart';

import '../user_data_model.dart';
import 'base_response.dart';

part 'decoration_pass_card_effect_date_response.g.dart';


@JsonSerializable()
class DecorationPassCardEffectDateResponse extends BaseResponse{

  @JsonKey(name: 'data')
  DecorationPassCardEffectDate effectDate;

  DecorationPassCardEffectDateResponse();

  factory DecorationPassCardEffectDateResponse.fromJson(Map<String, dynamic> srcJson) => _$DecorationPassCardEffectDateResponseFromJson(srcJson);

}


@JsonSerializable()
class DecorationPassCardEffectDate extends Object{

  @JsonKey(name: 'fromDate')
  String fromDate;//有效开始时间

  @JsonKey(name: 'delayDate')
  String delayDate;//有效截止时间

  DecorationPassCardEffectDate(this.fromDate,this.delayDate,);

  factory DecorationPassCardEffectDate.fromJson(Map<String, dynamic> srcJson) => _$DecorationPassCardEffectDateFromJson(srcJson);

}


