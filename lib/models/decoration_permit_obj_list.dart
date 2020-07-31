import 'package:json_annotation/json_annotation.dart';

import 'decoration_permit_obj.dart';

part 'decoration_permit_obj_list.g.dart';


@JsonSerializable()
class DecorationPermitObjList extends Object {

  @JsonKey(name: 'appCodes')
  List<String> appCodes;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'data')
  List<DecorationPermitInfo> data;

  @JsonKey(name: 'extStr')
  String extStr;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'totalCount')
  int totalCount;

  DecorationPermitObjList({this.appCodes,this.code,this.data,this.extStr,this.message,this.systemDate,this.totalCount,});

  factory DecorationPermitObjList.fromJson(Map<String, dynamic> srcJson) => _$DecorationPermitObjListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DecorationPermitObjListToJson(this);

}




