import 'package:json_annotation/json_annotation.dart';

part 'articles_release_record_model.g.dart';

@JsonSerializable()
class ArticlesReleaseRecordModel extends Object {
  @JsonKey(name: 'appCodes')
  List<String> appCodes;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'data')
  List<ArticlesReleaseInfo> articlesReleaseList;

  @JsonKey(name: 'extStr')
  String extStr;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'totalCount')
  int totalCount;

  ArticlesReleaseRecordModel(
    this.appCodes,
    this.code,
    this.articlesReleaseList,
    this.extStr,
    this.message,
    this.systemDate,
    this.totalCount,
  );

  factory ArticlesReleaseRecordModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ArticlesReleaseRecordModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ArticlesReleaseRecordModelToJson(this);
}

@JsonSerializable()
class ArticlesReleaseInfo extends Object {
  @JsonKey(name: 'buildName')
  String buildName;

  @JsonKey(name: 'businessNo')
  String businessNo;

  @JsonKey(name: 'createTime')
  String createTime;

  @JsonKey(name: 'customerName')
  String customerName;

  @JsonKey(name: 'customerPhone')
  String customerPhone;

  @JsonKey(name: 'customerType')
  String customerType;

  @JsonKey(name: 'goodNames')
  String goodNames;

  @JsonKey(name: 'goodNums')
  int goodNums;

  @JsonKey(name: 'houseNo')
  String houseNo;

  @JsonKey(name: 'operateStep')
  String operateStep;

  @JsonKey(name: 'outTime')
  String outTime;

  @JsonKey(name: 'projectName')
  String projectName;

  @JsonKey(name: 'reason')
  String reason;

  @JsonKey(name: 'releasePassId')
  int releasePassId;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'statusDesc')
  String statusDesc;

  @JsonKey(name: 'unitName')
  String unitName;

  @JsonKey(name: 'updateTime')
  String updateTime;

  ArticlesReleaseInfo(
    this.buildName,
    this.businessNo,
    this.createTime,
    this.customerName,
    this.customerPhone,
    this.customerType,
    this.goodNames,
    this.goodNums,
    this.houseNo,
    this.operateStep,
    this.outTime,
    this.projectName,
    this.reason,
    this.releasePassId,
    this.status,
    this.unitName,
    this.updateTime,
    this.statusDesc,
  );

  factory ArticlesReleaseInfo.fromJson(Map<String, dynamic> srcJson) => _$ArticlesReleaseInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ArticlesReleaseInfoToJson(this);
}
