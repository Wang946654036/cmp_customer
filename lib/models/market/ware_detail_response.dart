import 'package:cmp_customer/models/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

import 'ware_detail_model.dart';

part 'ware_detail_response.g.dart';


@JsonSerializable()
class WareDetailResponse extends BaseResponse{

  @JsonKey(name: 'data')
  WareDetailModel data;

  WareDetailResponse({this.data});

  factory WareDetailResponse.fromJson(Map<String, dynamic> srcJson) => _$WareDetailResponseFromJson(srcJson);

}