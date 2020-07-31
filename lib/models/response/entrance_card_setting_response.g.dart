// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entrance_card_setting_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EntranceCardSettingResponse _$EntranceCardSettingResponseFromJson(
    Map<String, dynamic> json) {
  return EntranceCardSettingResponse(
    json['data'] == null
        ? null
        : EntranceCardSetting.fromJson(json['data'] as Map<String, dynamic>),
  )
    ..code = json['code'] as String
    ..message = json['message'] as String;
}

Map<String, dynamic> _$EntranceCardSettingResponseToJson(
        EntranceCardSettingResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.entranceCardSetting,
    };

EntranceCardSetting _$EntranceCardSettingFromJson(Map<String, dynamic> json) {
  return EntranceCardSetting(
    json['settingId'] as int,
    json['headIconFlag'] as String,
    (json['unitPrice'] as num)?.toDouble(),
    json['projectId'] as int,
    json['projectName'] as String,
    json['settingName'] as String,
    json['chargeDesc'] as String,
    json['paymentTip'] as String,
    json['status'] as String,
    json['creatorId'] as int,
    json['createTime'] as String,
  );
}

Map<String, dynamic> _$EntranceCardSettingToJson(
        EntranceCardSetting instance) =>
    <String, dynamic>{
      'settingId': instance.settingId,
      'headIconFlag': instance.headIconFlag,
      'unitPrice': instance.unitPrice,
      'projectId': instance.projectId,
      'projectName': instance.projectName,
      'settingName': instance.settingName,
      'chargeDesc': instance.chargeDesc,
      'paymentTip': instance.paymentTip,
      'status': instance.status,
      'creatorId': instance.creatorId,
      'createTime': instance.createTime,
    };
