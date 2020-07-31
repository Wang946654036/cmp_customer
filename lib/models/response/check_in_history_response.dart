import 'package:json_annotation/json_annotation.dart';

import 'base_response.dart';

part 'check_in_history_response.g.dart';


@JsonSerializable()
class CheckInHistoryResponse extends BaseResponse{

  @JsonKey(name: 'data')
  List<CheckInHistory> historyList;

  CheckInHistoryResponse();

  factory CheckInHistoryResponse.fromJson(Map<String, dynamic> srcJson) => _$CheckInHistoryResponseFromJson(srcJson);

}


@JsonSerializable()
class CheckInHistory extends Object{

  @JsonKey(name: 'bookReprocessTime')
  String bookReprocessTime;

  @JsonKey(name: 'businessNo')
  String businessNo;

  @JsonKey(name: 'createTime')
  String createTime;

  @JsonKey(name: 'customerName')
  String customerName;

  @JsonKey(name: 'customerPhone')
  String customerPhone;

  @JsonKey(name: 'enterType')
  String enterType;

  @JsonKey(name: 'houseNo')
  String houseNo;

  @JsonKey(name: 'projectName')
  String projectName;

  @JsonKey(name: 'rentType')
  String rentType;

  @JsonKey(name: 'rentersName')
  String rentersName;

  @JsonKey(name: 'rentingEnterId')
  int rentingEnterId;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'updateTime')
  String updateTime;

  CheckInHistory(this.bookReprocessTime,this.businessNo,this.createTime,this.customerName,this.customerPhone,this.enterType,this.houseNo,this.projectName,this.rentType,this.rentersName,this.rentingEnterId,this.status,this.updateTime,);

  factory CheckInHistory.fromJson(Map<String, dynamic> srcJson) => _$CheckInHistoryFromJson(srcJson);

}


