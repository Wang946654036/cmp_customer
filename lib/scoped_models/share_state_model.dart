//
//import 'package:cmp_customer/models/common/common_share_model.dart';
//import 'package:cmp_customer/models/common/common_share_model.dart';
//import 'package:cmp_customer/models/common/common_share_model.dart';
//import 'package:cmp_customer/utils/ui_data.dart';
//import 'package:flutter/widgets.dart';
//import 'package:scoped_model/scoped_model.dart';
//import 'package:sharesdk/sharesdk.dart';
//
//class ShareStateModel{
//  final List<CommonShareItemModel> itemModels = [
//    CommonShareItemModel(UIData.imageShareWechat,"微信"),
//    CommonShareItemModel(UIData.imageShareWechatMoments,"朋友圈"),
//    CommonShareItemModel(UIData.imageShareWechatFavorite,"微信收藏"),
//    CommonShareItemModel(UIData.imageShareQQ,"QQ"),
//    CommonShareItemModel(UIData.imageShareQQZone,"QQ空间"),
//    CommonShareItemModel(UIData.imageShareSinaWeibo,"新浪微博"),
//  ];
//
//  //设置key
//  _setKey(platform) async{
//    //微信key
//    if(platform == ShareSDKPlatforms.wechatSession
//        || platform == ShareSDKPlatforms.wechatTimeline
//        || platform == ShareSDKPlatforms.wechatTimeline
//        || platform == ShareSDKPlatforms.wechatTimeline){
//      ShareSDKRegister register = ShareSDKRegister();
//      register.setupWechat("wxff9c77e320ec1108", "");//微信的key
//      await ShareSDK.regist(register);
//    }
//  }
//
//  //分享
//  void share(CommonShareModel model,ShareSDKPlatform platform) async{
//    await _setKey(platform);
//    SSDKMap params = SSDKMap()
//      ..setGeneral(
//          model.title??"",
//          model.text??"",
//          model.thumbImageUrl??"",
//          null,
//          null,
//          model.url??"",
//          model.url??"",
//          model.url??"",
//          model.url??"",
//          SSDKContentTypes.webpage);
//    ShareSDK.share(
//        platform, params, (SSDKResponseState state,
//        Map userdata, Map contentEntity, SSDKError error) {
//    });
//  }
//}