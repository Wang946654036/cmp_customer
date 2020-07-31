import 'package:json_annotation/json_annotation.dart';

part 'community_certified_model.g.dart';


@JsonSerializable()
class CommunityCertifiedModel extends Object {

  @JsonKey(name: 'appCodes')
  List<String> appCodes;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'data')
  List<CommunityCertified> communityCertifiedList;

  @JsonKey(name: 'extStr')
  String extStr;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'totalCount')
  int totalCount;

  CommunityCertifiedModel(this.appCodes,this.code,this.communityCertifiedList,this.extStr,this.message,this.systemDate,this.totalCount,);

  factory CommunityCertifiedModel.fromJson(Map<String, dynamic> srcJson) => _$CommunityCertifiedModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CommunityCertifiedModelToJson(this);

}


@JsonSerializable()
class CommunityCertified extends Object {

  ///1:默认；0：不是默认
  @JsonKey(name: 'isDefaultProject')
  String isDefaultProject;

  @JsonKey(name: 'projectId')
  int projectId;

  @JsonKey(name: 'projectName')
  String projectName;

  @JsonKey(name: 'formerName')
  String formerName;

  @JsonKey(name: 'status')
  String status;

  CommunityCertified(this.isDefaultProject,this.projectId,this.projectName,this.status,this.formerName);

  factory CommunityCertified.fromJson(Map<String, dynamic> srcJson) => _$CommunityCertifiedFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CommunityCertifiedToJson(this);

}


