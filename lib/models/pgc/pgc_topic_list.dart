import 'package:cmp_customer/models/pgc/pgc_topic_obj.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pgc_topic_list.g.dart';


@JsonSerializable()
class PgcTopicList extends Object {

  @JsonKey(name: 'appCodes')
  List<String> appCodes;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'data')
  List<PgcTopicInfo> pgcTopicInfoList;

  @JsonKey(name: 'extStr')
  String extStr;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'totalCount')
  int totalCount;

  PgcTopicList({this.appCodes,this.code,this.pgcTopicInfoList,this.extStr,this.message,this.systemDate,this.totalCount,});

  factory PgcTopicList.fromJson(Map<String, dynamic> srcJson) => _$PgcTopicListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PgcTopicListToJson(this);

}
