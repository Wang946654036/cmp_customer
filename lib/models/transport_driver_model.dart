import 'package:json_annotation/json_annotation.dart';

part 'transport_driver_model.g.dart';


@JsonSerializable()
class TransportDriverModel extends Object {

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'data')
  List<TransportDriverInfo> transportDriverList;

  TransportDriverModel(this.code,this.message,this.systemDate,this.transportDriverList,);

  factory TransportDriverModel.fromJson(Map<String, dynamic> srcJson) => _$TransportDriverModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TransportDriverModelToJson(this);

}


@JsonSerializable()
class TransportDriverInfo extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'orderNo')
  String orderNo;

  @JsonKey(name: 'orderStatus')
  String orderStatus; //订单状态：1：未排队、2：等待叫号、3：已叫号、4：已完成、5：已作废

  @JsonKey(name: 'orderType')
  String orderType; //订单类型：0：提货订单 1：送货订单

  @JsonKey(name: 'customerId')
  String customerId;

  @JsonKey(name: 'customerName')
  String customerName; //客户名称（订单类型为提货展现）

  @JsonKey(name: 'carNo')
  String carNo; //车牌号码

  @JsonKey(name: 'driveMobile')
  String driveMobile;

  @JsonKey(name: 'pickUpTime')
  String pickUpTime;

  @JsonKey(name: 'effectiveStartTime')
  String effectiveStartTime;

  @JsonKey(name: 'effectiveEndTime')
  String effectiveEndTime;

  @JsonKey(name: 'weightAll')
  double weightAll;

  @JsonKey(name: 'wayFeeAll')
  double wayFeeAll;

  @JsonKey(name: 'originatingAddress')
  String originatingAddress;

  @JsonKey(name: 'destinationAddress')
  String destinationAddress;

  @JsonKey(name: 'productDesc')
  String productDesc;

  @JsonKey(name: 'serialNum')
  String serialNum;

  @JsonKey(name: 'callDesc')
  String callDesc;

  @JsonKey(name: 'pickUpTimeStr')
  String pickUpTimeStr;

  @JsonKey(name: 'effectiveStartTimeStr')
  String effectiveStartTimeStr; //送货有效开始时间（订单类型为送货展现）

  @JsonKey(name: 'effectiveEndTimeStr')
  String effectiveEndTimeStr; //送货有效结束时间（订单类型为送货展现）

  @JsonKey(name: 'carrierName')
  String carrierName; //承运商名称（订单类型为送货展现）

  @JsonKey(name: 'supplierName')
  String supplierName; //供应商名称（订单类型为送货展现）

  @JsonKey(name: 'sendProvince')
  String startProvince;

  @JsonKey(name: 'sendCity')
  String startCity;

  @JsonKey(name: 'sendArea')
  String startArea;

  @JsonKey(name: 'sendAddress')
  String startAddress;

  @JsonKey(name: 'receiptProvince')
  String endProvince;

  @JsonKey(name: 'receiptCity')
  String endCity;

  @JsonKey(name: 'receiptArea')
  String endArea;

  @JsonKey(name: 'receiptAddress')
  String endAddress;

  @JsonKey(name: 'scrapType')
  String scrapType; //送货类型 0-原料 1-废钢

  @JsonKey(name: 'laveFactoryTime')
  String laveFactoryTime; //已叫号剩余进厂时间

  TransportDriverInfo(this.id,this.orderNo,this.orderStatus,this.orderType,this.customerId,this.customerName,this.carNo,this.driveMobile,this.pickUpTime,this.effectiveStartTime,this.effectiveEndTime,this.weightAll,this.wayFeeAll,this.originatingAddress,this.destinationAddress,this.productDesc,this.serialNum,this.callDesc,this.pickUpTimeStr,this.effectiveStartTimeStr,this.effectiveEndTimeStr,this.carrierName,this.endCity,this.endArea,this.startArea,this.endProvince,this.startCity,this.startProvince,this.startAddress,this.endAddress,this.scrapType,this.laveFactoryTime,this.supplierName);

  factory TransportDriverInfo.fromJson(Map<String, dynamic> srcJson) => _$TransportDriverInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TransportDriverInfoToJson(this);

}


