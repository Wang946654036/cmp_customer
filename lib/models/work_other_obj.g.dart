// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_other_obj.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkOtherObj _$WorkOtherObjFromJson(Map<String, dynamic> json) {
  return WorkOtherObj(
    (json['appCodes'] as List)?.map((e) => e as String)?.toList(),
    json['code'] as String,
    json['data'] == null
        ? null
        : WorkOther.fromJson(json['data'] as Map<String, dynamic>),
    json['extStr'] as String,
    json['message'] as String,
    json['systemDate'] as String,
    json['totalCount'] as int,
  );
}

Map<String, dynamic> _$WorkOtherObjToJson(WorkOtherObj instance) =>
    <String, dynamic>{
      'appCodes': instance.appCodes,
      'code': instance.code,
      'data': instance.data,
      'extStr': instance.extStr,
      'message': instance.message,
      'systemDate': instance.systemDate,
      'totalCount': instance.totalCount,
    };

WorkOther _$WorkOtherFromJson(Map<String, dynamic> json) {
  return WorkOther(
    appointmentTime: json['appointmentTime'] as String,
    complaintMainCategory: json['complaintMainCategoryName'] as String,
    complaintProperty: json['complaintPropertyName'] as String,
    complaintSubCategory: json['complaintSubCategory'] as String,
    complaintSubCategoryList: (json['complaintSubCategoryNameList'] as List)
        ?.map((e) => e as String)
        ?.toList(),
    createPostId: json['createPostId'] as int,
    createTime: json['createTime'] as String,
    createUserId: json['createUserId'] as int,
    createUserName: json['createUserName'] as String,
    customerAddress: json['customerAddress'] as String,
    customerId: json['customerId'] as int,
    customerName: json['customerName'] as String,
    customerPhone: json['customerPhone'] as String,
    customerType: json['customerType'] as String,
    draftFlag: json['draftFlag'] as String,
    hangUpFlag: json['hangUpFlag'] as String,
    hasAccept: json['hasAccept'] as String,
    hasCancel: json['hasCancel'] as String,
    hasClose: json['hasClose'] as String,
    hasDone: json['hasDone'] as String,
    hasEvaluate: json['hasEvaluate'] as String,
    hasFinish: json['hasFinish'] as String,
    hasImage: json['hasImage'] as String,
    hasPaid: json['hasPaid'] as String,
    hasRework: json['hasRework'] as String,
    hasVoice: json['hasVoice'] as String,
    houseBuildId: json['houseBuildId'] as int,
    houseId: json['houseId'] as int,
    houseName: json['houseName'] as String,
    houseUnitId: json['houseUnitId'] as int,
    mainFlag: json['mainFlag'] as String,
    overtimeFlag: json['overtimeFlag'] as String,
    paidServiceId: json['paidServiceId'] as int,
    paidStyleJson: json['paidStyleJson'] as String,
    paidStyleList:
        (json['paidStyleList'] as List)?.map((e) => e as String)?.toList(),
    processConfId: json['processConfId'] as int,
    processId: json['processId'] as String,
    processKey: json['processKey'] as String,
    processNodeCode: json['processNodeCode'] as String,
    processNodeName: json['processNodeName'] as String,
    processState: json['processState'] as String,
    processStateName: json['processStateName'] as String,
    processTime: json['processTime'] as String,
    projectId: json['projectId'] as int,
    projectName: json['projectName'] as String,
    reportContent: json['reportContent'] as String,
    reportRemarks: json['reportRemarks'] as String,
    reportSourceName: json['reportSourceName'] as String,
    reportSource: json['reportSource'] as String,
    serviceGrade: json['serviceGrade'] as int,
    serviceSubType: json['serviceSubType'] as String,
    serviceSubTypeName: json['serviceSubTypeName'] as String,
    serviceType: json['serviceType'] as String,
    serviceTypeName: json['serviceTypeName'] as String,
    updateTime: json['updateTime'] as String,
    updateUserId: json['updateUserId'] as int,
    updateUserName: json['updateUserName'] as String,
    urgentFlag: json['urgentFlag'] as String,
    urgentLevel: json['urgentLevel'] as String,
    validFlag: json['validFlag'] as String,
    workOrderCode: json['workOrderCode'] as String,
    workOrderId: json['workOrderId'] as int,
    workOrderPhotoList: (json['workOrderPhotoList'] as List)
        ?.map((e) => (e as Map<String, dynamic>)?.map(
              (k, e) => MapEntry(k, e as String),
            ))
        ?.toList(),
    workOrderVoiceList: (json['workOrderVoiceList'] as List)
        ?.map((e) => (e as Map<String, dynamic>)?.map(
              (k, e) => MapEntry(k, e as String),
            ))
        ?.toList(),
    workTaskId: json['workTaskId'] as int,
    materialNameList:
        (json['materialNameList'] as List)?.map((e) => e as String)?.toList(),
    totalLaborFee: (json['totalLaborFee'] as num)?.toDouble(),
    totalMaterialFee: (json['totalMaterialFee'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$WorkOtherToJson(WorkOther instance) => <String, dynamic>{
      'appointmentTime': instance.appointmentTime,
      'complaintMainCategoryName': instance.complaintMainCategory,
      'complaintPropertyName': instance.complaintProperty,
      'complaintSubCategory': instance.complaintSubCategory,
      'complaintSubCategoryNameList': instance.complaintSubCategoryList,
      'createPostId': instance.createPostId,
      'createTime': instance.createTime,
      'createUserId': instance.createUserId,
      'createUserName': instance.createUserName,
      'customerAddress': instance.customerAddress,
      'customerId': instance.customerId,
      'customerName': instance.customerName,
      'customerPhone': instance.customerPhone,
      'customerType': instance.customerType,
      'draftFlag': instance.draftFlag,
      'hangUpFlag': instance.hangUpFlag,
      'hasAccept': instance.hasAccept,
      'hasCancel': instance.hasCancel,
      'hasClose': instance.hasClose,
      'hasDone': instance.hasDone,
      'hasEvaluate': instance.hasEvaluate,
      'hasFinish': instance.hasFinish,
      'hasImage': instance.hasImage,
      'hasPaid': instance.hasPaid,
      'hasRework': instance.hasRework,
      'hasVoice': instance.hasVoice,
      'houseBuildId': instance.houseBuildId,
      'houseId': instance.houseId,
      'houseName': instance.houseName,
      'houseUnitId': instance.houseUnitId,
      'mainFlag': instance.mainFlag,
      'overtimeFlag': instance.overtimeFlag,
      'paidServiceId': instance.paidServiceId,
      'paidStyleJson': instance.paidStyleJson,
      'paidStyleList': instance.paidStyleList,
      'processConfId': instance.processConfId,
      'processId': instance.processId,
      'processKey': instance.processKey,
      'processNodeCode': instance.processNodeCode,
      'processNodeName': instance.processNodeName,
      'processState': instance.processState,
      'processStateName': instance.processStateName,
      'processTime': instance.processTime,
      'projectId': instance.projectId,
      'projectName': instance.projectName,
      'reportContent': instance.reportContent,
      'reportRemarks': instance.reportRemarks,
      'reportSourceName': instance.reportSourceName,
      'reportSource': instance.reportSource,
      'serviceGrade': instance.serviceGrade,
      'serviceSubType': instance.serviceSubType,
      'serviceSubTypeName': instance.serviceSubTypeName,
      'serviceType': instance.serviceType,
      'serviceTypeName': instance.serviceTypeName,
      'updateTime': instance.updateTime,
      'updateUserId': instance.updateUserId,
      'updateUserName': instance.updateUserName,
      'urgentFlag': instance.urgentFlag,
      'urgentLevel': instance.urgentLevel,
      'validFlag': instance.validFlag,
      'workOrderCode': instance.workOrderCode,
      'workOrderId': instance.workOrderId,
      'workOrderPhotoList': instance.workOrderPhotoList,
      'workOrderVoiceList': instance.workOrderVoiceList,
      'workTaskId': instance.workTaskId,
      'materialNameList': instance.materialNameList,
      'totalMaterialFee': instance.totalMaterialFee,
      'totalLaborFee': instance.totalLaborFee,
    };