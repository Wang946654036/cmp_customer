//import 'package:cmp_customer/ui/common/common_scaffold.dart';
//import 'package:cmp_customer/ui/home/ace_bottom_navigation_bar.dart';
//import 'package:cmp_customer/utils/ui_data.dart';
//import 'package:flutter/material.dart';
//
//class HomePage extends StatefulWidget {
//  @override
//  _HomePageState createState() => _HomePageState();
//}
//
//class _HomePageState extends State<HomePage> {
//  var _currentIndex = 0;
//
//  @override
//  void initState() {
//    super.initState();
//  }
//
//  @override
//  void dispose() {
//    super.dispose();
//  }
//
//  ///
//  /// 底部导航栏，中间按钮突起效果
//  ///
//  Widget _buildBottomNavigationBar() {
//    return ACEBottomNavigationBar(
//        type: ACEBottomNavigationBarType.protruding,
//        textUnSelectedColor: UIData.darkGreyColor,
//        textSelectedColor: UIData.darkGreyColor,
//        protrudingColor: UIData.darkGreyColor,
//        items: [
//          NavigationItemBean(
//              textStr: '首页',
//              textUnSelectedColor: UIData.darkGreyColor,
//              textSelectedColor: UIData.darkGreyColor,
//              image: AssetImage(UIData.iconHomeNormal),
//              imageSelected: AssetImage(UIData.iconHomeSelected)),
//          NavigationItemBean(
//              textStr: '服务',
//              textUnSelectedColor: UIData.darkGreyColor,
//              textSelectedColor: UIData.darkGreyColor,
//              image: AssetImage(UIData.iconServiceNormal),
//              imageSelected: AssetImage(UIData.iconServiceSelected)),
//          NavigationItemBean(
//              textStr: '一键开门',
//              textUnSelectedColor: UIData.darkGreyColor,
//              textSelectedColor: UIData.darkGreyColor,
//              image: AssetImage(UIData.iconOpenDoor),
//              isProtruding: true),
//          NavigationItemBean(
//              textStr: '商城',
//              textUnSelectedColor: UIData.darkGreyColor,
//              textSelectedColor: UIData.darkGreyColor,
//              image: AssetImage(UIData.iconMallNormal),
//              imageSelected: AssetImage(UIData.iconMallSelected)),
//          NavigationItemBean(
//              textStr: '我的',
//              textUnSelectedColor: UIData.darkGreyColor,
//              textSelectedColor: UIData.darkGreyColor,
//              image: AssetImage(UIData.iconMeNormal),
//              imageSelected: AssetImage(UIData.iconMeSelected))
//        ],
//        onTabChangedListener: (index) {
//          setState(() {
//            _currentIndex = index;
////            _pageChange(index);
//          });
//        });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return CommonScaffold(
//      bottomNavigationBar: _buildBottomNavigationBar(),
//    );
//  }
//}
