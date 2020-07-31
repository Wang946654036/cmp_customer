import 'package:json_annotation/json_annotation.dart';

part 'near_info_list.g.dart';


@JsonSerializable()
class NearInfoList extends Object {

  @JsonKey(name: 'appCodes')
  List<String> appCodes;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'data')
  List<NearInfo> data;

  @JsonKey(name: 'extStr')
  String extStr;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'totalCount')
  int totalCount;

  NearInfoList({this.appCodes,this.code,this.data,this.extStr,this.message,this.systemDate,this.totalCount,});

  factory NearInfoList.fromJson(Map<String, dynamic> srcJson) => _$NearInfoListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$NearInfoListToJson(this);

}


@JsonSerializable()
class NearInfo extends Object {

  @JsonKey(name: 'address')
  String address;

  @JsonKey(name: 'linkPerson')
  String linkPerson;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'nearId')
  int nearId;

  @JsonKey(name: 'projectId')
  int projectId;

  @JsonKey(name: 'tel')
  String tel;

  NearInfo(this.address,this.linkPerson,this.name,this.nearId,this.projectId,this.tel,);

  factory NearInfo.fromJson(Map<String, dynamic> srcJson) => _$NearInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$NearInfoToJson(this);

}


