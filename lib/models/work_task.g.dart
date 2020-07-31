// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkTask _$WorkTaskFromJson(Map<String, dynamic> json) {
  return WorkTask(
    analysis: json['analysis'] as String,
    carbonCopyList:
        (json['carbonCopyList'] as List)?.map((e) => e as int)?.toList(),
    communication: json['communication'] as String,
    complaintMainCategory: json['complaintMainCategory'] as String,
    complaintProperty: json['complaintProperty'] as String,
    complaintSubCategoryList: (json['complaintSubCategoryList'] as List)
        ?.map((e) => e as String)
        ?.toList(),
    cooperationUserId:
        (json['cooperationUserId'] as List)?.map((e) => e as int)?.toList(),
    dispatchPostId: json['dispatchPostId'] as int,
    dispatchUserId: json['dispatchUserId'] as int,
    passFlag: json['passFlag'] as String,
    payPrice: json['payPrice'] as int,
    payType: json['payType'] as String,
    processAction: json['processAction'] as String,
    processContent: json['processContent'] as String,
    processNodePhotoList: (json['processNodePhotoList'] as List)
        ?.map((e) => e as String)
        ?.toList(),
    processNodeVoiceList: (json['processNodeVoiceList'] as List)
        ?.map((e) => e as String)
        ?.toList(),
    processRemarks: json['processRemarks'] as String,
    selectTime: json['selectTime'] as String,
    serviceGrade: json['serviceGrade'] as int,
    serviceSubType: json['serviceSubType'] as String,
    urgentLevel: json['urgentLevel'] as String,
    validFlag: json['validFlag'] as String,
    workOrderId: json['workOrderId'] as int,
    workTaskId: json['workTaskId'] as int,
  );
}

Map<String, dynamic> _$WorkTaskToJson(WorkTask instance) => <String, dynamic>{
      'analysis': instance.analysis,
      'carbonCopyList': instance.carbonCopyList,
      'communication': instance.communication,
      'complaintMainCategory': instance.complaintMainCategory,
      'complaintProperty': instance.complaintProperty,
      'complaintSubCategoryList': instance.complaintSubCategoryList,
      'cooperationUserId': instance.cooperationUserId,
      'dispatchPostId': instance.dispatchPostId,
      'dispatchUserId': instance.dispatchUserId,
      'passFlag': instance.passFlag,
      'payPrice': instance.payPrice,
      'payType': instance.payType,
      'processAction': instance.processAction,
      'processContent': instance.processContent,
      'processNodePhotoList': instance.processNodePhotoList,
      'processNodeVoiceList': instance.processNodeVoiceList,
      'processRemarks': instance.processRemarks,
      'selectTime': instance.selectTime,
      'serviceGrade': instance.serviceGrade,
      'serviceSubType': instance.serviceSubType,
      'urgentLevel': instance.urgentLevel,
      'validFlag': instance.validFlag,
      'workOrderId': instance.workOrderId,
      'workTaskId': instance.workTaskId,
    };
