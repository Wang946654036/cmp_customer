import 'package:cmp_customer/models/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'parking_card_prices_response.g.dart';


@JsonSerializable()
class ParkingCardPricesResponse extends BaseResponse {

  @JsonKey(name: 'appCodes')
  List<String> appCodes;

  @JsonKey(name: 'data')
  List<ParkingCardPackage> parkingCardPackages;

  @JsonKey(name: 'extStr')
  String extStr;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'totalCount')
  int totalCount;

  ParkingCardPricesResponse({this.appCodes,this.parkingCardPackages,this.extStr,this.systemDate,this.totalCount,});

  factory ParkingCardPricesResponse.fromJson(Map<String, dynamic> srcJson) => _$ParkingCardPricesResponseFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ParkingCardPricesResponseToJson(this);

}


@JsonSerializable()
class ParkingCardPackage extends Object {

  @JsonKey(name: 'name')
  String parkName;//停车场名称

  @JsonKey(name: 'park_id')
  int parkId;//停车场id

  @JsonKey(name: 'price')
  List<ParkingCardPrices> prices;//套餐列表

  ParkingCardPackage(this.parkName,this.parkId,this.prices,);

  factory ParkingCardPackage.fromJson(Map<String, dynamic> srcJson) => _$ParkingCardPackageFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ParkingCardPackageToJson(this);

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


