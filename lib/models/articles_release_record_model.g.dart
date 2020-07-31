// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'articles_release_record_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticlesReleaseRecordModel _$ArticlesReleaseRecordModelFromJson(
    Map<String, dynamic> json) {
  return ArticlesReleaseRecordModel(
    (json['appCodes'] as List)?.map((e) => e as String)?.toList(),
    json['code'] as String,
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : ArticlesReleaseInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['extStr'] as String,
    json['message'] as String,
    json['systemDate'] as String,
    json['totalCount'] as int,
  );
}

Map<String, dynamic> _$ArticlesReleaseRecordModelToJson(
        ArticlesReleaseRecordModel instance) =>
    <String, dynamic>{
      'appCodes': instance.appCodes,
      'code': instance.code,
      'data': instance.articlesReleaseList,
      'extStr': instance.extStr,
      'message': instance.message,
      'systemDate': instance.systemDate,
      'totalCount': instance.totalCount,
    };

ArticlesReleaseInfo _$ArticlesReleaseInfoFromJson(Map<String, dynamic> json) {
  return ArticlesReleaseInfo(
    json['buildName'] as String,
    json['businessNo'] as String,
    json['createTime'] as String,
    json['customerName'] as String,
    json['customerPhone'] as String,
    json['customerType'] as String,
    json['goodNames'] as String,
    json['goodNums'] as int,
    json['houseNo'] as String,
    json['operateStep'] as String,
    json['outTime'] as String,
    json['projectName'] as String,
    json['reason'] as String,
    json['releasePassId'] as int,
    json['status'] as String,
    json['unitName'] as String,
    json['updateTime'] as String,
    json['statusDesc'] as String,
  );
}

Map<String, dynamic> _$ArticlesReleaseInfoToJson(
        ArticlesReleaseInfo instance) =>
    <String, dynamic>{
      'buildName': instance.buildName,
      'businessNo': instance.businessNo,
      'createTime': instance.createTime,
      'customerName': instance.customerName,
      'customerPhone': instance.customerPhone,
      'customerType': instance.customerType,
      'goodNames': instance.goodNames,
      'goodNums': instance.goodNums,
      'houseNo': instance.houseNo,
      'operateStep': instance.operateStep,
      'outTime': instance.outTime,
      'projectName': instance.projectName,
      'reason': instance.reason,
      'releasePassId': instance.releasePassId,
      'status': instance.status,
      'statusDesc': instance.statusDesc,
      'unitName': instance.unitName,
      'updateTime': instance.updateTime,
    };
