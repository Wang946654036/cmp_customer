import 'package:cmp_customer/models/request/base_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'check_in_history_request.g.dart';


@JsonSerializable()
class CheckInHistoryRequest extends BaseRequest {

//  @JsonKey(name: 'carNos')
//  List<String> carNos;
//
//  @JsonKey(name: 'customerId')
//  int customerId;

  @JsonKey(name: 'endTime')
  String endTime;

//  @JsonKey(name: 'searchKey')
//  String searchKey;

  @JsonKey(name: 'startTime')
  String startTime;

//  @JsonKey(name: 'types')
//  List<String> types;

  @JsonKey(name: 'status')
  List<String> status;

  @JsonKey(name: 'projectId')
  int projectId;//项目id


  CheckInHistoryRequest();

  factory CheckInHistoryRequest.fromJson(Map<String, dynamic> srcJson) => _$CheckInHistoryRequestFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CheckInHistoryRequestToJson(this);

}


