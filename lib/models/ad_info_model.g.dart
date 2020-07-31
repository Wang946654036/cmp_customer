// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ad_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdInfoModel _$AdInfoModelFromJson(Map<String, dynamic> json) {
  return AdInfoModel(
    (json['appCodes'] as List)?.map((e) => e as String)?.toList(),
    json['code'] as String,
    (json['data'] as List)
        ?.map((e) =>
            e == null ? null : AdInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['extStr'] as String,
    json['message'] as String,
    json['systemDate'] as String,
    json['totalCount'] as int,
  );
}

Map<String, dynamic> _$AdInfoModelToJson(AdInfoModel instance) =>
    <String, dynamic>{
      'appCodes': instance.appCodes,
      'code': instance.code,
      'data': instance.adInfo,
      'extStr': instance.extStr,
      'message': instance.message,
      'systemDate': instance.systemDate,
      'totalCount': instance.totalCount,
    };

AdInfo _$AdInfoFromJson(Map<String, dynamic> json) {
  return AdInfo(
    beginTime: json['beginTime'] as String,
    content: json['content'] as String,
    endTime: json['endTime'] as String,
    id: json['id'] as int,
    imgUrl: json['imgUrl'] as String,
    title: json['title'] as String,
    toUrl: json['toUrl'] as String,
    type: json['type'] as String,
    foreign: json['foreign'] as String,
  );
}

Map<String, dynamic> _$AdInfoToJson(AdInfo instance) => <String, dynamic>{
      'beginTime': instance.beginTime,
      'content': instance.content,
      'endTime': instance.endTime,
      'id': instance.id,
      'imgUrl': instance.imgUrl,
      'title': instance.title,
      'toUrl': instance.toUrl,
      'type': instance.type,
      'foreign': instance.foreign,
    };
