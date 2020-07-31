import 'package:cmp_customer/models/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

import '../user_data_model.dart';

part 'talk_list_response.g.dart';


@JsonSerializable()
class TalkListResponse extends BaseResponse {

  @JsonKey(name: 'data')
  List<TalkInfo> data;

  TalkListResponse(this.data,);

  factory TalkListResponse.fromJson(Map<String, dynamic> srcJson) => _$TalkListResponseFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TalkListResponseToJson(this);

}


@JsonSerializable()
class TalkInfo extends Object {

  @JsonKey(name: 'attachmentList')
  List<Attachment> attachmentList;

  @JsonKey(name: 'buildName')
  String buildName;

  @JsonKey(name: 'city')
  String city;

  @JsonKey(name: 'cityCode')
  String cityCode;

  @JsonKey(name: 'commentCount')
  int commentCount;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'createTime')
  String createTime;

  @JsonKey(name: 'creatorId')
  int creatorId;

  @JsonKey(name: 'customerType')
  int customerType;

  @JsonKey(name: 'deleteReason')
  String deleteReason;

  @JsonKey(name: 'deleteTime')
  String deleteTime;

  @JsonKey(name: 'deleteUserId')
  int deleteUserId;

  @JsonKey(name: 'deleteUserName')
  String deleteUserName;

  @JsonKey(name: 'houseNo')
  String houseNo;

  @JsonKey(name: 'likeCount')
  int likeCount;

  @JsonKey(name: 'mobile')
  String mobile;

  @JsonKey(name: 'nickName')
  String nickName;

  @JsonKey(name: 'number')
  String number;

  @JsonKey(name: 'projectId')
  int projectId;

  @JsonKey(name: 'projectName')
  String projectName;

  @JsonKey(name: 'realName')
  String realName;

  @JsonKey(name: 'status')
  String status;

//  @JsonKey(name: 'talkCommentExtendList')
//  List<TalkComment> talkCommentExtendList;

  @JsonKey(name: 'talkId')
  int talkId;

  @JsonKey(name: 'talkSymbol')
  String talkSymbol;

  @JsonKey(name: 'unitName')
  String unitName;

  @JsonKey(name: 'userCollectFlag')
  bool userCollectFlag;

  @JsonKey(name: 'userLikeFlag')
  bool userLikeFlag;

  @JsonKey(name: 'userPicture')
  Attachment userPicture;

  @JsonKey(name: 'viewCount')
  int viewCount;

  @JsonKey(name: 'contentOpen')
  bool contentOpen;

  TalkInfo(this.attachmentList,this.buildName,this.city,this.cityCode,this.commentCount,this.content,this.createTime,this.creatorId,this.customerType,this.deleteReason,this.deleteTime,this.deleteUserId,this.deleteUserName,this.houseNo,this.likeCount,this.mobile,this.nickName,this.number,this.projectId,this.projectName,this.realName,this.status,this.talkId,this.talkSymbol,this.unitName,this.userCollectFlag,this.userLikeFlag,this.userPicture,this.viewCount,this.contentOpen);

  factory TalkInfo.fromJson(Map<String, dynamic> srcJson) => _$TalkInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TalkInfoToJson(this);

}

//@JsonSerializable()
//class TalkComment extends Object {
//
//  @JsonKey(name: 'content')
//  String content;
//
//  @JsonKey(name: 'createTime')
//  String createTime;
//
//  @JsonKey(name: 'custId')
//  int custId;
//
//  @JsonKey(name: 'deleteReason')
//  String deleteReason;
//
//  @JsonKey(name: 'deleteTime')
//  String deleteTime;
//
//  @JsonKey(name: 'deleteUser')
//  int deleteUser;
//
//  @JsonKey(name: 'lastCommentId')
//  int lastCommentId;
//
//  @JsonKey(name: 'mobile')
//  String mobile;
//
//  @JsonKey(name: 'nickName')
//  String nickName;
//
//  @JsonKey(name: 'projectId')
//  int projectId;
//
//  @JsonKey(name: 'projectName')
//  String projectName;
//
//  @JsonKey(name: 'realName')
//  String realName;
//
//  @JsonKey(name: 'replyContent')
//  String replyContent;
//
//  @JsonKey(name: 'replyName')
//  String replyName;
//
//  @JsonKey(name: 'rootCommentId')
//  int rootCommentId;
//
//  @JsonKey(name: 'status')
//  String status;
//
//  @JsonKey(name: 'talkCommentId')
//  int talkCommentId;
//
//  @JsonKey(name: 'talkId')
//  int talkId;
//
//  TalkComment(this.content,this.createTime,this.custId,this.deleteReason,this.deleteTime,this.deleteUser,this.lastCommentId,this.mobile,this.nickName,this.projectId,this.projectName,this.realName,this.replyContent,this.replyName,this.rootCommentId,this.status,this.talkCommentId,this.talkId,);
//
//  factory TalkComment.fromJson(Map<String, dynamic> srcJson) => _$TalkCommentFromJson(srcJson);
//
//  Map<String, dynamic> toJson() => _$TalkCommentToJson(this);
//
//}




