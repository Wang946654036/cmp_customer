///列表
///
///业务办理列表
///
///
import 'package:cmp_customer/models/meetingroom/reserve_info.dart';
import 'package:cmp_customer/models/property_change_user_param.dart';
import 'package:cmp_customer/models/response/entrance_card_details_response.dart';
import 'package:cmp_customer/scoped_models/reservation_state_model.dart';
import 'package:cmp_customer/ui/common/common_list_loading.dart';
import 'package:cmp_customer/ui/common/common_list_refresh.dart';
import 'package:cmp_customer/ui/common/common_loadmore.dart';
import 'package:cmp_customer/ui/common/common_shadow_container.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/conference_room_reservation/reservation_detail.dart';
import 'package:cmp_customer/ui/decorate_manager/decoration_ui.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


//会议室预定
class ReservationListPage extends StatefulWidget {
  ReservationModel _model;
  Function callback;
  List<ReserveInfo> reserveInfoList;

  ReservationListPage(
      this._model,  this.reserveInfoList, this.callback);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ReservationListState(reserveInfoList);
  }
}

class ReservationListState extends State<ReservationListPage> {
  ScrollController _loadMoreScrollController = new ScrollController();

//  bool initLoading;//初始化加载标志
  List<EntranceCardDetailsInfo> historyList;
  PropertyChangeUserParam param = new PropertyChangeUserParam();
  List<ReserveInfo> reserveInfoList = new List();

  ReservationListState(this.reserveInfoList);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    initLoading=true;
    _loadMoreScrollController.addListener(() {
      if (_loadMoreScrollController.position.pixels ==
          _loadMoreScrollController.position.maxScrollExtent) {
        if (widget._model.reservationInfoListState != ListState.HINT_LOADING) {
          if (widget.callback != null) {
            widget.callback(param);
          }
          widget._model.quoteRecordHandleLoadMore(param,reserveInfoList);
        }
      }
    });
    //初始化请求数据

//    //获取列表数据
    if (widget.callback != null) {
      widget.callback(param);
    }
    widget._model.loadHistoryList(param,reserveInfoList);
  }

  @override
  void dispose() {
    super.dispose();
    if (_loadMoreScrollController != null) _loadMoreScrollController.dispose();
  }

  //刷新操作
  _refresh() {
    if (widget.callback != null) {
      widget.callback(param);
    }
    widget._model
        .historyHandleRefresh(param,reserveInfoList, preRefresh: true);
  }

  Future refresh() async {
    if (widget.callback != null) {
      widget.callback(param);
    }
    widget._model
        .historyHandleRefresh(param,reserveInfoList, preRefresh: true);
  }

  //创建控件
  Widget _buildContent() {
    return ScopedModelDescendant<ReservationModel>(
      builder: (context, child, model) {
        switch (widget._model.reservationInfoListState) {
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
          default:
            return CommonListLoading();
            break;
        }
      },
    );
  }

  Widget _buildList() {
    return ScopedModelDescendant<ReservationModel>(
        builder: (context, child, model) {
          return RefreshIndicator(
              child: ListView.builder(
//            shrinkWrap: true,
                  controller: _loadMoreScrollController,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: (reserveInfoList?.length ?? 0) + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (reserveInfoList.length == index) {
                      return CommonLoadMore(model.maxCount);
                    } else {
                      ReserveInfo info = reserveInfoList[index];
                      return GestureDetector(
                          onTap: () {
                            if(StringsHelper.isEmpty(info?.orderId?.toString()??'')){
                              CommonToast.show(type: ToastIconType.INFO,msg: '订单无效');
                            }
                            Navigate.toNewPage(
                                ReservationDetailPage(
                                    widget._model, info.orderId),
                                callBack: (flag) {
                                  if (flag != null && flag is bool && flag) {
                                    refresh();
                                  }
                                });
                          },
                          child: CommonShadowContainer(
                            margin: EdgeInsets.only(
                                top: UIData.spaceSize12,
                                left: UIData.spaceSize16,
                                right: UIData.spaceSize16),
                            backgroundColor: Colors.white,
                            child: new Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: UIData.spaceSize12),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child:
                                        leftTextWidget(
                                          fontSize: UIData.fontSize11,
                                          color: UIData.lightGreyColor,
                                          text: "申请日期：${info?.createTime ?? ""}",
                                          topSpacing: ScreenUtil.getInstance().setHeight(4),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          right: UIData.spaceSize16,
                                        ),
                                        child: CommonText.lighterYellow12Text(
                                            (info?.stateName??getStateStr(info?.state)),
                                            textAlign: TextAlign.right),
                                      )
                                    ],
                                  ),
                                ),
//                                leftTextWidget(
//                                    text: info?.createTime ??
//                                        "",
//                                    color: UIData.lightGreyColor,
//                                    fontSize: UIData.fontSize14
//                                ),
                                leftTextWidget(
                                  text:
                                  ("会议室：${(info.meetingRoomName ?? "")}"),
                                  topSpacing: ScreenUtil.getInstance().setHeight(4),
                                ),
//                                leftTextWidget(
//                                  text: ("地点：${info.meetingSubOrderVoList[0]?.address ?? ""}"),
//                                  topSpacing: ScreenUtil.getInstance().setHeight(4),
//                                ),
                                leftTextWidget(
                                  fontSize: UIData.fontSize11,
                                  color: UIData.lightGreyColor,
                                  text:
                                  "预定日期：${(info.orderDates ?? "")}",
                                  topSpacing: ScreenUtil.getInstance().setHeight(4),
                                ),
                                leftTextWidget(
                                  fontSize: UIData.fontSize11,
                                  color: UIData.lightGreyColor,
                                  text:
                                  "合共预定${(info.meetingRoomName ?? "").split(',')?.length??'0'}个会议室...",
                                  topSpacing: ScreenUtil.getInstance().setHeight(4),
                                  bottomSpacing: UIData.spaceSize12,
                                ),

                              ],
                            ),
                          ));
                    }
                  }),
              onRefresh: refresh);
        });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModel<ReservationModel>(
        model: widget._model, child: _buildContent());
  }
}


