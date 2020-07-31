import 'package:cmp_customer/models/response/parking_card_details_response.dart';
import 'package:cmp_customer/scoped_models/parking_model/parking_details_state_model.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_image_display.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_ui.dart';
import 'package:cmp_customer/ui/parking/parking_card_node.dart';
import 'package:cmp_customer/ui/parking/parking_card_state.dart';
import 'package:cmp_customer/utils/common_event_bus.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'parking_card_ui.dart';

//停车卡详情
class ParkingCardDetailsPage extends StatefulWidget {
//  String parkingId;
  ParkingCardDetailsPage(int parkingId) {
    detailsParkingId = parkingId;
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement creatextate
    return ParkingCardDetails();
  }
}

ParkingDetailsStateModel _stateModel;
int detailsParkingId;
class ParkingCardDetails extends State<ParkingCardDetailsPage> {
  bool checkboxState = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _stateModel = new ParkingDetailsStateModel(context);
    getDetailsData();
    //添加刷新监听事件
    parking_card_bus.on(parking_refresh, _eventCallBack);
    //添加关闭监听事件
//    parking_card_bus.on(parking_details_close, _closeCallBack);
  }

  EventCallBack _eventCallBack = (refresh) {
    getDetailsData();
  };

//  EventCallBack _closeCallBack = (refresh) {
//    Navigate.closePage();
//  };

//  @override
//  void didChangeAppLifecycleState(AppLifecycleState state) {
//    // TODO: implement didChangeAppLifecycleState
//    super.didChangeAppLifecycleState(state);
//    if(state == AppLifecycleState.resumed && _stateModel.payRefresh){
//      //打开了支付页面，需要刷新列表
//      parking_card_bus.emit(parking_refresh); //发送刷新事件
//      _stateModel.setPayRefresh(false);
//    }
//  }



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    parking_card_bus.off(parking_refresh, _eventCallBack); //移除监听
//    parking_card_bus.off(parking_details_close, _eventCallBack); //移除监听
  }

  Widget _buildContent() {
    return ScopedModelDescendant<ParkingDetailsStateModel>(
        builder: (context, child, model) {
      ParkingCardDetailsInfo info = model.detailsInfo;
      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              margin: EdgeInsets.only(bottom: bottom_spacing),
              padding: EdgeInsets.only(bottom: bottom_spacing),
              child: Column(
                children: <Widget>[
                  labelTextWidget(
                    label: label_apply_deal_type,
                    text: getOperationStateText(info.type),
                    topSpacing: top_spacing,
                  ),
                  labelTextWidget(
                    label: label_apply_deal_progress,
                    text: info.statusDesc ?? "",
                    color: color_text_orange,
                    topSpacing: top_spacing,
                  ),
                  labelTextWidget(
                    label: label_apply_deal_time,
                    text: info.createTime ?? "",
                    topSpacing: top_spacing,
                  ),
                  Visibility(
                    visible: info.status == auditFailed,
                    child: labelTextWidget(
                        label: label_apply_audit_time,
                        text: info.updateTime ?? "",
                        topSpacing: top_spacing),
                  )
                ],
              ),
            ),
//            Visibility(
//              visible: info.status == auditFailed,
//              child: Container(
//                color: Colors.white,
//                margin: EdgeInsets.only(bottom: bottom_spacing),
//                padding: EdgeInsets.only(top: top_spacing),
//                child: Column(
//                  children: <Widget>[
////                        leftTextWidget(text: label_apply_audit_opinion,
////                          color: color_text_gray,
////                          topSpacing: top_spacing,),
//                    leftTextWidget(text: label_apply_upload_driving_license),
//                    Container(
//                      margin: EdgeInsets.all(horizontal_spacing),
//                      child: CommonImageDisplay(null),
//                    ),
////                        info.status == auditFailed?CommonImagePicker(): ,
//                  ],
//                ),
//              ),
//            ),
            Container(
              color: Colors.white,
              margin: EdgeInsets.only(bottom: bottom_spacing),
              padding: EdgeInsets.only(bottom: bottom_spacing),
              child: Column(
                children: <Widget>[
                  labelTextWidget(
                    label: label_apply_parking_place,
                    text: info.parkingLot ?? "",
                    topSpacing: top_spacing,
                  ),
                  labelTextWidget(
                    label: label_apply_parking_packages,
                    text: info.parkingPackage ?? "",
                    topSpacing: top_spacing,
                  ),
                  labelTextWidget(
                    label: label_apply_car_no,
                    text: info.carNo ?? "",
                    topSpacing: top_spacing,
                  ),
                  labelTextWidget(
                    label: label_apply_car_brand,
                    text: info.carBrand ?? "",
                    topSpacing: top_spacing,
                  ),
                  labelTextWidget(
                    label: label_apply_car_color,
                    text: info.carColor ?? "",
                    topSpacing: top_spacing,
                  ),
                  labelTextWidget(
                    label: label_apply_driver_name,
                    text: info.carOwnerName ?? "",
                    topSpacing: top_spacing,
                  ),
                  labelTextWidget(
                    label: label_apply_driver_phone,
                    text: info.carOwnerPhone ?? "",
                    topSpacing: top_spacing,
                  ),
                  Visibility(
                    visible: _applyInfoVisiable(info.type),
                    child: labelTextWidget(
                      label: label_apply_duration,
                      text:
                          StringsHelper.getStringValue(info.applyMonths) + "个月",
                      topSpacing: top_spacing,
                    ),
                  ),
                  Visibility(
                    visible: info.status == payWaiting ||
                        info.status == auditWaiting,
                    child: labelTextWidget(
                      label: label_apply_fee,
                      text: StringsHelper.getStringValue(info.payFees)+label_unit_fee,
                      topSpacing: top_spacing,
                      color: color_text_orange,
                    ),
                  ),
                  Visibility(
                    visible: _xzInfoVisiable(info.type) ||
                        _tkInfoVisiable(info.type),
                    child: labelTextWidget(
                      label: label_apply_old_start_n_stop_date,
                      text: StringsHelper.getStringValue(info.effectTime) +
                          "至" +
                          StringsHelper.getValidStringValue(
                              info.validEndTime, info.formerEndTime),
                      topSpacing: top_spacing,
                    ),
                  ),
                  Visibility(
                    visible: _xzInfoVisiable(info.type),
                    child: labelTextWidget(
                      label: label_apply_duration_renew,
                      text:
                          StringsHelper.getStringValue(info.applyMonths) + "个月",
                      topSpacing: top_spacing,
                    ),
                  ),
                  Visibility(
                    visible: _tkInfoVisiable(info.type),
                    child: labelTextWidget(
                      label: label_apply_expect_date,
                      text: info.cancelEndTime ?? "",
                      topSpacing: top_spacing,
                    ),
                  ),
                  Visibility(
                    visible: _tkInfoVisiable(info.type) &&
                        (info.paybackFees != null),
                    child: labelTextWidget(
                      label: label_apply_back_fee,
                      text: StringsHelper.getDoubleToStringValue(
                              info.paybackFees) +
                          label_unit_fee,
                      topSpacing: top_spacing,
                      color: color_text_orange,
                    ),
                  ),
                ],
              ),
            ),

//            Visibility(
//              visible: _applyInfoVisiable(info.type)&&info.status==auditWaiting,
//              child:Container(
//                    color: color_layout_bg,
//                    margin: EdgeInsets.symmetric(vertical: vertical_spacing),
//                    child: Column(
//                      children: <Widget>[
//                        Container(
//                          alignment: Alignment.centerLeft,
//                          margin: EdgeInsets.only(left: left_spacing,top: top_spacing),
//                          height: single_height,
//                          child: Text(label_apply_upload_driving_license,
//                              style: TextStyle(
//                                  fontSize: normal_text_size, color: color_text)),
//                        ),
//                        Container(
//                          margin: EdgeInsets.all(horizontal_spacing),
//                          child: CommonImagePicker(photoIdList:info.photoList)
//                        ),
//                      ],
//                    )
//                )
//                ),
//                Visibility(
//                  visible: info.status == completed,
//                  child: Container(
//                      color: Colors.white,
//                      margin: EdgeInsets.only(bottom: bottom_spacing),
//                      padding: EdgeInsets.only(bottom: bottom_spacing),
//                      child: labelTextWidget(label: label_apply_pay_fee,
//                        text: StringsHelper.getStringValue(info.payFees)+label_unit_fee,
//                        topSpacing: top_spacing,
//                        color: color_text_orange,)
//                  ),
//                ),

            Visibility(
              visible: info.status == completed &&
                  (info.type == operationXK || info.type == operationXF),
              child: Container(
                color: Colors.white,
                margin: EdgeInsets.only(bottom: bottom_spacing),
                padding: EdgeInsets.only(bottom: bottom_spacing),
                child: Column(
                  children: <Widget>[
                    labelTextWidget(
                      label: label_apply_pay_time,
                      text: info?.payTime ?? "",
                      topSpacing: top_spacing,
                    ),
                    labelTextWidget(
                      label: label_apply_pay_fee,
                      text: StringsHelper.getDoubleToStringValue(info?.payFees) +
                          label_unit_fee,
                      topSpacing: top_spacing,
                      color: color_text_orange,
                    ),
                    labelTextWidget(
                      label: label_apply_pay_method,
                      text: _getPayTypeName(info?.payType),
                      topSpacing: top_spacing,
                    ),
                  ],
                ),
              ),
            ),
//                Visibility(
//                  visible: info.type==operationTZ&&info.status != tzAcceptWaiting,
//                  child: Container(
//                    color: Colors.white,
//                    margin: EdgeInsets.only(bottom: bottom_spacing),
//                    padding: EdgeInsets.only(bottom: bottom_spacing),
//                    child: Column(
//                      children: <Widget>[
//                        labelTextWidget(label: label_apply_accept_fee,
//                          text: StringsHelper.getDoubleToStringValue(info.payFees)+ label_unit_fee,
//                          topSpacing: top_spacing,
//                          color: color_text_orange,),
//                        leftTextWidget(text: label_apply_accept_opinion,
//                          color: color_text_gray,
//                          topSpacing: top_spacing,),
//                        leftTextWidget(
//                            text: info.remark??""),
//                      ],
//                    ),
//                  ),
//                ),
            //流程节点
            Container(
              color: color_layout_bg,
              child: ParkingCardNodeWidget(info?.recordList),
            ),
//            Visibility(
//              visible: info.status != auditWaiting,
//              child: Container(
//                color: Colors.white,
//                margin: EdgeInsets.only(bottom: bottom_spacing),
//                padding: EdgeInsets.only(bottom: bottom_spacing),
//                child: Column(
//                  children: <Widget>[
//                    leftTextWidget(
//                      text: label_apply_node,
//                      topSpacing: top_spacing,
//                    ),
//                  ],
//                ),
//              ),
//            ),
          ],
        ),
      );
    });
  }

  Widget _buildBody() {
    return ScopedModelDescendant<ParkingDetailsStateModel>(
        builder: (context, child, model) {
      return CommonLoadContainer(
        state: _stateModel.mineState,
        callback: () {
          _stateModel.getDetails(detailsParkingId);
        },
        content: _buildContent(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModel<ParkingDetailsStateModel>(
        model: _stateModel,
        child: CommonScaffold(
            appTitle: "办理详情",
            bodyData: _buildBody(),
            bottomNavigationBar:
                ScopedModelDescendant<ParkingDetailsStateModel>(
                    builder: (context, child, model) {
              ParkingCardDetailsInfo info = model.detailsInfo;
              return Visibility(
                  visible: _bottomVisiable(info.status, info.type),
                  child: StadiumSolidWithTowButton(
                    cancelText: _getCancelText(info.status),
                    onCancel: () {
                      _stateModel.cancelOnDetailsTap(context);
                    },
                    conFirmText: _getConfirmText(info.status),
                    onConFirm: () {
                      _stateModel.confirmOnDetailsTap(context);
                    },
                  )
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: <Widget>[
//                    Expanded(
//                        child: StadiumSolidButton(
//                      _getCancelText(info.status),
//                      btnType: ButtonType.CANCEL,
//                      onTap: () {
//                        _stateModel.cancelOnDetailsTap(context);
//                      },
//                          margin: EdgeInsets.only(
//                              left: UIData.spaceSize48,
//                              right: UIData.spaceSize24,
//                              top: UIData.spaceSize10,
//                              bottom: UIData.spaceSize10
//                          ),
//                    )),
//                    Expanded(
//                        child: StadiumSolidButton(
//                      _getConfirmText(info.status),
//                      btnType: ButtonType.CONFIRM,
//                      onTap: () {
//                        _stateModel.confirmOnDetailsTap(context);
//                      },
//                          margin: EdgeInsets.only(
//                              left: UIData.spaceSize24,
//                              right: UIData.spaceSize48,
//                              top: UIData.spaceSize10,
//                              bottom: UIData.spaceSize10
//                          ),
//                    )),
//                  ],
//                ),
                  );
            })));
  }

  _getCancelText(String state) {
    var cancelText;
    switch (state) {
      case auditWaiting:
      case auditFailed:
      case payWaiting:
//    case xzAuditWaiting:
//    case xzAuditFailed:
//    case xzPayWaiting:
      case tzAcceptWaiting:
      case tzConfirmWaiting:
        cancelText = "取消办理";
        break;
//      case completed:
//        cancelText = "退卡";
//        break;
    }
    return cancelText;
  }

  _getConfirmText(String state) {
    var confirmText;
    switch (state) {
      case auditWaiting:
      case auditFailed:
//    case xzAuditWaiting:
//    case xzAuditFailed:
//    case xzPayWaiting:
      case tzAcceptWaiting:
        confirmText = "修改申请";
        break;
      case payWaiting:
        confirmText = "立即支付";
        break;
      case tzConfirmWaiting:
        confirmText = "确认退租";
        break;
//      case completed:
//        confirmText = "续费";
//        break;
    }
    return confirmText;
  }

//按钮是否显示
  _bottomVisiable(String state, String type) {
    return state == auditWaiting ||
        state == auditFailed ||
        state == payWaiting ||
        state == tzAcceptWaiting ||
        state == tzConfirmWaiting ||
        (state != completed); //已完成不显示
  }

//初次申请信息是否显示
  _applyInfoVisiable(String type) {
    return operationXK == type;
//  return state==auditWaiting
//      ||state==auditFailed
//      ||state==payWaiting
//      ||state==completed
//      ||state==cancelled;
  }

//续租信息是否显示
  _xzInfoVisiable(String type) {
    return operationXF == type;
//  return state==xzAuditWaiting
//      ||state==xzAuditFailed
//      ||state==xzPayWaiting
//      ||state==xzCompleted
//      ||state==xzCancelled;
  }

//退卡信息是否显示
  _tkInfoVisiable(String type) {
    return operationTZ == type;
//  return state==tzAcceptWaiting
//      ||state==tzConfirmWaiting
//      ||state==tkCompleted
//      ||state==tkCancelled
//      ||state==payWaiting;
  }

//获取字符串
  _getString(value) {
    if (value == null) {
      return "";
    } else {}
  }

  //获取支付方式名称
  _getPayTypeName(String type){
    if("XSZF"==type){
      return "线上支付";
    }else if("XXZF"==type){
      return "线下支付";
    }else{
      return "";
    }
  }
}

//获取数据方法
getDetailsData() {
  if (_stateModel != null) {
    _stateModel.getDetails(detailsParkingId);
  }
}
//获取时间的字符串
