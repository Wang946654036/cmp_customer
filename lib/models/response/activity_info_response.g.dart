// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityInfoResponse _$ActivityInfoResponseFromJson(Map<String, dynamic> json) {
  return ActivityInfoResponse(
    json['data'] == null
        ? null
        : ActivityInfo.fromJson(json['data'] as Map<String, dynamic>),
  )
    ..code = json['code'] as String
    ..message = json['message'] as String;
}

Map<String, dynamic> _$ActivityInfoResponseToJson(
        ActivityInfoResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

ActivityInfo _$ActivityInfoFromJson(Map<String, dynamic> json) {
  return ActivityInfo(
    json['activityId'] as int,
    json['activityNum'] as String,
    json['activityTemplateId'] as int,
    json['activityTitle'] as String,
    json['createTime'] as String,
    json['createUser'] as int,
    json['endTime'] as String,
    json['huoseWinnerTimes'] as int,
    json['isSaveTemplate'] as String,
    json['isUseTemplate'] as String,
    json['joinObj'] as String,
    json['joinTimes'] as int,
    json['location'] as String,
    json['orgId'] as int,
    json['orgName'] as String,
    (json['projectIdList'] as List)?.map((e) => e as int)?.toList(),
    json['projectNames'] as String,
    json['publishLimit'] as String,
    json['rule'] as String,
    json['startTime'] as String,
    json['status'] as String,
    json['thankParticipateLocation'] as String,
    json['thankParticipatePic'] as String,
    json['themePic'] as String,
    json['themeFilePath'] as String,
    json['updateTime'] as String,
    json['updateUser'] as int,
    json['userWinnerTimes'] as int,
  );
}

Map<String, dynamic> _$ActivityInfoToJson(ActivityInfo instance) =>
    <String, dynamic>{
      'activityId': instance.activityId,
      'activityNum': instance.activityNum,
      'activityTemplateId': instance.activityTemplateId,
      'activityTitle': instance.activityTitle,
      'createTime': instance.createTime,
      'createUser': instance.createUser,
      'endTime': instance.endTime,
      'huoseWinnerTimes': instance.huoseWinnerTimes,
      'isSaveTemplate': instance.isSaveTemplate,
      'isUseTemplate': instance.isUseTemplate,
      'joinObj': instance.joinObj,
      'joinTimes': instance.joinTimes,
      'location': instance.location,
      'orgId': instance.orgId,
      'orgName': instance.orgName,
      'projectIdList': instance.projectIdList,
      'projectNames': instance.projectNames,
      'publishLimit': instance.publishLimit,
      'rule': instance.rule,
      'startTime': instance.startTime,
      'status': instance.status,
      'thankParticipateLocation': instance.thankParticipateLocation,
      'thankParticipatePic': instance.thankParticipatePic,
      'themePic': instance.themePic,
      'themeFilePath': instance.themeFilePath,
      'updateTime': instance.updateTime,
      'updateUser': instance.updateUser,
      'userWinnerTimes': instance.userWinnerTimes,
    };
