import 'package:json_annotation/json_annotation.dart';
import 'package:cmp_customer/models/response/base_response.dart';

import '../user_data_model.dart';

part 'check_in_details_response.g.dart';

@JsonSerializable()
class CheckInDetailsResponse extends BaseResponse {
  @JsonKey(name: 'data')
  CheckInDetails details;

  CheckInDetailsResponse({this.details});

  factory CheckInDetailsResponse.fromJson(Map<String, dynamic> srcJson) =>
      _$CheckInDetailsResponseFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CheckInDetailsResponseToJson(this);
}

@JsonSerializable()
class CheckInDetails extends Object {
  @JsonKey(name: 'agreedReprocessTime')
  String agreedReprocessTime;

  @JsonKey(name: 'assigneeName')
  String assigneeName;

  @JsonKey(name: 'attJfpjList')
  List<Attachment> attJfpjList;

  @JsonKey(name: 'attRzqrList')
  List<Attachment> attRzqrList;

  @JsonKey(name: 'attRzqrhList')
  List<Attachment> attRzqrhList;

  @JsonKey(name: 'attZhrzList')
  List<Attachment> attZhrzList;

  @JsonKey(name: 'auditRemark')
  String auditRemark;

  @JsonKey(name: 'bookReprocessTime')
  String bookReprocessTime;

  @JsonKey(name: 'businessNo')
  String businessNo;

  @JsonKey(name: 'companyCreditCode')
  String companyCreditCode;

  @JsonKey(name: 'companyProp')
  String companyProp;

  @JsonKey(name: 'contactName')
  String contactName;

  @JsonKey(name: 'contactPhone')
  String contactPhone;

  @JsonKey(name: 'createTime')
  String createTime;

  @JsonKey(name: 'customerId')
  int customerId;

  @JsonKey(name: 'customerName')
  String customerName;

  @JsonKey(name: 'customerPhone')
  String customerPhone;

  @JsonKey(name: 'depositAccount')
  String depositAccount;

  @JsonKey(name: 'depositBank')
  String depositBank;

  @JsonKey(name: 'emerContactName')
  String emerContactName;

  @JsonKey(name: 'emerContactPhone')
  String emerContactPhone;

  @JsonKey(name: 'enterConfirmRemark')
  String enterConfirmRemark;

  @JsonKey(name: 'enterDate')
  String enterDate;

  @JsonKey(name: 'enterType')
  String enterType;

  @JsonKey(name: 'gender')
  String gender;

  @JsonKey(name: 'houseId')
  int houseId;

  @JsonKey(name: 'houseNo')
  String houseNo;

  @JsonKey(name: 'houseUsage')
  String houseUsage;

  @JsonKey(name: 'idNum')
  String idNum;

  @JsonKey(name: 'idType')
  String idType;

  @JsonKey(name: 'legalPersonName')
  String legalPersonName;

  @JsonKey(name: 'operateStep')
  String operateStep;

  @JsonKey(name: 'operateStepNext')
  String operateStepNext;

  @JsonKey(name: 'payConfirmRemark')
  String payConfirmRemark;

  @JsonKey(name: 'payFees')
  double payFees;

  @JsonKey(name: 'postId')
  int postId;

  @JsonKey(name: 'processId')
  String processId;

  @JsonKey(name: 'projectId')
  int projectId;

  @JsonKey(name: 'projectName')
  String projectName;

  @JsonKey(name: 'formerName')
  String formerName;

  @JsonKey(name: 'recordList')
  List<RecordList> recordList;

  @JsonKey(name: 'relationship')
  String relationship;

  @JsonKey(name: 'rentArea')
  String rentArea;

  @JsonKey(name: 'rentLocation')
  String rentLocation;

  @JsonKey(name: 'rentAddress')
  String rentAddress;

  @JsonKey(name: 'rentType')
  String rentType;

  @JsonKey(name: 'rentersName')
  String rentersName;

  @JsonKey(name: 'rentingEnterId')
  int rentingEnterId;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'taxCategory')
  String taxCategory;

  @JsonKey(name: 'taxRate')
  String taxRate;

  @JsonKey(name: 'updateTime')
  String updateTime;

  @JsonKey(name: 'userId')
  int userId;

  CheckInDetails({
    this.agreedReprocessTime,
    this.assigneeName,
    this.attJfpjList,
    this.attRzqrList,
    this.attRzqrhList,
    this.attZhrzList,
    this.auditRemark,
    this.bookReprocessTime,
    this.businessNo,
    this.companyCreditCode,
    this.companyProp,
    this.contactName,
    this.contactPhone,
    this.createTime,
    this.customerId,
    this.customerName,
    this.customerPhone,
    this.depositAccount,
    this.depositBank,
    this.emerContactName,
    this.emerContactPhone,
    this.enterConfirmRemark,
    this.enterDate,
    this.enterType,
    this.gender,
    this.houseId,
    this.houseNo,
    this.houseUsage,
    this.idNum,
    this.idType,
    this.legalPersonName,
    this.operateStep,
    this.operateStepNext,
    this.payConfirmRemark,
    this.payFees,
    this.postId,
    this.processId,
    this.projectId,
    this.projectName,
    this.formerName,
    this.recordList,
    this.relationship,
    this.rentArea,
    this.rentLocation,
    this.rentAddress,
    this.rentType,
    this.rentersName,
    this.rentingEnterId,
    this.status,
    this.taxCategory,
    this.taxRate,
    this.updateTime,
    this.userId,
  });

  factory CheckInDetails.fromJson(Map<String, dynamic> srcJson) => _$CheckInDetailsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CheckInDetailsToJson(this);
}

@JsonSerializable()
class RecordList extends Object {
  @JsonKey(name: 'attJfpjList')
  List<Attachment> attJfpjList;

  @JsonKey(name: 'attRzqrList')
  List<Attachment> attRzqrList;

  @JsonKey(name: 'attRzqrhList')
  List<Attachment> attRzqrhList;

  @JsonKey(name: 'attZhrzList')
  List<Attachment> attZhrzList;

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

  @JsonKey(name: 'operateStepDesc')
  String operateStepDesc;

  @JsonKey(name: 'postId')
  int postId;

  @JsonKey(name: 'recordId')
  int recordId;

  @JsonKey(name: 'remark')
  String remark;

  @JsonKey(name: 'rentingEnterId')
  int rentingEnterId;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'statusDesc')
  String statusDesc;

  @JsonKey(name: 'userId')
  int userId;

  RecordList(
    this.attJfpjList,
    this.attRzqrList,
    this.attRzqrhList,
    this.attZhrzList,
    this.attachmentFlag,
    this.createTime,
    this.creator,
    this.creatorId,
    this.creatorType,
    this.operateStep,
    this.postId,
    this.recordId,
    this.remark,
    this.rentingEnterId,
    this.status,
    this.userId,
  );

  factory RecordList.fromJson(Map<String, dynamic> srcJson) => _$RecordListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RecordListToJson(this);
}
