import 'package:cmp_customer/models/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ware_project_response.g.dart';


@JsonSerializable()
class WareProjectResponse extends BaseResponse{

  @JsonKey(name: 'data')
  List<ProjectInfo> data;

  WareProjectResponse({this.data});

  factory WareProjectResponse.fromJson(Map<String, dynamic> srcJson) => _$WareProjectResponseFromJson(srcJson);

}

@JsonSerializable()
class ProjectInfo extends Object {

  @JsonKey(name: 'area')
  String area;

  @JsonKey(name: 'city')
  String city;

  @JsonKey(name: 'projectId')
  int projectId;

  @JsonKey(name: 'projectCode')
  String projectCode;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'status')
  String status;


  ProjectInfo({this.area,this.city,this.projectId,this.projectCode,this.name,this.status,});

  factory ProjectInfo.fromJson(Map<String, dynamic> srcJson) => _$ProjectInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProjectInfoToJson(this);

}