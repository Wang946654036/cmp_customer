// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_card_apply_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingCardApplyResponse _$ParkingCardApplyResponseFromJson(
    Map<String, dynamic> json) {
  return ParkingCardApplyResponse(
    json['applyMonths'] as int,
    json['buildId'] as int,
    json['cancelEndTime'] as String,
    json['carBrand'] as String,
    json['carColor'] as String,
    json['carNo'] as String,
    json['carOwnerName'] as String,
    json['carOwnerPhone'] as String,
    json['customerId'] as int,
    json['customerName'] as String,
    json['customerPhone'] as String,
    (json['driveLicencePhotoList'] as List)?.map((e) => e as String)?.toList(),
    json['parkingId'] as int,
    json['parkingLot'] as String,
    json['parkingLotId'] as int,
    json['parkingPackage'] as String,
    json['parkingPackageId'] as int,
    json['payFees'] as int,
    json['projectId'] as int,
    json['remark'] as String,
    json['houseId'] as String,
    json['houseNo'] as String,
    json['type'] as String,
    json['unitId'] as int,
  );
}

Map<String, dynamic> _$ParkingCardApplyResponseToJson(
        ParkingCardApplyResponse instance) =>
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
      'driveLicencePhotoList': instance.driveLicencePhotoList,
      'parkingId': instance.parkingId,
      'parkingLot': instance.parkingLot,
      'parkingLotId': instance.parkingLotId,
      'parkingPackage': instance.parkingPackage,
      'parkingPackageId': instance.parkingPackageId,
      'payFees': instance.payFees,
      'projectId': instance.projectId,
      'remark': instance.remark,
      'houseId': instance.houseId,
      'houseNo': instance.houseNo,
      'type': instance.type,
      'unitId': instance.unitId,
    };
