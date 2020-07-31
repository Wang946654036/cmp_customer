import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/common/common_page_model.dart';
import 'package:cmp_customer/models/message_center_model.dart';
import 'package:cmp_customer/models/property_notice_model.dart';
import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/strings/strings_notice.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_dot.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_loadmore.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_shadow_container.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/market/chat_list.dart';
import 'package:cmp_customer/ui/notice/message_page.dart';
import 'package:cmp_customer/ui/notice/property_notice_detail_page.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scoped_model/scoped_model.dart';

///
/// 消息中心列表
///
class MessageCenterPage extends StatefulWidget {
  MessageCenterPage();

  @override
  _MessageCenterPageState createState() => _MessageCenterPageState();
}

class _MessageCenterPageState extends State<MessageCenterPage> {
  ListPageModel _listPageModel = ListPageModel();

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _refreshData({bool preRefresh = false}) {
    stateModel.loadMessageList(_listPageModel, preRefresh: preRefresh);
  }

  //角标（小于100显示圆圈，大于等于100显示圆角矩形）
  Widget _buildBadge(int count) {
    if (count != null && count > 0) {
      if (count < 100) {
        return SizedBox(
          width: UIData.spaceSize16,
          height: UIData.spaceSize16,
          child: CircleAvatar(
              backgroundColor: UIData.redColor,
              child: CommonText.text11(count.toString(), color: UIData.primaryColor)),
        );
      } else {
        return ClipRRect(
            borderRadius: BorderRadius.circular(100),
//                              backgroundColor: UIData.redColor,
            child: Container(
              padding: EdgeInsets.all(UIData.spaceSize4),
              color: UIData.redColor,
              alignment: Alignment.center,
              child: CommonText.text11(count.toString(), color: UIData.primaryColor),
            ));
      }
    } else {
      return Container();
    }
  }

  ///
  /// item卡片
  ///
  Widget _buildCard(MessageInfo info) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize16, vertical: UIData.spaceSize8),
        color: UIData.primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Stack(
                  alignment: Alignment.topRight,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(UIData.spaceSize4),
                      child: messageCenter2IconMap[info?.messageType],
//                    child: UIData.iconMessageWorkOrder,
                    ),
                    _buildBadge(info?.yetReadMessageCount),
                  ],
                ),
                SizedBox(width: UIData.spaceSize8),
                CommonText.darkGrey16Text(messageCenterMap[info?.messageType] ?? ''),
              ],
            ),
            Row(
              children: <Widget>[
                CommonText.lightGrey12Text(info?.createTime ?? ''),
                SizedBox(width: UIData.spaceSize4),
                Icon(
                  Icons.keyboard_arrow_right,
                  color: UIData.lighterGreyColor,
                )
              ],
            )
          ],
        ),
      ),
      onTap: (){
        if(info?.messageType == messageTypeJSLT){
          //集市聊天(不太符合消息推送的机制，只能在这里跳转了)
          Navigate.toNewPage(ChatListPage());
        }else{
          Navigate.toNewPage(
              MessagePage(messageCenterMap[info?.messageType] ?? '', info?.messageType, totalCount: info.yetReadMessageCount,
                  callback: () {
                    _refreshData();
//            setState(() {
//              if (info?.yetReadMessageCount != null && info.yetReadMessageCount > 0)
//                info.yetReadMessageCount = info.yetReadMessageCount - 1;
//            });
                  }));
        }
      },
    );
  }

//  _refresh() {
//    MainStateModel.of(context).taskHandleRefresh(pageModel: _listPageModel, preRefresh: true);
//  }
  Future<void> _handleRefresh() async {
    _refreshData();
  }

  Widget _buildList() {
    return RefreshIndicator(
        child: ListView.separated(
          shrinkWrap: true,
//          physics: NeverScrollableScrollPhysics(),
//            padding: EdgeInsets.only(top: UIData.spaceSize16),
          itemCount: _listPageModel?.list?.length ?? 0,
//            itemCount: 2,
          itemBuilder: (context, index) {
            MessageInfo info = _listPageModel?.list[index];
//              PropertyNotice info;
            return _buildCard(info);
          },
          separatorBuilder: (context, index) {
            return CommonDivider();
          },
        ),
        onRefresh: _handleRefresh);
  }

  Widget _buildContent() {
    return ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
      return CommonLoadContainer(
          state: _listPageModel.listPage.listState,
//              state: ListState.HINT_DISMISS, //测试数据
          content: _buildList(),
          callback: ()=> _refreshData(preRefresh: true));
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
      return CommonScaffold(
        appTitle: '消息中心',
        bodyData: _buildContent(),
      );
    });
  }
}
