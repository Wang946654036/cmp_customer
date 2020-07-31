// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'process_main_node_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProcessMainNodeList _$ProcessMainNodeListFromJson(Map<String, dynamic> json) {
  return ProcessMainNodeList(
    appCodes: (json['appCodes'] as List)?.map((e) => e as String)?.toList(),
    code: json['code'] as String,
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : ProcessMainNode.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    extStr: json['extStr'] as String,
    message: json['message'] as String,
    systemDate: json['systemDate'] as String,
    totalCount: json['totalCount'] as int,
  );
}

Map<String, dynamic> _$ProcessMainNodeListToJson(
        ProcessMainNodeList instance) =>
    <String, dynamic>{
      'appCodes': instance.appCodes,
      'code': instance.code,
      'data': instance.data,
      'extStr': instance.extStr,
      'message': instance.message,
      'systemDate': instance.systemDate,
      'totalCount': instance.totalCount,
    };

ProcessMainNode _$ProcessMainNodeFromJson(Map<String, dynamic> json) {
  return ProcessMainNode(
    complaintMainCategory: json['complaintMainCategory'] as String,
    complaintProperty: json['complaintPropertyName'] as String,
    complaintSubCategory: (json['complaintSubCategoryList'] as List)
        ?.map((e) => e as String)
        ?.toList(),
    customerName: json['customerName'] as String,
    dispatchPostName: json['dispatchPostName'] as String,
    dispatchUserName: json['dispatchUserName'] as String,
    hasImage: json['hasImage'] as String,
    hasVoice: json['hasVoice'] as String,
    nodeCode: json['nodeCode'] as String,
    nodeId: json['nodeId'] as int,
    passFlag: json['passFlag'] as String,
    payPrice: (json['payPrice'] as num)?.toDouble(),
    payType: json['payType'] as String,
    processContent: json['processContent'] as String,
    processExecutor: json['processExecutor'] as String,
    processId: json['processId'] as String,
    processNodeName: json['processNodeName'] as String,
    processPostId: json['processPostId'] as int,
    processRemarks: json['processRemarks'] as String,
    processTime: json['processTime'] as String,
    processUserId: json['processUserId'] as int,
    processUserName: json['processUserName'] as String,
    serviceGrade: json['serviceGrade'] as int,
    serviceSubType: json['serviceSubType'] as String,
    subNodeList: (json['subNodeList'] as List)
        ?.map((e) => e == null
            ? null
            : ProcessSubNode.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    urgentLevel: json['urgentLevel'] as String,
    validFlag: json['validFlag'] as String,
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
    materialNameList:
        (json['materialNameList'] as List)?.map((e) => e as String)?.toList(),
    materialFee: (json['materialFee'] as num)?.toDouble(),
    laborFee: (json['laborFee'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$ProcessMainNodeToJson(ProcessMainNode instance) =>
    <String, dynamic>{
      'complaintMainCategory': instance.complaintMainCategory,
      'complaintPropertyName': instance.complaintProperty,
      'complaintSubCategoryList': instance.complaintSubCategory,
      'customerName': instance.customerName,
      'dispatchPostName': instance.dispatchPostName,
      'dispatchUserName': instance.dispatchUserName,
      'hasImage': instance.hasImage,
      'hasVoice': instance.hasVoice,
      'nodeCode': instance.nodeCode,
      'nodeId': instance.nodeId,
      'passFlag': instance.passFlag,
      'payPrice': instance.payPrice,
      'payType': instance.payType,
      'processContent': instance.processContent,
      'processExecutor': instance.processExecutor,
      'processId': instance.processId,
      'processNodeName': instance.processNodeName,
      'processPostId': instance.processPostId,
      'processRemarks': instance.processRemarks,
      'processTime': instance.processTime,
      'processUserId': instance.processUserId,
      'processUserName': instance.processUserName,
      'serviceGrade': instance.serviceGrade,
      'serviceSubType': instance.serviceSubType,
      'subNodeList': instance.subNodeList,
      'urgentLevel': instance.urgentLevel,
      'validFlag': instance.validFlag,
      'workOrderId': instance.workOrderId,
      'workOrderPhotoList': instance.workOrderPhotoList,
      'workOrderVoiceList': instance.workOrderVoiceList,
      'materialNameList': instance.materialNameList,
      'materialFee': instance.materialFee,
      'laborFee': instance.laborFee,
    };
