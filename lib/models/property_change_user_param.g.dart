// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property_change_user_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PropertyChangeUserParam _$PropertyChangeUserParamFromJson(
    Map<String, dynamic> json) {
  return PropertyChangeUserParam(
    custId: json['custId'] as int,
    assigneePhone: json['assigneePhone'] as String,
    assigneeRealname: json['assigneeRealname'] as String,
    buildId: json['buildId'] as int,
    businessNo: json['businessNo'] as String,
    current: json['current'] as int,
    currentUser: json['currentUser'] as int,
    customerName: json['customerName'] as String,
    customerPhone: json['customerPhone'] as String,
    endTime: json['endTime'] as String,
    houseId: json['houseId'] as int,
    houseNo: json['houseNo'] as String,
    pageSize: json['pageSize'] as int,
    projectIds: (json['projectIds'] as List)?.map((e) => e as int)?.toList(),
    queryType: json['queryType'] as String,
    startTime: json['startTime'] as String,
    status: json['status'] as String,
    unitId: json['unitId'] as int,
    operationCust: json['operationCust'] as int,
  );
}

Map<String, dynamic> _$PropertyChangeUserParamToJson(
        PropertyChangeUserParam instance) =>
    <String, dynamic>{
      'assigneePhone': instance.assigneePhone,
      'assigneeRealname': instance.assigneeRealname,
      'buildId': instance.buildId,
      'businessNo': instance.businessNo,
      'current': instance.current,
      'currentUser': instance.currentUser,
      'customerName': instance.customerName,
      'customerPhone': instance.customerPhone,
      'endTime': instance.endTime,
      'houseId': instance.houseId,
      'houseNo': instance.houseNo,
      'pageSize': instance.pageSize,
      'projectIds': instance.projectIds,
      'queryType': instance.queryType,
      'startTime': instance.startTime,
      'status': instance.status,
      'unitId': instance.unitId,
      'custId': instance.custId,
      'operationCust': instance.operationCust,
    };
