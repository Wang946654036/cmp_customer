import 'package:cmp_customer/models/user_data_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'change_title_obj.dart';

part 'decoration_permit_obj.g.dart';


@JsonSerializable()
class DecorationPermitObj extends Object {

  @JsonKey(name: 'appCodes')
  List<String> appCodes;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'data')
  DecorationPermitInfo data;

  @JsonKey(name: 'extStr')
  String extStr;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'totalCount')
  int totalCount;

  DecorationPermitObj({this.appCodes,this.code,this.data,this.extStr,this.message,this.systemDate,this.totalCount,});

  factory DecorationPermitObj.fromJson(Map<String, dynamic> srcJson) => _$DecorationPermitObjFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DecorationPermitObjToJson(this);

}


@JsonSerializable()
class DecorationPermitInfo extends Object {

  @JsonKey(name: 'applyId')
  int applyId;

  @JsonKey(name: 'applyVo')
  ApplyVo applyVo;

  @JsonKey(name: 'bpmCurrentRole')
  String bpmCurrentRole;

  @JsonKey(name: 'bpmCurrentState')
  String bpmCurrentState;

  @JsonKey(name: 'checkRole')
  String checkRole;

  @JsonKey(name: 'delayDate')
  String delayDate;

  @JsonKey(name: 'delayState')
  String delayState;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'oddNumber')
  String oddNumber;
  @JsonKey(name: 'newNumber')
  String newNumber;
  @JsonKey(name: 'operationCust')
  int operationCust;

  @JsonKey(name: 'operationUser')
  int operationUser;

  @JsonKey(name: 'postId')
  int postId;

  @JsonKey(name: 'processId')
  String processId;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'userId')
  int userId;

  @JsonKey(name: 'writeDate')
  String writeDate;

  @JsonKey(name: 'writer')
  int writer;

  @JsonKey(name: 'writerName')
  String writerName;

  @JsonKey(name: 'fromDate')
  String fromDate;
  @JsonKey(name: 'reason')
  String reason;
  @JsonKey(name: 'remark')
  String remark;
  @JsonKey(name: 'applyHanders')
  List<DecorateApplyHanderVo> applyHanders ;
  DecorationPermitInfo(this.applyId,this.applyVo,this.bpmCurrentRole,this.bpmCurrentState,this.checkRole,this.fromDate,this.delayDate,this.delayState,this.id,this.oddNumber,this.newNumber,this.operationCust,this.operationUser,this.postId,this.processId,this.status,this.userId,this.writeDate,this.writer,this.writerName,this.reason,this.remark,this.applyHanders);

  factory DecorationPermitInfo.fromJson(Map<String, dynamic> srcJson) => _$DecorationPermitInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DecorationPermitInfoToJson(this);

}


@JsonSerializable()
class ApplyVo extends Object {

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

  @JsonKey(name: 'custPhone')
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

  ApplyVo(this.agree,this.applyDate,this.applyType,this.beginWorkDate,this.bpmCurrentRole,this.bpmCurrentState,this.checkRole,this.companyPaperNumber,this.companyPapers,this.credentialNumber,this.credentialPapers,this.custId,this.custName,this.custPhone,this.decorateAcceptanceVo,this.decorateType,this.houseId,this.houseName,this.id,this.manager,this.managerIdCard,this.managerIdCardPhotos,this.managerPhone,this.nodeList,this.oddNumber,this.operationCust,this.operationUser,this.otherPhotos,this.payPhotos,this.postId,this.processId,this.programDesc,this.programName,this.projectId,this.state,this.status,this.userId,this.workCompany,this.workDayLong,this.workPeopleNum,);

  factory ApplyVo.fromJson(Map<String, dynamic> srcJson) => _$ApplyVoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ApplyVoToJson(this);

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

  @JsonKey(name: 'checkSecond')
  int checkSecond;

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

  DecorateAcceptanceVo(this.applyId,this.backPrice,this.bpmCurrentRole,this.bpmCurrentState,this.checkDate,this.checkDesc,this.checkPhotos,this.checkResult,this.checkRole,this.checkSecond,this.counter,this.createDate,this.custId,this.finishDate,this.id,this.isBack,this.manager,this.managerPhone,this.operationCust,this.operationUser,this.price,this.processId,this.quality,this.state,this.status,this.suggestion,);

  factory DecorateAcceptanceVo.fromJson(Map<String, dynamic> srcJson) => _$DecorateAcceptanceVoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DecorateAcceptanceVoToJson(this);

}
@JsonSerializable()
class DecorateApplyHanderVo extends Object{
  @JsonKey(name: 'mobile')
  String mobile;
  @JsonKey(name: 'postName')
  String postName;
  @JsonKey(name: 'realname')
  String realname;

  DecorateApplyHanderVo(this.mobile,this.postName,this.realname);
  factory DecorateApplyHanderVo.fromJson(Map<String, dynamic> srcJson) => _$DecorateApplyHanderVoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DecorateApplyHanderVoToJson(this);
}

@JsonSerializable()
class NodeList extends Object {

  @JsonKey(name: 'applyId')
  int applyId;

  @JsonKey(name: 'attFileList')
  List<Attachment> attFileList;

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

  @JsonKey(name: 'operationCustName')
  String operationCustName;

  @JsonKey(name: 'operationName')
  String operationName;

  @JsonKey(name: 'operationResult')
  String operationResult;

  @JsonKey(name: 'operationUser')
  int operationUser;

  @JsonKey(name: 'operationUserName')
  String operationUserName;

  @JsonKey(name: 'other')
  String other;

  @JsonKey(name: 'remark')
  String remark;

  NodeList(this.applyId,this.attFileList,this.createDate,this.id,this.logType,this.operation,this.operationCust,this.operationCustName,this.operationName,this.operationResult,this.operationUser,this.operationUserName,this.other,this.remark,);

  factory NodeList.fromJson(Map<String, dynamic> srcJson) => _$NodeListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$NodeListToJson(this);

}





  
