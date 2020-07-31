
import 'package:cmp_customer/models/visitor_release_detail_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'visitor_release_detail_list_model.g.dart';
@JsonSerializable()
class VisitorReleaseDetailListModel extends Object {
  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'data')
  List<VisitorReleaseDetail> data;

  VisitorReleaseDetailListModel({this.code,
    this.message,
    this.systemDate,
    this.data,}
      );

  factory VisitorReleaseDetailListModel.fromJson(Map<String, dynamic> srcJson) => _$VisitorReleaseDetailListModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VisitorReleaseDetailListModelToJson(this);
}