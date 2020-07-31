import 'package:cmp_customer/models/user_data_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'office_cancel_lease_detail_model.g.dart';

@JsonSerializable()
class OfficeCancelLeaseDetailModel extends Object {
  @JsonKey(name: 'appCodes')
  List<String> appCodes;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'data')
  OfficeCancelLeaseDetail officeCancelLeaseDetail;

  @JsonKey(name: 'extStr')
  String extStr;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'totalCount')
  int totalCount;

  OfficeCancelLeaseDetailModel(
    this.appCodes,
    this.code,
    this.officeCancelLeaseDetail,
    this.extStr,
    this.message,
    this.systemDate,
    this.totalCount,
  );

  factory OfficeCancelLeaseDetailModel.fromJson(Map<String, dynamic> srcJson) =>
      _$OfficeCancelLeaseDetailModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$OfficeCancelLeaseDetailModelToJson(this);
}

@JsonSerializable()
class OfficeCancelLeaseDetail extends Object {
  @JsonKey(name: 'attApplyList')
  List<String> attApplyList;

  @JsonKey(name: 'attRectifyList')
  List<String> attRectifyList;

  @JsonKey(name: 'attSubmitList')
  List<Attachment> attSubmitList;

  List<HouseInfo> houseList; //用于申请表单页面显示房号列表用

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

  OfficeCancelLeaseDetail({
    this.attApplyList,
    this.attRectifyList,
    this.attSubmitList,
    this.buildIds,
    this.buildNames,
    this.businessNo,
    this.checkTime,
    this.createTime,
    this.custIds,
    this.custNames,
    this.customerId,
    this.customerName,
    this.customerTel,
    this.customerType,
    this.houseIds,
    this.houseNos,
    this.officeSurrenderId,
    this.operateStep,
    this.participatePerson,
    this.payMoney,
    this.projectId,
    this.projectName,
    this.recordList,
    this.remark,
    this.status,
    this.statusTypeName,
    this.submitDate,
    this.submitHouse,
    this.submitRemark,
    this.submitResult,
    this.submitResultName,
    this.surrenderTime,
    this.unitIds,
    this.unitNames,
    this.updateTime,
    this.updator,
    this.updatorId,
  });

  factory OfficeCancelLeaseDetail.fromJson(Map<String, dynamic> srcJson) =>
      _$OfficeCancelLeaseDetailFromJson(srcJson);

  Map<String, dynamic> toJson() => _$OfficeCancelLeaseDetailToJson(this);

  factory OfficeCancelLeaseDetail.clone(OfficeCancelLeaseDetail srcData) {
    OfficeCancelLeaseDetail outData = OfficeCancelLeaseDetail();
    outData.attApplyList = List();
    srcData.attApplyList?.forEach((String uuid) {
      outData.attApplyList.add(uuid);
    });
    outData.attRectifyList = List();
    srcData.attRectifyList?.forEach((String uuid) {
      outData.attRectifyList.add(uuid);
    });
    outData.attSubmitList = List();
    srcData.attSubmitList?.forEach((Attachment attach) {
      outData.attSubmitList.add(attach);
    });
    outData.buildIds = srcData.buildIds;
    outData.buildNames = srcData.buildNames;
    outData.businessNo = srcData.businessNo;
    outData.checkTime = srcData.checkTime;
    outData.createTime = srcData.createTime;
    outData.custIds = srcData.custIds;
    outData.customerId = srcData.customerId;
    outData.customerName = srcData.customerName;
    outData.customerTel = srcData.customerTel;
    outData.customerType = srcData.customerType;
    outData.houseIds = srcData.houseIds;
    outData.houseNos = srcData.houseNos;
    outData.officeSurrenderId = srcData.officeSurrenderId;
    outData.operateStep = srcData.operateStep;
    outData.participatePerson = srcData.participatePerson;
    outData.payMoney = srcData.payMoney;
    outData.projectId = srcData.projectId;
    outData.projectName = srcData.projectName;
    outData.recordList = srcData.recordList;
    outData.remark = srcData.remark;
    outData.status = srcData.status;
    outData.statusTypeName = srcData.statusTypeName;
    outData.submitDate = srcData.submitDate;
    outData.submitHouse = srcData.submitHouse;
    outData.submitRemark = srcData.submitRemark;
    outData.submitResult = srcData.submitResult;
    outData.submitResultName = srcData.submitResultName;
    outData.surrenderTime = srcData.surrenderTime;
    outData.unitIds = srcData.unitIds;
    outData.unitNames = srcData.unitNames;
    outData.updateTime = srcData.updateTime;
    outData.updator = srcData.updator;
    outData.updatorId = srcData.updatorId;
    return outData;
  }
}

@JsonSerializable()
class RecordInfo extends Object {
  @JsonKey(name: 'attApplyList')
  List<String> attApplyList;

  @JsonKey(name: 'attRectifyList')
  List<String> attRectifyList;

  @JsonKey(name: 'attSubmitList')
  List<Attachment> attSubmitList;

  @JsonKey(name: 'attachmentFlag')
  String attachmentFlag;

  @JsonKey(name: 'auditResult')
  String auditResult;

  @JsonKey(name: 'auditResultName')
  String auditResultName;

  @JsonKey(name: 'checkTime')
  String checkTime;

  @JsonKey(name: 'createTime')
  String createTime;

  @JsonKey(name: 'creator')
  String creator;

  @JsonKey(name: 'creatorId')
  int creatorId;

  @JsonKey(name: 'creatorType')
  String creatorType;

  @JsonKey(name: 'officeSurrenderId')
  int officeSurrenderId;

  @JsonKey(name: 'operateStep')
  String operateStep;

  @JsonKey(name: 'participatePerson')
  String participatePerson;

  @JsonKey(name: 'postId')
  int postId;

  @JsonKey(name: 'recordId')
  int recordId;

  @JsonKey(name: 'remark')
  String remark;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'statusTypeName')
  String statusTypeName;

  @JsonKey(name: 'submitDate')
  String submitDate;

  @JsonKey(name: 'submitRemark')
  String submitRemark;

  @JsonKey(name: 'submitResult')
  String submitResult;

  @JsonKey(name: 'submitResultName')
  String submitResultName;

  @JsonKey(name: 'userId')
  int userId;

  RecordInfo(
    this.attApplyList,
    this.attRectifyList,
    this.attSubmitList,
    this.attachmentFlag,
    this.auditResult,
    this.auditResultName,
    this.checkTime,
    this.createTime,
    this.creator,
    this.creatorId,
    this.creatorType,
    this.officeSurrenderId,
    this.operateStep,
    this.participatePerson,
    this.postId,
    this.recordId,
    this.remark,
    this.status,
    this.statusTypeName,
    this.submitDate,
    this.submitRemark,
    this.submitResult,
    this.submitResultName,
    this.userId,
  );

  factory RecordInfo.fromJson(Map<String, dynamic> srcJson) => _$RecordInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RecordInfoToJson(this);
}
