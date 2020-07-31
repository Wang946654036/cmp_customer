import 'package:cmp_customer/models/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'html_healthy_token_model.g.dart';


@JsonSerializable()
class HtmlHealthyTokenModel extends BaseResponse {

  @JsonKey(name: 'data')
  HealthyInfo healthyInfo;

  HtmlHealthyTokenModel(this.healthyInfo,);

  factory HtmlHealthyTokenModel.fromJson(Map<String, dynamic> srcJson) => _$HtmlHealthyTokenModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HtmlHealthyTokenModelToJson(this);

}


@JsonSerializable()
class HealthyInfo extends Object {

  @JsonKey(name: 'token')
  String token;

  @JsonKey(name: 'cid')
  String cid;

  @JsonKey(name: 'url')
  String url;

  HealthyInfo(this.token,this.cid,this.url,);

  factory HealthyInfo.fromJson(Map<String, dynamic> srcJson) => _$HealthyInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HealthyInfoToJson(this);

}


