import 'package:cmp_customer/models/user_data_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'articles_release_detail_model.g.dart';

@JsonSerializable()
class ArticlesReleaseDetailModel extends Object {
  @JsonKey(name: 'appCodes')
  List<String> appCodes;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'data')
  ArticlesReleaseDetail articlesReleaseDetail;

  @JsonKey(name: 'extStr')
  String extStr;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'totalCount')
  int totalCount;

  ArticlesReleaseDetailModel(
    this.appCodes,
    this.code,
    this.articlesReleaseDetail,
    this.extStr,
    this.message,
    this.systemDate,
    this.totalCount,
  );

  factory ArticlesReleaseDetailModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ArticlesReleaseDetailModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ArticlesReleaseDetailModelToJson(this);
}

@JsonSerializable()
class ArticlesReleaseDetail extends Object {
  @JsonKey(name: 'assigneeName')
  String assigneeName;

  @JsonKey(name: 'attDwzmList')
  List<Attachment> attDwzmList;

  @JsonKey(name: 'attWpzpList')
  List<Attachment> attWpzpList;

  @JsonKey(name: 'attWpSignList')
  List<Attachment> attWpSignList;

  @JsonKey(name: 'buildId')
  int buildId;

  @JsonKey(name: 'buildName')
  String buildName;

  @JsonKey(name: 'businessNo')
  String businessNo;

  @JsonKey(name: 'carNo')
  String carNo;

  @JsonKey(name: 'createTime')
  String createTime;

  @JsonKey(name: 'customerId')
  int customerId;

  @JsonKey(name: 'customerName')
  String customerName;

  @JsonKey(name: 'customerPhone')
  String customerPhone;

  //申请人证件号码
  @JsonKey(name: 'custIdNum')
  String custIdNum;

  @JsonKey(name: 'customerType')
  String customerType;

  @JsonKey(name: 'goodNames')
  String goodNames;

  @JsonKey(name: 'goodNums')
  int goodNums;

  @JsonKey(name: 'houseId')
  int houseId;

  String houseName;

  @JsonKey(name: 'houseNo')
  String houseNo;

  @JsonKey(name: 'operateStep')
  String operateStep;

  @JsonKey(name: 'operateStepNext')
  String operateStepNext;

  @JsonKey(name: 'outTime')
  String outTime;

  @JsonKey(name: 'ownerName')
  String ownerName;

  @JsonKey(name: 'ownerPhone')
  String ownerPhone;

  @JsonKey(name: 'postId')
  int postId;

  @JsonKey(name: 'processId')
  String processId;

  @JsonKey(name: 'projectId')
  int projectId;

  @JsonKey(name: 'projectName')
  String projectName;

  @JsonKey(name: 'formerName')
  String formerName;

  String reasonName; //申请理由中文

  @JsonKey(name: 'reason')
  String reason;

  @JsonKey(name: 'recordList')
  List<RecordInfo> recordList;

  @JsonKey(name: 'releasePassId')
  int releasePassId;

  @JsonKey(name: 'remark')
  String remark;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'statusDesc')
  String statusDesc;

  @JsonKey(name: 'unitId')
  int unitId;

  @JsonKey(name: 'unitName')
  String unitName;

  @JsonKey(name: 'updateTime')
  String updateTime;

  @JsonKey(name: 'userId')
  int userId;

  @JsonKey(name: 'applyType')
  String applyType;

  @JsonKey(name: 'goodsList')
  List<GoodsInfo> goodsList;

  ArticlesReleaseDetail({
    this.assigneeName,
    this.attDwzmList,
    this.attWpzpList,
    this.buildId,
    this.buildName,
    this.businessNo,
    this.carNo,
    this.createTime,
    this.customerId,
    this.customerName,
    this.customerPhone,
    this.customerType,
    this.goodNames,
    this.goodNums,
    this.houseId,
    this.houseNo,
    this.operateStep,
    this.operateStepNext,
    this.outTime,
    this.ownerName,
    this.ownerPhone,
    this.postId,
    this.processId,
    this.projectId,
    this.projectName,
    this.formerName,
    this.reason,
    this.recordList,
    this.releasePassId,
    this.remark,
    this.status,
    this.unitId,
    this.unitName,
    this.updateTime,
    this.userId,
    this.applyType,
    this.statusDesc,
    this.goodsList,
    this.custIdNum,
  });

  factory ArticlesReleaseDetail.fromJson(Map<String, dynamic> srcJson) => _$ArticlesReleaseDetailFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ArticlesReleaseDetailToJson(this);

  factory ArticlesReleaseDetail.clone(ArticlesReleaseDetail srcData) {
    ArticlesReleaseDetail outData = ArticlesReleaseDetail();
    outData.assigneeName = srcData.assigneeName;
    outData.attDwzmList = List();
    srcData.attDwzmList?.forEach((Attachment attach) {
      outData.attDwzmList.add(attach);
    });
    outData.attWpzpList = List();
    srcData.attWpzpList?.forEach((Attachment attach) {
      outData.attWpzpList.add(attach);
    });
    outData.attWpSignList = List();
    srcData.attWpSignList?.forEach((Attachment attach) {
      outData.attWpSignList.add(attach);
    });
    outData.buildId = srcData.buildId;
    outData.buildName = srcData.buildName;
    outData.businessNo = srcData.businessNo;
    outData.carNo = srcData.carNo;
    outData.createTime = srcData.createTime;
    outData.customerId = srcData.customerId;
    outData.customerName = srcData.customerName;
    outData.customerPhone = srcData.customerPhone;
    outData.customerType = srcData.customerType;
    outData.goodNames = srcData.goodNames;
    outData.goodNums = srcData.goodNums;
    outData.houseId = srcData.houseId;
    outData.houseNo = srcData.houseNo;
    outData.operateStep = srcData.operateStep;
    outData.operateStepNext = srcData.operateStepNext;
    outData.outTime = srcData.outTime;
    outData.ownerName = srcData.ownerName;
    outData.ownerPhone = srcData.ownerPhone;
    outData.postId = srcData.postId;
    outData.processId = srcData.processId;
    outData.projectId = srcData.projectId;
    outData.projectName = srcData.projectName;
    outData.formerName = srcData.formerName;
    outData.reason = srcData.reason;
    outData.recordList = srcData.recordList;
    outData.releasePassId = srcData.releasePassId;
    outData.remark = srcData.remark;
    outData.status = srcData.status;
    outData.unitId = srcData.unitId;
    outData.unitName = srcData.unitName;
    outData.updateTime = srcData.updateTime;
    outData.userId = srcData.userId;
    outData.applyType = srcData.applyType;
    outData.goodsList = List();
    srcData.goodsList?.forEach((GoodsInfo info) {
      GoodsInfo welderInfo = GoodsInfo();
      welderInfo.goodsName = info?.goodsName;
      welderInfo.goodsNumber = info?.goodsNumber;
      welderInfo.goodsPicUuid = info?.goodsPicUuid;
      outData.goodsList.add(welderInfo);
    });
    return outData;
  }
}

@JsonSerializable()
class RecordInfo extends Object {
  @JsonKey(name: 'attDwzmList')
  List<Attachment> attDwzmList;

  @JsonKey(name: 'attWpzpList')
  List<Attachment> attWpzpList;

  @JsonKey(name: 'attWpSignList')
  List<Attachment> attWpSignList;

  @JsonKey(name: 'attWpfxmgList')
  List<Attachment> attWpfxmgList;

  @JsonKey(name: 'attachmentFlag')
  String attachmentFlag;

  @JsonKey(name: 'createTime')
  String createTime;

  @JsonKey(name: 'creator')
  String creator;

  @JsonKey(name: 'creatorId')
  int creatorId;

  @JsonKey(name: 'creatorType')
  String creatorType;

  @JsonKey(name: 'operateStep')
  String operateStep;

  @JsonKey(name: 'postId')
  int postId;

  @JsonKey(name: 'recordId')
  int recordId;

  @JsonKey(name: 'releasePassId')
  int releasePassId;

  @JsonKey(name: 'remark')
  String remark;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'statusDesc')
  String statusDesc;

  @JsonKey(name: 'userId')
  int userId;

  RecordInfo(
    this.attDwzmList,
    this.attWpzpList,
    this.attachmentFlag,
    this.createTime,
    this.creator,
    this.creatorId,
    this.creatorType,
    this.operateStep,
    this.postId,
    this.recordId,
    this.releasePassId,
    this.remark,
    this.status,
    this.userId,
    this.statusDesc,
    this.attWpSignList,
    this.attWpfxmgList,
  );

  factory RecordInfo.fromJson(Map<String, dynamic> srcJson) => _$RecordInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RecordInfoToJson(this);
}



@JsonSerializable()
class GoodsInfo extends Object {
  @JsonKey(name: 'goodsName')
  String goodsName;

  @JsonKey(name: 'goodsNumber')
  int goodsNumber;

  @JsonKey(name: 'goodsPicUuid')
  String goodsPicUuid;

  GoodsInfo({
    this.goodsName,
    this.goodsNumber,
    this.goodsPicUuid,
  });

  factory GoodsInfo.fromJson(Map<String, dynamic> srcJson) => _$GoodsInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$GoodsInfoToJson(this);
}