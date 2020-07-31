import 'package:json_annotation/json_annotation.dart';

part 'access_pass_model.g.dart';


@JsonSerializable()
class AccessPassModel extends Object {

  @JsonKey(name: 'appCodes')
  List<String> appCodes;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'data')
  List<AccessPassInfo> AccessPassList;

  @JsonKey(name: 'extStr')
  String extStr;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'totalCount')
  int totalCount;

  AccessPassModel(this.appCodes,this.code,this.AccessPassList,this.extStr,this.message,this.systemDate,this.totalCount,);

  factory AccessPassModel.fromJson(Map<String, dynamic> srcJson) => _$AccessPassModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AccessPassModelToJson(this);

}


@JsonSerializable()
class AccessPassInfo extends Object {

  @JsonKey(name: 'buildId')
  int buildId;

  @JsonKey(name: 'buildName')
  String buildName;

  @JsonKey(name: 'cardType')
  String cardType;

  @JsonKey(name: 'cardTypeName')
  String cardTypeName;

  @JsonKey(name: 'createTime')
  String createTime;

  @JsonKey(name: 'creatorId')
  int creatorId;

  @JsonKey(name: 'custHouseRelationId')
  int custHouseRelationId;

  @JsonKey(name: 'custIdNum')
  String custIdNum;

  @JsonKey(name: 'custName')
  String custName;

  @JsonKey(name: 'custPhone')
  String custPhone;

  @JsonKey(name: 'custProper')
  String custProper;

  @JsonKey(name: 'custProperName')
  String custProperName;

  @JsonKey(name: 'custType')
  String custType;

  @JsonKey(name: 'custTypeName')
  String custTypeName;

  @JsonKey(name: 'houseId')
  int houseId;

  @JsonKey(name: 'houseNo')
  String houseNo;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'idTypeId')
  String idTypeId;

  @JsonKey(name: 'idTypeIdName')
  String idTypeIdName;

  @JsonKey(name: 'mobile')
  String mobile;

  @JsonKey(name: 'projectId')
  int projectId;

  @JsonKey(name: 'projectName')
  String projectName;

  @JsonKey(name: 'qrCodeTime')
  String qrCodeTime;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'unitId')
  int unitId;

  @JsonKey(name: 'unitName')
  String unitName;

  AccessPassInfo(this.buildId,this.buildName,this.cardType,this.cardTypeName,this.createTime,this.creatorId,this.custHouseRelationId,this.custIdNum,this.custName,this.custPhone,this.custProper,this.custProperName,this.custType,this.custTypeName,this.houseId,this.houseNo,this.id,this.idTypeId,this.idTypeIdName,this.mobile,this.projectId,this.projectName,this.qrCodeTime,this.status,this.unitId,this.unitName,);

  factory AccessPassInfo.fromJson(Map<String, dynamic> srcJson) => _$AccessPassInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AccessPassInfoToJson(this);

}


