import 'package:json_annotation/json_annotation.dart';

part 'decoration_obj_list.g.dart';


@JsonSerializable()
class DecorationObjList extends Object {

  @JsonKey(name: 'appCodes')
  List<String> appCodes;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'data')
  List<DecorationRecord> data;

  @JsonKey(name: 'extStr')
  String extStr;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'totalCount')
  int totalCount;

  DecorationObjList({this.appCodes,this.code,this.data,this.extStr,this.message,this.systemDate,this.totalCount,});

  factory DecorationObjList.fromJson(Map<String, dynamic> srcJson) => _$DecorationObjListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DecorationObjListToJson(this);

}





@JsonSerializable()
class DecorationRecord extends Object {

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

  @JsonKey(name: 'companyPaperNumber')
  String companyPaperNumber;

  @JsonKey(name: 'credentialNumber')
  String credentialNumber;

  @JsonKey(name: 'custId')
  int custId;

  @JsonKey(name: 'custName')
  String custName;

  @JsonKey(name: 'custPhone')
  String custPhone;

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

  @JsonKey(name: 'managerPhone')
  String managerPhone;

  @JsonKey(name: 'oddNumber')
  String oddNumber;

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

  @JsonKey(name: 'userId')
  int userId;

  @JsonKey(name: 'workCompany')
  String workCompany;

  @JsonKey(name: 'workDayLong')
  int workDayLong;

  @JsonKey(name: 'workPeopleNum')
  int workPeopleNum;


  @JsonKey(name: 'businessNo')
  String businessNo;


  DecorationRecord({this.agree,this.applyDate,this.applyType,this.beginWorkDate,this.bpmCurrentRole,this.bpmCurrentState,this.companyPaperNumber,this.credentialNumber,this.custId,this.custName,this.custPhone,this.decorateType,this.houseId,this.houseName,this.id,this.manager,this.managerIdCard,this.managerPhone,this.oddNumber,this.postId,this.processId,this.programDesc,this.programName,this.projectId,this.state,this.userId,this.workCompany,this.workDayLong,this.workPeopleNum,this.businessNo});

  factory DecorationRecord.fromJson(Map<String, dynamic> srcJson) => _$DecorationRecordFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DecorationRecordToJson(this);

}


