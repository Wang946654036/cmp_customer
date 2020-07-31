import 'package:cmp_customer/models/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'entrance_card_setting_response.g.dart';


@JsonSerializable()
class EntranceCardSettingResponse extends BaseResponse {

  @JsonKey(name: 'data')
  EntranceCardSetting entranceCardSetting;

  EntranceCardSettingResponse(this.entranceCardSetting,);

  factory EntranceCardSettingResponse.fromJson(Map<String, dynamic> srcJson) => _$EntranceCardSettingResponseFromJson(srcJson);

  Map<String, dynamic> toJson() => _$EntranceCardSettingResponseToJson(this);

}


@JsonSerializable()
class EntranceCardSetting extends Object {

  @JsonKey(name: 'settingId')
  int settingId;

  @JsonKey(name: 'headIconFlag')
  String headIconFlag;

  @JsonKey(name: 'unitPrice')
  double unitPrice;

  @JsonKey(name: 'projectId')
  int projectId;

  @JsonKey(name: 'projectName')
  String projectName;

  @JsonKey(name: 'settingName')
  String settingName;

  @JsonKey(name: 'chargeDesc')
  String chargeDesc;

  @JsonKey(name: 'paymentTip')
  String paymentTip;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'creatorId')
  int creatorId;

  @JsonKey(name: 'createTime')
  String createTime;

  EntranceCardSetting(this.settingId,this.headIconFlag,this.unitPrice,this.projectId,this.projectName,this.settingName,this.chargeDesc,this.paymentTip,this.status,this.creatorId,this.createTime,);

  factory EntranceCardSetting.fromJson(Map<String, dynamic> srcJson) => _$EntranceCardSettingFromJson(srcJson);

  Map<String, dynamic> toJson() => _$EntranceCardSettingToJson(this);

}


