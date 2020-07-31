// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'decoration_pass_card_history_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DecorationPassCardHistoryResponse _$DecorationPassCardHistoryResponseFromJson(
    Map<String, dynamic> json) {
  return DecorationPassCardHistoryResponse()
    ..code = json['code'] as String
    ..message = json['message'] as String
    ..historyList = (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : DecorationPassCardDetails.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$DecorationPassCardHistoryResponseToJson(
        DecorationPassCardHistoryResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.historyList,
    };
