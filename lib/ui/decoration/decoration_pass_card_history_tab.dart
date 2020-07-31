import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/hot_work/hot_work_list_content.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'decoration_pass_card_history.dart';

///
/// 记录列表
///
class DecorationPassCardHistoryTabPage extends StatefulWidget {
  final bool isOwner;

  DecorationPassCardHistoryTabPage(this.isOwner);

  @override
  _DecorationPassCardHistory createState() => _DecorationPassCardHistory();
}

class _DecorationPassCardHistory extends State<DecorationPassCardHistoryTabPage> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Widget _buildBody() {
//    return ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
      return widget.isOwner
          ? TabBarView(children: [DecorationPassCardHistoryPage(0), DecorationPassCardHistoryPage(1)], controller: _tabController)
          : DecorationPassCardHistoryPage(1);
//    });
  }

  Widget _buildTabBar() {
//    return ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
      return Container(
        color: UIData.primaryColor,
        child: TabBar(
            controller: _tabController,
            indicator: UnderlineTabIndicator(
                borderSide: BorderSide(width: 3.0, color: UIData.redGradient2),
                insets: EdgeInsets.symmetric(horizontal: UIData.spaceSize50)),
            labelStyle: CommonText.darkGrey15TextStyle(),
            tabs: [Tab(text: '租户申请'), Tab(text: '我的申请')]),
      );
//    });
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appTitle: '出入证申请列表',
      tabBar: widget.isOwner ? _buildTabBar() : null,
      bodyData: _buildBody(),
    );
  }
}
