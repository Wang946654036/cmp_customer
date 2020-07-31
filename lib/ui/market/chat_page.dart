import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/models/chat_history_response.dart';
import 'package:cmp_customer/models/common/common_page_model.dart';
import 'package:cmp_customer/models/market/ware_detail_model.dart';
import 'package:cmp_customer/scoped_models/market_model/chat_state_model.dart';
import 'package:cmp_customer/scoped_models/market_model/market_detail_model.dart';
import 'package:cmp_customer/ui/common/common_image_widget.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/utils/common_event_bus.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/date_util.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/shared_preferences_key.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../main.dart';
import 'chat_list.dart';
import 'market_basedata.dart';

//聊天页面
class ChatPage extends StatefulWidget {
  int onlineChatId;
  int goodsId; //商品id
  int businessId; //商品创建人id（卖家）
  int customerId; //客户id（买家）
  String businessName; //商家昵称
  String customerName; //客户昵称
  WareDetailModel marketInfo;

  ChatPage(this.goodsId, this.businessId, this.customerId, this.businessName, this.customerName,
      {this.onlineChatId, this.marketInfo});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ChatPageState();
  }
}

//ChatStateModel _chatStateModel;
ListPageModel _listPageModel;
ScrollController _scrollController;
//上下两条消息的时间差,相隔10分钟
const int timeDifference = 10 * 60 * 1000;
int goodsId; //商品id
int businessId; //商品创建人id（卖家）
int customerId; //买家id
int onlineChatId; //聊天室id

void _receiveMessage(ChatRecord info, {bool toScrollDown = false}) {
  if (_listPageModel?.list != null) {
    _listPageModel.list.add(info);
  }
  if (chatStateModel != null) {
    chatStateModel.notifyListeners();
  }
  if (toScrollDown) {
    _autoScrollDown();
  } else if (_scrollController != null &&
      _scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
    _autoScrollDown();
  }
}

///自动滚动到最底部,需要延时执行，才能滚动成功
void _autoScrollDown() {
  Timer(Duration(milliseconds: 300), () => _scrollController.jumpTo(_scrollController.position.maxScrollExtent));
}

void _getChatHistory(bool scrollDown, {bool setIsRead = false}) {
  if (onlineChatId != null) {
    chatStateModel.getChatHistoryList(setIsRead ? ListPageModel() : _listPageModel, onLineChatId: onlineChatId,
        callback: (success) {
      updateUnReadMessage();
      if (success != null && success && scrollDown) {
        _autoScrollDown();
      }
    });
  } else {
    chatStateModel.getChatHistoryList(setIsRead ? ListPageModel() : _listPageModel,
        goodsId: goodsId, businessId: businessId, customerId: customerId, callback: (success) {
      updateUnReadMessage();
      if (success != null && success && scrollDown) {
        _autoScrollDown();
      }
    });
  }
}

//更新未读消息
void updateUnReadMessage() {
  int length = chatStateModel?.list?.length ?? 0;
  for (int i = 0; i < length; i++) {
    ChatHistory history = chatStateModel.list[i];
    if (history.goodsId == goodsId && history.businessId == businessId && history.customerId == customerId) {
      //当前接收的信息在聊天页面的时候设置全部已读
      history.unReadCount = 0;
      chatStateModel.notifyListeners();
      return;
    }
  }
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController _textEditingController;
  String webSocketUrl;
  MarketDetailModel _detailModel;
  String headUuid; //对方的头像id
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listPageModel = ListPageModel();
    _scrollController = ScrollController();
    _textEditingController = TextEditingController();
    if (chatStateModel == null) chatStateModel = ChatStateModel();
    _detailModel = MarketDetailModel();
    //添加监听事件
    websocket_bus.on(websocket_message, _eventCallBack);
    goodsId = widget.goodsId;
    businessId = widget.businessId;
    customerId = widget.customerId;
    onlineChatId = widget.onlineChatId;

    //查询商品信息
    if (widget.marketInfo != null) {
      _detailModel.marketInfo = widget.marketInfo;
      _detailModel.notifyListeners();
      _getChatHistory(true);
    } else {
      _detailModel.getDetail(widget.goodsId, callBack: () {
        _getChatHistory(true);
      });
    }
  }

  EventCallBack _eventCallBack = (message) {
    //在这里解析websocket发送过来的消息
    ChatHistory info = message;
    if (info?.goodsId == goodsId &&
        info?.businessId == businessId &&
        info?.customerId == customerId &&
        (info?.onLineChatRecordList?.isNotEmpty ?? false)) {
      _receiveMessage(info.onLineChatRecordList[0]);
      _getChatHistory(false, setIsRead: true);
    }
  };

  @override
  void dispose() {
    super.dispose();
    websocket_bus.off(websocket_message, _eventCallBack); //移除监听
    //清空信息
    goodsId = null;
    businessId = null;
    customerId = null;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModel<ChatStateModel>(
        model: chatStateModel,
        child: ScopedModelDescendant<ChatStateModel>(builder: (context, child, model) {
          return CommonScaffold(
              appTitle:
                  (stateModel.accountId == widget.businessId ? widget.customerName : widget.businessName) ?? "",
              bodyData: Column(
                children: <Widget>[_buildGoods(), Expanded(child: _buildList()), _buildChatBottom()],
              ));
        }));
  }

  Widget _buildGoods() {
    return ScopedModel<MarketDetailModel>(
        model: _detailModel,
        child: ScopedModelDescendant<MarketDetailModel>(builder: (context, child, model) {
          WareDetailModel info = model?.marketInfo;
          return Visibility(
            visible: info != null,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize16, vertical: UIData.spaceSize12),
              child: Row(
                children: <Widget>[
                  (info?.picAttachmentList?.isNotEmpty ?? false)
                      ? Container(
                          height: 50,
                          width: 50,
                          margin: EdgeInsets.only(right: UIData.spaceSize12),
                          child: CommonImageWidget(info?.picAttachmentList[0]?.attachmentUuid,
                              loadingImage: UIData.imageImageLoading, loadedFailedImage: UIData.imageLoadedFailed),
//                    child: CachedNetworkImage(
//                      placeholder: (context, url) =>
//                          Image.asset(UIData.imageImageLoading),
//                      errorWidget: (context, url, error) =>
//                          Image.asset(UIData.imageLoadedFailed),
//                      imageUrl: HttpOptions.showPhotoUrl(
//                          info.picAttachmentList[0].attachmentUuid),
//                      fit: BoxFit.cover,
//                      alignment: Alignment.center,
//                    ),
                        )
                      : Container(
                          margin: EdgeInsets.only(right: UIData.spaceSize12),
                        ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        CommonText.darkGrey16Text(info?.title ?? ""),
                        Visibility(
                          visible:
                              model.marketInfo?.tradingType == StringsHelper.enum2String(MarketType.XSY), //小生意
                          child: CommonText.orange14Text(getPriceAndUnit(
                              model.marketInfo?.price?.toString(), model.marketInfo?.priceDescribe)),
                        ),
                        Visibility(
                          visible: model.marketInfo?.tradingType == StringsHelper.enum2String(MarketType.ES), //二手
                          child: Row(
                            children: <Widget>[
                              CommonText.orange14Text(model.marketInfo?.price != null
                                  ? "￥${model.marketInfo?.price?.toString() ?? ""}"
                                  : ""),
                              Visibility(
                                visible: model.marketInfo?.priceBak != null,
                                child: Container(
                                  margin: EdgeInsets.only(left: UIData.spaceSize8),
                                  child: CommonText.text14(" ${model.marketInfo?.priceBak?.toString() ?? ''}",
                                      color: UIData.lightGreyColor, textDecoration: TextDecoration.lineThrough),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: model.marketInfo?.tradingType == StringsHelper.enum2String(MarketType.ZJ), //租借
                          child: Row(
                            children: <Widget>[
                              CommonText.orange14Text("租金："),
                              Expanded(
                                child: CommonText.orange14Text(getPriceAndUnit(
                                    model.marketInfo?.price?.toString(), model.marketInfo?.priceDescribe)),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: model.marketInfo?.tradingType == StringsHelper.enum2String(MarketType.ZJ), //租借
                          child: Row(
                            children: <Widget>[
                              CommonText.orange14Text("押金："),
                              Expanded(
                                child: CommonText.orange14Text("￥${model.marketInfo?.priceBak?.toString() ?? ''}"),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              color: UIData.primaryColor,
            ),
          );
        }));
  }

  Widget _buildList() {
    return ScopedModelDescendant<ChatStateModel>(builder: (context, child, model) {
      return SingleChildScrollView(
        controller: _scrollController,
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            ChatRecord history = _listPageModel.list[index];
            if (index == 0) {
              history.showDateTime = true; //第一个必须显示时间
            } else {
              if ((DateTime.parse(history.sendTime).millisecondsSinceEpoch) -
                      DateTime.parse(_listPageModel.list[index - 1].sendTime).millisecondsSinceEpoch <
                  timeDifference) {
                history.showDateTime = false;
              } else {
                history.showDateTime = true;
              }
            }
            return Column(
              children: <Widget>[
                Visibility(
                    visible: history.showDateTime ?? true,
                    child: Container(
                      child: CommonText.lightGrey16Text(history.sendTime),
                      padding: EdgeInsets.symmetric(vertical: 10),
                    )),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: _buildChatItem(history),
                )
              ],
            );
          },
          itemCount: (_listPageModel.list?.length ?? 0),
        ),
      );
    });
  }

  Widget _buildChatItem(ChatRecord history) {
    if (history.sendId != null && history.sendId == stateModel.accountId) {
      //自己发送的消息
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
//                  CommonText.lightGrey12Text("${history.createTime ?? ""}"),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    decoration: BoxDecoration(
                      image: DecorationImage(
//                        centerSlice: Rect.fromLTRB(30,30,40, 40),
                        image: AssetImage(UIData.imageChatMineBg),
//                        fit: BoxFit.cover
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: CommonText.darkGrey16Text("${history.content ?? ""}", overflow: TextOverflow.visible),
                  )
                ],
              ),
            ),
          ),
          Container(
              width: ScreenUtil.getInstance().setWidth(30),
              height: ScreenUtil.getInstance().setWidth(30),
              margin: EdgeInsets.only(right: 16),
              alignment: Alignment.center,
              child: ClipOval(
                child: Container(
                    width: ScreenUtil.getInstance().setWidth(30),
                    height: ScreenUtil.getInstance().setWidth(30),
                    child: CommonImageWidget(stateModel?.portrait,
                        loadingImage: UIData.imagePortrait,
                        loadedFailedImage: UIData.imagePortrait,
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
              )),
        ],
      );
    } else {
      return Row(
        children: <Widget>[
//          Container(
//            margin: EdgeInsets.only(left: 16),
//            width: 30,
//            height: 30,
//            child: Image.asset(
//              UIData.imageZhaoxiaotong,
//              fit: BoxFit.fill,
//              width: 30,
//              height: 30,
//            ),
//          ),
          Container(
              width: ScreenUtil.getInstance().setWidth(30),
              height: ScreenUtil.getInstance().setWidth(30),
              margin: EdgeInsets.only(left: 16),
              alignment: Alignment.center,
              child: ClipOval(
                  child: Container(
                    width: ScreenUtil.getInstance().setWidth(30),
                    height: ScreenUtil.getInstance().setWidth(30),
                    child: CommonImageWidget(chatStateModel?.otherPhotoId,
                        loadingImage: UIData.imagePortrait,
                        loadedFailedImage: UIData.imagePortrait,
                        loadedNoDataImage: UIData.imagePortrait),
                  )
//                child: StringsHelper.isNotEmpty(chatStateModel?.otherPhotoId)
//                    ? CachedNetworkImage(
//                        imageUrl: HttpOptions.showPhotoUrl(chatStateModel?.otherPhotoId),
//                        width: 30,
//                        height: 30,
//                        fit: BoxFit.fill,
//                      )
//                    : Image.asset(
//                        UIData.imagePortrait,
//                        fit: BoxFit.fill,
//                      ),
                  )),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
//                  CommonText.lightGrey12Text("${history.createTime ?? ""}"),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(UIData.imageChatOtherBg),
//                          fit: BoxFit.cover
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: CommonText.darkGrey16Text("${history.content ?? ""}", overflow: TextOverflow.visible),
                  )
                ],
              ),
            ),
          ),
        ],
      );
    }
  }

//  ///创建用户本身的聊天框
//  Widget _createRightMessage() {
//    return Container(
//      margin: EdgeInsets.only(top: 13, right: 15),
//      child: Column(
//        children: <Widget>[
//          //时间节点
//          widget.isShowTime
//              ? Container(
//            padding: EdgeInsets.only(left: 30),
//            height: 18,
//            margin: EdgeInsets.only(bottom: 20),
//            child: Text(
//              widget.time,
//              style: TextStyle(
//                fontSize: 13,
//                color: MyColors.ff99999a,
//              ),
//            ),
//          )
//              : Container(
//            width: 0,
//            height: 0,
//          ),
//
//          Row(
//            mainAxisAlignment: MainAxisAlignment.end,
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: <Widget>[
//              Stack(
//                children: <Widget>[
//                  //用户名
//                  Positioned(
//                    right: 5,
//                    top: 2,
//                    child: Text(
//                      widget.mineName,
//                      textAlign: TextAlign.right,
//                      style: TextStyle(
//                        fontSize: 11,
//                        color: MyColors.ff99999a,
//                      ),
//                    ),
//                  ),
//
//                  //聊天框
//                  Container(
////                      color: MyColors.ff42cf43,
//                      padding:
//                      EdgeInsets.symmetric(vertical: 10, horizontal: 14),
//                      margin: EdgeInsets.only(right: 5,top: 13),
//                      constraints: BoxConstraints(
//                        maxWidth: 250,
//                        minHeight: 42,
//                        minWidth: 50,
//                      ),
//                      decoration: BoxDecoration(
//                        image: DecorationImage(
//                          image: AssetImage(
//                            "assets/images/icon_chat_mine_bg.png",
//                          ),
//                          fit: BoxFit.fill,
//                        ),
//                      ),
//                      child: Text(
//                        widget.messageContent,
//                        style: TextStyle(
//                          fontSize: 16,
//                          color: MyColors.ff1a1d20,
//                        ),
//                      )),
//                ],
//              ),
//              Image.asset("assets/images/icon_chat_mine_head.png",
//                  width: 42, height: 42),
//            ],
//          )
//        ],
//      ),
//    );
//  }
//
//  ///创建好友聊天框
//  Widget _createLeftMessage() {
//    return Container(
//      margin: EdgeInsets.only(top: 20, left: 15),
//      child: Column(children: <Widget>[
//        //时间节点
//        widget.isShowTime
//            ? Container(
//          height: 18,
//          margin: EdgeInsets.only(bottom: 20),
//          child: Text(
//            widget.time,
//            style: TextStyle(
//              fontSize: 13,
//              color: MyColors.ff99999a,
//            ),
//          ),
//        )
//            : Container(
//          width: 0,
//          height: 0,
//        ),
//
//        Row(
//          mainAxisAlignment: MainAxisAlignment.start,
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
//            Image.asset("assets/images/icon_chat_other_head.png",
//                width: 42, height: 42),
//            Stack(
//              children: <Widget>[
//                Positioned(
//                  left: 10,
//                  top: 2,
//                  child: //其他用户名
//                  Container(
//                    child: Text(
//                      widget.otherName,
//                      style: TextStyle(
//                        color: MyColors.ff99999a,
//                        fontSize: 11,
//                      ),
//                    ),
//                  ),
//                ),
//
//                //聊天框
//                Container(
//                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
//                  margin: EdgeInsets.only(left: 8,top: 15),
//                  constraints: BoxConstraints(
//                      maxWidth: 250,
//                      minHeight: 42,
//                      minWidth: 50
//                  ),
//                  decoration: BoxDecoration(
//                    image: DecorationImage(
//                      image: AssetImage("assets/images/icon_chat_other_bg.png"),
//                      fit: BoxFit.fill,
//                    ),
//                  ),
//                  child: Text(
////                    widget.messageContent,
//                    widget.messageContent,
//                    textAlign: TextAlign.left,
//                    style: TextStyle(
//                      fontSize: 16,
//                      color: MyColors.ff1a1d20,
//                    ),
//                  ),
//                ),
//              ],
//            ),
//          ],
//        ),
//      ]),
//    );
//  }

  Widget _buildChatBottom() {
    return Container(
      color: UIData.primaryColor,
      alignment: Alignment.centerLeft,
      child: Row(
        children: <Widget>[
          Expanded(
              child: Container(
            margin: EdgeInsets.only(left: 16),
            padding: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(color: UIData.scaffoldBgColor, borderRadius: BorderRadius.circular(5)),
            child: TextField(
              controller: _textEditingController,
              style: CommonText.darkGrey14TextStyle(),
              textInputAction: TextInputAction.send,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "来说点什么吧",
                hintStyle: CommonText.lightGrey14TextStyle(),
                isDense: true,
              ),
              onSubmitted: (text) {
                _sendMessage();
              },
            ),
          )),
          FlatButton(
            padding: EdgeInsets.all(1),
            child: CommonText.blue14Text('发送'),
            onPressed: () {
              _sendMessage();
            },
          )
        ],
      ),
    );
  }

  //发送消息
  void _sendMessage() {
    String text = _textEditingController.text.toString();
    if (StringsHelper.isNotEmpty(text)) {
      setState(() {
        _textEditingController.text = "";
      });

      ChatRecord chatRecord = ChatRecord(
          chatId: widget.onlineChatId,
          sendId: stateModel.accountId,
          sendName: stateModel.accountId == widget.businessId ? widget.businessName : widget.customerName,
          senderPhotoId: stateModel.portrait,
          receiveId: stateModel.accountId == widget.businessId ? widget.customerId : widget.businessId,
          content: text,
          sendTime: StringsHelper.formatterYMDHms.format(new DateTime.now()));
      ChatHistory info = ChatHistory(
          goodsId: widget.goodsId,
          businessId: widget.businessId,
          customerId: widget.customerId,
          onLineChatId: widget.onlineChatId,
          recvId: stateModel.accountId == widget.businessId ? widget.customerId : widget.businessId,
          sendId: stateModel.accountId,
          sendName: stateModel.accountId == widget.businessId ? widget.businessName : widget.customerName,
          customerPhotoId: stateModel.accountId == widget.customerId ? stateModel.portrait : null,
          customerNickName: widget.customerName,
          unReadCount: 1,
          goodsPhotoId: (_detailModel?.marketInfo?.picAttachmentList?.isNotEmpty ?? false)
              ? _detailModel.marketInfo.picAttachmentList[0].attachmentUuid
              : null,
          message: text,
          createTime: StringsHelper.formatterYMDHms.format(new DateTime.now()),
          pushTime: StringsHelper.formatterYMDHms.format(new DateTime.now()),
          onLineChatRecordList: [chatRecord]);
      stateModel.sendMessage(json.encode(info));

      receiveMessage(info); //通知列表
      _receiveMessage(chatRecord, toScrollDown: true);
      LogUtils.printLog(json.encode(info).toString());
    }
  }
}
