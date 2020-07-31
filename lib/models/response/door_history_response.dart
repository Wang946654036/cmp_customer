import 'package:cmp_customer/models/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'door_history_response.g.dart';


@JsonSerializable()
class DoorHistoryResponse extends BaseResponse{

  @JsonKey(name: 'data')
  List<DoorList> doorList;

  DoorHistoryResponse(this.doorList);

  factory DoorHistoryResponse.fromJson(Map<String, dynamic> srcJson) => _$DoorHistoryResponseFromJson(srcJson);

}


@JsonSerializable()
class DoorList extends Object{

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'mobile')
  String mobile;

  @JsonKey(name: 'userType')
  String userType;

  @JsonKey(name: 'projectId')
  int projectId;

  @JsonKey(name: 'projectName')
  String projectName;

  @JsonKey(name: 'projectLocalName')
  String projectLocalName;

  @JsonKey(name: 'gateName')
  String gateName;

  @JsonKey(name: 'result')
  String result;

  @JsonKey(name: 'createTime')
  String createTime;

  DoorList(this.id,this.name,this.mobile,this.userType,this.projectId,this.projectName,this.gateName,this.result,this.createTime,);

  factory DoorList.fromJson(Map<String, dynamic> srcJson) => _$DoorListFromJson(srcJson);

}


