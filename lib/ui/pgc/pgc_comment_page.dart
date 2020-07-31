import 'package:cmp_customer/models/pgc/pgc_comment_obj.dart';
import 'package:cmp_customer/models/pgc/pgc_infomation_obj.dart';
import 'package:cmp_customer/models/pgc/pgc_topic_obj.dart';
import 'package:cmp_customer/scoped_models/pgc_model/pgc_comment_model.dart';
import 'package:cmp_customer/scoped_models/pgc_model/pgc_infomation_model.dart';
import 'package:cmp_customer/scoped_models/pgc_model/pgc_topic_model.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/pgc/pgc_infomation/pgc_infomation_item.dart';
import 'package:cmp_customer/ui/pgc/pgc_topic/pgc_topic_item.dart';
import 'package:cmp_customer/ui/pgc/pgc_ui.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/log_util.dart';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class PgcCommentPage extends StatefulWidget {
  PgcCommentInfo info;
  PgcInfoType infoType;

  PgcCommentPage(this.info, this.infoType);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PgcCommentPageState();
  }
}

class _PgcCommentPageState extends State<PgcCommentPage> {
  var _model;
  var pgcinfo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.infoType==null){
      widget.infoType = PgcInfoType.infomation;
    }
    switch (widget.infoType) {
      case PgcInfoType.infomation:
        _model = new PgcInfomationDetailModel();

        _model.pgcCommentInfoListHistoryHandleRefresh(
            map: {"pgcCommentId": widget.info.pgcCommentId},
           );
        _model.pgcInfomationDetailHandleRefresh(
            map: {"pgcId": widget.info?.pgcId ?? ''},
            callBack: () {

            });

        break;
      case PgcInfoType.topic:
        _model = new PgcTopicListModel();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return widget.infoType == PgcInfoType.infomation?buildPgcCommentPageScaffold<PgcInfomationDetailModel>():Container();
  }

  Widget buildPgcCommentPageScaffold<T extends Model>(){
    return ScopedModel<T>(
        model: _model,
        child: CommonScaffold(
            appTitle: '评论详情',
            bodyData: Column(children: <Widget>[
              Expanded(
                child: buildPgcCommentPage<PgcInfomationDetailModel>(),
              )
            ])));
  }

  Widget buildPgcCommentPage<T extends Model>() {
    return ScopedModelDescendant<T>(
      builder: (context, child, model) {
        return CommonLoadContainer(
            state: _model.pgcCommentInfoListState,
            content: RefreshIndicator(
              onRefresh: _refresh,
              child: _buildList<T>(),
            ),
            callback: _refresh);
      },
    );
  }

  Future<void> _refresh() async {
    _model.pgcCommentInfoListHistoryHandleRefresh();
  }

  refresh() {
    _model.pgcCommentInfoListHistoryHandleRefresh();
  }

  Widget _buildList<T extends Model>() {

    return ScopedModelDescendant<T>(
        builder: (context, child, model) {
      return ListView(
        children: <Widget>[
          PgcDiscussItem(
            _model.pgcCommentInfos[0],
            infoType: widget.infoType,
          ),
          getPgcTypeItem(),
        ],
      );
    });
  }

  Widget getPgcTypeItem() {
    switch (widget.infoType) {
      case PgcInfoType.infomation:
          PgcInfomationInfo pgcInfomationInfo = _model.pgcInfomation;
          return PgcInfomationItem(
              pgcInfomationInfo, new PgcInfomationListModel());
        break;
      case PgcInfoType.topic:
        if (pgcinfo is PgcTopicInfo) {
          PgcTopicInfo pgcTopicInfo = pgcinfo;
          return PgcTopicItem(pgcTopicInfo, new PgcTopicListModel());
        } else {
          return Container();
        }
        break;
    }
  }
}
