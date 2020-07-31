// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'house_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HouseListModel _$HouseListModelFromJson(Map<String, dynamic> json) {
  return HouseListModel(
    (json['appCodes'] as List)?.map((e) => e as String)?.toList(),
    json['code'] as String,
    (json['data'] as List)
        ?.map((e) =>
            e == null ? null : HouseAddr.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['extStr'] as String,
    json['message'] as String,
    json['systemDate'] as String,
    json['totalCount'] as int,
  );
}

Map<String, dynamic> _$HouseListModelToJson(HouseListModel instance) =>
    <String, dynamic>{
      'appCodes': instance.appCodes,
      'code': instance.code,
      'data': instance.houseList,
      'extStr': instance.extStr,
      'message': instance.message,
      'systemDate': instance.systemDate,
      'totalCount': instance.totalCount,
    };

HouseAddr _$HouseAddrFromJson(Map<String, dynamic> json) {
  return HouseAddr(
    json['areaId'] as int,
    json['attachment'] as String,
    json['attachmentNum'] as int,
    json['buildCode'] as String,
    json['buildId'] as int,
    json['buildType'] as String,
    (json['buildingHeight'] as num)?.toDouble(),
    (json['constructionArea'] as num)?.toDouble(),
    json['createTime'] as String,
    json['creator'] as String,
    json['creatorId'] as int,
    json['description'] as String,
    (json['groundBuildingHeight'] as num)?.toDouble(),
    json['groundLayer'] as int,
    json['layerHouseholds'] as int,
    json['liftTotal'] as int,
    json['name'] as String,
    json['projectId'] as int,
    json['singleOwner'] as String,
    json['status'] as String,
    json['totalLayer'] as int,
    (json['undergroundBuildingHeight'] as num)?.toDouble(),
    json['unsergroundLayer'] as int,
    json['updaterTime'] as String,
    json['updator'] as String,
    json['updatorId'] as int,
    json['unitId'] as int,
    json['houseId'] as int,
    json['houseNo'] as String,
  );
}

Map<String, dynamic> _$HouseAddrToJson(HouseAddr instance) => <String, dynamic>{
      'areaId': instance.areaId,
      'attachment': instance.attachment,
      'attachmentNum': instance.attachmentNum,
      'buildCode': instance.buildCode,
      'buildId': instance.buildId,
      'buildType': instance.buildType,
      'buildingHeight': instance.buildingHeight,
      'constructionArea': instance.constructionArea,
      'createTime': instance.createTime,
      'creator': instance.creator,
      'creatorId': instance.creatorId,
      'description': instance.description,
      'groundBuildingHeight': instance.groundBuildingHeight,
      'groundLayer': instance.groundLayer,
      'layerHouseholds': instance.layerHouseholds,
      'liftTotal': instance.liftTotal,
      'name': instance.name,
      'projectId': instance.projectId,
      'singleOwner': instance.singleOwner,
      'status': instance.status,
      'totalLayer': instance.totalLayer,
      'undergroundBuildingHeight': instance.undergroundBuildingHeight,
      'unsergroundLayer': instance.unsergroundLayer,
      'updaterTime': instance.updaterTime,
      'updator': instance.updator,
      'updatorId': instance.updatorId,
      'unitId': instance.unitId,
      'houseId': instance.houseId,
      'houseNo': instance.houseNo,
    };
