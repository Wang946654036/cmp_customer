import 'package:cached_network_image/cached_network_image.dart';
import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/response/winning_record_response.dart';
import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/ui/common/common_dialog.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_image_widget.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_shadow_container.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/me/common_me_single_row.dart';
import 'package:cmp_customer/ui/me/community_selection_page.dart';
import 'package:cmp_customer/ui/me/share_friends.dart';
import 'package:cmp_customer/ui/pgc/pgc_my_collect/pgc_my_collect_tab.dart';
import 'package:cmp_customer/ui/work_other/complaint_page.dart';
import 'package:cmp_customer/ui/work_other/customer_feedback.dart';
import 'package:cmp_customer/ui/work_other/work_other_ui.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scoped_model/scoped_model.dart';

import 'about_page.dart';
import 'winning_record.dart';

///
/// 我的
///
class MePage extends StatefulWidget {
  @override
  _MePageState createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///
  /// 顶部色块
  ///
  Widget _buildHeader() {
    return GestureDetector(
      child: Container(
        height: ScreenUtil.getInstance().setHeight(140),
        padding: EdgeInsets.only(left: UIData.spaceSize16, bottom: UIData.spaceSize20),
        alignment: Alignment.bottomLeft,
        decoration: BoxDecoration(
//      shape: StadiumBorder(),
          gradient: LinearGradient(colors: [UIData.goldenGradient1, UIData.goldenGradient2]),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: ScreenUtil.getInstance().setWidth(55),
              height: ScreenUtil.getInstance().setWidth(55),
              padding: EdgeInsets.all(1.0),
              decoration: ShapeDecoration(shape: StadiumBorder(), color: UIData.primaryColor),
              child: ClipOval(
                child: CommonImageWidget(stateModel.portrait,
                    loadingImage: UIData.imagePortrait,
                    loadedFailedImage: UIData.imagePortrait,
                    loadedNoDataImage: UIData.imagePortrait),
//                child: StringsHelper.isNotEmpty(stateModel.portrait)
//                    ? CachedNetworkImage(
//                        placeholder: (context, url) => Image.asset(UIData.imagePortrait),
//                        errorWidget: (context, url, error) => Image.asset(UIData.imagePortrait),
//                        imageUrl: HttpOptions.showPhotoUrl(stateModel.portrait),
//                        fit: BoxFit.fill,
//                      )
//                    : Image.asset(
//                        UIData.imagePortrait,
//                        fit: BoxFit.fill,
//                      ),
              ),
            ),
            Expanded(
                child: ListTile(
              dense: true,
//              isThreeLine: true,
              //是客户显示客户名称，游客显示昵称
              title: CommonText.white17Text(
                  stateModel.customerType == 2
                      ? (stateModel.customerName ?? '')
                      : (stateModel.personalInfo?.nickName ?? ''),
                  textAlign: TextAlign.start),
              subtitle: stateModel.customerType == 2
                  ? CommonText.white14Text(stateModel.defaultProjectName ?? '', textAlign: TextAlign.start)
                  : null,
              trailing: Icon(Icons.keyboard_arrow_right, color: UIData.primaryColor),
            ))
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).pushNamed(Constant.pagePersonalInfo);
      },
    );
  }

  ///
  /// 第一个卡片
  ///
  Widget _buildFirstCard() {
    return CommonShadowContainer(
      margin: EdgeInsets.all(UIData.spaceSize16),
      child: Column(
        children: <Widget>[
          MeSingleLine('表扬', backgroundColor: Colors.transparent, onTap: () {
            if (stateModel.defaultProjectId != null)
              Navigate.toNewPage(ComplaintPage(
                WorkOtherMainType.Praise,
                sub: WorkOtherSubType.Praise,
              ));
          }),
          CommonDivider(),
          MeSingleLine('咨询建议',
              backgroundColor: Colors.transparent,
              onTap: () => Navigate.toNewPage(ComplaintPage(
                    WorkOtherMainType.Advice,
                    sub: WorkOtherSubType.Advice,
                  ))),
        ],
      ),
    );
  }

  ///
  /// 第二个卡片
  ///
  Widget _buildSecondCard() {
    return CommonShadowContainer(
      margin: EdgeInsets.symmetric(horizontal: UIData.spaceSize16, vertical: UIData.spaceSize16),
      child: Column(
        children: <Widget>[
          ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
            return Visibility(
                visible: model.baseDataLoaded == 1, //0=加载中，1=加载成功，2=加载失败
                child: Column(
                  children: <Widget>[
                    MeSingleLine('切换社区',
                        backgroundColor: Colors.transparent,
                        onTap: () => Navigate.toNewPage(CommunitySelectionPage())),
                    CommonDivider(),
                    MeSingleLine('产品反馈',
                        backgroundColor: Colors.transparent,
                        onTap: () => Navigate.toNewPage(CreateCustomerFeedback())),
                    CommonDivider(),
//          Visibility(child: Column(
//            children: <Widget>[
                    MeSingleLine('我的收藏',
                        backgroundColor: Colors.transparent, onTap: () => Navigate.toNewPage(PgcMyCollectTab())),
                    CommonDivider(),
                    MeSingleLine('中奖记录',
                        backgroundColor: Colors.transparent, onTap: () => Navigate.toNewPage(WinningRecordPage())),
                    CommonDivider(),
//            ],
//          ), visible: HttpOptions.baseUrl != HttpOptions.urlProduction),
                    MeSingleLine('邀请好友',
                        backgroundColor: Colors.transparent, onTap: () => Navigate.toNewPage(ShareFriendsPage())),
                    CommonDivider(),
                  ],
                ));
          }),
          MeSingleLine('关于我们', backgroundColor: Colors.transparent, onTap: () => Navigate.toNewPage(AboutPage())
//                  CommonToast.show(msg: '开发中，稍候开放', type: ToastIconType.INFO)
//          CommonDialog.showDevelopmentDialog(context)
              ),
          CommonDivider(),
          MeSingleLine('设置',
              backgroundColor: Colors.transparent,
              onTap: () => Navigator.of(context).pushNamed(Constant.pageSetting)),
//          CommonDivider(),
//          MeSingleLine('客户热线',
//              backgroundColor: Colors.transparent, arrowVisible: false, content: StringsHelper.hotline),
        ],
      ),
    );
  }

  ///
  /// 阴影
  ///
  Widget _buildShadowContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(color: UIData.dividerColor, offset: Offset(10.0, 20.0), blurRadius: 10.0, spreadRadius: -20.0)
      ]),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      showAppBar: false,
      bodyData: Column(
        children: <Widget>[
          _buildHeader(),
//          _buildFirstCard(),
          _buildSecondCard(),
        ],
      ),
    );
  }
}
