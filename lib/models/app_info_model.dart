import 'package:json_annotation/json_annotation.dart';

part 'app_info_model.g.dart';

@JsonSerializable()
class AppInfoModel extends Object {
  @JsonKey(name: 'appCodes')
  List<String> appCodes;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'data')
  AppInfo appInfo;

  @JsonKey(name: 'extStr')
  String extStr;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'totalCount')
  int totalCount;

  AppInfoModel(
    this.appCodes,
    this.code,
    this.appInfo,
    this.extStr,
    this.message,
    this.systemDate,
    this.totalCount,
  );

  factory AppInfoModel.fromJson(Map<String, dynamic> srcJson) => _$AppInfoModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AppInfoModelToJson(this);
}

@JsonSerializable()
class AppInfo extends Object {
  @JsonKey(name: 'build')
  int build;

  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: 'desc')
  String desc;

  @JsonKey(name: 'id')
  int id;

  //是否强制：1-强制更新，0不强制更新
  @JsonKey(name: 'isForce')
  int isForce;

  @JsonKey(name: 'otherUrl')
  String otherUrl;

  @JsonKey(name: 'systemType')
  String systemType;

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'url')
  String url;

  @JsonKey(name: 'version')
  String version;

  @JsonKey(name: 'size')
  String size;

  @JsonKey(name: 'disabledMenu')
  String disabledMenu;

  @JsonKey(name: 'marketStatement')
  String marketStatement;

  AppInfo(this.build, this.code, this.desc, this.id, this.isForce, this.otherUrl, this.systemType, this.type,
      this.url, this.version, this.size, this.disabledMenu, this.marketStatement);

  factory AppInfo.fromJson(Map<String, dynamic> srcJson) => _$AppInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AppInfoToJson(this);
}
