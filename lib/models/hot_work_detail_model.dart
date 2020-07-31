import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'user_data_model.dart';

part 'hot_work_detail_model.g.dart';

@JsonSerializable()
class HotWorkDetailModel extends Object {
  @JsonKey(name: 'appCodes')
  List<String> appCodes;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'data')
  HotWorkDetail hotWorkDetail;

  @JsonKey(name: 'extStr')
  String extStr;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'totalCount')
  int totalCount;

  HotWorkDetailModel(
    this.appCodes,
    this.code,
    this.hotWorkDetail,
    this.extStr,
    this.message,
    this.systemDate,
    this.totalCount,
  );

  factory HotWorkDetailModel.fromJson(Map<String, dynamic> srcJson) => _$HotWorkDetailModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HotWorkDetailModelToJson(this);
}

@JsonSerializable()
class HotWorkDetail extends Object {
  @JsonKey(name: 'constructionUnit')
  String constructionUnit;

  @JsonKey(name: 'createTime')
  String createTime;

  @JsonKey(name: 'customerId')
  int customerId;

  @JsonKey(name: 'customerName')
  String customerName;

  @JsonKey(name: 'customerPhone')
  String customerPhone;

  @JsonKey(name: 'firePreventMan')
  String firePreventMan;

  @JsonKey(name: 'fireWatchMan')
  String fireWatchMan;

  @JsonKey(name: 'hotWorkContent')
  String hotWorkContent;

  @JsonKey(name: 'hotWorkEndTime')
  String hotWorkEndTime;

  @JsonKey(name: 'hotWorkId')
  int hotWorkId;

  @JsonKey(name: 'hotWorkLocation')
  String hotWorkLocation;

  @JsonKey(name: 'hotWorkNo')
  String hotWorkNo;

  @JsonKey(name: 'hotWorkStartTime')
  String hotWorkStartTime;

  @JsonKey(name: 'houseBuildId')
  int houseBuildId;

  @JsonKey(name: 'houseId')
  int houseId;

  @JsonKey(name: 'houseName')
  String houseName;

  @JsonKey(name: 'houseUnitId')
  int houseUnitId;

  @JsonKey(name: 'onSiteLeader')
  String onSiteLeader;

  @JsonKey(name: 'ownerId')
  int ownerId;

  @JsonKey(name: 'ownerIdentityNo')
  String ownerIdentityNo;

  @JsonKey(name: 'ownerName')
  String ownerName;

  @JsonKey(name: 'ownerPhone')
  String ownerPhone;

  @JsonKey(name: 'processExecutor')
  String processExecutor;

  @JsonKey(name: 'processId')
  String processId;

  @JsonKey(name: 'processNodeCode')
  String processNodeCode;

  @JsonKey(name: 'processNodeName')
  String processNodeName;

  @JsonKey(name: 'processPostId')
  int processPostId;

  @JsonKey(name: 'processState')
  String processState;

  @JsonKey(name: 'processStateName')
  String processStateName;

  @JsonKey(name: 'processTime')
  String processTime;

  @JsonKey(name: 'processUserId')
  int processUserId;

  @JsonKey(name: 'projectId')
  int projectId;

  @JsonKey(name: 'projectName')
  String projectName;

  @JsonKey(name: 'formerName')
  String formerName;

  @JsonKey(name: 'remark')
  String remark;

  @JsonKey(name: 'updateTime')
  String updateTime;

  @JsonKey(name: 'welderList')
  List<WelderInfo> welderList;

  @JsonKey(name: 'applyType')
  String applyType;

  @JsonKey(name: 'applyRecordList')
  List<RecordInfo> recordList;

  @JsonKey(name: 'attDhYzSignList')
  List<Attachment> attDhYzSignList;

  @JsonKey(name: 'attDhZhSignList')
  List<Attachment> attDhZhSignList;

  HotWorkDetail({
    this.constructionUnit,
    this.createTime,
    this.customerId,
    this.customerName,
    this.customerPhone,
    this.firePreventMan,
    this.fireWatchMan,
    this.hotWorkContent,
    this.hotWorkEndTime,
    this.hotWorkId,
    this.hotWorkLocation,
    this.hotWorkNo,
    this.hotWorkStartTime,
    this.houseBuildId,
    this.houseId,
    this.houseName,
    this.houseUnitId,
    this.onSiteLeader,
    this.ownerId,
    this.ownerIdentityNo,
    this.ownerName,
    this.ownerPhone,
    this.processExecutor,
    this.processId,
    this.processNodeCode,
    this.processNodeName,
    this.processPostId,
    this.processState,
    this.processStateName,
    this.processTime,
    this.processUserId,
    this.projectId,
    this.projectName,
    this.formerName,
    this.remark,
    this.updateTime,
    this.welderList,
    this.applyType,
    this.recordList,
    this.attDhYzSignList,
    this.attDhZhSignList,
  });

  factory HotWorkDetail.fromJson(Map<String, dynamic> srcJson) => _$HotWorkDetailFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HotWorkDetailToJson(this);

  factory HotWorkDetail.clone(HotWorkDetail srcData) {
    HotWorkDetail outData = HotWorkDetail();
    outData.constructionUnit = srcData.constructionUnit;
    outData.createTime = srcData.createTime;
    outData.customerId = srcData.customerId;
    outData.customerName = srcData.customerName;
    outData.customerPhone = srcData.customerPhone;
    outData.firePreventMan = srcData.firePreventMan;
    outData.fireWatchMan = srcData.fireWatchMan;
    outData.hotWorkContent = srcData.hotWorkContent;
    outData.hotWorkEndTime = srcData.hotWorkEndTime;
    outData.hotWorkId = srcData.hotWorkId;
    outData.hotWorkLocation = srcData.hotWorkLocation;
    outData.hotWorkNo = srcData.hotWorkNo;
    outData.hotWorkStartTime = srcData.hotWorkStartTime;
    outData.houseBuildId = srcData.houseBuildId;
    outData.houseId = srcData.houseId;
    outData.houseName = srcData.houseName;
    outData.houseUnitId = srcData.houseUnitId;
    outData.onSiteLeader = srcData.onSiteLeader;
    outData.ownerId = srcData.ownerId;
    outData.ownerIdentityNo = srcData.ownerIdentityNo;
    outData.ownerName = srcData.ownerName;
    outData.ownerPhone = srcData.ownerPhone;
    outData.processExecutor = srcData.processExecutor;
    outData.processId = srcData.processId;
    outData.processNodeCode = srcData.processNodeCode;
    outData.processNodeName = srcData.processNodeName;
    outData.processPostId = srcData.processPostId;
    outData.processState = srcData.processState;
    outData.processStateName = srcData.processStateName;
    outData.processTime = srcData.processTime;
    outData.processUserId = srcData.processUserId;
    outData.projectId = srcData.projectId;
    outData.projectName = srcData.projectName;
    outData.formerName = srcData.formerName;
    outData.remark = srcData.remark;
    outData.updateTime = srcData.updateTime;
    outData.applyType = srcData.applyType;
    outData.welderList = List();
    srcData.welderList.forEach((WelderInfo info) {
      WelderInfo welderInfo = WelderInfo();
      if (info?.welderIdPhotoList != null) {
        List<String> welderIdPhotoList = List();
        info?.welderIdPhotoList?.forEach((String uuid) => welderIdPhotoList.add(uuid));
        welderInfo.welderIdPhotoList = welderIdPhotoList;
      }
      if (info?.welderCertPhotoList != null) {
        List<String> welderCertPhotoList = List();
        info?.welderCertPhotoList?.forEach((String uuid) => welderCertPhotoList.add(uuid));
        welderInfo.welderCertPhotoList = welderCertPhotoList;
      }
      welderInfo.welderId = info?.welderId;
      welderInfo.welderName = info?.welderName;
      welderInfo.hotWorkId = info?.hotWorkId;
      welderInfo.workType = info?.workType;
      welderInfo.certificateNo = info?.certificateNo;
      welderInfo.idCardNo = info?.idCardNo;
      outData.welderList.add(welderInfo);
    });
    return outData;
  }
}

@JsonSerializable()
class WelderInfo extends Object {
  @JsonKey(name: 'certificateNo')
  String certificateNo;

  @JsonKey(name: 'hotWorkId')
  int hotWorkId;

  @JsonKey(name: 'idCardNo')
  String idCardNo;

  @JsonKey(name: 'welderCertPhotoList')
  List<String> welderCertPhotoList;

  @JsonKey(name: 'welderId')
  int welderId;

  @JsonKey(name: 'welderIdPhotoList')
  List<String> welderIdPhotoList;

  @JsonKey(name: 'welderName')
  String welderName;

  @JsonKey(name: 'workType')
  String workType;

  WelderInfo({
    this.certificateNo,
    this.hotWorkId,
    this.idCardNo,
    this.welderCertPhotoList,
    this.welderId,
    this.welderIdPhotoList,
    this.welderName,
    this.workType,
  });

  factory WelderInfo.fromJson(Map<String, dynamic> srcJson) => _$WelderInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$WelderInfoToJson(this);
}

@JsonSerializable()
class RecordInfo extends Object {
  @JsonKey(name: 'executorName')
  String executorName;

  @JsonKey(name: 'hotWorkId')
  int hotWorkId;

  //是否通过：0=不通过；1=通过
  @JsonKey(name: 'passFlag')
  String passFlag;

  @JsonKey(name: 'processContent')
  String processContent;

  @JsonKey(name: 'processCustId')
  int processCustId;

  @JsonKey(name: 'processExecutor')
  String processExecutor;

  @JsonKey(name: 'processNodeCode')
  String processNodeCode;

  @JsonKey(name: 'processNodeName')
  String processNodeName;

  @JsonKey(name: 'processPostId')
  int processPostId;

  @JsonKey(name: 'processPostName')
  String processPostName;

  @JsonKey(name: 'processTime')
  String processTime;

  @JsonKey(name: 'processUserId')
  int processUserId;

  @JsonKey(name: 'recordId')
  int recordId;

  @JsonKey(name: 'attDhYzSignList')
  List<Attachment> attDhYzSignList;

  @JsonKey(name: 'attDhZhSignList')
  List<Attachment> attDhZhSignList;

  RecordInfo(
    this.executorName,
    this.hotWorkId,
    this.passFlag,
    this.processContent,
    this.processCustId,
    this.processExecutor,
    this.processNodeCode,
    this.processNodeName,
    this.processPostId,
    this.processPostName,
    this.processTime,
    this.processUserId,
    this.recordId,
    this.attDhYzSignList,
    this.attDhZhSignList,
  );

  factory RecordInfo.fromJson(Map<String, dynamic> srcJson) => _$RecordInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RecordInfoToJson(this);
}
