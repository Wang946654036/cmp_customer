// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property_notice_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PropertyNoticeDetailModel _$PropertyNoticeDetailModelFromJson(
    Map<String, dynamic> json) {
  return PropertyNoticeDetailModel(
    (json['appCodes'] as List)?.map((e) => e as String)?.toList(),
    json['code'] as String,
    json['data'] == null
        ? null
        : PropertyNoticeDetail.fromJson(json['data'] as Map<String, dynamic>),
    json['extStr'] as String,
    json['message'] as String,
    json['systemDate'] as String,
    json['totalCount'] as int,
  );
}

Map<String, dynamic> _$PropertyNoticeDetailModelToJson(
        PropertyNoticeDetailModel instance) =>
    <String, dynamic>{
      'appCodes': instance.appCodes,
      'code': instance.code,
      'data': instance.propertyNoticeDetail,
      'extStr': instance.extStr,
      'message': instance.message,
      'systemDate': instance.systemDate,
      'totalCount': instance.totalCount,
    };

PropertyNoticeDetail _$PropertyNoticeDetailFromJson(Map<String, dynamic> json) {
  return PropertyNoticeDetail(
    imageList: (json['attachmentList'] as List)
        ?.map((e) =>
            e == null ? null : ImageInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    checkStatus: json['checkStatus'] as int,
    content: json['content'] as String,
    fileList: (json['fileList'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    id: json['id'] as int,
    isRead: json['isRead'] as String,
    isTimed: json['isTimed'] as int,
    operationUser: json['operationUser'] as int,
    orgId: json['orgId'] as int,
    orgName: json['orgName'] as String,
    scopeIds: (json['scopeIds'] as List)?.map((e) => e as int)?.toList(),
    sendScope: json['sendScope'] as int,
    sendTarget: json['sendTarget'] as int,
    sendTime: json['sendTime'] as String,
    sendUser: json['sendUser'] as int,
    status: json['status'] as int,
    submitTime: json['submitTime'] as String,
    suggestion: json['suggestion'] as String,
    title: json['title'] as String,
    type: json['type'] as int,
    userOrgId: json['userOrgId'] as int,
  );
}

Map<String, dynamic> _$PropertyNoticeDetailToJson(
        PropertyNoticeDetail instance) =>
    <String, dynamic>{
      'attachmentList': instance.imageList,
      'checkStatus': instance.checkStatus,
      'content': instance.content,
      'fileList': instance.fileList,
      'id': instance.id,
      'isRead': instance.isRead,
      'isTimed': instance.isTimed,
      'operationUser': instance.operationUser,
      'orgId': instance.orgId,
      'orgName': instance.orgName,
      'scopeIds': instance.scopeIds,
      'sendScope': instance.sendScope,
      'sendTarget': instance.sendTarget,
      'sendTime': instance.sendTime,
      'sendUser': instance.sendUser,
      'status': instance.status,
      'submitTime': instance.submitTime,
      'suggestion': instance.suggestion,
      'title': instance.title,
      'type': instance.type,
      'userOrgId': instance.userOrgId,
    };
