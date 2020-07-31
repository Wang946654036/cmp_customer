import 'package:cmp_customer/main.dart';
///业务办理列表
///
///
import 'package:cmp_customer/models/decoration_obj_list.dart';
import 'package:cmp_customer/models/property_change_user_param.dart';
import 'package:cmp_customer/models/response/entrance_card_details_response.dart';
import 'package:cmp_customer/scoped_models/decoration_model.dart';
import 'package:cmp_customer/ui/common/common_list_loading.dart';
import 'package:cmp_customer/ui/common/common_list_refresh.dart';
import 'package:cmp_customer/ui/common/common_loadmore.dart';
import 'package:cmp_customer/ui/common/common_shadow_container.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../decoration_ui.dart';
import 'decoration_apply_detail.dart';
import 'decoration_apply_detail_page.dart';

//租客申请
class DecorationHistoryListZKPage extends StatefulWidget {
  DecorationModel _model;
  Function callback;

  DecorationHistoryListZKPage(this._model, this.callback);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DecorationHistoryListState();
  }
}

class DecorationHistoryListState extends State<DecorationHistoryListZKPage> {
  ScrollController _loadMoreScrollController = new ScrollController();

////  bool initLoading;//初始化加载标志
//  List<EntranceCardDetailsInfo> historyList;
  PropertyChangeUserParam param ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    initLoading=true;

    _loadMoreScrollController.addListener(() {
      if (_loadMoreScrollController.position.pixels ==
          _loadMoreScrollController.position.maxScrollExtent) {
        if (widget._model.decorationInfoListStateZK !=
            ListState.HINT_LOADING) {
          if (widget.callback != null) {
            widget.callback(param);
          }
          widget._model.quoteRecordHandleLoadMoreZK(param);
        }
      }
    });
    //初始化请求数据

//    //初始化筛选数据
    widget._model.initScreenData();
//    //获取列表数据
    if (widget.callback != null) {
      widget.callback(param);
    }
    widget._model.loadHistoryListZK(param);
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
    widget._model.historyHandleRefreshZK(param, preRefresh: true);
  }

  Future<void> refresh() async
  {
    if (widget.callback != null) {
      widget.callback(param);
    }
    widget._model.historyHandleRefreshZK(param, preRefresh: true);
  }
  //创建控件
  Widget _buildContent() {
    return ScopedModelDescendant<DecorationModel>(
      builder: (context, child, model) {
        switch (widget._model.decorationInfoListStateZK) {
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
    return ScopedModelDescendant<DecorationModel>(
        builder: (context, child, model) {
          return RefreshIndicator(
              child: ListView.builder(
//            shrinkWrap: true,
                  controller: _loadMoreScrollController,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: (model.decorationInfoListZK?.length ?? 0) + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (model.decorationInfoListZK.length == index) {
                      return CommonLoadMore(model.maxCountZK);
                    } else {
                      DecorationRecord info = model.decorationInfoListZK[index];
                      return GestureDetector(
                          onTap: () {
                            Navigate.toNewPage(DecorationApplyDetailPage(
                                widget._model, info.id,isCheckZK: true,),callBack: (flag){
                              if(flag!=null&& flag is bool && flag){
                                _refresh();
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
                                  margin: EdgeInsets.only(
                                      top: UIData.spaceSize12),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: leftTextWidget(
                                          text:
                                          (info.houseName ?? ''),
                                          isBold: true,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          right: UIData.spaceSize16,
                                        ),
                                        child: CommonText.text12(
                                            (getStateStr(info.state)),
                                            textAlign: TextAlign.right),
                                      )
                                    ],
                                  ),
                                ),
//                                leftTextWidget(
//                                    text: info.createTime ??
//                                        "",
//                                    color: UIData.lightGreyColor,
//                                    fontSize: UIData.fontSize14
//                                ),

                                leftTextWidget(
                                  text: "申请人：${info.custName ?? ""}",
                                  topSpacing: ScreenUtil.getInstance().setHeight(4),
                                ),
                                leftTextWidget(
                                  text:("联系方式：${info.custPhone ?? ""}"),
                                  topSpacing: ScreenUtil.getInstance().setHeight(4),
                                ),
                                leftTextWidget(
                                  text:("业务单号：${info.oddNumber ?? ""}" ),
                                  topSpacing: ScreenUtil.getInstance().setHeight(4),
                                ),
                                leftTextWidget(
                                  fontSize: UIData.fontSize11,
                                  color: UIData.lightGreyColor,
                                  text:
                                  "办理时间：${info.applyDate ??
                                      ""}" ,
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
    return ScopedModel<DecorationModel>(
        model: widget._model, child: _buildContent());
  }
}

_search(text) {
  print(text);
  LogUtils.printLog(text);
}
