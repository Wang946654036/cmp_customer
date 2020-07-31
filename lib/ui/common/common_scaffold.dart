import 'dart:io';

import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

///
/// 通用脚手架
///
class CommonScaffold extends StatefulWidget {
  final scaffoldKey;
  final appTitle;
  final Widget bodyData;
  final backGroundColor;
  final elevation;
  final appBarHeight;
  final Widget leftButton;
  final showDrawer;
  final appBarActions;
  final bottomNavigationBar;
  final showAppBar;
  final appBar;
  final showLeftButton;
  final appBarBackgroundColor;
  final tabBar;
  final appBarTitleColor;
  final tabBarBackgroundColor;
  final popBack;
  final showBottomShadow;
  final floatingActionButton;
  final floatingActionButtonLocation;
  final Widget endDrawerWidget;
  final onWillPop;

  CommonScaffold({
    this.scaffoldKey,
    this.appTitle = '',
    this.bodyData,
    this.backGroundColor,
    this.elevation = 0.0,
    this.appBarHeight,
    this.leftButton,
    this.showDrawer = false,
    this.appBarActions,
    this.bottomNavigationBar,
    this.showAppBar = true,
    this.appBar,
    this.showLeftButton = true,
    this.appBarBackgroundColor = UIData.primaryColor,
    this.tabBar,
    this.appBarTitleColor = UIData.darkGreyColor,
    this.tabBarBackgroundColor,
    this.popBack,
    this.showBottomShadow = false,
    this.floatingActionButtonLocation,
    this.floatingActionButton,
    this.endDrawerWidget,
    this.onWillPop,
  });

  @override
  _CommonScaffoldState createState() => _CommonScaffoldState();
}

class _CommonScaffoldState extends State<CommonScaffold> {
  @override
  Widget build(BuildContext context) {
//    print('appBarHeight:${MediaQuery.of(context).size.height ~/ 14}');
//    print('stateBarHeight:$appTitle${MediaQuery.of(context).padding.top}');
//    print('height:$appTitle${MediaQuery.of(context).padding.top}');
//  double _statusBarHeight = MediaQuery.of(context).padding.top;
//    LogUtils.printLog('stausBarHeight:$appTitle${MediaQuery.of(context).padding.top}');
//    LogUtils.printLog('stausBarHeight-ScreenUtil:$appTitle${ScreenUtil.statusBarHeight}');
    return Platform.isAndroid
        ? WillPopScope(
            child: _buildGestureDetector(_buildScaffold()),
            onWillPop: _onWillPop,
          )
        : _buildGestureDetector(_buildScaffold());
  }

  Widget _buildGestureDetector(Widget child) {
    return GestureDetector(
      child: child,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: widget.appBarBackgroundColor,
      centerTitle: false,
      titleSpacing: 0.0,
      elevation: widget.elevation,
      title: Row(
        children: <Widget>[
          widget.showLeftButton
              ? (widget.leftButton ??
                  GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      child: Container(
//                        width: 35,
                        height: 35,
//                      iconSize: 35.0,
                        padding: EdgeInsets.only(left: UIData.spaceSize16),
                        child: Icon(Icons.keyboard_arrow_left, color: UIData.darkGreyColor),
                      ),
                      onTap: () {
//                        LogUtils.printLog('commonScaffold backButton');
                        if (widget.popBack != null)
                          widget.popBack();
                        else {
                          Navigator.of(context).pop();
                        }
                      }))
              : Container(),
          widget.appTitle is String
              ? GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: Text(widget.appTitle,
                      style: TextStyle(fontSize: UIData.fontSize18, color: widget.appBarTitleColor)),
                  onTap: () {
                    if (widget.leftButton == null) {
                      if (widget.popBack != null)
                        widget.popBack();
                      else {
                        Navigator.of(context).pop();
                      }
                    }
                  },
                )
              : widget.appTitle
        ],
      ),
//      leading:
      automaticallyImplyLeading: false,
      actions: widget.appBarActions,
      bottom: PreferredSize(
          child: Container(
            height: widget.tabBar != null ? (MediaQuery.of(context).size.height ~/ 20).toDouble() : null,
            color: widget.tabBarBackgroundColor,
            child: widget.tabBar,
          ),
          preferredSize: Size.fromHeight(
              widget.tabBar != null ? (MediaQuery.of(context).size.height ~/ 20).toDouble() : 0.0)),
    );
  }

  Widget _buildScaffold() {
    return Scaffold(
      key: widget.scaffoldKey,
      backgroundColor: widget.backGroundColor ?? UIData.scaffoldBgColor,
      appBar: widget.showAppBar ? widget.appBar ?? _buildAppBar() : null,
      body: widget.bodyData,
      endDrawer: widget.endDrawerWidget == null
          ? null
          : Drawer(
              child: widget.endDrawerWidget,
            ),
//      drawer: showDrawer ? CommonDrawer() : null,
      bottomNavigationBar: IntrinsicHeight(
          child: SafeArea(
              child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: widget.showBottomShadow ? UIData.lightGreyColor : Colors.transparent,
              offset: Offset(0.0, 15.0),
              blurRadius: 6.0,
              spreadRadius: 10.0)
        ]),
        child: widget.bottomNavigationBar,
      ))),
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
    );
  }

  Future<bool> _onWillPop() {
    if (tipDialogKey.currentState.isShow)
      CommonToast.dismiss();
    else {
      if (widget.onWillPop != null) {
        widget.onWillPop();
      } else if (navigatorKey.currentState.canPop()) {
        navigatorKey.currentState.pop();
      } else {
//        SystemNavigator.pop();
//        return Future.value(true);
        try {
          stateModel.callNative("back2Desk");
        } on PlatformException catch (e) {
          LogUtils.printLog("最小化失败：${e.toString()}");
        }
      }
    }
    return Future.value(false);
  }
}
