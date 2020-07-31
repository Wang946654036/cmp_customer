///侧滑菜单
///
///

import 'package:cmp_customer/scoped_models/decoration_model.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/decorate_manager/decoration_ui.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:cmp_customer/models/property_change_user_param.dart';

//筛选布局
class DecorationHistoryScreenPage extends StatefulWidget {
//  get entranceState => null;
  Function callback;
  DecorationModel model;

  DecorationHistoryScreenPage(this.model, {this.callback});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DecorationHistoryScreenPageScreen();
  }
}

//停车页面筛选布局
class DecorationHistoryScreenPageScreen
    extends State<DecorationHistoryScreenPage> {
//   GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  DecorationModel model;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model = widget.model;
    if (model == null) {
      model = DecorationModel();
    }
    model.initScreenData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return ScopedModel<DecorationModel>(
        model: model,
        child: ScopedModelDescendant<DecorationModel>(
            builder: (context, child, model) {
          return CommonScaffold(
            showLeftButton: false,
//          showAppBar: false,
            appTitle: Container(
              margin: EdgeInsets.only(left: UIData.spaceSize16),
              child: CommonText.darkGrey15Text(applyState),
            ),
            backGroundColor: UIData.primaryColor,
            bodyData: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: UIData.spaceSize16),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: ellipseBotton(
                          model.applyStateList[0].stateName,
                          model.applyStateList[0].selected,
                          onChanged: (value) {
                            model.setApplyState(0, value);
                          },
                        ),
                      ),
                      Expanded(
                        child: ellipseBotton(
                          model.applyStateList[1].stateName,
                          model.applyStateList[1].selected,
                          onChanged: (value) {
                            model.setApplyState(1, value);
                          },
                        ),
                      ),
                      Expanded(
                        child: ellipseBotton(
                          model.applyStateList[2].stateName,
                          model.applyStateList[2].selected,
                          onChanged: (value) {
                            model.setApplyState(2, value);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: UIData.spaceSize16, top: UIData.spaceSize12),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: ellipseBotton(
                          model.applyStateList[3].stateName,
                          model.applyStateList[3].selected,
                          onChanged: (value) {
                            model.setApplyState(3, value);
                          },
                        ),
                      ),
                      Expanded(
                        child: ellipseBotton(
                          model.applyStateList[4].stateName,
                          model.applyStateList[4].selected,
                          onChanged: (value) {
                            model.setApplyState(4, value);
                          },
                        ),
                      ),
                      Expanded(
                        child: ellipseBotton(
                          model.applyStateList[5].stateName,
                          model.applyStateList[5].selected,
                          onChanged: (value) {
                            model.setApplyState(5, value);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: UIData.spaceSize16, top: UIData.spaceSize12),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: ellipseBotton(
                          model.applyStateList[6].stateName,
                          model.applyStateList[6].selected,
                          onChanged: (value) {
                            model.setApplyState(6, value);
                          },
                        ),
                      ),
                      Expanded(
                        child: ellipseBotton(
                          model.applyStateList[7].stateName,
                          model.applyStateList[7].selected,
                          onChanged: (value) {
                            model.setApplyState(7, value);
                          },
                        ),
                      ),
                      Expanded(
                        child: ellipseBotton(
                          model.applyStateList[8].stateName,
                          model.applyStateList[8].selected,
                          onChanged: (value) {
                            model.setApplyState(8, value);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: UIData.spaceSize16, top: UIData.spaceSize12),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: ellipseBotton(
                          model.applyStateList[9].stateName,
                          model.applyStateList[9].selected,
                          onChanged: (value) {
                            model.setApplyState(9, value);
                          },
                        ),
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                    ],
                  ),
                ),
                leftTextWidget(
                  text: applyTime,
                  topSpacing: UIData.spaceSize12,
                  leftSpacing: UIData.spaceSize16,
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: UIData.spaceSize16,
                    top: UIData.spaceSize12,
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: ellipseBotton(
                          model.applyTimeList[0].timeName,
                          model.applyTimeList[0].selected,
                          onChanged: (value) {
                            model.setApplyTime(0, value);
                          },
                        ),
                      ),
                      Expanded(
                        child: ellipseBotton(
                          model.applyTimeList[1].timeName,
                          model.applyTimeList[1].selected,
                          onChanged: (value) {
                            model.setApplyTime(1, value);
                          },
                        ),
                      ),
                      Expanded(
                        child: ellipseBotton(
                          model.applyTimeList[2].timeName,
                          model.applyTimeList[2].selected,
                          onChanged: (value) {
                            model.setApplyTime(2, value);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
//        appBarActions: <Widget>[],
            bottomNavigationBar: StadiumSolidWithTowButton(
              cancelText: "重置",
              onCancel: () {
                model.reset();
              },
              conFirmText: "确定",
              onConFirm: () {
                PropertyChangeUserParam param = new PropertyChangeUserParam(
                    startTime: model.selectedTimeIndex >= 0
                        ? (model.applyTimeList[model.selectedTimeIndex].time)
                        : (model.selectedStartDate),
                    status: model.selectedStateIndex != -1
                        ? (model
                            .applyStateList[model.selectedStateIndex].stateCode)
                        : null,
                    endTime: model.selectedEndDate);
                if (widget.callback != null) {
                  widget.callback(param);
                } else {
                  model.historyHandleRefresh(param, preRefresh: true);
                  model.historyHandleRefreshZK(param, preRefresh: true);
                }
                Navigator.of(context).pop();
              },
              padding: EdgeInsets.symmetric(
                  horizontal: UIData.spaceSize30, vertical: UIData.spaceSize10),
            ),
//                  endDrawerWidget: SelectMultipleProjectPage(
//                      callback: (list) {
//                        model.setWarpList(list);
//                      },
//                      selectedIdList: model.getSelectedIdList())
          );
          ;
        }));
  }
}
