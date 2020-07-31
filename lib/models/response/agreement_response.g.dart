// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agreement_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgreementResponse _$AgreementResponseFromJson(Map<String, dynamic> json) {
  return AgreementResponse(
    json['systemDate'] as String,
    json['data'] == null
        ? null
        : AgreementInfo.fromJson(json['data'] as Map<String, dynamic>),
    json['totalCount'] as int,
  )
    ..code = json['code'] as String
    ..message = json['message'] as String;
}

Map<String, dynamic> _$AgreementResponseToJson(AgreementResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'systemDate': instance.systemDate,
      'data': instance.agreementInfo,
      'totalCount': instance.totalCount,
    };

AgreementInfo _$AgreementInfoFromJson(Map<String, dynamic> json) {
  return AgreementInfo(
    agreementId: json['agreementId'] as int,
    agreementType: json['agreementType'] as String,
    agreementName: json['agreementName'] as String,
    agreementTitle: json['agreementTitle'] as String,
    agreementContent: json['agreementContent'] as String,
    createUserId: json['createUserId'] as int,
    createTime: json['createTime'] as String,
    updateUserId: json['updateUserId'] as int,
    updateTime: json['updateTime'] as String,
    agreementTypeName: json['agreementTypeName'] as String,
    projectIdList:
        (json['projectIdList'] as List)?.map((e) => e as int)?.toList(),
    projectNames: json['projectNames'] as String,
    createUserName: json['createUserName'] as String,
    updateUserName: json['updateUserName'] as String,
  );
}

Map<String, dynamic> _$AgreementInfoToJson(AgreementInfo instance) =>
    <String, dynamic>{
      'agreementId': instance.agreementId,
      'agreementType': instance.agreementType,
      'agreementName': instance.agreementName,
      'agreementTitle': instance.agreementTitle,
      'agreementContent': instance.agreementContent,
      'createUserId': instance.createUserId,
      'createTime': instance.createTime,
      'updateUserId': instance.updateUserId,
      'updateTime': instance.updateTime,
      'agreementTypeName': instance.agreementTypeName,
      'projectIdList': instance.projectIdList,
      'projectNames': instance.projectNames,
      'createUserName': instance.createUserName,
      'updateUserName': instance.updateUserName,
    };
