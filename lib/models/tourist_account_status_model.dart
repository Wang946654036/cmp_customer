import 'package:json_annotation/json_annotation.dart';

part 'tourist_account_status_model.g.dart';


@JsonSerializable()
class TouristAccountStatusModel extends Object {

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'data')
  Data data;

  TouristAccountStatusModel(this.code,this.message,this.systemDate,this.data,);

  factory TouristAccountStatusModel.fromJson(Map<String, dynamic> srcJson) => _$TouristAccountStatusModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TouristAccountStatusModelToJson(this);

}


@JsonSerializable()
class Data extends Object {

  @JsonKey(name: 'custHouseRelationVoAppList')
  List<CustomerInfo> customerList;

  @JsonKey(name: 'customerAppInfoList')
  List<TouristAccountStatus> touristAccountStatusList;

  Data(this.touristAccountStatusList,this.customerList);

  factory Data.fromJson(Map<String, dynamic> srcJson) => _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);

}


@JsonSerializable()
class CustomerInfo extends Object {

  @JsonKey(name: 'custHouseRelationId')
  int custHouseRelationId;

  @JsonKey(name: 'custId')
  int custId;

  @JsonKey(name: 'houseId')
  int houseId;

  @JsonKey(name: 'projectId')
  int projectId;

  @JsonKey(name: 'buildId')
  int buildId;

  @JsonKey(name: 'unitId')
  int unitId;

  @JsonKey(name: 'custProper')
  String custProper;

  @JsonKey(name: 'settleStatus')
  String settleStatus;

  @JsonKey(name: 'repossessTime')
  String repossessTime;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'isDefaultProject')
  String isDefaultProject;

  @JsonKey(name: 'isDefaultHouse')
  String isDefaultHouse;

  @JsonKey(name: 'creator')
  String creator;

  @JsonKey(name: 'projectName')
  String projectName;

  @JsonKey(name: 'buildName')
  String buildName;

  @JsonKey(name: 'unitName')
  String unitName;

  @JsonKey(name: 'floorName')
  String floorName;

  @JsonKey(name: 'houseNo')
  String houseNo;

  @JsonKey(name: 'custName')
  String custName;

  @JsonKey(name: 'custPhone')
  String custPhone;

  CustomerInfo(this.custHouseRelationId,this.custId,this.houseId,this.projectId,this.buildId,this.unitId,this.custProper,this.settleStatus,this.repossessTime,this.status,this.isDefaultProject,this.isDefaultHouse,this.creator,this.projectName,this.buildName,this.unitName,this.floorName,this.houseNo,this.custName,this.custPhone,);

  factory CustomerInfo.fromJson(Map<String, dynamic> srcJson) => _$CustomerInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CustomerInfoToJson(this);

}




@JsonSerializable()
class TouristAccountStatus extends Object {

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
  List<RoleInfoList> roleInfoList;

  @JsonKey(name: 'sex')
  int sex;

  @JsonKey(name: 'signature')
  String signature;

  TouristAccountStatus(this.birthDate,this.custEnabled,this.customerType,this.id,this.mobile,this.realname,this.roleIds,this.roleInfoList,this.sex,this.signature,);

  factory TouristAccountStatus.fromJson(Map<String, dynamic> srcJson) => _$TouristAccountStatusFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TouristAccountStatusToJson(this);

}



@JsonSerializable()
class RoleInfoList extends Object {

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

  RoleInfoList(this.appResourceIds,this.createTime,this.description,this.enabled,this.enabledIds,this.id,this.orgId,this.orgType,this.orgTypeName,this.resourceIds,this.resources,this.roleCode,this.roleName,this.type,this.webResourceIds,this.whole,);

  factory RoleInfoList.fromJson(Map<String, dynamic> srcJson) => _$RoleInfoListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RoleInfoListToJson(this);

}