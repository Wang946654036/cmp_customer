import 'package:cmp_customer/models/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'activity_info_response.g.dart';


@JsonSerializable()
class ActivityInfoResponse extends BaseResponse {


  @JsonKey(name: 'data')
  ActivityInfo data;

  ActivityInfoResponse(this.data);

  factory ActivityInfoResponse.fromJson(Map<String, dynamic> srcJson) => _$ActivityInfoResponseFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ActivityInfoResponseToJson(this);

}


@JsonSerializable()
class ActivityInfo extends Object {

  @JsonKey(name: 'activityId')
  int activityId;

  @JsonKey(name: 'activityNum')
  String activityNum;

  @JsonKey(name: 'activityTemplateId')
  int activityTemplateId;

  @JsonKey(name: 'activityTitle')
  String activityTitle;

  @JsonKey(name: 'createTime')
  String createTime;

  @JsonKey(name: 'createUser')
  int createUser;

  @JsonKey(name: 'endTime')
  String endTime;

  @JsonKey(name: 'huoseWinnerTimes')
  int huoseWinnerTimes;

  @JsonKey(name: 'isSaveTemplate')
  String isSaveTemplate;

  @JsonKey(name: 'isUseTemplate')
  String isUseTemplate;

  @JsonKey(name: 'joinObj')
  String joinObj;

  @JsonKey(name: 'joinTimes')
  int joinTimes;

  @JsonKey(name: 'location')
  String location;

  @JsonKey(name: 'orgId')
  int orgId;

  @JsonKey(name: 'orgName')
  String orgName;

  @JsonKey(name: 'projectIdList')
  List<int> projectIdList;

  @JsonKey(name: 'projectNames')
  String projectNames;

  @JsonKey(name: 'publishLimit')
  String publishLimit;

  @JsonKey(name: 'rule')
  String rule;

  @JsonKey(name: 'startTime')
  String startTime;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'thankParticipateLocation')
  String thankParticipateLocation;

  @JsonKey(name: 'thankParticipatePic')
  String thankParticipatePic;

  @JsonKey(name: 'themePic')
  String themePic;

  @JsonKey(name: 'themeFilePath')
  String themeFilePath;

  @JsonKey(name: 'updateTime')
  String updateTime;

  @JsonKey(name: 'updateUser')
  int updateUser;

  @JsonKey(name: 'userWinnerTimes')
  int userWinnerTimes;

  ActivityInfo(this.activityId,this.activityNum,this.activityTemplateId,this.activityTitle,this.createTime,this.createUser,this.endTime,this.huoseWinnerTimes,this.isSaveTemplate,this.isUseTemplate,this.joinObj,this.joinTimes,this.location,this.orgId,this.orgName,this.projectIdList,this.projectNames,this.publishLimit,this.rule,this.startTime,this.status,this.thankParticipateLocation,this.thankParticipatePic,this.themePic,this.themeFilePath,this.updateTime,this.updateUser,this.userWinnerTimes,);

  factory ActivityInfo.fromJson(Map<String, dynamic> srcJson) => _$ActivityInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ActivityInfoToJson(this);

}

