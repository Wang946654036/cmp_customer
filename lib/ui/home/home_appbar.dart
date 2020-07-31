import 'dart:convert';

import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/uncertified_community_model.dart';
import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/ui/common/common_dialog.dart';
import 'package:cmp_customer/ui/common/common_dot.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/home/main_page.dart';
import 'package:cmp_customer/ui/me/community_selection_page.dart';
import 'package:cmp_customer/ui/notice/message_center_page.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/shared_preferences_key.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scoped_model/scoped_model.dart';

///
/// 首页和服务顶部当前社区按钮
///
class HomeLocationButton extends StatelessWidget {
//  String _defaultProjectName = '';

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
//      _getDefaultProjectName();
      return GestureDetector(
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: UIData.spaceSize12),
              width: ScreenUtil.getInstance().setWidth(26),
              height: ScreenUtil.getInstance().setHeight(26),
              child: Image.asset(UIData.imageLocation),
            ),
            CommonText.darkGrey17Text(stateModel.defaultProjectName ?? '选择社区')
          ],
        ),
        onTap: () {
          Navigate.toNewPage(CommunitySelectionPage());
        },
      );
    });
  }

  ///
  /// 判断默认项目，没有已认证房屋的游客和客户，自己选择项目设置为默认项目
  /// 先判断是否有默认项目，没有就拿未认证社区的默认项目
  ///
//  _getDefaultProjectName() async {
//    if (stateModel.defaultProjectName != null && stateModel.defaultProjectName.isNotEmpty) {
//      _defaultProjectName = stateModel.defaultProjectName;
//    } else {
//      SharedPreferences prefs = await SharedPreferencesKey.globalPrefs;
//      String jsonCommunity = prefs.getString(SharedPreferencesKey.KEY_UNCERTIFIED_COMMUNITY);
//      UncertifiedCommunityModel uncertifiedCommunityModel = UncertifiedCommunityModel();
//      if (jsonCommunity != null && jsonCommunity.isNotEmpty) {
//        LogUtils.printLog('jsonCommunity: ${json.encode(json.decode(jsonCommunity))}');
//        uncertifiedCommunityModel = UncertifiedCommunityModel.fromJson(json.decode(jsonCommunity));
//        if (uncertifiedCommunityModel.uncertifiedCommunityList != null &&
//            uncertifiedCommunityModel.uncertifiedCommunityList.length > 0) {
//          uncertifiedCommunityModel.uncertifiedCommunityList.forEach((UncertifiedCommunity community) {
//            if (community.isDefault) _defaultProjectName = community.projectName;
//          });
//        }
//      }
//    }
//    stateModel.mainRefresh();
//  }
}

///
/// 右上角扫码按钮
///
class HomeScanButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: ScreenUtil.getInstance().setWidth(26),
        height: ScreenUtil.getInstance().setWidth(26),
        margin: EdgeInsets.symmetric(horizontal: UIData.spaceSize8),
        child: Image.asset(UIData.iconScan),
      ),
      onTap: () {
        CommonToast.show();
      },
    );
  }
}

///
/// 右上角消息按钮
///
class HomeMessageButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
      return Visibility(
          visible: model.customerType == 2,
          child: GestureDetector(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize8),
              child: Stack(
                alignment: Alignment.centerRight,
                children: <Widget>[
                  Container(
                    width: ScreenUtil.getInstance().setWidth(26),
                    height: ScreenUtil.getInstance().setWidth(26),
                    child: Image.asset(UIData.iconMessage),
                  ),
                  Visibility(
                      visible: model.unReadMessageTotalCount > 0,
                      child: Container(
                          margin: EdgeInsets.only(bottom: UIData.spaceSize16), child: CommonDiamondDot()))
//                  Container(margin: EdgeInsets.only(bottom: UIData.spaceSize16), child: CommonDiamondDot()),
                ],
              ),
            ),
            onTap: () => Navigate.toNewPage(MessageCenterPage()),
          ));
    });
  }
}
