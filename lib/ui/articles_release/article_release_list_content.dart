import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/articles_release_record_model.dart';
import 'package:cmp_customer/models/common/common_page_model.dart';
import 'package:cmp_customer/models/hot_work_record_model.dart';
import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/strings/strings_articles_release.dart';
import 'package:cmp_customer/strings/strings_hot_work.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_loadmore.dart';
import 'package:cmp_customer/ui/common/common_shadow_container.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/hot_work/hot_work_detail_page.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'articles_release_detail_page.dart';
import 'articles_release_record_page.dart';

///
/// 物品放行记录列表内容
/// [customerType] 查询类型，业主查询租户申请：0，查询自己的申请：1
///
class ArticleReleaseListContent extends StatefulWidget {
  final int customerType;
  final ArticlesReleaseFilterModel filterModel;

  ArticleReleaseListContent(this.customerType, this.filterModel, {Key key}) : super(key: key);

  @override
  ArticleReleaseListContentState createState() => ArticleReleaseListContentState();
}

class ArticleReleaseListContentState extends State<ArticleReleaseListContent> with AutomaticKeepAliveClientMixin {
  ListPageModel _listPageModel = ListPageModel();
  ScrollController _loadMoreScrollController = new ScrollController();
  ArticlesReleaseFilterModel _filterModel;

  @override
  void initState() {
    super.initState();
    _filterModel = widget.filterModel;
    _loadMoreScrollController.addListener(() {
      if (_loadMoreScrollController.position.pixels == _loadMoreScrollController.position.maxScrollExtent) {
        if (_listPageModel.listPage.listState != ListState.HINT_LOADING) {
          stateModel.articlesReleaseRecordHandleLoadMore(_listPageModel, widget.customerType, _filterModel);
        }
      }
    });
    handleRefresh();
//    stateModel.loadArticlesReleaseRecordList(_listPageModel);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  Future<void> handleRefresh({bool preRefresh = false}) async {
    stateModel.loadArticlesReleaseRecordList(_listPageModel, widget.customerType, _filterModel,
        preRefresh: preRefresh);
  }

  ///
  /// item卡片
  ///
  Widget _buildCard(ArticlesReleaseInfo info) {
    return CommonShadowContainer(
      padding: EdgeInsets.all(UIData.spaceSize16),
      margin: EdgeInsets.only(left: UIData.spaceSize16, right: UIData.spaceSize16, bottom: UIData.spaceSize16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            //第一行，左边楼栋和房号， 右边是申请状态
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                  child: CommonText.darkGrey16Text(articleReleaseReasonMap.keys.firstWhere(
                      (String key) => articleReleaseReasonMap[key] == info?.reason,
                      orElse: () => ''))), //楼栋和房号
              //状态，按照状态情况显示不同颜色
              CommonText.text12(info?.statusDesc ?? '',
                  color: articlesReleaseStatusToColorMap[info?.status] ?? UIData.yellowColor)
//              CommonText.lighterYellow12Text('待审核'),//测试数据
            ],
          ),
          SizedBox(height: UIData.spaceSize8),
          //第二行，申请时间
          CommonText.lightGrey12Text(info?.createTime ?? ''),
        ],
      ),
      onTap: () {
        Navigate.toNewPage(ArticlesReleaseDetailPage(info?.releasePassId, customerType: widget.customerType),
            callBack: (bool value) {
          if (value != null && value is bool && value) handleRefresh(preRefresh: true);
        });
      },
    );
  }

  Widget _buildList() {
    return RefreshIndicator(
        child: ListView.builder(
            shrinkWrap: true,
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: UIData.spaceSize16),
            controller: _loadMoreScrollController,
            itemCount: (_listPageModel?.list?.length ?? 0) + 1,
//            itemCount: 5, //测试数据
            itemBuilder: (context, index) {
              if (_listPageModel?.list?.length == index) {
                return CommonLoadMore(_listPageModel.listPage.maxCount);
              } else {
                ArticlesReleaseInfo info = _listPageModel?.list[index];
                return _buildCard(info);
              }
            }),
        onRefresh: handleRefresh);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
//      return EasyRefresh.custom(
//        header: PhoenixHeader(),
//        footer: PhoenixFooter(),
//        slivers: <Widget>[
//          SliverList(
//              delegate: SliverChildBuilderDelegate(
//                    (context, index) {
//                      if (_listPageModel?.list?.length == index) {
//                        return CommonLoadMore(_listPageModel.listPage.maxCount);
//                      } else {
//                        ArticlesReleaseInfo info = _listPageModel?.list[index];
//                        return _buildCard(info);
//                      }
//                },
//                childCount: (_listPageModel?.list?.length ?? 0) + 1,
//              ))
//        ],
//        onRefresh: handleRefresh,
//        onLoad: () async {
//          stateModel.articlesReleaseRecordHandleLoadMore(_listPageModel, _filterModel);
//        },
//      );
      return CommonLoadContainer(
        state: _listPageModel.listPage.listState,
//        state: ListState.HINT_DISMISS, //测试数据
        content: _buildList(),
        callback: () => handleRefresh(preRefresh: true),
      );
    });
  }
}
