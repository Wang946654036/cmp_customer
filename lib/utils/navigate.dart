import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/ui/common/common_dialog.dart';
import 'package:cmp_customer/ui/house_authentication/my_house_page.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:flutter/material.dart';

class Navigate {
  static toNewPage(Widget page, {Function callBack}) {
    navigatorKey.currentState.push<Object>(new MaterialPageRoute(builder: (_) {
      return page;
    })).then((data) {
      LogUtils.printLog(data?.toString() ?? "");
      if (callBack != null) callBack(data);
    });
  }

  static closePage([data]) {
    navigatorKey.currentState.pop(data);
  }

  //检查是否为客户并且有已认证过的房屋才有权限
  static checkCustomerCertified(BuildContext context, Widget page) {
    if (2 == stateModel?.customerType &&
        stateModel.customerId != null &&
        stateModel.defaultProjectId != null &&
        stateModel.defaultHouseId != null) {
      toNewPage(page);
    } else {
      CommonDialog.showUncertifiedDialog(context);
    }
  }
}
