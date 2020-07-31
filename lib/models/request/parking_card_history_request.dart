import 'package:cmp_customer/models/request/base_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'parking_card_history_request.g.dart';


@JsonSerializable()
class ParkingCardHistoryRequest extends BaseRequest {

  @JsonKey(name: 'carNos')
  List<String> carNos;

  @JsonKey(name: 'customerId')
  int customerId;

  @JsonKey(name: 'endTime')
  String endTime;

  @JsonKey(name: 'searchKey')
  String searchKey;

  @JsonKey(name: 'startTime')
  String startTime;

  @JsonKey(name: 'types')
  List<String> types;

  @JsonKey(name: 'projectId')
  int projectId;//项目id


  ParkingCardHistoryRequest({this.carNos,this.customerId,this.endTime,this.searchKey,this.startTime,this.types,});

  factory ParkingCardHistoryRequest.fromJson(Map<String, dynamic> srcJson) => _$ParkingCardHistoryRequestFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ParkingCardHistoryRequestToJson(this);

}


