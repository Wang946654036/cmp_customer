import 'package:cmp_customer/scoped_models/collect/talk_list_model.dart';
import 'package:cmp_customer/scoped_models/collect/topic_list_model.dart';
import 'package:cmp_customer/scoped_models/market_model/market_list_model.dart';
import 'package:cmp_customer/scoped_models/pgc_model/pgc_collect_state_model.dart';
import 'package:cmp_customer/scoped_models/pgc_model/pgc_infomation_model.dart';
import 'package:cmp_customer/ui/collect/talk_list.dart';
import 'package:cmp_customer/ui/collect/topic_list.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/market/market_list.dart';
import 'package:cmp_customer/ui/pgc/pgc_infomation/pgc_infomation_list.dart';
import 'package:cmp_customer/ui/pgc/pgc_topic/pgc_topic_list.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';

//我的收藏页面
class PgcMyCollectTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PgcMyCollectTabState();
  }
}
class _PgcMyCollectTabState extends State<PgcMyCollectTab>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<Widget> tabTitles;
  List<Widget> tabViews;
  PgcInfomationListModel _infomationModel;
  TopicListModel _topicModel;
  MarketListModel _marketModel;
  TalkListModel _talkModel;
  bool isEdit = false;//是否编辑

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabTitles = new List();
    tabTitles.add(new Tab(text: '资讯',));
    tabTitles.add(new Tab(text: '社区话题',));
    tabTitles.add(new Tab(text: '邻里集市',));
    tabTitles.add(new Tab(text: '说说',));
//    tabTitles.add(new Tab(text: '积分商品',));
//    _collectStateModel = new PgcCollectStateModel();
    _infomationModel = new PgcInfomationListModel();
    _infomationModel.isBulkCollectPage =  true;
    _marketModel = new MarketListModel();
    _marketModel.isBulkCollectPage =  true;
    _talkModel = new TalkListModel();
    _talkModel.isBulkCollectPage =  true;
    _topicModel = new TopicListModel();
    _topicModel.isBulkCollectPage =  true;
    tabViews = new List();
    tabViews.add(new PGCInfomationList(_infomationModel,
      refreshCallback: () {
        _infomationModel.pgcInfomationListHistoryHandleRefresh(
            preRefresh: true,
            map: {
              'type': 0,
            });
      },
      loadMoreCallback: (){
        _infomationModel.pgcInfomationListHandleLoadMore(map: {
          'type': 0,
        });
      },));
    tabViews.add(new TopicList(_topicModel,
      refreshCallback: () {
        _topicModel.listHistoryHandleRefresh(
            preRefresh: true,
            map: {
              'type': 0,
            });
      },
      loadMoreCallback: (){
        _topicModel.listHistoryHandleRefresh(map: {
          'type': 0,
        });
      },));
    tabViews.add(new MarketList(_marketModel,
      refreshCallback: () {
        _marketModel.marketListHistoryHandleRefresh(
            preRefresh: true,
            map: {
              'type': 0,
            });
      },
      loadMoreCallback: (){
        _marketModel.marketListHandleLoadMore(map: {
          'type': 0,
        });
      },));
    tabViews.add(new TalkList(_talkModel,
      refreshCallback: () {
        _talkModel.listHistoryHandleRefresh(
            preRefresh: true,
            map: {
              'type': 0,
            });
      },
      loadMoreCallback: (){
        _talkModel.listHandleLoadMore(map: {
          'type': 0,
        });
      },));
    _tabController = new TabController(length: tabTitles.length, vsync: this);

    _tabController.addListener((){
        setState(() {
          if(_tabController.index == 0)
            isEdit = _infomationModel.isBulkCollectOperation;
          else if(_tabController.index == 1)
            isEdit = _topicModel.isBulkCollectOperation;
          else if(_tabController.index == 2)
            isEdit = _marketModel.isBulkCollectOperation;
          else if(_tabController.index == 3)
            isEdit = _talkModel.isBulkCollectOperation;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CommonScaffold(
      appTitle: '我的收藏',
      bodyData: _buildBody(),
      tabBar: TabBar(
        tabs: tabTitles,
        indicatorSize: TabBarIndicatorSize.label,
        labelPadding: EdgeInsets.all(0),
        controller: _tabController,
      ),
      appBarActions: [
        FlatButton(
            onPressed: (){
              setState(() {
                isEdit =!isEdit;
                if(_tabController.index == 0){
                  _infomationModel.changedBulkCollectOperation();
                }else if(_tabController.index == 1){
                  _topicModel.changedBulkCollectOperation();
                }else if(_tabController.index == 2){
                  _marketModel.changedBulkCollectOperation();
                }else if(_tabController.index == 3){
                  _talkModel.changedBulkCollectOperation();
                }
              });
            },
            child: CommonText.red15Text(isEdit?'取消':'编辑'))
      ],
//      bottomNavigationBar: Offstage(
//        offstage: !isEdit,
//        child: _buildBottomNavigationBar(),
//      ),
    );
  }

  Widget _buildBody(){
    return TabBarView(
      children: tabViews,
      controller: _tabController,
    );
  }

//  //按钮是否显示
//  _showVisibleButton(){
//    return (_tabController.index == 0 && _infomationModel.isBulkCollectOperation)
//        ||(_tabController.index == 1 && _infomationModel.isBulkCollectOperation);
//  }
//
//  //是否全选
//  _isAllCollected(){
//    if(_tabController.index == 0){
//      return _infomationModel.collectCheckedList.length == _infomationModel.pgcInfomations.length;
//    }else if(_tabController.index == 1){
//
//    }else{
//      return false;
//    }
//  }
//
//  //设置全选
//  _setAllCollected(bool checked){
//    if(_tabController.index == 0){
//      _infomationModel.setAllCollected(checked);
//    }else if(_tabController.index == 1){
//
//    }
//  }
//
//  //按钮布局
//  Widget _buildBottomNavigationBar(){
//    return Container(
//      color: UIData.primaryColor,
//      child: Row(
//        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//        children: <Widget>[
//          Row(
//            children: <Widget>[
//              Checkbox(
//                  value: _isAllCollected(),
//                  onChanged: (bool checked) {
//                    _setAllCollected(checked);
//                  }),
//              CommonText.darkGrey15Text(_isAllCollected()?'全删':'全选')
//            ],
//          ),
//          FlatButton(child: CommonText.red15Text('取消收藏'), onPressed: () {
//            _cancelCollect();
//          })
//        ],
//      )
//    );
//  }
//
//  //取消收藏
//  _cancelCollect(){
//    List<int> list;
//    int type;
//    if(_tabController.index == 0){
//      list = _infomationModel.collectCheckedList;
//      type = 0;//咨询
//    }else if(_tabController.index == 1){
////      list = _infomationModel.collectCheckedList;
//      type = 1;//话题
//    }
//    if(list==null || list.isEmpty){
//      CommonToast.show(msg: "请勾选需要取消的信息");
//    }else{
//      _collectStateModel.cancelCollectList(list, type, (success){
//        if(success!=null && success){
//          if(_tabController.index == 0){
//            _infomationModel.pgcInfomationListHistoryHandleRefresh(
//                preRefresh: true,
//                map: {
//                  'type': 0,
//                });
//          }else if(_tabController.index == 1){
//            type = 1;//话题
//          }
//        }
//      });
//    }
//  }

}