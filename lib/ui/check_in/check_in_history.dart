import 'package:cmp_customer/models/response/check_in_history_response.dart';
import 'package:cmp_customer/scoped_models/check_in_model/check_in_history_state_model.dart';
import 'package:cmp_customer/ui/check_in/check_in_details.dart';
import 'package:cmp_customer/ui/check_in/check_in_screen.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_loadmore.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_shadow_container.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/parking/parking_card_ui.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scoped_model/scoped_model.dart';

import 'check_in_label.dart';
import 'check_in_status.dart';

//租户申请记录
class CheckInHistoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CheckInHistory();
  }
}

class _CheckInHistory extends State<CheckInHistoryPage> {
  CheckInHistoryStateModel _stateModel;
  ScrollController _loadMoreScrollController;

  @override
  void initState() {
    super.initState();
    if (_stateModel == null) {
      _stateModel = new CheckInHistoryStateModel();
      _stateModel.initScreenData();
    }
    if (_loadMoreScrollController == null) {
      _loadMoreScrollController = new ScrollController();
      _loadMoreScrollController.addListener(() {
        if (_loadMoreScrollController.position.pixels ==
            _loadMoreScrollController.position.maxScrollExtent) {
          if (_stateModel.listState != ListState.HINT_LOADING) {
            _stateModel.quoteRecordHandleLoadMore();
          }
        }
      });
    }
    _stateModel.loadHistoryList();
  }

  @override
  void dispose() {
    super.dispose();
    if (_loadMoreScrollController != null) _loadMoreScrollController.dispose();
  }

  Widget _buildContent() {
    return ScopedModelDescendant<CheckInHistoryStateModel>(
      builder: (context, child, model) {
        return CommonLoadContainer(
          state: model.listState,
          callback: (){
            _stateModel.historyHandleRefresh(preRefresh: true);
          },
          content: _buildList(),
        );
      },
    );
  }

  Widget _buildList() {
    return ScopedModelDescendant<CheckInHistoryStateModel>(
        builder: (context, child, model) {
      return RefreshIndicator(
          child: ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            controller: _loadMoreScrollController,
            itemCount: (model?.historyList?.length ?? 0) + 1,
            itemBuilder: (BuildContext context, int index) {
              if (model.historyList.length == index) {
                return CommonLoadMore(model.maxCount);
              } else {
                CheckInHistory info = model.historyList[index];
                return GestureDetector(
                    onTap: () {
                      Navigate.toNewPage(
                          CheckInDetailsPage(info.rentingEnterId),callBack: (data){
                            //操作回调函数，刷新列表
                            model.loadHistoryList(preRefresh: true);
                          },);
                    },
                    child: CommonShadowContainer(
                      margin: EdgeInsets.only(
                          top: card_spacing,
                          left: left_spacing,
                          right: right_spacing),
                      backgroundColor: Colors.white,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.only(
                                      left: left_spacing,
                                      top: top_spacing,
                                    ),
                                    child: CommonText.darkGrey15Text(info.rentersName??"")),
                                Container(
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.only(
                                      left: left_spacing,
                                    ),
                                    child: CommonText.darkGrey15Text(entryTypeMap[info.enterType]??"")),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(
                                      left: left_spacing,
                                      top:
                                          ScreenUtil.getInstance().setHeight(5),
                                      bottom: bottom_spacing),
                                  child: CommonText.lightGrey12Text(
                                      info.createTime ?? ""),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                right: right_spacing, top: top_spacing),
                            child: Text(
                              getStateText(info.status),
                              style: TextStyle(
                                  fontSize: UIData.fontSize12,
                                  color: (info.status == completed ||
                                          info.status == cancelled ||
                                          info.status == auditFailed)
                                      ? color_text_gray
                                      : color_text_orange),
                            ),
                          ),
                        ],
                      ),
                    ));
              }
            },
          ),
          onRefresh: model.historyHandleRefresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<CheckInHistoryStateModel>(
      model: _stateModel,
      child: CommonScaffold(
        appTitle: "申请记录",
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
        endDrawerWidget: CheckInScreenPage(),
        bodyData: _buildContent(),
      ));
  }
}
