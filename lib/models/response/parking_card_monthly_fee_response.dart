import 'package:cmp_customer/models/response/parking_card_monthly_response.dart';
import 'package:json_annotation/json_annotation.dart';

import 'base_response.dart';

part 'parking_card_monthly_fee_response.g.dart';


@JsonSerializable()
class ParkingCardMonthlyFeeResponse extends BaseResponse {

  @JsonKey(name: 'data')
  ParkingCardMonthly data;

  ParkingCardMonthlyFeeResponse();

  factory ParkingCardMonthlyFeeResponse.fromJson(Map<String, dynamic> srcJson) => _$ParkingCardMonthlyFeeResponseFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ParkingCardMonthlyFeeResponseToJson(this);

}


