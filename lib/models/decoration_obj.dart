import 'package:cmp_customer/models/user_data_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'change_title_obj.dart';

part 'decoration_obj.g.dart';


@JsonSerializable()
class DecorationObj extends Object {

  @JsonKey(name: 'appCodes')
  List<String> appCodes;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'data')
  DecorationInfo data;

  @JsonKey(name: 'extStr')
  String extStr;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'totalCount')
  int totalCount;

  DecorationObj({this.appCodes,this.code,this.data,this.extStr,this.message,this.systemDate,this.totalCount,});

  factory DecorationObj.fromJson(Map<String, dynamic> srcJson) => _$DecorationObjFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DecorationObjToJson(this);

}


@JsonSerializable()
class DecorationInfo extends Object {

  @JsonKey(name: 'agree')
  int agree;

  @JsonKey(name: 'applyDate')
  String applyDate;

  @JsonKey(name: 'applyType')
  int applyType;

  @JsonKey(name: 'beginWorkDate')
  String beginWorkDate;

  @JsonKey(name: 'bpmCurrentRole')
  String bpmCurrentRole;

  @JsonKey(name: 'bpmCurrentState')
  String bpmCurrentState;

  @JsonKey(name: 'acceptanceCheckRole')
  String acceptanceCheckRole;

  @JsonKey(name: 'acceptanceId')
  int acceptanceId;

  @JsonKey(name: 'checkRole')
  String checkRole;

  @JsonKey(name: 'companyPaperNumber')
  String companyPaperNumber;

  @JsonKey(name: 'companyPapers')
  List<Attachment> companyPapers;

  @JsonKey(name: 'credentialNumber')
  String credentialNumber;

  @JsonKey(name: 'credentialPapers')
  List<Attachment> credentialPapers;

  @JsonKey(name: 'custId')
  int custId;

  @JsonKey(name: 'custName')
  String custName;

  @JsonKey(name:'custPhone')
  String custPhone;

  @JsonKey(name: 'decorateAcceptanceVo')
  DecorateAcceptanceVo decorateAcceptanceVo;

  @JsonKey(name: 'decorateType')
  int decorateType;

  @JsonKey(name: 'houseId')
  int houseId;

  @JsonKey(name: 'houseName')
  String houseName;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'manager')
  String manager;

  @JsonKey(name: 'managerIdCard')
  String managerIdCard;

  @JsonKey(name: 'managerIdCardPhotos')
  List<Attachment> managerIdCardPhotos;

  @JsonKey(name: 'managerPhone')
  String managerPhone;

  @JsonKey(name: 'nodeList')
  List<NodeList> nodeList;

  @JsonKey(name: 'oddNumber')
  String oddNumber;

  @JsonKey(name: 'operationCust')
  int operationCust;

  @JsonKey(name: 'operationUser')
  int operationUser;

  @JsonKey(name: 'otherPhotos')
  List<Attachment> otherPhotos;

  @JsonKey(name: 'payPhotos')
  List<Attachment> payPhotos;

  @JsonKey(name: 'postId')
  int postId;

  @JsonKey(name: 'processId')
  String processId;

  @JsonKey(name: 'programDesc')
  String programDesc;

  @JsonKey(name: 'programName')
  String programName;

  @JsonKey(name: 'projectId')
  int projectId;

  @JsonKey(name: 'state')
  String state;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'userId')
  int userId;

  @JsonKey(name: 'workCompany')
  String workCompany;

  @JsonKey(name: 'workDayLong')
  int workDayLong;

  @JsonKey(name: 'workPeopleNum')
  int workPeopleNum;
  @JsonKey(name: 'houseCustName')
  String houseCustName;
  @JsonKey(name: 'canOperation')
  bool canOperation;

  DecorationInfo({this.agree,this.applyDate,this.applyType,this.beginWorkDate,this.bpmCurrentRole,this.bpmCurrentState,this.checkRole,this.companyPaperNumber,this.companyPapers,this.credentialNumber,this.credentialPapers,this.custId,this.custName,this.custPhone,this.decorateAcceptanceVo,this.decorateType,this.houseId,this.houseName,this.id,this.manager,this.managerIdCard,this.managerIdCardPhotos,this.managerPhone,this.nodeList,this.oddNumber,this.operationCust,this.operationUser,this.otherPhotos,this.payPhotos,this.postId,this.processId,this.programDesc,this.programName,this.projectId,this.state,this.status,this.userId,this.workCompany,this.workDayLong,this.workPeopleNum,this.houseCustName,this.acceptanceId,this.acceptanceCheckRole,this.canOperation});

  factory DecorationInfo.fromJson(Map<String, dynamic> srcJson) => _$DecorationInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DecorationInfoToJson(this);

}







@JsonSerializable()
class DecorateAcceptanceVo extends Object {

  @JsonKey(name: 'applyId')
  int applyId;

  @JsonKey(name: 'backPrice')
  int backPrice;

  @JsonKey(name: 'bpmCurrentRole')
  String bpmCurrentRole;

  @JsonKey(name: 'bpmCurrentState')
  String bpmCurrentState;

  @JsonKey(name: 'checkDate')
  String checkDate;

  @JsonKey(name: 'checkDesc')
  String checkDesc;

  @JsonKey(name: 'checkPhotos')
  List<Attachment> checkPhotos;

  @JsonKey(name: 'checkResult')
  int checkResult;

  @JsonKey(name: 'checkRole')
  String checkRole;

  @JsonKey(name: 'counter')
  int counter;

  @JsonKey(name: 'createDate')
  String createDate;

  @JsonKey(name: 'custId')
  int custId;

  @JsonKey(name: 'finishDate')
  String finishDate;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'isBack')
  int isBack;

  @JsonKey(name: 'manager')
  String manager;

  @JsonKey(name: 'managerPhone')
  String managerPhone;

  @JsonKey(name: 'operationCust')
  int operationCust;

  @JsonKey(name: 'operationUser')
  int operationUser;

  @JsonKey(name: 'price')
  String price;

  @JsonKey(name: 'processId')
  String processId;

  @JsonKey(name: 'quality')
  int quality;

  @JsonKey(name: 'state')
  String state;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'suggestion')
  String suggestion;

  DecorateAcceptanceVo(this.applyId,this.backPrice,this.bpmCurrentRole,this.bpmCurrentState,this.checkDate,this.checkDesc,this.checkPhotos,this.checkResult,this.checkRole,this.counter,this.createDate,this.custId,this.finishDate,this.id,this.isBack,this.manager,this.managerPhone,this.operationCust,this.operationUser,this.price,this.processId,this.quality,this.state,this.status,this.suggestion,);

  factory DecorateAcceptanceVo.fromJson(Map<String, dynamic> srcJson) => _$DecorateAcceptanceVoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DecorateAcceptanceVoToJson(this);

}





@JsonSerializable()
class NodeList extends Object {

  @JsonKey(name: 'applyId')
  int applyId;

  @JsonKey(name: 'createDate')
  String createDate;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'logType')
  int logType;

  @JsonKey(name: 'operation')
  String operation;

  @JsonKey(name: 'operationCust')
  int operationCust;

  @JsonKey(name: 'operationName')
  String operationName;

  @JsonKey(name: 'operationResult')
  String operationResult;

  @JsonKey(name: 'operationUser')
  int operationUser;

  @JsonKey(name: 'other')
  String other;

  @JsonKey(name: 'remark')
  String remark;

  @JsonKey(name: 'attFileList')
  List<Attachment> attFileList;

  NodeList(this.applyId,this.createDate,this.id,this.logType,this.operation,this.operationCust,this.operationName,this.operationResult,this.operationUser,this.other,this.remark,this.attFileList);

  factory NodeList.fromJson(Map<String, dynamic> srcJson) => _$NodeListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$NodeListToJson(this);

}






  
