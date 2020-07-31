import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/ui/common/common_dialog.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/house_authentication/house_auth_page.dart';
import 'package:cmp_customer/ui/house_authentication/tourist_auto_auth_page.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
/// 游客-无认证记录
///
class TouristNoRecord extends StatelessWidget {
  final Function callback;

  TouristNoRecord([this.callback]);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: UIData.primaryColor,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              UIData.imageTouristNoRecord,
              fit: BoxFit.fitWidth,
              width: ScreenUtil.getInstance().setWidth(135),
            ),
            SizedBox(height: UIData.spaceSize16),
            CommonText.grey16Text('您目前是游客身份\n完成房屋认证即可畅享服务哟', textAlign: TextAlign.center),
            SizedBox(height: UIData.spaceSize20),
            FlatButton(
                onPressed: () {
                  stateModel.getTouristAccountStatus(callBack: ({String message, String mobile, List list}) {
                    LogUtils.printLog(message);
                    if (message == '450') {
                      //未匹配到客户
                      navigatorKey.currentState.push<bool>(MaterialPageRoute(builder: (context) {
                        return HouseAuthPage(
                          houseAuthType: HouseAuthType.FirstAuth,
                        );
                      })).then((bool value) {
                        if (value != null && value) {
                          if (callback != null) callback();
                        }
                      });
                    } else if (message == '451') {
                      //匹配到客户未关联账号
                      navigatorKey.currentState.push<void>(MaterialPageRoute(builder: (context) {
                        return TouristAutoAuthPage(list);
                      })).then((void value) {
                        if (callback != null) callback();
                      });
                    } else if (message == '452') {
                      //匹配到客户且关联账号
                      CommonDialog.showAlertDialog(context, content: '检测到您已有账号$mobile，您可登录该账号修改手机号或者请联系物管中心知会系统后台人员解决。',
                          positiveBtnText: '返回登录',
                          negativeBtnText: '取消',
                          onConfirm: () {
                        navigatorKey.currentState.pushNamedAndRemoveUntil(Constant.pageLogin, ModalRoute.withName('/'));
                      });
                    }
                  });
                },
                child: CommonText.red16Text('马上认证')),
          ],
        ),
      ),
    );
  }
}
