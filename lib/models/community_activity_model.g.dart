// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_activity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommunityActivityModel _$CommunityActivityModelFromJson(
    Map<String, dynamic> json) {
  return CommunityActivityModel(
    (json['appCodes'] as List)?.map((e) => e as String)?.toList(),
    json['code'] as String,
    (json['data'] as List)
        ?.map((e) =>
            e == null ? null : ActivityInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['extStr'] as String,
    json['message'] as String,
    json['systemDate'] as String,
    json['totalCount'] as int,
  );
}

Map<String, dynamic> _$CommunityActivityModelToJson(
        CommunityActivityModel instance) =>
    <String, dynamic>{
      'appCodes': instance.appCodes,
      'code': instance.code,
      'data': instance.activityList,
      'extStr': instance.extStr,
      'message': instance.message,
      'systemDate': instance.systemDate,
      'totalCount': instance.totalCount,
    };

ActivityInfo _$ActivityInfoFromJson(Map<String, dynamic> json) {
  return ActivityInfo(
    json['activityTarget'] as String,
    json['activityType'] as int,
    json['beginTime'] as String,
    json['commitCount'] as int,
    json['contentRichText'] == null
        ? null
        : ContentRichText.fromJson(
            json['contentRichText'] as Map<String, dynamic>),
    json['contentRichTextId'] as int,
    json['createTime'] as String,
    json['createWorkerId'] as int,
    json['createWorkerName'] as String,
    json['customForm'] == null
        ? null
        : CustomForm.fromJson(json['customForm'] as Map<String, dynamic>),
    json['customFormId'] as int,
    json['deleted'] as int,
    json['deptId'] as int,
    json['deptName'] as String,
    json['endTime'] as String,
    json['h5Url'] as String,
    json['id'] as int,
    json['isAnonymous'] as int,
    json['logo'] as String,
    json['name'] as String,
    json['num'] as int,
    json['orgId'] as int,
    json['orgName'] as String,
    json['publishRangeDetail'] as String,
    json['publishRangeDetailVo'] == null
        ? null
        : PublishRangeDetailVo.fromJson(
            json['publishRangeDetailVo'] as Map<String, dynamic>),
    json['publishRangeType'] as int,
    json['publishTime'] as String,
    json['qrcodeUrl'] as String,
    json['rule'] as String,
    json['rulesVo'] == null
        ? null
        : RulesVo.fromJson(json['rulesVo'] as Map<String, dynamic>),
    json['shareImgUrl'] as String,
    json['shareSubtitle'] as String,
    json['shareTitle'] as String,
    json['shortUrl'] as String,
    json['status'] as int,
  );
}

Map<String, dynamic> _$ActivityInfoToJson(ActivityInfo instance) =>
    <String, dynamic>{
      'activityTarget': instance.activityTarget,
      'activityType': instance.activityType,
      'beginTime': instance.beginTime,
      'commitCount': instance.commitCount,
      'contentRichText': instance.contentRichText,
      'contentRichTextId': instance.contentRichTextId,
      'createTime': instance.createTime,
      'createWorkerId': instance.createWorkerId,
      'createWorkerName': instance.createWorkerName,
      'customForm': instance.customForm,
      'customFormId': instance.customFormId,
      'deleted': instance.deleted,
      'deptId': instance.deptId,
      'deptName': instance.deptName,
      'endTime': instance.endTime,
      'h5Url': instance.h5Url,
      'id': instance.id,
      'isAnonymous': instance.isAnonymous,
      'logo': instance.logo,
      'name': instance.name,
      'num': instance.num,
      'orgId': instance.orgId,
      'orgName': instance.orgName,
      'publishRangeDetail': instance.publishRangeDetail,
      'publishRangeDetailVo': instance.publishRangeDetailVo,
      'publishRangeType': instance.publishRangeType,
      'publishTime': instance.publishTime,
      'qrcodeUrl': instance.qrcodeUrl,
      'rule': instance.rule,
      'rulesVo': instance.rulesVo,
      'shareImgUrl': instance.shareImgUrl,
      'shareSubtitle': instance.shareSubtitle,
      'shareTitle': instance.shareTitle,
      'shortUrl': instance.shortUrl,
      'status': instance.status,
    };

ContentRichText _$ContentRichTextFromJson(Map<String, dynamic> json) {
  return ContentRichText(
    json['content'] as String,
    json['createTime'] as String,
    json['createWorkerId'] as int,
    json['createWorkerName'] as String,
    json['deleted'] as int,
    json['id'] as int,
  );
}

Map<String, dynamic> _$ContentRichTextToJson(ContentRichText instance) =>
    <String, dynamic>{
      'content': instance.content,
      'createTime': instance.createTime,
      'createWorkerId': instance.createWorkerId,
      'createWorkerName': instance.createWorkerName,
      'deleted': instance.deleted,
      'id': instance.id,
    };

CustomForm _$CustomFormFromJson(Map<String, dynamic> json) {
  return CustomForm(
    json['copiedTimes'] as int,
    json['createOrgId'] as int,
    json['createOrgName'] as String,
    json['createTime'] as String,
    json['createWorkerId'] as int,
    json['createWorkerName'] as String,
    json['deleted'] as int,
    json['description'] as String,
    json['formType'] as int,
    json['id'] as int,
    json['name'] as String,
    json['status'] as int,
    json['templateJson'] as String,
  );
}

Map<String, dynamic> _$CustomFormToJson(CustomForm instance) =>
    <String, dynamic>{
      'copiedTimes': instance.copiedTimes,
      'createOrgId': instance.createOrgId,
      'createOrgName': instance.createOrgName,
      'createTime': instance.createTime,
      'createWorkerId': instance.createWorkerId,
      'createWorkerName': instance.createWorkerName,
      'deleted': instance.deleted,
      'description': instance.description,
      'formType': instance.formType,
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'templateJson': instance.templateJson,
    };

PublishRangeDetailVo _$PublishRangeDetailVoFromJson(Map<String, dynamic> json) {
  return PublishRangeDetailVo(
    json['buildId'] as int,
    json['buildName'] as String,
    json['houseId'] as int,
    json['houseNo'] as String,
    json['projectId'] as int,
    json['projectName'] as String,
    json['unitId'] as int,
    json['unitName'] as String,
  );
}

Map<String, dynamic> _$PublishRangeDetailVoToJson(
        PublishRangeDetailVo instance) =>
    <String, dynamic>{
      'buildId': instance.buildId,
      'buildName': instance.buildName,
      'houseId': instance.houseId,
      'houseNo': instance.houseNo,
      'projectId': instance.projectId,
      'projectName': instance.projectName,
      'unitId': instance.unitId,
      'unitName': instance.unitName,
    };

RulesVo _$RulesVoFromJson(Map<String, dynamic> json) {
  return RulesVo(
    json['displayForm'] as int,
    json['signUpRules'] == null
        ? null
        : SignUpRules.fromJson(json['signUpRules'] as Map<String, dynamic>),
    json['vote'] == null
        ? null
        : Vote.fromJson(json['vote'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RulesVoToJson(RulesVo instance) => <String, dynamic>{
      'displayForm': instance.displayForm,
      'signUpRules': instance.signUpRules,
      'vote': instance.vote,
    };

SignUpRules _$SignUpRulesFromJson(Map<String, dynamic> json) {
  return SignUpRules(
    json['key1'] as int,
    json['key2'] as int,
    json['key3'] as int,
  );
}

Map<String, dynamic> _$SignUpRulesToJson(SignUpRules instance) =>
    <String, dynamic>{
      'key1': instance.key1,
      'key2': instance.key2,
      'key3': instance.key3,
    };

Vote _$VoteFromJson(Map<String, dynamic> json) {
  return Vote(
    json['day'] as int,
    json['number'] as int,
    json['type'] as int,
  );
}

Map<String, dynamic> _$VoteToJson(Vote instance) => <String, dynamic>{
      'day': instance.day,
      'number': instance.number,
      'type': instance.type,
    };
