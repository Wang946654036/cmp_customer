
import 'package:cmp_customer/models/change_title_obj.dart';
import 'package:json_annotation/json_annotation.dart';

part 'change_title_obj_list.g.dart';


@JsonSerializable()
class ChangeTitleObjList extends Object {

  @JsonKey(name: 'appCodes')
  List<String> appCodes;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'data')
  List<ChangeTitleInfo> data;

  @JsonKey(name: 'extStr')
  String extStr;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'totalCount')
  int totalCount;

  ChangeTitleObjList({this.appCodes,this.code,this.data,this.extStr,this.message,this.systemDate,this.totalCount,});

  factory ChangeTitleObjList.fromJson(Map<String, dynamic> srcJson) => _$ChangeTitleObjListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ChangeTitleObjListToJson(this);

}




