import 'package:json_annotation/json_annotation.dart';

part 'community_activity_model.g.dart';


@JsonSerializable()
class CommunityActivityModel extends Object {

  @JsonKey(name: 'appCodes')
  List<String> appCodes;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'data')
  List<ActivityInfo> activityList;

  @JsonKey(name: 'extStr')
  String extStr;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'totalCount')
  int totalCount;

  CommunityActivityModel(this.appCodes,this.code,this.activityList,this.extStr,this.message,this.systemDate,this.totalCount,);

  factory CommunityActivityModel.fromJson(Map<String, dynamic> srcJson) => _$CommunityActivityModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CommunityActivityModelToJson(this);

}


@JsonSerializable()
class ActivityInfo extends Object {

  @JsonKey(name: 'activityTarget')
  String activityTarget;

  @JsonKey(name: 'activityType')
  int activityType;

  @JsonKey(name: 'beginTime')
  String beginTime;

  @JsonKey(name: 'commitCount')
  int commitCount;

  @JsonKey(name: 'contentRichText')
  ContentRichText contentRichText;

  @JsonKey(name: 'contentRichTextId')
  int contentRichTextId;

  @JsonKey(name: 'createTime')
  String createTime;

  @JsonKey(name: 'createWorkerId')
  int createWorkerId;

  @JsonKey(name: 'createWorkerName')
  String createWorkerName;

  @JsonKey(name: 'customForm')
  CustomForm customForm;

  @JsonKey(name: 'customFormId')
  int customFormId;

  @JsonKey(name: 'deleted')
  int deleted;

  @JsonKey(name: 'deptId')
  int deptId;

  @JsonKey(name: 'deptName')
  String deptName;

  @JsonKey(name: 'endTime')
  String endTime;

  @JsonKey(name: 'h5Url')
  String h5Url;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'isAnonymous')
  int isAnonymous;

  @JsonKey(name: 'logo')
  String logo;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'num')
  int num;

  @JsonKey(name: 'orgId')
  int orgId;

  @JsonKey(name: 'orgName')
  String orgName;

  @JsonKey(name: 'publishRangeDetail')
  String publishRangeDetail;

  @JsonKey(name: 'publishRangeDetailVo')
  PublishRangeDetailVo publishRangeDetailVo;

  @JsonKey(name: 'publishRangeType')
  int publishRangeType;

  @JsonKey(name: 'publishTime')
  String publishTime;

  @JsonKey(name: 'qrcodeUrl')
  String qrcodeUrl;

  @JsonKey(name: 'rule')
  String rule;

  @JsonKey(name: 'rulesVo')
  RulesVo rulesVo;

  @JsonKey(name: 'shareImgUrl')
  String shareImgUrl;

  @JsonKey(name: 'shareSubtitle')
  String shareSubtitle;

  @JsonKey(name: 'shareTitle')
  String shareTitle;

  @JsonKey(name: 'shortUrl')
  String shortUrl;

  @JsonKey(name: 'status')
  int status;

  ActivityInfo(this.activityTarget,this.activityType,this.beginTime,this.commitCount,this.contentRichText,this.contentRichTextId,this.createTime,this.createWorkerId,this.createWorkerName,this.customForm,this.customFormId,this.deleted,this.deptId,this.deptName,this.endTime,this.h5Url,this.id,this.isAnonymous,this.logo,this.name,this.num,this.orgId,this.orgName,this.publishRangeDetail,this.publishRangeDetailVo,this.publishRangeType,this.publishTime,this.qrcodeUrl,this.rule,this.rulesVo,this.shareImgUrl,this.shareSubtitle,this.shareTitle,this.shortUrl,this.status,);

  factory ActivityInfo.fromJson(Map<String, dynamic> srcJson) => _$ActivityInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ActivityInfoToJson(this);

}


@JsonSerializable()
class ContentRichText extends Object {

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'createTime')
  String createTime;

  @JsonKey(name: 'createWorkerId')
  int createWorkerId;

  @JsonKey(name: 'createWorkerName')
  String createWorkerName;

  @JsonKey(name: 'deleted')
  int deleted;

  @JsonKey(name: 'id')
  int id;

  ContentRichText(this.content,this.createTime,this.createWorkerId,this.createWorkerName,this.deleted,this.id,);

  factory ContentRichText.fromJson(Map<String, dynamic> srcJson) => _$ContentRichTextFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ContentRichTextToJson(this);

}


@JsonSerializable()
class CustomForm extends Object {

  @JsonKey(name: 'copiedTimes')
  int copiedTimes;

  @JsonKey(name: 'createOrgId')
  int createOrgId;

  @JsonKey(name: 'createOrgName')
  String createOrgName;

  @JsonKey(name: 'createTime')
  String createTime;

  @JsonKey(name: 'createWorkerId')
  int createWorkerId;

  @JsonKey(name: 'createWorkerName')
  String createWorkerName;

  @JsonKey(name: 'deleted')
  int deleted;

  @JsonKey(name: 'description')
  String description;

  @JsonKey(name: 'formType')
  int formType;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'templateJson')
  String templateJson;

  CustomForm(this.copiedTimes,this.createOrgId,this.createOrgName,this.createTime,this.createWorkerId,this.createWorkerName,this.deleted,this.description,this.formType,this.id,this.name,this.status,this.templateJson,);

  factory CustomForm.fromJson(Map<String, dynamic> srcJson) => _$CustomFormFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CustomFormToJson(this);

}


@JsonSerializable()
class PublishRangeDetailVo extends Object {

  @JsonKey(name: 'buildId')
  int buildId;

  @JsonKey(name: 'buildName')
  String buildName;

  @JsonKey(name: 'houseId')
  int houseId;

  @JsonKey(name: 'houseNo')
  String houseNo;

  @JsonKey(name: 'projectId')
  int projectId;

  @JsonKey(name: 'projectName')
  String projectName;

  @JsonKey(name: 'unitId')
  int unitId;

  @JsonKey(name: 'unitName')
  String unitName;

  PublishRangeDetailVo(this.buildId,this.buildName,this.houseId,this.houseNo,this.projectId,this.projectName,this.unitId,this.unitName,);

  factory PublishRangeDetailVo.fromJson(Map<String, dynamic> srcJson) => _$PublishRangeDetailVoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PublishRangeDetailVoToJson(this);

}


@JsonSerializable()
class RulesVo extends Object {

  @JsonKey(name: 'displayForm')
  int displayForm;

  @JsonKey(name: 'signUpRules')
  SignUpRules signUpRules;

  @JsonKey(name: 'vote')
  Vote vote;

  RulesVo(this.displayForm,this.signUpRules,this.vote,);

  factory RulesVo.fromJson(Map<String, dynamic> srcJson) => _$RulesVoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RulesVoToJson(this);

}


@JsonSerializable()
class SignUpRules extends Object {

  @JsonKey(name: 'key1')
  int key1;

  @JsonKey(name: 'key2')
  int key2;

  @JsonKey(name: 'key3')
  int key3;

  SignUpRules(this.key1,this.key2,this.key3,);

  factory SignUpRules.fromJson(Map<String, dynamic> srcJson) => _$SignUpRulesFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SignUpRulesToJson(this);

}


@JsonSerializable()
class Vote extends Object {

  @JsonKey(name: 'day')
  int day;

  @JsonKey(name: 'number')
  int number;

  @JsonKey(name: 'type')
  int type;

  Vote(this.day,this.number,this.type,);

  factory Vote.fromJson(Map<String, dynamic> srcJson) => _$VoteFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VoteToJson(this);

}


