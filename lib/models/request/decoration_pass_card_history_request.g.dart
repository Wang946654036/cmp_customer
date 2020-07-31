// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'decoration_pass_card_history_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DecorationPassCardHistoryRequest _$DecorationPassCardHistoryRequestFromJson(
    Map<String, dynamic> json) {
  return DecorationPassCardHistoryRequest()
    ..pageSize = json['pageSize'] as int
    ..current = json['current'] as int
    ..projectId = json['projectId'] as String
    ..ownerId = json['ownerId'] as String
    ..customerId = json['customerId'] as String;
}

Map<String, dynamic> _$DecorationPassCardHistoryRequestToJson(
        DecorationPassCardHistoryRequest instance) =>
    <String, dynamic>{
      'pageSize': instance.pageSize,
      'current': instance.current,
      'projectId': instance.projectId,
      'ownerId': instance.ownerId,
      'customerId': instance.customerId,
    };
