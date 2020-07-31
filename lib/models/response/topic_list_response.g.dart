// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopicListResponse _$TopicListResponseFromJson(Map<String, dynamic> json) {
  return TopicListResponse(
    (json['data'] as List)
        ?.map((e) =>
            e == null ? null : TopicInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )
    ..code = json['code'] as String
    ..message = json['message'] as String;
}

Map<String, dynamic> _$TopicListResponseToJson(TopicListResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

TopicInfo _$TopicInfoFromJson(Map<String, dynamic> json) {
  return TopicInfo(
    json['activityId'] as int,
    json['activityTitle'] as String,
    (json['attachmentList'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['bannerList'] as List)?.map((e) => e as String)?.toList(),
    json['bookPublishTime'] as String,
    json['browseCount'] as int,
    json['city'] as String,
    json['collectTopic'] as bool,
    json['commentCount'] as int,
    json['createTime'] as String,
    json['createUser'] as int,
    json['customerType'] as int,
    json['isTop'] as String,
    json['keyword'] as String,
    json['likeCount'] as int,
    json['mobile'] as String,
    json['nickName'] as String,
    json['number'] as String,
    json['orgId'] as int,
    json['orgName'] as String,
    (json['projectIdList'] as List)?.map((e) => e as int)?.toList(),
    json['projectNames'] as String,
    json['publishLimit'] as String,
    json['publishMethod'] as String,
    json['publishTime'] as String,
    json['status'] as String,
    json['statusName'] as String,
    json['titlePic'] as String,
    json['topicId'] as int,
    json['topicTitle'] as String,
    json['updateTime'] as String,
    json['updateUser'] as int,
    json['userPicture'] == null
        ? null
        : Attachment.fromJson(json['userPicture'] as Map<String, dynamic>),
    json['weight'] as int,
  );
}

Map<String, dynamic> _$TopicInfoToJson(TopicInfo instance) => <String, dynamic>{
      'activityId': instance.activityId,
      'activityTitle': instance.activityTitle,
      'attachmentList': instance.attachmentList,
      'bannerList': instance.bannerList,
      'bookPublishTime': instance.bookPublishTime,
      'browseCount': instance.browseCount,
      'city': instance.city,
      'collectTopic': instance.collectTopic,
      'commentCount': instance.commentCount,
      'createTime': instance.createTime,
      'createUser': instance.createUser,
      'customerType': instance.customerType,
      'isTop': instance.isTop,
      'keyword': instance.keyword,
      'likeCount': instance.likeCount,
      'mobile': instance.mobile,
      'nickName': instance.nickName,
      'number': instance.number,
      'orgId': instance.orgId,
      'orgName': instance.orgName,
      'projectIdList': instance.projectIdList,
      'projectNames': instance.projectNames,
      'publishLimit': instance.publishLimit,
      'publishMethod': instance.publishMethod,
      'publishTime': instance.publishTime,
      'status': instance.status,
      'statusName': instance.statusName,
      'titlePic': instance.titlePic,
      'topicId': instance.topicId,
      'topicTitle': instance.topicTitle,
      'updateTime': instance.updateTime,
      'updateUser': instance.updateUser,
      'userPicture': instance.userPicture,
      'weight': instance.weight,
    };
