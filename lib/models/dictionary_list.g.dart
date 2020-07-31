// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dictionary_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DictionaryList _$DictionaryListFromJson(Map<String, dynamic> json) {
  return DictionaryList(
    (json['appCodes'] as List)?.map((e) => e as String)?.toList(),
    json['code'] as String,
    (json['data'] as List)
        ?.map((e) =>
            e == null ? null : Dictionary.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['extStr'] as String,
    json['message'] as String,
    json['systemDate'] as String,
    json['totalCount'] as int,
  );
}

Map<String, dynamic> _$DictionaryListToJson(DictionaryList instance) =>
    <String, dynamic>{
      'appCodes': instance.appCodes,
      'code': instance.code,
      'data': instance.data,
      'extStr': instance.extStr,
      'message': instance.message,
      'systemDate': instance.systemDate,
      'totalCount': instance.totalCount,
    };

Dictionary _$DictionaryFromJson(Map<String, dynamic> json) {
  return Dictionary(
    json['dataCode'] as String,
    json['dataDesc'] as String,
    json['dataName'] as String,
    json['dataSubType'] as String,
    json['dataType'] as String,
    json['dictionaryId'] as int,
    json['sortNo'] as int,
    json['specialInfo'] as String,
    json['validFlag'] as String,
  );
}

Map<String, dynamic> _$DictionaryToJson(Dictionary instance) =>
    <String, dynamic>{
      'dataCode': instance.dataCode,
      'dataDesc': instance.dataDesc,
      'dataName': instance.dataName,
      'dataSubType': instance.dataSubType,
      'dataType': instance.dataType,
      'dictionaryId': instance.dictionaryId,
      'sortNo': instance.sortNo,
      'specialInfo': instance.specialInfo,
      'validFlag': instance.validFlag,
    };
