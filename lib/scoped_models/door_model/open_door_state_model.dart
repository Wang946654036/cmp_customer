import 'dart:async';
import 'dart:convert';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/response/base_response.dart';
import 'package:cmp_customer/models/response/door_list_response.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/decorate_manager/decoration_ui.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:scoped_model/scoped_model.dart';

class OpenDoorStateModel extends Model {
  bool isOpening=false;//开门中
  Timer timer;//定时器
//  List<PermissionGroup> permissionsGroup = [
//    PermissionGroup.location,
//    PermissionGroup.storage
//  ];
  List<DoorInfo> doorList; //开门的列表
  List<DeviceInfo> doorUsedList = new List(); //常用门的列表
  ListState doorState = ListState.HINT_LOADING;
//  String error;
  bool isSetting = false; //是否设置常用
  String tip;//列表错误提示

  //常用页面设置
  setIsSetting(bool setting){
    isSetting=setting;
    notifyListeners();
  }

//  //初始化开门所需要的权限
//  initPermission(){
//    PermissionHandler().requestPermissions(permissionsGroup);
//  }

  ///
  ///开门
  ///[deviceFactory]设备厂商:1-拓桥,2-得令,3-智锁
  ///[hexKey] 智锁蓝牙设备开门密钥
  ///
  openDoor(String type, int projectId, String deviceCode, String lockId, String deviceName, String deviceFactory,
      String hexKey,{Function callback}) {
    if (deviceFactory == '2') {
      //得令
      if (StringsHelper.isEmpty(deviceCode)) {
        CommonToast.show(msg: "开门失败，deviceCode为空", type: ToastIconType.INFO);
      } else {
        if (type == "2") {
          if (StringsHelper.isEmpty(lockId)) {
            CommonToast.show(msg: "开门失败，lockId为空", type: ToastIconType.INFO);
          } else {
            //蓝牙开门
            openDeLingBlueDoor(projectId, deviceCode, lockId, deviceName,callback:callback);
          }
        } else if (type == "1") {
          openNetDoor(type, deviceCode, deviceName, projectId,callback:callback);
        } else {
          CommonToast.show(type: ToastIconType.FAILED, msg: "此门不支持一键开门");
        }
      }
    } else if (deviceFactory == '3') {
      //智锁
      if (StringsHelper.isEmpty(deviceCode)) {
        CommonToast.show(msg: '开门失败，deviceCode为空', type: ToastIconType.INFO);
      } else if (StringsHelper.isEmpty(hexKey)) {
        CommonToast.show(msg: '开门失败，hexKey为空', type: ToastIconType.INFO);
      } else {
        openLopeBlueDoor(projectId, deviceCode, hexKey, deviceName,callback:callback);
      }
    } else {
      if (type == "1") {
        openNetDoor(type, deviceCode, deviceName, projectId,callback:callback);
      }else {
        CommonToast.show(msg: '未适配！', type: ToastIconType.INFO);
      }
    }
  }


//  //蓝牙开门初始化
//  openBlueDoorInit(){
//    if(Platform.isIOS){//ios需要先初始化，安卓是点击才初始化
//      stateModel.callNative("openDoorInit");
//    }
//  }

  //得令蓝牙开门
  openDeLingBlueDoor(int projectId,String pid,String lockId,String deviceName,{Function callback}){
    _startTimer();
    CommonToast.show(msg: "蓝牙开门中...");
    if(!isOpening){
      isOpening=true;
      Map map = new Map();
      map["pid"]=pid;
      map["lockId"]=lockId;
      stateModel.callNative("openDoor", object: map,callback: (result){
        isOpening=false;
        CommonToast.dismiss();
        _cancelTimer();
        try{
          if(result!=null){
            BaseResponse response = BaseResponse.fromJson(Map<String, dynamic>.from(result));
            CommonToast.show(msg: response.message,type: response.success()?ToastIconType.SUCCESS:ToastIconType.FAILED);
            _saveOpenBlueDoorRecord(projectId,pid,response.success()?"1":"0",deviceName,remark:response.message);//回调后台，告诉开门结果
            if(callback !=null&&response.success()) callback();//回调开门成功
          }else{
            _saveOpenBlueDoorRecord(projectId,pid,"0",deviceName,);//开门失败，回调后台
          }
        }catch(e){
          LogUtils.printLog(e.toString());
          CommonToast.show(msg: "开门失败：数据解析错误",type: ToastIconType.FAILED);
          _saveOpenBlueDoorRecord(projectId,pid,"0",deviceName,);//开门失败，回调后台
        }
      });
    }
  }

  //智锁蓝牙开门
  openLopeBlueDoor(int projectId,String mac,String key,String deviceName,{Function callback}){
    _startTimer();
    CommonToast.show(msg: "蓝牙开门中...");
    if(!isOpening){
      isOpening=true;
      Map map = new Map();
      map["mac"]=mac;
      map["key"]=key;
      stateModel.callNative("openLopeDoor", object: map,callback: (result){
        isOpening=false;
        CommonToast.dismiss();
        _cancelTimer();
        try{
          if(result!=null){
            BaseResponse response = BaseResponse.fromJson(Map<String, dynamic>.from(result));
            CommonToast.show(msg: response.message,type: response.success()?ToastIconType.SUCCESS:ToastIconType.FAILED);
            _saveOpenBlueDoorRecord(projectId,mac,response.success()?"1":"0",deviceName,remark:response.message);//回调后台，告诉开门结果
            if(callback !=null&&response.success()) callback();//回调开门成功
          }else{
            _saveOpenBlueDoorRecord(projectId,mac,"0",deviceName,);//开门失败，回调后台
          }
        }catch(e){
          LogUtils.printLog(e.toString());
          CommonToast.show(msg: "开门失败：数据解析错误",type: ToastIconType.FAILED);
          _saveOpenBlueDoorRecord(projectId,mac,"0",deviceName,);//开门失败，回调后台
        }
      });
    }
  }

  //开启定时任务
  _startTimer(){
    if(timer==null) {
      //延迟关闭窗口（防止原生未回调或回调失败）
      timer = new Timer(new Duration(seconds: 30), () {
        // 只在倒计时结束时回调
        isOpening=false;
        CommonToast.dismiss();
        _cancelTimer();
      });
    }
  }

  //取消定时任务
  _cancelTimer(){
    if(timer!=null) {
      timer.cancel();
      timer=null;
    }
  }



  //回调蓝牙开门结果给后台
  _saveOpenBlueDoorRecord(int projectId,String pid,String result,String gateName,{String remark}) {
    Map<String, Object> params = new Map();
    params['projectId'] = projectId;
    params['pid'] = pid;
    params['result'] = result;
    params['gateName'] = gateName;
    params['remark'] = remark;
    params['openTime'] = DateTime.now().millisecondsSinceEpoch.toString();//毫秒级别的时间戳
    HttpUtil.post(HttpOptions.saveOpenBlueDoorRecord, null,jsonData: json.encode(params));
  }


  //远程开门
  openNetDoor(String modeType,String deviceCode,String deviceName,int projectId,{Function callback}) {
    CommonToast.show(msg: "请求开门中...");
    Map<String, Object> params = new Map();
    params['projectId'] = projectId;
    params['modeType'] = modeType;
    params['deviceCode'] = deviceCode; //设备编码
    params['deviceName'] = deviceName; //设备名称
    HttpUtil.post(HttpOptions.openDoor, (data){
      _openNetDoorCallBack(data,callback: callback);
    },
        errorCallBack: _errorCallback, jsonData: json.encode(params));
  }

  //远程开门回调
  _openNetDoorCallBack(data,{Function callback}) {
    CommonToast.dismiss();
    try {
      BaseResponse response = BaseResponse.fromJson(data);
      CommonToast.show(type: response.success()?ToastIconType.SUCCESS:ToastIconType.FAILED, msg: response.message??"");
      if (response.success()) {
        if(callback !=null&&response.success()) callback();//回调开门成功
      }
//      else {
//        CommonToast.show(type: ToastIconType.FAILED, msg: response.message??"");
//      }
    } catch (e) {
      _errorCallback("返回参数错误");
    }
  }

  //获取一键开门的设备列表
  getDoorDevice({Function callback}) async {
    tip = null;
    doorState = ListState.HINT_LOADING;
    notifyListeners();
    Map<String, Object> params = new Map();
    params['projectId'] = stateModel.defaultProjectId; //项目id
    HttpUtil.post(HttpOptions.getDoorList, (data){_getDoorDeviceCallBack(data,callback: callback);},
        jsonData: json.encode(params),
        errorCallBack: _getDoorDeviceErrorCallback);
  }

  //获取门禁设备回调
  _getDoorDeviceCallBack(data,{Function callback}) {
    try {
      DoorListResponse response = DoorListResponse.fromJson(data);
      if (response.success()) {
        if (response.doorList == null || response.doorList.isEmpty) {
          //无数据
          doorState = ListState.HINT_NO_DATA_CLICK;
        } else {
          doorList = response.doorList;

          _initUsedDoor(doorList); //初始化已选常用门（按钮）
          doorState = ListState.HINT_DISMISS; //加载完成，隐藏加载页面
          if(callback!=null){
            callback();
          }
        }
      } else {

        doorState = ListState.HINT_LOADED_FAILED_CLICK; //加载完成，隐藏加载页面
        if(callback!=null){
          callback();
        }
        tip = response?.message??"";
//        CommonToast.show(
//            type: ToastIconType.FAILED, msg: response?.message??"");
//        error = response.message;
      }
    } catch (e) {
      print(e.toString());
      doorState = ListState.HINT_LOADED_FAILED_CLICK; //加载完成，隐藏加载页面
      if(callback!=null){
        callback();
      }
//      error = "返回参数错误";
    }
    notifyListeners();
  }

  //获取门禁设备错误回调
  _getDoorDeviceErrorCallback(data) {
    doorState = ListState.HINT_LOADED_FAILED_CLICK; //加载完成，隐藏加载页面
    notifyListeners();
//    CommonToast.show(
//        type: ToastIconType.FAILED, msg: data?.toString());
  }

  //通用错误回调
  _errorCallback(data) {
    CommonToast.show(
        type: ToastIconType.FAILED, msg: data?.toString());
  }

//  //设置开门信息(同时存在蓝牙或者远程开门使用)
//  _setOpenDoorInfo(){
//    if(doorList!=null&&doorList.isNotEmpty){
//      doorList.forEach((doorInfo){
//        if(doorInfo!=null&&doorInfo.mode!=null&&doorInfo.mode.isNotEmpty){
//          doorInfo.openDoorList=new List<OpenDoorInfo>();
//          doorInfo.mode.forEach((mode){
//            if(mode!=null&&mode.deviceList!=null&&mode.deviceList.isNotEmpty){
//              if(mode.modeType=="1"){//远程开门
//                mode.deviceList.forEach((deviceInfo){
//                  if(deviceInfo!=null){
//                    bool exist=false;
//                    for(int i=0;i<doorInfo.openDoorList.length;i++){
//                      if(doorInfo.openDoorList[i].deviceName==deviceInfo.deviceName){
//                        exist=true;//存在设备信息，赋值设备编号
//                        doorInfo.openDoorList[i].deviceCode=deviceInfo.deviceCode;
//                        break;
//                      }
//                    }
//                    if(!exist){//不存在，添加新的设备信息
//                      doorInfo.openDoorList.add(new OpenDoorInfo(deviceCode: deviceInfo.deviceCode,deviceName: deviceInfo.deviceName));
//                    }
//                  }
//                });
//              }else if(mode.modeType=="2"){//蓝牙开门
//                mode.deviceList.forEach((deviceInfo){
//                  if(deviceInfo!=null){
//                    bool exist=false;
//                    for(int i=0;i<doorInfo.openDoorList.length;i++){
//                      if(doorInfo.openDoorList[i].deviceName==deviceInfo.deviceName){
//                        exist=true;//存在设备信息，赋值设备编号
//                        doorInfo.openDoorList[i].devicePid=deviceInfo.deviceCode;
//                        break;
//                      }
//                    }
//                    if(!exist){//不存在，添加新的设备信息
//                      doorInfo.openDoorList.add(new OpenDoorInfo(devicePid: deviceInfo.deviceCode,deviceName: deviceInfo.deviceName));
//                    }
//                  }
//                });
//              }
//            }
//          });
//        }
//      });
//    }
//  }

  //初始化已设置的常用门
  _initUsedDoor(List<DoorInfo> doorList){
    List<DeviceInfo> doorUsedLocalList = List();
    doorUsedList.clear();
    doorList.forEach((doorInfo) {
      doorInfo.mode.forEach((mode) {
        mode.deviceList.forEach((DeviceInfo deviceInfo) {
          deviceInfo.projectId = StringsHelper.getIntValue(doorInfo.projectId);
          deviceInfo.projectName = doorInfo.projectName;
          deviceInfo.modeType = mode.modeType;

          DeviceInfo info = new DeviceInfo(
              StringsHelper.getIntValue(doorInfo.projectId),
              deviceInfo.lockid,
              deviceInfo.deviceCode,
              deviceInfo.deviceName,
              mode.modeType,
              doorInfo.projectName,
              true,
              deviceInfo.deviceFactory,
              deviceInfo.hexKey);
          String jsonData = json.encode(info);

          if (stateModel.usedDoorData != null && stateModel.usedDoorData.contains(jsonData)) { //校验是否包含设备信息
            deviceInfo.checked = true;
            doorUsedList.add(deviceInfo); //添加常用门列表
          }

          //更新常用门页面的设备信息
          stateModel.usedList?.forEach((DeviceInfo info) {
            if (deviceInfo.projectId == info.projectId && deviceInfo.modeType == info.modeType) {
              if (deviceInfo.deviceCode == info.deviceCode){
                //当设备名称不一致的时候，修改设备名称
                if(deviceInfo.deviceName != info.deviceName){
                  info.deviceName = deviceInfo.deviceName;
                }
                //当设lockid不一致的时候，修改lockid
                if(deviceInfo.lockid != info.lockid){
                  info.lockid = deviceInfo.lockid;
                }
                info.hexKey = deviceInfo.hexKey;
                info.deviceFactory = deviceInfo.deviceFactory;
                //添加需要保存的常用门数据，避免添加重复数据
                if(doorUsedLocalList.isEmpty||!json.encode(doorUsedLocalList).contains(json.encode(info))){
                  doorUsedLocalList.add(info);
                }
                return;
              }else if(deviceInfo.deviceName == info.deviceName){
                //当设备编号不一致的时候，修改设备编号
                if(deviceInfo.deviceCode != info.deviceCode){
                  info.deviceCode = deviceInfo.deviceCode;
                }
                //当设lockid不一致的时候，修改lockid
                if(deviceInfo.lockid != info.lockid){
                  info.lockid = deviceInfo.lockid;
                }
                info.hexKey = deviceInfo.hexKey;
                info.deviceFactory = deviceInfo.deviceFactory;
                //添加需要保存的常用门数据，避免添加重复数据
                if(doorUsedLocalList.isEmpty||!json.encode(doorUsedLocalList).contains(json.encode(info))){
                  doorUsedLocalList.add(info);
                }
              }
            }
          });
        });
      });
    });
    stateModel.setUsedDoorData(doorUsedLocalList);
  }


  //设置勾选的常用门
  void setUsedDoor(DeviceInfo info){
    if(info.checked??false){
      info.checked=false;
      doorUsedList.remove(info);
    }else{
      if(doorUsedList.length>=6){
        CommonToast.show(type: ToastIconType.INFO,msg: "最多设置6个常用门");
        return;
      }else{
        info.checked=true;
        if(!doorUsedList.contains(info)){
          doorUsedList.add(info);
        }
      }
    }
    notifyListeners();
  }

  //设置常用门
  void saveUsedDoor() async {
//    SharedPreferences prefs = await SharedPreferencesKey.globalPrefs;
//    String data = prefs.getString(
//        SharedPreferencesKey.KEY_USED_DOOR + stateModel.customerId.toString());
//    UsedDoor usedDoor;
//    if (data == null) {
//      usedDoor = new UsedDoor(new List()); //本地不存在常用门
//    }else{
//      usedDoor = UsedDoor.fromJson(json.decode(data));
//    }
//        doorUsedList.forEach((deviceInfo) {
////          UsedDoorInfo info=new UsedDoorInfo(doorInfo.projectName,
////              mode.modeType, deviceInfo.deviceName, deviceInfo.deviceCode,deviceInfo.lockid);
//          String jsonData = json.encode(deviceInfo);
//          if ((deviceInfo.checked??false)&&(stateModel.usedDoorData==null||!stateModel.usedDoorData.contains(jsonData))) {
//            list.add(info);
//          }
//        });
//    prefs.setString(
//        SharedPreferencesKey.KEY_USED_DOOR + stateModel.customerId.toString(),
//        json.encode(usedDoor));
//    stateModel.usedList=usedDoor.usedList;
//    notifyListeners();
    stateModel.setUsedDoorData(doorUsedList);
    CommonToast.show(type: ToastIconType.SUCCESS,msg: "设置常用门成功");
    Navigate.closePage();
  }
//  //设置开门信息(蓝牙或者远程只存在一种)
//  _setOpenDoorInfo() {
//    if (doorList != null && doorList.isNotEmpty) {
//      doorList.forEach((doorInfo) {
//        if (doorInfo != null &&
//            doorInfo.mode != null &&
//            doorInfo.mode.isNotEmpty) {
//          Mode mode = doorInfo.mode[0];
//          if (mode != null &&
//              mode.deviceList != null &&
//              mode.deviceList.isNotEmpty) {
//            doorInfo.openDoorList = new List<OpenDoorInfo>();
//            if (mode.modeType == "1") {
//              //远程开门
//              mode.deviceList.forEach((deviceInfo) {
//                if (deviceInfo != null) {
//                  //添加设备信息
//                  doorInfo.openDoorList.add(new OpenDoorInfo(
//                      deviceCode: deviceInfo.deviceCode,
//                      deviceName: deviceInfo.deviceName));
//                }
//              });
//            } else if (mode.modeType == "2") {
//              //蓝牙开门
//              mode.deviceList.forEach((deviceInfo) {
//                if (deviceInfo != null) {
//                  //添加设备信息
//                  doorInfo.openDoorList.add(new OpenDoorInfo(
//                      devicePid: deviceInfo.deviceCode,
//                      deviceName: deviceInfo.deviceName));
//                }
//              });
//            }
//          }
//        }
//      });
//    }
//  }

//  //获取常用列表
//  getUsedDoorData() async{
//    try{
//      SharedPreferences prefs = await SharedPreferencesKey.globalPrefs;
//      String data = prefs.getString(
//          SharedPreferencesKey.KEY_USED_DOOR + stateModel.customerId.toString());
//      if (data == null) {
//        //不存在常用列表
//      }else{
//        UsedDoor usedDoor= UsedDoor.fromJson(json.decode(data));
//        if(usedDoor!=null){
//          stateModel.usedList=usedDoor.usedList;
//        }
//      }
//    }catch(e){
//      usedList=null;
//    }
//  }
}
