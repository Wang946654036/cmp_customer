// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'process_sub_node_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProcessSubNodeList _$ProcessSubNodeListFromJson(Map<String, dynamic> json) {
  return ProcessSubNodeList(
    (json['appCodes'] as List)?.map((e) => e as String)?.toList(),
    json['code'] as String,
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : ProcessSubNode.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['extStr'] as String,
    json['message'] as String,
    json['systemDate'] as String,
    json['totalCount'] as int,
  );
}

Map<String, dynamic> _$ProcessSubNodeListToJson(ProcessSubNodeList instance) =>
    <String, dynamic>{
      'appCodes': instance.appCodes,
      'code': instance.code,
      'data': instance.data,
      'extStr': instance.extStr,
      'message': instance.message,
      'systemDate': instance.systemDate,
      'totalCount': instance.totalCount,
    };

ProcessSubNode _$ProcessSubNodeFromJson(Map<String, dynamic> json) {
  return ProcessSubNode(
    json['nodeCode'] as String,
    json['nodeCodeName'] as String,
    json['nodeId'] as int,
    json['parentNodeId'] as int,
    json['processContent'] as String,
    json['processPostId'] as int,
    json['processTime'] as String,
    json['processUserId'] as int,
    json['processUserName'] as String,
    json['workOrderId'] as int,
    (json['laborFee'] as num)?.toDouble(),
    (json['materialFee'] as num)?.toDouble(),
    (json['materialNameList'] as List)?.map((e) => e as String)?.toList(),
    (json['payPrice'] as num)?.toDouble(),
    json['payType'] as String,
  );
}

Map<String, dynamic> _$ProcessSubNodeToJson(ProcessSubNode instance) =>
    <String, dynamic>{
      'nodeCode': instance.nodeCode,
      'nodeCodeName': instance.nodeCodeName,
      'nodeId': instance.nodeId,
      'parentNodeId': instance.parentNodeId,
      'processContent': instance.processContent,
      'processPostId': instance.processPostId,
      'processTime': instance.processTime,
      'processUserId': instance.processUserId,
      'processUserName': instance.processUserName,
      'workOrderId': instance.workOrderId,
      'materialNameList': instance.materialNameList,
      'materialFee': instance.materialFee,
      'laborFee': instance.laborFee,
      'payPrice': instance.payPrice,
      'payType': instance.payType,
    };
