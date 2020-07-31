import 'package:cmp_customer/models/response/base_response.dart';
import 'package:cmp_customer/models/response/parking_card_details_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'parking_card_mine_response.g.dart';

@JsonSerializable()
class ParkingCardMineResponse extends BaseResponse {

  @JsonKey(name: 'data')
  List<ParkingCardDetailsInfo> parkingCardDetailsList;

  ParkingCardMineResponse({this.parkingCardDetailsList,});

  factory ParkingCardMineResponse.fromJson(Map<String, dynamic> srcJson) => _$ParkingCardMineResponseFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ParkingCardMineResponseToJson(this);

}