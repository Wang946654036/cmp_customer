import 'package:cmp_customer/models/office_cancel_lease_detail_model.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'office_cancel_lease_record_model.g.dart';


@JsonSerializable()
class OfficeCancelLeaseRecordModel extends Object {

  @JsonKey(name: 'appCodes')
  List<String> appCodes;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'data')
  List<OfficeCancelLeaseInfo> officeCancelLeaseList;

  @JsonKey(name: 'extStr')
  String extStr;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'totalCount')
  int totalCount;

  OfficeCancelLeaseRecordModel(this.appCodes,this.code,this.officeCancelLeaseList,this.extStr,this.message,this.systemDate,this.totalCount,);

  factory OfficeCancelLeaseRecordModel.fromJson(Map<String, dynamic> srcJson) => _$OfficeCancelLeaseRecordModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$OfficeCancelLeaseRecordModelToJson(this);

}


@JsonSerializable()
class OfficeCancelLeaseInfo extends Object {

  @JsonKey(name: 'attApplyList')
  List<String> attApplyList;

  @JsonKey(name: 'attRectifyList')
  List<String> attRectifyList;

  @JsonKey(name: 'attSubmitList')
  List<Attachment> attSubmitList;

  @JsonKey(name: 'buildIds')
  String buildIds;

  @JsonKey(name: 'buildNames')
  String buildNames;

  @JsonKey(name: 'businessNo')
  String businessNo;

  @JsonKey(name: 'checkTime')
  String checkTime;

  @JsonKey(name: 'createTime')
  String createTime;

  @JsonKey(name: 'custIds')
  String custIds;

  @JsonKey(name: 'custNames')
  String custNames;

  @JsonKey(name: 'customerId')
  int customerId;

  @JsonKey(name: 'customerName')
  String customerName;

  @JsonKey(name: 'customerTel')
  String customerTel;

  @JsonKey(name: 'customerType')
  String customerType;

  @JsonKey(name: 'houseIds')
  String houseIds;

  @JsonKey(name: 'houseNos')
  String houseNos;

  @JsonKey(name: 'officeSurrenderId')
  int officeSurrenderId;

  @JsonKey(name: 'operateStep')
  String operateStep;

  @JsonKey(name: 'participatePerson')
  String participatePerson;

  @JsonKey(name: 'payMoney')
  String payMoney;

  @JsonKey(name: 'projectId')
  int projectId;

  @JsonKey(name: 'projectName')
  String projectName;

  @JsonKey(name: 'recordList')
  List<RecordInfo> recordList;

  @JsonKey(name: 'remark')
  String remark;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'statusTypeName')
  String statusTypeName;

  @JsonKey(name: 'submitDate')
  String submitDate;

  @JsonKey(name: 'submitHouse')
  String submitHouse;

  @JsonKey(name: 'submitRemark')
  String submitRemark;

  @JsonKey(name: 'submitResult')
  String submitResult;

  @JsonKey(name: 'submitResultName')
  String submitResultName;

  @JsonKey(name: 'surrenderTime')
  String surrenderTime;

  @JsonKey(name: 'unitIds')
  String unitIds;

  @JsonKey(name: 'unitNames')
  String unitNames;

  @JsonKey(name: 'updateTime')
  String updateTime;

  @JsonKey(name: 'updator')
  String updator;

  @JsonKey(name: 'updatorId')
  int updatorId;

  OfficeCancelLeaseInfo(this.attApplyList,this.attRectifyList,this.attSubmitList,this.buildIds,this.buildNames,this.businessNo,this.checkTime,this.createTime,this.custIds,this.custNames,this.customerId,this.customerName,this.customerTel,this.customerType,this.houseIds,this.houseNos,this.officeSurrenderId,this.operateStep,this.participatePerson,this.payMoney,this.projectId,this.projectName,this.recordList,this.remark,this.status,this.statusTypeName,this.submitDate,this.submitHouse,this.submitRemark,this.submitResult,this.submitResultName,this.surrenderTime,this.unitIds,this.unitNames,this.updateTime,this.updator,this.updatorId,);

  factory OfficeCancelLeaseInfo.fromJson(Map<String, dynamic> srcJson) => _$OfficeCancelLeaseInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$OfficeCancelLeaseInfoToJson(this);

}