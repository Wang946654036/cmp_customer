import 'package:json_annotation/json_annotation.dart';

part 'common_result_model.g.dart';


@JsonSerializable()
class CommonResultModel extends Object {

  @JsonKey(name: 'code')
  var code;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'data')
  var data;

  bool success(){
    return code=="0";
  }

  CommonResultModel(this.code,this.message,this.data);

  factory CommonResultModel.fromJson(Map<String, dynamic> srcJson) => _$CommonResultModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CommonResultModelToJson(this);

}


