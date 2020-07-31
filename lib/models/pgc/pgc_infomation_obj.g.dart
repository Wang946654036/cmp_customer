// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pgc_infomation_obj.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PgcInfomationObj _$PgcInfomationObjFromJson(Map<String, dynamic> json) {
  return PgcInfomationObj(
    appCodes: (json['appCodes'] as List)?.map((e) => e as String)?.toList(),
    code: json['code'] as String,
    pgcInfomationInfo: json['data'] == null
        ? null
        : PgcInfomationInfo.fromJson(json['data'] as Map<String, dynamic>),
    extStr: json['extStr'] as String,
    message: json['message'] as String,
    systemDate: json['systemDate'] as String,
    totalCount: json['totalCount'] as int,
  );
}

Map<String, dynamic> _$PgcInfomationObjToJson(PgcInfomationObj instance) =>
    <String, dynamic>{
      'appCodes': instance.appCodes,
      'code': instance.code,
      'data': instance.pgcInfomationInfo,
      'extStr': instance.extStr,
      'message': instance.message,
      'systemDate': instance.systemDate,
      'totalCount': instance.totalCount,
    };

PgcInfomationInfo _$PgcInfomationInfoFromJson(Map<String, dynamic> json) {
  return PgcInfomationInfo(
    author: json['author'] as String,
    bookPublishTime: json['bookPublishTime'] as String,
    browseCount: json['browseCount'] as int,
    commentCount: json['commentCount'] as int,
    content: json['content'] as String,
    createTime: json['createTime'] as String,
    createUser: json['createUser'] as int,
    isTop: json['isTop'] as String,
    keyword: json['keyword'] as String,
    likeCount: json['likeCount'] as int,
    operationLogList: (json['operationLogList'] as List)
        ?.map((e) => e == null
            ? null
            : OperationLogList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    orgId: json['orgId'] as int,
    orgName: json['orgName'] as String,
    pgcId: json['pgcId'] as int,
    pgcTitle: json['pgcTitle'] as String,
    projectIdList:
        (json['projectIdList'] as List)?.map((e) => e as int)?.toList(),
    projectNames: json['projectNames'] as String,
    publishLimit: json['publishLimit'] as String,
    publishMethod: json['publishMethod'] as String,
    publishTime: json['publishTime'] as String,
    source: json['source'] as String,
    status: json['status'] as String,
    statusName: json['statusName'] as String,
    titlePic: json['titlePic'] as String,
    updateTime: json['updateTime'] as String,
    updateUser: json['updateUser'] as int,
    weight: json['weight'] as int,
    custCollect: json['custCollect'] as String,
    custLike: json['custLike'] as String,
  );
}

Map<String, dynamic> _$PgcInfomationInfoToJson(PgcInfomationInfo instance) =>
    <String, dynamic>{
      'author': instance.author,
      'bookPublishTime': instance.bookPublishTime,
      'browseCount': instance.browseCount,
      'commentCount': instance.commentCount,
      'content': instance.content,
      'createTime': instance.createTime,
      'createUser': instance.createUser,
      'isTop': instance.isTop,
      'keyword': instance.keyword,
      'likeCount': instance.likeCount,
      'operationLogList': instance.operationLogList,
      'orgId': instance.orgId,
      'orgName': instance.orgName,
      'pgcId': instance.pgcId,
      'pgcTitle': instance.pgcTitle,
      'projectIdList': instance.projectIdList,
      'projectNames': instance.projectNames,
      'publishLimit': instance.publishLimit,
      'publishMethod': instance.publishMethod,
      'publishTime': instance.publishTime,
      'source': instance.source,
      'status': instance.status,
      'statusName': instance.statusName,
      'titlePic': instance.titlePic,
      'updateTime': instance.updateTime,
      'updateUser': instance.updateUser,
      'weight': instance.weight,
      'custCollect': instance.custCollect,
      'custLike': instance.custLike,
    };

OperationLogList _$OperationLogListFromJson(Map<String, dynamic> json) {
  return OperationLogList(
    auditResult: json['auditResult'] as String,
    createTime: json['createTime'] as String,
    logId: json['logId'] as int,
    operationName: json['operationName'] as String,
    pgcId: json['pgcId'] as int,
    remark: json['remark'] as String,
    userId: json['userId'] as int,
    userName: json['userName'] as String,
  );
}

Map<String, dynamic> _$OperationLogListToJson(OperationLogList instance) =>
    <String, dynamic>{
      'auditResult': instance.auditResult,
      'createTime': instance.createTime,
      'logId': instance.logId,
      'operationName': instance.operationName,
      'pgcId': instance.pgcId,
      'remark': instance.remark,
      'userId': instance.userId,
      'userName': instance.userName,
    };
