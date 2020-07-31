import 'dart:async';
import 'dart:io';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/ad_info_model.dart';
import 'package:cmp_customer/models/response/activity_info_response.dart';
import 'package:cmp_customer/models/response/door_list_response.dart';
import 'package:cmp_customer/scoped_models/activity_state_model.dart';
import 'package:cmp_customer/scoped_models/door_model/open_door_state_model.dart';
import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/ui/common/common_dialog.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_shadow_container.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/door/open_door_list.dart';
import 'package:cmp_customer/ui/parking/parking_card_ui.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/shared_preferences_key.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scoped_model/scoped_model.dart';

//常用门列表
class OpenDoorUsedPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OpenDoorUsed();
  }
}

class OpenDoorUsed extends State<OpenDoorUsedPage> {
  OpenDoorStateModel _doorStateModel = OpenDoorStateModel();

  Color _getIconColor(int index) {
    Color color = Color(0xFF70A7FA);
    switch (index) {
      case 0:
        color = Color(0xFF70A7FA);
        break;
      case 1:
        color = Color(0xFFFAC746);
        break;
      case 2:
        color = Color(0xFF77CE50);
        break;
      case 3:
        color = Color(0xFFFFB07B);
        break;
      case 4:
        color = Color(0xFF5CD6F6);
        break;
      case 5:
        color = Color(0xFFC893F8);
        break;
    }
    return color;
  }

  Widget _buildItem(DeviceInfo info, int index) {
    return CommonShadowContainer(
        margin: EdgeInsets.only(left: UIData.spaceSize16, right: UIData.spaceSize16, top: UIData.spaceSize16),
        padding: EdgeInsets.only(top: UIData.spaceSize16, bottom: UIData.spaceSize16, left: UIData.spaceSize16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(child: CommonText.darkGrey16Text(info?.deviceName ?? "", fontWeight: FontWeight.w600)),
//            SizedBox(width: UIData.spaceSize8),
            Container(
                height: ScreenUtil.getInstance().setHeight(30),
                margin: EdgeInsets.symmetric(horizontal: UIData.spaceSize16),
//            if(StringsHelper.isNotEmpty(info?.deviceFactory)&&StringsHelper.isNotEmpty(info?.hexKey))
//            _doorStateModel.openDoor(info?.modeType, info?.projectId, info?.deviceCode, info?.lockid,
//                info?.deviceName, info?.deviceFactory, info?.hexKey);
//            else{
//              CommonToast.show(msg:"初始化设备中",);
//              _doorStateModel.getDoorDevice(callback: (){
//                if(_doorStateModel.doorState == ListState.HINT_DISMISS){
//                  CommonToast.dismiss();
//                  if(StringsHelper.isNotEmpty(info?.deviceFactory)&&StringsHelper.isNotEmpty(info?.hexKey))
//                    _doorStateModel.openDoor(info?.modeType, info?.projectId, info?.deviceCode, info?.lockid,
//                        info?.deviceName, info?.deviceFactory, info?.hexKey);
//                  else{
//                    CommonToast.show(msg:"设备同步失败，请重新添加常用门",type: ToastIconType.INFO);
//                  }
//                }
//              });
//            }
                    child: Image.asset(UIData.imageOpenDoorBtn, fit: BoxFit.fitHeight))
          ],
        ), onTap: (){
      if (StringsHelper.isNotEmpty(info?.deviceFactory)) {
        _doorStateModel.openDoor(info?.modeType, info?.projectId, info?.deviceCode, info?.lockid,
            info?.deviceName, info?.deviceFactory, info?.hexKey, callback: () {
              if (stateModel.defaultProjectId != null) {
                //获取活动页面
                new ActivityStateModel().queryActivity((ActivityInfo info) async {
                  SharedPreferences prefs = await SharedPreferencesKey.globalPrefs;
                  String token = prefs.getString(SharedPreferencesKey.KEY_ACCESS_TOEKN);
                  String url =
                      "${HttpOptions.baseUrl.replaceAll("ubms-customer/", "")}template/appShare/lottery.html?token=$token&custAppId=${stateModel.customerId}&projectId=${stateModel.defaultProjectId}&orgId=${info?.orgId}&activityId=${info?.activityId}&closePage=1";
                  if (context != null)
                    CommonDialog.showAdDialog(
                        context, new AdInfo(toUrl: url, title: info.activityTitle),
                        bgImage: new File(info.themeFilePath));
                });
              }
            });
      } else {
        CommonToast.show(msg: "设备厂商为空，请稍后重试", type: ToastIconType.INFO);
      }
    });

  }

//  Widget _buildItem(DeviceInfo info, int index) {
//    return Column(
//      mainAxisAlignment: MainAxisAlignment.center,
//      crossAxisAlignment: CrossAxisAlignment.center,
//      children: <Widget>[
//        GestureDetector(
//          child: Icon(
//            UIData.iconDoorDevice,
//            color: _getIconColor(index),
//            size: 50,
//          ),
//          onTap: () {
////            if(StringsHelper.isNotEmpty(info?.deviceFactory)&&StringsHelper.isNotEmpty(info?.hexKey))
////            _doorStateModel.openDoor(info?.modeType, info?.projectId, info?.deviceCode, info?.lockid,
////                info?.deviceName, info?.deviceFactory, info?.hexKey);
////            else{
////              CommonToast.show(msg:"初始化设备中",);
////              _doorStateModel.getDoorDevice(callback: (){
////                if(_doorStateModel.doorState == ListState.HINT_DISMISS){
////                  CommonToast.dismiss();
////                  if(StringsHelper.isNotEmpty(info?.deviceFactory)&&StringsHelper.isNotEmpty(info?.hexKey))
////                    _doorStateModel.openDoor(info?.modeType, info?.projectId, info?.deviceCode, info?.lockid,
////                        info?.deviceName, info?.deviceFactory, info?.hexKey);
////                  else{
////                    CommonToast.show(msg:"设备同步失败，请重新添加常用门",type: ToastIconType.INFO);
////                  }
////                }
////              });
////            }
//            if (StringsHelper.isNotEmpty(info?.deviceFactory)) {
//              _doorStateModel.openDoor(info?.modeType, info?.projectId, info?.deviceCode, info?.lockid,
//                  info?.deviceName, info?.deviceFactory, info?.hexKey);
//            } else {
//              CommonToast.show(msg: "设备厂商为空，请稍后重试", type: ToastIconType.INFO);
//            }
//          },
//        ),
//        Padding(
//          padding: EdgeInsets.only(top: text_spacing),
//          child:
//              CommonText.text12(info?.deviceName ?? "", color: UIData.darkGreyColor, textAlign: TextAlign.center),
//        )
//      ],
//    );
//  }

  Widget _buildContent() {
    return ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(UIData.imageOpenDoorBanner, fit: BoxFit.fitWidth),
          ListView.builder(
              shrinkWrap: true,
              itemCount: model?.usedList?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return _buildItem(model?.usedList[index], index);
              })
        ],
      );
    });
  }

//  Widget _buildContent() {
//    return ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
//      return Column(
//        crossAxisAlignment: CrossAxisAlignment.stretch,
//        children: <Widget>[
//          Expanded(
//            child: Container(
//                alignment: Alignment.bottomCenter,
//                decoration: BoxDecoration(
//                    image: DecorationImage(image: AssetImage(UIData.iconDoorBackground), fit: BoxFit.cover),
//                    color: UIData.primaryColor),
//                child: GridView.builder(
//                    physics: new NeverScrollableScrollPhysics(),
//                    shrinkWrap: true,
//                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                      crossAxisCount: 3,
//                    ),
//                    itemCount: model?.usedList?.length ?? 0,
//                    itemBuilder: (BuildContext context, int index) {
//                      return _buildItem(model?.usedList[index], index);
//                    })),
//          ),
//          Container(
//              color: UIData.primaryColor,
//              padding: EdgeInsets.only(bottom: bottom_spacing),
//              child: IconButton(
//                icon: Icon(
//                  Icons.close,
//                ),
//                onPressed: () {
//                  Navigate.closePage(false);
//                },
//              ))
//        ],
//      );
//    });
//  }

  //初始化智锁的蓝牙开门
  void _initLopeBluetooth() {
    stateModel.callNative("openLopeDoorInit");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initLopeBluetooth();
//    if (stateModel.baseDataLoaded == 1) {
    _doorStateModel.getDoorDevice();
//    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModel<MainStateModel>(
        model: stateModel,
        child: CommonScaffold(
          appTitle: "常用门",
          bodyData: _buildContent(),
          appBarActions: [
            ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
              return stateModel.baseDataLoaded == 1
                  ? FlatButton(
                      child: CommonText.red15Text('更多'),
                      onPressed: () {
                        Navigate.toNewPage(OpenDoorListPage());
                      })
                  : Container();
            })
          ],
        )
//        child: SafeArea(child: _buildBody())
        );
  }
}
