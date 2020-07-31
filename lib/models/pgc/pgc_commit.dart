import 'package:json_annotation/json_annotation.dart';

part 'pgc_commit.g.dart';


@JsonSerializable()
class PgcCommit extends Object {

  @JsonKey(name: 'deleteReason')
  String deleteReason;//删除备注，type=1 时输入

  @JsonKey(name: 'like')
  String like;//点赞内容：0：取消点赞；1：点赞；type=3 时输入

  @JsonKey(name: 'pgcCommentId')
  int pgcCommentId;//PGC评论ID

  @JsonKey(name: 'reply')
  String reply;//回复内容，type=2 时输入

  @JsonKey(name: 'type')
  String type;//操作标识：1：删除；2：回复；3：点赞；

  PgcCommit(this.deleteReason,this.like,this.pgcCommentId,this.reply,this.type,);

  factory PgcCommit.fromJson(Map<String, dynamic> srcJson) => _$PgcCommitFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PgcCommitToJson(this);

}


