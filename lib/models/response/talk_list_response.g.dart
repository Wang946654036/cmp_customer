// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'talk_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TalkListResponse _$TalkListResponseFromJson(Map<String, dynamic> json) {
  return TalkListResponse(
    (json['data'] as List)
        ?.map((e) =>
            e == null ? null : TalkInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )
    ..code = json['code'] as String
    ..message = json['message'] as String;
}

Map<String, dynamic> _$TalkListResponseToJson(TalkListResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

TalkInfo _$TalkInfoFromJson(Map<String, dynamic> json) {
  return TalkInfo(
    (json['attachmentList'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['buildName'] as String,
    json['city'] as String,
    json['cityCode'] as String,
    json['commentCount'] as int,
    json['content'] as String,
    json['createTime'] as String,
    json['creatorId'] as int,
    json['customerType'] as int,
    json['deleteReason'] as String,
    json['deleteTime'] as String,
    json['deleteUserId'] as int,
    json['deleteUserName'] as String,
    json['houseNo'] as String,
    json['likeCount'] as int,
    json['mobile'] as String,
    json['nickName'] as String,
    json['number'] as String,
    json['projectId'] as int,
    json['projectName'] as String,
    json['realName'] as String,
    json['status'] as String,
    json['talkId'] as int,
    json['talkSymbol'] as String,
    json['unitName'] as String,
    json['userCollectFlag'] as bool,
    json['userLikeFlag'] as bool,
    json['userPicture'] == null
        ? null
        : Attachment.fromJson(json['userPicture'] as Map<String, dynamic>),
    json['viewCount'] as int,
    json['contentOpen'] as bool,
  );
}

Map<String, dynamic> _$TalkInfoToJson(TalkInfo instance) => <String, dynamic>{
      'attachmentList': instance.attachmentList,
      'buildName': instance.buildName,
      'city': instance.city,
      'cityCode': instance.cityCode,
      'commentCount': instance.commentCount,
      'content': instance.content,
      'createTime': instance.createTime,
      'creatorId': instance.creatorId,
      'customerType': instance.customerType,
      'deleteReason': instance.deleteReason,
      'deleteTime': instance.deleteTime,
      'deleteUserId': instance.deleteUserId,
      'deleteUserName': instance.deleteUserName,
      'houseNo': instance.houseNo,
      'likeCount': instance.likeCount,
      'mobile': instance.mobile,
      'nickName': instance.nickName,
      'number': instance.number,
      'projectId': instance.projectId,
      'projectName': instance.projectName,
      'realName': instance.realName,
      'status': instance.status,
      'talkId': instance.talkId,
      'talkSymbol': instance.talkSymbol,
      'unitName': instance.unitName,
      'userCollectFlag': instance.userCollectFlag,
      'userLikeFlag': instance.userLikeFlag,
      'userPicture': instance.userPicture,
      'viewCount': instance.viewCount,
      'contentOpen': instance.contentOpen,
    };
