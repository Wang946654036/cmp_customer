import 'package:json_annotation/json_annotation.dart'; 
  
part 'parking_card_apply_response.g.dart';


@JsonSerializable()
  class ParkingCardApplyResponse extends Object {

  @JsonKey(name: 'applyMonths')
  int applyMonths;//申请时长（创建时必填）

  @JsonKey(name: 'buildId')
  int buildId; //楼栋id（创建时必填）

  @JsonKey(name: 'cancelEndTime')
  String cancelEndTime;//提前终止日期（创建-退租时必填）

  @JsonKey(name: 'carBrand')
  String carBrand;//车辆品牌

  @JsonKey(name: 'carColor')
  String carColor;//车辆颜色

  @JsonKey(name: 'carNo')
  String carNo;//车牌号（创建时必填）

  @JsonKey(name: 'carOwnerName')
  String carOwnerName;//车主姓名（创建时必填）

  @JsonKey(name: 'carOwnerPhone')
  String carOwnerPhone;//车主电话（创建时必填）

  @JsonKey(name: 'customerId')
  int customerId;//申请人id（创建时必填）

  @JsonKey(name: 'customerName')
  String customerName;//申请人姓名（创建时必填）

  @JsonKey(name: 'customerPhone')
  String customerPhone;//申请人电话（创建时必填）

  @JsonKey(name: 'driveLicencePhotoList')
  List<String> driveLicencePhotoList;//行驶证图片UUID列表

  @JsonKey(name: 'parkingId')
  int parkingId;//停车办理业务id（编辑时必填）

  @JsonKey(name: 'parkingLot')
  String parkingLot;//停车场名称（创建时必填）

  @JsonKey(name: 'parkingLotId')
  int parkingLotId;//停车场id（创建时必填）

  @JsonKey(name: 'parkingPackage')
  String parkingPackage;//停车场套餐（创建时必填）

  @JsonKey(name: 'parkingPackageId')
  int parkingPackageId;//停车套餐id（创建时必填）

  @JsonKey(name: 'payFees')
  int payFees;//支付金额（创建-新卡申请、续费时必填）

  @JsonKey(name: 'projectId')
  int projectId;//项目id（创建时必填）

  @JsonKey(name: 'remark')
  String remark;//备注

  @JsonKey(name: 'houseId')
  String houseId;//房屋id

  @JsonKey(name: 'houseNo')
  String houseNo;//房屋号（创建时必填）

  @JsonKey(name: 'type')
  String type;//办理类型：XKSQ-新卡申请、XF-续费、TZ-退租

  @JsonKey(name: 'unitId')
  int unitId;//单元id（创建时必填）

  ParkingCardApplyResponse(this.applyMonths,this.buildId,this.cancelEndTime,this.carBrand,this.carColor,this.carNo,this.carOwnerName,this.carOwnerPhone,this.customerId,this.customerName,this.customerPhone,this.driveLicencePhotoList,this.parkingId,this.parkingLot,this.parkingLotId,this.parkingPackage,this.parkingPackageId,this.payFees,this.projectId,this.remark,this.houseId,this.houseNo,this.type,this.unitId,);

  factory ParkingCardApplyResponse.fromJson(Map<String, dynamic> srcJson) => _$ParkingCardApplyResponseFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ParkingCardApplyResponseToJson(this);

}

  
