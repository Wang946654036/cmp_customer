import 'package:cmp_customer/models/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'parking_card_price_response.g.dart';

//根据套餐id返回的套餐详情
@JsonSerializable()
class ParkingCardPriceResponse extends BaseResponse {

  @JsonKey(name: 'data')
  List<ParkingCardPrices> prices;//套餐列表

  ParkingCardPriceResponse();

  factory ParkingCardPriceResponse.fromJson(Map<String, dynamic> srcJson) => _$ParkingCardPriceResponseFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ParkingCardPriceResponseToJson(this);

}


@JsonSerializable()
class ParkingCardPrices extends Object {


  @JsonKey(name: 'park_name')
  String parkName;//停车场名称（仅用于列表显示与选中）

  @JsonKey(name: 'park_id')
  int parkId;//停车场名称（仅用于列表显示与选中）

  @JsonKey(name: 'name')
  String priceName;//套餐名称

  @JsonKey(name: 'price_id')
  int priceId;//套餐id

  @JsonKey(name: 'price')
  String price;//套餐价格

  ParkingCardPrices({this.parkId,this.parkName,this.priceId,this.priceName,this.price});

  factory ParkingCardPrices.fromJson(Map<String, dynamic> srcJson) => _$ParkingCardPricesFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ParkingCardPricesToJson(this);

}