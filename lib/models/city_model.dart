import 'package:azlistview/azlistview.dart';
import 'package:json_annotation/json_annotation.dart';

part 'city_model.g.dart';

///运行 flutter packages pub run build_runner build 生成x.g.dart文件
///运行 flutter packages pub run build_runner watch 可开启watch监控变化
@JsonSerializable()
class CityModel extends Object {
  @JsonKey(name: 'cityInfo')
  List<CityInfo> cityList = List();

  CityModel(this.cityList);

  factory CityModel.fromJson(Map<String, dynamic> srcJson) => _$CityModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CityModelToJson(this);
}

@JsonSerializable()
class CityInfo extends ISuspensionBean {
  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'provinceName')
  String provinceName;

  @JsonKey(name: 'provinceCode')
  String provinceCode;

  @JsonKey(name: 'countryName')
  String countryName;

  @JsonKey(name: 'countryCode')
  String countryCode;

  @JsonKey(name: 'subName')
  String subName;

  @JsonKey(name: 'tagIndex')
  String tagIndex;

  @JsonKey(name: 'namePinyin')
  String namePinyin;

  CityInfo(
      {this.name,
      this.code,
      this.countryName,
      this.countryCode,
      this.provinceCode,
      this.provinceName,
      this.subName,
      this.tagIndex,
      this.namePinyin});

  factory CityInfo.fromJson(Map<String, dynamic> srcJson) => _$CityInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CityInfoToJson(this);

  @override
  String getSuspensionTag() => tagIndex;

//  @override
//  String toString() => "CityBean {" + " \"name\":\"" + name + "\" + " + " \"countryName\":\"" + countryName + "\"" + '}';
}
