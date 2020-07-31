import 'package:json_annotation/json_annotation.dart';

import 'user_data_model.dart';

part 'new_house_model.g.dart';

@JsonSerializable()
class NewHouseModel extends Object {
  @JsonKey(name: 'appCodes')
  List<String> appCodes;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'data')
  NewHouseDetail newHouseDetail;

  @JsonKey(name: 'extStr')
  String extStr;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'totalCount')
  int totalCount;

  NewHouseModel(
    this.appCodes,
    this.code,
    this.newHouseDetail,
    this.extStr,
    this.message,
    this.systemDate,
    this.totalCount,
  );

  factory NewHouseModel.fromJson(Map<String, dynamic> srcJson) => _$NewHouseModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$NewHouseModelToJson(this);
}

@JsonSerializable()
class NewHouseDetail extends Object {
  @JsonKey(name: 'projectId')
  int projectId;

  @JsonKey(name: 'projectName')
  String projectName;
  @JsonKey(name: 'projectFormerName')
  String projectFormerName;

  @JsonKey(name: 'houseName')
  String houseName;

  @JsonKey(name: 'buildName')
  String buildName;

  @JsonKey(name: 'unitName')
  String unitName;

  @JsonKey(name: 'houseNo')
  String houseNo;

  @JsonKey(name: 'accountName')
  String accountName;

  @JsonKey(name: 'auditTime')
  String auditTime;

  @JsonKey(name: 'auditor')
  String auditor;

  @JsonKey(name: 'auditorId')
  int auditorId;

  @JsonKey(name: 'bank')
  String bank;

  @JsonKey(name: 'bankAccount')
  String bankAccount;

  @JsonKey(name: 'bankCollectAttachmentList')
  List<Attachment> bankCollectAttachmentList;
  @JsonKey(name: 'checkCollectAttachmentList')
  List<Attachment> checkCollectAttachmentList;

  @JsonKey(name: 'businessNo')
  String businessNo;

  @JsonKey(name: 'confirmPhotoList')
  List<Attachment> confirmPhotoList;

  @JsonKey(name: 'createTime')
  String createTime;

  @JsonKey(name: 'creatorId')
  int creatorId;

  @JsonKey(name: 'custBirth')
  String custBirth;

  @JsonKey(name: 'custIdNum')
  String custIdNum;

  @JsonKey(name: 'custName')
  String custName;

  @JsonKey(name: 'custNation')
  String custNation;

  @JsonKey(name: 'custNative')
  String custNative;

  @JsonKey(name: 'custPhone')
  String custPhone;

  @JsonKey(name: 'custProper')
  String custProper;

  @JsonKey(name: 'custType')
  String custType;

  @JsonKey(name: 'decideDate')
  String decideDate;

  @JsonKey(name: 'email')
  String email;

  //性别:1-男，2-女
  @JsonKey(name: 'gender')
  String gender;

  @JsonKey(name: 'houseId')
  int houseId;

  @JsonKey(name: 'houseJoinCarList')
  List<NewHouseCarInfo> newHouseCarInfoList;

  @JsonKey(name: 'houseJoinId')
  int houseJoinId;

  @JsonKey(name: 'houseJoinPetList')
  List<NewHousePetInfo> newHousePetInfoList;

  @JsonKey(name: 'idTypeId')
  String idTypeId;

  @JsonKey(name: 'joinDate')
  String joinDate;

  @JsonKey(name: 'payType')
  String payType;

  @JsonKey(name: 'personalityDesc')
  String personalityDesc;

  @JsonKey(name: 'propertyParkList')
  List<PropertyParkInfo> propertyParkList;

  @JsonKey(name: 'regAddr')
  String regAddr;
  @JsonKey(name: 'country')
  String country;
  @JsonKey(name: 'relatedAttachmentList')
  List<Attachment> relatedAttachmentList;

  @JsonKey(name: 'remark')
  String remark;

  @JsonKey(name: 'scheduleDate')
  String scheduleDate;

  @JsonKey(name: 'processStatus')
  String processStatus;

  @JsonKey(name: 'processStatusName')
  String processStatusName;

  @JsonKey(name: 'updateTime')
  String updateTime;

  @JsonKey(name: 'updator')
  String updator;

  @JsonKey(name: 'updatorId')
  int updatorId;

  @JsonKey(name: 'updatorType')
  String updatorType;

  @JsonKey(name: 'workUnit')
  String workUnit;
  @JsonKey(name: 'workAddr')
  String workAddr;

  @JsonKey(name: 'recordList')
  List<RecordInfo> recordList;

  NewHouseDetail({
    this.projectId,
    this.projectName,
    this.projectFormerName,
    this.houseName,
    this.buildName,
    this.unitName,
    this.houseNo,
    this.accountName,
    this.auditTime,
    this.auditor,
    this.auditorId,
    this.bank,
    this.bankAccount,
    this.bankCollectAttachmentList,
    this.checkCollectAttachmentList,
    this.businessNo,
    this.confirmPhotoList,
    this.createTime,
    this.creatorId,
    this.custBirth,
    this.custIdNum,
    this.custName,
    this.custNative,
    this.custPhone,
    this.custProper,
    this.custType,
    this.decideDate,
    this.email,
    this.gender,
    this.houseId,
    this.newHouseCarInfoList,
    this.houseJoinId,
    this.newHousePetInfoList,
    this.idTypeId,
    this.joinDate,
    this.payType,
    this.personalityDesc,
    this.propertyParkList,
    this.regAddr,
    this.country,
    this.relatedAttachmentList,
    this.remark,
    this.scheduleDate,
    this.processStatus,
    this.processStatusName,
    this.updateTime,
    this.updator,
    this.updatorId,
    this.updatorType,
    this.workUnit,
    this.workAddr,
    this.recordList,
  });

  factory NewHouseDetail.fromJson(Map<String, dynamic> srcJson) => _$NewHouseDetailFromJson(srcJson);

  Map<String, dynamic> toJson() => _$NewHouseDetailToJson(this);
}

@JsonSerializable()
class NewHouseCarInfo extends Object {
  @JsonKey(name: 'carAttachmentList')
  List<Attachment> carAttachmentList;

  @JsonKey(name: 'carBrand')
  String carBrand;

  @JsonKey(name: 'carColor')
  String carColor;

  @JsonKey(name: 'carId')
  int carId;

  @JsonKey(name: 'carSize')
  String carSize;

  @JsonKey(name: 'houseJoinId')
  int houseJoinId;

  @JsonKey(name: 'plateNumber')
  String plateNumber;

  @JsonKey(name: 'remark')
  String remark;

  NewHouseCarInfo({
    this.carAttachmentList,
    this.carBrand,
    this.carColor,
    this.carId,
    this.carSize,
    this.houseJoinId,
    this.plateNumber,
    this.remark,
  });

  factory NewHouseCarInfo.fromJson(Map<String, dynamic> srcJson) => _$NewHouseCarInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$NewHouseCarInfoToJson(this);
}

@JsonSerializable()
class NewHousePetInfo extends Object {
  @JsonKey(name: 'houseJoinId')
  int houseJoinId;

  //是否办理证件:0-否，1-是
  @JsonKey(name: 'isPetCertificated')
  String isPetCertificated;

  @JsonKey(name: 'petAttachmentList')
  List<Attachment> petAttachmentList;

  @JsonKey(name: 'petColor')
  String petColor;

  @JsonKey(name: 'petId')
  int petId;

  @JsonKey(name: 'petNickName')
  String petNickName;

  @JsonKey(name: 'petVariety')
  String petVariety;

  @JsonKey(name: 'remark')
  String remark;

  NewHousePetInfo({
    this.houseJoinId,
    this.isPetCertificated,
    this.petAttachmentList,
    this.petColor,
    this.petId,
    this.petNickName,
    this.petVariety,
    this.remark,
  });

  factory NewHousePetInfo.fromJson(Map<String, dynamic> srcJson) => _$NewHousePetInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$NewHousePetInfoToJson(this);
}

@JsonSerializable()
class PropertyParkInfo extends Object {
  @JsonKey(name: 'houseJoinId')
  int houseJoinId;

  @JsonKey(name: 'number')
  String number;

  @JsonKey(name: 'projectId')
  int projectId;

  @JsonKey(name: 'propertyParkId')
  int propertyParkId;

  PropertyParkInfo({
    this.houseJoinId,
    this.number,
    this.projectId,
    this.propertyParkId,
  });

  factory PropertyParkInfo.fromJson(Map<String, dynamic> srcJson) => _$PropertyParkInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PropertyParkInfoToJson(this);
}

@JsonSerializable()
class RecordInfo extends Object {
  @JsonKey(name: 'attachmentFlag')
  String attachmentFlag;

  @JsonKey(name: 'createTime')
  String createTime;

  @JsonKey(name: 'creator')
  String creator;

  @JsonKey(name: 'creatorId')
  int creatorId;

  @JsonKey(name: 'creatorType')
  String creatorType;

  @JsonKey(name: 'houseJoinId')
  int houseJoinId;

  @JsonKey(name: 'operateStep')
  String operateStep;

  //"审核结果，1-通过，0 不通过"
  @JsonKey(name: 'operationStatus')
  String operationStatus;

  @JsonKey(name: 'operateStepName')
  String operateStepName;

  @JsonKey(name: 'postId')
  int postId;

  @JsonKey(name: 'processStatus')
  String processStatus;

  @JsonKey(name: 'processStatusName')
  String processStatusName;

  @JsonKey(name: 'recordAttachmentList')
  List<Attachment> recordAttachmentList;

  @JsonKey(name: 'recordId')
  int recordId;

  @JsonKey(name: 'remark')
  String remark;

  @JsonKey(name: 'userId')
  int userId;

  RecordInfo(
    this.attachmentFlag,
    this.createTime,
    this.creator,
    this.creatorId,
    this.creatorType,
    this.houseJoinId,
    this.operateStep,
    this.operateStepName,
    this.postId,
    this.processStatus,
    this.processStatusName,
    this.recordAttachmentList,
    this.recordId,
    this.remark,
    this.userId,
    this.operationStatus,
  );

  factory RecordInfo.fromJson(Map<String, dynamic> srcJson) => _$RecordInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RecordInfoToJson(this);
}
