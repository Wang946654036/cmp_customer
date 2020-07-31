// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property_notice_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PropertyNoticeModel _$PropertyNoticeModelFromJson(Map<String, dynamic> json) {
  return PropertyNoticeModel(
    (json['appCodes'] as List)?.map((e) => e as String)?.toList(),
    json['code'] as String,
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : PropertyNotice.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['extStr'] as String,
    json['message'] as String,
    json['systemDate'] as String,
    json['totalCount'] as int,
  );
}

Map<String, dynamic> _$PropertyNoticeModelToJson(
        PropertyNoticeModel instance) =>
    <String, dynamic>{
      'appCodes': instance.appCodes,
      'code': instance.code,
      'data': instance.propertyNoticeList,
      'extStr': instance.extStr,
      'message': instance.message,
      'systemDate': instance.systemDate,
      'totalCount': instance.totalCount,
    };

PropertyNotice _$PropertyNoticeFromJson(Map<String, dynamic> json) {
  return PropertyNotice(
    (json['attachmentList'] as List)
        ?.map((e) =>
            e == null ? null : ImageInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['checkStatus'] as int,
    json['content'] as String,
    (json['fileList'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['id'] as int,
    json['isRead'] as String,
    json['isTimed'] as int,
    json['operationUser'] as int,
    json['orgId'] as int,
    json['orgName'] as String,
    (json['scopeIds'] as List)?.map((e) => e as int)?.toList(),
    json['sendScope'] as int,
    json['sendTarget'] as int,
    json['sendTime'] as String,
    json['sendUser'] as int,
    json['status'] as int,
    json['submitTime'] as String,
    json['suggestion'] as String,
    json['title'] as String,
    json['type'] as int,
    json['userOrgId'] as int,
  );
}

Map<String, dynamic> _$PropertyNoticeToJson(PropertyNotice instance) =>
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

ImageInfo _$ImageInfoFromJson(Map<String, dynamic> json) {
  return ImageInfo(
    json['attachmentName'] as String,
    json['attachmentType'] as String,
    json['attachmentUuid'] as String,
    json['createTime'] as String,
    json['id'] as int,
    json['relatedId'] as int,
    json['source'] as String,
    json['status'] as String,
    json['type'] as String,
  );
}

Map<String, dynamic> _$ImageInfoToJson(ImageInfo instance) => <String, dynamic>{
      'attachmentName': instance.attachmentName,
      'attachmentType': instance.attachmentType,
      'attachmentUuid': instance.attachmentUuid,
      'createTime': instance.createTime,
      'id': instance.id,
      'relatedId': instance.relatedId,
      'source': instance.source,
      'status': instance.status,
      'type': instance.type,
    };
