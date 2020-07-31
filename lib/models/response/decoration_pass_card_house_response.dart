import 'package:json_annotation/json_annotation.dart';

import '../user_data_model.dart';
import 'base_response.dart';

part 'decoration_pass_card_house_response.g.dart';

@JsonSerializable()
class DecorationPassCardHouseResponse extends BaseResponse {
  @JsonKey(name: 'data')
  List<DecorationPassCardHouse> houseList;

  DecorationPassCardHouseResponse();

  factory DecorationPassCardHouseResponse.fromJson(Map<String, dynamic> srcJson) =>
      _$DecorationPassCardHouseResponseFromJson(srcJson);
}

@JsonSerializable()
class DecorationPassCardHouse extends Object {
  @JsonKey(name: 'projectId')
  int projectId;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'formerName')
  String formerName;

  @JsonKey(name: 'houseVoList')
  List<HouseInfo> houseVoList;

  DecorationPassCardHouse(
    this.projectId,
    this.name,
    this.formerName,
    this.houseVoList,
  );

  factory DecorationPassCardHouse.fromJson(Map<String, dynamic> srcJson) =>
      _$DecorationPassCardHouseFromJson(srcJson);
}
