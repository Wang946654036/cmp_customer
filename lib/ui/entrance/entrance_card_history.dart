import 'package:cmp_customer/models/response/entrance_card_details_response.dart';
import 'package:cmp_customer/models/transport_driver_model.dart';
import 'package:cmp_customer/scoped_models/entrance_model/entrance_list_state_model.dart';
import 'package:cmp_customer/scoped_models/entrance_model/entrance_list_state_model.dart';
import 'package:cmp_customer/scoped_models/entrance_state_model.dart';
import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/scoped_models/parking_model/parking_history_state_model.dart';
import 'package:cmp_customer/ui/common/common_list_loading.dart';
import 'package:cmp_customer/ui/common/common_list_refresh.dart';
import 'package:cmp_customer/ui/common/common_loadmore.dart';
import 'package:cmp_customer/ui/common/common_shadow_container.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_details.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_state.dart';
import 'package:cmp_customer/ui/parking/parking_card_details.dart';
import 'package:cmp_customer/utils/common_event_bus.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:cmp_customer/ui/parking/parking_card_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scoped_model/scoped_model.dart';

///
/// 门禁卡申请通知列表(业主或租户申请的记录)
class EntranceCardHistoryPage extends StatefulWidget {
  @override
  _EntranceCardHistoryPageState createState() =>
      _EntranceCardHistoryPageState();
}

EntranceListStateModel _stateModel;
//获取数据方法
getListData() {
  if (_stateModel != null) {
    //获取列表数据
    _stateModel.loadList(preRefresh: true);
  }
}

class _EntranceCardHistoryPageState extends State<EntranceCardHistoryPage> {
//  EntranceListStateModel _stateModel;
  ScrollController _loadMoreScrollController;

  @override
  void initState() {
    super.initState();
    if (_stateModel == null) {
      _stateModel = new EntranceListStateModel();
      _stateModel.initData("ZJ");
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

    getListData();
    //添加刷新监听事件
    entrance_card_bus.on(entrance_refresh, _eventCallBack);
  }

  EventCallBack _eventCallBack = (refresh) {
    getListData();
  };

  @override
  void dispose() {
    super.dispose();
    //移除列表刷新
    entrance_card_bus.off(entrance_refresh, _eventCallBack);
  }

  _refresh() {
    _stateModel.historyHandleRefresh(preRefresh: true);
  }

  Widget _buildContent() {
    return ScopedModelDescendant<EntranceListStateModel>(
      builder: (context, child, model) {
        switch (model.listState) {
          case ListState.HINT_LOADING:
            return CommonListLoading();
            break;
          case ListState.HINT_NO_DATA_CLICK:
            return CommonListRefresh(
                state: ListState.HINT_NO_DATA_CLICK, callBack: _refresh);
            break;
          case ListState.HINT_LOADED_FAILED_CLICK:
            return CommonListRefresh(
                state: ListState.HINT_LOADED_FAILED_CLICK, callBack: _refresh);
            break;
          case ListState.HINT_DISMISS:
            return _buildList();
            break;
        }
      },
    );
  }

  Widget _buildList() {
    return ScopedModelDescendant<EntranceListStateModel>(
        builder: (context, child, model) {
      return RefreshIndicator(
          child: ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            controller: _loadMoreScrollController,
            itemCount: (model?.entranceList?.length ?? 0) + 1,
            itemBuilder: (BuildContext context, int index) {
              if (model.entranceList.length == index) {
                return CommonLoadMore(model.maxCount);
              } else {
                EntranceCardDetailsInfo info = model.entranceList[index];
                return GestureDetector(
                    onTap: () {
                      Navigate.toNewPage(
                          EntranceCardDetailsPage(info.accessCardId));
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
                                    child: Text.rich(TextSpan(children: [
                                      TextSpan(
                                        text: "申请 ",
                                        style: TextStyle(
                                            color: color_text,
                                            fontSize: normal_text_size),
                                      ),
                                      TextSpan(
                                        text: StringsHelper.getStringValue(
                                            info.applyCount),
                                        style:
                                            TextStyle(color: color_text_orange),
                                      ),
                                      TextSpan(
                                        text: " 张门禁卡",
                                        style: TextStyle(
                                            color: color_text,
                                            fontSize: normal_text_size),
                                      ),
                                    ]))),
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
                            child: CommonText.text12(info.statusDesc??"",color: (info.status == completed ||
                                info.status == cancelled ||
                                info.status == closed)
                                ? color_text_gray
                                : color_text_orange),
//                            Text(
//                              getStateText(info.status),
//                              style: TextStyle(
//                                  fontSize: UIData.fontSize12,
//                                  color: (info.status == completed ||
//                                          info.status == cancelled ||
//                                          info.status == closed)
//                                      ? color_text_gray
//                                      : color_text_orange),
//                            ),
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
    return ScopedModel<EntranceListStateModel>(
      model: _stateModel,
      child: _buildContent(),
    );
  }
}
