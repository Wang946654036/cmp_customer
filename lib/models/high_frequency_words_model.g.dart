// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'high_frequency_words_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HighFrequencyWorks _$HighFrequencyWorksFromJson(Map<String, dynamic> json) {
  return HighFrequencyWorks(
    json['code'] as int,
    json['message'] as String,
    (json['data'] as List)
        ?.map(
            (e) => e == null ? null : Data.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$HighFrequencyWorksToJson(HighFrequencyWorks instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.datas,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    json['attachmentId'] as int,
    json['status'] as String,
    json['attachmentName'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'attachmentId': instance.attachmentId,
      'status': instance.status,
      'attachmentName': instance.attachmentName,
    };
