import 'package:cmp_customer/models/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'parking_card_cars_response.g.dart';


@JsonSerializable()
class ParkingCardCarsResponse extends BaseResponse {

  @JsonKey(name: 'data')
  List<String> custCars;

  ParkingCardCarsResponse(this.custCars,);

  factory ParkingCardCarsResponse.fromJson(Map<String, dynamic> srcJson) => _$ParkingCardCarsResponseFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ParkingCardCarsResponseToJson(this);

}


