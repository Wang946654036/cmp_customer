// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'uncertified_community_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UncertifiedCommunityModel _$UncertifiedCommunityModelFromJson(
    Map<String, dynamic> json) {
  return UncertifiedCommunityModel(
    list: (json['list'] as List)
        ?.map((e) => e == null
            ? null
            : UncertifiedCommunityList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$UncertifiedCommunityModelToJson(
        UncertifiedCommunityModel instance) =>
    <String, dynamic>{
      'list': instance.list,
    };

UncertifiedCommunityList _$UncertifiedCommunityListFromJson(
    Map<String, dynamic> json) {
  return UncertifiedCommunityList(
    uncertifiedCommunityList: (json['uncertifiedCommunityList'] as List)
        ?.map((e) => e == null
            ? null
            : UncertifiedCommunity.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    account: json['account'] as String,
  );
}

Map<String, dynamic> _$UncertifiedCommunityListToJson(
        UncertifiedCommunityList instance) =>
    <String, dynamic>{
      'uncertifiedCommunityList': instance.uncertifiedCommunityList,
      'account': instance.account,
    };

UncertifiedCommunity _$UncertifiedCommunityFromJson(Map<String, dynamic> json) {
  return UncertifiedCommunity(
    projectId: json['projectId'] as int,
    isDefault: json['isDefault'] as bool,
    formerName: json['formerName'] as String,
  );
}

Map<String, dynamic> _$UncertifiedCommunityToJson(
        UncertifiedCommunity instance) =>
    <String, dynamic>{
      'projectId': instance.projectId,
      'formerName': instance.formerName,
      'isDefault': instance.isDefault,
    };
