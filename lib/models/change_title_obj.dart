import 'package:cmp_customer/models/user_data_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'change_title_obj.g.dart';

@JsonSerializable()
class ChangeTitleObj extends Object {
  @JsonKey(name: 'appCodes')
  List<String> appCodes;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'data')
  ChangeTitleInfo changeTitleInfo;

  @JsonKey(name: 'extStr')
  String extStr;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'totalCount')
  int totalCount;

  ChangeTitleObj(
    this.appCodes,
    this.code,
    this.changeTitleInfo,
    this.extStr,
    this.message,
    this.systemDate,
    this.totalCount,
  );

  factory ChangeTitleObj.fromJson(Map<String, dynamic> srcJson) => _$ChangeTitleObjFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ChangeTitleObjToJson(this);
}

@JsonSerializable()
class ChangeTitleInfo extends Object {
  @JsonKey(name: 'assigneeId')
  int assigneeId;

  @JsonKey(name: 'assigneeIdNum')
  String assigneeIdNum;

  @JsonKey(name: 'assigneeIdNumMatchId')
  int assigneeIdNumMatchId;

  @JsonKey(name: 'assigneeIdTypeId')
  String assigneeIdTypeId;

  @JsonKey(name: 'assigneeMobileMatchId')
  int assigneeMobileMatchId;

  @JsonKey(name: 'assigneePhone')
  String assigneePhone;

  @JsonKey(name: 'assigneeRealname')
  String assigneeRealname;

  @JsonKey(name: 'attApplyPhotoList')
  List<String> attApplyPhotoList;

  @JsonKey(name: 'attFileList')
  List<Attachment> attFileList;

  @JsonKey(name: 'attApplyList')
  List<Attachment> attApplyList;
  @JsonKey(name: 'attPhotoList')
  List<String> attPhotoList;

  @JsonKey(name: 'buildId')
  int buildId;

  @JsonKey(name: 'buildName')
  String buildName;

  @JsonKey(name: 'businessNo')
  String businessNo;

  @JsonKey(name: 'createTime')
  String createTime;

  @JsonKey(name: 'custSimpleVoAppByIdNum')
  CustSimpleVoAppByIdNum custSimpleVoAppByIdNum;

  @JsonKey(name: 'custSimpleVoAppByMobile')
  CustSimpleVoAppByMobile custSimpleVoAppByMobile;

  @JsonKey(name: 'customerId')
  int customerId;

  @JsonKey(name: 'customerIdNum')
  String customerIdNum;

  @JsonKey(name: 'customerIdTypeId')
  String customerIdTypeId;

  @JsonKey(name: 'customerName')
  String customerName;

  @JsonKey(name: 'customerPhone')
  String customerPhone;

  @JsonKey(name: 'handoverTime')
  String handoverTime;

  @JsonKey(name: 'houseId')
  int houseId;

  @JsonKey(name: 'houseNo')
  String houseNo;

  @JsonKey(name: 'operateStep')
  String operateStep;

  @JsonKey(name: 'projectId')
  int projectId;

  @JsonKey(name: 'projectName')
  String projectName;

  @JsonKey(name: 'formerName')
  String formerName;

  @JsonKey(name: 'propertyChangeId')
  int propertyChangeId;

  @JsonKey(name: 'recordList')
  List<RecordList> recordList;

  @JsonKey(name: 'remark')
  String remark;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'unitId')
  int unitId;

  @JsonKey(name: 'unitName')
  String unitName;

  @JsonKey(name: 'updateTime')
  String updateTime;
  @JsonKey(name: 'promptInfo')
  String promptInfo;

  ChangeTitleInfo(
      {this.attApplyList,
      this.assigneeId,
      this.assigneeIdNum,
      this.assigneeIdNumMatchId,
      this.assigneeIdTypeId,
      this.assigneeMobileMatchId,
      this.assigneePhone,
      this.assigneeRealname,
      this.attApplyPhotoList,
      this.attFileList,
      this.attPhotoList,
      this.buildId,
      this.buildName,
      this.businessNo,
      this.createTime,
      this.custSimpleVoAppByIdNum,
      this.custSimpleVoAppByMobile,
      this.customerId,
      this.customerIdNum,
      this.customerIdTypeId,
      this.customerName,
      this.customerPhone,
      this.handoverTime,
      this.houseId,
      this.houseNo,
      this.operateStep,
      this.projectId,
      this.projectName,
      this.formerName,
      this.propertyChangeId,
      this.recordList,
      this.remark,
      this.status,
      this.unitId,
      this.unitName,
      this.updateTime,
      this.promptInfo});

  factory ChangeTitleInfo.fromJson(Map<String, dynamic> srcJson) => _$ChangeTitleInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ChangeTitleInfoToJson(this);
}

@JsonSerializable()
class CustSimpleVoAppByIdNum extends Object {
  @JsonKey(name: 'custId')
  int custId;

  @JsonKey(name: 'custIdNum')
  String custIdNum;

  @JsonKey(name: 'custName')
  String custName;

  @JsonKey(name: 'custPhone')
  String custPhone;

  @JsonKey(name: 'idTypeId')
  String idTypeId;

  CustSimpleVoAppByIdNum({
    this.custId,
    this.custIdNum,
    this.custName,
    this.custPhone,
    this.idTypeId,
  });

  factory CustSimpleVoAppByIdNum.fromJson(Map<String, dynamic> srcJson) =>
      _$CustSimpleVoAppByIdNumFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CustSimpleVoAppByIdNumToJson(this);
}

@JsonSerializable()
class CustSimpleVoAppByMobile extends Object {
  @JsonKey(name: 'custId')
  int custId;

  @JsonKey(name: 'custIdNum')
  String custIdNum;

  @JsonKey(name: 'custName')
  String custName;

  @JsonKey(name: 'custPhone')
  String custPhone;

  @JsonKey(name: 'idTypeId')
  String idTypeId;

  CustSimpleVoAppByMobile({
    this.custId,
    this.custIdNum,
    this.custName,
    this.custPhone,
    this.idTypeId,
  });

  factory CustSimpleVoAppByMobile.fromJson(Map<String, dynamic> srcJson) =>
      _$CustSimpleVoAppByMobileFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CustSimpleVoAppByMobileToJson(this);
}

@JsonSerializable()
class RecordList extends Object {
  @JsonKey(name: 'attFileList')
  List<Attachment> attFileList;

  @JsonKey(name: 'attPhotoList')
  List<String> attPhotoList;

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

  @JsonKey(name: 'operateStep')
  String operateStep;

  @JsonKey(name: 'operateStepName')
  String operateStepName;

  @JsonKey(name: 'postId')
  int postId;

  @JsonKey(name: 'propertyChangeId')
  int propertyChangeId;

  @JsonKey(name: 'recordId')
  int recordId;

  @JsonKey(name: 'remark')
  String remark;

  @JsonKey(name: 'status')
  String status;
  @JsonKey(name: 'statusName')
  String statusName;
  @JsonKey(name: 'userId')
  int userId;
  @JsonKey(name: 'payFees')
  double payFees;

  RecordList(
      {this.payFees,
      this.attFileList,
      this.attPhotoList,
      this.attachmentFlag,
      this.createTime,
      this.creator,
      this.creatorId,
      this.creatorType,
      this.operateStep,
      this.operateStepName,
      this.postId,
      this.propertyChangeId,
      this.recordId,
      this.remark,
      this.status,
      this.userId,
      this.statusName});

  factory RecordList.fromJson(Map<String, dynamic> srcJson) => _$RecordListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RecordListToJson(this);
}
