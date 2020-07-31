import 'package:cmp_customer/models/property_change_user_param.dart';

///验收详情切换
///
///

import 'package:cmp_customer/scoped_models/decoration_model.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/decorate_manager/decoration_permit/decoration_history_list_screen.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../decoration_ui.dart';
import 'decoration_apply_detail.dart';
import 'decoration_check_detail.dart';
import 'decoration_history_list.dart';
import 'decoration_history_list_zk.dart';

//产权变更办理列表tab页
class DecorationApplyTabPage extends StatefulWidget {
//  int infoId;
  DecorationApplyTabPage();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DecorationApplyListTab();
  }
}

class DecorationApplyListTab extends State<DecorationApplyTabPage> {
  DecorationModel _model = DecorationModel();
  DecorationModel _model1 = DecorationModel();
  DecorationModel _model2 = DecorationModel();
  PropertyChangeUserParam param;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (_model == null) _model = new DecorationModel();
    if (_model1 == null) _model1 = new DecorationModel();
    if (_model2 == null) _model2 = new DecorationModel();
    return DefaultTabController(
        length: 2,
        child: ScopedModel<DecorationModel>(
          model: _model,
          child: new CommonScaffold(
            endDrawerWidget: DecorationHistoryScreenPage(
              _model2,
              callback: (PropertyChangeUserParam data) {
                param = new PropertyChangeUserParam(
                    startTime: data.startTime,
                    status: data.status,
                    endTime: data.endTime);
                _model1.historyHandleRefresh(param, preRefresh: true);
                _model.historyHandleRefreshZK(param, preRefresh: true);
              },
            ),
            appTitle: "装修许可证办理列表",
            tabBar: TabBar(tabs: <Widget>[
              new Tab(
                text: "租户申请",
              ),
              new Tab(
                text: "我的申请",
              )
            ], indicatorSize: TabBarIndicatorSize.label),
            bodyData: new TabBarView(
              children: <Widget>[
                new DecorationHistoryListZKPage(_model,
                    (PropertyChangeUserParam data) {
                  if(data==null){
                    data = PropertyChangeUserParam();
                  }
                  if (param != null) {
                    data.startTime = param.startTime;
                    data.status = param.status;
                    data.endTime = param.endTime;
                  }
                }),
                new DecorationHistoryListPage(_model1,
                    (PropertyChangeUserParam data) {
                      if(data==null){
                        data = PropertyChangeUserParam();
                      }
                      if (param != null) {
                        data.startTime = param.startTime;
                        data.status = param.status;
                        data.endTime = param.endTime;
                      }
                }),
              ],
            ),
          ),
        ));
  }
}
