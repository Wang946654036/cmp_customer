import 'package:cmp_customer/models/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

import '../user_data_model.dart';

part 'entrance_card_details_response.g.dart';

@JsonSerializable()
class EntranceCardDetailsResponse extends BaseResponse {
  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'data')
  EntranceCardDetailsInfo entranceCardDetailsInfo;

  EntranceCardDetailsResponse(
    this.systemDate,
    this.entranceCardDetailsInfo,
  );

  factory EntranceCardDetailsResponse.fromJson(Map<String, dynamic> srcJson) =>
      _$EntranceCardDetailsResponseFromJson(srcJson);

  Map<String, dynamic> toJson() => _$EntranceCardDetailsResponseToJson(this);
}

@JsonSerializable()
class EntranceCardDetailsInfo extends Object {
  @JsonKey(name: 'accessCardId')
  int accessCardId;

  @JsonKey(name: 'projectId')
  int projectId;

  @JsonKey(name: 'projectName')
  String projectName;

  @JsonKey(name: 'formerName')
  String formerName;

  @JsonKey(name: 'buildName')
  String buildName;

  @JsonKey(name: 'unitName')
  String unitName;

  @JsonKey(name: 'houseNo')
  String houseNo;

  @JsonKey(name: 'houseId')
  int houseId;

  @JsonKey(name: 'ownerId')
  int ownerId;

  @JsonKey(name: 'settingId')
  int settingId;

  @JsonKey(name: 'businessNo')
  String businessNo;

  @JsonKey(name: 'customerId')
  int customerId;

  @JsonKey(name: 'customerName')
  String customerName;

  @JsonKey(name: 'customerType')
  String customerType;

  @JsonKey(name: 'customerPhone')
  String customerPhone;

  @JsonKey(name: 'applyCount')
  int applyCount;

  @JsonKey(name: 'reason')
  String reason;

  @JsonKey(name: 'payFees')
  double payFees;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'statusDesc')
  String statusDesc;

  @JsonKey(name: 'createTime')
  String createTime;

  @JsonKey(name: 'updateTime')
  String updateTime;

  @JsonKey(name: 'attHeadList')
  List<String> attHeadList;

  @JsonKey(name: 'attSfzList')
  List<String> attSfzList;

  @JsonKey(name: 'attJfpjList')
  List<String> attJfpjList;

  @JsonKey(name: 'attMjkfjList')
  List<Attachment> attMjkfjList;

  @JsonKey(name: 'recordList')
  List<RecordList> recordList;

  EntranceCardDetailsInfo({
    this.accessCardId,
    this.projectId,
    this.houseId,
    this.ownerId,
    this.settingId,
    this.businessNo,
    this.customerId,
    this.customerType,
    this.customerPhone,
    this.applyCount,
    this.reason,
    this.payFees,
    this.status,
    this.createTime,
    this.updateTime,
    this.recordList,
    this.formerName,
  });

  factory EntranceCardDetailsInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$EntranceCardDetailsInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$EntranceCardDetailsInfoToJson(this);
}

@JsonSerializable()
class RecordList extends Object {
  @JsonKey(name: 'recordId')
  int recordId;

  @JsonKey(name: 'accessCardId')
  int accessCardId;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'attachmentFlag')
  String attachmentFlag;

  @JsonKey(name: 'creatorId')
  int creatorId;

  @JsonKey(name: 'createTime')
  String createTime;

  @JsonKey(name: 'attHeadList')
  List<String> attHeadList;

  @JsonKey(name: 'attSfzList')
  List<String> attSfzList;

  @JsonKey(name: 'remark')
  String remark; //流程节点

  @JsonKey(name: 'operateStep')
  String operateStep; //流程节点

  @JsonKey(name: 'operateStepDesc')
  String operateStepDesc; //流程节点中文

  @JsonKey(name: 'statusDesc')
  String statusDesc;

  @JsonKey(name: 'attJfpjList')
  List<String> attList;

  @JsonKey(name: 'attMjkfjList')
  List<Attachment> attMjkfjList;

  RecordList(this.recordId, this.accessCardId, this.status, this.attachmentFlag, this.creatorId, this.createTime,
      this.attHeadList, this.attSfzList, this.remark, this.operateStep, this.attList);

  factory RecordList.fromJson(Map<String, dynamic> srcJson) => _$RecordListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RecordListToJson(this);
}

//@JsonSerializable()
//class AttHeadList extends Object {
//
//  @JsonKey(name: 'id')
//  int id;
//
//  @JsonKey(name: 'source')
//  String source;
//
//  @JsonKey(name: 'type')
//  String type;
//
//  @JsonKey(name: 'relatedId')
//  int relatedId;
//
//  @JsonKey(name: 'attachmentUuid')
//  String attachmentUuid;
//
//  @JsonKey(name: 'status')
//  String status;
//
//  @JsonKey(name: 'createTime')
//  String createTime;
//
//  AttHeadList(this.id,this.source,this.type,this.relatedId,this.attachmentUuid,this.status,this.createTime,);
//
//  factory AttHeadList.fromJson(Map<String, dynamic> srcJson) => _$AttHeadListFromJson(srcJson);
//
//  Map<String, dynamic> toJson() => _$AttHeadListToJson(this);
//
//}
//
//
//@JsonSerializable()
//class AttSfzList extends Object {
//
//  @JsonKey(name: 'id')
//  int id;
//
//  @JsonKey(name: 'source')
//  String source;
//
//  @JsonKey(name: 'type')
//  String type;
//
//  @JsonKey(name: 'relatedId')
//  int relatedId;
//
//  @JsonKey(name: 'attachmentUuid')
//  String attachmentUuid;
//
//  @JsonKey(name: 'status')
//  String status;
//
//  @JsonKey(name: 'createTime')
//  String createTime;
//
//  AttSfzList(this.id,this.source,this.type,this.relatedId,this.attachmentUuid,this.status,this.createTime,);
//
//  factory AttSfzList.fromJson(Map<String, dynamic> srcJson) => _$AttSfzListFromJson(srcJson);
//
//  Map<String, dynamic> toJson() => _$AttSfzListToJson(this);
//
//}

@JsonSerializable()
class AttList extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'source')
  String source;

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'relatedId')
  int relatedId;

  @JsonKey(name: 'attachmentUuid')
  String attachmentUuid;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'createTime')
  String createTime;

  AttList(
    this.id,
    this.source,
    this.type,
    this.relatedId,
    this.attachmentUuid,
    this.status,
    this.createTime,
  );

  factory AttList.fromJson(Map<String, dynamic> srcJson) => _$AttListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AttListToJson(this);
}
