// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ware_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WareDetailModel _$WareDetailModelFromJson(Map<String, dynamic> json) {
  return WareDetailModel(
    browseCount: json['browseCount'] as int,
    city: json['city'] as String,
    content: json['content'] as String,
    createTime: json['createTime'] as String,
    custAppId: json['custAppId'] as int,
    customerType: json['customerType'] as int,
    deleteReason: json['deleteReason'] as String,
    deleteUser: json['deleteUser'] as int,
    likeCount: json['likeCount'] as int,
    nickName: json['nickName'] as String,
    picAttachmentList: (json['picAttachmentList'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    price: json['price'],
    priceBak: json['priceBak'],
    priceDescribe: json['priceDescribe'] as String,
    projectId: json['projectId'] as int,
    projectName: json['projectName'] as String,
    status: json['status'] as String,
    title: json['title'] as String,
    tradingOpt: json['tradingOpt'] as String,
    tradingType: json['tradingType'] as String,
    updateTime: json['updateTime'] as String,
    userPicture: json['userPicture'] == null
        ? null
        : Attachment.fromJson(json['userPicture'] as Map<String, dynamic>),
    waresId: json['waresId'] as int,
    waresType: json['waresType'] as String,
    waresTypeName: json['waresTypeName'] as String,
    wareCommentCount: json['wareCommentCount'] as int,
    commentCount: json['commentCount'] as int,
    userIsCollect: json['userIsCollect'] as bool,
    userIsLike: json['userIsLike'] as bool,
  );
}

Map<String, dynamic> _$WareDetailModelToJson(WareDetailModel instance) =>
    <String, dynamic>{
      'browseCount': instance.browseCount,
      'city': instance.city,
      'content': instance.content,
      'createTime': instance.createTime,
      'custAppId': instance.custAppId,
      'customerType': instance.customerType,
      'deleteReason': instance.deleteReason,
      'deleteUser': instance.deleteUser,
      'likeCount': instance.likeCount,
      'nickName': instance.nickName,
      'picAttachmentList': instance.picAttachmentList,
      'price': instance.price,
      'priceBak': instance.priceBak,
      'priceDescribe': instance.priceDescribe,
      'projectId': instance.projectId,
      'projectName': instance.projectName,
      'status': instance.status,
      'title': instance.title,
      'tradingOpt': instance.tradingOpt,
      'tradingType': instance.tradingType,
      'updateTime': instance.updateTime,
      'userPicture': instance.userPicture,
      'waresId': instance.waresId,
      'waresType': instance.waresType,
      'waresTypeName': instance.waresTypeName,
      'wareCommentCount': instance.wareCommentCount,
      'commentCount': instance.commentCount,
      'userIsLike': instance.userIsLike,
      'userIsCollect': instance.userIsCollect,
    };
