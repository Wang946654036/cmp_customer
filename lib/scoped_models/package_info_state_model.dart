import 'dart:convert';
import 'dart:io';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/models/app_info_model.dart';
import 'package:cmp_customer/strings/strings_common.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/failed_code_trans.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/shared_preferences_key.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info/package_info.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info/device_info.dart';

import '../main.dart';

//app信息
mixin PackageInfoStateModel on Model {
  String appName; //app名称
  String packageName; //包名
  String version; //版本
  String buildNumber; //编译版本
  Map<String, String> deviceInfo; //设备信息

  void initPackageInfo() {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      appName = packageInfo.appName;
      packageName = packageInfo.packageName;
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    });
  }

  Future<void> initDeviceInfo() async {
    try {
      DeviceInfoPlugin info = DeviceInfoPlugin();
      if (Platform.isIOS) {
        final iOSInfo = await info.iosInfo;
        deviceInfo = {
          'OS': 'IOS',
          'systemVersion': iOSInfo.systemVersion,
          'DeviceName': iOSInfo.name,
          'development': developmentMap[HttpOptions.baseUrl] ?? '其他环境',
        };
      } else if (Platform.isAndroid) {
        final androidInfo = await info.androidInfo;
        deviceInfo = {
          'OS': 'Android',
          'systemVersion': androidInfo.version.release,
          'Brand': androidInfo.brand,
          'Model': androidInfo.model,
          'development': developmentMap[HttpOptions.baseUrl] ?? '其他环境',
        };
      } else {
        return {};
      }
    } catch (e) {
      LogUtils.printLog('获取设备信息失败:$e');
      return {'failed': '获取设备信息失败:$e'};
    }
  }

  //获取版本信息
  void getAppVersion({Function callback}) async {
    Map<String, dynamic> params = new Map();
    params['systemType'] = Platform.isAndroid ? 'Android' : 'IOS';
//    params['systemType'] = Platform.isAndroid ? 'Android' : '${HttpOptions.isTrialVersion ? 'IOS_TRIAL' : 'IOS'}';
    String jsonData = json.encode(params);

    HttpUtil.post(HttpOptions.getAppVersionUrl, (data) => _appInfoCallBack(data, callback: callback),
        jsonData: jsonData, errorCallBack: (errorMsg) => _appInfoErrorCallBack(errorMsg, callback: callback));
  }

  void _appInfoCallBack(data, {Function callback}) {
    AppInfoModel model = AppInfoModel.fromJson(data);
    LogUtils.printLog('版本信息:${json.encode(data)}');
    if (model.code == '0') {
      if (model.appInfo != null &&
          (StringsHelper.isEmpty(model.appInfo?.disabledMenu) ||
              !model.appInfo.disabledMenu.contains('集市'))) {
        stateModel.showMarket = false;
      }
      stateModel.marketStatement = model.appInfo?.marketStatement ?? '';
//      stateModel.showMarket = true; //测试数据
      if (model?.appInfo?.otherUrl != null && model?.appInfo?.otherUrl.isNotEmpty) {
        //下载地址不为空
        setDownloadUrl(model?.appInfo?.otherUrl);
      }
      if (model?.appInfo?.code != null && buildNumber != null && buildNumber.isNotEmpty) {
        if (int.parse(buildNumber) < model.appInfo.code) {
          //本地版本号小于服务器版本号
          if (model?.appInfo?.url != null && model.appInfo.url.isNotEmpty) {
            if (callback != null)
              callback(model.appInfo.url, model.appInfo.version, model?.appInfo?.isForce == 1 ? true : false,
                  model?.appInfo?.size ?? '', model?.appInfo?.desc);
          }
        }
      }
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
      CommonToast.show(msg: '版本信息获取失败：$failedDescri', type: ToastIconType.FAILED);
    }
    notifyListeners();
  }

  void _appInfoErrorCallBack(errorMsg, {Function callback}) {
    LogUtils.printLog('接口返回失败');
    CommonToast.show(msg: '版本信息获取失败：$errorMsg', type: ToastIconType.FAILED);
    notifyListeners();
  }

  void setDownloadUrl(String url) async {
    SharedPreferences prefs = await SharedPreferencesKey.globalPrefs;
    prefs.setString(SharedPreferencesKey.KEY_DOWNLOAD_URL, url);
  }

  ///
  /// 上报设备信息
  /// [appType]app类型：1-慧到家（员工），2-到家汇（业主）
  ///
  void uploadDeviceInfo({Function callBack}) async {
    Map<String, dynamic> params = new Map();
    params['loginId'] = stateModel.accountId;
    StringBuffer sb = StringBuffer();
    sb.write('${appName}_');
    sb.write(deviceInfo['development']);
    if (Platform.isIOS && HttpOptions.isTrialVersion) {
      sb.write('_体验版');
    }
    params['appName'] = sb.toString();
    params['appType'] = 2;
    params['appVersion'] = version;
    params['systemType'] = Platform.isAndroid ? 'Android' : 'IOS';
    params['systemVersion'] = deviceInfo['systemVersion'];
    params['screenResolution'] = '${ScreenUtil.screenWidth} * ${ScreenUtil.screenHeight}';
    if (Platform.isAndroid) {
      params['androidDeviceBrand'] = deviceInfo['Brand'];
      params['androidDeviceModel'] = deviceInfo['Model'];
    } else if (Platform.isIOS) {
      params['iosDeviceName'] = deviceInfo['DeviceName'];
    }
    String jsonData = json.encode(params);
    HttpUtil.post(HttpOptions.uploadDeviceInfoUrl, (data) => _uploadDeviceInfoCallBack(data, callBack: callBack),
        jsonData: jsonData,
        errorCallBack: (errorMsg) => _uploadDeviceInfoErrorCallBack(errorMsg, callBack: callBack));
  }

  void _uploadDeviceInfoCallBack(data, {Function callBack}) async {
    LogUtils.printLog('上报设备信息:${json.encode(data)}');
//    CommonResultModel model = CommonResultModel.fromJson(data);
  }

  void _uploadDeviceInfoErrorCallBack(String errorMsg, {Function callBack}) {
    LogUtils.printLog('上报设备信息接口返回失败：$errorMsg');
  }
}
