
import 'package:cmp_customer/models/property_change_user_param.dart';
import 'package:cmp_customer/models/visitor_release_detail_model.dart';
import 'package:cmp_customer/scoped_models/visitor_release_state_model.dart';
import 'package:cmp_customer/ui/common/common_list_loading.dart';
import 'package:cmp_customer/ui/common/common_list_refresh.dart';
import 'package:cmp_customer/ui/common/common_loadmore.dart';
import 'package:cmp_customer/ui/common/common_shadow_container.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/decorate_manager/decoration_ui.dart';
import 'package:cmp_customer/ui/visitor_release/visitor_release_check.dart';
import 'package:cmp_customer/ui/visitor_release/visitor_release_detail.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:cmp_customer/utils/navigate.dart';

import '../../main.dart';

///
/// Created by yyy
/// 列表界面
///
class VisitorReleaseListPage extends StatefulWidget {
  final VisitorReleaseStateModel model;
  Function callback;

  VisitorReleaseListPage(this.model, {this.callback});

  @override
  _VisitorReleaseListPageState createState() => _VisitorReleaseListPageState();
}

class _VisitorReleaseListPageState extends State<VisitorReleaseListPage> {
  ScrollController _loadMoreScrollController = new ScrollController();

  PropertyChangeUserParam param = new PropertyChangeUserParam(operationCust: stateModel.customerId);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    initLoading=true;

    _loadMoreScrollController.addListener(() {
      if (_loadMoreScrollController.position.pixels == _loadMoreScrollController.position.maxScrollExtent) {
        if (widget.model.visitorReleaseInfoListState != ListState.HINT_LOADING) {
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
    return ScopedModelDescendant<VisitorReleaseStateModel>(
      builder: (context, child, model) {
        switch (widget.model.visitorReleaseInfoListState) {
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
    return ScopedModelDescendant<VisitorReleaseStateModel>(builder: (context, child, model) {
      return RefreshIndicator(
          child: ListView.builder(
//            shrinkWrap: true,
              controller: _loadMoreScrollController,
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: (model.visitorReleaseInfoList?.length ?? 0) + 1,
              itemBuilder: (BuildContext context, int index) {
                if (model.visitorReleaseInfoList.length == index) {
                  return CommonLoadMore(model.maxCount);
                } else {
                  VisitorReleaseDetail info = model.visitorReleaseInfoList[index];
                  return GestureDetector(
                      onTap: () {
                        Navigate.toNewPage(VisitorReleaseDetailPage(widget.model, info.appointmentVisitId),callBack: (flag){if(flag!=null&&flag is bool&&flag){
                          refresh();
                        }});
//                        Navigate.toNewPage(VisitorReleaseCheckPage(widget.model, 67),callBack: (flag){if(flag!=null&&flag is bool&&flag){
//                          refresh();
//                        }});
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
                                      text: "到访日期：${info?.visitDate ?? ""}",
//                                      isBold: true,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      right: UIData.spaceSize16,
                                    ),
                                    child: CommonText.text12(info?.stateName ?? '',
                                        textAlign: TextAlign.right,color: UIData.yellowColor),
                                  )
                                ],
                              ),
                            ),


                            leftTextWidget(
                              text: ("访客：${info?.visitorName ?? ""}/${info?.visitorPhone ?? ""}"),
                              topSpacing: ScreenUtil.getInstance().setHeight(4),
                            ),
                            leftTextWidget(
                              fontSize: UIData.fontSize11,
                              color: UIData.lightGreyColor,
                              text: "预约提交时间：${info?.createTime ?? ""}",
                              topSpacing: ScreenUtil.getInstance().setHeight(4),

                            ),
                            Container(
                              margin: EdgeInsets.only(
                                top: UIData.spaceSize6,
                                bottom: UIData.spaceSize12,
                                left: UIData.spaceSize16,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    height: UIData.spaceSize14,
                                    width: UIData.spaceSize14,
                                    child: Image.asset(UIData.imageLocation),
                                  ),
                                  SizedBox(
                                    width: UIData.spaceSize4,
                                  ),
                                  Expanded(child: CommonText.grey14Text(
                                      '${info?.projectFormerName ?? ''}${info?.buildName ?? ''}${info?.unitName ?? ''}${info?.houseName ?? ''}'),)
                                  ,
                                ],
                              ),
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
    return ScopedModel<VisitorReleaseStateModel>(model: widget.model, child: _buildContent());
  }
}
