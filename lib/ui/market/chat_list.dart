import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/models/chat_history_response.dart';
import 'package:cmp_customer/scoped_models/market_model/chat_state_model.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_dot.dart';
import 'package:cmp_customer/ui/common/common_image_widget.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/utils/common_event_bus.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/date_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/shared_preferences_key.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../main.dart';
import 'chat_page.dart';
import 'market_basedata.dart';

class ChatListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ListState();
  }
}

ChatStateModel chatStateModel;

//接收消息
void receiveMessage(ChatHistory info) {
  if (chatStateModel != null) {
    int length = chatStateModel?.list?.length ?? 0;
    for (int i = 0; i < length; i++) {
      ChatHistory history = chatStateModel.list[i];
      if (history.goodsId == info.goodsId &&
          history.businessId == info.businessId &&
          history.customerId == info.customerId) {
        history.onLineChatRecordList = info?.onLineChatRecordList;
        history.updateTime = info?.updateTime ??
            info?.createTime ??
            info.pushTime ??
            StringsHelper.formatterYMDHms.format(new DateTime.now());
        if (history.goodsId == goodsId && history.businessId == businessId && history.customerId == customerId) {
          //当前接收的信息在聊天页面的时候设置全部已读
          history.unReadCount = 0;
        } else {
          //当前接收的信息不在聊天页面的时候，设置未读
          history.unReadCount = (history.unReadCount ?? 0) + 1;
        }
        chatStateModel.notifyListeners();
        return;
      }
    }
    info.unReadCount = (info.unReadCount ?? 0) + 1;
    chatStateModel.list.insert(0, info);
    chatStateModel.notifyListeners();
  }
}

class _ListState extends State<ChatListPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (stateModel.channel == null) stateModel.initWebSocket(); //初始化聊天
    if (chatStateModel == null) chatStateModel = new ChatStateModel();
    chatStateModel.getChatList();
    //添加监听事件
    websocket_bus.on(websocket_message, _eventCallBack);
  }

  EventCallBack _eventCallBack = (message) {
    //在这里解析websocket发送过来的消息
    receiveMessage(message);
  };

  @override
  void dispose() {
    super.dispose();
    websocket_bus.off(websocket_message, _eventCallBack); //移除监听
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModel<ChatStateModel>(
        model: chatStateModel, child: CommonScaffold(appTitle: "集市聊天", bodyData: _buildList()));
  }

  Widget _buildList() {
    return ScopedModelDescendant<ChatStateModel>(builder: (context, child, model) {
      return CommonLoadContainer(
          state: chatStateModel.listState,
          content: RefreshIndicator(
            child: ListView.separated(
              itemCount: model.list?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                ChatHistory info = model.list[index];
                return _buildItem(info);
              },
              separatorBuilder: (BuildContext context, int index) {
                return CommonDivider();
              },
            ),
            onRefresh: _refresh,
          ),
          callback: _refresh);
    });
  }

  Widget _buildItem(ChatHistory info) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize16, vertical: UIData.spaceSize12),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                          width: ScreenUtil.getInstance().setWidth(30),
                          height: ScreenUtil.getInstance().setWidth(30),
                          margin: EdgeInsets.only(right: UIData.spaceSize8),
                          child: ClipOval(
                            child: Container(
                                width: ScreenUtil.getInstance().setWidth(30),
                                height: ScreenUtil.getInstance().setWidth(30),
                                child: CommonImageWidget(
                                    (info.businessId == stateModel.accountId)
                                        ? info.customerPhotoId
                                        : info.businessPhotoId,
                                    loadingImage: UIData.imageImageLoading,
                                    loadedFailedImage: UIData.imageLoadedFailed,
                                    loadedNoDataImage: UIData.imagePortrait)),
//                child: StringsHelper.isNotEmpty(stateModel.portrait)
//                    ? CachedNetworkImage(
//                        imageUrl: HttpOptions.showPhotoUrl(stateModel.portrait),
//                        width: 30,
//                        height: 30,
//                        fit: BoxFit.fill,
//                      )
//                    : Image.asset(
//                        UIData.imagePortrait,
//                        fit: BoxFit.fill,
//                      ),
                          )
//                        child: StringsHelper.isNotEmpty(
//                                (info.businessId == stateModel.accountId)
//                                    ? info.customerPhotoId
//                                    : info.businessPhotoId)
//                            ? CachedNetworkImage(
//                                placeholder: (context, url) =>
//                                    Image.asset(UIData.imageImageLoading),
//                                errorWidget: (context, url, error) =>
//                                    Image.asset(UIData.imageLoadedFailed),
//                                imageUrl: HttpOptions.showPhotoUrl(
//                                    (info.businessId == stateModel.accountId)
//                                        ? info.customerPhotoId
//                                        : info.businessPhotoId),
//                                fit: BoxFit.cover,
//                                alignment: Alignment.center,
//                              )
//                            : Image.asset(UIData.imagePortrait),
                          ),
                      CommonText.darkGrey16Text((info.businessId == stateModel.accountId)
                          ? info.customerNickName
                          : info.businessNickName),
                      SizedBox(
                        width: UIData.spaceSize8,
                      ),
                      //未读才显示红点点
                      CommonDiamondDot(color: (info.unReadCount ?? 0) > 0 ? UIData.redColor : UIData.primaryColor),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: UIData.spaceSize12),
                    child: CommonText.text14(
                        ((info.onLineChatRecordList?.length ?? 0) > 0)
                            ? (info
//                                    .onLineChatRecordList[
//                                        info.onLineChatRecordList.length - 1]
                                    .onLineChatRecordList[0]
                                    .content ??
                                "")
                            : "",
                        color: (info.unReadCount ?? 0) > 0 ? UIData.orangeColor : UIData.lightGreyColor),
                  ),
                  CommonText.lightGrey12Text(
                      DateUtils.getTheCommentTime(info?.updateTime ?? info?.createTime ?? ""))
                ],
              ),
            ),
            StringsHelper.isNotEmpty(info?.goodsPhotoId)
                ? Container(
                    height: 50,
                    width: 50,
                    child: CommonImageWidget(
                      info?.goodsPhotoId,
                      loadingImage: UIData.imageImageLoading,
                      loadedFailedImage: UIData.imageLoadedFailed,
                    ),
//                    child: CachedNetworkImage(
//                      placeholder: (context, url) => Image.asset(UIData.imageImageLoading),
//                      errorWidget: (context, url, error) => Image.asset(UIData.imageLoadedFailed),
//                      imageUrl: HttpOptions.showPhotoUrl(info.goodsPhotoId),
//                      fit: BoxFit.cover,
//                      alignment: Alignment.center,
//                    ),
                  )
                : Container(),
          ],
        ),
        color: UIData.primaryColor,
      ),
      onTap: () {
        Navigate.toNewPage(ChatPage(
          info.goodsId,
          info.businessId,
          info.customerId,
          info.businessNickName,
          info.customerNickName,
          onlineChatId: info.onLineChatId,
        ));
      },
    );
  }

  //刷新
  Future<void> _refresh() async {
    chatStateModel.getChatList();
  }
}
