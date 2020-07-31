import 'package:cmp_customer/models/response/base_response.dart';
import 'package:cmp_customer/models/response/entrance_card_details_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'entrance_card_list_response.g.dart';


@JsonSerializable()
class EntranceCardListResponse extends BaseResponse {

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'data')
  List<EntranceCardDetailsInfo> entranceCardDetailsList;

  EntranceCardListResponse(this.systemDate,this.entranceCardDetailsList);

  factory EntranceCardListResponse.fromJson(Map<String, dynamic> srcJson) => _$EntranceCardListResponseFromJson(srcJson);

  Map<String, dynamic> toJson() => _$EntranceCardListResponseToJson(this);

}


