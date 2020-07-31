// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_card_history_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingCardHistoryRequest _$ParkingCardHistoryRequestFromJson(
    Map<String, dynamic> json) {
  return ParkingCardHistoryRequest(
    carNos: (json['carNos'] as List)?.map((e) => e as String)?.toList(),
    customerId: json['customerId'] as int,
    endTime: json['endTime'] as String,
    searchKey: json['searchKey'] as String,
    startTime: json['startTime'] as String,
    types: (json['types'] as List)?.map((e) => e as String)?.toList(),
  )
    ..pageSize = json['pageSize'] as int
    ..current = json['current'] as int
    ..projectId = json['projectId'] as int;
}

Map<String, dynamic> _$ParkingCardHistoryRequestToJson(
        ParkingCardHistoryRequest instance) =>
    <String, dynamic>{
      'pageSize': instance.pageSize,
      'current': instance.current,
      'carNos': instance.carNos,
      'customerId': instance.customerId,
      'endTime': instance.endTime,
      'searchKey': instance.searchKey,
      'startTime': instance.startTime,
      'types': instance.types,
      'projectId': instance.projectId,
    };
