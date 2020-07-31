import 'package:cmp_customer/models/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'agreement_response.g.dart';

@JsonSerializable()
class AgreementResponse extends BaseResponse {
  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'data')
  AgreementInfo agreementInfo;

  @JsonKey(name: 'totalCount')
  int totalCount;

  AgreementResponse(
    this.systemDate,
    this.agreementInfo,
    this.totalCount,
  );

  factory AgreementResponse.fromJson(Map<String, dynamic> srcJson) => _$AgreementResponseFromJson(srcJson);
}

@JsonSerializable()
class AgreementInfo extends Object {
  @JsonKey(name: 'agreementId')
  int agreementId;

  @JsonKey(name: 'agreementType')
  String agreementType;

  @JsonKey(name: 'agreementName')
  String agreementName;

  @JsonKey(name: 'agreementTitle')
  String agreementTitle;

  @JsonKey(name: 'agreementContent')
  String agreementContent;

  @JsonKey(name: 'createUserId')
  int createUserId;

  @JsonKey(name: 'createTime')
  String createTime;

  @JsonKey(name: 'updateUserId')
  int updateUserId;

  @JsonKey(name: 'updateTime')
  String updateTime;

  @JsonKey(name: 'agreementTypeName')
  String agreementTypeName;

  @JsonKey(name: 'projectIdList')
  List<int> projectIdList;

  @JsonKey(name: 'projectNames')
  String projectNames;

  @JsonKey(name: 'createUserName')
  String createUserName;

  @JsonKey(name: 'updateUserName')
  String updateUserName;

  AgreementInfo({
    this.agreementId,
    this.agreementType,
    this.agreementName,
    this.agreementTitle,
    this.agreementContent,
    this.createUserId,
    this.createTime,
    this.updateUserId,
    this.updateTime,
    this.agreementTypeName,
    this.projectIdList,
    this.projectNames,
    this.createUserName,
    this.updateUserName,
  });

  factory AgreementInfo.fromJson(Map<String, dynamic> srcJson) => _$AgreementInfoFromJson(srcJson);
}
