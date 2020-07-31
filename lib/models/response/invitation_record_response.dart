import 'package:json_annotation/json_annotation.dart';

import 'base_response.dart';

part 'invitation_record_response.g.dart';


@JsonSerializable()
class InvitationRecordResponse extends BaseResponse {

  @JsonKey(name: 'data')
  List<InvitationRecord> data;

  InvitationRecordResponse();

  factory InvitationRecordResponse.fromJson(Map<String, dynamic> srcJson) =>
      _$InvitationRecordResponseFromJson(srcJson);

  Map<String, dynamic> toJson() => _$InvitationRecordResponseToJson(this);

}


@JsonSerializable()
class InvitationRecord extends Object {

  @JsonKey(name: 'createTime')
  String createTime;

  @JsonKey(name: 'custId')
  int custId;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'phone')
  String phone;

  @JsonKey(name: 'rewardTime')
  String rewardTime;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'statusName')
  String statusName;

  @JsonKey(name: 'toNickname')
  String toNickname;

  @JsonKey(name: 'updateTime')
  String updateTime;

  @JsonKey(name: 'updateDate')
  String updateDate;

  InvitationRecord(this.createTime, this.custId, this.id, this.phone, this.rewardTime, this.status,
      this.statusName, this.toNickname, this.updateTime,this.updateDate);

  factory InvitationRecord.fromJson(Map<String, dynamic> srcJson) => _$InvitationRecordFromJson(srcJson);

  Map<String, dynamic> toJson() => _$InvitationRecordToJson(this);

}


