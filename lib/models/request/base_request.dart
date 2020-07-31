import 'package:cmp_customer/http/http_options.dart';
import 'package:json_annotation/json_annotation.dart';

part 'base_request.g.dart';


@JsonSerializable()
class BaseRequest extends Object {

  @JsonKey(name: 'pageSize')
  int pageSize;

  @JsonKey(name: 'current')
  int current;

  BaseRequest({this.pageSize=HttpOptions.pageSize,this.current=1});

  factory BaseRequest.fromJson(Map<String, dynamic> srcJson) => _$BaseRequestFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BaseRequestToJson(this);

}


