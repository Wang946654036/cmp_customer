import 'package:cmp_customer/models/decoration_obj.dart';
import 'package:cmp_customer/models/meetingroom/meeting_room_info_obj.dart';
import 'package:cmp_customer/models/meetingroom/reserve_info.dart';
import 'package:cmp_customer/scoped_models/decoration_model.dart';
import 'package:cmp_customer/scoped_models/reservation_state_model.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_dialog.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_text_field.dart';
import 'package:cmp_customer/ui/conference_room_reservation/can_book_room_list.dart';
import 'package:cmp_customer/ui/conference_room_reservation/reservation_save_page.dart';
import 'package:cmp_customer/ui/decorate_manager/decoration_ui.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'can_book_room_list_continue.dart';

//确认预定列表
class ReservationCheckPage extends StatefulWidget {
  ReservationModel _model;
  int orderId;
  ReservationCheckPage(this._model,{this.orderId});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ReservationCheckPageState();
  }
}

class _ReservationCheckPageState extends State<ReservationCheckPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CommonScaffold(
      popBack: () {
        CommonDialog.showAlertDialog(context, title: widget.orderId!=null?'确认放弃编辑？':'确定放弃预定？', onConfirm: () {
          widget._model.saveInfoList.clear();
          widget._model.notifyListeners();
          Navigate.closePage();
        }, negativeBtnText: '我再看看');
      },
      appTitle: widget.orderId!=null?'重新编辑':'会议室预定',
      bottomNavigationBar: StadiumSolidButton(
        '提交',
        onTap: () {
          if(widget.orderId==null)
          widget._model.createMeetingMainOrder(callback: () {
            widget._model.saveInfoList.clear();
            Navigate.closePage(2);
          });
          else
            widget._model.editMeetingMainOrder(widget.orderId,callback: () {
              widget._model.saveInfoList.clear();
              Navigate.closePage(2);
            });
        },
      ),
      bodyData: ScopedModel<ReservationModel>(
          model: widget._model, child: _buildContent()),
    );
  }

  Widget _buildContent() {
    return ScopedModelDescendant<ReservationModel>(
        builder: (context, child, model) {
      ReserveInfo info = model.reserveInfo;
      return SingleChildScrollView(
        child: Column(children: getViewList()),
      );
    });
  }

  List<Widget> getViewList() {
    List<MeetingRoomInfo> saveInfoList = new List();
    if (widget._model.saveInfoList != null &&
        widget._model.saveInfoList.length > 0) {
      saveInfoList.addAll(widget._model.saveInfoList);
    }
    List<Widget> widgets = new List();
    widgets.add(SizedBox(height: UIData.spaceSize12,));
    for (int index = 0; index < saveInfoList.length; index++) {
      MeetingRoomInfo info = saveInfoList[index];
      Widget view = Container(
        color: UIData.primaryColor,
        margin: EdgeInsets.only(bottom: UIData.spaceSize1),
        padding: EdgeInsets.only(
            bottom: UIData.spaceSize12, left: UIData.spaceSize16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(flex: 1, child: CommonText.grey15Text('会议室${index + 1}')),
                Expanded(
                    flex: 2,
                    child: GestureDetector(
                        child: CommonText.darkGrey15Text(info.roomName??''),
                        onTap: () {
                          Navigate.toNewPage(ReservationSavePage(
                            widget._model,
                            info,
                            position: index,
                          ));
                        })),
                GestureDetector(
                  onTap: () {
                    CommonDialog.showAlertDialog(context, title: '确定移除？',
                        onConfirm: () {
                      saveInfoList.removeAt(index);
                      widget._model.saveInfoList.removeAt(index);
                      widget._model.notifyListeners();
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(UIData.spaceSize16),
                    child: Icon(
                      Icons.cancel,
                      color: UIData.lightGreyColor,
                      size: UIData.fontSize20,
                    ),
                  ),
                )
              ],
            ),
            Visibility(
              child: GestureDetector(
                onTap: () {
                  Navigate.toNewPage(ReservationSavePage(
                    widget._model,
                    info,
                    position: index,
                  ));
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
//                    Container(
//                      padding: EdgeInsets.only(right: UIData.spaceSize4),
//                      child: Icon(
//                        Icons.info,
//                        color: UIData.redColor,
//                        size: UIData.fontSize16,
//                      ),
//                    ),
                    Expanded(
                      child: CommonText.grey12Text('预约时间：${info.orderDate}'),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
      widgets.add(view);
    }
    if(widget._model.saveInfoList!=null&&widget._model.saveInfoList.length<5) {
      widgets.add(Container(
          padding: EdgeInsets.symmetric(
              vertical: UIData.spaceSize10),
          child: Container(
            width:double.infinity,
            color: UIData.primaryColor,
            child: FlatButton(
                onPressed: () {
                  Navigate.toNewPage(CanBookRoomListContinue(widget._model));
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.add_circle, color: UIData.themeBgColor),
                    SizedBox(width: UIData.spaceSize4),
                    CommonText.red15Text('继续预定'),
                  ],
                )),
          )));
    }
    return widgets;
  }
}
