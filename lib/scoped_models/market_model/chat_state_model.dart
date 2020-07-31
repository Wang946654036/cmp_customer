import 'dart:convert';


import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/models/chat_history_response.dart';
import 'package:cmp_customer/models/chat_list_response.dart';
import 'package:cmp_customer/models/common/common_page_model.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';

import '../../main.dart';
import '../base_model.dart';

class ChatStateModel extends BaseModel {
  String webSocketUrl;
  String otherPhotoId;//对方的头像
  //消息记录
  getChatHistoryList(ListPageModel page,{int onLineChatId,int goodsId,int businessId,int customerId,
    Function callback}) async {
    Map<String, dynamic> params = Map();
    params["currentPage"] = page.listPage.currentPage;
    params["pageSize"] = HttpOptions.pageSize * 1000; //最多加载10000条历史记录
    params["onLineChatId"] = onLineChatId;
    params["goodsId"] = goodsId;
    params["businessId"] = businessId;
    params["customerId"] = customerId;
    HttpUtil.post(
        HttpOptions.findSingleChatRecord,
            (data) {
          _getChatHistoryListCallback(data, page, callback: callback);
        },
        jsonData: json.encode(params),
        errorCallBack: (data) {
          _getChatHistoryListErrorCallBack(data, page);
        });
  }

  //获取历史记录回调
  _getChatHistoryListCallback(data, ListPageModel page, {Function callback}) {
    try {
      ChatHistoryResponse model = ChatHistoryResponse.fromJson(data);
      if (model.success()) {
        if (model.data != null && model.data.onLineChatRecordList!=null && model.data.onLineChatRecordList.isNotEmpty) {
          if(model.data.businessId == stateModel.accountId){
            otherPhotoId = model.data.customerPhotoId;
          }else if(model.data.customerId == stateModel.accountId){
            otherPhotoId = model.data.businessPhotoId;
          }
          page.list.addAll(model.data.onLineChatRecordList);
          page.listPage.listState = ListState.HINT_DISMISS;
          if (page.list.length < HttpOptions.pageSize){
            page.listPage.maxCount = true;
          }
          if (page.listPage.currentPage == 1) {
            //首次加载成功
            page.listPage.currentPage++;
            notifyListeners();
            if (callback != null) {
              callback(true);
            }
            return;
          } else {
            page.listPage.currentPage++;
          }
        } else {
          page.listPage.listState = ListState.HINT_NO_DATA_CLICK;
        }
      } else {
        page.listPage.listState = ListState.HINT_LOADED_FAILED_CLICK;
      }
      notifyListeners();
    } catch (e) {
      _getChatHistoryListErrorCallBack("", page);
    }
  }

  void _getChatHistoryListErrorCallBack(errorMsg, ListPageModel page) {
    page.listPage.listState = ListState.HINT_LOADED_FAILED_CLICK;
    notifyListeners();
  }


  //聊天列表
  getChatList() async {
    list.clear();
    listState =  ListState.HINT_LOADING;
    notifyListeners();
    HttpUtil.post(
        HttpOptions.findChatRecords,_getChatListCallback,errorCallBack: (data){
      _getChatListErrorCallBack(data);
    });
  }

  //聊天列表回调
  _getChatListCallback(data) {
    try {
      ChatListResponse model = ChatListResponse.fromJson(data);
      if (model.success()) {
        if (model.data != null && model.data.isNotEmpty) {
          list = model.data;
          listState = ListState.HINT_DISMISS;
        } else {
          listState = ListState.HINT_NO_DATA_CLICK;
        }
      } else {
        listState = ListState.HINT_LOADED_FAILED_CLICK;
      }
      notifyListeners();
    } catch (e) {
      _getChatListErrorCallBack("数据格式返回错误");
    }
  }

  void _getChatListErrorCallBack(errorMsg) {
    errorCallBack(errorMsg??"请求失败");
    listState = ListState.HINT_LOADED_FAILED_CLICK;
    notifyListeners();
  }
}
