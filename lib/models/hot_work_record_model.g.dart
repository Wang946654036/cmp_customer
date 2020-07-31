// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hot_work_record_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotWorkRecordModel _$HotWorkRecordModelFromJson(Map<String, dynamic> json) {
  return HotWorkRecordModel(
    (json['appCodes'] as List)?.map((e) => e as String)?.toList(),
    json['code'] as String,
    (json['data'] as List)
        ?.map((e) =>
            e == null ? null : HotWorkInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['extStr'] as String,
    json['message'] as String,
    json['systemDate'] as String,
    json['totalCount'] as int,
  );
}

Map<String, dynamic> _$HotWorkRecordModelToJson(HotWorkRecordModel instance) =>
    <String, dynamic>{
      'appCodes': instance.appCodes,
      'code': instance.code,
      'data': instance.hotWorkList,
      'extStr': instance.extStr,
      'message': instance.message,
      'systemDate': instance.systemDate,
      'totalCount': instance.totalCount,
    };

HotWorkInfo _$HotWorkInfoFromJson(Map<String, dynamic> json) {
  return HotWorkInfo(
    json['constructionUnit'] as String,
    json['createTime'] as String,
    json['customerId'] as int,
    json['customerName'] as String,
    json['customerPhone'] as String,
    json['firePreventMan'] as String,
    json['fireWatchMan'] as String,
    json['hotWorkContent'] as String,
    json['hotWorkEndTime'] as String,
    json['hotWorkId'] as int,
    json['hotWorkLocation'] as String,
    json['hotWorkNo'] as String,
    json['hotWorkStartTime'] as String,
    json['houseBuildId'] as int,
    json['houseId'] as int,
    json['houseName'] as String,
    json['houseUnitId'] as int,
    json['onSiteLeader'] as String,
    json['ownerId'] as int,
    json['ownerIdentityNo'] as String,
    json['ownerName'] as String,
    json['ownerPhone'] as String,
    json['processExecutor'] as String,
    json['processId'] as String,
    json['processNodeCode'] as String,
    json['processNodeName'] as String,
    json['processPostId'] as int,
    json['processState'] as String,
    json['processStateName'] as String,
    json['processTime'] as String,
    json['processUserId'] as int,
    json['projectId'] as int,
    json['projectName'] as String,
    json['formerName'] as String,
    json['remark'] as String,
    json['updateTime'] as String,
    (json['welderList'] as List)
        ?.map((e) =>
            e == null ? null : WelderInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$HotWorkInfoToJson(HotWorkInfo instance) =>
    <String, dynamic>{
      'constructionUnit': instance.constructionUnit,
      'createTime': instance.createTime,
      'customerId': instance.customerId,
      'customerName': instance.customerName,
      'customerPhone': instance.customerPhone,
      'firePreventMan': instance.firePreventMan,
      'fireWatchMan': instance.fireWatchMan,
      'hotWorkContent': instance.hotWorkContent,
      'hotWorkEndTime': instance.hotWorkEndTime,
      'hotWorkId': instance.hotWorkId,
      'hotWorkLocation': instance.hotWorkLocation,
      'hotWorkNo': instance.hotWorkNo,
      'hotWorkStartTime': instance.hotWorkStartTime,
      'houseBuildId': instance.houseBuildId,
      'houseId': instance.houseId,
      'houseName': instance.houseName,
      'houseUnitId': instance.houseUnitId,
      'onSiteLeader': instance.onSiteLeader,
      'ownerId': instance.ownerId,
      'ownerIdentityNo': instance.ownerIdentityNo,
      'ownerName': instance.ownerName,
      'ownerPhone': instance.ownerPhone,
      'processExecutor': instance.processExecutor,
      'processId': instance.processId,
      'processNodeCode': instance.processNodeCode,
      'processNodeName': instance.processNodeName,
      'processPostId': instance.processPostId,
      'processState': instance.processState,
      'processStateName': instance.processStateName,
      'processTime': instance.processTime,
      'processUserId': instance.processUserId,
      'projectId': instance.projectId,
      'projectName': instance.projectName,
      'formerName': instance.formerName,
      'remark': instance.remark,
      'updateTime': instance.updateTime,
      'welderList': instance.welderList,
    };
