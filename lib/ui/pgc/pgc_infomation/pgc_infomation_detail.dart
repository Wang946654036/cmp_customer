import 'dart:async';
import 'dart:io';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/common/common_share_model.dart';
import 'package:cmp_customer/models/pgc/pgc_comment_obj.dart';
import 'package:cmp_customer/models/pgc/pgc_infomation_obj.dart';
import 'package:cmp_customer/scoped_models/pgc_model/pgc_infomation_model.dart';
import 'package:cmp_customer/ui/common/common_bottom_input_view/bottom_input_view.dart';
import 'package:cmp_customer/ui/common/common_bottom_input_view/pop_route.dart';
import 'package:cmp_customer/ui/common/common_dialog.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_loadmore.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/common/popover/cupertino_popover.dart';
import 'package:cmp_customer/ui/common/popover/cupertino_popover_menu_item.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/share_util.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fai_webview/flutter_fai_webview.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:scoped_model/scoped_model.dart';

import '../pgc_ui.dart';

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    if (Platform.isAndroid || Platform.isFuchsia || Platform.isIOS) {
      return child;
    } else {
      return super.buildViewportChrome(context, child, axisDirection);
    }
  }
}

class PgcInfomationDetail extends StatefulWidget {
  final PgcInfomationInfo info;
  final Function refreshCallback;
  final bool canEdit; //是否能编辑

  PgcInfomationDetail(this.info, {this.refreshCallback, this.canEdit = true});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _pgcInfomationDetailState();
  }
}

class _pgcInfomationDetailState extends State<PgcInfomationDetail> {
  ScrollController _loadMoreScrollController = new ScrollController();
  TextEditingController controller = TextEditingController();
  PgcInfomationDetailModel _model;
  String searchType = '2';
  bool hasSelected = false;
  bool hasDianzan = false;
  GlobalKey globalKey = GlobalKey();
  GlobalKey globalKey2 = GlobalKey();
  GlobalKey globalKey3 = GlobalKey();
  GlobalKey globalKey4 = GlobalKey();
  GlobalKey globalKey5 = GlobalKey();
  FaiWebViewWidget webViewWidget;

  //原生 发送给 Flutter 的消息
  String message = "--";
  String htmlUrl = HttpOptions.baseUrl + HttpOptions.getPgcContent;
  double webViewHeight = 1;
  double scrollTopFlag = -1;

  // 标记是否是加载中
  bool loading = true;
  bool isNormalScroll = true;
  bool needScrollControll = false;

  double _getWH() {
    if (!widget.canEdit) return 1;
    final containerWidth = globalKey.currentContext.size.width;
    final containerHeight = globalKey.currentContext.size.height;
    print('Container widht is $containerWidth, height is $containerHeight');
    return containerHeight;
  }

  double _getWH2() {
    final containerWidth = globalKey2.currentContext.size.width;
    final containerHeight = globalKey2.currentContext.size.height;
    print('Container2 widht is $containerWidth, height is $containerHeight');
    return containerHeight;
  }

  double _getWH3() {
    final containerWidth = globalKey3.currentContext.size.width;
    final containerHeight = globalKey3.currentContext.size.height;
    print('Container3 widht is $containerWidth, height is $containerHeight');
    return containerHeight;
  }

  double _getWH4() {
    final containerWidth = globalKey4.currentContext.size.width;
    final containerHeight = globalKey4.currentContext.size.height;
    print('Container4 widht is $containerWidth, height is $containerHeight');
    return containerHeight;
  }

  double _getWH5() {
    final containerWidth = globalKey5.currentContext.size.width;
    final containerHeight = globalKey5.currentContext.size.height;
    print('Container5 widht is $containerWidth, height is $containerHeight');
    return containerHeight;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hasDianzan = (widget.info?.custLike ?? '0') == '0' ? false : true;
    hasSelected = (widget.info?.custCollect ?? '0') == '0' ? false : true;
    _model = PgcInfomationDetailModel();
    //使用插件 FaiWebViewWidget
    LogUtils.printLog("$htmlUrl${widget.info?.pgcId ?? ''}");
    webViewWidget = FaiWebViewWidget(
      //webview 加载网页链接
      url: "$htmlUrl${widget.info?.pgcId ?? ''}",

      //webview 加载信息回调
      callback: callBack,
      //输出日志
      isLog: true,
    );
    _refresh();
    _model.createCustomerOperation(
      {'type': '1', 'pgcId': widget.info?.pgcId},
    );
    _loadMoreScrollController.addListener(listener);
  }

  void removeListenerFormScroll() {
    _loadMoreScrollController.removeListener(listener);
    _loadMoreScrollController.animateTo(scrollTopFlag + 7,
        duration: new Duration(seconds: 1), curve: Curves.ease);

    setState(() {
      isNormalScroll = false;
      LogUtils.printLog('开始滚内部');
    });
  }

  void listener() {
    LogUtils.printLog('needScrollControll${needScrollControll}');
    LogUtils.printLog('scrollTopFlag${scrollTopFlag}');
    LogUtils.printLog(
        '_loadMoreScrollController.offset${_loadMoreScrollController.offset}');
    if (needScrollControll &&
        scrollTopFlag != -1 &&
        (_loadMoreScrollController.offset < scrollTopFlag + 5 &&
            _loadMoreScrollController.offset > scrollTopFlag / 5 * 3)) {
      removeListenerFormScroll();
    } else if (_loadMoreScrollController.position.pixels ==
        _loadMoreScrollController.position.maxScrollExtent) {
      if (_model.pgcInfomationDetailState != ListState.HINT_LOADING) {
        _model.pgcCommentInfoListHandleLoadMore(
            map: {'pgcId': widget.info.pgcId, 'sortName': searchType});
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
//    _onStateChanged.cancel();
//    flutterWebViewPlugin.dispose();
  }

  void callBack(int code, String msg, content1) {
    //加载页面完成后 对页面重新测量的回调
    //这里没有使用到
    //当FaiWebViewWidget 被嵌套在可滑动的 widget 中，必须设置 FaiWebViewWidget 的高度
    //设置 FaiWebViewWidget 的高度 可通过在 FaiWebViewWidget 嵌套一层 Container 或者 SizeBox
    if (code == 201) {
      //页面加载完成后 测量的 WebView 高度

      setState(() {
        if (scrollTopFlag == -1)
          scrollTopFlag = _getWH2() + _getWH3() + _getWH4();
        double content = 1;
        if (!(content is double))
          content = double.parse(content1?.toString() ?? 1);
        else
          content = content1;
        if (content +
                ScreenUtil.statusBarHeight +
                ScreenUtil.bottomBarHeight +
                35 +
                _getWH() <
            ScreenUtil.screenHeightDp) {
          webViewHeight = content + 10;
          needScrollControll = false;
        } else {
          needScrollControll = true;
          webViewHeight = ScreenUtil.screenHeightDp -
              ScreenUtil.statusBarHeight -
              ScreenUtil.bottomBarHeight -
              60-
              _getWH();
        }
      });
    } else if (code == 304) {
//滑到底部
      print('滑到底部');
      if (needScrollControll) {
        setState(() {
          isNormalScroll = true;
        });
        if (!_loadMoreScrollController.hasListeners)
          _loadMoreScrollController.addListener(listener);
        _loadMoreScrollController.animateTo(
            _getWH2() + _getWH3() + _getWH4() + _getWH() + 35,
            duration: new Duration(milliseconds: 300),
            curve: Curves.ease);
      }
    } else if (code == 301) {
      print('滑到顶部');
      _loadMoreScrollController.animateTo(0,
          duration: new Duration(seconds: 1), curve: Curves.ease);
      if (needScrollControll) {
        setState(() {
          isNormalScroll = true;
        });
        if (!_loadMoreScrollController.hasListeners) {
          Future.delayed(Duration(seconds: 1), () {
            _loadMoreScrollController.addListener(listener);
          });
        }
      }
    }
    setState(() {
      print('isNormalScroll:$isNormalScroll');
      print("webViewHeight: " + webViewHeight.toString());
      print("wh: " + _getWH().toString());
      print("wh5: " + _getWH5().toString());
      print("回调：code[" + code.toString() + "]; msg[" + msg.toString() + "]");
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModel<PgcInfomationDetailModel>(
        model: _model,
        child: ScopedModelDescendant<PgcInfomationDetailModel>(
            builder: (context, child, model) {
          hasDianzan =
              (model.pgcInfomation?.custLike ?? '0') == '0' ? false : true;
          hasSelected =
              (model.pgcInfomation?.custCollect ?? '0') == '0' ? false : true;
          return CommonScaffold(
              appTitle: '资讯详情',
              appBarActions: [
                CupertinoPopoverButton(
                    popoverWidth: UIData.spaceSize100,
                    popoverColor: UIData.greyColor,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: UIData.spaceSize12,
                          horizontal: UIData.spaceSize16),
                      alignment: Alignment.centerRight,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          CommonText.red15Text('更多'),
                        ],
                      ),
                    ),
                    popoverBuild: (context) {
                      return CupertinoPopoverMenuList(
                        children: <Widget>[
                          CupertinoPopoverMenuItemWithIcon(
                            leading: hasSelected
                                ? Icon(
                                    UIData.iconDataStartSelected,
                                    color: UIData.yellowColor,
                                  )
                                : Icon(
                                    UIData.iconDataStartUnselected,
                                    color: UIData.primaryColor,
                                  ),
                            child: CommonText.white14Text(
                                hasSelected ? "取消收藏" : '点击收藏'),
                            onTap: () {
                              model.createCustomerOperation({
                                'type': '4',
                                'collect': hasSelected ? '0' : '1',
                                'pgcId': widget.info?.pgcId
                              }, callback: () {
                                CommonToast.show(
                                    type: ToastIconType.SUCCESS,
                                    msg: hasSelected ? '已取消收藏' : '收藏成功');

                                if (hasSelected &&
                                    widget.refreshCallback != null) {
                                  //收藏页面进来的，取消收藏后，关闭页面，并刷新列表
                                  Navigate.closePage(true);
                                  widget.refreshCallback();
                                } else {
                                  setState(() {
                                    if (model.pgcInfomation != null) if ((model
                                                .pgcInfomation?.custCollect ??
                                            '0') ==
                                        '0') {
                                      model.pgcInfomation?.custCollect = '1';
                                    } else {
                                      model.pgcInfomation?.custCollect = '0';
                                    }
                                  });
                                }
                              });
                            },
                          ),
                          CupertinoPopoverMenuItemWithIcon(
                            leading: Icon(Icons.share),
                            child: CommonText.white14Text("一键分享"),
                            onTap: () {
                              String baseUrl = HttpOptions.baseUrl
                                  .replaceAll('ubms-customer/', '');
                              String picUrl = ShareUtil.showShareMenu(
                                  context,
                                  CommonShareModel(
                                    title: widget.info?.pgcTitle,
                                    thumbImageUrl: StringsHelper.isNotEmpty(
                                            widget.info?.titlePic)
                                        ? HttpOptions.showPhotoUrl(
                                            widget.info?.titlePic)
                                        : null,
                                    text: widget.info?.keyword ?? ' ',
                                    url: baseUrl +
                                        "template/appShare/pgcDetail.html?id=${widget.info?.pgcId}",
                                  ));
                            },
                          ),
                        ],
                      );
                    }),
              ],
              bottomNavigationBar: widget.canEdit
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          key: globalKey,
                          color: UIData.primaryColor,
                          padding: EdgeInsets.symmetric(
                              horizontal: UIData.spaceSize8),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: FlatButton(
                                  color: UIData.scaffoldBgColor,
                                  child: CommonText.grey14Text('请发表您的高见'),
                                  onPressed: () {
                                    if (2 == stateModel?.customerType &&
                                        stateModel.customerId != null &&
                                        stateModel.defaultProjectId != null &&
                                        stateModel.defaultHouseId != null) {
                                      getBottomSheet(context, '发表评论');
                                    } else {
                                      CommonDialog.showUncertifiedDialog(
                                          context);
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                width: UIData.spaceSize16,
                              ),
                              PgcIconTextView(
                                leading: hasDianzan
                                    ? UIData.iconDianzan2
                                    : UIData.iconDianzan,
                                child: CommonText.lightGrey14Text(getPGCNumb(
                                    (model.pgcInfomation?.likeCount ?? 0))),
                                canClick: true,
                                onTap: () {
                                  CommonToast.show(
                                      type: ToastIconType.SUCCESS,
                                      msg: hasDianzan ? '点赞-1' : '点赞+1');
                                  setState(() {
                                    if (model.pgcInfomation == null) {
                                      return;
                                    }
                                    if (model.pgcInfomation?.likeCount ==
                                        null) {
                                      model.pgcInfomation?.likeCount = 0;
                                    }

                                    model.pgcInfomation?.likeCount = hasDianzan
                                        ? (model.pgcInfomation?.likeCount - 1)
                                        : (model.pgcInfomation?.likeCount + 1);
                                    if (model.pgcInfomation?.likeCount < 0) {
                                      model.pgcInfomation?.likeCount = 0;
                                    }
                                    if ((model.pgcInfomation?.custLike ??
                                            '0') ==
                                        '0') {
                                      model.pgcInfomation?.custLike = '1';
                                    } else {
                                      model.pgcInfomation?.custLike = '0';
                                    }
                                  });
                                  model.createCustomerOperation({
                                    'type': '2',
                                    'like': hasDianzan ? '0' : '1',
                                    'pgcId': widget.info?.pgcId
                                  }, callback: () {});
                                },
                              ),
                              SizedBox(
                                width: UIData.spaceSize8,
                              ),
                              PgcIconTextView(
                                leading: UIData.iconPinlun,
                                child: CommonText.lightGrey14Text(getPGCNumb(
                                    model.pgcInfomation?.commentCount ??
                                        (widget.info?.commentCount ?? 0))),
                                canClick: true,
                                onTap: () {
                                  if (!_loadMoreScrollController.hasListeners) {
                                    Future.delayed(Duration(), () {
                                      _loadMoreScrollController
                                          .addListener(listener);
                                    });
                                  }
                                  setState(() {
                                    isNormalScroll = true;
                                  });
                                  if ((model.pgcCommentInfos?.length ?? 0) > 0)
                                    _loadMoreScrollController.animateTo(
                                        _getWH2() +
                                            _getWH3() +
                                            _getWH4() +35+
                                            webViewHeight,
                                        duration: new Duration(milliseconds: 300),
                                        curve: Curves.ease);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : null,
              bodyData: buildPGCInfomationDetail());
        }));
  }

  Widget buildPGCInfomationDetail() {
    return ScopedModelDescendant<PgcInfomationDetailModel>(
      builder: (context, child, model) {
//          _buildList();

        return CommonLoadContainer(
            state: _model.pgcInfomationDetailState,
            content: ScrollConfiguration(
                behavior: MyBehavior(), //自定义behavior
                child: SingleChildScrollView(
                  controller: _loadMoreScrollController,
                  physics: isNormalScroll
                      ? ClampingScrollPhysics()
                      : NeverScrollableScrollPhysics(),
                  child: Column(
                    children: <Widget>[
                      Container(
                          key: globalKey2,
                          color: UIData.primaryColor,
                          margin: EdgeInsets.only(top: UIData.spaceSize8),
                          padding: EdgeInsets.only(
                              left: UIData.spaceSize16,
                              right: UIData.spaceSize16,
                              top: UIData.spaceSize12),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: CommonText.darkGrey18Text(
                                    _model.pgcInfomation?.pgcTitle ??
                                        (widget.info?.pgcTitle ?? '')),
                              ),
                            ],
                          )),
                      Container(
                        key: globalKey3,
                        color: UIData.primaryColor,
                        padding: EdgeInsets.only(
                            left: UIData.spaceSize16,
                            right: UIData.spaceSize16,
                            top: UIData.spaceSize8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: CommonText.grey14Text(
                                  '${StringsHelper.isNotEmpty(_model.pgcInfomation?.publishTime) ? _model.pgcInfomation?.publishTime + '    ' : (StringsHelper.isNotEmpty(widget.info?.publishTime) ? widget.info?.publishTime + "    " : '')}\n${StringsHelper.isNotEmpty(_model.pgcInfomation?.author ?? (widget.info?.author ?? '')) ? '作者：${_model.pgcInfomation?.author ?? (widget.info?.author ?? '')}' : ''}    ${StringsHelper.isNotEmpty(_model.pgcInfomation?.source ?? (widget.info?.source ?? '')) ? '来源：${_model.pgcInfomation?.source ?? (widget.info?.source ?? '')}' : ''}'),
                            ),
                            PgcIconTextView(
                              leading: UIData.iconWenzhangliulanshu,
                              child: CommonText.lightGrey14Text(getPGCNumb(
                                  _model.pgcInfomation?.browseCount ??
                                      (widget.info?.browseCount ?? 0))),
                              canClick: false,
                            ),
                          ],
                        ),
                      ),
                      Container(
                          key: globalKey4,
                          color: UIData.primaryColor,
                          padding: EdgeInsets.symmetric(
                              horizontal: UIData.spaceSize16,
                              vertical: UIData.spaceSize8),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Wrap(
                                  alignment: WrapAlignment.start,
                                  runAlignment: WrapAlignment.start,
                                  spacing: UIData.spaceSize10,
                                  runSpacing: UIData.spaceSize3 * 2,
                                  children: getSpcWidgetList(
                                      types: _model.pgcInfomation?.keyword
                                              ?.split(',') ??
                                          (widget.info?.keyword?.split(',') ??
                                              [])),
                                ),
                              ),
                            ],
                          )),
                      Container(
                        height: webViewHeight,
                        child: webViewWidget,
                      ),
                      _buildList()
                    ],
                  ),
                )),
//            RefreshIndicator(
//              onRefresh: _refresh,
//              child:
//            ),
            callback: refresh);
      },
    );
  }

  Future<void> _refresh() async {
    searchType = '2';

    _model.pgcInfomationDetailHandleRefresh(
        map: {"pgcId": widget.info?.pgcId ?? ''},
        callBack: () {
          _model.pgcCommentInfoListHistoryHandleRefresh(map: {
            'pgcId': _model.pgcInfomation.pgcId,
            'sortName': searchType
          });
        });
  }

  refresh() {
    searchType = '2';

    _model.pgcInfomationDetailHandleRefresh(
        map: {"pgcId": widget.info?.pgcId ?? ''},
        callBack: () {
          _model.pgcCommentInfoListHistoryHandleRefresh(map: {
            'pgcId': _model.pgcInfomation.pgcId,
            'sortName': searchType
          });
        });
  }

  Widget _buildList() {
    return ScopedModelDescendant<PgcInfomationDetailModel>(
        builder: (context, child, model) {
      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: (model.pgcCommentInfos?.length ?? 0) + 2,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                      key: globalKey5,
                      color: UIData.primaryColor,
                      margin: EdgeInsets.only(top: UIData.spaceSize12),
                      padding: EdgeInsets.only(left: UIData.spaceSize16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          CommonText.grey16Text(
                              '${getPGCNumb(_model.pgcInfomation?.commentCount ?? (widget.info?.commentCount ?? 0))}条评论'),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: UIData.spaceSize12,
                                horizontal: UIData.spaceSize16),
                            child: CupertinoPopoverButton(
                                popoverWidth: UIData.spaceSize100,
                                popoverColor: UIData.greyColor,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      CommonText.grey14Text(
                                          searchType == '2' ? '按热度' : '按时间'),
                                      Icon(
                                        Icons.keyboard_arrow_down,
                                        size: UIData.spaceSize14,
                                        color: UIData.greyColor,
                                      ),
                                    ],
                                  ),
                                ),
                                popoverBuild: (context) {
                                  return CupertinoPopoverMenuList(
                                    children: <Widget>[
                                      CupertinoPopoverMenuItem(
                                        child: CommonText.white14Text("按时间"),
                                        onTap: () {
                                          setState(() {
                                            searchType = '1';
                                            _model
                                                .pgcCommentInfoListHistoryHandleRefresh(
                                                    map: {
                                                  'pgcId': widget.info.pgcId,
                                                  'sortName': searchType
                                                });
                                          });
                                        },
                                      ),
                                      CupertinoPopoverMenuItem(
                                        child: CommonText.white14Text("按热度"),
                                        onTap: () {
                                          setState(() {
                                            searchType = '2';
                                            _model
                                                .pgcCommentInfoListHistoryHandleRefresh(
                                                    map: {
                                                  'pgcId': widget.info.pgcId,
                                                  'sortName': searchType
                                                });
                                          });
                                        },
                                      ),
                                    ],
                                  );
                                }),
                          )
                        ],
                      )),
                ],
              ),
            );
          } else if ((model.pgcCommentInfos?.length ?? 0) == index - 1) {
            if (model.pgcCommentInfoListState == ListState.HINT_NO_DATA_CLICK) {
              return CommonLoadMoreForPgc();
            } else if (model.pgcCommentInfoListState ==
                ListState.HINT_LOADING) {
              return CommonLoadMore(model.historyMaxCount);
              ;
            } else if (model.pgcCommentInfoListState ==
                ListState.HINT_LOADED_FAILED_CLICK) {
              return FlatButton(
                child: Container(
                  child: CommonLoadMoreForPgc(tips: '获取失败，点击刷新'),
                  padding: EdgeInsets.only(bottom: UIData.spaceSize16),
                ),
                onPressed: () {
                  _model.pgcCommentInfoListHistoryHandleRefresh(map: {
                    'pgcId': widget.info.pgcId,
                    'sortName': searchType
                  });
                },
              );
            } else {
              if (model.historyMaxCount)
                return CommonLoadMore(model.historyMaxCount);
              else {
                return Container();
              }
            }
          } else if ((model.pgcCommentInfos?.length ?? 0) > 0) {
            PgcCommentInfo info = model.pgcCommentInfos[index - 1];
            return PgcDiscussItem(info, infoType: PgcInfoType.infomation,
                onDianZanClick: () {
              _model.changePgcComment({
                'like': (info?.custLike ?? '0') == '1' ? '0' : '1',
                'pgcCommentId': info?.pgcCommentId ?? null
              }, callback: () {
                CommonToast.show(
                    msg: (info?.custLike ?? '0') == '1' ? '点赞-1' : '点赞+1',
                    type: ToastIconType.INFO);
                if ((info?.custLike ?? '0') == '1') {
                  info?.custLike = '0';
                  if (info?.likeCount != null) {
                    info?.likeCount--;
                    if (info?.likeCount < 0) {
                      info?.likeCount = 0;
                    }
                  }
                } else {
                  info?.custLike = '1';
                  if (info?.likeCount != null) {
                    info?.likeCount++;
                  }
                }
              });
            });
          } else {
            return Container();
          }
        },
      );
    });
  }

  getBottomSheet(BuildContext context, String str) {
    TextEditingController controller = new TextEditingController();

    Navigator.push(
        context,
        PopRoute(
            child: BottomInputView(str, () {
          if (StringsHelper.isNotEmpty(controller.text)) {
            CommonToast.show();
            _model.createCustomerOperation({
              'type': '3',
              'content': controller.text,
              'pgcId': widget.info?.pgcId
            }, callback: () {
              CommonToast.show(type: ToastIconType.SUCCESS, msg: '成功发表');
              controller.text = '';
              Navigator.of(context).pop();
              _model.pgcInfomation?.commentCount =
                  (_model.pgcInfomation?.commentCount ?? 0) + 1;
              _model.pgcCommentInfoListHistoryHandleRefresh(
                  map: {'pgcId': widget.info?.pgcId, 'sortName': searchType});
            });
          } else {
            CommonToast.show(type: ToastIconType.FAILED, msg: '请先输入内容');
          }
        }, controller)));
  }

  Row textField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(
          child: new TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: '发表...',
              border: null,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: UIData.themeBgColor),
              ),
            ),
            keyboardType: TextInputType.text,
            maxLength: 600,
            maxLines: 10,
          ),
        ),
        FlatButton(
          child: CommonText.red14Text('发表'),
          onPressed: () {
            if (StringsHelper.isNotEmpty(controller.text)) {
              CommonToast.show();
              _model.createCustomerOperation({
                'type': '3',
                'content': controller.text,
                'pgcId': widget.info?.pgcId
              }, callback: () {
                CommonToast.show(type: ToastIconType.SUCCESS, msg: '成功发表');
                controller.text = '';
                Navigator.of(context).pop();
                _model.pgcInfomation?.commentCount =
                    (_model.pgcInfomation?.commentCount ?? 0) + 1;
                _model.pgcCommentInfoListHistoryHandleRefresh(
                    map: {'pgcId': widget.info?.pgcId, 'sortName': searchType});
              });
            } else {
              CommonToast.show(type: ToastIconType.FAILED, msg: '请先输入内容');
            }
          },
        ),
      ],
    );
  }
}
