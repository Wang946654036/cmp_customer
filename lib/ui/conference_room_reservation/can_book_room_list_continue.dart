import 'package:cmp_customer/models/meetingroom/meeting_room_info_obj.dart';
import 'package:cmp_customer/scoped_models/reservation_state_model.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_list_loading.dart';
import 'package:cmp_customer/ui/common/common_list_refresh.dart';
import 'package:cmp_customer/ui/common/common_loadmore.dart';
import 'package:cmp_customer/ui/common/common_picker.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_shadow_container.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/conference_room_reservation/reservation_save_page.dart';
import 'package:cmp_customer/ui/decorate_manager/decoration_ui.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scoped_model/scoped_model.dart';

///可预定会议室列表（我要预定）

class CanBookRoomListContinue extends StatefulWidget {
  ReservationModel _model;

  CanBookRoomListContinue(this._model);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CanBookRoomListState();
  }
}

class _CanBookRoomListState extends State<CanBookRoomListContinue> {
  String surrenderTime = StringsHelper.formatterYMD.format(DateTime.now()); //今天
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _loadMoreScrollController.addListener(() {
      if (_loadMoreScrollController.position.pixels ==
          _loadMoreScrollController.position.maxScrollExtent) {
        if (widget._model.reservationInfoListState != ListState.HINT_LOADING) {
          widget._model.quoteCanBookHandleLoadMore(param, expandStateList);
        }
      }
    });
    _refresh();
  }

  ScrollController _loadMoreScrollController = new ScrollController();
  List<MeetingRoomInfo> expandStateList =
      new List(); //开展开的状态列表,ExpandStateBean是自定义的类
  List<List<Time>> checkList = new List();

  //创建控件
  Map<String, dynamic> param = new Map();

  Widget _buildContent() {
    return ScopedModelDescendant<ReservationModel>(
      builder: (context, child, model) {
        switch (widget._model.meetinInfoListState) {
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
              controller: _loadMoreScrollController,
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: (expandStateList?.length ?? 0) + 1,
              itemBuilder: (BuildContext context, int index) {
                if (expandStateList.length == index) {
                  return CommonLoadMore(model.meetingRoomsMaxCount);
                } else {
                  MeetingRoomInfo info = expandStateList[index];

                  return CommonShadowContainer(
                    margin: EdgeInsets.only(
                        top: UIData.spaceSize12,
                        left: UIData.spaceSize16,
                        right: UIData.spaceSize16),
                    backgroundColor: Colors.white,
                    child: ExpansionTile(
                      title: new Column(
                        children: <Widget>[
                          leftTextWidget(
                            text: info.roomName ?? '',
                            leftSpacing: 0,
                            fontSize: UIData.fontSize16,
                            topSpacing: ScreenUtil.getInstance().setHeight(4),
                          ),
                          leftTextWidget(
                            text: ("可容纳人数：${info.capacity ?? 0}"),
                            leftSpacing: 0,
                            fontSize: UIData.fontSize14,
                            topSpacing: ScreenUtil.getInstance().setHeight(4),
                          ),
                          leftTextWidget(
                            text: (info.address ?? ""),
                            leftSpacing: 0,
                            fontSize: UIData.fontSize14,
                            bottomSpacing:
                                ScreenUtil.getInstance().setHeight(4),
                            topSpacing: ScreenUtil.getInstance().setHeight(4),
                          ),
                        ],
                      ),
                      children: [
                        Visibility(
                          visible: !isSaved(info),
                          child: Container(
                            color: UIData.primaryColor,
                            padding: EdgeInsets.only(
                                left: UIData.spaceSize16,
                                right: UIData.spaceSize16,
                                top: UIData.spaceSize4,
                                bottom: UIData.spaceSize12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                CommonFullScaleDivider(),
                                SizedBox(
                                  height: UIData.spaceSize12,
                                ),
                                CommonText.darkGrey15Text('可选时间段：'),
                                SizedBox(
                                  height: UIData.spaceSize3 * 2,
                                ),
                                Wrap(
                                  alignment: WrapAlignment.start,
                                  runAlignment: WrapAlignment.start,
                                  spacing: UIData.spaceSize10,
                                  runSpacing: UIData.spaceSize3 * 2,
                                  children:
                                      getSpcWidgetList(info.selectTimeList),
                                ),
                                SizedBox(
                                  height: UIData.spaceSize3 * 2,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    CommonText.orange12Text(
                                        '已选${getCheckedTimeCount(info.selectTimeList)}小时'),
                                    FlatButton(
                                      onPressed: () {
                                        Navigate.toNewPage(
                                            ReservationSavePage(
                                              widget._model,
                                              info,
                                              orderDate: surrenderTime,
                                            ), callBack: (int requestCode) {
                                          if (requestCode == null &&
                                              !(requestCode is int)) {
                                            return;
                                          }
                                          if (widget._model.result_fail ==
                                              requestCode) {
                                          } else if (widget._model.result_ok ==
                                              requestCode) {
                                            Navigate.closePage();
                                          }
                                        });
                                      },
                                      child:
                                          CommonText.lighterRed12Text('立即预定'),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                          visible: isSaved(info),
                          child: Container(
                            color: UIData.primaryColor,
                            padding: EdgeInsets.symmetric(
                                horizontal: UIData.spaceSize16,
                                vertical: UIData.spaceSize12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                CommonText.lightGrey14Text('已保存'),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }
              }),
          onRefresh: refresh);
    });
  }

//刷新操作
  _refresh() {
    param['orderDate'] = surrenderTime;
    widget._model
        .canBookHandleRefresh(param, expandStateList, preRefresh: true);
  }

  Future refresh() async {
    param['orderDate'] = surrenderTime;
    widget._model.canBookHandleRefresh(param, expandStateList);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CommonScaffold(
      appTitle: '继续预定',
      bodyData: Container(
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                CommonPicker.datePickerModal(context, onConfirm: (String date) {
                  if (date != null)
                    setState(() {
                      surrenderTime = date;
                      _refresh();
                    });
                });
              },
              child: Container(
                width: double.infinity,
                color: UIData.primaryColor,
                margin: EdgeInsets.only(top: UIData.spaceSize1),
                padding: EdgeInsets.all(UIData.spaceSize12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CommonText.text15('预约日期：$surrenderTime',
                        textAlign: TextAlign.center,
                        color: UIData.darkGreyColor),
                    Icon(
                      Icons.arrow_drop_down,
                      color: UIData.greyColor,
                      size: UIData.fontSize18,
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: ScopedModel<ReservationModel>(
                  model: widget._model, child: _buildContent()),
            )
          ],
        ),
      ),
    );
  }

  int getCheckedTimeCount(List<Time> myList) {
    int count = 0;
    if (myList != null)
      myList.forEach((Time map) {
        if (map.selected ?? false) {
          count++;
        }
      });
    return count;
  }

  List<Widget> getSpcWidgetList(List<Time> myList) {
    List<Widget> widgetList = new List();
    if (myList != null)
      for (int i = 0; i < myList.length; i++) {
        widgetList.add(ChoiceChip(
          label: Text("${myList[i].beginTime}-${myList[i].endTime}"),
          selected: myList[i].selected ?? false,
          selectedColor: UIData.themeBgColor,
          backgroundColor: Color(0xFFEFEFEF),
          labelStyle: (myList[i].selected ?? false)
              ? TextStyle(
                  color: UIData.primaryColor,
                  fontSize: UIData.fontSize14,
                )
              : TextStyle(
                  color: UIData.lightGreyColor,
                  fontSize: UIData.fontSize14,
                ),
          onSelected: (bool value) {
            setState(() {
              (myList[i].selected ?? false)
                  ? myList[i].selected = false
                  : myList[i].selected = true;
            });
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  UIData.spaceSize12 + UIData.spaceSize3)),
        ));
      }

    return widgetList;
  }

  bool isSaved(MeetingRoomInfo info) {
    bool isSaved = false;
    if (widget._model.saveInfoList != null) {
      for (int i = 0; i < widget._model.saveInfoList.length; i++) {
        if (widget._model.saveInfoList[i].roomId == info.roomId &&
            widget._model.saveInfoList[i].orderDate == surrenderTime) {
          isSaved = true;
          return isSaved;
        }
      }
    }
    return isSaved;
  }
}
