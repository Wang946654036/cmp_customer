import 'package:cmp_customer/models/user_data_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'property_notice_model.g.dart';


@JsonSerializable()
class PropertyNoticeModel extends Object {

  @JsonKey(name: 'appCodes')
  List<String> appCodes;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'data')
  List<PropertyNotice> propertyNoticeList;

  @JsonKey(name: 'extStr')
  String extStr;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'totalCount')
  int totalCount;

  PropertyNoticeModel(this.appCodes,this.code,this.propertyNoticeList,this.extStr,this.message,this.systemDate,this.totalCount,);

  factory PropertyNoticeModel.fromJson(Map<String, dynamic> srcJson) => _$PropertyNoticeModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PropertyNoticeModelToJson(this);

}


@JsonSerializable()
class PropertyNotice extends Object {

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
  //是否已读 0代表未读 1代表已读
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

  //公告类型（0-一般 1-重要 2-紧急）
  @JsonKey(name: 'type')
  int type;

  @JsonKey(name: 'userOrgId')
  int userOrgId;

  PropertyNotice(this.imageList,this.checkStatus,this.content,this.fileList,this.id,this.isRead,this.isTimed,this.operationUser,this.orgId,this.orgName,this.scopeIds,this.sendScope,this.sendTarget,this.sendTime,this.sendUser,this.status,this.submitTime,this.suggestion,this.title,this.type,this.userOrgId,);

  factory PropertyNotice.fromJson(Map<String, dynamic> srcJson) => _$PropertyNoticeFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PropertyNoticeToJson(this);

}


@JsonSerializable()
class ImageInfo extends Object {

  @JsonKey(name: 'attachmentName')
  String attachmentName;

  @JsonKey(name: 'attachmentType')
  String attachmentType;

  @JsonKey(name: 'attachmentUuid')
  String attachmentUuid;

  @JsonKey(name: 'createTime')
  String createTime;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'relatedId')
  int relatedId;

  @JsonKey(name: 'source')
  String source;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'type')
  String type;

  ImageInfo(this.attachmentName,this.attachmentType,this.attachmentUuid,this.createTime,this.id,this.relatedId,this.source,this.status,this.type,);

  factory ImageInfo.fromJson(Map<String, dynamic> srcJson) => _$ImageInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ImageInfoToJson(this);

}


//@JsonSerializable()
//class Attachment extends Object {
//
//  @JsonKey(name: 'attachmentName')
//  String attachmentName;
//
//  @JsonKey(name: 'attachmentType')
//  String attachmentType;
//
//  @JsonKey(name: 'attachmentUuid')
//  String attachmentUuid;
//
//  @JsonKey(name: 'createTime')
//  String createTime;
//
//  @JsonKey(name: 'id')
//  int id;
//
//  @JsonKey(name: 'relatedId')
//  int relatedId;
//
//  @JsonKey(name: 'source')
//  String source;
//
//  @JsonKey(name: 'status')
//  String status;
//
//  @JsonKey(name: 'type')
//  String type;
//
//  Attachment(this.attachmentName,this.attachmentType,this.attachmentUuid,this.createTime,this.id,this.relatedId,this.source,this.status,this.type,);
//
//  factory Attachment.fromJson(Map<String, dynamic> srcJson) => _$AttachmentFromJson(srcJson);
//
//  Map<String, dynamic> toJson() => _$AttachmentToJson(this);
//
//}


