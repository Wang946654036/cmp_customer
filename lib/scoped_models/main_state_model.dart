import 'dart:convert';
import 'dart:io';

import 'package:cmp_customer/models/response/base_response.dart';
import 'package:cmp_customer/scoped_models/high_frequency_words_state_model.dart';
import 'package:cmp_customer/scoped_models/work_others_detail_model.dart';
import 'package:cmp_customer/scoped_models/work_others_list_model.dart';
import 'package:cmp_customer/scoped_models/work_others_process_node_model.dart';
import 'package:cmp_customer/scoped_models/near_info_model.dart';
import 'package:cmp_customer/ui/common/common_dialog.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'access_pass_state_model.dart';
import 'city_state_model.dart';
import 'community_state_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'market_model/market_base_model.dart';
import 'market_model/websocket_state_model.dart';
import 'pwd_state_model.dart';
import 'user_state_model.dart';
import 'house_state_model.dart';
import 'html_state_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'notice_state_model.dart';
import 'package_info_state_model.dart';
import 'office_cancel_lease_state_model.dart';
import 'articles_release_state_model.dart';
import 'common_state_model.dart';
import 'door_model/open_used_state_model.dart';
import 'hot_work_state_model.dart';
import 'package:open_file/open_file.dart';

class MainStateModel extends Model
    with
        UserStateModel,
        HighFrequencyWordsStateModel,
        WorkOthersDetailModel,
        WorkOthersListModel,
        HouseStateModel,
        HtmlStateModel,
        WorkOthersProcessNodeModel,
        CommunityStateModel,
        NoticeStateModel,
        PackageInfoStateModel,
        OfficeCancelLeaseStateModel,
        ArticlesReleaseStateModel,
        CommonStateModel,NearInfoModel,
        OpenDoorUsedModel,
        HotWorkStateModel,
        CityStateModel,
        AccessPassStateModel,
        MarketBaseModel,
        WebSocketStateModel,
        PwdStateModel{


  final JPush jPush = new JPush();

  MainStateModel() {
    _init();
  }

  void mainRefresh() {
    notifyListeners();
  }

  get jsonworkOther => null;

  _init() {
//    _getAppDocDir();
    initPackageInfo();
    initDeviceInfo();
  }

  ///
  /// 打开链接
  ///
  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw '无法打开链接';
    }
  }

  //打开文件
  void openFile(String filePath) {
    if(filePath!=null&&filePath.isNotEmpty){
      OpenFile.open(filePath);
    }
  }

  callPhone(phoneNo) async {
    if (await canLaunch('tel:$phoneNo')) {
      await launch('tel:$phoneNo');
    } else {
      throw '电话无法拨打';
    }
  }

  static const platform = const MethodChannel("zswy.flutter/channel");

  Future<Null> callNative(String method, {Object object, Function callback}) async {
    try {
//      在通道上调用此方法
      var result = await platform.invokeMethod(method, object);
      LogUtils.printLog("callNativeSuccess:" + (result?.toString()??"result is null"));
      if (callback != null) {
        callback(result);
      }
    } on PlatformException catch (e) {
      LogUtils.printLog("callNativeError:" + (e?.toString()??"result is null"));
      if (callback != null) {
        callback(e.message);
      }
    }
  }

  //判断是否有进入模块的权限，客户并且有已认证过的房屋才有权限
  bool checkModulePermission(BuildContext context) {

    if (2 == customerType && defaultProjectId != null && defaultHouseId != null) {
      return true;
    } else {
      CommonDialog.showUncertifiedDialog(context);
      return false;
    }
  }

//  _getAppDocDir() async {
//    Constant.appDocDir = await getApplicationDocumentsDirectory();
//  }

//  Future<File> _getLocalFile() async{
//    String dir = (await getExternalStorageDirectory()).path + '/222sdshtg';
//    File file = File(dir);
//    file.create();
//    LogUtils.printLog('file exists:${await file.exists()}');
//    LogUtils.printLog('appDir:$dir');
//    return File('$dir/region.txt');
//  }
  static MainStateModel of(context) => ScopedModel.of<MainStateModel>(context);
}
