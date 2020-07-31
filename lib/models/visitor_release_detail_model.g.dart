// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visitor_release_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisitorReleaseDetailModel _$VisitorReleaseDetailModelFromJson(
    Map<String, dynamic> json) {
  return VisitorReleaseDetailModel(
    appCodes: (json['appCodes'] as List)?.map((e) => e as String)?.toList(),
    code: json['code'] as String,
    data: json['data'] == null
        ? null
        : VisitorReleaseDetail.fromJson(json['data'] as Map<String, dynamic>),
    extStr: json['extStr'] as String,
    message: json['message'] as String,
    systemDate: json['systemDate'] as String,
    totalCount: json['totalCount'] as int,
  );
}

Map<String, dynamic> _$VisitorReleaseDetailModelToJson(
        VisitorReleaseDetailModel instance) =>
    <String, dynamic>{
      'appCodes': instance.appCodes,
      'code': instance.code,
      'data': instance.data,
      'extStr': instance.extStr,
      'message': instance.message,
      'systemDate': instance.systemDate,
      'totalCount': instance.totalCount,
    };

VisitorReleaseDetail _$VisitorReleaseDetailFromJson(Map<String, dynamic> json) {
  return VisitorReleaseDetail(
    appointmentVisitId: json['appointmentVisitId'] as int,
    oddNumber: json['oddNumber'] as String,
    state: json['state'] as String,
    stateName: json['stateName'] as String,
    acceptRemark: json['acceptRemark'] as String,
    applyType: json['applyType'] as String,
    houseId: json['houseId'] as int,
    custName: json['custName'] as String,
    custPhone: json['custPhone'] as String,
    visitReason: json['visitReason'] as String,
    visitDate: json['visitDate'] as String,
    effective: json['effective'] as int,
    visitorName: json['visitorName'] as String,
    visitorPhone: json['visitorPhone'] as String,
    paperType: json['paperType'] as String,
    paperNumber: json['paperNumber'] as String,
    driveCar: json['driveCar'] as int,
    carNumber: json['carNumber'] as String,
    visitNum: json['visitNum'] as int,
    remark: json['remark'] as String,
    qrCodeUuid: json['qrCodeUuid'] as String,
    isPassedFromCust: json['isPassedFromCust'] as int,
    projectId: json['projectId'] as int,
    projectName: json['projectName'] as String,
    projectFormerName: json['projectFormerName'] as String,
    houseName: json['houseName'] as String,
    buildName: json['buildName'] as String,
    buildId: json['buildId'] as int,
    unitName: json['unitName'] as String,
    unitId: json['unitId'] as int,
    createTime: json['createTime'] as String,
    isPassed: json['isPassed'] as int,
    opinion: json['opinion'] as String,
    beginTime: json['passBeginTime'] as String,
    endTime: json['passEndTime'] as String,
  )..maxEffective = json['maxEffective'] as int;
}

Map<String, dynamic> _$VisitorReleaseDetailToJson(
        VisitorReleaseDetail instance) =>
    <String, dynamic>{
      'appointmentVisitId': instance.appointmentVisitId,
      'oddNumber': instance.oddNumber,
      'state': instance.state,
      'stateName': instance.stateName,
      'acceptRemark': instance.acceptRemark,
      'applyType': instance.applyType,
      'houseId': instance.houseId,
      'custName': instance.custName,
      'custPhone': instance.custPhone,
      'visitReason': instance.visitReason,
      'visitDate': instance.visitDate,
      'effective': instance.effective,
      'maxEffective': instance.maxEffective,
      'visitorName': instance.visitorName,
      'visitorPhone': instance.visitorPhone,
      'paperType': instance.paperType,
      'paperNumber': instance.paperNumber,
      'driveCar': instance.driveCar,
      'carNumber': instance.carNumber,
      'visitNum': instance.visitNum,
      'remark': instance.remark,
      'qrCodeUuid': instance.qrCodeUuid,
      'isPassedFromCust': instance.isPassedFromCust,
      'projectId': instance.projectId,
      'projectName': instance.projectName,
      'projectFormerName': instance.projectFormerName,
      'houseName': instance.houseName,
      'buildName': instance.buildName,
      'buildId': instance.buildId,
      'unitName': instance.unitName,
      'unitId': instance.unitId,
      'createTime': instance.createTime,
      'isPassed': instance.isPassed,
      'opinion': instance.opinion,
      'passBeginTime': instance.beginTime,
      'passEndTime': instance.endTime,
    };
