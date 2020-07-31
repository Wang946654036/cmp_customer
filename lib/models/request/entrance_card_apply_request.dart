import 'package:json_annotation/json_annotation.dart';

import '../user_data_model.dart';

part 'entrance_card_apply_request.g.dart';


@JsonSerializable()
class EntranceCardApplyRequest extends Object {

  @JsonKey(name: 'accessCardId')
  int accessCardId;//申请id

  @JsonKey(name: 'applyCount')
  int applyCount;//申请张数

  @JsonKey(name: 'attHeadList')
  List<String> attHeadList;//头像uuid列表

  @JsonKey(name: 'attSfzList')
  List<String> attSfzList;//身份证uuid列表

  @JsonKey(name: 'attMjkfjList')
  List<Attachment> attMjkfjList;//相关附件

  @JsonKey(name: 'buildId')
  int buildId;//楼栋id

  @JsonKey(name: 'businessNo')
  String businessNo;//业务办理单号

  @JsonKey(name: 'createTime')
  String createTime;//创建时间

  @JsonKey(name: 'customerId')
  int customerId;//客户id

  @JsonKey(name: 'customerPhone')
  String customerPhone;//客户电话

  @JsonKey(name: 'customerType')
  String customerType;//客户类型（业主、租客 ）

  @JsonKey(name: 'houseId')
  int houseId;//房屋id

  @JsonKey(name: 'houseNo')
  String houseNo;//房屋号码

  @JsonKey(name: 'ownerId')
  int ownerId;//业主id

  @JsonKey(name: 'payFees')
  double payFees;//缴费金额

  @JsonKey(name: 'projectId')
  int projectId;//项目id

  @JsonKey(name: 'reason')
  String reason;//申请原因

  @JsonKey(name: 'remark')
  String remark;//备注

  @JsonKey(name: 'settingId')
  int settingId;//方案id

  @JsonKey(name: 'status')
  String status;//状态

  @JsonKey(name: 'unitId')
  int unitId;//单元id

  @JsonKey(name: 'updateTime')
  String updateTime;//更新时间

  EntranceCardApplyRequest({this.accessCardId,this.applyCount,this.attHeadList,this.attSfzList,this.buildId,this.businessNo,this.createTime,this.customerId,this.customerPhone,this.customerType,this.houseId,this.houseNo,this.ownerId,this.payFees,this.projectId,this.reason,this.remark,this.settingId,this.status,this.unitId,this.updateTime,});

  factory EntranceCardApplyRequest.fromJson(Map<String, dynamic> srcJson) => _$EntranceCardApplyRequestFromJson(srcJson);

  Map<String, dynamic> toJson() => _$EntranceCardApplyRequestToJson(this);

}


