import 'dart:io';
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:url_launcher/url_launcher.dart';

//地图跳转（线路规划）
class MapUtil {

  /// 高德地图
  static Future<String> gotoAMap(longitude, latitude,{String address}) async {
//    var url = '${Platform.isAndroid ? 'android' : 'ios'}amap://navi?sourceApplication=amap&lat=$latitude&lon=$longitude&dev=0&style=2';
    var url ;
     if(Platform.isAndroid){
       url = Uri.encodeFull('amapuri://route/plan/?sourceApplication=${stateModel.appName??""}&dlat=$latitude&dlon=$longitude&dname=${address??""}&dev=0&t=0');
     }else{
       url = Uri.encodeFull("iosamap://path?sourceApplication=${stateModel.appName??""}&dlat=$latitude&dlon=$longitude&dname=${address??""}&dev=0&t=0");
     }
    bool canLaunchUrl = await canLaunch(url);
    if (!canLaunchUrl) {
      return "请安装高德地图APP";
    }else{
      await launch(url);
      return null;
    }
  }

  /// 腾讯地图
  static Future<String> gotoTencentMap(longitude, latitude,{String address}) async {
    var url = Uri.encodeFull('qqmap://map/routeplan?type=drive&fromcoord=CurrentLocation&to=${address??""}&tocoord=$latitude,$longitude&referer=SXXBZ-ARTCK-4Q3JK-ADWSL-6GUIS-SYFW3');
    bool canLaunchUrl = await canLaunch(url);
    if (!canLaunchUrl) {
//      CommonToast.show(type: ToastIconType.INFO,msg:'请安装腾讯地图APP');
      return "请安装腾讯地图APP";
    }else{
      await launch(url);
      return null;
    }
  }

   /// 百度地图
  static Future<String> gotoBaiduMap(longitude, latitude,{String address}) async {
    var url = Uri.encodeFull('baidumap://map/direction?destination=name:${address??""}|latlng:$latitude,$longitude&coord_type=gcj02&mode=driving');

    bool canLaunchUrl = await canLaunch(url);

    if (!canLaunchUrl) {
      return "请安装百度地图APP";
    }else{
      await launch(url);
      return null;
    }
  }

//  /// 苹果地图
//  static Future<bool> _gotoAppleMap(longitude, latitude) async {
//    var url = 'http://maps.apple.com/?&daddr=$latitude,$longitude';
//
//    bool canLaunchUrl = await canLaunch(url);
//
//    if (!canLaunchUrl) {
//      ToastUtil.show('打开失败~');
//      return false;
//    }
//
//    await launch(url);
//  }
}