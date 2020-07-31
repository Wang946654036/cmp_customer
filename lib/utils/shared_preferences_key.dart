import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

export 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesKey {
  static final Future<SharedPreferences> globalPrefs = SharedPreferences.getInstance();

  //sessionId
  static final String KEY_SESSION_ID = "session_id";

//  //access_token
  static final String KEY_ACCESS_TOEKN = "key_access_token";

//  //refresh_token
  static final String KEY_REFRESH_TOEKN = "key_refresh_token";

  //上一次登录时间
  static final String KEY_LAST_LOGIN_TIME = "last_login_time";

  //第一次打开应用
  static final String KEY_FIRST_TIME_OPEN = "last_first_time_open";

//  //用户名即手机号
  static final String KEY_USER_ACCOUNT = "user_account";

  //用户姓名
  static final String KEY_USER_NAME = "user_name";

  //默认社区id
  static final String KEY_PROJECT_ID = "project_id";

  //默认社区名称
  static final String KEY_PROJECT_NAME = "project_name";

  //默认房屋id
  static final String KEY_HOUSE_ID = "house_id";

  //默认客户id
  static final String KEY_CUSTOMER_ID = "key_customer_id";

  //账号类型(1--游客;2--已经经过认证的客户)
  static final String KEY_CUSTOMER_TYPE = "customer_type";

  //默认我的月卡（本地缓存）
  static final String KEY_DEFAULT_PARKING_CARD = "default_parking_card";

  //未认证的社区列表json（本地缓存）
  static final String KEY_UNCERTIFIED_COMMUNITY = "uncertified_community";

  //常用门
  static final String KEY_USED_DOOR = "key_used_door";

  //下载地址
  static final String KEY_DOWNLOAD_URL = "key_download_url";

  //广告弹窗是否弹出标识
  static final String KEY_AD_FLAG = "key_ad_flag";

  //是否弹框集市声明
  static final String KEY_SHOW_MARKET_STATEMENT = "key_show_market_statement";

  //首页菜单缓存
  static final String KEY_HOME_MENULIST = "key_home_menulist";
}
