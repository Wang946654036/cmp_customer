// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'near_info_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NearInfoList _$NearInfoListFromJson(Map<String, dynamic> json) {
  return NearInfoList(
    appCodes: (json['appCodes'] as List)?.map((e) => e as String)?.toList(),
    code: json['code'] as String,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : NearInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    extStr: json['extStr'] as String,
    message: json['message'] as String,
    systemDate: json['systemDate'] as String,
    totalCount: json['totalCount'] as int,
  );
}

Map<String, dynamic> _$NearInfoListToJson(NearInfoList instance) =>
    <String, dynamic>{
      'appCodes': instance.appCodes,
      'code': instance.code,
      'data': instance.data,
      'extStr': instance.extStr,
      'message': instance.message,
      'systemDate': instance.systemDate,
      'totalCount': instance.totalCount,
    };

NearInfo _$NearInfoFromJson(Map<String, dynamic> json) {
  return NearInfo(
    json['address'] as String,
    json['linkPerson'] as String,
    json['name'] as String,
    json['nearId'] as int,
    json['projectId'] as int,
    json['tel'] as String,
  );
}

Map<String, dynamic> _$NearInfoToJson(NearInfo instance) => <String, dynamic>{
      'address': instance.address,
      'linkPerson': instance.linkPerson,
      'name': instance.name,
      'nearId': instance.nearId,
      'projectId': instance.projectId,
      'tel': instance.tel,
    };
