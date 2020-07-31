import 'package:cmp_customer/models/response/parking_card_details_response.dart';
import 'package:cmp_customer/scoped_models/parking_model/parking_mine_state_model.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_shadow_container.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/popover/cupertino_popover.dart';
import 'package:cmp_customer/ui/common/popover/cupertino_popover_menu_item.dart';
import 'package:cmp_customer/ui/parking/parking_card_details.dart';
import 'package:cmp_customer/ui/parking/parking_card_state.dart';
import 'package:cmp_customer/utils/common_event_bus.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scoped_model/scoped_model.dart';

import 'parking_card_ui.dart';

//停车卡我的月卡
class ParkingCardMinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ParkingCardMine();
  }
}

ParkingMineStateModel _stateModel;
////获取数据方法
//getMyCards() {
//  if (_stateModel != null) _stateModel.getMyCards();
//}

class ParkingCardMine extends State<ParkingCardMinePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _stateModel = new ParkingMineStateModel();
    _stateModel.getMyCards();
    parking_card_bus.on(parking_refresh, _eventCallBack); //增加监听
  }

  EventCallBack _eventCallBack = (refresh) {
    _stateModel.getMyCards();
  };

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    parking_card_bus.off(parking_refresh, _eventCallBack); //移除监听
//    //移除所有监听
//    parking_card_bus.off(parking_refresh);
//    parking_card_bus.off(parking_details_close);
  }

  Widget _buildContent() {
    return ScopedModelDescendant<ParkingMineStateModel>(
        builder: (context, child, model) {
      ParkingCardDetailsInfo info = model.selectedIndex >= 0
          ? model.detailsList[model.selectedIndex]
          : model.lastParkingApplyInfo;
      return RefreshIndicator(
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: <Widget>[
                Visibility(
                  visible: model.selectedIndex >= 0,
                  child: GestureDetector(
                    onTap: () {
                      model.selectOtherCard();
                    },
                    child: CommonShadowContainer(
                      margin: EdgeInsets.only(
                          top: card_spacing,
                          left: left_spacing,
                          right: right_spacing),
//                      decoration: BoxDecoration(
//                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                        boxShadow: <BoxShadow>[
//                          BoxShadow(
//                              color: UIData.dividerColor,
//                              offset: Offset(0.0, 5.0),
//                              blurRadius: 5.0,
//                              spreadRadius: 0.0),
//                        ],
                      image: DecorationImage(
                          image: AssetImage(UIData.imageParkingMine),
                          fit: BoxFit.fill),
                      //                  boxShadow: [BoxShadow(color: Color(0x99FFFF00), offset: Offset(0.0, 5.0),    blurRadius: 10.0, spreadRadius: 0.0), BoxShadow(color: Color(0x9900FF00), offset: Offset(1.0, 1.0)), BoxShadow(color: Color(0xFF0000FF))]
                      //                image: DecorationImage(image: AssetImage(UIData.imageMineCard)),
//                      ),
                      child: Stack(
                        children: <Widget>[
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: top_spacing, left: left_spacing),
                                    child: CommonText.text18(info?.carNo ?? "",
                                        color: Colors.white)),
                                Padding(
                                  padding: EdgeInsets.only(
//                                top: ScreenUtil.getInstance().setWidth(7),
                                      left: left_spacing),
                                  //                    child: Text("北门停车场",style: TextStyle(color: color_text_white,fontSize: UIData.fontSize12),),
                                  child: CommonText.white12Text(
                                      info?.parkingLot ?? ""),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: ScreenUtil.getInstance()
                                            .setWidth(10),
                                        bottom: ScreenUtil.getInstance()
                                            .setWidth(10),
                                        left: left_spacing),
                                    //                    child: Text("北门停车场",style: TextStyle(color: color_text_white,fontSize: UIData.fontSize12),),
                                    child: Row(
                                      children: <Widget>[
                                        UIData.iconDiamonds,
                                        CommonText.white12Text(
                                            info?.parkingPackage ?? ""),
                                      ],
                                    )),
                              ]),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                                margin: EdgeInsets.only(
                                  top: top_spacing,
                                ),
                                height: parking_state_height,
                                padding: EdgeInsets.symmetric(
                                    horizontal: horizontal_spacing),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(
                                            parking_state_half_height),
                                        bottomLeft: Radius.circular(
                                            parking_state_half_height)),
                                    gradient: LinearGradient(
                                        colors: color_grey_gradient)),
                                child: CommonText.text12(
                                    getCardValidityName(info?.validEndTime),
                                    color: Colors.white)),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: model.selectedIndex >= 0,
                  child: CommonShadowContainer(
                    margin: EdgeInsets.only(
                        top: card_spacing,
                        left: left_spacing,
                        right: right_spacing),
                    backgroundColor: Colors.white,
                    child: Column(
                      children: <Widget>[
                        labelTextWidget(
                          label: label_apply_car_brand,
                          text: info?.carBrand ?? "",
                          topSpacing: top_spacing,
                        ),
                        labelTextWidget(
                          label: label_apply_car_color,
                          text: info?.carColor ?? "",
                          topSpacing: top_spacing,
                        ),
                        labelTextWidget(
                          label: label_apply_driver_name,
                          text: info?.carOwnerName ?? "",
                          topSpacing: top_spacing,
                        ),
                        labelTextWidget(
                          label: label_apply_driver_phone,
                          text: info?.carOwnerPhone ?? "",
                          topSpacing: top_spacing,
                        ),
                        labelTextWidget(
                          label: label_apply_time,
                          text: info?.registerTime ?? "",
                          topSpacing: top_spacing,
                        ),
                        labelTextWidget(
                          label: label_apply_startup_date,
                          text: info?.effectTime ?? "",
                          topSpacing: top_spacing,
                        ),
                        labelTextWidget(
                          label: label_apply_termination_date,
                          text: info?.validEndTime ?? "",
                          topSpacing: top_spacing,
                          bottomSpacing: bottom_spacing,
                        ),
                      ],
                    ),
                  ),
                ),
                CommonShadowContainer(
                  margin: EdgeInsets.symmetric(
                      vertical: vertical_spacing,
                      horizontal: horizontal_spacing),
                  backgroundColor: Colors.white,
                  onTap: (){
                    Navigate.toNewPage(ParkingCardDetailsPage(info?.parkingId));
                  },
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: CommonText.text16(
                                  label_apply_recent_record,
                                  isBold: true),
                              padding: EdgeInsets.only(left: left_spacing),
                            ),
                          ),
//                          IconButton(
//                            icon: Icon(Icons.more_horiz,color: UIData.lightGreyColor,),
//                            iconSize: ScreenUtil.getInstance().setWidth(18),
//                            onPressed: () {
//                              model.toParkingHistory();
//                            },
//                            padding: EdgeInsets.all(0),
//                          ),
                          FlatButton(
                            child: CommonText.red16Text('更多办理记录'),
                            onPressed: () {
                              model.toParkingHistory();
                            },

                          )
                        ],
                      ),
//                              horizontalLineWidget(),
                      labelTextWidget(
                        label: label_apply_deal_type,
                        text: getOperationStateText(info?.type),
//                    topSpacing: text_spacing,
                      ),
                      labelTextWidget(
                        label: label_apply_deal_no,
                        text: info?.businessNo ?? "",
                        color: color_text_red,
                        topSpacing: text_spacing,
                      ),
                      labelTextWidget(
                        label: label_apply_deal_progress,
                        text: info.statusDesc??"",
                        topSpacing: text_spacing,
                        bottomSpacing: text_spacing,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          onRefresh: model.getMyCardsRefresh);
    });
  }

  Widget _buildBody() {
    return ScopedModelDescendant<ParkingMineStateModel>(
        builder: (context, child, model) {
      return CommonLoadContainer(
        state: _stateModel.mineState,
        callback: () {
          _stateModel.getMyCards();
        },
        content: _buildContent(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModel<ParkingMineStateModel>(
        model: _stateModel,
        child: CommonScaffold(
            appTitle: "我的月卡",
            appBarActions: <Widget>[
              CupertinoPopoverButton(
        popoverWidth: UIData.spaceSize120,
            popoverColor: UIData.greyColor,
            child: FlatButton(
              child: CommonText.red15Text("添加月卡"),
              onPressed: null,
            ),
            popoverBuild: (context) {
              return CupertinoPopoverMenuList(
                children: <Widget>[
                  CupertinoPopoverMenuItem(
                    child: CommonText.white14Text("新卡申请"),
                    onTap: () {
                      _stateModel.applyNewCard();
                    },
                  ),
                  CupertinoPopoverMenuItem(
                    child: CommonText.white14Text("绑定已有月卡"),
                    onTap: () {
                      _stateModel.bindOldCard();
                    },
                  ),
                ],
              );
            }),
//              Builder(builder: (context) {
//                return FlatButton(
////                  behavior: HitTestBehavior.translucent,
//                    onPressed: () {
//                      _stateModel.applyNewCard();
//                    },
////                    child: Container(
////                        alignment: Alignment.centerRight,
////                        padding: EdgeInsets.only(right: right_spacing),
//                        child: CommonText.text15("我要申请",
//                            color: color_text_red,
//                            textAlign: TextAlign.center)
////                )
//                );
//              })
            ],
            bodyData: _buildBody(),
            bottomNavigationBar: ScopedModelDescendant<ParkingMineStateModel>(
                builder: (context, child, model) {
              ParkingCardDetailsInfo info = model.selectedIndex >= 0
                  ? model.detailsList[model.selectedIndex]
                  : null;
              return Visibility(
                visible: _bottomVisiable(info),
                child: StadiumSolidWithTowButton(
                    cancelText: '退租',
                    onCancel: () {
                      _stateModel.cancelOnMineTap();
                    },
                    conFirmText: '续费',
                    onConFirm: () {
                      _stateModel.confirmOnMineTap();
                    }),
              );
            })));
  }

  //底部按钮是否可见
  _bottomVisiable(ParkingCardDetailsInfo info) {
    //已完成状态
//    if (info != null &&info?.status ==completed&&(info?.type ==operationXK || info?.type == operationXF)) {
    if (info != null &&
        (info?.status == null|| info?.status == completed || info?.status == cancelled)) {
      return true;
    }
    return false;
  }
}
