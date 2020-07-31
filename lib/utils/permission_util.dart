import 'dart:io';

import 'package:cmp_customer/utils/log_util.dart';
import 'package:permission_handler/permission_handler.dart';

export 'package:permission_handler/permission_handler.dart';

///
/// 获取权限工具
///
class PermissionUtil {
  static void checkServiceStatus(PermissionGroup permission) {
    LogUtils.printLog('serviceStatus start:');
    PermissionHandler().checkServiceStatus(permission).then((ServiceStatus serviceStatus) {
      LogUtils.printLog('serviceStatus:${serviceStatus.toString()}');
    });
  }

  static Future<void> requestPermission(List<PermissionGroup> permissions, {Function callback}) async {
    List<PermissionGroup> _permissions = permissions?.where((PermissionGroup permission) {
      if (Platform.isIOS) {
        return permission != PermissionGroup.unknown &&
            permission != PermissionGroup.phone &&
            permission != PermissionGroup.sms &&
            permission != PermissionGroup.storage;
      } else {
        return permission != PermissionGroup.unknown &&
            permission != PermissionGroup.mediaLibrary &&
            permission != PermissionGroup.photos &&
            permission != PermissionGroup.reminders;
      }
    })?.toList();
    if (_permissions != null && _permissions.length > 0) {
      Map<PermissionGroup, PermissionStatus> permissionRequestResult;
      permissionRequestResult = await PermissionHandler()?.requestPermissions(_permissions);
      if (permissionRequestResult != null && permissionRequestResult.length > 0) {
        bool isGranted = true;
        permissionRequestResult.forEach((PermissionGroup permissionGroup, PermissionStatus permissionStatus) {
          if (permissionStatus != PermissionStatus.granted) {
            isGranted = false;
            LogUtils.printLog('$permissionGroup: ${permissionRequestResult[permissionGroup]}');
          }
        });
        if (isGranted) {
          if (callback != null) callback(true);
          return ;
        } else {
          if (callback != null) callback(false);
          return ;
        }
      }
    }
    if (callback != null) callback(true);
//        .then((Map<PermissionGroup, PermissionStatus> permissionRequestResult) {
//      bool isGranted = true;
//      permissionRequestResult.forEach((PermissionGroup permissionGroup, PermissionStatus permissionStatus) {
//        if (permissionStatus != PermissionStatus.granted) {
//          isGranted = false;
//          LogUtils.printLog('$permissionGroup: ${permissionRequestResult[permissionGroup]}');
//        }
//      });
//      if (isGranted) {
//        if (callback != null) callback(true);
//      } else {
//        if (callback != null) callback(false);
//      }
//    });
  }
}
