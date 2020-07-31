import 'dart:io';
import 'dart:io' as prefix0;
import 'dart:typed_data';
import 'dart:ui';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/models/common/common_share_model.dart';
import 'package:cmp_customer/ui/common/common_share_bottom_sheet.dart';
import 'package:cmp_customer/utils/permission_util.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_extend/share_extend.dart';
import 'package:sharesdk_plugin/sharesdk_plugin.dart';

import 'log_util.dart';

//分享控件
class ShareUtil {
  //初始化
  static init() async {
    //分享平台都需要到平台上申请(目前仅提供微信和qq)
    ShareSDKRegister register = ShareSDKRegister();

    if (Platform.isIOS && HttpOptions.isTrialVersion) {
      //体验版
      register.setupWechat("wx329e7e84101038ae", "","https://apppack.56ing.com/"); //微信的key
      register.setupQQ("1106648831", "vYIQporqRdQhpYch"); //qq的key
    } else {
      register.setupWechat("wxff9c77e320ec1108", "", "https://apppack.56ing.com/"); //微信的key
      register.setupQQ("1106154627", "3Y1dL8K6KMa6wPLP"); //qq的key
    }
    SharesdkPlugin.regist(register);
  }

  //提供给外部使用的分享方法
  static shareWidget(GlobalKey rootWidgetKey) async {
    PermissionUtil.requestPermission([PermissionGroup.storage], callback: (bool isGranted) async {
      if (isGranted) {
        RenderRepaintBoundary boundary = rootWidgetKey.currentContext.findRenderObject();
        var image = await boundary.toImage(pixelRatio: window.devicePixelRatio);
        ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
        Uint8List pngBytes = byteData.buffer.asUint8List();
        Directory externalDir = await getTemporaryDirectory();
        String filePath = await _saveImage(pngBytes, externalDir, "zswy_djh_share.png");
//        if(callback!=null)
//          callback(filePath);
//        else
//          _shareImage(filePath);
        showShareMenu(rootWidgetKey.currentContext, CommonShareModel(url: filePath));
      }
    });
  }

  //生成图片文件
  static _saveImage(Uint8List uint8List, Directory dir, String fileName) async {
    bool isDirExist = await Directory(dir.path).exists();
    if (!isDirExist) {
      //文件夹不存在
      Directory(dir.path).create(); //创建文件夹
    }
    String filePath = dir.path + "/" + fileName;
    File localFile = await File(filePath).writeAsBytes(uint8List);
    return localFile.path;
  }

//  //分享操作
//  static _shareImage(String filePath) {
////    ImageShare.shareImage(filePath: filePath);
////    ShareExtend.share(filePath, "image");
//  }

//********sharesdk暂不支持ios的swift。等官方支持了再使用********//
//  //目前仅要求微信和QQ
  static final List<CommonShareItemModel> itemModels = [
    CommonShareItemModel(UIData.imageShareWechat, "微信", ShareSDKPlatforms.wechatSession),
    CommonShareItemModel(UIData.imageShareWechatMoments, "朋友圈", ShareSDKPlatforms.wechatTimeline),
//    CommonShareItemModel(UIData.imageShareWechatFavorite, "微信收藏",
//        ShareSDKPlatforms.wechatTimeline),
    CommonShareItemModel(UIData.imageShareQQ, "QQ", ShareSDKPlatforms.qq),
////    CommonShareItemModel(
////        UIData.imageShareQQZone, "QQ空间", ShareSDKPlatforms.qZone),
////    CommonShareItemModel(
////        UIData.imageShareSinaWeibo, "新浪微博", ShareSDKPlatforms.sina),
  ];

//
  //显示分享菜单
  static showShareMenu(BuildContext context, CommonShareModel shareModel) {
    try {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return CommonShareBottomSheet(shareModel);
        },
      );
    } catch (e) {
      LogUtils.printLog(e.toString());
    }
  }

//
  //分享
  static share(CommonShareModel model, ShareSDKPlatform platform) {
    if (model.url.startsWith("http")) {
      //服务器地址
      shareWeb(model, platform);
    } else {
      //分享本地文件
      shareFile(model.url, platform);
    }
  }

  //分享链接
  static shareWeb(CommonShareModel model, ShareSDKPlatform platform) {
    SSDKMap params = SSDKMap()
      ..setGeneral(
          model.title ?? "",
          model.text ?? "",
          (model.thumbImageUrl != null && model.thumbImageUrl.isNotEmpty) ? [model.thumbImageUrl] : null,
          model.thumbImageUrl,
          null,
          model.url ?? "",
          model.url ?? "",
          null,
          null,
          null,
          SSDKContentTypes.webpage);
    SharesdkPlugin.share(platform, params, null);
  }

  //分享文件
  static shareFile(String imagePath, ShareSDKPlatform platform) {
    SSDKMap params = SSDKMap()
      ..setGeneral("", "", [imagePath], null, imagePath, null, null, null, null,
          null, SSDKContentTypes.image);
    SharesdkPlugin.share(platform, params, null);
  }
}
