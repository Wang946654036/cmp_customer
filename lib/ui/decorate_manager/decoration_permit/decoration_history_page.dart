import 'package:cmp_customer/models/property_change_user_param.dart';

///验收详情切换
///
///

import 'package:cmp_customer/scoped_models/decoration_model.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/decorate_manager/decoration_permit/decoration_history_list_screen.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../decoration_ui.dart';
import 'decoration_apply_detail.dart';
import 'decoration_check_detail.dart';
import 'decoration_history_list.dart';
import 'decoration_history_list_zk.dart';

//
class DecorationHistoryPage extends StatefulWidget {
  DecorationHistoryPage();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DecorationApplyListTab();
  }
}

class DecorationApplyListTab extends State<DecorationHistoryPage> {
  DecorationModel _model = DecorationModel();
  PropertyChangeUserParam param;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CommonScaffold(
        appTitle: "我的申请",
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
        endDrawerWidget: DecorationHistoryScreenPage(
          DecorationModel(),
          callback: (PropertyChangeUserParam data) {
            param = new PropertyChangeUserParam(
                startTime: data.startTime,
                status: data.status,
                endTime: data.endTime);
            _model.historyHandleRefresh(param, preRefresh: true);
          },
        ),
        bodyData: DecorationHistoryListPage(_model, (PropertyChangeUserParam data) {
          if (param != null) {
            data.startTime = param.startTime;
            data.status = param.status;
            data.endTime = param.endTime;
          }
          LogUtils.printLog('===========>${data.status}');
        }));
  }
}
