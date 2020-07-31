import 'package:json_annotation/json_annotation.dart';

part 'work_order_vo.g.dart';

@JsonSerializable()
class WorkOrderVo extends Object {
  @JsonKey(name: 'appointmentTime')
  String appointmentTime;

  @JsonKey(name: 'complaintMainCategory')
  String complaintMainCategory;

  @JsonKey(name: 'complaintProperty')
  String complaintProperty;

  @JsonKey(name: 'complaintSubCategory')
  String complaintSubCategory;

  @JsonKey(name: 'customerAddress')
  String customerAddress;

  @JsonKey(name: 'customerId')
  int customerId;

  @JsonKey(name: 'customerName')
  String customerName;

  @JsonKey(name: 'customerPhone')
  String customerPhone;

  @JsonKey(name: 'customerType')
  String customerType;

  @JsonKey(name: 'draftFlag')
  String draftFlag;

  @JsonKey(name: 'houseId')
  int houseId;
  @JsonKey(name: 'unitId')
  int unitId;
  @JsonKey(name: 'buildId')
  int buildId;

  @JsonKey(name: 'paidServiceId')
  int paidServiceId;

  @JsonKey(name: 'paidStyleList')
  List<String> paidStyleList;

  @JsonKey(name: 'projectId')
  int projectId;

  @JsonKey(name: 'reportContent')
  String reportContent;

  @JsonKey(name: 'reportRemarks')
  String reportRemarks;

  @JsonKey(name: 'reportSource')
  String reportSource;
  @JsonKey(name: 'createSource')
  String createSource;

  @JsonKey(name: 'serviceSubType')
  String serviceSubType;

  @JsonKey(name: 'serviceType')
  String serviceType;

  @JsonKey(name: 'urgentLevel')
  String urgentLevel;

  @JsonKey(name: 'validFlag')
  String validFlag;

  @JsonKey(name: 'workOrderId')
  int workOrderId;

  @JsonKey(name: 'workOrderPhotoList')
  List<String> workOrderPhotoList;

  @JsonKey(name: 'workOrderVoiceList')
  List<String> workOrderVoiceList;
  @JsonKey(name: 'orderCategory')
  String orderCategory;
  WorkOrderVo({
    this.houseId,
    this.buildId,
    this.unitId,
    this.appointmentTime,
    this.complaintMainCategory,
    this.complaintProperty,
    this.complaintSubCategory,
    this.customerAddress,
    this.customerId,
    this.customerName,
    this.customerPhone,
    this.customerType,
    this.draftFlag,
    this.paidServiceId,
    this.paidStyleList,
    this.projectId,
    this.reportContent,
    this.reportRemarks,
    this.reportSource,
    this.createSource,
    this.serviceSubType,
    this.serviceType,
    this.urgentLevel,
    this.validFlag,
    this.workOrderId,
    this.workOrderPhotoList,
    this.workOrderVoiceList,
    this.orderCategory
  });

  factory WorkOrderVo.fromJson(Map<String, dynamic> srcJson) =>
      _$WorkOrderVoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$WorkOrderVoToJson(this);
}
