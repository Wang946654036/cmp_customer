import 'package:cmp_customer/models/response/parking_card_details_response.dart';
import 'package:cmp_customer/scoped_models/entrance_state_model.dart';
import 'package:cmp_customer/scoped_models/parking_model/parking_history_state_model.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_list_loading.dart';
import 'package:cmp_customer/ui/common/common_list_refresh.dart';
import 'package:cmp_customer/ui/common/common_loadmore.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_shadow_container.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/parking/parking_card_details.dart';
import 'package:cmp_customer/ui/parking/parking_card_screen.dart';
import 'package:cmp_customer/ui/parking/parking_card_state.dart';
import 'package:cmp_customer/utils/common_event_bus.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'parking_card_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//停车卡办理记录页面
class ParkingCardHistoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ParkingCardHistory();
}


ParkingHistoryStateModel _stateModel;

//刷新操作
_refresh() {
  if(_stateModel!=null)
    _stateModel.historyHandleRefresh(preRefresh: true);
}

class ParkingCardHistory extends State<ParkingCardHistoryPage>{
  ScrollController _loadMoreScrollController = new ScrollController();
//  bool initLoading;//初始化加载标志
  List<ParkingCardHistory> historyList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    initLoading=true

    _stateModel = new ParkingHistoryStateModel();
    _loadMoreScrollController.addListener(() {
      if (_loadMoreScrollController.position.pixels ==
          _loadMoreScrollController.position.maxScrollExtent) {
        if (_stateModel.historyListState != ListState.HINT_LOADING) {
          _stateModel.quoteRecordHandleLoadMore();
        }
      }
    });
    //初始化筛选数据
    _stateModel.initScreenData();
    if (_stateModel != null) {
      //获取车辆数据
      _stateModel.loadCustCars();
      //获取列表数据
      _stateModel.loadHistoryList();
    }
    //添加刷新监听事件
    parking_card_bus.on(parking_refresh, _eventCallBack);
  }

  EventCallBack _eventCallBack = (refresh) {
    _refresh();
  };

//  @override
//  void didChangeAppLifecycleState(AppLifecycleState state) {
//    // TODO: implement didChangeAppLifecycleState
//    if(state == AppLifecycleState.resumed && _stateModel.payRefresh){
//      //打开了支付页面，需要刷新列表
//      _refresh();
//      _stateModel.setPayRefresh(false);
//    }
//  }



  @override
  void dispose() {
    super.dispose();
    parking_card_bus.off(parking_refresh, _eventCallBack); //移除监听
    if (_loadMoreScrollController != null) _loadMoreScrollController.dispose();
  }

  //创建控件
  Widget _buildContent() {
    return ScopedModelDescendant<ParkingHistoryStateModel>(
      builder: (context, child, model) {
//        if(initLoading){//初始化加载，只加载一次
//          model.loadCustCars();
//          model.loadHistoryList();
//          initLoading=false;
//        }
        switch (model.historyListState) {
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
    return ScopedModelDescendant<ParkingHistoryStateModel>(
        builder: (context, child, model) {
      return RefreshIndicator(
          child: ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              controller: _loadMoreScrollController,
              itemCount: (model?.parkingCardHistoryList?.length ?? 0) + 1,
              itemBuilder: (BuildContext context, int index) {
                if (model.parkingCardHistoryList.length == index) {
                  return CommonLoadMore(model.maxCount);
                } else {
                  ParkingCardDetailsInfo info =
                      model.parkingCardHistoryList[index];
                  return GestureDetector(
                      onTap: () {
                        Navigate.toNewPage(ParkingCardDetailsPage(info.parkingId));
                      },
                      child: CommonShadowContainer(
                        margin: EdgeInsets.only(
                            top: card_spacing,
                            left: left_spacing,
                            right: right_spacing),
                        backgroundColor: Colors.white,
                        child: new Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: leftTextWidget(
                                    text: info.businessNo,
                                    topSpacing: vertical_spacing,
                                    isBold: true,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  margin: EdgeInsets.only(
                                      right: right_spacing,
                                      top: vertical_spacing),
                                  child: CommonText.text12(info.statusDesc??"",color: color_text_orange)
//                                  Text(getStateText(info.status),
//                                      style: TextStyle(
//                                          fontSize: UIData.fontSize12,
//                                          color: color_text_orange)),
                                ),
                              ],
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(left: left_spacing),
                              child: Text(info.registerTime,
                                  style: TextStyle(
                                      fontSize: little_text_size,
                                      color: color_text_gray)),
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      leftTextWidget(
                                        text: label_apply_car_no +
                                            "：" +
                                            info.carNo,
                                        topSpacing: ScreenUtil.getInstance()
                                            .setHeight(8),
                                      ),
                                      leftTextWidget(
                                        text: label_apply_deal_type +
                                            "：" +
                                            getOperationStateText(info.type),
                                        bottomSpacing: vertical_spacing,
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: info.status == payWaiting,
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    margin:
                                        EdgeInsets.only(right: right_spacing),
                                    child: RadiusSolidText(
                                      text: "支付",
                                      horizontalPadding: horizontal_spacing,
                                      verticalPadding: input_padding,
                                      onTap: () {
                                        _stateModel.getPayInfo(info.parkingId);
                                        return true;
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ));
                }
              }),
          onRefresh: model.historyHandleRefresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModel<ParkingHistoryStateModel>(
        model: _stateModel,
        child: CommonScaffold(
          appTitle: "办理记录",
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
          endDrawerWidget: ParkingCardScreenPage(),
          bodyData: _buildContent(),
        ));
  }

  _requestCallback(data) {
//    historyList=
  }
}
