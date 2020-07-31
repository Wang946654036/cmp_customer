// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ware_comment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WareCommentResponse _$WareCommentResponseFromJson(Map<String, dynamic> json) {
  return WareCommentResponse(
    json['data'] == null
        ? null
        : WareComment.fromJson(json['data'] as Map<String, dynamic>),
    json['totalCount'] as int,
  )
    ..code = json['code'] as String
    ..message = json['message'] as String;
}

Map<String, dynamic> _$WareCommentResponseToJson(
        WareCommentResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
      'totalCount': instance.totalCount,
    };

WareComment _$WareCommentFromJson(Map<String, dynamic> json) {
  return WareComment(
    json['page'] == null
        ? null
        : Page.fromJson(json['page'] as Map<String, dynamic>),
    json['commentCount'] as int,
  );
}

Map<String, dynamic> _$WareCommentToJson(WareComment instance) =>
    <String, dynamic>{
      'page': instance.page,
      'commentCount': instance.commentCount,
    };

Page _$PageFromJson(Map<String, dynamic> json) {
  return Page(
    json['total'] as int,
    json['size'] as int,
    json['pages'] as int,
    json['current'] as int,
    (json['records'] as List)
        ?.map((e) =>
            e == null ? null : Record.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$PageToJson(Page instance) => <String, dynamic>{
      'total': instance.total,
      'size': instance.size,
      'pages': instance.pages,
      'current': instance.current,
      'records': instance.records,
    };

Record _$RecordFromJson(Map<String, dynamic> json) {
  return Record(
    json['waresCommentId'] as int,
    json['waresId'] as int,
    json['rootCommentId'] as int,
    json['lastCommentId'] as int,
    json['custId'] as int,
    json['projectId'] as int,
    json['content'] as String,
    json['status'] as String,
    json['deleteReason'] as String,
    json['createTime'] as String,
    json['nickName'] as String,
    json['replyName'] as String,
    json['realName'] as String,
    json['mobile'] as String,
    json['projectName'] as String,
    json['city'] as String,
    json['appId'] as int,
    json['userPicture'] == null
        ? null
        : UserPicture.fromJson(json['userPicture'] as Map<String, dynamic>),
    json['isOwner'] as String,
  );
}

Map<String, dynamic> _$RecordToJson(Record instance) => <String, dynamic>{
      'waresCommentId': instance.waresCommentId,
      'waresId': instance.waresId,
      'rootCommentId': instance.rootCommentId,
      'lastCommentId': instance.lastCommentId,
      'custId': instance.custId,
      'projectId': instance.projectId,
      'content': instance.content,
      'status': instance.status,
      'deleteReason': instance.deleteReason,
      'createTime': instance.createTime,
      'nickName': instance.nickName,
      'replyName': instance.replyName,
      'realName': instance.realName,
      'mobile': instance.mobile,
      'projectName': instance.projectName,
      'city': instance.city,
      'appId': instance.appId,
      'userPicture': instance.userPicture,
      'isOwner': instance.isOwner,
    };

UserPicture _$UserPictureFromJson(Map<String, dynamic> json) {
  return UserPicture(
    json['id'] as int,
    json['source'] as String,
    json['type'] as String,
    json['relatedId'] as int,
    json['attachmentUuid'] as String,
    json['status'] as String,
    json['createTime'] as String,
  );
}

Map<String, dynamic> _$UserPictureToJson(UserPicture instance) =>
    <String, dynamic>{
      'id': instance.id,
      'source': instance.source,
      'type': instance.type,
      'relatedId': instance.relatedId,
      'attachmentUuid': instance.attachmentUuid,
      'status': instance.status,
      'createTime': instance.createTime,
    };
