import 'package:cmp_customer/models/property_notice_model.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'property_notice_detail_model.g.dart';

@JsonSerializable()
class PropertyNoticeDetailModel extends Object {
  @JsonKey(name: 'appCodes')
  List<String> appCodes;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'data')
  PropertyNoticeDetail propertyNoticeDetail;

  @JsonKey(name: 'extStr')
  String extStr;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'totalCount')
  int totalCount;

  PropertyNoticeDetailModel(
    this.appCodes,
    this.code,
    this.propertyNoticeDetail,
    this.extStr,
    this.message,
    this.systemDate,
    this.totalCount,
  );

  factory PropertyNoticeDetailModel.fromJson(Map<String, dynamic> srcJson) =>
      _$PropertyNoticeDetailModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PropertyNoticeDetailModelToJson(this);
}

@JsonSerializable()
class PropertyNoticeDetail extends Object {
  @JsonKey(name: 'attachmentList')
  List<ImageInfo> imageList;

  @JsonKey(name: 'checkStatus')
  int checkStatus;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'fileList')
  List<Attachment> fileList;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'isRead')
  String isRead;

  @JsonKey(name: 'isTimed')
  int isTimed;

  @JsonKey(name: 'operationUser')
  int operationUser;

  @JsonKey(name: 'orgId')
  int orgId;

  @JsonKey(name: 'orgName')
  String orgName;

  @JsonKey(name: 'scopeIds')
  List<int> scopeIds;

  @JsonKey(name: 'sendScope')
  int sendScope;

  @JsonKey(name: 'sendTarget')
  int sendTarget;

  @JsonKey(name: 'sendTime')
  String sendTime;

  @JsonKey(name: 'sendUser')
  int sendUser;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'submitTime')
  String submitTime;

  @JsonKey(name: 'suggestion')
  String suggestion;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'type')
  int type;

  @JsonKey(name: 'userOrgId')
  int userOrgId;

  PropertyNoticeDetail({
    this.imageList,
    this.checkStatus,
    this.content,
    this.fileList,
    this.id,
    this.isRead,
    this.isTimed,
    this.operationUser,
    this.orgId,
    this.orgName,
    this.scopeIds,
    this.sendScope,
    this.sendTarget,
    this.sendTime,
    this.sendUser,
    this.status,
    this.submitTime,
    this.suggestion,
    this.title,
    this.type,
    this.userOrgId,}
  );

  factory PropertyNoticeDetail.fromJson(Map<String, dynamic> srcJson) => _$PropertyNoticeDetailFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PropertyNoticeDetailToJson(this);
}
