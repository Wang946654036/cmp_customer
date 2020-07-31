import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';


@JsonSerializable()
class BaseResponse extends Object {

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'message')
  String message;

  bool success(){
    return code=="0";
  }

  BaseResponse({this.code,this.message});

  factory BaseResponse.fromJson(Map<String, dynamic> srcJson) => _$BaseResponseFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);

}


