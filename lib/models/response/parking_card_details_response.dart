import 'package:cmp_customer/models/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'parking_card_details_response.g.dart';

@JsonSerializable()
class ParkingCardDetailsResponse extends BaseResponse{
  @JsonKey(name: 'data')
  ParkingCardDetailsInfo parkingCardDetailsInfo;

  ParkingCardDetailsResponse({this.parkingCardDetailsInfo,});

  factory ParkingCardDetailsResponse.fromJson(Map<String, dynamic> srcJson) => _$ParkingCardDetailsResponseFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ParkingCardDetailsResponseToJson(this);

}


@JsonSerializable()
class ParkingCardDetailsInfo extends Object {

  @JsonKey(name: 'parkingId')
  int parkingId;//停车办理业务id

  @JsonKey(name: 'parkingInfoId')
  int parkingInfoId;//停车办理月卡id

  @JsonKey(name: 'projectId')
  int projectId;//项目id

  @JsonKey(name: 'buildId')
  int buildId;//楼栋id

  @JsonKey(name: 'unitId')
  int unitId;//单元id

  @JsonKey(name: 'houseId')
  int houseId;//房屋id

  @JsonKey(name: 'houseNo')
  String houseNo;//房屋号

  @JsonKey(name: 'type')
  String type;//办理类型：XK-新卡申请、XF-续费、TZ-退租

  @JsonKey(name: 'businessNo')
  String businessNo;//业务单号

  @JsonKey(name: 'parkingLotId')
  int parkingLotId;//停车场id

  @JsonKey(name: 'parkingLot')
  String parkingLot;//停车场名称

  @JsonKey(name: 'parkingPackageId')
  int parkingPackageId;//停车场套餐id

  @JsonKey(name: 'parkingPackage')
  String parkingPackage;//停车场套餐

  @JsonKey(name: 'carNo')
  String carNo;//车牌号

  @JsonKey(name: 'carBrand')
  String carBrand;//车辆品牌

  @JsonKey(name: 'carColor')
  String carColor;//车辆颜色

  @JsonKey(name: 'carOwnerName')
  String carOwnerName;//车主姓名

  @JsonKey(name: 'carOwnerPhone')
  String carOwnerPhone;//车主电话

  @JsonKey(name: 'applyMonths')
  int applyMonths;//申请时长（月）

  @JsonKey(name: 'payFees')
  double payFees;//支付金额

  @JsonKey(name: 'paybackFees')
  double paybackFees;//可退金额

  @JsonKey(name: 'customerId')
  int customerId;//客户id

  @JsonKey(name: 'customerName')
  String customerName;//客户名称

  @JsonKey(name: 'customerPhone')
  String customerPhone;//客户电话

  @JsonKey(name: 'status')
  String status;//新卡申请、续费进度状态：DSH-待审核、SHBTG-审核不通过、DZF-待支付、YWC-已完成、YQX-已取消；退租进度状态：DSL-待受理、DQR-待确认、YWC-已完成、YQX-已取消

  @JsonKey(name: 'statusDesc')
  String statusDesc;//新卡申请、续费进度状态：DSH-待审核、SHBTG-审核不通过、DZF-待支付、YWC-已完成、YQX-已取消；退租进度状态：DSL-待受理、DQR-待确认、YWC-已完成、YQX-已取消

  @JsonKey(name: 'remark')
  String remark;//备注

  @JsonKey(name: 'createTime')
  String createTime;//创建时间

  @JsonKey(name: 'registerTime')
  String registerTime;//申请时间

  @JsonKey(name: 'updateTime')
  String updateTime;//更新时间

  @JsonKey(name: 'payTime')
  String payTime;//支付时间

  @JsonKey(name: 'payType')
  String payType;//支付方式  XSZF-线上支付、XXZF-线下支付

  @JsonKey(name: 'effectTime')
  String effectTime;//生效时间

  @JsonKey(name: 'formerStartTime')
  String formerStartTime;//原有效开始时间

  @JsonKey(name: 'formerEndTime')
  String formerEndTime;//原有效结束时间

  @JsonKey(name: 'validStartTime')
  String validStartTime;//续费有效开始时间

  @JsonKey(name: 'validEndTime')
  String validEndTime;//续费有效结束时间

  @JsonKey(name: 'cancelEndTime')
  String cancelEndTime;//提前终止时间

  @JsonKey(name: 'recordList')
  List<RecordList> recordList;//流程记录列表

  @JsonKey(name: 'attList')
  List<String> attList;//行驶证图片UUID列表

  ParkingCardDetailsInfo({this.parkingId,this.projectId,this.buildId,this.unitId,this.houseId,this.houseNo,this.type,this.businessNo,this.parkingLotId,this.parkingLot,this.parkingPackageId,this.parkingPackage,this.carNo,this.carBrand,this.carColor,this.carOwnerName,this.carOwnerPhone,this.applyMonths,this.payFees,this.customerId,this.customerName,this.customerPhone,this.status,this.remark,this.registerTime,this.updateTime,this.cancelEndTime,this.recordList,this.effectTime});

  factory ParkingCardDetailsInfo.fromJson(Map<String, dynamic> srcJson) => _$ParkingCardDetailsInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ParkingCardDetailsInfoToJson(this);

}


@JsonSerializable()
class RecordList extends Object {

  @JsonKey(name: 'recordId')
  int recordId;//流程记录表id

  @JsonKey(name: 'parkingId')
  int parkingId;//停车办理业务id

  @JsonKey(name: 'attachmentFlag')
  String attachmentFlag;//附件标识：YES-有、NO-无

  @JsonKey(name: 'operateStep')
  String operateStep;//流程节点

  @JsonKey(name: 'operateStepDesc')
  String operateStepDesc;//流程节点中文

  @JsonKey(name: 'statusDesc')
  String statusDesc;

  @JsonKey(name: 'status')
  String status;//新卡申请、续费进度状态

  @JsonKey(name: 'creatorId')
  int creatorId;//创建人id

  @JsonKey(name: 'creator')
  String creator;//创建人

  @JsonKey(name: 'createTime')
  String createTime;//创建时间

  @JsonKey(name: 'remark')
  String remark;//  备注（审核意见）

  @JsonKey(name: 'attList')
  List<AttList> attList;

  RecordList(this.recordId,this.parkingId,this.attachmentFlag,this.status,this.creatorId,this.creator,this.createTime,this.attList,this.remark,this.operateStep);

  factory RecordList.fromJson(Map<String, dynamic> srcJson) => _$RecordListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RecordListToJson(this);

}


@JsonSerializable()
class AttList extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'source')
  String source;

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'relatedId')
  int relatedId;

  @JsonKey(name: 'attachmentUuid')
  String attachmentUuid;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'createTime')
  String createTime;

  AttList(this.id,this.source,this.type,this.relatedId,this.attachmentUuid,this.status,this.createTime,);

  factory AttList.fromJson(Map<String, dynamic> srcJson) => _$AttListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AttListToJson(this);

}


