// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_order_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkOrderVo _$WorkOrderVoFromJson(Map<String, dynamic> json) {
  return WorkOrderVo(
    houseId: json['houseId'] as int,
    buildId: json['buildId'] as int,
    unitId: json['unitId'] as int,
    appointmentTime: json['appointmentTime'] as String,
    complaintMainCategory: json['complaintMainCategory'] as String,
    complaintProperty: json['complaintProperty'] as String,
    complaintSubCategory: json['complaintSubCategory'] as String,
    customerAddress: json['customerAddress'] as String,
    customerId: json['customerId'] as int,
    customerName: json['customerName'] as String,
    customerPhone: json['customerPhone'] as String,
    customerType: json['customerType'] as String,
    draftFlag: json['draftFlag'] as String,
    paidServiceId: json['paidServiceId'] as int,
    paidStyleList:
        (json['paidStyleList'] as List)?.map((e) => e as String)?.toList(),
    projectId: json['projectId'] as int,
    reportContent: json['reportContent'] as String,
    reportRemarks: json['reportRemarks'] as String,
    reportSource: json['reportSource'] as String,
    createSource: json['createSource'] as String,
    serviceSubType: json['serviceSubType'] as String,
    serviceType: json['serviceType'] as String,
    urgentLevel: json['urgentLevel'] as String,
    validFlag: json['validFlag'] as String,
    workOrderId: json['workOrderId'] as int,
    workOrderPhotoList:
        (json['workOrderPhotoList'] as List)?.map((e) => e as String)?.toList(),
    workOrderVoiceList:
        (json['workOrderVoiceList'] as List)?.map((e) => e as String)?.toList(),
    orderCategory: json['orderCategory'] as String,
  );
}

Map<String, dynamic> _$WorkOrderVoToJson(WorkOrderVo instance) =>
    <String, dynamic>{
      'appointmentTime': instance.appointmentTime,
      'complaintMainCategory': instance.complaintMainCategory,
      'complaintProperty': instance.complaintProperty,
      'complaintSubCategory': instance.complaintSubCategory,
      'customerAddress': instance.customerAddress,
      'customerId': instance.customerId,
      'customerName': instance.customerName,
      'customerPhone': instance.customerPhone,
      'customerType': instance.customerType,
      'draftFlag': instance.draftFlag,
      'houseId': instance.houseId,
      'unitId': instance.unitId,
      'buildId': instance.buildId,
      'paidServiceId': instance.paidServiceId,
      'paidStyleList': instance.paidStyleList,
      'projectId': instance.projectId,
      'reportContent': instance.reportContent,
      'reportRemarks': instance.reportRemarks,
      'reportSource': instance.reportSource,
      'createSource': instance.createSource,
      'serviceSubType': instance.serviceSubType,
      'serviceType': instance.serviceType,
      'urgentLevel': instance.urgentLevel,
      'validFlag': instance.validFlag,
      'workOrderId': instance.workOrderId,
      'workOrderPhotoList': instance.workOrderPhotoList,
      'workOrderVoiceList': instance.workOrderVoiceList,
      'orderCategory': instance.orderCategory,
    };
