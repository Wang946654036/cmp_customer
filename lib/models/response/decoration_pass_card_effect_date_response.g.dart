// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'decoration_pass_card_effect_date_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DecorationPassCardEffectDateResponse
    _$DecorationPassCardEffectDateResponseFromJson(Map<String, dynamic> json) {
  return DecorationPassCardEffectDateResponse()
    ..code = json['code'] as String
    ..message = json['message'] as String
    ..effectDate = json['data'] == null
        ? null
        : DecorationPassCardEffectDate.fromJson(
            json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$DecorationPassCardEffectDateResponseToJson(
        DecorationPassCardEffectDateResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.effectDate,
    };

DecorationPassCardEffectDate _$DecorationPassCardEffectDateFromJson(
    Map<String, dynamic> json) {
  return DecorationPassCardEffectDate(
    json['fromDate'] as String,
    json['delayDate'] as String,
  );
}

Map<String, dynamic> _$DecorationPassCardEffectDateToJson(
        DecorationPassCardEffectDate instance) =>
    <String, dynamic>{
      'fromDate': instance.fromDate,
      'delayDate': instance.delayDate,
    };
