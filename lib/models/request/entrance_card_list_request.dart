import 'package:cmp_customer/models/request/base_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'entrance_card_list_request.g.dart';


@JsonSerializable()
class EntranceCardListRequest extends BaseRequest {

  @JsonKey(name: 'projectId')
  int projectId;//项目id

  @JsonKey(name: 'queryType')
  String queryType;//查询类型（ZH:租户申请、ZJ:我的申请）


  EntranceCardListRequest({this.projectId,this.queryType});

  factory EntranceCardListRequest.fromJson(Map<String, dynamic> srcJson) => _$EntranceCardListRequestFromJson(srcJson);

  Map<String, dynamic> toJson() => _$EntranceCardListRequestToJson(this);

}


