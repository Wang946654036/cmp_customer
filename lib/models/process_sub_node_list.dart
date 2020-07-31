import 'package:json_annotation/json_annotation.dart';

part 'process_sub_node_list.g.dart';


@JsonSerializable()
class ProcessSubNodeList extends Object {

  @JsonKey(name: 'appCodes')
  List<String> appCodes;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'data')
  List<ProcessSubNode> data;

  @JsonKey(name: 'extStr')
  String extStr;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'totalCount')
  int totalCount;

  ProcessSubNodeList(this.appCodes,this.code,this.data,this.extStr,this.message,this.systemDate,this.totalCount,);

  factory ProcessSubNodeList.fromJson(Map<String, dynamic> srcJson) => _$ProcessSubNodeListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProcessSubNodeListToJson(this);

}


@JsonSerializable()
class ProcessSubNode extends Object {

  @JsonKey(name: 'nodeCode')
  String nodeCode;
  @JsonKey(name:'nodeCodeName')
  String nodeCodeName;
  @JsonKey(name: 'nodeId')
  int nodeId;

  @JsonKey(name: 'parentNodeId')
  int parentNodeId;

  @JsonKey(name: 'processContent')
  String processContent;

  @JsonKey(name: 'processPostId')
  int processPostId;

  @JsonKey(name: 'processTime')
  String processTime;

  @JsonKey(name: 'processUserId')
  int processUserId;
  @JsonKey(name: 'processUserName')
  String processUserName;
  @JsonKey(name: 'workOrderId')
  int workOrderId;

  @JsonKey(name: 'materialNameList')
  List<String> materialNameList;

  @JsonKey(name: 'materialFee')
  double materialFee;

  @JsonKey(name: 'laborFee')
  double laborFee;

  @JsonKey(name: 'payPrice')
  double payPrice;

  @JsonKey(name: 'payType')
  String payType;


  ProcessSubNode(this.nodeCode,this.nodeCodeName,this.nodeId,this.parentNodeId,this.processContent,this.processPostId,this.processTime,this.processUserId,this.processUserName,this.workOrderId,this.laborFee,this.materialFee,this.materialNameList,this.payPrice,this.payType);

  factory ProcessSubNode.fromJson(Map<String, dynamic> srcJson) => _$ProcessSubNodeFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProcessSubNodeToJson(this);

}


