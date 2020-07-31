import 'package:json_annotation/json_annotation.dart';

part 'house_list_model.g.dart';

@JsonSerializable()
class HouseListModel extends Object {
  @JsonKey(name: 'appCodes')
  List<String> appCodes;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'data')
  List<HouseAddr> houseList;

  @JsonKey(name: 'extStr')
  String extStr;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'totalCount')
  int totalCount;

  HouseListModel(
    this.appCodes,
    this.code,
    this.houseList,
    this.extStr,
    this.message,
    this.systemDate,
    this.totalCount,
  );

  factory HouseListModel.fromJson(Map<String, dynamic> srcJson) => _$HouseListModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HouseListModelToJson(this);
}

@JsonSerializable()
class HouseAddr extends Object {
  @JsonKey(name: 'areaId')
  int areaId;

  @JsonKey(name: 'attachment')
  String attachment;

  @JsonKey(name: 'attachmentNum')
  int attachmentNum;

  @JsonKey(name: 'buildCode')
  String buildCode;

  @JsonKey(name: 'buildId')
  int buildId;

  @JsonKey(name: 'buildType')
  String buildType;

  @JsonKey(name: 'buildingHeight')
  double  buildingHeight;

  @JsonKey(name: 'constructionArea')
  double constructionArea;

  @JsonKey(name: 'createTime')
  String createTime;

  @JsonKey(name: 'creator')
  String creator;

  @JsonKey(name: 'creatorId')
  int creatorId;

  @JsonKey(name: 'description')
  String description;

  @JsonKey(name: 'groundBuildingHeight')
  double groundBuildingHeight;

  @JsonKey(name: 'groundLayer')
  int groundLayer;

  @JsonKey(name: 'layerHouseholds')
  int layerHouseholds;

  @JsonKey(name: 'liftTotal')
  int liftTotal;

  @JsonKey(name: 'name')
  String name;

//  @JsonKey(name: 'projectAging')
//  String projectAging;

  @JsonKey(name: 'projectId')
  int projectId;

  @JsonKey(name: 'singleOwner')
  String singleOwner;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'totalLayer')
  int totalLayer;

  @JsonKey(name: 'undergroundBuildingHeight')
  double undergroundBuildingHeight;

  @JsonKey(name: 'unsergroundLayer')
  int unsergroundLayer;

  @JsonKey(name: 'updaterTime')
  String updaterTime;

  @JsonKey(name: 'updator')
  String updator;

  @JsonKey(name: 'updatorId')
  int updatorId;

  //单元id
  @JsonKey(name: 'unitId')
  int unitId;

  //房号id
  @JsonKey(name: 'houseId')
  int houseId;

  //房号
  @JsonKey(name: 'houseNo')
  String houseNo;

  HouseAddr(
    this.areaId,
    this.attachment,
    this.attachmentNum,
    this.buildCode,
    this.buildId,
    this.buildType,
    this.buildingHeight,
    this.constructionArea,
    this.createTime,
    this.creator,
    this.creatorId,
    this.description,
    this.groundBuildingHeight,
    this.groundLayer,
    this.layerHouseholds,
    this.liftTotal,
    this.name,
//    this.projectAging,
    this.projectId,
    this.singleOwner,
    this.status,
    this.totalLayer,
    this.undergroundBuildingHeight,
    this.unsergroundLayer,
    this.updaterTime,
    this.updator,
    this.updatorId,
    this.unitId,
    this.houseId,
    this.houseNo,
  );

  factory HouseAddr.fromJson(Map<String, dynamic> srcJson) => _$HouseAddrFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HouseAddrToJson(this);
}
