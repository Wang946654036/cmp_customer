import 'package:json_annotation/json_annotation.dart';

part 'share_info_model.g.dart';


@JsonSerializable()
class ShareInfoModel extends Object {

  @JsonKey(name: 'title')
  String title;//分享标题

  @JsonKey(name: 'imageUrl')
  String imageUrl;//分享图片地址

  @JsonKey(name: 'content')
  String content;//分享内容

  @JsonKey(name: 'url')
  String url;//分享地址

  @JsonKey(name: 'type')
  String type;//分享类型

  ShareInfoModel(this.title,this.imageUrl,this.content,this.url,this.type);

  factory ShareInfoModel.fromJson(Map<String, dynamic> srcJson) => _$ShareInfoModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ShareInfoModelToJson(this);

}


