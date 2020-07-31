// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'share_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShareInfoModel _$ShareInfoModelFromJson(Map<String, dynamic> json) {
  return ShareInfoModel(
    json['title'] as String,
    json['imageUrl'] as String,
    json['content'] as String,
    json['url'] as String,
    json['type'] as String,
  );
}

Map<String, dynamic> _$ShareInfoModelToJson(ShareInfoModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'imageUrl': instance.imageUrl,
      'content': instance.content,
      'url': instance.url,
      'type': instance.type,
    };
