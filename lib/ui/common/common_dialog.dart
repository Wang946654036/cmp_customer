import 'dart:io';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/models/ad_info_model.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/house_authentication/my_house_page.dart';
import 'package:cmp_customer/ui/house_authentication/tourist_no_record.dart';
import 'package:cmp_customer/ui/html/html_page.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../main.dart';

///
/// 公用弹框
///
class CommonDialog {
  ///
  /// 提示框样式
  ///
  static Widget showAlertDialog(
    BuildContext context, {
    Key key,
    barrierDismissible = false,
    onConfirm,
    onCancel,
    String title,
    var contentPadding,
    var content,
    double contentFontSize,
    String positiveBtnText = '确认',
    Color positiveBtnColor,
    String negativeBtnText = '取消',
    bool showNegativeBtn = true,
    bool showPositiveBtn = true,
    bool willPop = true,
    bool onTapCloseDialog = true,
  }) {
    showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (BuildContext context) {
          return WillPopScope(
              child: SimpleDialog(
                key: key,
//            title: Text('标题'),
                contentPadding: contentPadding ?? EdgeInsets.only(top: UIData.spaceSize16),
                children: <Widget>[
//              Offstage(
//                offstage: content != null,
//                child: Icon(Icons.info_outline, color: UIData.primaryColor, size: 35.0),
//              ),
//              Container(
//                height: UIData.spaceSize16,
//              ),
                  Offstage(
                      offstage: title == null,
                      child: Container(
                        margin: EdgeInsets.only(bottom: UIData.spaceSize12),
                        child: CommonText.darkGrey18Text(title ?? ''),
                      )),
                  Offstage(
                      offstage: content == null,
                      child: content is String
                          ? Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize20),
                              margin: EdgeInsets.symmetric(vertical: UIData.spaceSize16),
                              child: Text(content ?? '',
                                  style: TextStyle(
                                      color: UIData.darkGreyColor,
                                      height: 1.2,
                                      fontSize: contentFontSize ?? UIData.fontSize14),
                                  overflow: TextOverflow.fade),
//                              child: CommonText.text14(content ?? '',
//                                  color: UIData.darkGreyColor,
//                                  height: 1.2,
//                                  overflow: TextOverflow.fade),
                            )
                          : content),
                  Offstage(
                      offstage: !showPositiveBtn && !showNegativeBtn,
                      child: Container(
                        margin: EdgeInsets.only(top: UIData.spaceSize16),
                        decoration: BoxDecoration(border: Border(top: BorderSide(color: UIData.dividerColor))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Visibility(
                                visible: showNegativeBtn,
                                child: Expanded(
                                  child: GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      child: Container(
                                        height: ScreenUtil.getInstance().setHeight(45),
                                        alignment: Alignment.center,
                                        child: CommonText.lightGrey16Text(negativeBtnText),
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);
                                        if (onCancel != null) onCancel();
                                      }),
                                )),
                            Visibility(
                              visible: showNegativeBtn && showPositiveBtn,
                              child: Container(
                                width: 1.0,
                                height: ScreenUtil.getInstance().setHeight(45),
                                color: UIData.dividerColor,
                              ),
                            ),
                            Visibility(
                                visible: showPositiveBtn,
                                child: Expanded(
                                  child: GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      child: Container(
                                        height: ScreenUtil.getInstance().setHeight(45),
                                        alignment: Alignment.center,
                                        child: CommonText.text16(positiveBtnText,
                                            color: positiveBtnColor ?? UIData.redColor),
                                      ),
                                      onTap: () {
//                                    Navigator.pop(context);
                                        if (onTapCloseDialog) Navigator.pop(context);
                                        if (onConfirm != null) onConfirm();
                                      }),
                                )),
                          ],
                        ),
                      )),
//              FlatButton(onPressed: () {}, child: CommonText.blue15Text('确定')),
                ],
              ),
              onWillPop: () async {
                return Future.value(willPop);
              });
        });
    return null;
  }

  //未认证窗口
  static Widget showUncertifiedDialog(BuildContext context, {String content}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SimpleDialog(
            backgroundColor: Colors.transparent,
            contentPadding: EdgeInsets.only(top: UIData.spaceSize16),
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                height: UIData.spaceSize40,
                child: GestureDetector(
                    child:
                        Image.asset(UIData.imageRoundClose, width: UIData.spaceSize24, height: UIData.spaceSize24),
                    onTap: () {
                      Navigator.pop(context);
                    }),
              ),
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: UIData.primaryColor),
//                color: UIData.primaryColor,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: UIData.spaceSize40),
                      Image.asset(
                        UIData.imageTouristNoRecord,
                        fit: BoxFit.fitWidth,
                        width: ScreenUtil.getInstance().setWidth(135),
                      ),
                      SizedBox(height: UIData.spaceSize16),
                      CommonText.grey16Text(content ?? '您在当前社区是游客身份\n完成房屋认证即可畅享服务哟', textAlign: TextAlign.center),
                      SizedBox(height: UIData.spaceSize20),
                      StadiumSolidButton(
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize20),
                          child: CommonText.white16Text('马上认证'),
                        ),
                        onTap: () {
                          Navigate.closePage();
                          Navigate.toNewPage(MyHousePage());
                        },
                      ),
//                      FlatButton(
//                          onPressed: () {
//                            Navigate.closePage();
//                            Navigate.toNewPage(MyHousePage());
//                          },
//                          child: CommonText.red16Text('马上认证')),
                      SizedBox(height: UIData.spaceSize40),
                    ],
                  ),
                ),
              ),
              SizedBox(height: UIData.spaceSize40)
            ],
          );
        });
    return null;
  }

  //开发中窗口
  static Widget showDevelopmentDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SimpleDialog(
            backgroundColor: Colors.transparent,
            contentPadding: EdgeInsets.only(top: UIData.spaceSize16),
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                height: UIData.spaceSize40,
                child: GestureDetector(
                    child: Image.asset(
                      UIData.imageRoundClose,
                      width: UIData.spaceSize24,
                      height: UIData.spaceSize24,
                    ),
//                    child: Icon(Icons.close,color: UIData.primaryColor,size: UIData.spaceSize24,),
                    onTap: () {
                      Navigator.pop(context);
                    }),
              ),
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: UIData.primaryColor),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: UIData.spaceSize40),
                      Image.asset(
                        UIData.imageInDevelopment,
                        fit: BoxFit.fitWidth,
                        width: ScreenUtil.getInstance().setWidth(135),
                      ),
                      SizedBox(height: UIData.spaceSize16),
                      CommonText.grey16Text('功能建设中，敬请期待！', textAlign: TextAlign.center),
                      SizedBox(height: UIData.spaceSize20),
                      StadiumSolidButton(
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize20),
                          child: CommonText.white16Text('我知道了'),
                        ),
                        onTap: () {
                          Navigate.closePage();
                        },
                      ),
                      SizedBox(height: UIData.spaceSize40),
//                      FlatButton(
//                          onPressed: () {
//                            Navigate.closePage();
//                          },
//                          child: CommonText.red16Text('我知道了')),
                    ],
                  ),
                ),
              ),
              SizedBox(height: UIData.spaceSize40)
            ],
          );
        });
    return null;
  }

  //升级中窗口
  static Widget showUpgradingDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SimpleDialog(
            backgroundColor: Colors.transparent,
//            contentPadding: EdgeInsets.only(top: UIData.spaceSize16),
            children: <Widget>[
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: UIData.primaryColor),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: UIData.spaceSize16),
                      Image.asset(
                        UIData.imageInUpgrading,
                        fit: BoxFit.fitWidth,
                        width: ScreenUtil.getInstance().setWidth(155),
                      ),
                      SizedBox(height: UIData.spaceSize8),
                      CommonText.grey16Text('请耐心等候升级！', textAlign: TextAlign.center),
                      SizedBox(height: UIData.spaceSize16),
                    ],
                  ),
                ),
              ),
              SizedBox(height: UIData.spaceSize40)
            ],
          );
        });
    return null;
  }

  //应用内升级提示框
  static Widget showUpgradeDialog(
    BuildContext context, {
    onConfirm,
    onCancel,
    String version,
    String content,
//    bool willPop = true,
    bool isForce = true,
    bool onTapCloseDialog = true,
  }) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
              child: SimpleDialog(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Image.asset(UIData.imageUpgradeBg),
                      Positioned.fill(
                          child: Container(
                              padding: EdgeInsets.only(
                                  top: UIData.spaceSize120,
                                  left: UIData.spaceSize20,
                                  right: UIData.spaceSize20,
                                  bottom: UIData.spaceSize16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  CommonText.darkGrey18Text(
                                      '发现新版本 ${HttpOptions.baseUrl == HttpOptions.urlProduction ? 'V' : ''}$version'),
                                  SizedBox(height: UIData.spaceSize16),
                                  Expanded(
                                      child: SingleChildScrollView(
                                    child: Center(
                                        child: CommonText.grey15Text(
                                      StringsHelper.isNotEmpty(content) ? content : '程序猿修复了若干个Bug和提升了稳定性，请大胆的更新吧！',
                                    )),
                                  )),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      FlatButton(
                                          onPressed: () {
                                            if (onTapCloseDialog) Navigator.pop(context);
                                            if (onConfirm != null) onConfirm();
                                          },
                                          child: CommonText.white16Text('好，立即更新'),
                                          color: Colors.redAccent),
                                      Visibility(
                                          child: FlatButton(
                                              onPressed: () {
                                                if (onCancel != null)
                                                  onCancel();
                                                else
                                                  Navigator.pop(context);
                                              },
                                              child: CommonText.text16('暂不更新', color: Colors.redAccent),
                                              color: UIData.lightestRedColor),
                                          visible: !isForce)
                                    ],
                                  )
                                ],
                              ))),
                    ],
                  )
                ],
              ),
              onWillPop: () async {
                return Future.value(!isForce);
              });
        });
    return null;
  }

  //广告跳转窗口
  static Widget showAdDialog(BuildContext context, AdInfo adInfo, {File bgImage}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SimpleDialog(
            backgroundColor: Colors.transparent,
            contentPadding: EdgeInsets.only(top: UIData.spaceSize16),
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                height: UIData.spaceSize40,
                child: GestureDetector(
                    child:
                        Image.asset(UIData.imageRoundClose, width: UIData.spaceSize24, height: UIData.spaceSize24),
                    onTap: () {
                      Navigator.pop(context);
                    }),
              ),
              GestureDetector(
                child: Container(
//                width: ScreenUtil.getInstance().setWidth(100),
                  alignment: Alignment.center,
                  child: Image.file(bgImage, fit: BoxFit.fitWidth),
                ),
                onTap: () {
                  Navigator.pop(context);
                  if (adInfo.foreign == '绿萝') {
                    if (2 == stateModel?.customerType && stateModel.hasHouse) {
                      Navigate.toNewPage(HtmlPage(HttpOptions.getLvluoUrl(stateModel.userAccount), '绿萝行动'));
                    } else {
                      CommonDialog.showUncertifiedDialog(context, content: '很抱歉，您当前身份是游客，\n请完成房屋认证后方可参加活动哦');
                    }
                  } else {
                    if (StringsHelper.isNotEmpty(adInfo?.toUrl)) {
                      Navigate.toNewPage(HtmlPage(adInfo?.toUrl, adInfo?.title ?? ''));
                    }
                  }
                },
              ),
            ],
          );
        });
    return null;
  }
}

//class CommonAlertDialog extends StatelessWidget {
//  final BuildContext context;
//  final bool barrierDismissible;
//  final Function onConfirm;
//  final Function onCancel;
//  final String title;
//  final String content;
//  final String positiveBtnText;
//  final String negativeBtnText;
//  final bool showNegativeBtn;
//
//  CommonAlertDialog(
//    this.context, {
//    this.title,
//    this.content,
//    this.barrierDismissible = false,
//    this.showNegativeBtn = true,
//    this.positiveBtnText = '确定',
//    this.negativeBtnText = '取消',
//    this.onConfirm,
//    this.onCancel,
//  });
//
//  @override
//  Widget build(BuildContext context) {
//    return Container();
//  }
//}
