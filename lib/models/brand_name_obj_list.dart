
import 'package:cmp_customer/models/brand_name_obj.dart';
import 'package:cmp_customer/models/change_title_obj.dart';
import 'package:json_annotation/json_annotation.dart';

part 'brand_name_obj_list.g.dart';


@JsonSerializable()
class BrandNameObjList extends Object {

  @JsonKey(name: 'appCodes')
  List<String> appCodes;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'data')
  List<BrandNameInfo> data;

  @JsonKey(name: 'extStr')
  String extStr;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'totalCount')
  int totalCount;

  BrandNameObjList({this.appCodes,this.code,this.data,this.extStr,this.message,this.systemDate,this.totalCount,});

  factory BrandNameObjList.fromJson(Map<String, dynamic> srcJson) => _$BrandNameObjListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BrandNameObjListToJson(this);

}




