// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entrance_card_list_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EntranceCardListRequest _$EntranceCardListRequestFromJson(
    Map<String, dynamic> json) {
  return EntranceCardListRequest(
    projectId: json['projectId'] as int,
    queryType: json['queryType'] as String,
  )
    ..pageSize = json['pageSize'] as int
    ..current = json['current'] as int;
}

Map<String, dynamic> _$EntranceCardListRequestToJson(
        EntranceCardListRequest instance) =>
    <String, dynamic>{
      'pageSize': instance.pageSize,
      'current': instance.current,
      'projectId': instance.projectId,
      'queryType': instance.queryType,
    };
