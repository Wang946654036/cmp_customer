//申请状态
import 'dart:ui';

import 'package:cmp_customer/utils/ui_data.dart';

const String auditLandlordWaiting = "YZ_CHECK"; //待业主同意
const String auditLandlordFailed = "YZ_DISAGREE"; //业主不同意
const String auditPropertyWaiting = "WY_CHECK"; //待物业审核
const String auditPropertyFailed = "WY_CHECK_FAIL"; //物业不通过
const String payWaiting = "PAYMENT_PENDING"; //待缴费
const String completed = "WRITED"; //已签证
const String cancelled = "CANCEL_REQUEST"; //已撤单
const String expired = "TIMED"; //已过期

//获取状态的颜色
getStateColor(String state) {
  Color color = UIData.lightGreyColor;
  switch (state) {
    case auditLandlordWaiting:
    case auditPropertyWaiting:
    case payWaiting:
      color = UIData.yellowColor;
      break;
    case auditLandlordFailed:
    case auditPropertyFailed:
      color = UIData.lightRedColor;
      break;
    case completed:
    case cancelled:
    case expired:
      color = UIData.lightGreyColor;
      break;
  }
  return color;
}