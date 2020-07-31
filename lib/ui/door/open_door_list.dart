import 'dart:io';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/ad_info_model.dart';
import 'package:cmp_customer/models/response/activity_info_response.dart';
import 'package:cmp_customer/models/response/door_list_response.dart';
import 'package:cmp_customer/scoped_models/activity_state_model.dart';
import 'package:cmp_customer/scoped_models/door_model/open_door_state_model.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_dialog.dart';
import 'package:cmp_customer/ui/common/common_list_loading.dart';
import 'package:cmp_customer/ui/common/common_list_refresh.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/door/open_door_history.dart';
import 'package:cmp_customer/ui/house_authentication/my_house_page.dart';
import 'package:cmp_customer/ui/house_authentication/tourist_no_record.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/shared_preferences_key.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scoped_model/scoped_model.dart';

//一键开门列表
class OpenDoorListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OpenDoorList();
  }
}

class OpenDoorList extends State<OpenDoorListPage> {
  OpenDoorStateModel _doorStateModel = new OpenDoorStateModel();

  Widget _buildContent() {
    return ScopedModelDescendant<OpenDoorStateModel>(builder: (context, child, model) {
      return ListView.builder(
          itemCount: model?.doorList?.length ?? 0,
          itemBuilder: (BuildContext context, int projectIndex) {
            DoorInfo info = model?.doorList[projectIndex];
            return Container(
                color: UIData.primaryColor,
                child: ExpansionTile(
                    initiallyExpanded: projectIndex == 0,
                    title: CommonText.darkGrey17Text(info.projectName ?? ""),
                    children: <Widget>[
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: info?.mode?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            Mode mode = info?.mode[index];
                            return Container(
                                color: UIData.primaryColor,
                                child: ExpansionTile(
                                  initiallyExpanded: projectIndex == 0 && index == 0,
                                  title: Padding(
                                    padding: EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(16)),
                                    child: CommonText.text16(
                                        mode.modeType == "2" ? "蓝牙门禁" : mode.modeType == "1" ? "4G门禁" : "",
                                        color: UIData.greyColor, isBold: true),
                                  ),
                                  children: <Widget>[
                                    ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: mode?.deviceList?.length ?? 0,
                                        itemBuilder: (BuildContext context, int index) {
                                          DeviceInfo deviceInfo = mode?.deviceList[index];
                                          return _buildItem(
                                            deviceInfo,
                                            () {
                                              if (_doorStateModel.isSetting) {
                                                _doorStateModel.setUsedDoor(deviceInfo);
                                              } else {
                                                _doorStateModel.openDoor(
                                                    mode.modeType,
                                                    deviceInfo.projectId,
                                                    deviceInfo.deviceCode,
                                                    deviceInfo.lockid,
                                                    deviceInfo.deviceName,
                                                    deviceInfo.deviceFactory,
                                                    deviceInfo.hexKey,
                                                  callback: (){
                                                    if(stateModel.defaultProjectId!=null){
                                                      //获取活动页面
                                                      new ActivityStateModel().queryActivity((ActivityInfo info) async{
                                                        SharedPreferences prefs = await SharedPreferencesKey.globalPrefs;
                                                        String token=prefs.getString(SharedPreferencesKey.KEY_ACCESS_TOEKN);
                                                        String url = "${HttpOptions.baseUrl.replaceAll(
                                                            "ubms-customer/",
                                                            "")}template/appShare/lottery.html?token=$token&custAppId=${stateModel.customerId}&projectId=${stateModel.defaultProjectId}&orgId=${info?.orgId}&activityId=${info?.activityId}&closePage=1";
                                                        if(context!=null)
                                                          CommonDialog.showAdDialog(context, new AdInfo(toUrl: url,title: info.activityTitle),bgImage: new File(info.themeFilePath));
                                                      });
                                                    }
                                                  }
                                                );
                                              }
                                            },border: index < mode.deviceList.length - 1
                                          );
                                        }),
                                  ],
                                ));
                          })
                    ]));
//          return Container(
//              color: UIData.primaryColor,
//              child: ExpansionTile(
//                title: CommonText.darkGrey16Text(info.projectName??""),
//                children: <Widget>[
//                  ListView.builder(
//                      physics: NeverScrollableScrollPhysics(),
//                      shrinkWrap: true,
//                      itemCount: info?.openDoorList?.length ?? 0,
//                      itemBuilder: (BuildContext context, int index) {
//                        OpenDoorInfo deviceInfo =info.openDoorList[index];
//                        return ListTile(
//                          contentPadding: EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(30)),
//                          title:  CommonText.grey14Text(deviceInfo.deviceName??""),
//                          onTap: (){
//                            if(StringsHelper.isNotEmpty(deviceInfo.devicePid)&&StringsHelper.isNotEmpty(deviceInfo.deviceCode)){
//                              Navigate.toNewPage(OpenDoorPage(deviceInfo));
//                            }else if(StringsHelper.isNotEmpty(deviceInfo.devicePid)){
//                              _doorStateModel.openBlueDoor(deviceInfo.devicePid);
//                            }else if(StringsHelper.isNotEmpty(deviceInfo.deviceCode)){
//                              _doorStateModel.openNetDoor(deviceInfo.deviceCode);
//                            }else{
//                              CommonToast.show(type: ToastIconType.FAILED,msg: "此门不支持一键开门");
//                            }
//                          },
//                        );
//                      }),
//
//                ],
//              ));
          });
    });
  }

  Widget _buildItem(DeviceInfo info, Function callback, {bool border = true}) {
    return GestureDetector(
      onTap: () {
        callback();
      },
      child: Container(
        height: ScreenUtil.getInstance().setWidth(50),
        padding: EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(60)),
        color: UIData.primaryColor,
        child: Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: border ? UIData.dividerColor : Colors.transparent))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: CommonText.darkGrey16Text(info.deviceName),
              ),
              Visibility(
                visible: _doorStateModel.isSetting,
                child: Checkbox(
                  value: info.checked ?? false,
                  onChanged: (bool checked) {
                    callback();
                  },
                  activeColor: UIData.themeBgColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return ScopedModelDescendant<OpenDoorStateModel>(builder: (context, child, model) {
      Widget widget;
      switch (model.doorState) {
        case ListState.HINT_LOADING:
          widget = CommonListLoading();
          break;
        case ListState.HINT_NO_DATA_CLICK:
          widget = Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: ScreenUtil().setWidth(100),
                child: Image(image: AssetImage(UIData.imageNoData)),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(30)),
                child: CommonText.text16("您已是认证客户，一键开门授权中....\n待人工审核！",
                    textAlign: TextAlign.center, color: UIData.lightGreyColor),
              ),
            ],
          ));
          break;
        case ListState.HINT_LOADED_FAILED_CLICK:
          if (StringsHelper.isEmpty(model.tip)) {
            widget = CommonListRefresh(
                state: ListState.HINT_LOADED_FAILED_CLICK,
                callBack: () {
                  model.getDoorDevice();
                });
          } else {
            widget = Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: ScreenUtil().setWidth(80),
                  child: Image(image: AssetImage(UIData.imageLoadedFailed)),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(30)),
                  child: CommonText.text16(model.tip, textAlign: TextAlign.center, color: UIData.lightGreyColor),
                ),
              ],
            ));
          }
          break;
        case ListState.HINT_DISMISS:
          widget = _buildContent();
          break;
      }
      return widget;
    });
  }

  Widget _buildButton() {
    if (_doorStateModel.isSetting ?? false) {
      return StadiumSolidWithTowButton(
          cancelText: '取消',
          onCancel: () {
            _doorStateModel.setIsSetting(false);
          },
          conFirmText: '确定',
          onConFirm: () {
            _doorStateModel.saveUsedDoor();
          });
    } else {
      return StadiumSolidButton(
        "设置常用门",
        onTap: () {
          _doorStateModel.setIsSetting(true);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModel<OpenDoorStateModel>(
        model: _doorStateModel,
        child: ScopedModelDescendant<OpenDoorStateModel>(builder: (context, child, model) {
          if (stateModel?.customerType != 2) {
            return CommonScaffold(
                appTitle: "一键开门",
                bodyData: TouristNoRecord(() {
                  Navigate.toNewPage(MyHousePage());
                }));
          } else {
            return CommonScaffold(
                appTitle: "一键开门",
                bodyData: _buildBody(),
                appBarActions: [
                  FlatButton(
                      onPressed: () {
                        if (!_doorStateModel.isSetting) {
                          Navigate.toNewPage(OpenDoorHistoryPage());
                        }
                      },
                      child: CommonText.red15Text(
                          _doorStateModel.isSetting ? '${_doorStateModel.doorUsedList?.length ?? 0}/6' : '开门记录'))
                ],
                bottomNavigationBar: ScopedModelDescendant<OpenDoorStateModel>(builder: (context, child, model) {
                  return Visibility(
                      visible: _doorStateModel.doorState == ListState.HINT_DISMISS, child: _buildButton());
                }));
          }
        })
//        child: SafeArea(child: _buildBody())
        );
  }

  //初始化智锁的蓝牙开门
  void _initLopeBluetooth() {
    stateModel.callNative("openLopeDoorInit");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initLopeBluetooth();
    _doorStateModel.getDoorDevice();
//    _doorStateModel.openBlueDoorInit();
  }
}
