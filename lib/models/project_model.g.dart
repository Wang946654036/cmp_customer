// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectModel _$ProjectModelFromJson(Map<String, dynamic> json) {
  return ProjectModel(
    (json['appCodes'] as List)?.map((e) => e as String)?.toList(),
    json['code'] as String,
    (json['data'] as List)
        ?.map((e) =>
            e == null ? null : ProjectInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['extStr'] as String,
    json['message'] as String,
    json['systemDate'] as String,
    json['totalCount'] as int,
  );
}

Map<String, dynamic> _$ProjectModelToJson(ProjectModel instance) =>
    <String, dynamic>{
      'appCodes': instance.appCodes,
      'code': instance.code,
      'data': instance.projectList,
      'extStr': instance.extStr,
      'message': instance.message,
      'systemDate': instance.systemDate,
      'totalCount': instance.totalCount,
    };

ProjectInfo _$ProjectInfoFromJson(Map<String, dynamic> json) {
  return ProjectInfo(
    alldayTel: json['alldayTel'] as String,
    area: json['area'] as String,
    buildCount: json['buildCount'] as int,
    buildindUnit: json['buildindUnit'] as String,
    cheapHouse: json['cheapHouse'] as String,
    cheapHouseBuilds: json['cheapHouseBuilds'] as int,
    cheapHouseConstructionArea:
        (json['cheapHouseConstructionArea'] as num)?.toDouble(),
    cheapHouseHouses: json['cheapHouseHouses'] as int,
    city: json['city'] as String,
    clubCount: json['clubCount'] as int,
    contractArea: (json['contractArea'] as num)?.toDouble(),
    contractMoney: (json['contractMoney'] as num)?.toDouble(),
    createTime: json['createTime'] as String,
    creator: json['creator'] as String,
    creatorId: json['creatorId'] as int,
    deliveryHouseholds: json['deliveryHouseholds'] as int,
    detailAddress: json['detailAddress'] as String,
    developmentCompany: json['developmentCompany'] as String,
    endWordDate: json['endWordDate'] as String,
    firstJoinDate: json['firstJoinDate'] as String,
    firstTakeoverDate: json['firstTakeoverDate'] as String,
    formerName: json['formerName'] as String,
    greeningRatio: json['greeningRatio'] as String,
    landNumber: json['landNumber'] as String,
    landUsedNumber: json['landUsedNumber'] as String,
    latlon: json['latlon'] as String,
    limitedPriceHouse: json['limitedPriceHouse'] as String,
    limitedPriceHouseBuilds: json['limitedPriceHouseBuilds'] as int,
    limitedPriceHouseConstructionArea:
        (json['limitedPriceHouseConstructionArea'] as num)?.toDouble(),
    limitedPriceHouseHouses: json['limitedPriceHouseHouses'] as int,
    listCount: json['listCount'] as int,
    managerType: json['managerType'] as String,
    name: json['name'] as String,
    orgId: json['orgId'] as int,
    plotRatio: json['plotRatio'] as String,
    postcode: json['postcode'] as String,
    projectCode: json['projectCode'] as String,
    projectFormatType: json['projectFormatType'] as String,
    projectHeader: json['projectHeader'] as String,
    projectId: json['projectId'] as int,
    projectIntrodution: json['projectIntrodution'] as String,
    projectNper: json['projectNper'] as String,
    projectStatus: json['projectStatus'] as String,
    projectType: json['projectType'] as String,
    province: json['province'] as String,
    shopsCount: json['shopsCount'] as int,
    source: json['source'] as String,
    startWorkDate: json['startWorkDate'] as String,
    status: json['status'] as String,
    stayinHouseholds: json['stayinHouseholds'] as int,
    surfaceParkingCount: json['surfaceParkingCount'] as int,
    swimmingPoolCount: json['swimmingPoolCount'] as int,
    totalConstructionArea: (json['totalConstructionArea'] as num)?.toDouble(),
    totalCoverArea: (json['totalCoverArea'] as num)?.toDouble(),
    totalHouseholds: json['totalHouseholds'] as int,
    undergroudParkingCount: json['undergroudParkingCount'] as int,
    updaterTime: json['updaterTime'] as String,
    updator: json['updator'] as String,
    updatorId: json['updatorId'] as int,
    tagIndex: json['tagIndex'] as String,
  )..isShowSuspension = json['isShowSuspension'] as bool;
}

Map<String, dynamic> _$ProjectInfoToJson(ProjectInfo instance) =>
    <String, dynamic>{
      'isShowSuspension': instance.isShowSuspension,
      'alldayTel': instance.alldayTel,
      'area': instance.area,
      'buildCount': instance.buildCount,
      'buildindUnit': instance.buildindUnit,
      'cheapHouse': instance.cheapHouse,
      'cheapHouseBuilds': instance.cheapHouseBuilds,
      'cheapHouseConstructionArea': instance.cheapHouseConstructionArea,
      'cheapHouseHouses': instance.cheapHouseHouses,
      'city': instance.city,
      'clubCount': instance.clubCount,
      'contractArea': instance.contractArea,
      'contractMoney': instance.contractMoney,
      'createTime': instance.createTime,
      'creator': instance.creator,
      'creatorId': instance.creatorId,
      'deliveryHouseholds': instance.deliveryHouseholds,
      'detailAddress': instance.detailAddress,
      'developmentCompany': instance.developmentCompany,
      'endWordDate': instance.endWordDate,
      'firstJoinDate': instance.firstJoinDate,
      'firstTakeoverDate': instance.firstTakeoverDate,
      'formerName': instance.formerName,
      'greeningRatio': instance.greeningRatio,
      'landNumber': instance.landNumber,
      'landUsedNumber': instance.landUsedNumber,
      'latlon': instance.latlon,
      'limitedPriceHouse': instance.limitedPriceHouse,
      'limitedPriceHouseBuilds': instance.limitedPriceHouseBuilds,
      'limitedPriceHouseConstructionArea':
          instance.limitedPriceHouseConstructionArea,
      'limitedPriceHouseHouses': instance.limitedPriceHouseHouses,
      'listCount': instance.listCount,
      'managerType': instance.managerType,
      'name': instance.name,
      'orgId': instance.orgId,
      'plotRatio': instance.plotRatio,
      'postcode': instance.postcode,
      'projectCode': instance.projectCode,
      'projectFormatType': instance.projectFormatType,
      'projectHeader': instance.projectHeader,
      'projectId': instance.projectId,
      'projectIntrodution': instance.projectIntrodution,
      'projectNper': instance.projectNper,
      'projectStatus': instance.projectStatus,
      'projectType': instance.projectType,
      'province': instance.province,
      'shopsCount': instance.shopsCount,
      'source': instance.source,
      'startWorkDate': instance.startWorkDate,
      'status': instance.status,
      'stayinHouseholds': instance.stayinHouseholds,
      'surfaceParkingCount': instance.surfaceParkingCount,
      'swimmingPoolCount': instance.swimmingPoolCount,
      'totalConstructionArea': instance.totalConstructionArea,
      'totalCoverArea': instance.totalCoverArea,
      'totalHouseholds': instance.totalHouseholds,
      'undergroudParkingCount': instance.undergroudParkingCount,
      'updaterTime': instance.updaterTime,
      'updator': instance.updator,
      'updatorId': instance.updatorId,
      'tagIndex': instance.tagIndex,
    };
