import 'package:cmp_customer/models/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'door_list_response.g.dart';

@JsonSerializable()
class DoorListResponse extends BaseResponse {
  @JsonKey(name: 'data')
  List<DoorInfo> doorList;

  DoorListResponse(this.doorList);

  factory DoorListResponse.fromJson(Map<String, dynamic> srcJson) => _$DoorListResponseFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DoorListResponseToJson(this);
}

@JsonSerializable()
class DoorInfo extends Object {
  @JsonKey(name: 'mode')
  List<Mode> mode;

  @JsonKey(name: 'project_id')
  String projectId;

  @JsonKey(name: 'project_name')
  String projectName;

  @JsonKey(name: 'user_type')
  String userType;

  DoorInfo(this.mode, this.projectId, this.projectName, this.userType);

  factory DoorInfo.fromJson(Map<String, dynamic> srcJson) => _$DoorInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DoorInfoToJson(this);
}

@JsonSerializable()
class Mode extends Object {
  @JsonKey(name: 'device_list')
  List<DeviceInfo> deviceList;

  @JsonKey(name: 'mode_name')
  String modeName;

  @JsonKey(name: 'mode_type')
  String modeType;

  Mode(
    this.deviceList,
    this.modeName,
    this.modeType,
  );

  factory Mode.fromJson(Map<String, dynamic> srcJson) => _$ModeFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ModeToJson(this);
}

@JsonSerializable()
class DeviceInfo extends Object {
  @JsonKey(name: 'projectId')
  int projectId; //项目id

  @JsonKey(name: 'lockid')
  String lockid; //设备lockid（蓝牙开门使用）

  @JsonKey(name: 'device_code')
  String deviceCode;

  @JsonKey(name: 'device_name')
  String deviceName;

  @JsonKey(name: 'mode_type')
  String modeType;

  @JsonKey(name: 'project_name')
  String projectName;

  @JsonKey(name: 'device_checked')
  bool checked;

  //设备厂商:1-拓桥,2-得令,3-智锁
  @JsonKey(name: 'device_factory')
  String deviceFactory;

  @JsonKey(name: 'hexkey')
  String hexKey;

  DeviceInfo(this.projectId, this.lockid, this.deviceCode, this.deviceName, this.modeType, this.projectName,
      this.checked, this.deviceFactory, this.hexKey);

  factory DeviceInfo.fromJson(Map<String, dynamic> srcJson) => _$DeviceInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DeviceInfoToJson(this);
}

@JsonSerializable()
class UsedDoor extends Object {
  @JsonKey(name: 'data')
  List<DeviceInfo> usedList; //常用列表

  UsedDoor(this.usedList);

  factory UsedDoor.fromJson(Map<String, dynamic> srcJson) => _$UsedDoorFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UsedDoorToJson(this);
}

//@JsonSerializable()
//class UsedDoorInfo extends Object{
//
//  @JsonKey(name: 'project_name')
//  String projectName; //项目名称
//
//  @JsonKey(name: 'mode_type')
//  String modeType;//开门类型（蓝牙或者网络）
//
//  @JsonKey(name: 'lockid')
//  String lockid;//设备lockid（蓝牙开门使用）
//
//  @JsonKey(name: 'device_code')
//  String deviceCode;//门编号或pid（开门使用）
//
//  @JsonKey(name: 'device_name')
//  String deviceName;//门名称
//
//  UsedDoorInfo(this.projectName,this.modeType,this.deviceName,this.deviceCode,this.lockid);
//
//  factory UsedDoorInfo.fromJson(Map<String, dynamic> srcJson) => _$UsedDoorInfoFromJson(srcJson);
//
//  Map<String, dynamic> toJson() => _$UsedDoorInfoToJson(this);
//}
