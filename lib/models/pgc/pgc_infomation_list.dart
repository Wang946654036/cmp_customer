import 'package:cmp_customer/models/pgc/pgc_infomation_obj.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pgc_infomation_list.g.dart';


@JsonSerializable()
class PgcInfomationList extends Object {

  @JsonKey(name: 'appCodes')
  List<String> appCodes;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'data')
  List<PgcInfomationInfo> pgcInfomationInfoList;

  @JsonKey(name: 'extStr')
  String extStr;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'totalCount')
  int totalCount;

  PgcInfomationList({this.appCodes,this.code,this.pgcInfomationInfoList,this.extStr,this.message,this.systemDate,this.totalCount,});

  factory PgcInfomationList.fromJson(Map<String, dynamic> srcJson) => _$PgcInfomationListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PgcInfomationListToJson(this);

}
