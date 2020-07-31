import 'package:cmp_customer/models/meetingroom/reserve_info.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reserve_info_obj.g.dart';

@JsonSerializable()
class ReserveInfoObj extends Object {

  @JsonKey(name: 'appCodes')
  List<String> appCodes;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'data')
  ReserveInfo data;

  @JsonKey(name: 'extStr')
  String extStr;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'totalCount')
  int totalCount;

  ReserveInfoObj({this.appCodes,this.code,this.data,this.extStr,this.message,this.systemDate,this.totalCount,});

  factory ReserveInfoObj.fromJson(Map<String, dynamic> srcJson) => _$ReserveInfoObjFromJson(srcJson);

}