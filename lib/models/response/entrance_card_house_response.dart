import 'package:cmp_customer/models/response/base_response.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/ui/house_authentication/house_list.dart';
import 'package:json_annotation/json_annotation.dart';

part 'entrance_card_house_response.g.dart';


@JsonSerializable()
class EntranceCardHouseResponse extends BaseResponse {

  @JsonKey(name: 'data')
  List<HouseInfo> houseList;

  @JsonKey(name: 'extStr')
  String extStr;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'totalCount')
  int totalCount;

  EntranceCardHouseResponse(this.houseList,this.extStr,this.systemDate,this.totalCount,);

  factory EntranceCardHouseResponse.fromJson(Map<String, dynamic> srcJson) => _$EntranceCardHouseResponseFromJson(srcJson);

  Map<String, dynamic> toJson() => _$EntranceCardHouseResponseToJson(this);

}



