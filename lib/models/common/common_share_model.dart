import 'package:sharesdk_plugin/sharesdk_plugin.dart';

class CommonShareModel {
  String title; //标题
  String text; //文本
  String thumbImageUrl; //缩略图地址
  String url; //分享内容（链接地址、文件路径）
  CommonShareModel({this.title,this.text,this.thumbImageUrl,this.url});
}

class CommonShareItemModel {
  String image; //图标
  String name; //内容
  ShareSDKPlatform platform;
  CommonShareItemModel(this.image,this.name,this.platform);
}