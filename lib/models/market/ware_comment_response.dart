import 'package:cmp_customer/models/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ware_comment_response.g.dart';


@JsonSerializable()
class WareCommentResponse extends BaseResponse {

  @JsonKey(name: 'data')
  WareComment data;

  @JsonKey(name: 'totalCount')
  int totalCount;

  WareCommentResponse(this.data,this.totalCount,);

  factory WareCommentResponse.fromJson(Map<String, dynamic> srcJson) => _$WareCommentResponseFromJson(srcJson);

  Map<String, dynamic> toJson() => _$WareCommentResponseToJson(this);

}


@JsonSerializable()
class WareComment extends Object {

  @JsonKey(name: 'page')
  Page page;

  @JsonKey(name: 'commentCount')
  int commentCount;

  WareComment(this.page,this.commentCount,);

  factory WareComment.fromJson(Map<String, dynamic> srcJson) => _$WareCommentFromJson(srcJson);

  Map<String, dynamic> toJson() => _$WareCommentToJson(this);

}


@JsonSerializable()
class Page extends Object {

  @JsonKey(name: 'total')
  int total;

  @JsonKey(name: 'size')
  int size;

  @JsonKey(name: 'pages')
  int pages;

  @JsonKey(name: 'current')
  int current;

  @JsonKey(name: 'records')
  List<Record> records;

  Page(this.total,this.size,this.pages,this.current,this.records,);

  factory Page.fromJson(Map<String, dynamic> srcJson) => _$PageFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PageToJson(this);

}

@JsonSerializable()
class Record extends Object {

  @JsonKey(name: 'waresCommentId')
  int waresCommentId;

  @JsonKey(name: 'waresId')
  int waresId;

  @JsonKey(name: 'rootCommentId')
  int rootCommentId;

  @JsonKey(name: 'lastCommentId')
  int lastCommentId;

  @JsonKey(name: 'custId')
  int custId;

  @JsonKey(name: 'projectId')
  int projectId;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'deleteReason')
  String deleteReason;

  @JsonKey(name: 'createTime')
  String createTime;

  @JsonKey(name: 'nickName')
  String nickName;

  @JsonKey(name: 'replyName')
  String replyName;

  @JsonKey(name: 'realName')
  String realName;

  @JsonKey(name: 'mobile')
  String mobile;

  @JsonKey(name: 'projectName')
  String projectName;

  @JsonKey(name: 'city')
  String city;

  @JsonKey(name: 'appId')
  int appId;

  @JsonKey(name: 'userPicture')
  UserPicture userPicture;

  @JsonKey(name: 'isOwner')
  String isOwner;

  Record(this.waresCommentId,this.waresId,this.rootCommentId,this.lastCommentId,this.custId,this.projectId,this.content,this.status,this.deleteReason,this.createTime,this.nickName,this.replyName,this.realName,this.mobile,this.projectName,this.city,this.appId,this.userPicture,this.isOwner,);

  factory Record.fromJson(Map<String, dynamic> srcJson) => _$RecordFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RecordToJson(this);

}


@JsonSerializable()
class UserPicture extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'source')
  String source;

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'relatedId')
  int relatedId;

  @JsonKey(name: 'attachmentUuid')
  String attachmentUuid;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'createTime')
  String createTime;

  UserPicture(this.id,this.source,this.type,this.relatedId,this.attachmentUuid,this.status,this.createTime,);

  factory UserPicture.fromJson(Map<String, dynamic> srcJson) => _$UserPictureFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserPictureToJson(this);

}

