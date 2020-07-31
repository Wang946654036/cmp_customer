import 'dart:convert';

import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/response/door_list_response.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/shared_preferences_key.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin OpenDoorUsedModel on Model {

  List<DeviceInfo> usedList; //常用列表
  String usedDoorData; //常用门列表json字符串


  //重新加载常用门数据
  void reloadUsedDoor(){
    usedList = null;
    usedDoorData = null;
    _getUsedDoorData();
  }

  //获取常用列表
  _getUsedDoorData() async{
    try{
      SharedPreferences prefs = await SharedPreferencesKey.globalPrefs;
//      prefs.remove(SharedPreferencesKey.KEY_USED_DOOR + stateModel.customerId.toString());//测试
      int projectId = prefs.getInt(SharedPreferencesKey.KEY_PROJECT_ID);
      int customerId = prefs.getInt(SharedPreferencesKey.KEY_CUSTOMER_ID);
      if(projectId != null && customerId != null){
        String data = prefs.getString(
//          SharedPreferencesKey.KEY_USED_DOOR + stateModel.defaultProjectId.toString() + stateModel.customerId.toString());
            SharedPreferencesKey.KEY_USED_DOOR + projectId.toString() + customerId.toString());
        LogUtils.printLog(data);
        if (data != null){
          usedDoorData=data;
          UsedDoor usedDoor= UsedDoor.fromJson(json.decode(data));
          if(usedDoor!=null){
            usedList=usedDoor.usedList;
            return ;
          }
        }
      }
    }catch(e){

    }
    usedList=null;
  }

  setUsedDoorData(List<DeviceInfo> list) async{
    usedList = new List();
    usedList.addAll(list);
    notifyListeners();
    UsedDoor usedDoor = new UsedDoor(list);
    String data=json.encode(usedDoor);
    SharedPreferences prefs = await SharedPreferencesKey.globalPrefs;
    prefs.setString(
        SharedPreferencesKey.KEY_USED_DOOR + stateModel.defaultProjectId.toString() + stateModel.customerId.toString(),
        data);
    usedDoorData=data;
  }
}
