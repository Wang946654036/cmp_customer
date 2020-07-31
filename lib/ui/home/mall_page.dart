import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/house_authentication/my_house_page.dart';
import 'package:cmp_customer/ui/html/html_page.dart';
import 'package:cmp_customer/ui/me/community_selection_page.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../main.dart';

///
/// 商城
///
class MallPage extends StatefulWidget {
  @override
  _MallPageState createState() => _MallPageState();
}

class _MallPageState extends State<MallPage> {
  String _url;
  ListState _state = ListState.HINT_LOADING;

  @override
  void initState() {
    super.initState();
    LogUtils.printLog('商城');
    _refreshData();
  }

  void _refreshData() {
    setState(() {
      _state = ListState.HINT_LOADING;
    });
    stateModel.getMallLink(callback: ({ListState state, String url}) {
      if (state != null) {
        setState(() {
          _state = state;
        });
      }
      if (StringsHelper.isNotEmpty(url)) {
        setState(() {
          _url = url;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
      if (stateModel.defaultProjectId == null) {
        return CommonScaffold(
          appTitle: '商城',
          bodyData: Container(
            color: UIData.primaryColor,
//            padding: EdgeInsets.all(UIData.spaceSize30),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
//            CommonText.darkGrey16Text('功能建设中', textAlign: TextAlign.center, fontWeight: FontWeight.w500),
//            SizedBox(height: UIData.spaceSize16),
                  Container(
                    alignment: Alignment.center,
                    height: ScreenUtil.getInstance().setWidth(135),
                    child: Image.asset(
                      UIData.imageTouristNoRecord,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  SizedBox(height: UIData.spaceSize30),
//            CommonText.darkGrey18Text('关注公众号“招商到家汇”', textAlign: TextAlign.center),
//            SizedBox(height: UIData.spaceSize20),
                  CommonText.darkGrey15Text('您目前是游客身份，\n请完成房屋认证或选择社区！',
                      fontWeight: FontWeight.w500, textAlign: TextAlign.center, overflow: TextOverflow.fade),
                  SizedBox(height: UIData.spaceSize40),
                  StadiumSolidWithTowButton(
                    conFirmText: '房屋认证',
                    onConFirm: () {
                      Navigate.toNewPage(MyHousePage());
                    },
                    cancelText: '选择社区',
                    onCancel: () {
                      Navigate.toNewPage(CommunitySelectionPage());
                    },
                  )
//            SizedBox(height: UIData.spaceSize4),
//            CommonText.grey13Text('微信中点击“添加朋友”，选择“公众号”，搜索“招商到家汇”关注。'),
//            SizedBox(height: UIData.spaceSize16),
//            CommonText.darkGrey14Text('关注方式二：', fontWeight: FontWeight.w500),
//            SizedBox(height: UIData.spaceSize4),
//            CommonText.grey13Text('截图保存本界面，并在微信中点击“扫一扫”->“相册”，选择本界面截图识别二维码关注。'),
//            SizedBox(height: UIData.spaceSize20),
//            Container(
//              alignment: Alignment.center,
//              height: ScreenUtil.getInstance().setWidth(135),
//              child: Image.asset(
//                UIData.imageWechatSubscriQrcode,
//                fit: BoxFit.fitHeight,
//              ),
//            )
                ],
              ),
            ),
          ),
        );
      } else {
//        LogUtils.printLog('商城url:${HttpOptions.getMallUrl(_url, stateModel.accountId, stateModel.defaultProjectId)}');
        return CommonScaffold(
          appTitle: '商城',
          showAppBar: _state != ListState.HINT_DISMISS,
          bodyData: CommonLoadContainer(
            state: _state,
            content: Container(
              color: UIData.primaryColor,
              child: StringsHelper.isNotEmpty(_url)
                  ? HtmlPage(
                      HttpOptions.getMallUrl(_url, stateModel.accountId, stateModel.defaultProjectId), '商城')
                  : Container(),
            ),
            callback: _refreshData,
          ),
        );
//            if(StringsHelper.isNotEmpty(_url)){
//            return HtmlPage(_url, '商城');
//            }else {
//              return Center(
//                child: CommonText.darkGrey15Text('加载中...',
//                    fontWeight: FontWeight.w500, textAlign: TextAlign.center),
//              );
//            }
      }
//          return Container();
    });
  }
}
