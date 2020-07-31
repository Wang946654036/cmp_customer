import 'package:cmp_customer/models/pgc/pgc_topic_obj.dart';
import 'package:cmp_customer/scoped_models/pgc_model/pgc_topic_model.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_loadmore.dart';
import 'package:cmp_customer/ui/pgc/pgc_topic/pgc_topic_item.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class PGCTopicList extends StatefulWidget {
  String processState;
  String queryType;
  Function callback;

  PGCTopicList(
      {this.processState = '', this.queryType = '', this.callback});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PGCTopicListState();
  }
}

class _PGCTopicListState extends State<PGCTopicList> {
  ScrollController _loadMoreScrollController = new ScrollController();
  Map<String, dynamic> selectMap = new Map();
  PgcTopicListModel _model = new PgcTopicListModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.callback != null) {
      widget.callback(selectMap);
    }
    _model.pgcTopicListHistoryHandleRefresh( map: selectMap);
    _loadMoreScrollController.addListener(() {
      if (_loadMoreScrollController.position.pixels ==
          _loadMoreScrollController.position.maxScrollExtent) {
        if (_model.pgcTopicListState != ListState.HINT_LOADING) {
          if (widget.callback != null) {
            widget.callback(selectMap);
          }
          _model.pgcTopicListHandleLoadMore(
              map: selectMap);
        }
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModel<PgcTopicListModel>(
        model: _model,
        child: Scaffold(
            body: Column(children: <Widget>[
              Expanded(
                child: buildPGCTopicList(),
              )
            ])));
  }



  Widget buildPGCTopicList() {

    return ScopedModelDescendant<PgcTopicListModel>(
      builder: (context, child, model) {
        return CommonLoadContainer(
            state: _model.pgcTopicListState,
            content: _buildList(),
            callback: refresh);
      },
    );
  }

  Future<void> _refresh() async{
    if (widget.callback != null) {
      widget.callback(selectMap);
    }
    _model.pgcTopicListHistoryHandleRefresh(map: selectMap);
  }

  refresh() {
    if (widget.callback != null) {
      widget.callback(selectMap);
    }
    _model.pgcTopicListHistoryHandleRefresh(map: selectMap);
  }

  Widget _buildList() {
    return ScopedModelDescendant<PgcTopicListModel>(
        builder: (context, child, model) {
          return RefreshIndicator(
            child: ListView.builder(
              controller: _loadMoreScrollController,
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: (model.pgcTopics?.length ?? 0) + 1,
              itemBuilder: (BuildContext context, int index) {
                if (model.pgcTopics?.length == index) {
                  return CommonLoadMore(model.historyMaxCount);
                } else {
                  PgcTopicInfo info = model.pgcTopics[index];
                  return PgcTopicItem(info,model);
                }
              },
            ),
            onRefresh: _refresh ,
          );
        });
  }


}
