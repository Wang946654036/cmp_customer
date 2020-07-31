import 'package:cmp_customer/models/meetingroom/meeting_room_info_obj.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reserve_info.g.dart';


@JsonSerializable()
class ReserveInfo extends Object{
  @JsonKey(name: 'actualPay')
  double actualPay;

  @JsonKey(name: 'applicantName')
  String applicantName;

  @JsonKey(name: 'applicatMobile')
  String applicatMobile;

  @JsonKey(name: 'confirmCost')
  double confirmCost;

  @JsonKey(name: 'createTime')
  String createTime;
  @JsonKey(name: 'acceptRemark')
  String acceptRemark;
  @JsonKey(name: 'payRemark')
  String payRemark;

  @JsonKey(name: 'creatorId')
  int creatorId;

  @JsonKey(name: 'estimatedCost')
  double estimatedCost;

  @JsonKey(name: 'estimatedDetail')
  String estimatedDetail;

  @JsonKey(name: 'orderCode')
  String orderCode;

  @JsonKey(name: 'orderId')
  int orderId;



  @JsonKey(name: 'orgId')
  int orgId;

  @JsonKey(name: 'projectId')
  int projectId;

  @JsonKey(name: 'state')
  String state;

  @JsonKey(name: 'stateName')
  String stateName;

  @JsonKey(name: 'updateTime')
  String updateTime;

  @JsonKey(name: 'updaterId')
  int updaterId;
  @JsonKey(name: 'meetingRoomName')
  String meetingRoomName;
  @JsonKey(name: 'orderDates')
  String orderDates;

  @JsonKey(name: 'meetingSubOrderVoList')
  List<MeetingRoomInfo> meetingSubOrderVoList;

  @JsonKey(name:'payPhotoList')
  List<Attachment> payPhotoList;

  ReserveInfo({this.orderDates,this.meetingRoomName,this.actualPay,this.applicantName,this.applicatMobile,this.confirmCost,this.createTime,
    this.creatorId,this.estimatedCost,this.estimatedDetail,this.meetingSubOrderVoList,this.orderCode,
    this.orderId,this.orgId,this.projectId,this.state,this.stateName,this.updateTime,this.acceptRemark,this.payRemark,
    this.updaterId,this.payPhotoList});

  factory ReserveInfo.fromJson(Map<String, dynamic> srcJson) => _$ReserveInfoFromJson(srcJson);

}









