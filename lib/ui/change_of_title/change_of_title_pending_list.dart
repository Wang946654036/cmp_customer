import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/change_title_obj.dart';
import 'package:cmp_customer/models/property_change_user_param.dart';
import 'package:cmp_customer/models/response/entrance_card_details_response.dart';
import 'package:cmp_customer/scoped_models/change_of_title_model.dart';
import 'package:cmp_customer/ui/change_of_title/change_of_title_detail.dart';
import 'package:cmp_customer/ui/change_of_title/change_of_title_ui.dart';
import 'package:cmp_customer/ui/common/common_list_loading.dart';
import 'package:cmp_customer/ui/common/common_list_refresh.dart';
import 'package:cmp_customer/ui/common/common_loadmore.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_shadow_container.dart';
import 'package:cmp_customer/ui/common/common_text.dart';

//import 'package:cmp_customer/ui/entrance/page_query_type.dart';
import 'package:cmp_customer/ui/parking/parking_card_ui.dart';

//import 'package:cmp_customer/ui/parking/parking_card_ui_label.dart';
//import 'package:cmp_customer/ui/parking/parking_card_ui_widget.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//产权变更列表页面
class ChangeOfTitleListPage extends StatefulWidget {
  ChangeOfTitleModel _model;

//  PageQueryType type;
  Function callback;

  ChangeOfTitleListPage(
      this._model,
//      this.type,
      this.callback);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ChangeOfTitleListState();
  }
}

class ChangeOfTitleListState extends State<ChangeOfTitleListPage> {
  ScrollController _loadMoreScrollController = new ScrollController();

//  bool initLoading;//初始化加载标志
  List<EntranceCardDetailsInfo> historyList;
  PropertyChangeUserParam param = new PropertyChangeUserParam();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    initLoading=true;
//    param.queryType=getQueryTypeCode(widget.type);

    _loadMoreScrollController.addListener(() {
      if (_loadMoreScrollController.position.pixels ==
          _loadMoreScrollController.position.maxScrollExtent) {
        if (widget._model.changeOfTitleInfoListState !=
            ListState.HINT_LOADING) {
          if (widget.callback != null) {
            widget.callback(param);
          }
          widget._model.quoteRecordHandleLoadMore(param);
        }
      }
    });
    //初始化请求数据
    param.custId = stateModel.customerId;
//    //初始化筛选数据
//    _model.initScreenData();
//    //获取列表数据
    if (widget.callback != null) {
      widget.callback(param);
    }

    widget._model.loadHistoryList(param);
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
    widget._model.historyHandleRefresh(param, preRefresh: true);
  }

  //创建控件
  Widget _buildContent() {
    return ScopedModelDescendant<ChangeOfTitleModel>(
      builder: (context, child, model) {
        switch (widget._model.changeOfTitleInfoListState) {
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
    return ScopedModelDescendant<ChangeOfTitleModel>(
        builder: (context, child, model) {
      return RefreshIndicator(
          child: ListView.builder(
//            shrinkWrap: true,
              controller: _loadMoreScrollController,
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: (model.changeTitleInfoList?.length ?? 0) + 1,
              itemBuilder: (BuildContext context, int index) {
                if (model.changeTitleInfoList.length == index) {
                  return CommonLoadMore(model.maxCount);
                } else {
                  ChangeTitleInfo info = model.changeTitleInfoList[index];
                  return GestureDetector(
                      onTap: () {
                        Navigate.toNewPage(ChangeOfTitleDetail(
                            widget._model,
//                                    widget.type,
                            info.propertyChangeId),callBack: (flag){

                          if(flag!=null&&flag is bool &&flag){
                            _refresh();
                          }

                        });
                      },
                      child: CommonShadowContainer(
                        margin: EdgeInsets.only(
                            top: card_spacing,
                            left: left_spacing,
                            right: right_spacing),
                        backgroundColor: Colors.white,
                        child: new Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                  top: top_spacing, left: left_spacing),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Expanded(
                                    child: CommonText.black16Text(
                                        (info.formerName ?? '') +

                                            (info.buildName ?? '') +

                                            (info.unitName ?? '') +

                                            (info.houseNo ?? ''),
                                        textAlign: TextAlign.left),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      right: right_spacing,
                                    ),
                                    child: CommonText.text12(
                                        (getStateStr(info.status)),
                                        textAlign: TextAlign.right),
                                  )
                                ],
                              ),
                            ),
                            leftTextWidget(
                              fontSize: UIData.fontSize11,
                              color: UIData.lightGreyColor,
                              text:
                                  label_apply_deal_no + "：" + info.businessNo ??
                                      "",
                              topSpacing: ScreenUtil.getInstance().setHeight(4),
                            ),
                            leftTextWidget(
                              fontSize: UIData.fontSize11,
                              color: UIData.lightGreyColor,
                              text: label_apply_deal_time +
                                      "：" +
                                      info.createTime ??
                                  "",
                              topSpacing: ScreenUtil.getInstance().setHeight(4),
                            ),
                            leftTextWidget(
                              text: "受让方：" + info.assigneeRealname ??
                                  "" + '-' + info.assigneePhone ??
                                  "",
                              topSpacing: ScreenUtil.getInstance().setHeight(4),
                              bottomSpacing: vertical_spacing,
                            ),
                          ],
                        ),
                      ));
                }
              }),
          onRefresh: () {
            if (widget.callback != null) {
              widget.callback(param);
            }
            model.historyHandleRefresh(param, preRefresh: true);
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModel<ChangeOfTitleModel>(
        model: widget._model,
        child: CommonScaffold(appTitle: "历史列表", bodyData: _buildContent()));
  }
}

_search(text) {
  print(text);
  LogUtils.printLog(text);
}
