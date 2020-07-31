import 'package:cmp_customer/models/response/base_response.dart';
import 'package:cmp_customer/models/response/parking_card_details_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'parking_card_history_response.g.dart';


@JsonSerializable()
class ParkingCardHistoryResponse extends BaseResponse{


//  @JsonKey(name: 'code')
//  int code;
//
//  @JsonKey(name: 'message')
//  String message;
//
//  bool success(){
//    return code==0;
//  }

  @JsonKey(name: 'data')
  List<ParkingCardDetailsInfo> parkingCardHistoryList;

  ParkingCardHistoryResponse(this.parkingCardHistoryList);

  factory ParkingCardHistoryResponse.fromJson(Map<String, dynamic> srcJson) => _$ParkingCardHistoryResponseFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ParkingCardHistoryResponseToJson(this);

}

//@JsonSerializable()
//class ParkingCardHistoryDetailsInfo extends Object{
//
//  @JsonKey(name: 'parkingId')
//  int parkingId;
//
//  @JsonKey(name: 'projectId')
//  int projectId;
//
//  @JsonKey(name: 'buildId')
//  int buildId;
//
//  @JsonKey(name: 'unitId')
//  int unitId;
//
//  @JsonKey(name: 'roomNo')
//  String roomNo;
//
//  @JsonKey(name: 'type')
//  String type;
//
//  @JsonKey(name: 'businessNo')
//  String businessNo;
//
//  @JsonKey(name: 'parkingLotId')
//  String parkingLotId;
//
//  @JsonKey(name: 'parkingLot')
//  String parkingLot;
//
//  @JsonKey(name: 'parkingPackageId')
//  String parkingPackageId;
//
//  @JsonKey(name: 'parkingPackage')
//  String parkingPackage;
//
//  @JsonKey(name: 'carNo')
//  String carNo;
//
//  @JsonKey(name: 'carBrand')
//  String carBrand;
//
//  @JsonKey(name: 'carColor')
//  String carColor;
//
//  @JsonKey(name: 'carOwnerName')
//  String carOwnerName;
//
//  @JsonKey(name: 'carOwnerPhone')
//  String carOwnerPhone;
//
//  @JsonKey(name: 'applyMonths')
//  int applyMonths;
//
//  @JsonKey(name: 'payFees')
//  double payFees;
//
//  @JsonKey(name: 'customerId')
//  int customerId;
//
//  @JsonKey(name: 'customerName')
//  String customerName;
//
//  @JsonKey(name: 'customerPhone')
//  String customerPhone;
//
//  @JsonKey(name: 'status')
//  String status;
//
//  @JsonKey(name: 'remark')
//  String remark;
//
//  @JsonKey(name: 'createTime')
//  String createTime;
//
//  @JsonKey(name: 'updateTime')
//  String updateTime;
//
//  ParkingCardHistoryDetailsInfo({this.parkingId,this.projectId,this.buildId,this.unitId,this.roomNo,this.type,this.businessNo,this.parkingLotId,this.parkingLot,this.parkingPackageId,this.parkingPackage,this.carNo,this.carBrand,this.carColor,this.carOwnerName,this.carOwnerPhone,this.applyMonths,this.payFees,this.customerId,this.customerName,this.customerPhone,this.status,this.remark,this.createTime,this.updateTime,});
//
//  factory ParkingCardHistoryDetailsInfo.fromJson(Map<String, dynamic> srcJson) => _$ParkingCardHistoryDetailsInfoFromJson(srcJson);
//
//  Map<String, dynamic> toJson() => _$ParkingCardHistoryDetailsInfoToJson(this);
//
//}