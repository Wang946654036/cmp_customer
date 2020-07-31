import 'package:cmp_customer/models/common/common_page_model.dart';
import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'article_release_list_content.dart';
import 'articles_release_record_filter.dart';

///
/// 物品放行申请记录列表
///
class ArticlesReleaseRecordPage extends StatefulWidget {
  final bool isOwner;

  ArticlesReleaseRecordPage(this.isOwner);

  @override
  _ArticlesReleaseRecordPageState createState() => _ArticlesReleaseRecordPageState();
}

class _ArticlesReleaseRecordPageState extends State<ArticlesReleaseRecordPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ArticlesReleaseFilterModel _filterModel = ArticlesReleaseFilterModel();
  GlobalKey<ArticleReleaseListContentState> _MyGlobalKey = GlobalKey<ArticleReleaseListContentState>();
  GlobalKey<ArticleReleaseListContentState> _ZHGlobalKey = GlobalKey<ArticleReleaseListContentState>();

//  List<String> _reasonList = List(); //申请理由列表
//  List<String> _statusList = List(); //状态列表
//  String _startTime; //开始时间
//  String _endTime; //结束时间

  @override
  void initState() {
    super.initState();
    if (widget.isOwner) _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildBody() {
    return ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
      return widget.isOwner
          ? TabBarView(children: [
              ArticleReleaseListContent(0, _filterModel, key: _ZHGlobalKey),
              ArticleReleaseListContent(1, _filterModel, key: _MyGlobalKey)
            ], controller: _tabController)
          : ArticleReleaseListContent(1, _filterModel, key: _MyGlobalKey);
    });
  }

  Widget _buildTabBar() {
    return ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
      return Container(
        color: UIData.primaryColor,
        child: TabBar(
            controller: _tabController,
            indicator: UnderlineTabIndicator(
                borderSide: BorderSide(width: 3.0, color: UIData.redGradient2),
                insets: EdgeInsets.symmetric(horizontal: UIData.spaceSize50)),
//          indicatorSize: TabBarIndicatorSize.label,
//            indicatorColor: UIData.themeBgColor,
//          indicatorWeight: 3.0,
            labelStyle: CommonText.darkGrey15TextStyle(),
            tabs: [Tab(text: '租户申请'), Tab(text: '我的申请')]),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appTitle: '物品放行记录',
      tabBar: widget.isOwner ? _buildTabBar() : null,
      bodyData: _buildBody(),
      appBarActions: <Widget>[
        Builder(builder: (context) {
          return IconButton(
            icon: UIData.iconFilter,
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
          );
        })
      ],
      endDrawerWidget: ArticlesReleaseRecordFilter(_filterModel, callback: () {
        if(_tabController == null){
          _MyGlobalKey.currentState.handleRefresh(preRefresh: true);
        }else
        if (_tabController.index == 0) {
          _ZHGlobalKey.currentState.handleRefresh(preRefresh: true);
        } else {
          _MyGlobalKey.currentState.handleRefresh(preRefresh: true);
        }
      }),
    );
  }
}

class ArticlesReleaseFilterModel {
  List<String> reasonList = List(); //申请理由列表
  List<String> statusList = List(); //状态列表
  String startTime; //开始时间
  String endTime; //结束时间
}
