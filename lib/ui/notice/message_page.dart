import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/strings/strings_notice.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'message_list_content.dart';

///
/// 子类型消息列表
///
class MessagePage extends StatefulWidget {
  final String title;
  final String messageType;
  final Function callback;
  final int totalCount;

  MessagePage(this.title, this.messageType, {this.callback, this.totalCount});

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> with SingleTickerProviderStateMixin {
  GlobalKey<MessageListContentState> _keyReply = GlobalKey();
  GlobalKey<MessageListContentState> _keyLike;
  TabController _tabController;

  //第一次更新点赞未读数量（互动消息时使用）
  bool _first = true;

  //回复/评论数量
  int _replyCount;

  //点赞数量
  int _likeCount;

  @override
  void initState() {
    super.initState();
    if (widget.messageType == messageTypeHDXX) {
      _keyLike = GlobalKey();
      _tabController = TabController(length: 2, vsync: this);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildTabBar() {
    return ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
      return Container(
        color: UIData.primaryColor,
        child: TabBar(
            controller: _tabController,
            indicator: UnderlineTabIndicator(
                borderSide: BorderSide(width: 3.0, color: UIData.redGradient2),
                insets: EdgeInsets.symmetric(horizontal: UIData.spaceSize50)),
//          indicatorSize: TabBarIndicatorSize.label,
//            indicatorColor: UIData.themeBgColor,
//          indicatorWeight: 3.0,
            labelStyle: CommonText.darkGrey15TextStyle(),
            tabs: [
              Tab(text: '评论/回复${(_replyCount != null && _replyCount > 0) ? '（$_replyCount）' : ''}'),
              Tab(text: '点赞${(_likeCount != null && _likeCount > 0) ? '（$_likeCount）' : ''}')
            ]),
      );
    });
  }

  Widget _buildBody() {
    return ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
      //互动消息
      if (widget.messageType == messageTypeHDXX) {
        return TabBarView(controller: _tabController, children: [
          MessageListContent(widget.messageType,
              custSubMsgList: [messageSubTypeREPLY],
              appSubMsgList: [messageSubTypeWAREREPLY,messageSubTypeTOPICCOMMENT,messageSubTypeTALKCOMMENT],
              key: _keyReply, callback: ({int count}) {
//            if (count == null) {
            if (widget.callback != null) widget.callback();
//            } else {
            setState(() {
              _replyCount = count;
              if (_first) {
                _likeCount = widget.totalCount - _replyCount;
                _first = false;
              }
            });
//            }
          }),
          MessageListContent(widget.messageType,
              custSubMsgList: [messageSubTypeLIKE],
              appSubMsgList: [messageSubTypeWARELIKE,messageSubTypeTOPICLIKE,messageSubTypeTALKLIKE],
              key: _keyLike, callback: ({int count}) {
//            if (count == null) {
            if (widget.callback != null) widget.callback();
//            } else {
            setState(() {
              _likeCount = count;
            });
//            }
          }),
        ]);
      } else {
        //互动消息外的其他消息
        return MessageListContent(widget.messageType, key: _keyReply, callback: ({int count}) {
//            if (count == null) {
          if (widget.callback != null) widget.callback();
//            } else {
//              setState(() {
//                _likeCount = count;
//              });
//            }
        });
      }
    });
  }

  String get _getMessageSubType {
    if (widget.messageType == messageTypeHDXX) {
      if (_tabController.index == 0)
        return messageSubTypeREPLY;
      else
        return messageSubTypeLIKE;
    } else
      return null;
  }

  List<String> get _getCustSubMsgList {
    if (widget.messageType == messageTypeHDXX) {
      if (_tabController.index == 0)
        return [messageSubTypeREPLY];
      else
        return [messageSubTypeLIKE];
    } else
      return null;
  }

  List<String> get _getAppSubMsgList {
    if (widget.messageType == messageTypeHDXX) {
      if (_tabController.index == 0)
        return [messageSubTypeWAREREPLY,messageSubTypeTOPICCOMMENT,messageSubTypeTALKCOMMENT];
      else
        return [messageSubTypeWARELIKE,messageSubTypeTOPICLIKE,messageSubTypeTALKLIKE];
    } else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
      return CommonScaffold(
        appTitle: widget.title ?? '',
        tabBar: widget.messageType == messageTypeHDXX ? _buildTabBar() : null,
        bodyData: _buildBody(),
//        bodyData: MessageListContent(widget.messageType, key: _key),
        appBarActions: [
          FlatButton(
              onPressed: () {
                setState(() {
//                  _modify = !_modify; //编辑用，暂时停用
                  stateModel.setMessageReadBatch(
                      messageType: widget.messageType,
                      messageSubType: _getMessageSubType,
                      messageSubTypeList: _getAppSubMsgList,
//                      appSubMsgList: _getAppSubMsgList,
                      callBack: () {
                        stateModel.getUnReadMessageTotalCount();
                        if (widget.callback != null) widget.callback(); //回调到消息中心刷新红点的未读消息数量
                        if (widget.messageType == messageTypeHDXX &&
                            _tabController != null &&
                            _tabController.index == 1) {
                          //互动消息的点赞
                          _keyLike.currentState.handleRefresh(preRefresh: true);
                        } else {
                          _keyReply.currentState.handleRefresh(preRefresh: true);
                        }
                      });
                });
              },
// child: CommonText.darkGrey15Text(_modify ? '完成' : '编辑'))
              child: CommonText.darkGrey15Text('全部已读'))
        ],
//        bottomNavigationBar: _buildBottomNavigationBar(),
      );
    });
  }
}
