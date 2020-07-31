import 'package:json_annotation/json_annotation.dart';

import 'new_house_model.dart';

part'new_house_detail_list_model.g.dart';

@JsonSerializable()
class NewHouseDetailListModel extends Object {
  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'data')
  List<NewHouseDetail> data;

  NewHouseDetailListModel({this.code,
    this.message,
    this.systemDate,
    this.data,}
      );

  factory NewHouseDetailListModel.fromJson(Map<String, dynamic> srcJson) => _$NewHouseDetailListModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$NewHouseDetailListModelToJson(this);
}