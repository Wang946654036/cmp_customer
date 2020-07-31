// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_card_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingCardDetailsResponse _$ParkingCardDetailsResponseFromJson(
    Map<String, dynamic> json) {
  return ParkingCardDetailsResponse(
    parkingCardDetailsInfo: json['data'] == null
        ? null
        : ParkingCardDetailsInfo.fromJson(json['data'] as Map<String, dynamic>),
  )
    ..code = json['code'] as String
    ..message = json['message'] as String;
}

Map<String, dynamic> _$ParkingCardDetailsResponseToJson(
        ParkingCardDetailsResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.parkingCardDetailsInfo,
    };

ParkingCardDetailsInfo _$ParkingCardDetailsInfoFromJson(
    Map<String, dynamic> json) {
  return ParkingCardDetailsInfo(
    parkingId: json['parkingId'] as int,
    projectId: json['projectId'] as int,
    buildId: json['buildId'] as int,
    unitId: json['unitId'] as int,
    houseId: json['houseId'] as int,
    houseNo: json['houseNo'] as String,
    type: json['type'] as String,
    businessNo: json['businessNo'] as String,
    parkingLotId: json['parkingLotId'] as int,
    parkingLot: json['parkingLot'] as String,
    parkingPackageId: json['parkingPackageId'] as int,
    parkingPackage: json['parkingPackage'] as String,
    carNo: json['carNo'] as String,
    carBrand: json['carBrand'] as String,
    carColor: json['carColor'] as String,
    carOwnerName: json['carOwnerName'] as String,
    carOwnerPhone: json['carOwnerPhone'] as String,
    applyMonths: json['applyMonths'] as int,
    payFees: (json['payFees'] as num)?.toDouble(),
    customerId: json['customerId'] as int,
    customerName: json['customerName'] as String,
    customerPhone: json['customerPhone'] as String,
    status: json['status'] as String,
    remark: json['remark'] as String,
    registerTime: json['registerTime'] as String,
    updateTime: json['updateTime'] as String,
    cancelEndTime: json['cancelEndTime'] as String,
    recordList: (json['recordList'] as List)
        ?.map((e) =>
            e == null ? null : RecordList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    effectTime: json['effectTime'] as String,
  )
    ..parkingInfoId = json['parkingInfoId'] as int
    ..paybackFees = (json['paybackFees'] as num)?.toDouble()
    ..statusDesc = json['statusDesc'] as String
    ..createTime = json['createTime'] as String
    ..payTime = json['payTime'] as String
    ..payType = json['payType'] as String
    ..formerStartTime = json['formerStartTime'] as String
    ..formerEndTime = json['formerEndTime'] as String
    ..validStartTime = json['validStartTime'] as String
    ..validEndTime = json['validEndTime'] as String
    ..attList = (json['attList'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$ParkingCardDetailsInfoToJson(
        ParkingCardDetailsInfo instance) =>
    <String, dynamic>{
      'parkingId': instance.parkingId,
      'parkingInfoId': instance.parkingInfoId,
      'projectId': instance.projectId,
      'buildId': instance.buildId,
      'unitId': instance.unitId,
      'houseId': instance.houseId,
      'houseNo': instance.houseNo,
      'type': instance.type,
      'businessNo': instance.businessNo,
      'parkingLotId': instance.parkingLotId,
      'parkingLot': instance.parkingLot,
      'parkingPackageId': instance.parkingPackageId,
      'parkingPackage': instance.parkingPackage,
      'carNo': instance.carNo,
      'carBrand': instance.carBrand,
      'carColor': instance.carColor,
      'carOwnerName': instance.carOwnerName,
      'carOwnerPhone': instance.carOwnerPhone,
      'applyMonths': instance.applyMonths,
      'payFees': instance.payFees,
      'paybackFees': instance.paybackFees,
      'customerId': instance.customerId,
      'customerName': instance.customerName,
      'customerPhone': instance.customerPhone,
      'status': instance.status,
      'statusDesc': instance.statusDesc,
      'remark': instance.remark,
      'createTime': instance.createTime,
      'registerTime': instance.registerTime,
      'updateTime': instance.updateTime,
      'payTime': instance.payTime,
      'payType': instance.payType,
      'effectTime': instance.effectTime,
      'formerStartTime': instance.formerStartTime,
      'formerEndTime': instance.formerEndTime,
      'validStartTime': instance.validStartTime,
      'validEndTime': instance.validEndTime,
      'cancelEndTime': instance.cancelEndTime,
      'recordList': instance.recordList,
      'attList': instance.attList,
    };

RecordList _$RecordListFromJson(Map<String, dynamic> json) {
  return RecordList(
    json['recordId'] as int,
    json['parkingId'] as int,
    json['attachmentFlag'] as String,
    json['status'] as String,
    json['creatorId'] as int,
    json['creator'] as String,
    json['createTime'] as String,
    (json['attList'] as List)
        ?.map((e) =>
            e == null ? null : AttList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['remark'] as String,
    json['operateStep'] as String,
  )
    ..operateStepDesc = json['operateStepDesc'] as String
    ..statusDesc = json['statusDesc'] as String;
}

Map<String, dynamic> _$RecordListToJson(RecordList instance) =>
    <String, dynamic>{
      'recordId': instance.recordId,
      'parkingId': instance.parkingId,
      'attachmentFlag': instance.attachmentFlag,
      'operateStep': instance.operateStep,
      'operateStepDesc': instance.operateStepDesc,
      'statusDesc': instance.statusDesc,
      'status': instance.status,
      'creatorId': instance.creatorId,
      'creator': instance.creator,
      'createTime': instance.createTime,
      'remark': instance.remark,
      'attList': instance.attList,
    };

AttList _$AttListFromJson(Map<String, dynamic> json) {
  return AttList(
    json['id'] as int,
    json['source'] as String,
    json['type'] as String,
    json['relatedId'] as int,
    json['attachmentUuid'] as String,
    json['status'] as String,
    json['createTime'] as String,
  );
}

Map<String, dynamic> _$AttListToJson(AttList instance) => <String, dynamic>{
      'id': instance.id,
      'source': instance.source,
      'type': instance.type,
      'relatedId': instance.relatedId,
      'attachmentUuid': instance.attachmentUuid,
      'status': instance.status,
      'createTime': instance.createTime,
    };
