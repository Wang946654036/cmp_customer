import 'package:cmp_customer/models/new_house_model.dart';
import 'package:cmp_customer/models/property_change_user_param.dart';
import 'package:cmp_customer/scoped_models/new_house_state_model.dart';
import 'package:cmp_customer/ui/common/common_list_loading.dart';
import 'package:cmp_customer/ui/common/common_list_refresh.dart';
import 'package:cmp_customer/ui/common/common_loadmore.dart';
import 'package:cmp_customer/ui/common/common_shadow_container.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/decorate_manager/decoration_ui.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:cmp_customer/utils/navigate.dart';

import '../../main.dart';
import 'new_house_detail_page.dart';

///
/// Created by qianlx on 2020/3/28 12:33 PM.
/// 新房入伙列表界面
///
class NewHouseListPage extends StatefulWidget {
  final NewHouseStateModel model;
  Function callback;

  NewHouseListPage(this.model, {this.callback});

  @override
  _NewHouseListPageState createState() => _NewHouseListPageState();
}

class _NewHouseListPageState extends State<NewHouseListPage> {
  ScrollController _loadMoreScrollController = new ScrollController();

  PropertyChangeUserParam param = new PropertyChangeUserParam(operationCust: stateModel.customerId);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    initLoading=true;

    _loadMoreScrollController.addListener(() {
      if (_loadMoreScrollController.position.pixels == _loadMoreScrollController.position.maxScrollExtent) {
        if (widget.model.newHouseInfoState != ListState.HINT_LOADING) {
          if (widget.callback != null) {
            widget.callback(param);
          }
          widget.model.quoteRecordHandleLoadMore(param);
        }
      }
    });
    //初始化请求数据

//    //获取列表数据
    if (widget.callback != null) {
      widget.callback(param);
    }
    widget.model.loadHistoryList(param);
  }

  @override
  void dispose() {
    super.dispose();
    if (_loadMoreScrollController != null) _loadMoreScrollController.dispose();
  }

  //刷新操作
  Future _refresh() async {
    if (widget.callback != null) {
      widget.callback(param);
    }
    widget.model.historyHandleRefresh(param, preRefresh: true);
  }

  refresh() {
    if (widget.callback != null) {
      widget.callback(param);
    }
    widget.model.historyHandleRefresh(param, preRefresh: true);
  }

  //创建控件
  Widget _buildContent() {
    return ScopedModelDescendant<NewHouseStateModel>(
      builder: (context, child, model) {
        switch (widget.model.newHouseInfoListState) {
          case ListState.HINT_LOADING:
            return CommonListLoading();
            break;
          case ListState.HINT_NO_DATA_CLICK:
            return CommonListRefresh(state: ListState.HINT_NO_DATA_CLICK, callBack: _refresh);
            break;
          case ListState.HINT_LOADED_FAILED_CLICK:
            return CommonListRefresh(state: ListState.HINT_LOADED_FAILED_CLICK, callBack: _refresh);
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
    return ScopedModelDescendant<NewHouseStateModel>(builder: (context, child, model) {
      return RefreshIndicator(
          child: ListView.builder(
//            shrinkWrap: true,
              controller: _loadMoreScrollController,
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: (model.newHouseInfoList?.length ?? 0) + 1,
              itemBuilder: (BuildContext context, int index) {
                if (model.newHouseInfoList.length == index) {
                  return CommonLoadMore(model.maxCount);
                } else {
                  NewHouseDetail info = model.newHouseInfoList[index];
                  return GestureDetector(
                      onTap: () {
                        Navigate.toNewPage(NewHouseDetailPage(widget.model, info.houseJoinId),callBack: (flag){if(flag!=null&&flag is bool&&flag){
                          refresh();
                        }});
                      },
                      child: CommonShadowContainer(
                        margin: EdgeInsets.only(
                            top: UIData.spaceSize12, left: UIData.spaceSize16, right: UIData.spaceSize16),
                        backgroundColor: Colors.white,
                        child: new Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: UIData.spaceSize12),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: leftTextWidget(
                                      text: "客户姓名：${info?.custName ?? ""}",
//                                      isBold: true,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      right: UIData.spaceSize16,
                                    ),
                                    child: CommonText.text12(info?.processStatusName ?? '',
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
                              text: ("业务单号：${info?.businessNo ?? ""}"),
                              topSpacing: ScreenUtil.getInstance().setHeight(4),
                            ),
                            leftTextWidget(
                              fontSize: UIData.fontSize11,
                              color: UIData.lightGreyColor,
                              text: "办理时间：${info?.createTime ?? ""}",
                              topSpacing: ScreenUtil.getInstance().setHeight(4),
                              bottomSpacing: UIData.spaceSize12,
                            ),
                          ],
                        ),
                      ));
                }
              }),
          onRefresh: _refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModel<NewHouseStateModel>(model: widget.model, child: _buildContent());
  }
}
