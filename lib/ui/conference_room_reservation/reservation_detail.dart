import 'package:cmp_customer/models/change_title_obj.dart';
import 'package:cmp_customer/models/decoration_obj.dart';
import 'package:cmp_customer/models/meetingroom/meeting_room_info_obj.dart';
import 'package:cmp_customer/models/meetingroom/reserve_info.dart';
import 'package:cmp_customer/models/property_notice_model.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/scoped_models/decoration_model.dart';
import 'package:cmp_customer/scoped_models/reservation_state_model.dart';
import 'package:cmp_customer/ui/brand_name/brand_name_ui.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_dialog.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_image_display.dart';
import 'package:cmp_customer/ui/common/common_image_picker.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_text_field.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/conference_room_reservation/reservation_check_page.dart';
import 'package:cmp_customer/ui/conference_room_reservation/reservation_node_list.dart';
import 'package:cmp_customer/ui/conference_room_reservation/room_information_ui.dart';
import 'package:cmp_customer/ui/conference_room_reservation/rooms_reservation_info_list.dart';
import 'package:cmp_customer/ui/decorate_manager/decoration_ui.dart';
import 'package:cmp_customer/ui/decorate_manager/decoration_ui.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../main.dart';
import 'can_book_room_list.dart';

class ReservationDetailPage extends StatefulWidget {
  ReservationModel _model;
  int infoId;

  ReservationDetailPage(this._model, this.infoId);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ReservationDetailPageState();
  }
}

class _ReservationDetailPageState extends State<ReservationDetailPage> {
  List<Attachment> attPhotoList = new List();

  TextEditingController remarkController = new TextEditingController();
  TextEditingController feeController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget._model.getReserveInfo(widget.infoId);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModel<ReservationModel>(
        model: widget._model,
        child: ScopedModelDescendant<ReservationModel>(
            builder: (context, child, model) {
          ReserveInfo info = model.reserveInfo;
          return CommonScaffold(
              appTitle: "申请详情",
              bodyData: _buildBody(),
              appBarActions: [
                // //DSL-待受理，SLBTG-受理不通过，DJF-待缴费，JFCS-缴费超时，YDCG-预定成功，YQX-已取消
                Visibility(
                  child: FlatButton(
                    child: CommonText.red15Text('取消预定'),
                    onPressed: () {
                      CommonDialog.showAlertDialog(context,
                          title: '是否取消预定',
                          positiveBtnText: '确认取消',
                          negativeBtnText: '我再看看', onConfirm: () {
                        model.reserveIsPass({
                          'orderId': info.orderId,
                          'operation': 'QX',
                        }, callback: () {
                          Navigate.closePage(true);
                        });
                      });
                    },
                  ),
                  visible:
                      model.reservationInfoState == ListState.HINT_DISMISS &&
                          info.state != 'YDCG' &&
                          info.state != 'YQX'&&
                          info.state != 'SLBTG',
                ),
              ],
              bottomNavigationBar: model.reservationInfoState ==
                          ListState.HINT_DISMISS &&
                      (info.state == 'DSL' || info.state == 'SLBTG')
                  ? StadiumSolidButton(
                      info.state == 'SLBTG' ? '重新申请' : '编辑申请',
                      onTap: () {
                        if(info.state == 'SLBTG'){
                          Navigate.toNewPage(CanBookRoomList(model),callBack: (flag){
                            if(flag!=null&&flag is bool&&flag){
                              Navigate.closePage(true);
                            }
                          });
                        }else {
                          if (widget._model.saveInfoList == null) {
                            widget._model.saveInfoList = new List();
                          } else {
                            widget._model.saveInfoList.clear();
                          }
                          widget._model.saveInfoList
                              .addAll(info.meetingSubOrderVoList);
                          widget._model.saveInfoList
                              .forEach((MeetingRoomInfo meetingInfo) {
                            if (meetingInfo.deviceSelectList != null) {
                              if (meetingInfo.deviceList == null) {
                                meetingInfo.deviceList = new List();
                                meetingInfo.deviceList.addAll(
                                    meetingInfo.deviceSelectList);
                              } else
                                meetingInfo.deviceList.forEach((Device device) {
                                  for (int i = 0;
                                  i < meetingInfo.deviceSelectList.length;
                                  i++) {
                                    if (device.code ==
                                        meetingInfo.deviceSelectList[i].code) {
                                      device.point =
                                          meetingInfo.deviceSelectList[i].point;
                                    }
                                  }
                                  LogUtils.printLog(
                                      'device:${device.name}${device.point}');
                                });
//                            info.deviceSelectList.clear();
                            }
                            if (meetingInfo.serviceSelectList != null) {
                              if (meetingInfo.serviceList == null) {
                                meetingInfo.serviceList = new List();
                                meetingInfo.serviceList.addAll(
                                    meetingInfo.serviceSelectList);
                              } else
                                meetingInfo.serviceList.forEach((
                                    Service service) {
                                  for (int i = 0;
                                  i < meetingInfo.serviceSelectList.length;
                                  i++) {
                                    if (service.code ==
                                        meetingInfo.serviceSelectList[i].code) {
                                      service.point =
                                          meetingInfo.serviceSelectList[i]
                                              .point;
                                    }
                                  }
                                  LogUtils.printLog(
                                      'service:${service.name}${service
                                          .point}');
                                });
//                            info.serviceSelectList.clear();
                            }

                            meetingInfo.meetingSubOrderTimeVoList.forEach((
                                Time time) {
//                            LogUtils.printLog('${time.timeId}');
                              time.selected = true;
                            });
                            meetingInfo.selectTimeList = new List();
                            meetingInfo.selectTimeList.addAll(
                                meetingInfo.meetingSubOrderTimeVoList);
                          });

                          Navigate.toNewPage(
                              ReservationCheckPage(
                                widget._model,
                                orderId: info.orderId,
                              ), callBack: (int requestCodeInside) {
                            if (widget._model.result_suc_create ==
                                requestCodeInside) {
                              //回去刷新
                              Navigate.closePage(true);
                            }
                          });
                        }
                      },
                    )
                  : null);
        }));
  }

  Widget _buildBody() {
    return ScopedModelDescendant<ReservationModel>(
        builder: (context, child, model) {
      return CommonLoadContainer(
        state: widget._model.reservationInfoState,
        callback: () {
          widget._model.getReserveInfo(widget.infoId);
        },
        content: _buildContent(),
      );
    });
  }

  Widget _buildContent() {
    return ScopedModelDescendant<ReservationModel>(
        builder: (context, child, model) {
      ReserveInfo info = model.reserveInfo;
      return SingleChildScrollView(
        child: Column(children: <Widget>[
          //状态栏
          Container(
              color: UIData.primaryColor,
              padding: EdgeInsets.only(
                  bottom: UIData.spaceSize12, top: UIData.spaceSize12),
              child: Column(children: <Widget>[
                Stack(
                  children: <Widget>[
                    ///状态栏
                    Align(
                        alignment: Alignment.center,
                        child: CommonText.darkGrey16Text(
                            info.stateName ??
                                getReservationStateStr(info.state ?? ''),
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ])),
          CommonDivider(),

          ///受理人信息
          Container(
            color: UIData.primaryColor,
            margin: EdgeInsets.only(top: UIData.spaceSize12),
            padding: EdgeInsets.symmetric(vertical: UIData.spaceSize12),
            child: Column(
              children: <Widget>[
                labelTextWidget(
                  label: '业务单号',
                  text: info.orderCode ?? '',
                  bottomSpacing: UIData.spaceSize6,
                ),
                Visibility(
                    visible: StringsHelper.isNotEmpty(info.acceptRemark),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: UIData.spaceSize6),
                      color: UIData.primaryColor,
                      child: labelTextWidget(
                        crossAxisAlignment:CrossAxisAlignment.start,
                        label: '受理意见',
                        text: info.acceptRemark ?? '',
                      ),
                    )),

                ///缴费信息
                Visibility(
                  //YDCG-预定成功
                  visible: info.actualPay != null && info.state == 'YDCG',
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: UIData.spaceSize6),
                    child: labelTextWidget(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      label: '缴费金额',
                      unit: '元',
                      text: '${info.actualPay ?? 0}',
                    ),
                  ),
                ),

                ///缴费信息
                Visibility(
                  //YDCG-预定成功
                  visible: info.confirmCost != null && (info.state == 'DJF'||info.state == 'JFCS'),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: UIData.spaceSize6),
                    child: labelTextWidget(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      label: '缴费金额',
                      unit: '元',
                      text: '${info.confirmCost ?? 0}',
                    ),
                  ),
                ),
                Visibility(
                  visible: StringsHelper.isNotEmpty(info.payRemark),
                  child: Container(
                    child: labelTextWidget(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      label: '缴费说明',
                      text: info.payRemark ?? "",
                      topSpacing: UIData.spaceSize6,
                    ),
                  ),
                ),
                Visibility(
                    visible: info?.payPhotoList!=null&&info.payPhotoList.length>0,
                    child: Container(
                      padding:
                      EdgeInsets.only(top: UIData.spaceSize12),
                      color: UIData.primaryColor,
                      child: labelTextWidget(
                        label: '缴费凭证',
                      ),
                    )),
                Visibility(
                  child: Container(
                    padding: EdgeInsets.only(
                        bottom: UIData.spaceSize12,
                        top: UIData.spaceSize8,
                        left: UIData.spaceSize16,
                        right: UIData.spaceSize16),
                    child: CommonImageDisplay(
                        photoIdList: getFileList(info?.payPhotoList)),
                  ),
                  visible:info?.payPhotoList!=null&&info.payPhotoList.length>0,
                ),
              ],
            ),
          ),
          SizedBox(
            height: UIData.spaceSize12,
          ),

          ///预定会议室列表
          Visibility(
            child: RoomsReservationInfoListView(
                info.meetingSubOrderVoList ?? new List<MeetingRoomInfo>()),
            visible: info.meetingSubOrderVoList != null &&
                info.meetingSubOrderVoList.length > 0,
          ),

          ///流程节点
//          ReservationNodeListView(new List<RecordList>()),
        ]),
      );
    });
  }

  List<String> getFileList(List<Attachment> attFileList) {
    List<String> strs = new List();
    if (attFileList != null)
      attFileList.forEach((info) {
        strs.add(info.attachmentUuid);
      });
    return strs;
  }
}
