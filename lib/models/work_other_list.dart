import 'package:cmp_customer/models/work_other_obj.dart';
import 'package:json_annotation/json_annotation.dart';

part 'work_other_list.g.dart';


@JsonSerializable()
class WorkOtherList extends Object {

  @JsonKey(name: 'appCodes')
  List<String> appCodes;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'data')
  List<WorkOther> data;

  @JsonKey(name: 'extStr')
  String extStr;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'totalCount')
  int totalCount;

  WorkOtherList({this.appCodes,this.code,this.data,this.extStr,this.message,this.systemDate,this.totalCount,});

  factory WorkOtherList.fromJson(Map<String, dynamic> srcJson) => _$WorkOtherListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$WorkOtherListToJson(this);

}




