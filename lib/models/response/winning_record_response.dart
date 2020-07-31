import 'package:cmp_customer/models/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'winning_record_response.g.dart';


@JsonSerializable()
class WinningRecordResponse extends BaseResponse {

  @JsonKey(name: 'data')
  List<WinningRecord> data;

  WinningRecordResponse(this.data);

  factory WinningRecordResponse.fromJson(Map<String, dynamic> srcJson) => _$WinningRecordResponseFromJson(srcJson);

  Map<String, dynamic> toJson() => _$WinningRecordResponseToJson(this);

}


@JsonSerializable()
class WinningRecord extends Object {

  @JsonKey(name: 'activityId')
  int activityId;

  @JsonKey(name: 'activityName')
  String activityName;

  @JsonKey(name: 'houseId')
  int houseId;

  @JsonKey(name: 'houseName')
  String houseName;

  @JsonKey(name: 'orgId')
  int orgId;

  @JsonKey(name: 'prizeName')
  String prizeName;

  @JsonKey(name: 'projectId')
  int projectId;

  @JsonKey(name: 'projectName')
  String projectName;

  @JsonKey(name: 'sendStatus')
  String sendStatus;

  @JsonKey(name: 'userId')
  int userId;

  @JsonKey(name: 'winningManagementId')
  int winningManagementId;

  @JsonKey(name: 'winningTime')
  String winningTime;

  WinningRecord(this.activityId,this.activityName,this.houseId,this.houseName,this.orgId,this.prizeName,this.projectId,this.projectName,this.sendStatus,this.userId,this.winningManagementId,this.winningTime,);

  factory WinningRecord.fromJson(Map<String, dynamic> srcJson) => _$WinningRecordFromJson(srcJson);

  Map<String, dynamic> toJson() => _$WinningRecordToJson(this);

}


