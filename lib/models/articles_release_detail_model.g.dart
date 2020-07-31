// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'articles_release_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticlesReleaseDetailModel _$ArticlesReleaseDetailModelFromJson(
    Map<String, dynamic> json) {
  return ArticlesReleaseDetailModel(
    (json['appCodes'] as List)?.map((e) => e as String)?.toList(),
    json['code'] as String,
    json['data'] == null
        ? null
        : ArticlesReleaseDetail.fromJson(json['data'] as Map<String, dynamic>),
    json['extStr'] as String,
    json['message'] as String,
    json['systemDate'] as String,
    json['totalCount'] as int,
  );
}

Map<String, dynamic> _$ArticlesReleaseDetailModelToJson(
        ArticlesReleaseDetailModel instance) =>
    <String, dynamic>{
      'appCodes': instance.appCodes,
      'code': instance.code,
      'data': instance.articlesReleaseDetail,
      'extStr': instance.extStr,
      'message': instance.message,
      'systemDate': instance.systemDate,
      'totalCount': instance.totalCount,
    };

ArticlesReleaseDetail _$ArticlesReleaseDetailFromJson(
    Map<String, dynamic> json) {
  return ArticlesReleaseDetail(
    assigneeName: json['assigneeName'] as String,
    attDwzmList: (json['attDwzmList'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    attWpzpList: (json['attWpzpList'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    buildId: json['buildId'] as int,
    buildName: json['buildName'] as String,
    businessNo: json['businessNo'] as String,
    carNo: json['carNo'] as String,
    createTime: json['createTime'] as String,
    customerId: json['customerId'] as int,
    customerName: json['customerName'] as String,
    customerPhone: json['customerPhone'] as String,
    customerType: json['customerType'] as String,
    goodNames: json['goodNames'] as String,
    goodNums: json['goodNums'] as int,
    houseId: json['houseId'] as int,
    houseNo: json['houseNo'] as String,
    operateStep: json['operateStep'] as String,
    operateStepNext: json['operateStepNext'] as String,
    outTime: json['outTime'] as String,
    ownerName: json['ownerName'] as String,
    ownerPhone: json['ownerPhone'] as String,
    postId: json['postId'] as int,
    processId: json['processId'] as String,
    projectId: json['projectId'] as int,
    projectName: json['projectName'] as String,
    formerName: json['formerName'] as String,
    reason: json['reason'] as String,
    recordList: (json['recordList'] as List)
        ?.map((e) =>
            e == null ? null : RecordInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    releasePassId: json['releasePassId'] as int,
    remark: json['remark'] as String,
    status: json['status'] as String,
    unitId: json['unitId'] as int,
    unitName: json['unitName'] as String,
    updateTime: json['updateTime'] as String,
    userId: json['userId'] as int,
    applyType: json['applyType'] as String,
    statusDesc: json['statusDesc'] as String,
    goodsList: (json['goodsList'] as List)
        ?.map((e) =>
            e == null ? null : GoodsInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    custIdNum: json['custIdNum'] as String,
  )
    ..attWpSignList = (json['attWpSignList'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..houseName = json['houseName'] as String
    ..reasonName = json['reasonName'] as String;
}

Map<String, dynamic> _$ArticlesReleaseDetailToJson(
        ArticlesReleaseDetail instance) =>
    <String, dynamic>{
      'assigneeName': instance.assigneeName,
      'attDwzmList': instance.attDwzmList,
      'attWpzpList': instance.attWpzpList,
      'attWpSignList': instance.attWpSignList,
      'buildId': instance.buildId,
      'buildName': instance.buildName,
      'businessNo': instance.businessNo,
      'carNo': instance.carNo,
      'createTime': instance.createTime,
      'customerId': instance.customerId,
      'customerName': instance.customerName,
      'customerPhone': instance.customerPhone,
      'custIdNum': instance.custIdNum,
      'customerType': instance.customerType,
      'goodNames': instance.goodNames,
      'goodNums': instance.goodNums,
      'houseId': instance.houseId,
      'houseName': instance.houseName,
      'houseNo': instance.houseNo,
      'operateStep': instance.operateStep,
      'operateStepNext': instance.operateStepNext,
      'outTime': instance.outTime,
      'ownerName': instance.ownerName,
      'ownerPhone': instance.ownerPhone,
      'postId': instance.postId,
      'processId': instance.processId,
      'projectId': instance.projectId,
      'projectName': instance.projectName,
      'formerName': instance.formerName,
      'reasonName': instance.reasonName,
      'reason': instance.reason,
      'recordList': instance.recordList,
      'releasePassId': instance.releasePassId,
      'remark': instance.remark,
      'status': instance.status,
      'statusDesc': instance.statusDesc,
      'unitId': instance.unitId,
      'unitName': instance.unitName,
      'updateTime': instance.updateTime,
      'userId': instance.userId,
      'applyType': instance.applyType,
      'goodsList': instance.goodsList,
    };

RecordInfo _$RecordInfoFromJson(Map<String, dynamic> json) {
  return RecordInfo(
    (json['attDwzmList'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['attWpzpList'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['attachmentFlag'] as String,
    json['createTime'] as String,
    json['creator'] as String,
    json['creatorId'] as int,
    json['creatorType'] as String,
    json['operateStep'] as String,
    json['postId'] as int,
    json['recordId'] as int,
    json['releasePassId'] as int,
    json['remark'] as String,
    json['status'] as String,
    json['userId'] as int,
    json['statusDesc'] as String,
    (json['attWpSignList'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['attWpfxmgList'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$RecordInfoToJson(RecordInfo instance) =>
    <String, dynamic>{
      'attDwzmList': instance.attDwzmList,
      'attWpzpList': instance.attWpzpList,
      'attWpSignList': instance.attWpSignList,
      'attWpfxmgList': instance.attWpfxmgList,
      'attachmentFlag': instance.attachmentFlag,
      'createTime': instance.createTime,
      'creator': instance.creator,
      'creatorId': instance.creatorId,
      'creatorType': instance.creatorType,
      'operateStep': instance.operateStep,
      'postId': instance.postId,
      'recordId': instance.recordId,
      'releasePassId': instance.releasePassId,
      'remark': instance.remark,
      'status': instance.status,
      'statusDesc': instance.statusDesc,
      'userId': instance.userId,
    };

GoodsInfo _$GoodsInfoFromJson(Map<String, dynamic> json) {
  return GoodsInfo(
    goodsName: json['goodsName'] as String,
    goodsNumber: json['goodsNumber'] as int,
    goodsPicUuid: json['goodsPicUuid'] as String,
  );
}

Map<String, dynamic> _$GoodsInfoToJson(GoodsInfo instance) => <String, dynamic>{
      'goodsName': instance.goodsName,
      'goodsNumber': instance.goodsNumber,
      'goodsPicUuid': instance.goodsPicUuid,
    };
