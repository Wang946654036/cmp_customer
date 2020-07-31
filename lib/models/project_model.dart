import 'package:azlistview/azlistview.dart';
import 'package:json_annotation/json_annotation.dart';

part 'project_model.g.dart';


@JsonSerializable()
class ProjectModel extends Object {

  @JsonKey(name: 'appCodes')
  List<String> appCodes;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'data')
  List<ProjectInfo> projectList;

  @JsonKey(name: 'extStr')
  String extStr;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'totalCount')
  int totalCount;

  ProjectModel(this.appCodes,this.code,this.projectList,this.extStr,this.message,this.systemDate,this.totalCount,);

  factory ProjectModel.fromJson(Map<String, dynamic> srcJson) => _$ProjectModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProjectModelToJson(this);

}


@JsonSerializable()
class ProjectInfo extends ISuspensionBean {

  @JsonKey(name: 'alldayTel')
  String alldayTel;

  @JsonKey(name: 'area')
  String area;

  @JsonKey(name: 'buildCount')
  int buildCount;

  @JsonKey(name: 'buildindUnit')
  String buildindUnit;

  @JsonKey(name: 'cheapHouse')
  String cheapHouse;

  @JsonKey(name: 'cheapHouseBuilds')
  int cheapHouseBuilds;

  @JsonKey(name: 'cheapHouseConstructionArea')
  double cheapHouseConstructionArea;

  @JsonKey(name: 'cheapHouseHouses')
  int cheapHouseHouses;

  @JsonKey(name: 'city')
  String city;

  @JsonKey(name: 'clubCount')
  int clubCount;

  @JsonKey(name: 'contractArea')
  double contractArea;

  @JsonKey(name: 'contractMoney')
  double contractMoney;

  @JsonKey(name: 'createTime')
  String createTime;

  @JsonKey(name: 'creator')
  String creator;

  @JsonKey(name: 'creatorId')
  int creatorId;

  @JsonKey(name: 'deliveryHouseholds')
  int deliveryHouseholds;

  @JsonKey(name: 'detailAddress')
  String detailAddress;

  @JsonKey(name: 'developmentCompany')
  String developmentCompany;

  @JsonKey(name: 'endWordDate')
  String endWordDate;

  @JsonKey(name: 'firstJoinDate')
  String firstJoinDate;

  @JsonKey(name: 'firstTakeoverDate')
  String firstTakeoverDate;

  @JsonKey(name: 'formerName')
  String formerName;

  @JsonKey(name: 'greeningRatio')
  String greeningRatio;

  @JsonKey(name: 'landNumber')
  String landNumber;

  @JsonKey(name: 'landUsedNumber')
  String landUsedNumber;

  @JsonKey(name: 'latlon')
  String latlon;

  @JsonKey(name: 'limitedPriceHouse')
  String limitedPriceHouse;

  @JsonKey(name: 'limitedPriceHouseBuilds')
  int limitedPriceHouseBuilds;

  @JsonKey(name: 'limitedPriceHouseConstructionArea')
  double limitedPriceHouseConstructionArea;

  @JsonKey(name: 'limitedPriceHouseHouses')
  int limitedPriceHouseHouses;

  @JsonKey(name: 'listCount')
  int listCount;

  @JsonKey(name: 'managerType')
  String managerType;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'orgId')
  int orgId;

  @JsonKey(name: 'plotRatio')
  String plotRatio;

  @JsonKey(name: 'postcode')
  String postcode;

  @JsonKey(name: 'projectCode')
  String projectCode;

  @JsonKey(name: 'projectFormatType')
  String projectFormatType;

  @JsonKey(name: 'projectHeader')
  String projectHeader;

  @JsonKey(name: 'projectId')
  int projectId;

  @JsonKey(name: 'projectIntrodution')
  String projectIntrodution;

  @JsonKey(name: 'projectNper')
  String projectNper;

  @JsonKey(name: 'projectStatus')
  String projectStatus;

  @JsonKey(name: 'projectType')
  String projectType;

  @JsonKey(name: 'province')
  String province;

  @JsonKey(name: 'shopsCount')
  int shopsCount;

  @JsonKey(name: 'source')
  String source;

  @JsonKey(name: 'startWorkDate')
  String startWorkDate;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'stayinHouseholds')
  int stayinHouseholds;

  @JsonKey(name: 'surfaceParkingCount')
  int surfaceParkingCount;

  @JsonKey(name: 'swimmingPoolCount')
  int swimmingPoolCount;

  @JsonKey(name: 'totalConstructionArea')
  double totalConstructionArea;

  @JsonKey(name: 'totalCoverArea')
  double totalCoverArea;

  @JsonKey(name: 'totalHouseholds')
  int totalHouseholds;

  @JsonKey(name: 'undergroudParkingCount')
  int undergroudParkingCount;

  @JsonKey(name: 'updaterTime')
  String updaterTime;

  @JsonKey(name: 'updator')
  String updator;

  @JsonKey(name: 'updatorId')
  int updatorId;

  @JsonKey(name: 'tagIndex')
  String tagIndex;//排序标志

  ProjectInfo({this.alldayTel,this.area,this.buildCount,this.buildindUnit,this.cheapHouse,this.cheapHouseBuilds,this.cheapHouseConstructionArea,this.cheapHouseHouses,this.city,this.clubCount,this.contractArea,this.contractMoney,this.createTime,this.creator,this.creatorId,this.deliveryHouseholds,this.detailAddress,this.developmentCompany,this.endWordDate,this.firstJoinDate,this.firstTakeoverDate,this.formerName,this.greeningRatio,this.landNumber,this.landUsedNumber,this.latlon,this.limitedPriceHouse,this.limitedPriceHouseBuilds,this.limitedPriceHouseConstructionArea,this.limitedPriceHouseHouses,this.listCount,this.managerType,this.name,this.orgId,this.plotRatio,this.postcode,this.projectCode,this.projectFormatType,this.projectHeader,this.projectId,this.projectIntrodution,this.projectNper,this.projectStatus,this.projectType,this.province,this.shopsCount,this.source,this.startWorkDate,this.status,this.stayinHouseholds,this.surfaceParkingCount,this.swimmingPoolCount,this.totalConstructionArea,this.totalCoverArea,this.totalHouseholds,this.undergroudParkingCount,this.updaterTime,this.updator,this.updatorId,this.tagIndex});

  factory ProjectInfo.fromJson(Map<String, dynamic> srcJson) => _$ProjectInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProjectInfoToJson(this);


  @override
  String getSuspensionTag() => tagIndex;

}


