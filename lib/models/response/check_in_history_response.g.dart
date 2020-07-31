// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_in_history_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckInHistoryResponse _$CheckInHistoryResponseFromJson(
    Map<String, dynamic> json) {
  return CheckInHistoryResponse()
    ..code = json['code'] as String
    ..message = json['message'] as String
    ..historyList = (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : CheckInHistory.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$CheckInHistoryResponseToJson(
        CheckInHistoryResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.historyList,
    };

CheckInHistory _$CheckInHistoryFromJson(Map<String, dynamic> json) {
  return CheckInHistory(
    json['bookReprocessTime'] as String,
    json['businessNo'] as String,
    json['createTime'] as String,
    json['customerName'] as String,
    json['customerPhone'] as String,
    json['enterType'] as String,
    json['houseNo'] as String,
    json['projectName'] as String,
    json['rentType'] as String,
    json['rentersName'] as String,
    json['rentingEnterId'] as int,
    json['status'] as String,
    json['updateTime'] as String,
  );
}

Map<String, dynamic> _$CheckInHistoryToJson(CheckInHistory instance) =>
    <String, dynamic>{
      'bookReprocessTime': instance.bookReprocessTime,
      'businessNo': instance.businessNo,
      'createTime': instance.createTime,
      'customerName': instance.customerName,
      'customerPhone': instance.customerPhone,
      'enterType': instance.enterType,
      'houseNo': instance.houseNo,
      'projectName': instance.projectName,
      'rentType': instance.rentType,
      'rentersName': instance.rentersName,
      'rentingEnterId': instance.rentingEnterId,
      'status': instance.status,
      'updateTime': instance.updateTime,
    };
