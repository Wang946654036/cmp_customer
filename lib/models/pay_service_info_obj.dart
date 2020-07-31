import 'package:cmp_customer/models/pay_service_info_list.dart';

import 'package:json_annotation/json_annotation.dart';

part 'pay_service_info_obj.g.dart';


@JsonSerializable()
class PayServiceInfoObj extends Object {

  @JsonKey(name: 'appCodes')
  List<String> appCodes;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'data')
  PayServiceInfo data;

  @JsonKey(name: 'extStr')
  String extStr;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'totalCount')
  int totalCount;

  PayServiceInfoObj(this.appCodes,this.code,this.data,this.extStr,this.message,this.systemDate,this.totalCount,);

  factory PayServiceInfoObj.fromJson(Map<String, dynamic> srcJson) => _$PayServiceInfoObjFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PayServiceInfoObjToJson(this);

}
