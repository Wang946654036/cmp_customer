import 'package:cmp_customer/models/meetingroom/meeting_room_info_obj.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meeting_room_info_list_obj.g.dart';

@JsonSerializable()
class MeetingRoomInfoListObj extends Object {

  @JsonKey(name: 'appCodes')
  List<String> appCodes;

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'data')
  List<MeetingRoomInfo> data;

  @JsonKey(name: 'extStr')
  String extStr;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'systemDate')
  String systemDate;

  @JsonKey(name: 'totalCount')
  int totalCount;

  MeetingRoomInfoListObj({this.appCodes,this.code,this.data,this.extStr,this.message,this.systemDate,this.totalCount,});

  factory MeetingRoomInfoListObj.fromJson(Map<String, dynamic> srcJson) => _$MeetingRoomInfoListObjFromJson(srcJson);

}