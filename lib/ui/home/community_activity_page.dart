import 'package:cached_network_image/cached_network_image.dart';
import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/common/common_page_model.dart';
import 'package:cmp_customer/models/community_activity_model.dart';
import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/ui/common/common_image_widget.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_loadmore.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_shadow_container.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/html/html_page.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scoped_model/scoped_model.dart';

///
/// 社区活动列表（调查问卷、投票、活动报名）
/// [findType]查询类别:0=查询全部 1=查询本人参与过的
/// [activityType]活动类型：1=问卷调查 2=投票 3=活动报名
///
class CommunityActivityPage extends StatefulWidget {
  final int findType; //查询类别:0=查询全部 1=查询本人参与过的
  final int activityType; //活动类型：1=问卷调查 2=投票 3=活动报名

  CommunityActivityPage({this.findType = 0, this.activityType = 3});

  @override
  _CommunityActivityPageState createState() => _CommunityActivityPageState();
}

class _CommunityActivityPageState extends State<CommunityActivityPage> {
  ListPageModel _listPageModel = ListPageModel();
  ScrollController _loadMoreScrollController = new ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadMoreScrollController.addListener(() {
      if (_loadMoreScrollController.position.pixels == _loadMoreScrollController.position.maxScrollExtent) {
        if (_listPageModel.listPage.listState != ListState.HINT_LOADING) {
          stateModel.communityActivityHandleLoadMore(_listPageModel, widget.findType, widget.activityType);
        }
      }
    });
    stateModel.loadCommunityActivityList(_listPageModel, widget.activityType, findType: widget.findType);
  }

  Future<void> _handleRefresh() async {
    stateModel.loadCommunityActivityList(_listPageModel, widget.activityType, findType: widget.findType);
  }

  String _getImageDefault() {
    //1=问卷调查 2=投票 3=活动报名
    switch (widget.activityType) {
      case 1:
        return UIData.imageQuestionnaireDefault;
        break;
      case 2:
        return UIData.imageVoteDefault;
        break;
      case 3:
        return UIData.imageCommunityDefault;
        break;
      default:
        return UIData.imageCommunityDefault;
        break;
    }
  }

  ///
  /// item卡片
  ///
  Widget _buildCard(ActivityInfo info) {
    LogUtils.printLog('图片路径：：${HttpOptions.urlAppDownloadImage}${_getImageDefault()}');
    return CommonShadowContainer(
        padding: EdgeInsets.only(bottom: UIData.spaceSize16),
        margin: EdgeInsets.only(left: UIData.spaceSize16, right: UIData.spaceSize16, bottom: UIData.spaceSize16),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(6.0), topRight: Radius.circular(6.0)),
                child: CommonImageWidget(info?.logo,
                    loadedNoDataImage: '${HttpOptions.urlAppDownloadImage}${_getImageDefault()}'),
//                  child: CachedNetworkImage(
//                    height: ScreenUtil.getInstance().setHeight(125),
//                    placeholder: (context, url) => Image.asset(UIData.imageBannerDefaultLoading),
//                    errorWidget: (context, url, error) => Image.asset(UIData.imageBannerDefaultFailed),
//                    imageUrl: (StringsHelper.isNotEmpty(info?.logo))
//                        ? HttpOptions.showPhotoUrl(info?.logo)
//                        : '${HttpOptions.urlAppDownloadImage}${_getImageDefault()}',
//                    fit: BoxFit.cover,
////                    alignment: Alignment.topCenter,
//                  )
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(height: UIData.spaceSize4),
                    CommonText.darkGrey16Text(info?.name ?? ''),
//                  SizedBox(height: UIData.spaceSize2),
//                  CommonText.text13('活动开始时间：${info?.beginTime ?? ''}',
//                      color: UIData.greyColor),
//                  SizedBox(height: UIData.spaceSize2),
//                  CommonText.text13('活动结束时间：${info?.endTime ?? ''}',
//                      color: UIData.greyColor),
                    SizedBox(height: UIData.spaceSize2),
                    Row(
                      children: <Widget>[
                        CommonText.text13('参与人数：', color: UIData.greyColor),
                        CommonText.text13((info?.commitCount ?? 0).toString(), color: UIData.themeBgColor),
                        CommonText.text13('人', color: UIData.greyColor),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        onTap: () {
          stateModel.communityActivityGetH5(info?.id, callBack: (String url) {
            Navigate.toNewPage(HtmlPage(url, info?.name,
                toShare: true,
                thumbImageUrl: (StringsHelper.isNotEmpty(info?.logo))
                    ? HttpOptions.showPhotoUrl(info?.logo)
                    : '${HttpOptions.urlAppDownloadImage}${_getImageDefault()}'));
          });
        });
  }

  Widget _buildList() {
    return RefreshIndicator(
        child: ListView.builder(
            padding: EdgeInsets.only(top: UIData.spaceSize16),
            controller: _loadMoreScrollController,
            itemCount: (_listPageModel?.list?.length ?? 0) + 1,
            itemBuilder: (context, index) {
              if (_listPageModel?.list?.length == index) {
                return CommonLoadMore(_listPageModel.listPage.maxCount);
              } else {
                ActivityInfo info = _listPageModel?.list[index];
                return _buildCard(info);
              }
            }),
        onRefresh: _handleRefresh);
  }

  Widget _buildBody() {
    return ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
      return CommonLoadContainer(
          state: _listPageModel.listPage.listState,
          content: _buildList(),
          callback: () {
            stateModel.loadCommunityActivityList(_listPageModel, widget.activityType,
                findType: widget.findType, preRefresh: true);
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appTitle: communityActivityType[widget.activityType], //1=问卷调查 2=投票 3=活动报名
      appBarActions: widget.findType == 0
          ? [
              FlatButton(
                  onPressed: () {
                    Navigate.toNewPage(CommunityActivityPage(findType: 1, activityType: widget.activityType));
                  },
                  child: CommonText.red15Text('我参与的'))
            ]
          : null,
      bodyData: _buildBody(),
    );
  }
}

const Map<int, String> communityActivityType = {
  1: '问卷调查',
  2: '投票',
  3: '社区活动',
};
