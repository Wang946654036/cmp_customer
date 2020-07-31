import 'dart:convert';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/common/common_share_model.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_shadow_container.dart';
import 'package:cmp_customer/ui/common/common_share_bottom_sheet.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/share_util.dart';
import 'package:cmp_customer/utils/shared_preferences_key.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'invitation_record.dart';

///
/// 邀请好友
///
class ShareFriendsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ShareFriends();
  }
}

class ShareFriends extends State<ShareFriendsPage> {
  GlobalKey shareWidgetKey = GlobalKey();
  String downloadUrl;

//
  _getDownloadUrl() async {
    SharedPreferences prefs = await SharedPreferencesKey.globalPrefs;
    setState(() {
      downloadUrl = prefs.getString(SharedPreferencesKey.KEY_DOWNLOAD_URL);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getDownloadUrl();
  }

  @override
  Widget build(BuildContext context) {
    //二维码图片，（目前生产环境暂时没有，如果IP地址有更换，需要重新生成二维码图片替换）
//    String imagePath = HttpOptions.baseUrl==HttpOptions.urlProduction?(Platform.isIOS?UIData.imageDownloadProductionIos:UIData.imageDownloadDemonstration):UIData.imageDownloadDemonstration;
    return CommonScaffold(
      appTitle: '邀请好友',
      bodyData: SingleChildScrollView(
          child: CommonShadowContainer(
        margin: EdgeInsets.symmetric(horizontal: UIData.spaceSize16, vertical: UIData.spaceSize12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
          RepaintBoundary(
              key: shareWidgetKey,
              child: Container(
                color: UIData.primaryColor,
                child: Column(
                  children: <Widget>[
                    Container(
                      width: ScreenUtil.getInstance().setWidth(150),
                      height: ScreenUtil.getInstance().setWidth(150),
                      margin: EdgeInsets.only(
                        top: ScreenUtil.getInstance().setHeight(50),
                      ),
//                          child: Visibility(
//                            visible: StringsHelper.isNotEmpty(downloadUrl),
//                            child:QrImage(
//                              size: ScreenUtil.getInstance().setHeight(50),
//                              data: downloadUrl??"",
//                            )
//                          ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Visibility(
                            visible: StringsHelper.isNotEmpty(downloadUrl),
                            child: QrImage(
                              data: downloadUrl ?? "",
                              foregroundColor: UIData.darkGreyColor,
                            ),
                          ),
                          Container(
                              width: ScreenUtil.getInstance().setWidth(28),
                              height: ScreenUtil.getInstance().setWidth(28),
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0), color: UIData.primaryColor),
                              child: Image.asset(
                                HttpOptions.baseUrl == HttpOptions.urlProduction
                                    ? UIData.iconLauncher
                                    : UIData.iconLauncherDemonstration,
                              ))
                        ],
                      ),
                    ),
//                        Padding(
//                          padding: EdgeInsets.only(top: UIData.spaceSize8),
//                          child: CommonText.darkGrey14Text(
//                              stateModel.appName + "：" + stateModel.version),
//                        ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: UIData.spaceSize16),
                      child: CommonText.lightGrey14Text("扫描二维码，你的朋友也能下载" + stateModel.appName),
                    )
                  ],
                ),
              )),
          CommonDivider(),
          FlatButton(
            child: CommonText.red16Text("邀请好友"),
            onPressed: () {
              if (downloadUrl == null || downloadUrl.isEmpty) {
                CommonToast.show(type: ToastIconType.INFO, msg: "二维码加载失败，请重新打开页面");
              } else {
//                if (HttpOptions.baseUrl == HttpOptions.urlProduction) {
//                  ShareUtil.shareWidget(shareWidgetKey);
//                } else {
                  if (stateModel.customerType == 2 && stateModel.isSettle) {
//                  showModalBottomSheet(
//                    context: context,
//                    builder: (BuildContext context) {
//                      //测试数据
//                      return CommonShareBottomSheet(CommonShareModel(
//                          title: "招商到家汇",
//                          text: "随我一同加入招商到家汇吧",
//                          thumbImageUrl: "https://appimg.dbankcdn.com/hwmarket/files/application/icon144/78ba6a1b12214ecb9c48b8e222159aca.png",
//                          url: "https://cmpss.cmpmc.com/template/appDownload/download_zsdjh.html"
//                      ));
//                    },
//                  );
                    String baseUrl = HttpOptions.baseUrl.replaceAll('ubms-customer/', '');
                    String imageUrl = HttpOptions.urlProduction.replaceAll('ubms-customer/', '');
                    ShareUtil.showShareMenu(
                        context,
                        CommonShareModel(
                          title: "招商到家汇",
                          text: "随我一同加入招商到家汇吧",
                          thumbImageUrl: imageUrl + "template/appShare/images/icon_app.png",
                          url: baseUrl +
                              "template/appShare/shareDownload.html?custHeadPhotoUrl=${HttpOptions.showPhotoUrl(stateModel.portrait)}"
                                  "&custName=${StringsHelper.encodeBase64(stateModel.personalInfo?.nickName ?? "")}&custId=${stateModel.accountId}",
                        ));
                  } else {
//                  ShareUtil.shareWidget(shareWidgetKey);
                    String baseUrl = HttpOptions.baseUrl.replaceAll('ubms-customer/', '');
                    String imageUrl = HttpOptions.urlProduction.replaceAll('ubms-customer/', '');
                    ShareUtil.showShareMenu(
                        context,
                        CommonShareModel(
                          title: "招商到家汇",
                          text: "随我一同加入招商到家汇吧",
                          thumbImageUrl: imageUrl + "template/appShare/images/icon_app.png",
                          url: baseUrl +
                              "template/appDownload/download_zsdjh"
                                  "${HttpOptions.baseUrl == HttpOptions.urlDemonstration ? '_demo' : HttpOptions.baseUrl == HttpOptions.urlTest ? '_test' : ''}"
                                  ".html",
                        ));
                  }
//                }
              }
            },
          )
        ]),
      )),
      appBarActions: [
        FlatButton(
            onPressed: () => Navigate.toNewPage(InvitationRecordPage()), child: CommonText.red15Text('邀请记录'))
      ],
    );
  }
}
