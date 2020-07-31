// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_card_apply_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingCardApplyRequest _$ParkingCardApplyRequestFromJson(
    Map<String, dynamic> json) {
  return ParkingCardApplyRequest(
    applyMonths: json['applyMonths'] as int,
    buildId: json['buildId'] as int,
    cancelEndTime: json['cancelEndTime'] as String,
    carBrand: json['carBrand'] as String,
    carColor: json['carColor'] as String,
    carNo: json['carNo'] as String,
    carOwnerName: json['carOwnerName'] as String,
    carOwnerPhone: json['carOwnerPhone'] as String,
    customerId: json['customerId'] as int,
    customerName: json['customerName'] as String,
    customerPhone: json['customerPhone'] as String,
    attList: (json['attList'] as List)?.map((e) => e as String)?.toList(),
    parkingId: json['parkingId'] as int,
    parkingLot: json['parkingLot'] as String,
    parkingLotId: json['parkingLotId'] as int,
    parkingPackage: json['parkingPackage'] as String,
    parkingPackageId: json['parkingPackageId'] as int,
    oldParkingId: json['oldParkingId'] as int,
    payFees: (json['payFees'] as num)?.toDouble(),
    projectId: json['projectId'] as int,
    remark: json['remark'] as String,
    houseNo: json['houseNo'] as String,
    type: json['type'] as String,
    unitId: json['unitId'] as int,
    houseId: json['houseId'] as int,
  )..parkingInfoId = json['parkingInfoId'] as int;
}

Map<String, dynamic> _$ParkingCardApplyRequestToJson(
        ParkingCardApplyRequest instance) =>
    <String, dynamic>{
      'applyMonths': instance.applyMonths,
      'buildId': instance.buildId,
      'cancelEndTime': instance.cancelEndTime,
      'carBrand': instance.carBrand,
      'carColor': instance.carColor,
      'carNo': instance.carNo,
      'carOwnerName': instance.carOwnerName,
      'carOwnerPhone': instance.carOwnerPhone,
      'customerId': instance.customerId,
      'customerName': instance.customerName,
      'customerPhone': instance.customerPhone,
      'attList': instance.attList,
      'parkingId': instance.parkingId,
      'parkingInfoId': instance.parkingInfoId,
      'oldParkingId': instance.oldParkingId,
      'parkingLot': instance.parkingLot,
      'parkingLotId': instance.parkingLotId,
      'parkingPackage': instance.parkingPackage,
      'parkingPackageId': instance.parkingPackageId,
      'payFees': instance.payFees,
      'projectId': instance.projectId,
      'remark': instance.remark,
      'houseNo': instance.houseNo,
      'houseId': instance.houseId,
      'type': instance.type,
      'unitId': instance.unitId,
    };
