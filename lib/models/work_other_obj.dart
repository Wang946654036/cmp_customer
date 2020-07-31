import 'package:json_annotation/json_annotation.dart';

part 'work_other_obj.g.dart';


@JsonSerializable()
class WorkOtherObj extends Object {

  @JsonKey(name: 'appCodes')
  List<String> appCodes;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'data')
  WorkOther data;

  @JsonKey(name: 'extStr')
  String extStr;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'totalCount')
  int totalCount;

  WorkOtherObj(this.appCodes,this.code,this.data,this.extStr,this.message,this.systemDate,this.totalCount,);

  factory WorkOtherObj.fromJson(Map<String, dynamic> srcJson) => _$WorkOtherObjFromJson(srcJson);

  Map<String, dynamic> toJson() => _$WorkOtherObjToJson(this);

}


@JsonSerializable()
class WorkOther extends Object {

  @JsonKey(name: 'appointmentTime')
  String appointmentTime;

  @JsonKey(name: 'complaintMainCategoryName')
  String complaintMainCategory;

  @JsonKey(name: 'complaintPropertyName')
  String complaintProperty;

  @JsonKey(name: 'complaintSubCategory')
  String complaintSubCategory;

  @JsonKey(name: 'complaintSubCategoryNameList')
  List<String> complaintSubCategoryList;

  @JsonKey(name: 'createPostId')
  int createPostId;

  @JsonKey(name: 'createTime')
  String createTime;

  @JsonKey(name: 'createUserId')
  int createUserId;

  @JsonKey(name: 'createUserName')
  String createUserName;

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

  @JsonKey(name: 'hangUpFlag')
  String hangUpFlag;

  @JsonKey(name: 'hasAccept')
  String hasAccept;

  @JsonKey(name: 'hasCancel')
  String hasCancel;

  @JsonKey(name: 'hasClose')
  String hasClose;

  @JsonKey(name: 'hasDone')
  String hasDone;

  @JsonKey(name: 'hasEvaluate')
  String hasEvaluate;

  @JsonKey(name: 'hasFinish')
  String hasFinish;

  @JsonKey(name: 'hasImage')
  String hasImage;

  @JsonKey(name: 'hasPaid')
  String hasPaid;

  @JsonKey(name: 'hasRework')
  String hasRework;

  @JsonKey(name: 'hasVoice')
  String hasVoice;

  @JsonKey(name: 'houseBuildId')
  int houseBuildId;

  @JsonKey(name: 'houseId')
  int houseId;

  @JsonKey(name: 'houseName')
  String houseName;

  @JsonKey(name: 'houseUnitId')
  int houseUnitId;

  @JsonKey(name: 'mainFlag')
  String mainFlag;

  @JsonKey(name: 'overtimeFlag')
  String overtimeFlag;

  @JsonKey(name: 'paidServiceId')
  int paidServiceId;

  @JsonKey(name: 'paidStyleJson')
  String paidStyleJson;

  @JsonKey(name: 'paidStyleList')
  List<String> paidStyleList;

  @JsonKey(name: 'processConfId')
  int processConfId;

  @JsonKey(name: 'processId')
  String processId;

  @JsonKey(name: 'processKey')
  String processKey;

  @JsonKey(name: 'processNodeCode')
  String processNodeCode;

  @JsonKey(name: 'processNodeName')
  String processNodeName;

  @JsonKey(name: 'processState')
  String processState;

  @JsonKey(name: 'processStateName')
  String processStateName;

  @JsonKey(name: 'processTime')
  String processTime;

  @JsonKey(name: 'projectId')
  int projectId;

  @JsonKey(name: 'projectName')
  String projectName;

  @JsonKey(name: 'reportContent')
  String reportContent;

  @JsonKey(name: 'reportRemarks')
  String reportRemarks;

  @JsonKey(name: 'reportSourceName')
  String reportSourceName;

  @JsonKey(name: 'reportSource')
  String reportSource;
  @JsonKey(name: 'serviceGrade')
  int serviceGrade;

  @JsonKey(name: 'serviceSubType')
  String serviceSubType;

  @JsonKey(name: 'serviceSubTypeName')
  String serviceSubTypeName;

  @JsonKey(name: 'serviceType')
  String serviceType;

  @JsonKey(name: 'serviceTypeName')
  String serviceTypeName;

  @JsonKey(name: 'updateTime')
  String updateTime;

  @JsonKey(name: 'updateUserId')
  int updateUserId;

  @JsonKey(name: 'updateUserName')
  String updateUserName;

  @JsonKey(name: 'urgentFlag')
  String urgentFlag;

  @JsonKey(name: 'urgentLevel')
  String urgentLevel;

  @JsonKey(name: 'validFlag')
  String validFlag;

  @JsonKey(name: 'workOrderCode')
  String workOrderCode;

  @JsonKey(name: 'workOrderId')
  int workOrderId;

  @JsonKey(name: 'workOrderPhotoList')
  List<Map<String,String>> workOrderPhotoList;

  @JsonKey(name: 'workOrderVoiceList')
  List<Map<String,String>> workOrderVoiceList;

  @JsonKey(name: 'workTaskId')
  int workTaskId;

  @JsonKey(name: 'materialNameList')
  List<String> materialNameList;

  @JsonKey(name: 'totalMaterialFee')
  double totalMaterialFee;

  @JsonKey(name: 'totalLaborFee')
  double totalLaborFee;


  WorkOther({this.appointmentTime,this.complaintMainCategory,this.complaintProperty,this.complaintSubCategory,this.complaintSubCategoryList,this.createPostId,this.createTime,this.createUserId,this.createUserName,this.customerAddress,this.customerId,this.customerName,this.customerPhone,this.customerType,this.draftFlag,this.hangUpFlag,this.hasAccept,this.hasCancel,this.hasClose,this.hasDone,this.hasEvaluate,this.hasFinish,this.hasImage,this.hasPaid,this.hasRework,this.hasVoice,this.houseBuildId,this.houseId,this.houseName,this.houseUnitId,this.mainFlag,this.overtimeFlag,this.paidServiceId,this.paidStyleJson,this.paidStyleList,this.processConfId,this.processId,this.processKey,this.processNodeCode,this.processNodeName,this.processState,this.processStateName,this.processTime,this.projectId,this.projectName,this.reportContent,this.reportRemarks,this.reportSourceName,this.reportSource,this.serviceGrade,this.serviceSubType,this.serviceSubTypeName,this.serviceType,this.serviceTypeName,this.updateTime,this.updateUserId,this.updateUserName,this.urgentFlag,this.urgentLevel,this.validFlag,this.workOrderCode,this.workOrderId,this.workOrderPhotoList,this.workOrderVoiceList,this.workTaskId,this.materialNameList,this.totalLaborFee,this.totalMaterialFee});

  factory WorkOther.fromJson(Map<String, dynamic> srcJson) => _$WorkOtherFromJson(srcJson);

  Map<String, dynamic> toJson() => _$WorkOtherToJson(this);

}




