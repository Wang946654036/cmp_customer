import 'package:cmp_customer/models/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

import 'ware_detail_model.dart';

part 'ware_list_response.g.dart';


@JsonSerializable()
class WareListResponse extends BaseResponse{

  @JsonKey(name: 'data')
  List<WareDetailModel> data;

  WareListResponse({this.data});

  factory WareListResponse.fromJson(Map<String, dynamic> srcJson) => _$WareListResponseFromJson(srcJson);

}