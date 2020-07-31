import 'package:cmp_customer/models/pgc/pgc_comment_obj.dart';
import 'package:cmp_customer/models/pgc/pgc_topic_obj.dart';
import 'package:cmp_customer/scoped_models/pgc_model/pgc_topic_model.dart';
import 'package:cmp_customer/ui/common/common_animation.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_loadmore.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/common/popover/cupertino_popover.dart';
import 'package:cmp_customer/ui/common/popover/cupertino_popover_menu_item.dart';
import 'package:cmp_customer/ui/pgc/pgc_topic/pgc_topic_disscuss_page.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scoped_model/scoped_model.dart';

import '../pgc_ui.dart';

class PgcTopicDetail extends StatefulWidget {
  PgcTopicInfo info;
  PgcTopicListModel _model;

  PgcTopicDetail(this.info, this._model);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _pgcTopicDetailState();
  }
}

class _pgcTopicDetailState extends State<PgcTopicDetail> {
  ScrollController _loadMoreScrollController = new ScrollController();
  PgcTopicListModel _model;
  String searchType = '0';
bool hasSelected = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _model = widget._model;
    _model.pgcTopics.add(new PgcTopicInfo());
    _model.pgcTopicListState = ListState.HINT_DISMISS;
    _loadMoreScrollController.addListener(() {
      LogUtils.printLog('wo jin lai le ');
      if (_loadMoreScrollController.position.pixels ==
          _loadMoreScrollController.position.maxScrollExtent) {
        if (_model.pgcTopicListState != ListState.HINT_LOADING) {
//          _model.pgcTopicListHistoryHandleRefresh();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModel<PgcTopicListModel>(
        model: _model,
        child: CommonScaffold(
            appBarActions: [
              CupertinoPopoverButton(
                popoverWidth: UIData.spaceSize100,
                  popoverColor: UIData.greyColor,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize16),
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
                          leading:hasSelected?Icon(UIData.iconDataStartSelected,color: UIData.yellowColor,):Icon(UIData.iconDataStartUnselected,color: UIData.primaryColor,),
                          child: CommonText.white14Text("收藏"),
                          onTap: () {
                            setState(() {
                              hasSelected = !hasSelected;
                            });
                          },
                        ),
                        CupertinoPopoverMenuItemWithIcon(
                          leading:Icon(UIData.iconDataStartSelected),
                          child: CommonText.white14Text("分享"),
                          onTap: () {
                            setState(() {

                            });
                          },
                        ),
                      ],
                    );
                  }),
            ],
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
          Container(
          color: UIData.primaryColor,
            padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize8),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    color: UIData.scaffoldBgColor,
                    child: CommonText.grey14Text('请发表您的高见'),
                    onPressed: () {
                      Navigate.toNewPage(PgcTopicDisscussPage(),
                          callBack: (flag) {
                            if (flag != null && flag) {
                              refresh();
                            }
                          });
                    },
                  ),
                ),
                SizedBox(
                  width: UIData.spaceSize8,
                ),
                PgcIconTextView(
                  leading: UIData.iconPinlun,
                  child: CommonText.grey14Text(getPGCNumb(19356)),
                  canClick: true,
                  onTap: () {
                    if ((_model.pgcTopics?.length ?? 0) > 0)
                      _loadMoreScrollController.animateTo(1,
                          duration: new Duration(seconds: 1),
                          curve: Curves.ease);
                  },
                ),
              ],
            ),
          ),

            ],
          ),
          appTitle: '参与话题',
          bodyData: buildPGCTopicDetail(),
        ));
  }

  Widget buildPGCTopicDetail() {
    return ScopedModelDescendant<PgcTopicListModel>(
      builder: (context, child, model) {
        return CommonLoadContainer(
            state: _model.pgcTopicListState,
            content: RefreshIndicator(
              onRefresh: _refresh,
              child: _buildList(),
            ),
            callback: refresh);
      },
    );
  }

  Future<void> _refresh() async {
    _model.pgcTopicListHistoryHandleRefresh();
  }

  refresh() {
    _model.pgcTopicListHistoryHandleRefresh();
  }

  Widget _buildList() {
    return ScopedModelDescendant<PgcTopicListModel>(
        builder: (context, child, model) {
      return ListView.builder(
        controller: _loadMoreScrollController,
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: (model.pgcTopics?.length ?? 0) + 2,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Container(
              color: UIData.primaryColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  //话题图片
                  Container(

                    alignment: Alignment.center,
                    child: FadeInImage.assetNetwork(
                      placeholder: UIData.imageBannerDefaultLoading,
                      image: '',
                      fit: BoxFit.contain,
                    ),
                  ),
                  Container(
                    color: UIData.primaryColor,
                    padding: EdgeInsets.symmetric(
                        horizontal: UIData.spaceSize16,
                        vertical: UIData.spaceSize12),
                    child: CommonText.darkGrey18Text('我是标题'),
                  ),

                  Container(
                    color: UIData.primaryColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: UIData.spaceSize16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CommonText.grey14Text('2019-06-09 09:14'),
                        Expanded(
                          child: PgcIconTextView(
                            leading: UIData.iconWenzhangliulanshu,
                            child: CommonText.grey14Text(getPGCNumb(33956)),
                            canClick: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: UIData.spaceSize12,
                  ),
                  Container(
                    color: UIData.primaryColor,
                    padding:
                        EdgeInsets.symmetric(horizontal: UIData.spaceSize16),
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      runAlignment: WrapAlignment.start,
                      spacing: UIData.spaceSize10,
                      runSpacing: UIData.spaceSize3 * 2,
                      children: getSpcWidgetList(
                          types: ['1', '2', '3', 'a', 'b', 'c']),
                    ),
                  ),
                  Container(
                    color: UIData.primaryColor,
                    padding: EdgeInsets.symmetric(
                        vertical: UIData.spaceSize12,
                        horizontal: UIData.spaceSize16),
                    child: Html(data: ''),
                  ),
                  CommonFullScaleDivider(),
                  Container(
                      color: UIData.primaryColor,
                      padding: EdgeInsets.symmetric(
                          vertical: UIData.spaceSize12,
                          horizontal: UIData.spaceSize16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          CommonText.darkGrey16Text('xxx条评论'),
                          CupertinoPopoverButton(
                            popoverWidth: UIData.spaceSize100,
                              popoverColor: UIData.greyColor,
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    CommonText.blue14Text(
                                        searchType == '0' ? '按热度' : '按时间'),
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
                                              .loadPgcTopicInfoHistoryList({});
                                        });
                                      },
                                    ),
                                    CupertinoPopoverMenuItem(
                                      child: CommonText.white14Text("按热度"),
                                      onTap: () {
                                        setState(() {
                                          searchType = '0';
                                          _model
                                              .loadPgcTopicInfoHistoryList({});
                                        });
                                      },
                                    ),
                                  ],
                                );
                              }),
                        ],
                      )),
                ],
              ),
            );
          } else if ((model.pgcTopics?.length ?? 0) == index - 1) {
            if (model.pgcTopics != null && model.pgcTopics.length == 0)
              return CommonLoadMoreForPgc();
            else
              return CommonLoadMore(model.historyMaxCount);
          } else if ((model.pgcTopics?.length ?? 0) > 0) {
            PgcCommentInfo info = model.pgcCommentInfos[index - 1];
            return PgcDiscussItem(info,infoType:PgcInfoType.topic,onDianZanClick: () {
              CommonToast.show(msg: '点赞了您嘞~', type: ToastIconType.INFO);
            });
          }
        },
      );
    });
  }
}
