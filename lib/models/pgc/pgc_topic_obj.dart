import 'package:json_annotation/json_annotation.dart';

part 'pgc_topic_obj.g.dart';


@JsonSerializable()
class PgcTopicObj extends Object {

  @JsonKey(name: 'appCodes')
  List<String> appCodes;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'data')
  PgcTopicInfo pgcTopicInfo;

  @JsonKey(name: 'extStr')
  String extStr;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'totalCount')
  int totalCount;

  PgcTopicObj(this.appCodes,this.code,this.pgcTopicInfo,this.extStr,this.message,this.systemDate,this.totalCount,);

  factory PgcTopicObj.fromJson(Map<String, dynamic> srcJson) => _$PgcTopicObjFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PgcTopicObjToJson(this);

}
@JsonSerializable()
class PgcTopicInfo extends Object {

  PgcTopicInfo();

  factory PgcTopicInfo.fromJson(Map<String, dynamic> srcJson) => _$PgcTopicInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PgcTopicInfoToJson(this);


}