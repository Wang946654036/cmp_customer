// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pgc_comment_obj.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PgcCommentObj _$PgcCommentObjFromJson(Map<String, dynamic> json) {
  return PgcCommentObj(
    appCodes: (json['appCodes'] as List)?.map((e) => e as String)?.toList(),
    code: json['code'] as String,
    pgcCommentInfoList: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : PgcCommentInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    extStr: json['extStr'] as String,
    message: json['message'] as String,
    systemDate: json['systemDate'] as String,
    totalCount: json['totalCount'] as int,
  );
}

Map<String, dynamic> _$PgcCommentObjToJson(PgcCommentObj instance) =>
    <String, dynamic>{
      'appCodes': instance.appCodes,
      'code': instance.code,
      'data': instance.pgcCommentInfoList,
      'extStr': instance.extStr,
      'message': instance.message,
      'systemDate': instance.systemDate,
      'totalCount': instance.totalCount,
    };

PgcCommentInfo _$PgcCommentInfoFromJson(Map<String, dynamic> json) {
  return PgcCommentInfo(
    content: json['content'] as String,
    createTime: json['createTime'] as String,
    custId: json['custId'] as int,
    custName: json['custName'] as String,
    custPhone: json['custPhone'] as String,
    deleteReason: json['deleteReason'] as String,
    likeCount: json['likeCount'] as int,
    likeUser: json['likeUser'] as int,
    nickname: json['nickname'] as String,
    pgcCommentId: json['pgcCommentId'] as int,
    pgcId: json['pgcId'] as int,
    projectId: json['projectId'] as int,
    projectName: json['projectName'] as String,
    formerName: json['formerName'] as String,
    reply: json['reply'] as String,
    replyTime: json['replyTime'] as String,
    replyUser: json['replyUser'] as int,
    status: json['status'] as String,
    userLike: json['userLike'] as String,
    custLike: json['custLike'] as String,
    cityName: json['cityName'] as String,
    custPhoto: json['custPhoto'] as String,
  );
}

Map<String, dynamic> _$PgcCommentInfoToJson(PgcCommentInfo instance) =>
    <String, dynamic>{
      'content': instance.content,
      'createTime': instance.createTime,
      'custId': instance.custId,
      'custName': instance.custName,
      'custPhone': instance.custPhone,
      'custPhoto': instance.custPhoto,
      'deleteReason': instance.deleteReason,
      'likeCount': instance.likeCount,
      'likeUser': instance.likeUser,
      'nickname': instance.nickname,
      'pgcCommentId': instance.pgcCommentId,
      'pgcId': instance.pgcId,
      'projectId': instance.projectId,
      'projectName': instance.projectName,
      'formerName': instance.formerName,
      'reply': instance.reply,
      'replyTime': instance.replyTime,
      'replyUser': instance.replyUser,
      'status': instance.status,
      'userLike': instance.userLike,
      'custLike': instance.custLike,
      'cityName': instance.cityName,
    };
