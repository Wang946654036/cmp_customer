import 'package:cmp_customer/models/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

import '../user_data_model.dart';

part 'topic_list_response.g.dart';


@JsonSerializable()
class TopicListResponse extends BaseResponse {

  @JsonKey(name: 'data')
  List<TopicInfo> data;

  TopicListResponse(this.data,);

  factory TopicListResponse.fromJson(Map<String, dynamic> srcJson) => _$TopicListResponseFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TopicListResponseToJson(this);

}


@JsonSerializable()
class TopicInfo extends Object {

  @JsonKey(name: 'activityId')
  int activityId;

  @JsonKey(name: 'activityTitle')
  String activityTitle;

  @JsonKey(name: 'attachmentList')
  List<Attachment> attachmentList;

  @JsonKey(name: 'bannerList')
  List<String> bannerList;

  @JsonKey(name: 'bookPublishTime')
  String bookPublishTime;

  @JsonKey(name: 'browseCount')
  int browseCount;

  @JsonKey(name: 'city')
  String city;

  @JsonKey(name: 'collectTopic')
  bool collectTopic;

  @JsonKey(name: 'commentCount')
  int commentCount;

//  @JsonKey(name: 'content')
//  String content;

  @JsonKey(name: 'createTime')
  String createTime;

  @JsonKey(name: 'createUser')
  int createUser;

  @JsonKey(name: 'customerType')
  int customerType;

  @JsonKey(name: 'isTop')
  String isTop;

  @JsonKey(name: 'keyword')
  String keyword;

  @JsonKey(name: 'likeCount')
  int likeCount;

  @JsonKey(name: 'mobile')
  String mobile;

  @JsonKey(name: 'nickName')
  String nickName;

  @JsonKey(name: 'number')
  String number;

//  @JsonKey(name: 'operationLogList')
//  List<OperationLogList> operationLogList;

  @JsonKey(name: 'orgId')
  int orgId;

  @JsonKey(name: 'orgName')
  String orgName;

  @JsonKey(name: 'projectIdList')
  List<int> projectIdList;

  @JsonKey(name: 'projectNames')
  String projectNames;

  @JsonKey(name: 'publishLimit')
  String publishLimit;

  @JsonKey(name: 'publishMethod')
  String publishMethod;

  @JsonKey(name: 'publishTime')
  String publishTime;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'statusName')
  String statusName;

  @JsonKey(name: 'titlePic')
  String titlePic;

  @JsonKey(name: 'topicId')
  int topicId;

  @JsonKey(name: 'topicTitle')
  String topicTitle;

  @JsonKey(name: 'updateTime')
  String updateTime;

  @JsonKey(name: 'updateUser')
  int updateUser;

  @JsonKey(name: 'userPicture')
  Attachment userPicture;

  @JsonKey(name: 'weight')
  int weight;

  TopicInfo(this.activityId,this.activityTitle,this.attachmentList,this.bannerList,this.bookPublishTime,this.browseCount,this.city,this.collectTopic,this.commentCount,this.createTime,this.createUser,this.customerType,this.isTop,this.keyword,this.likeCount,this.mobile,this.nickName,this.number,this.orgId,this.orgName,this.projectIdList,this.projectNames,this.publishLimit,this.publishMethod,this.publishTime,this.status,this.statusName,this.titlePic,this.topicId,this.topicTitle,this.updateTime,this.updateUser,this.userPicture,this.weight,);

  factory TopicInfo.fromJson(Map<String, dynamic> srcJson) => _$TopicInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TopicInfoToJson(this);

}

