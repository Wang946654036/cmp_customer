import 'package:json_annotation/json_annotation.dart';

part 'uncertified_community_model.g.dart';


@JsonSerializable()
class UncertifiedCommunityModel extends Object {

  @JsonKey(name: 'list')
  List<UncertifiedCommunityList> list;

  UncertifiedCommunityModel({this.list});

  factory UncertifiedCommunityModel.fromJson(Map<String, dynamic> srcJson) => _$UncertifiedCommunityModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UncertifiedCommunityModelToJson(this);

}
@JsonSerializable()
class UncertifiedCommunityList extends Object {

  @JsonKey(name: 'uncertifiedCommunityList')
  List<UncertifiedCommunity> uncertifiedCommunityList;

  @JsonKey(name: 'account')
  String account;

  UncertifiedCommunityList({this.uncertifiedCommunityList,this.account});

  factory UncertifiedCommunityList.fromJson(Map<String, dynamic> srcJson) => _$UncertifiedCommunityListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UncertifiedCommunityListToJson(this);

}




@JsonSerializable()
class UncertifiedCommunity extends Object {

  @JsonKey(name: 'projectId')
  int projectId;

//  @JsonKey(name: 'projectName')
//  String projectName;

  @JsonKey(name: 'formerName')
  String formerName;

  @JsonKey(name: 'isDefault')
  bool isDefault = false;

  UncertifiedCommunity({
    this.projectId,
//    this.projectName,
    this.isDefault,
    this.formerName
  });

  factory UncertifiedCommunity.fromJson(Map<String, dynamic> srcJson) => _$UncertifiedCommunityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UncertifiedCommunityToJson(this);

}


