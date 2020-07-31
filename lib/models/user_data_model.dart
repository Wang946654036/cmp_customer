import 'package:json_annotation/json_annotation.dart';

part 'user_data_model.g.dart';

@JsonSerializable()
class UserDataModel extends Object {
  @JsonKey(name: 'appCodes')
  List<String> appCodes;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'data')
  UserInfo userInfo;

  @JsonKey(name: 'extStr')
  String extStr;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'totalCount')
  int totalCount;

  UserDataModel(
    this.appCodes,
    this.code,
    this.userInfo,
    this.extStr,
    this.message,
    this.systemDate,
    this.totalCount,
  );

  factory UserDataModel.fromJson(Map<String, dynamic> srcJson) => _$UserDataModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserDataModelToJson(this);
}

@JsonSerializable()
class UserInfo extends Object {
  @JsonKey(name: 'custBirth')
  String custBirth;

  @JsonKey(name: 'custCode')
  String custCode;

  @JsonKey(name: 'custPhoto')
  String custPhoto;

  @JsonKey(name: 'custId')
  int custId;

  @JsonKey(name: 'custKind')
  String custKind;

  @JsonKey(name: 'custLoginAfterDtoList')
  List<HouseInfo> houseDefaultCommunityList;

  @JsonKey(name: 'custLoginAfterDtoListNotDefault')
  List<HouseInfo> houseAllList;

  @JsonKey(name: 'custName')
  String custName;

  @JsonKey(name: 'custPhone')
  String custPhone;

  @JsonKey(name: 'custType')
  String custType;

  @JsonKey(name: 'customerAppInfo')
  CustomerAppInfo customerAppInfo;

  @JsonKey(name: 'gender')
  String gender;

  @JsonKey(name: 'marriageStatus')
  String marriageStatus;

  @JsonKey(name: 'personalityDesc')
  String personalityDesc;

  @JsonKey(name: 'platformStatus')
  int platformStatus;

  @JsonKey(name: 'renantRelationId')
  int renantRelationId;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'vipLevel')
  String vipLevel;

  //默认社区的服务电话
  @JsonKey(name: 'alldayTel')
  String alldayTel;

  @JsonKey(name: 'managementNoticeVoList')
  List<PropertyNotice> propertyNoticeList;

  @JsonKey(name: 'customerMenuVoList')
  List<MenuInfo> menuList;

  UserInfo(
      this.custBirth,
      this.custCode,
      this.custId,
      this.custKind,
      this.houseDefaultCommunityList,
      this.houseAllList,
      this.custName,
      this.custPhone,
      this.custType,
      this.customerAppInfo,
      this.gender,
      this.marriageStatus,
      this.personalityDesc,
      this.platformStatus,
      this.renantRelationId,
      this.status,
      this.vipLevel,
      this.propertyNoticeList,
      this.alldayTel,
      this.custPhoto,
      this.menuList);

  factory UserInfo.fromJson(Map<String, dynamic> srcJson) => _$UserInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}

@JsonSerializable()
class HouseInfo extends Object {
  @JsonKey(name: 'buildId')
  int buildId;

  @JsonKey(name: 'buildName')
  String buildName;

  @JsonKey(name: 'createTime')
  String createTime;

  @JsonKey(name: 'creator')
  String creator;

  @JsonKey(name: 'creatorId')
  int creatorId;

  @JsonKey(name: 'custHouseRelationId')
  int custHouseRelationId;

  @JsonKey(name: 'custId')
  int custId;

  @JsonKey(name: 'custProper')
  String custProper;

  @JsonKey(name: 'floorName')
  String floorName;

  @JsonKey(name: 'houseId')
  int houseId;

  @JsonKey(name: 'houseNo')
  String houseNo;

  @JsonKey(name: 'isDefaultHouse')
  String isDefaultHouse;

  @JsonKey(name: 'isDefaultProject')
  String isDefaultProject;

  @JsonKey(name: 'memberNumber')
  String memberNumber;

  @JsonKey(name: 'projectId')
  int projectId;

  @JsonKey(name: 'projectName')
  String projectName;

  @JsonKey(name: 'formerName')
  String formerName;

  @JsonKey(name: 'rentEndTime')
  String rentEndTime;

  @JsonKey(name: 'rentStartTime')
  String rentStartTime;

  @JsonKey(name: 'repossessTime')
  String repossessTime;

  @JsonKey(name: 'settleInTime')
  String settleInTime;

  @JsonKey(name: 'settleStatus')
  String settleStatus;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'unitId')
  int unitId;

  @JsonKey(name: 'unitName')
  String unitName;

  @JsonKey(name: 'updateTime')
  String updateTime;

  @JsonKey(name: 'updator')
  String updator;

  @JsonKey(name: 'buildType')
  String buildType;

  @JsonKey(name: 'updatorId')
  int updatorId;

  @JsonKey(name: 'custName')
  String custName;

  @JsonKey(name: 'custPhone')
  String custPhone;

  bool selected = false; //是否选中用于房屋选择用

  HouseInfo(
      {this.buildId,
      this.buildName,
      this.createTime,
      this.creator,
      this.creatorId,
      this.custHouseRelationId,
      this.custId,
      this.custProper,
      this.floorName,
      this.houseId,
      this.houseNo,
      this.isDefaultHouse,
      this.isDefaultProject,
      this.memberNumber,
      this.projectId,
      this.projectName,
      this.rentEndTime,
      this.rentStartTime,
      this.repossessTime,
      this.settleInTime,
      this.settleStatus,
      this.status,
      this.unitId,
      this.unitName,
      this.updateTime,
      this.updator,
      this.updatorId,
      this.buildType,
      this.custName,
      this.custPhone,
      this.formerName});

  factory HouseInfo.fromJson(Map<String, dynamic> srcJson) => _$HouseInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HouseInfoToJson(this);
}

@JsonSerializable()
class PropertyNotice extends Object {
  @JsonKey(name: 'attachmentList')
  List<Attachment> attachmentList;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'isTimed')
  int isTimed;

  @JsonKey(name: 'noticeScopeList')
  List<NoticeScope> noticeScopeList;

  @JsonKey(name: 'orgId')
  int orgId;

  @JsonKey(name: 'scopeIds')
  String scopeIds;

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

  PropertyNotice(
    this.attachmentList,
    this.content,
    this.id,
    this.isTimed,
    this.noticeScopeList,
    this.orgId,
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
  );

  factory PropertyNotice.fromJson(Map<String, dynamic> srcJson) => _$PropertyNoticeFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PropertyNoticeToJson(this);
}

@JsonSerializable()
class Attachment extends Object {
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

  Attachment({
    this.attachmentName,
    this.attachmentType,
    this.attachmentUuid,
    this.createTime,
    this.id,
    this.relatedId,
    this.source,
    this.status,
    this.type,
  });

  factory Attachment.fromJson(Map<String, dynamic> srcJson) => _$AttachmentFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AttachmentToJson(this);
}

@JsonSerializable()
class NoticeScope extends Object {
  @JsonKey(name: 'receiveId')
  int receiveId;

  @JsonKey(name: 'receiveName')
  String receiveName;

  @JsonKey(name: 'receiveType')
  int receiveType;

  NoticeScope(
    this.receiveId,
    this.receiveName,
    this.receiveType,
  );

  factory NoticeScope.fromJson(Map<String, dynamic> srcJson) => _$NoticeScopeFromJson(srcJson);

  Map<String, dynamic> toJson() => _$NoticeScopeToJson(this);
}

@JsonSerializable()
class CustomerAppInfo extends Object {
  @JsonKey(name: 'birthDate')
  String birthDate;

  @JsonKey(name: 'custEnabled')
  bool custEnabled;

  @JsonKey(name: 'customerType')
  int customerType;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'mobile')
  String mobile;

  @JsonKey(name: 'realname')
  String realname;

  @JsonKey(name: 'roleIds')
  List<int> roleIds;

  @JsonKey(name: 'roleInfoList')
  List<RoleInfo> roleInfoList;

  @JsonKey(name: 'sex')
  int sex;

  @JsonKey(name: 'signature')
  String signature;

  @JsonKey(name: 'nickname')
  String nickname;

  CustomerAppInfo(
    this.birthDate,
    this.custEnabled,
    this.customerType,
    this.id,
    this.mobile,
    this.realname,
    this.roleIds,
    this.roleInfoList,
    this.sex,
    this.signature,
    this.nickname,
  );

  factory CustomerAppInfo.fromJson(Map<String, dynamic> srcJson) => _$CustomerAppInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CustomerAppInfoToJson(this);
}

@JsonSerializable()
class RoleInfo extends Object {
  @JsonKey(name: 'appResourceIds')
  List<int> appResourceIds;

  @JsonKey(name: 'createTime')
  String createTime;

  @JsonKey(name: 'description')
  String description;

  @JsonKey(name: 'enabled')
  bool enabled;

  @JsonKey(name: 'enabledIds')
  String enabledIds;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'orgId')
  int orgId;

  @JsonKey(name: 'orgType')
  int orgType;

  @JsonKey(name: 'orgTypeName')
  String orgTypeName;

  @JsonKey(name: 'resourceIds')
  List<int> resourceIds;

  @JsonKey(name: 'resources')
  String resources;

  @JsonKey(name: 'roleCode')
  String roleCode;

  @JsonKey(name: 'roleName')
  String roleName;

  @JsonKey(name: 'type')
  int type;

  @JsonKey(name: 'webResourceIds')
  List<int> webResourceIds;

  @JsonKey(name: 'whole')
  int whole;

  RoleInfo(
    this.appResourceIds,
    this.createTime,
    this.description,
    this.enabled,
    this.enabledIds,
    this.id,
    this.orgId,
    this.orgType,
    this.orgTypeName,
    this.resourceIds,
    this.resources,
    this.roleCode,
    this.roleName,
    this.type,
    this.webResourceIds,
    this.whole,
  );

  factory RoleInfo.fromJson(Map<String, dynamic> srcJson) => _$RoleInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RoleInfoToJson(this);
}

@JsonSerializable()
class MenuInfo extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'resourceName')
  String resourceName;

  @JsonKey(name: 'relationType')
  String relationType;

  @JsonKey(name: 'linkUrl')
  String linkUrl;

  @JsonKey(name: 'icon')
  String icon;

  @JsonKey(name: 'subTitle')
  String subTitle;

  @JsonKey(name: 'type')
  int type;

  @JsonKey(name: 'parentId')
  int parentId;

  @JsonKey(name: 'enabled')
  bool enabled;

  @JsonKey(name: 'childrenType')
  int childrenType;

  @JsonKey(name: 'order_no')
  int orderNo;

  @JsonKey(name: 'childrenList')
  List<MenuInfo> children;

  MenuInfo(this.id, this.resourceName, this.relationType, this.linkUrl, this.type, this.enabled, this.childrenType, this.children,
      this.icon, this.subTitle, this.orderNo);

  factory MenuInfo.fromJson(Map<String, dynamic> srcJson) => _$MenuInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MenuInfoToJson(this);
}
