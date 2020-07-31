import 'package:json_annotation/json_annotation.dart';

part 'pgc_infomation_obj.g.dart';


@JsonSerializable()
class PgcInfomationObj extends Object {

  @JsonKey(name: 'appCodes')
  List<String> appCodes;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'data')
  PgcInfomationInfo pgcInfomationInfo;

  @JsonKey(name: 'extStr')
  String extStr;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'totalCount')
  int totalCount;

  PgcInfomationObj({this.appCodes,this.code,this.pgcInfomationInfo,this.extStr,this.message,this.systemDate,this.totalCount,});

  factory PgcInfomationObj.fromJson(Map<String, dynamic> srcJson) => _$PgcInfomationObjFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PgcInfomationObjToJson(this);

}


@JsonSerializable()
class PgcInfomationInfo extends Object {

  @JsonKey(name: 'author')
  String author;

  @JsonKey(name: 'bookPublishTime')
  String bookPublishTime;

  @JsonKey(name: 'browseCount')
  int browseCount;

  @JsonKey(name: 'commentCount')
  int commentCount;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'createTime')
  String createTime;

  @JsonKey(name: 'createUser')
  int createUser;

  @JsonKey(name: 'isTop')
  String isTop;

  @JsonKey(name: 'keyword')
  String keyword;

  @JsonKey(name: 'likeCount')
  int likeCount;

  @JsonKey(name: 'operationLogList')
  List<OperationLogList> operationLogList;

  @JsonKey(name: 'orgId')
  int orgId;

  @JsonKey(name: 'orgName')
  String orgName;

  @JsonKey(name: 'pgcId')
  int pgcId;

  @JsonKey(name: 'pgcTitle')
  String pgcTitle;

  @JsonKey(name: 'projectIdList')
  List<int> projectIdList;

  @JsonKey(name: 'projectNames')
  String projectNames;

  @JsonKey(name: 'publishLimit')
  String publishLimit;

  @JsonKey(name: 'publishMethod')
  String publishMethod;

  @JsonKey(name: 'publishTime')
  String publishTime;

  @JsonKey(name: 'source')
  String source;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'statusName')
  String statusName;

  @JsonKey(name: 'titlePic')
  String titlePic;

  @JsonKey(name: 'updateTime')
  String updateTime;

  @JsonKey(name: 'updateUser')
  int updateUser;

  @JsonKey(name: 'weight')
  int weight;
  @JsonKey(name: 'custCollect')
  String custCollect;
  @JsonKey(name: 'custLike')
  String custLike;

  PgcInfomationInfo({this.author,this.bookPublishTime,this.browseCount,this.commentCount,this.content,this.createTime,this.createUser,this.isTop,this.keyword,this.likeCount,this.operationLogList,this.orgId,this.orgName,this.pgcId,this.pgcTitle,this.projectIdList,this.projectNames,this.publishLimit,this.publishMethod,this.publishTime,this.source,this.status,this.statusName,this.titlePic,this.updateTime,this.updateUser,this.weight,this.custCollect,this.custLike});

  factory PgcInfomationInfo.fromJson(Map<String, dynamic> srcJson) => _$PgcInfomationInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PgcInfomationInfoToJson(this);

}


@JsonSerializable()
class OperationLogList extends Object {

  @JsonKey(name: 'auditResult')
  String auditResult;

  @JsonKey(name: 'createTime')
  String createTime;

  @JsonKey(name: 'logId')
  int logId;

  @JsonKey(name: 'operationName')
  String operationName;

  @JsonKey(name: 'pgcId')
  int pgcId;

  @JsonKey(name: 'remark')
  String remark;

  @JsonKey(name: 'userId')
  int userId;

  @JsonKey(name: 'userName')
  String userName;

  OperationLogList({this.auditResult,this.createTime,this.logId,this.operationName,this.pgcId,this.remark,this.userId,this.userName,});

  factory OperationLogList.fromJson(Map<String, dynamic> srcJson) => _$OperationLogListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$OperationLogListToJson(this);

}


