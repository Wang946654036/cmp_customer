import 'dart:async';
import 'dart:io';

import 'package:amap_base_location/amap_base_location.dart';
import 'package:cmp_customer/locale/chinese_locale.dart';
import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/ui/common/error_page.dart';
import 'package:cmp_customer/ui/home/main_page.dart';
import 'package:cmp_customer/ui/login/intro_page.dart';
import 'package:cmp_customer/ui/login/login_page.dart';
import 'package:cmp_customer/ui/login/welcome_page.dart';
import 'package:cmp_customer/ui/me/check_verification_code_page.dart';
import 'package:cmp_customer/ui/me/modify_phone_no_page.dart';
import 'package:cmp_customer/ui/me/personal_info_page.dart';
import 'package:cmp_customer/ui/me/setting_page.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_picker/PickerLocalizationsDelegate.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tip_dialog/tip_dialog.dart';
import 'package:sentry/sentry.dart';

import 'http/http_options.dart';
import 'ui/login/first_privacy_policy_page.dart';

final SentryClient _sentry = new SentryClient(dsn: 'https://3c029a14d7a14f43b605c2ae9ccb4557@sentry.io/1496712');

/// Reports [error] along with its [stackTrace] to Sentry.io.
Future<Null> reportError(dynamic error, dynamic stackTrace) async {
  LogUtils.printLog('Caught error: $error');

  // Errors thrown in development mode are unlikely to be interesting. You can
  // check if you are running in dev mode using an assertion and omit sending
  // the report.
  if (HttpOptions.isInDebugMode) {
    LogUtils.printLog(stackTrace?.toString());
    LogUtils.printLog('In dev mode. Not sending report to Sentry.io.');
    return;
  }

  LogUtils.printLog('Reporting to Sentry.io...');

  Event _event = Event(
    release: stateModel.version,
    userContext: User(username: stateModel.userAccount, id: stateModel.customerId?.toString()),
    extra: stateModel.deviceInfo,
    exception: error,
    stackTrace: stackTrace,
  );

//  final SentryResponse response = await _sentry.captureException(
//    exception: error,
//    stackTrace: stackTrace,
//  );
  SentryResponse response;
  if (HttpOptions.baseUrl == HttpOptions.urlProduction)
    response = await _sentry.capture(
      event: _event,
    );

  if (response.isSuccessful) {
    LogUtils.printLog('Success! Event ID: ${response.eventId}');
  } else {
    LogUtils.printLog('Failed to report to Sentry.io: ${response.error}');
  }
}

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///
  /// 强制竖屏
  ///
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  //高德地图ios初始化key
  await AMap.init('059ad16b8b7d3cb088d72e9dc67d4771');

  // This captures errors reported by the Flutter framework.
  FlutterError.onError = (FlutterErrorDetails details) async {
    if (HttpOptions.isInDebugMode) {
      // In development mode simply print to console.
      FlutterError.dumpErrorToConsole(details);
    } else {
      // In production mode report to the application zone to report to
      // Sentry.
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };

  runZoned<Future<Null>>(() async {
    runApp(MyApp());
  }, onError: (error, stackTrace) async {
    await reportError(error, stackTrace);
  });

//  runApp(MyApp());
  if (Platform.isAndroid) {
    /// 以下两行 设置android状态栏为透明的沉浸。
    /// 写在组件渲染之后，是为了在渲染后进行set赋值，
    /// 覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

final GlobalKey<TipDialogContainerState> tipDialogKey = GlobalKey<TipDialogContainerState>();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final MainStateModel stateModel = MainStateModel();
BuildContext mainContext;

Widget _getErrorWidget(FlutterErrorDetails error) {
  return ErrorPage(error);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ErrorWidget.builder = _getErrorWidget;
    return ScopedModel<MainStateModel>(
      model: stateModel,
      child: TipDialogContainer(
          key: tipDialogKey,
          maskAlpha: 0.0,
//          duration: UIData.tipDialogDurationTime,
          child: MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
//                platform: TargetPlatform.iOS,
                primaryColor: UIData.primaryColor,
                primarySwatch: Colors.red,
                primaryColorBrightness: Brightness.light,
                cursorColor: UIData.themeBgColor,
                hintColor: UIData.lightGreyColor,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                scaffoldBackgroundColor: UIData.scaffoldBgColor,
                dividerColor: UIData.dividerColor,
                unselectedWidgetColor: UIData.lightestGreyColor,
                brightness: Brightness.light,
//                bottomAppBarColor: Colors.transparent,
                appBarTheme:
                    AppBarTheme(textTheme: TextTheme(title: TextStyle(fontSize: 18.0, color: Color(0xFF333333))))),
            darkTheme: ThemeData(
//                platform: TargetPlatform.iOS,
                primaryColor: UIData.primaryColor,
                primarySwatch: Colors.red,
                primaryColorBrightness: Brightness.light,
                cursorColor: UIData.themeBgColor,
                hintColor: UIData.lightGreyColor,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                scaffoldBackgroundColor: UIData.scaffoldBgColor,
                dividerColor: UIData.dividerColor,
                unselectedWidgetColor: UIData.lightestGreyColor,
                brightness: Brightness.light,
//                bottomAppBarColor: Colors.transparent,
                appBarTheme:
                    AppBarTheme(textTheme: TextTheme(title: TextStyle(fontSize: 18.0, color: Color(0xFF333333))))),
            localizationsDelegates: [
//              DefaultCupertinoLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              ChineseCupertinoLocalizations.delegate,
              PickerLocalizationsDelegate.delegate,
            ],
            supportedLocales: [const Locale('zh', 'CH')],
            home: WelcomePage(),
            routes: <String, WidgetBuilder>{
              Constant.pageMain: (BuildContext context) => MainPage(),
              Constant.pageLogin: (BuildContext context) => LoginPage(),
              Constant.pageIntro: (BuildContext context) => IntroPage(),
//              Constant.pageFeedback: (BuildContext context) => FeedbackPage(FeedbackType.opinion),
              Constant.pagePersonalInfo: (BuildContext context) => PersonalInfoPage(),
              Constant.pageSetting: (BuildContext context) => SettingPage(),
              Constant.pageModifyPhoneNo: (BuildContext context) => ModifyPhoneNoPage(),
              Constant.pageCheckVerificationCode: (BuildContext context) => CheckVerificationCodePage(),
              Constant.pageFirstPolicy: (BuildContext context) => FirstPrivacyPolicyPage(),
            },
          )),
    );
  }
}
