
import 'package:cmp_customer/models/process_sub_node_list.dart';
import 'package:json_annotation/json_annotation.dart';

part 'process_main_node_list.g.dart';


@JsonSerializable()
class ProcessMainNodeList extends Object {

  @JsonKey(name: 'appCodes')
  List<String> appCodes;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'data')
  List<ProcessMainNode> data;

  @JsonKey(name: 'extStr')
  String extStr;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'totalCount')
  int totalCount;

  ProcessMainNodeList({this.appCodes,this.code,this.data,this.extStr,this.message,this.systemDate,this.totalCount,});

  factory ProcessMainNodeList.fromJson(Map<String, dynamic> srcJson) => _$ProcessMainNodeListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProcessMainNodeListToJson(this);

}


@JsonSerializable()
class ProcessMainNode extends Object {

  @JsonKey(name: 'complaintMainCategory')
  String complaintMainCategory;

  @JsonKey(name: 'complaintPropertyName')
  String complaintProperty;

  @JsonKey(name: 'complaintSubCategoryList')
  List<String> complaintSubCategory;

  @JsonKey(name: 'customerName')
  String customerName;

  @JsonKey(name: 'dispatchPostName')
  String dispatchPostName;

  @JsonKey(name: 'dispatchUserName')
  String dispatchUserName;

  @JsonKey(name: 'hasImage')
  String hasImage;

  @JsonKey(name: 'hasVoice')
  String hasVoice;

  @JsonKey(name: 'nodeCode')
  String nodeCode;

  @JsonKey(name: 'nodeId')
  int nodeId;

  @JsonKey(name: 'passFlag')
  String passFlag;

  @JsonKey(name: 'payPrice')
  double payPrice;

  @JsonKey(name: 'payType')
  String payType;

  @JsonKey(name: 'processContent')
  String processContent;

  @JsonKey(name: 'processExecutor')
  String processExecutor;

  @JsonKey(name: 'processId')
  String processId;

  @JsonKey(name: 'processNodeName')
  String processNodeName;

  @JsonKey(name: 'processPostId')
  int processPostId;

  @JsonKey(name: 'processRemarks')
  String processRemarks;

  @JsonKey(name: 'processTime')
  String processTime;

  @JsonKey(name: 'processUserId')
  int processUserId;

  @JsonKey(name: 'processUserName')
  String processUserName;

  @JsonKey(name: 'serviceGrade')
  int serviceGrade;

  @JsonKey(name: 'serviceSubType')
  String serviceSubType;

  @JsonKey(name: 'subNodeList')
  List<ProcessSubNode> subNodeList;

  @JsonKey(name: 'urgentLevel')
  String urgentLevel;

  @JsonKey(name: 'validFlag')
  String validFlag;

  @JsonKey(name: 'workOrderId')
  int workOrderId;

  @JsonKey(name: 'workOrderPhotoList')
  List<Map<String,String>> workOrderPhotoList;

  @JsonKey(name: 'workOrderVoiceList')
  List<Map<String,String>> workOrderVoiceList;
  @JsonKey(name: 'materialNameList')
  List<String> materialNameList;

  @JsonKey(name: 'materialFee')
  double materialFee;
  @JsonKey(name: 'laborFee')
  double laborFee;
    ProcessMainNode({this.complaintMainCategory,this.complaintProperty,this.complaintSubCategory,this.customerName,this.dispatchPostName,this.dispatchUserName,this.hasImage,this.hasVoice,this.nodeCode,this.nodeId,this.passFlag,this.payPrice,this.payType,this.processContent,this.processExecutor,this.processId,this.processNodeName,this.processPostId,this.processRemarks,this.processTime,this.processUserId,this.processUserName,this.serviceGrade,this.serviceSubType,this.subNodeList,this.urgentLevel,this.validFlag,this.workOrderId,this.workOrderPhotoList,this.workOrderVoiceList,this.materialNameList,this.materialFee,this.laborFee});

  factory ProcessMainNode.fromJson(Map<String, dynamic> srcJson) => _$ProcessMainNodeFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProcessMainNodeToJson(this);

}




