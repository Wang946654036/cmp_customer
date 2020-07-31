import 'package:cmp_customer/models/response/entrance_card_details_response.dart';
import 'package:cmp_customer/models/transport_driver_model.dart';
import 'package:cmp_customer/scoped_models/entrance_model/entrance_list_state_model.dart';
import 'package:cmp_customer/scoped_models/entrance_model/entrance_list_state_model.dart';
import 'package:cmp_customer/scoped_models/entrance_state_model.dart';
import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/ui/common/common_dialog.dart';
import 'package:cmp_customer/ui/common/common_list_loading.dart';
import 'package:cmp_customer/ui/common/common_list_refresh.dart';
import 'package:cmp_customer/ui/common/common_loadmore.dart';
import 'package:cmp_customer/ui/common/common_shadow_container.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_apply_audit.dart';
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

/// 门禁卡申请列表（业主端查看租户申请的列表）
class EntranceCardListPage extends StatefulWidget {
  @override
  _EntranceCardListPageState createState() => _EntranceCardListPageState();
}

EntranceListStateModel _stateModel;

//获取数据方法
getListData() {
  if (_stateModel != null) {
    //获取列表数据
    _stateModel.loadList(preRefresh: true);
  }
}

class _EntranceCardListPageState extends State<EntranceCardListPage> {
  ScrollController _loadMoreScrollController;

  @override
  void initState() {
    super.initState();
    if (_stateModel == null) {
      _stateModel = new EntranceListStateModel();
      _stateModel.initData("ZH");
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
    //添加刷新监听事件
    entrance_card_bus.on(entrance_audit_refresh, _eventCallBack);
    _stateModel.loadList();
  }

  EventCallBack _eventCallBack = (refresh) {
    getListData();
  };

  @override
  void dispose() {
    super.dispose();
    //移除审核列表刷新
    entrance_card_bus.off(entrance_audit_refresh, _eventCallBack);
  }

  _refresh() {
    _stateModel.historyHandleRefresh();
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
//                      if (info.status == auditLandlordWaiting) {
                        //待业主审核
                        Navigate.toNewPage(EntranceCardApplyAuditPage(info,null));
//                      }
                    },
                    child: CommonShadowContainer(
                      margin: EdgeInsets.only(
                          top: card_spacing,
                          left: left_spacing,
                          right: right_spacing),
                      backgroundColor: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                                top: top_spacing,
                                left: left_spacing,
                                right: right_spacing),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: CommonText.black16Text(info.customerName ?? "",textAlign: TextAlign.start),
                                ),CommonText.text14(
                                    info.statusDesc??"",
                                        color: (info.status == completed ||
                                            info.status == cancelled ||
                                            info.status == closed)
                                            ? color_text_gray
                                            : color_text_orange),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: left_spacing,
                                right: right_spacing,
                                bottom: text_spacing),
                            child: CommonText.lightGrey12Text(
                                info.createTime ?? "",
                                textAlign: TextAlign.right),
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: leftTextWidget(
                                    text: "向您申请办理 " +
                                        StringsHelper.getStringValue(
                                            info.applyCount) +
                                        " 张门禁卡"),
                              ),
//                              Container(
//                                  margin: EdgeInsets.only(right: right_spacing),
//                                  child: CommonText.text14(
//                                      getStateText(info.status),
//                                      color: (info.status == completed ||
//                                              info.status == cancelled ||
//                                              info.status == closed)
//                                          ? color_text_gray
//                                          : color_text_orange)),
                            ],
                          ),Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(
                                    left: left_spacing,
                                    bottom: text_spacing),
                              child:UIData.iconLocation,
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    right: right_spacing,
                                    bottom: text_spacing),
                                child: CommonText.lightGrey12Text(StringsHelper
                                    .getStringValue(info.formerName) +
                                    " " +
                                    StringsHelper.getStringValue(info.buildName) +
                                    "-" +
                                    StringsHelper.getStringValue(info.unitName) +
                                    "-" +
                                    StringsHelper.getStringValue(info.houseNo)),
                              ),
                            ],
                          ),

                          Padding(
                              padding: EdgeInsets.only(bottom: bottom_spacing),
                              child: Visibility(
                                visible: info.status == auditLandlordWaiting,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    _StadiumSolidButton(
                                      '不同意',
                                      btnType: _ButtonType.CANCEL,
                                      onTap: () {
                                        CommonDialog.showAlertDialog(context,
                                            content: '拒绝该租户的门禁办理申请',
                                            onConfirm: () {
                                          model.onAuditTap(
                                              info.accessCardId, 0);
                                        });
//                      LogUtils.printLog('点击退租按钮');
                                      },
                                    ),
                                    _StadiumSolidButton(
                                      '同意',
                                      btnType: _ButtonType.CONFIRM,
                                      onTap: () {
                                        CommonDialog.showAlertDialog(context,
                                            content: '同意该租户的门禁办理申请',
                                            onConfirm: () {
                                          model.onAuditTap(
                                              info.accessCardId, 1);
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ))
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

enum _ButtonType {
  CONFIRM,
  CANCEL,
}

///
/// 实心背景圆角按钮
/// [btnType]默认为[ButtonType.CONFIRM]为渐变红色底色，[ButtonType.CANCEL]为深灰色底色
///
class _StadiumSolidButton extends StatelessWidget {
  final String title;
  final _ButtonType btnType;
  final GestureTapCallback onTap;

  _StadiumSolidButton(this.title,
      {this.btnType = _ButtonType.CONFIRM, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(
            top: top_spacing,
            left: UIData.spaceSize16,
            right: UIData.spaceSize16),
        padding: EdgeInsets.symmetric(
            vertical: UIData.spaceSize4, horizontal: UIData.spaceSize8),
        width: ScreenUtil.getInstance().setWidth(70),
        decoration: ShapeDecoration(
          shape: StadiumBorder(),
          gradient: btnType == _ButtonType.CONFIRM
              ? LinearGradient(colors: [
                  UIData.redGradient1,
                  UIData.redGradient2,
                  UIData.redGradient3
                ])
              : LinearGradient(
                  colors: [UIData.greyGradient1, UIData.greyGradient2]),

            shadows: [
              BoxShadow(
                  color: (btnType == _ButtonType.CONFIRM ? UIData.themeBgColor70 : UIData.greyGradient70),
                  offset: Offset(0.0, 3.5),
                  blurRadius: 4.0,
                  spreadRadius: 0.0)
            ]
        ),
        child: CommonText.white12Text(title),
      ),
      onTap: onTap,
    );
  }
}
