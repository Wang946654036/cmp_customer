import 'package:cmp_customer/models/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'parking_card_pay_info_response.g.dart';


@JsonSerializable()
class ParkingCardPayInfoResponse extends BaseResponse {


  @JsonKey(name: 'data')
  String url;

  @JsonKey(name: 'extStr')
  String extStr;

  ParkingCardPayInfoResponse(this.url,this.extStr,);

  factory ParkingCardPayInfoResponse.fromJson(Map<String, dynamic> srcJson) => _$ParkingCardPayInfoResponseFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ParkingCardPayInfoResponseToJson(this);

}


//@JsonSerializable()
//class ParkingCardPayInfo extends Object {
//
//  @JsonKey(name: 'id')
//  String id;
//
//  @JsonKey(name: 'url')
//  String url;
//
//  ParkingCardPayInfo(this.id,this.url,);
//
//  factory ParkingCardPayInfo.fromJson(Map<String, dynamic> srcJson) => _$ParkingCardPayInfoFromJson(srcJson);
//
//  Map<String, dynamic> toJson() => _$ParkingCardPayInfoToJson(this);
//
//}


