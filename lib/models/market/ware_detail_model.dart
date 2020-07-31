import 'package:json_annotation/json_annotation.dart';

import '../user_data_model.dart';
  
part 'ware_detail_model.g.dart';


@JsonSerializable()
  class WareDetailModel extends Object {

  @JsonKey(name: 'browseCount')
  int browseCount;

  @JsonKey(name: 'city')
  String city;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'createTime')
  String createTime;

  @JsonKey(name: 'custAppId')
  int custAppId;

  @JsonKey(name: 'customerType')
  int customerType;

  @JsonKey(name: 'deleteReason')
  String deleteReason;

  @JsonKey(name: 'deleteUser')
  int deleteUser;

  @JsonKey(name: 'likeCount')
  int likeCount;

  @JsonKey(name: 'nickName')
  String nickName;

  @JsonKey(name: 'picAttachmentList')
  List<Attachment> picAttachmentList;

  @JsonKey(name: 'price')
  var price;

  @JsonKey(name: 'priceBak')
  var priceBak;

  @JsonKey(name: 'priceDescribe')
  String priceDescribe;

  @JsonKey(name: 'projectId')
  int projectId;

  @JsonKey(name: 'projectName')
  String projectName;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'tradingOpt')
  String tradingOpt;

  @JsonKey(name: 'tradingType')
  String tradingType;

  @JsonKey(name: 'updateTime')
  String updateTime;

  @JsonKey(name: 'userPicture')
  Attachment userPicture;

  @JsonKey(name: 'waresId')
  int waresId;

  @JsonKey(name: 'waresType')
  String waresType;

  @JsonKey(name: 'waresTypeName')
  String waresTypeName;

  @JsonKey(name: 'wareCommentCount')
  int wareCommentCount;

  @JsonKey(name: 'commentCount')
  int commentCount;

  @JsonKey(name: 'userIsLike')
  bool userIsLike;

  @JsonKey(name: 'userIsCollect')
  bool userIsCollect;


  WareDetailModel({this.browseCount,this.city,this.content,this.createTime,this.custAppId,this.customerType,this.deleteReason,this.deleteUser,this.likeCount,this.nickName,this.picAttachmentList,this.price,this.priceBak,this.priceDescribe,this.projectId,this.projectName,this.status,this.title,this.tradingOpt,this.tradingType,this.updateTime,this.userPicture,this.waresId,this.waresType,this.waresTypeName,this.wareCommentCount,this.commentCount,this.userIsCollect,this.userIsLike});

  factory WareDetailModel.fromJson(Map<String, dynamic> srcJson) => _$WareDetailModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$WareDetailModelToJson(this);

}

  
