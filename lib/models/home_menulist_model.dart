import 'package:json_annotation/json_annotation.dart';

import 'user_data_model.dart';

part 'home_menulist_model.g.dart';

@JsonSerializable()
class HomeMenuListModel extends Object {

  @JsonKey(name: 'customerMenuVoList')
  List<MenuInfo> menuList;

  HomeMenuListModel({this.menuList});

  factory HomeMenuListModel.fromJson(Map<String, dynamic> srcJson) => _$HomeMenuListModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HomeMenuListModelToJson(this);
}