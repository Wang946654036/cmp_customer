// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transport_driver_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransportDriverModel _$TransportDriverModelFromJson(Map<String, dynamic> json) {
  return TransportDriverModel(
    json['code'] as String,
    json['message'] as String,
    json['systemDate'] as String,
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : TransportDriverInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TransportDriverModelToJson(
        TransportDriverModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'systemDate': instance.systemDate,
      'data': instance.transportDriverList,
    };

TransportDriverInfo _$TransportDriverInfoFromJson(Map<String, dynamic> json) {
  return TransportDriverInfo(
    json['id'] as int,
    json['orderNo'] as String,
    json['orderStatus'] as String,
    json['orderType'] as String,
    json['customerId'] as String,
    json['customerName'] as String,
    json['carNo'] as String,
    json['driveMobile'] as String,
    json['pickUpTime'] as String,
    json['effectiveStartTime'] as String,
    json['effectiveEndTime'] as String,
    (json['weightAll'] as num)?.toDouble(),
    (json['wayFeeAll'] as num)?.toDouble(),
    json['originatingAddress'] as String,
    json['destinationAddress'] as String,
    json['productDesc'] as String,
    json['serialNum'] as String,
    json['callDesc'] as String,
    json['pickUpTimeStr'] as String,
    json['effectiveStartTimeStr'] as String,
    json['effectiveEndTimeStr'] as String,
    json['carrierName'] as String,
    json['receiptCity'] as String,
    json['receiptArea'] as String,
    json['sendArea'] as String,
    json['receiptProvince'] as String,
    json['sendCity'] as String,
    json['sendProvince'] as String,
    json['sendAddress'] as String,
    json['receiptAddress'] as String,
    json['scrapType'] as String,
    json['laveFactoryTime'] as String,
    json['supplierName'] as String,
  );
}

Map<String, dynamic> _$TransportDriverInfoToJson(
        TransportDriverInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderNo': instance.orderNo,
      'orderStatus': instance.orderStatus,
      'orderType': instance.orderType,
      'customerId': instance.customerId,
      'customerName': instance.customerName,
      'carNo': instance.carNo,
      'driveMobile': instance.driveMobile,
      'pickUpTime': instance.pickUpTime,
      'effectiveStartTime': instance.effectiveStartTime,
      'effectiveEndTime': instance.effectiveEndTime,
      'weightAll': instance.weightAll,
      'wayFeeAll': instance.wayFeeAll,
      'originatingAddress': instance.originatingAddress,
      'destinationAddress': instance.destinationAddress,
      'productDesc': instance.productDesc,
      'serialNum': instance.serialNum,
      'callDesc': instance.callDesc,
      'pickUpTimeStr': instance.pickUpTimeStr,
      'effectiveStartTimeStr': instance.effectiveStartTimeStr,
      'effectiveEndTimeStr': instance.effectiveEndTimeStr,
      'carrierName': instance.carrierName,
      'supplierName': instance.supplierName,
      'sendProvince': instance.startProvince,
      'sendCity': instance.startCity,
      'sendArea': instance.startArea,
      'sendAddress': instance.startAddress,
      'receiptProvince': instance.endProvince,
      'receiptCity': instance.endCity,
      'receiptArea': instance.endArea,
      'receiptAddress': instance.endAddress,
      'scrapType': instance.scrapType,
      'laveFactoryTime': instance.laveFactoryTime,
    };
