import 'package:json_annotation/json_annotation.dart';

part 'property_change_user_param.g.dart';


@JsonSerializable()
class PropertyChangeUserParam extends Object {

  @JsonKey(name: 'assigneePhone')
  String assigneePhone;

  @JsonKey(name: 'assigneeRealname')
  String assigneeRealname;

  @JsonKey(name: 'buildId')
  int buildId;

  @JsonKey(name: 'businessNo')
  String businessNo;

  @JsonKey(name: 'current')
  int current;

  @JsonKey(name: 'currentUser')
  int currentUser;

  @JsonKey(name: 'customerName')
  String customerName;

  @JsonKey(name: 'customerPhone')
  String customerPhone;

  @JsonKey(name: 'endTime')
  String endTime;

  @JsonKey(name: 'houseId')
  int houseId;

  @JsonKey(name: 'houseNo')
  String houseNo;

  @JsonKey(name: 'pageSize')
  int pageSize;

  @JsonKey(name: 'projectIds')
  List<int> projectIds;

  @JsonKey(name: 'queryType')
  String queryType;

  @JsonKey(name: 'startTime')
  String startTime;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'unitId')
  int unitId;
@JsonKey(name: 'custId')
int custId;
  @JsonKey(name: 'operationCust')
  int operationCust;

  PropertyChangeUserParam({this.custId,this.assigneePhone,this.assigneeRealname,this.buildId,this.businessNo,this.current,this.currentUser,this.customerName,this.customerPhone,this.endTime,this.houseId,this.houseNo,this.pageSize,this.projectIds,this.queryType,this.startTime,this.status,this.unitId,this.operationCust});

  factory PropertyChangeUserParam.fromJson(Map<String, dynamic> srcJson) => _$PropertyChangeUserParamFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PropertyChangeUserParamToJson(this);

}


