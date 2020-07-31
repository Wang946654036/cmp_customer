// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reserve_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReserveInfo _$ReserveInfoFromJson(Map<String, dynamic> json) {
  return ReserveInfo(
    orderDates: json['orderDates'] as String,
    meetingRoomName: json['meetingRoomName'] as String,
    actualPay: (json['actualPay'] as num)?.toDouble(),
    applicantName: json['applicantName'] as String,
    applicatMobile: json['applicatMobile'] as String,
    confirmCost: (json['confirmCost'] as num)?.toDouble(),
    createTime: json['createTime'] as String,
    creatorId: json['creatorId'] as int,
    estimatedCost: (json['estimatedCost'] as num)?.toDouble(),
    estimatedDetail: json['estimatedDetail'] as String,
    meetingSubOrderVoList: (json['meetingSubOrderVoList'] as List)
        ?.map((e) => e == null
            ? null
            : MeetingRoomInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    orderCode: json['orderCode'] as String,
    orderId: json['orderId'] as int,
    orgId: json['orgId'] as int,
    projectId: json['projectId'] as int,
    state: json['state'] as String,
    stateName: json['stateName'] as String,
    updateTime: json['updateTime'] as String,
    acceptRemark: json['acceptRemark'] as String,
    payRemark: json['payRemark'] as String,
    updaterId: json['updaterId'] as int,
    payPhotoList: (json['payPhotoList'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ReserveInfoToJson(ReserveInfo instance) =>
    <String, dynamic>{
      'actualPay': instance.actualPay,
      'applicantName': instance.applicantName,
      'applicatMobile': instance.applicatMobile,
      'confirmCost': instance.confirmCost,
      'createTime': instance.createTime,
      'acceptRemark': instance.acceptRemark,
      'payRemark': instance.payRemark,
      'creatorId': instance.creatorId,
      'estimatedCost': instance.estimatedCost,
      'estimatedDetail': instance.estimatedDetail,
      'orderCode': instance.orderCode,
      'orderId': instance.orderId,
      'orgId': instance.orgId,
      'projectId': instance.projectId,
      'state': instance.state,
      'stateName': instance.stateName,
      'updateTime': instance.updateTime,
      'updaterId': instance.updaterId,
      'meetingRoomName': instance.meetingRoomName,
      'orderDates': instance.orderDates,
      'meetingSubOrderVoList': instance.meetingSubOrderVoList,
      'payPhotoList': instance.payPhotoList,
    };
