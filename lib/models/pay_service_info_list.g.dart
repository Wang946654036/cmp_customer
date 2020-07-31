// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pay_service_info_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayServiceInfoList _$PayServiceInfoListFromJson(Map<String, dynamic> json) {
  return PayServiceInfoList(
    (json['appCodes'] as List)?.map((e) => e as String)?.toList(),
    json['code'] as String,
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : PayServiceInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['extStr'] as String,
    json['message'] as String,
    json['systemDate'] as String,
    json['totalCount'] as int,
  );
}

Map<String, dynamic> _$PayServiceInfoListToJson(PayServiceInfoList instance) =>
    <String, dynamic>{
      'appCodes': instance.appCodes,
      'code': instance.code,
      'data': instance.data,
      'extStr': instance.extStr,
      'message': instance.message,
      'systemDate': instance.systemDate,
      'totalCount': instance.totalCount,
    };

PayServiceInfo _$PayServiceInfoFromJson(Map<String, dynamic> json) {
  return PayServiceInfo(
    json['createTime'] as String,
    json['createUserId'] as int,
    json['hasRelease'] as String,
    (json['posterPhotoList'] as List)
        ?.map((e) => e == null
            ? null
            : PosterPhotoList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['priceMax'] as num)?.toDouble(),
    (json['priceMin'] as num)?.toDouble(),
    json['priceUnit'] as String,
    json['priceRange'] as String,
    json['processPostId'] as int,
    json['processPostName'] as String,
    json['projectId'] as int,
    json['projectName'] as String,
    json['serviceConfId'] as int,
    json['serviceDesc'] as String,
    json['serviceName'] as String,
    json['serviceTime'] as String,
    json['serviceType'] as String,
    json['serviceTypeName'] as String,
    (json['showPhotoList'] as List)
        ?.map((e) => e == null
            ? null
            : PosterPhotoList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['styleListJson'] as String,
    json['styleList'] as List,
    json['updateTime'] as String,
    json['updateUserId'] as int,
    json['validFlag'] as String,
  );
}

Map<String, dynamic> _$PayServiceInfoToJson(PayServiceInfo instance) =>
    <String, dynamic>{
      'createTime': instance.createTime,
      'createUserId': instance.createUserId,
      'hasRelease': instance.hasRelease,
      'posterPhotoList': instance.posterPhotoList,
      'priceMax': instance.priceMax,
      'priceMin': instance.priceMin,
      'priceUnit': instance.priceUnit,
      'priceRange': instance.priceRange,
      'processPostId': instance.processPostId,
      'processPostName': instance.processPostName,
      'projectId': instance.projectId,
      'projectName': instance.projectName,
      'serviceConfId': instance.serviceConfId,
      'serviceDesc': instance.serviceDesc,
      'serviceName': instance.serviceName,
      'serviceTime': instance.serviceTime,
      'serviceType': instance.serviceType,
      'serviceTypeName': instance.serviceTypeName,
      'showPhotoList': instance.showPhotoList,
      'styleListJson': instance.styleListJson,
      'styleList': instance.styleListName,
      'updateTime': instance.updateTime,
      'updateUserId': instance.updateUserId,
      'validFlag': instance.validFlag,
    };

PosterPhotoList _$PosterPhotoListFromJson(Map<String, dynamic> json) {
  return PosterPhotoList(
    json['uuid'] as String,
    json['url'] as String,
  );
}

Map<String, dynamic> _$PosterPhotoListToJson(PosterPhotoList instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'url': instance.url,
    };
