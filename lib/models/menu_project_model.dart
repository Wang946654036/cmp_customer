import 'package:json_annotation/json_annotation.dart';

import 'user_data_model.dart';

part 'menu_project_model.g.dart';


@JsonSerializable()
class MenuProjectModel extends Object{

  @JsonKey(name: 'appCodes')
  List<String> appCodes;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'data')
  List<MenuInfo> menuProjectList;

  @JsonKey(name: 'extStr')
  String extStr;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'totalCount')
  int totalCount;

  MenuProjectModel({this.appCodes,this.code,this.menuProjectList,this.extStr,this.message,this.systemDate,this.totalCount,});

  factory MenuProjectModel.fromJson(Map<String, dynamic> srcJson) => _$MenuProjectModelFromJson(srcJson);

}



