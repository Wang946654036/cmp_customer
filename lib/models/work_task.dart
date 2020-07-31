import 'package:json_annotation/json_annotation.dart';

part 'work_task.g.dart';


@JsonSerializable()
class WorkTask extends Object {

  @JsonKey(name: 'analysis')
  String analysis;

  @JsonKey(name: 'carbonCopyList')
  List<int> carbonCopyList;

  @JsonKey(name: 'communication')
  String communication;

  @JsonKey(name: 'complaintMainCategory')
  String complaintMainCategory;

  @JsonKey(name: 'complaintProperty')
  String complaintProperty;

  @JsonKey(name: 'complaintSubCategoryList')
  List<String> complaintSubCategoryList;

  @JsonKey(name: 'cooperationUserId')
  List<int> cooperationUserId;

  @JsonKey(name: 'dispatchPostId')
  int dispatchPostId;

  @JsonKey(name: 'dispatchUserId')
  int dispatchUserId;

  @JsonKey(name: 'passFlag')
  String passFlag;

  @JsonKey(name: 'payPrice')
  int payPrice;

  @JsonKey(name: 'payType')
  String payType;

  @JsonKey(name: 'processAction')
  String processAction;

  @JsonKey(name: 'processContent')
  String processContent;

  @JsonKey(name: 'processNodePhotoList')
  List<String> processNodePhotoList;

  @JsonKey(name: 'processNodeVoiceList')
  List<String> processNodeVoiceList;

  @JsonKey(name: 'processRemarks')
  String processRemarks;

  @JsonKey(name: 'selectTime')
  String selectTime;

  @JsonKey(name: 'serviceGrade')
  int serviceGrade;

  @JsonKey(name: 'serviceSubType')
  String serviceSubType;

  @JsonKey(name: 'urgentLevel')
  String urgentLevel;

  @JsonKey(name: 'validFlag')
  String validFlag;

  @JsonKey(name: 'workOrderId')
  int workOrderId;

  @JsonKey(name: 'workTaskId')
  int workTaskId;

  WorkTask({this.analysis,this.carbonCopyList,this.communication,this.complaintMainCategory,this.complaintProperty,this.complaintSubCategoryList,this.cooperationUserId,this.dispatchPostId,this.dispatchUserId,this.passFlag,this.payPrice,this.payType,this.processAction,this.processContent,this.processNodePhotoList,this.processNodeVoiceList,this.processRemarks,this.selectTime,this.serviceGrade,this.serviceSubType,this.urgentLevel,this.validFlag,this.workOrderId,this.workTaskId,});

  factory WorkTask.fromJson(Map<String, dynamic> srcJson) => _$WorkTaskFromJson(srcJson);

  Map<String, dynamic> toJson() => _$WorkTaskToJson(this);

}


