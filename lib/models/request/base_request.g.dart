// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseRequest _$BaseRequestFromJson(Map<String, dynamic> json) {
  return BaseRequest(
    pageSize: json['pageSize'] as int,
    current: json['current'] as int,
  );
}

Map<String, dynamic> _$BaseRequestToJson(BaseRequest instance) =>
    <String, dynamic>{
      'pageSize': instance.pageSize,
      'current': instance.current,
    };
