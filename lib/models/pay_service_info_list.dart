import 'package:json_annotation/json_annotation.dart';

part 'pay_service_info_list.g.dart';


@JsonSerializable()
class PayServiceInfoList extends Object {

  @JsonKey(name: 'appCodes')
  List<String> appCodes;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'data')
  List<PayServiceInfo> data;

  @JsonKey(name: 'extStr')
  String extStr;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'totalCount')
  int totalCount;

  PayServiceInfoList(this.appCodes,this.code,this.data,this.extStr,this.message,this.systemDate,this.totalCount,);

  factory PayServiceInfoList.fromJson(Map<String, dynamic> srcJson) => _$PayServiceInfoListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PayServiceInfoListToJson(this);

}


@JsonSerializable()
class PayServiceInfo extends Object {

  @JsonKey(name: 'createTime')
  String createTime;

  @JsonKey(name: 'createUserId')
  int createUserId;

  @JsonKey(name: 'hasRelease')
  String hasRelease;

  @JsonKey(name: 'posterPhotoList')
  List<PosterPhotoList> posterPhotoList;

  @JsonKey(name: 'priceMax')
  double priceMax;

  @JsonKey(name: 'priceMin')
  double priceMin;

  @JsonKey(name: 'priceUnit')
  String priceUnit;

  @JsonKey(name: 'priceRange')
  String priceRange;

  @JsonKey(name: 'processPostId')
  int processPostId;

  @JsonKey(name: 'processPostName')
  String processPostName;

  @JsonKey(name: 'projectId')
  int projectId;

  @JsonKey(name: 'projectName')
  String projectName;

  @JsonKey(name: 'serviceConfId')
  int serviceConfId;

  @JsonKey(name: 'serviceDesc')
  String serviceDesc;

  @JsonKey(name: 'serviceName')
  String serviceName;

  @JsonKey(name: 'serviceTime')
  String serviceTime;

  @JsonKey(name: 'serviceType')
  String serviceType;

  @JsonKey(name: 'serviceTypeName')
  String serviceTypeName;

  @JsonKey(name: 'showPhotoList')
  List<PosterPhotoList> showPhotoList;

  @JsonKey(name: 'styleListJson')
  String  styleListJson;

  @JsonKey(name: 'styleList')
  List  styleListName;

  @JsonKey(name: 'updateTime')
  String updateTime;

  @JsonKey(name: 'updateUserId')
  int updateUserId;

  @JsonKey(name: 'validFlag')
  String validFlag;

  PayServiceInfo(this.createTime,this.createUserId,this.hasRelease,this.posterPhotoList,this.priceMax,this.priceMin,this.priceUnit,this.priceRange,this.processPostId,this.processPostName,this.projectId,this.projectName,this.serviceConfId,this.serviceDesc,this.serviceName,this.serviceTime,this.serviceType,this.serviceTypeName,this.showPhotoList,this.styleListJson,this.styleListName,this.updateTime,this.updateUserId,this.validFlag,);

  factory PayServiceInfo.fromJson(Map<String, dynamic> srcJson) => _$PayServiceInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PayServiceInfoToJson(this);

}


@JsonSerializable()
class PosterPhotoList extends Object {

  @JsonKey(name: 'uuid')
  String uuid;

  @JsonKey(name: 'url')
  String url;



  PosterPhotoList(this.uuid,this.url,);

  factory PosterPhotoList.fromJson(Map<String, dynamic> srcJson) => _$PosterPhotoListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PosterPhotoListToJson(this);

}




  
