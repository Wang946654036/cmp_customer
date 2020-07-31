import 'package:json_annotation/json_annotation.dart';

part 'banner_model.g.dart';


@JsonSerializable()
class BannerModel extends Object {

  @JsonKey(name: 'appCodes')
  List<String> appCodes;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'data')
  List<BannerInfo> bannerList;

  @JsonKey(name: 'extStr')
  String extStr;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'totalCount')
  int totalCount;

  BannerModel(this.appCodes,this.code,this.bannerList,this.extStr,this.message,this.systemDate,this.totalCount,);

  factory BannerModel.fromJson(Map<String, dynamic> srcJson) => _$BannerModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BannerModelToJson(this);

}


@JsonSerializable()
class BannerInfo extends Object {

  @JsonKey(name: 'bannerId')
  int bannerId;

  @JsonKey(name: 'id')
  int id;

  //类型：1-网页链接，2-图片链接，3-内部链接
  @JsonKey(name: 'type')
  int type;

  //链接地址
  @JsonKey(name: 'url')
  String url;

  //图片的uuid
  @JsonKey(name: 'uuid')
  String uuid;

  //图片的标题
  @JsonKey(name: 'imgTitle')
  String title;

  BannerInfo(this.bannerId,this.id,this.type,this.url,this.uuid,this.title);

  factory BannerInfo.fromJson(Map<String, dynamic> srcJson) => _$BannerInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BannerInfoToJson(this);

}


