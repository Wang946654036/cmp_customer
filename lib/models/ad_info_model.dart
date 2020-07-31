import 'package:json_annotation/json_annotation.dart';

part 'ad_info_model.g.dart';


@JsonSerializable()
class AdInfoModel extends Object {

  @JsonKey(name: 'appCodes')
  List<String> appCodes;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'data')
  List<AdInfo> adInfo;

  @JsonKey(name: 'extStr')
  String extStr;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'totalCount')
  int totalCount;

  AdInfoModel(this.appCodes,this.code,this.adInfo,this.extStr,this.message,this.systemDate,this.totalCount,);

  factory AdInfoModel.fromJson(Map<String, dynamic> srcJson) => _$AdInfoModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AdInfoModelToJson(this);

}


@JsonSerializable()
class AdInfo extends Object {

  @JsonKey(name: 'beginTime')
  String beginTime;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'endTime')
  String endTime;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'imgUrl')
  String imgUrl;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'toUrl')
  String toUrl;

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'foreign')
  String foreign;

  AdInfo({this.beginTime,this.content,this.endTime,this.id,this.imgUrl,this.title,this.toUrl,this.type,this.foreign,});

  factory AdInfo.fromJson(Map<String, dynamic> srcJson) => _$AdInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AdInfoToJson(this);

}


