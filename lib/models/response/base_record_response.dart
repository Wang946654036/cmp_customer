import '../user_data_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'base_record_response.g.dart';

@JsonSerializable()
class BaseRecordList extends Object{

  @JsonKey(name: 'attJfpjList')
  List<Attachment> attJfpjList;

  @JsonKey(name: 'attRzqrList')
  List<Attachment> attRzqrList;

  @JsonKey(name: 'attRzqrhList')
  List<Attachment> attRzqrhList;

  @JsonKey(name: 'attZhrzList')
  List<Attachment> attZhrzList;

  @JsonKey(name: 'attachmentFlag')
  String attachmentFlag;

  @JsonKey(name: 'createTime')
  String createTime;

  @JsonKey(name: 'creator')
  String creator;

  @JsonKey(name: 'creatorId')
  int creatorId;

  @JsonKey(name: 'creatorType')
  String creatorType;

  @JsonKey(name: 'operateStep')
  String operateStep;

  @JsonKey(name: 'operateStepDesc')
  String operateStepDesc;

  @JsonKey(name: 'postId')
  int postId;

  @JsonKey(name: 'recordId')
  int recordId;

  @JsonKey(name: 'remark')
  String remark;

  @JsonKey(name: 'rentingEnterId')
  int rentingEnterId;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'statusDesc')
  String statusDesc;

  @JsonKey(name: 'userId')
  int userId;

  BaseRecordList(this.attJfpjList,this.attRzqrList,this.attRzqrhList,this.attZhrzList,this.attachmentFlag,this.createTime,this.creator,this.creatorId,this.creatorType,this.operateStep,this.postId,this.recordId,this.remark,this.rentingEnterId,this.status,this.userId,);

  factory BaseRecordList.fromJson(Map<String, dynamic> srcJson) => _$BaseRecordListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BaseRecordListToJson(this);

}