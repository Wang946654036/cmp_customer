import 'package:json_annotation/json_annotation.dart';

part 'pgc_comment_obj.g.dart';

@JsonSerializable()
class PgcCommentObj extends Object {
  @JsonKey(name: 'appCodes')
  List<String> appCodes;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'data')
  List<PgcCommentInfo> pgcCommentInfoList;

  @JsonKey(name: 'extStr')
  String extStr;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'totalCount')
  int totalCount;

  PgcCommentObj({
    this.appCodes,
    this.code,
    this.pgcCommentInfoList,
    this.extStr,
    this.message,
    this.systemDate,
    this.totalCount,
  });

  factory PgcCommentObj.fromJson(Map<String, dynamic> srcJson) =>
      _$PgcCommentObjFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PgcCommentObjToJson(this);
}

//@JsonSerializable()
//class PgcCommentInfoList extends Object {
//
//  @JsonKey(name: 'deletedCount')
//  int deletedCount;
//
//  @JsonKey(name: 'existCount')
//  int existCount;
//
//  @JsonKey(name: 'resultList')
//  List<PgcCommentInfo> pgcCommentInfos;
//
//  PgcCommentInfoList({this.deletedCount,this.existCount,this.pgcCommentInfos,});
//
//  factory PgcCommentInfoList.fromJson(Map<String, dynamic> srcJson) => _$PgcCommentInfoListFromJson(srcJson);
//
//  Map<String, dynamic> toJson() => _$PgcCommentInfoListToJson(this);
//
//}

@JsonSerializable()
class PgcCommentInfo extends Object {
  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'createTime')
  String createTime;

  @JsonKey(name: 'custId')
  int custId;

  @JsonKey(name: 'custName')
  String custName;

  @JsonKey(name: 'custPhone')
  String custPhone;

  @JsonKey(name: 'custPhoto')
  String custPhoto;


  @JsonKey(name: 'deleteReason')
  String deleteReason;

  @JsonKey(name: 'likeCount')
  int likeCount;

  @JsonKey(name: 'likeUser')
  int likeUser;

  @JsonKey(name: 'nickname')
  String nickname;

  @JsonKey(name: 'pgcCommentId')
  int pgcCommentId;

  @JsonKey(name: 'pgcId')
  int pgcId;

  @JsonKey(name: 'projectId')
  int projectId;

  @JsonKey(name: 'projectName')
  String projectName;

  @JsonKey(name: 'formerName')
  String formerName;

  @JsonKey(name: 'reply')
  String reply;

  @JsonKey(name: 'replyTime')
  String replyTime;

  @JsonKey(name: 'replyUser')
  int replyUser;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'userLike')
  String userLike;

  @JsonKey(name: 'custLike')
  String custLike;
  @JsonKey(name: 'cityName')
  String cityName;


  PgcCommentInfo(
      {this.content,
      this.createTime,
      this.custId,
      this.custName,
      this.custPhone,
      this.deleteReason,
      this.likeCount,
      this.likeUser,
      this.nickname,
      this.pgcCommentId,
      this.pgcId,
      this.projectId,
      this.projectName,
      this.formerName,
      this.reply,
      this.replyTime,
      this.replyUser,
      this.status,
      this.userLike,
      this.custLike,
      this.cityName,
        this.custPhoto});

  factory PgcCommentInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$PgcCommentInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PgcCommentInfoToJson(this);
}
