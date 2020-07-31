import 'package:json_annotation/json_annotation.dart';

import '../user_data_model.dart';
import 'base_response.dart';

part 'decoration_pass_card_details_response.g.dart';

@JsonSerializable()
class DecorationPassCardDetailsResponse extends BaseResponse {
  @JsonKey(name: 'data')
  DecorationPassCardDetails details;

  DecorationPassCardDetailsResponse({this.details});

  factory DecorationPassCardDetailsResponse.fromJson(Map<String, dynamic> srcJson) =>
      _$DecorationPassCardDetailsResponseFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DecorationPassCardDetailsResponseToJson(this);
}

@JsonSerializable()
class DecorationPassCardDetails extends Object {
  @JsonKey(name: 'beginDate')
  String beginDate;

  @JsonKey(name: 'bpmCurrentRole')
  String bpmCurrentRole;

  @JsonKey(name: 'bpmCurrentState')
  String bpmCurrentState;

  @JsonKey(name: 'checkRole')
  String checkRole;

  @JsonKey(name: 'company')
  String company;

  @JsonKey(name: 'createDate')
  String createDate;

  @JsonKey(name: 'custId')
  int custId;

  @JsonKey(name: 'custName')
  String custName;

  @JsonKey(name: 'custPhone')
  String custPhone;

  @JsonKey(name: 'endDate')
  String endDate;

  @JsonKey(name: 'houseId')
  int houseId;

  @JsonKey(name: 'houseName')
  String houseName;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'nodeList')
  List<NodeList> nodeList;

  @JsonKey(name: 'oddNumber')
  String oddNumber;

  @JsonKey(name: 'operationCust')
  int operationCust;

  @JsonKey(name: 'operationUser')
  int operationUser;

  @JsonKey(name: 'paperCount')
  int paperCount;

  @JsonKey(name: 'passPhotos')
  List<Attachment> passPhotos;

  @JsonKey(name: 'postId')
  int postId;

  @JsonKey(name: 'processId')
  String processId;

  @JsonKey(name: 'projectId')
  int projectId;

  @JsonKey(name: 'projectName')
  String projectName;

  @JsonKey(name: 'formerName')
  String formerName;

  @JsonKey(name: 'remark')
  String remark;

  @JsonKey(name: 'state')
  String state;

  @JsonKey(name: 'stateString')
  String stateString;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'type')
  int type;

  @JsonKey(name: 'userId')
  int userId;

  @JsonKey(name: 'userList')
  List<UserList> userList;


  @JsonKey(name: 'creatorWriteUuid')
  String creatorWriteUuid;

  @JsonKey(name: 'ownerWriteUuid')
  String ownerWriteUuid;

  @JsonKey(name: 'checkUserUuid')
  String checkUserUuid;

  DecorationPassCardDetails({
    this.beginDate,
    this.bpmCurrentRole,
    this.bpmCurrentState,
    this.checkRole,
    this.company,
    this.createDate,
    this.custId,
    this.custName,
    this.custPhone,
    this.endDate,
    this.houseId,
    this.houseName,
    this.id,
    this.nodeList,
    this.oddNumber,
    this.operationCust,
    this.operationUser,
    this.paperCount,
    this.passPhotos,
    this.postId,
    this.processId,
    this.projectId,
    this.remark,
    this.state,
    this.status,
    this.type,
    this.userId,
    this.userList,
    this.formerName,
    this.creatorWriteUuid,
    this.ownerWriteUuid,
    this.checkUserUuid

  });

  factory DecorationPassCardDetails.fromJson(Map<String, dynamic> srcJson) =>
      _$DecorationPassCardDetailsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DecorationPassCardDetailsToJson(this);
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

  @JsonKey(name: 'checkUserUuid')
  String checkUserUuid;//审核人签名


  NodeList(
    this.applyId,
    this.attFileList,
    this.createDate,
    this.id,
    this.logType,
    this.operation,
    this.operationCust,
    this.operationCustName,
    this.operationName,
    this.operationResult,
    this.operationUser,
    this.operationUserName,
    this.other,
    this.remark,
    this.checkUserUuid
  );

  factory NodeList.fromJson(Map<String, dynamic> srcJson) => _$NodeListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$NodeListToJson(this);
}

@JsonSerializable()
class UserList extends Object {
  @JsonKey(name: 'applyId')
  int applyId;

  @JsonKey(name: 'beginDate')
  String beginDate;

  @JsonKey(name: 'endDate')
  String endDate;

  @JsonKey(name: 'headPhotos')
  List<Attachment> headPhotos;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'idCard')
  String idCard;

  @JsonKey(name: 'idCardPhotos')
  List<Attachment> idCardPhotos;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'workType')
  String workType;

  UserList({
    this.applyId,
    this.beginDate,
    this.endDate,
    this.headPhotos,
    this.id,
    this.idCard,
    this.idCardPhotos,
    this.name,
    this.workType,
  });

  factory UserList.fromJson(Map<String, dynamic> srcJson) => _$UserListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserListToJson(this);
}
