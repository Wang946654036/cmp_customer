import 'package:json_annotation/json_annotation.dart';

part 'map_info_model.g.dart';


@JsonSerializable()
class MapInfoModel extends Object {

  @JsonKey(name: 'longitude')
  double longitude;//经度

  @JsonKey(name: 'latitude')
  double latitude;//纬度

  @JsonKey(name: 'address')
  String address;//名称或地址

  @JsonKey(name: 'map')
  String map;//类型

  MapInfoModel(this.longitude,this.latitude,this.address,this.map);

  factory MapInfoModel.fromJson(Map<String, dynamic> srcJson) => _$MapInfoModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MapInfoModelToJson(this);

}


