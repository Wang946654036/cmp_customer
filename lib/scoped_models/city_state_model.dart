import 'dart:async';
import 'dart:convert';


import 'package:azlistview/azlistview.dart';
import 'package:cmp_customer/models/city_model.dart';
import 'package:cmp_customer/models/common/common_page_model.dart';
import 'package:cmp_customer/utils/city_dictionary.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/shared_preferences_key.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


mixin CityStateModel on Model {
  List<CityInfo> cityHotList = [
    CityInfo(code: "440300",name: "深圳市"),
    CityInfo(code: "110100",name: "北京市"),
    CityInfo(code: "310100",name: "上海市"),
    CityInfo(code: "440100",name: "广州市"),
    CityInfo(code: "320500",name: "苏州市"),
    CityInfo(code: "320100",name: "南京市"),
  ];//"深圳市","北京市","上海市","广州市","苏州市","南京市"]
  List<CityInfo> _cityAllList = new List();
  List<CityInfo> _searchCityList = List();
  String _suspensionTag = "";

  List<CityInfo> get cityAllList => _cityAllList;

  String get suspensionTag => _suspensionTag;

  List<CityInfo> get searchCityList => _searchCityList;

  loadCityData() async {
    //加载城市列表
    if (_cityAllList.isEmpty) {
      Map<int, String> addressMap = AddressDict.cityValues;
      List<CityInfo> cityList = List();
      addressMap.forEach((int code, String name) {
        cityList.add(CityInfo(name: name, code: code.toString()));
      });
      _handleList(cityList);
      _cityAllList.addAll(cityList);
      notifyListeners();
    }
  }

  void _handleList(List<CityInfo> list) {
    if (list == null || list.isEmpty) return;
    for (int i = 0, length = list.length; i < length; i++) {
      String pinyin = PinyinHelper.getPinyinE(list[i].name);
      String tag = pinyin.substring(0, 1).toUpperCase();
      if (RegExp("[A-Z]").hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = "#";
      }
    }
//    LogUtils.printLog('_handleList:$list');
    //根据A-Z排序
    SuspensionUtil.sortListBySuspensionTag(list);
  }

  void onSusTagChanged(String tag) {
    _suspensionTag = tag;
    notifyListeners();
  }

  static CityStateModel of(context) => ScopedModel.of<CityStateModel>(context);
}
