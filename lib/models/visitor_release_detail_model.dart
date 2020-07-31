import 'package:json_annotation/json_annotation.dart';
part 'visitor_release_detail_model.g.dart';

@JsonSerializable()
class VisitorReleaseDetailModel extends Object {
  @JsonKey(name: 'appCodes')
  List<String> appCodes;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'data')
  VisitorReleaseDetail data;

  @JsonKey(name: 'extStr')
  String extStr;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'totalCount')
  int totalCount;

  VisitorReleaseDetailModel({ this.appCodes,
    this.code,
    this.data,
    this.extStr,
    this.message,
    this.systemDate,
    this.totalCount,}

      );

  factory VisitorReleaseDetailModel.fromJson(Map<String, dynamic> srcJson) => _$VisitorReleaseDetailModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VisitorReleaseDetailModelToJson(this);
}
@JsonSerializable()
class VisitorReleaseDetail extends Object{
  @JsonKey(name: 'appointmentVisitId')
  int appointmentVisitId;
  @JsonKey(name: 'oddNumber')
  String oddNumber;
  @JsonKey(name: 'state')
  String state;
  @JsonKey(name: 'stateName')
  String stateName;
  @JsonKey(name: 'acceptRemark')
  String acceptRemark;

  @JsonKey(name: 'applyType')
  String applyType;//（YYDF-预约到访，LSDF-临时到访）
  @JsonKey(name: 'houseId')
  int houseId;
  @JsonKey(name: 'custName')
  String custName;
  @JsonKey(name: 'custPhone')
  String custPhone;
  @JsonKey(name: 'visitReason')
  String visitReason;
  @JsonKey(name: 'visitDate')
  String visitDate;
  @JsonKey(name: 'effective')
  int effective;
  @JsonKey(name: 'maxEffective')
  int maxEffective;

  @JsonKey(name: 'visitorName')
  String visitorName;
  @JsonKey(name: 'visitorPhone')
  String visitorPhone;
  @JsonKey(name: 'paperType')
  String paperType;
  @JsonKey(name: 'paperNumber')
  String paperNumber;
  @JsonKey(name: 'driveCar')
  int driveCar;
  @JsonKey(name: 'carNumber')
  String carNumber;
  @JsonKey(name: 'visitNum')
  int visitNum;
  @JsonKey(name: 'remark')
  String remark;
  @JsonKey(name: 'qrCodeUuid')
  String qrCodeUuid;
  @JsonKey(name: 'isPassedFromCust')
  int isPassedFromCust;

  @JsonKey(name: 'projectId')
  int projectId;

  @JsonKey(name: 'projectName')
  String projectName;

  @JsonKey(name: 'projectFormerName')
  String projectFormerName;

  @JsonKey(name: 'houseName')
  String houseName;

  @JsonKey(name: 'buildName')
  String buildName;
  @JsonKey(name: 'buildId')
  int buildId;
  @JsonKey(name: 'unitName')
  String unitName;
  @JsonKey(name: 'unitId')
  int unitId;

//创建时间：createTime
  @JsonKey(name: 'createTime')
  String createTime;
//是否放行（1-放行，0-不放行）：is_passed
  @JsonKey(name: 'isPassed')
  int isPassed;
//意见：opinion
  @JsonKey(name: 'opinion')
  String opinion;
  //放行时间段（开始）：passEndTime
//放行时间段（结束）：passEndTime
  @JsonKey(name: 'passBeginTime')
  String beginTime;
  @JsonKey(name: 'passEndTime')
  String endTime;

  VisitorReleaseDetail({this.appointmentVisitId, this.oddNumber, this.state,this.stateName,this.acceptRemark,
      this.applyType, this.houseId, this.custName, this.custPhone,
      this.visitReason, this.visitDate, this.effective, this.visitorName,
      this.visitorPhone, this.paperType, this.paperNumber, this.driveCar,
      this.carNumber, this.visitNum, this.remark, this.qrCodeUuid,
      this.isPassedFromCust, this.projectId, this.projectName,
      this.projectFormerName, this.houseName, this.buildName,this.buildId, this.unitName,this.unitId,
      this.createTime, this.isPassed, this.opinion,
      this.beginTime, this.endTime});

  factory VisitorReleaseDetail.fromJson(Map<String, dynamic> srcJson) => _$VisitorReleaseDetailFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VisitorReleaseDetailToJson(this);

  @override
  String toString() {
    return 'VisitorReleaseDetail{appointmentVisitId: $appointmentVisitId, oddNumber: $oddNumber, state: $state, stateName: $stateName, acceptRemark: $acceptRemark, applyType: $applyType, houseId: $houseId, custName: $custName, custPhone: $custPhone, visitReason: $visitReason, visitDate: $visitDate, effective: $effective, maxEffective: $maxEffective, visitorName: $visitorName, visitorPhone: $visitorPhone, paperType: $paperType, paperNumber: $paperNumber, driveCar: $driveCar, carNumber: $carNumber, visitNum: $visitNum, remark: $remark, qrCodeUuid: $qrCodeUuid, isPassedFromCust: $isPassedFromCust, projectId: $projectId, projectName: $projectName, projectFormerName: $projectFormerName, houseName: $houseName, buildName: $buildName, unitName: $unitName, createTime: $createTime, isPassed: $isPassed, opinion: $opinion, beginTime: $beginTime, endTime: $endTime}';
  }

}