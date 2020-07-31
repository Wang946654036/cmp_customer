import 'package:json_annotation/json_annotation.dart';

import 'base_response.dart';

part 'parking_card_monthly_response.g.dart';


@JsonSerializable()
class ParkingCardMonthlyResponse extends BaseResponse {

  @JsonKey(name: 'data')
  List<ParkingCardMonthly> data;

  ParkingCardMonthlyResponse();

  factory ParkingCardMonthlyResponse.fromJson(Map<String, dynamic> srcJson) => _$ParkingCardMonthlyResponseFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ParkingCardMonthlyResponseToJson(this);

}


@JsonSerializable()
class ParkingCardMonthly extends Object {

  @JsonKey(name: 'community')
  String community;

  @JsonKey(name: 'communityName')
  String communityName;

  @JsonKey(name: 'end')
  String end;

  @JsonKey(name: 'fee')
  int fee;

  @JsonKey(name: 'mobile')
  String mobile;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'park_id')
  int parkId;

  @JsonKey(name: 'park_name')
  String parkName;

  @JsonKey(name: 'plate')
  String plate;

  @JsonKey(name: 'price')
  String price;

  @JsonKey(name: 'price_id')
  int priceId;

  @JsonKey(name: 'price_name')
  String priceName;

  @JsonKey(name: 'start')
  String start;

  ParkingCardMonthly(this.community,this.communityName,this.end,this.fee,this.mobile,this.name,this.parkId,this.parkName,this.plate,this.price,this.priceId,this.priceName,this.start,);

  factory ParkingCardMonthly.fromJson(Map<String, dynamic> srcJson) => _$ParkingCardMonthlyFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ParkingCardMonthlyToJson(this);

}


