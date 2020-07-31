import 'dart:convert';
import 'dart:io';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/common/common_page_model.dart';
import 'package:cmp_customer/models/common_result_model.dart';
import 'package:cmp_customer/models/house_all_model.dart';
import 'package:cmp_customer/models/house_detail_model.dart';
import 'package:cmp_customer/models/house_list_model.dart';
import 'package:cmp_customer/models/message_center_model.dart';
import 'package:cmp_customer/models/message_with_count_model.dart';
import 'package:cmp_customer/models/property_notice_detail_model.dart';
import 'package:cmp_customer/models/property_notice_model.dart';
import 'package:cmp_customer/models/tourist_account_status_model.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/house_authentication/house_auth_page.dart';
import 'package:cmp_customer/ui/house_authentication/my_house_page.dart';
import 'package:cmp_customer/ui/house_authentication/select_house_content.dart';
import 'package:cmp_customer/ui/house_authentication/select_house_page.dart';
import 'package:cmp_customer/ui/notice/property_notice_detail_page.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/failed_code_trans.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:flutter/material.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

mixin NoticeStateModel on Model {
  int unReadMessageTotalCount = 0; //未读消息总条数

  ///
  /// 物业通知列表
  ///
  void loadPropertyNoticeList(
      {bool preRefresh = false, @required ListPageModel pageModel, String keyword, int read = 2}) {
    pageModel.listPage.listState = ListState.HINT_LOADING;
    if (preRefresh) notifyListeners();
    pageModel.listPage.currentPage = 1;
    pageModel.listPage.maxCount = false;
    pageModel.list.clear();
    _getPropertyNoticeList(pageModel, keyword, read);
  }

//  Future<void> propertyNoticeHandleRefresh({@required TaskPageController controller, bool preRefresh = false}) async {
//    loadTaskList(controller:controller,preRefresh: preRefresh);
//  }

  propertyNoticeLoadMore(ListPageModel pageModel, {String keyword, int read}) {
    pageModel.listPage.currentPage++;
    if (!pageModel.listPage.maxCount) {
      _getPropertyNoticeList(pageModel, keyword, read);
    }
  }

  _getPropertyNoticeList(ListPageModel pageModel, String keyword, int read) async {
    Map<String, dynamic> params = new Map();
    params['current'] = pageModel.listPage.currentPage;
    params['pageSize'] = HttpOptions.pageSize.toString();
    params['isRead'] = read; //是否已读 0:未读 1:已读 2:全部
    params['receiveId'] = stateModel.defaultProjectId;
//    params['receiveId'] = 1;//测试数据
    params['userId'] = stateModel.customerId;
    params['receiveType'] = 1; //接收组织类型(0:机构 1：项目)
    params['title'] = keyword;
    String jsonData = json.encode(params);

    HttpUtil.post(
        HttpOptions.propertyNoticeUrl,
        (data) {
          _propertyNoticeListCallBack(data, pageModel);
        },
        jsonData: jsonData,
        errorCallBack: (errorMsg) {
          _propertyNoticeListErrorCallBack(errorMsg, pageModel);
        });
  }

  void _propertyNoticeListCallBack(data, ListPageModel pageModel) {
    PropertyNoticeModel model = PropertyNoticeModel.fromJson(data);
    LogUtils.printLog('物业通知列表:${json.encode(data)}');
    if (model.code == '0') {
      if (model.propertyNoticeList != null && model.propertyNoticeList.length > 0) {
        pageModel.listPage.listState = ListState.HINT_DISMISS;
        if (pageModel.listPage.currentPage == 1) {
          //刷新操作，清空数据再添加（防止多次刷新请求导致数据重复添加）
          pageModel.list.clear();
        }
        pageModel.list.addAll(model.propertyNoticeList);
        if (model.propertyNoticeList.length < HttpOptions.pageSize) pageModel.listPage.maxCount = true;
//        }
      } else {
        if (pageModel.list == null || pageModel.list.isEmpty) {
          //nodata
          pageModel.listPage.listState = ListState.HINT_NO_DATA_CLICK;
          pageModel.list.clear();
        } else {
          //已到列表最底
          pageModel.listPage.maxCount = true;
        }
      }
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
      pageModel.listPage.listState = ListState.HINT_LOADED_FAILED_CLICK;
    }
    notifyListeners();
  }

  void _propertyNoticeListErrorCallBack(errorMsg, ListPageModel pageModel) {
    LogUtils.printLog('接口返回失败');
    pageModel.listPage.listState = ListState.HINT_LOADED_FAILED_CLICK;
    notifyListeners();
  }

  ///
  /// 物业通知详情
  ///
  void getPropertyNoticeDetail(
    int id,
    PropertyNoticeDetailPageModel pageModel, {
    VoidCallback callBack,
  }) async {
    pageModel.pageState = ListState.HINT_LOADING;
    notifyListeners();
    Map<String, dynamic> params = new Map();
    params['id'] = id;
    params['receiveId'] = stateModel.defaultProjectId;
    params['userId'] = stateModel.customerId;
    String jsonData = json.encode(params);

    HttpUtil.post(
        HttpOptions.propertyNoticeDetailUrl,
        (data) {
          _propertyNoticeDetailCallBack(data, pageModel);
        },
        jsonData: jsonData,
        errorCallBack: (errorMsg) {
          _propertyNoticeDetailErrorCallBack(errorMsg, pageModel);
        });
  }

  void _propertyNoticeDetailCallBack(data, PropertyNoticeDetailPageModel pageModel) {
    PropertyNoticeDetailModel model = PropertyNoticeDetailModel.fromJson(data);
    LogUtils.printLog('物业通知详情:${json.encode(data)}');
    if (model.code == '0') {
      pageModel.propertyNoticeDetail = model.propertyNoticeDetail;
      pageModel.pageState = ListState.HINT_DISMISS;
    } else {
      pageModel.pageState = ListState.HINT_LOADED_FAILED_CLICK;
//      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
    }
    notifyListeners();
  }

  void _propertyNoticeDetailErrorCallBack(errorMsg, PropertyNoticeDetailPageModel pageModel) {
    LogUtils.printLog('接口返回失败');
    pageModel.pageState = ListState.HINT_LOADED_FAILED_CLICK;
    notifyListeners();
  }

  ///
  /// 消息中心列表
  ///
  void loadMessageList(ListPageModel pageModel, {String messageType, bool preRefresh = false}) {
    pageModel.listPage.listState = ListState.HINT_LOADING;
    if (preRefresh) notifyListeners();
    pageModel.listPage.currentPage = 1;
    pageModel.listPage.maxCount = false;
    pageModel.list.clear();
    _getMessageList(pageModel, messageType: messageType);
  }

//  Future<void> messageHandleRefresh({@required TaskPageController controller, bool preRefresh = false}) async {
//    loadTaskList(controller:controller,preRefresh: preRefresh);
//  }

  messageLoadMore(ListPageModel pageModel, {String messageType, Function callback}) {
    pageModel.listPage.currentPage++;
    if (!pageModel.listPage.maxCount) {
      _getMessageList(pageModel, messageType: messageType, callback: callback);
    }
  }

  _getMessageList(ListPageModel pageModel, {String messageType, Function callback}) async {
    Map<String, dynamic> params = new Map();
    params['current'] = pageModel.listPage.currentPage;
    params['pageSize'] = HttpOptions.pageSize.toString();
    params['receiverId'] = stateModel.customerId;
    params['receiverAppId'] = stateModel.accountId;
    //messageType(消息类型：GDXX:工单消息 YWBL:业务办理 QTXX:其他消息 HDXX:互动消息 JSLT:集市聊天)
    params['messageType'] = messageType;
    String jsonData = json.encode(params);
    String url = HttpOptions.messageCenterUrl;
    HttpUtil.post(
        url,
        (data) {
          _messageListCallBack(data, pageModel, messageType, callback: callback);
        },
        jsonData: jsonData,
        errorCallBack: (errorMsg) {
          _messageListErrorCallBack(errorMsg, pageModel);
        });
  }

  void _messageListCallBack(data, ListPageModel pageModel, String messageType, {Function callback}) {
    MessageCenterModel model = MessageCenterModel.fromJson(data);
    LogUtils.printLog('消息列表:${json.encode(data)}');
    if (model.code == '0') {
      if (model.messageList != null && model.messageList.length > 0) {
        pageModel.listPage.listState = ListState.HINT_DISMISS;
        if (pageModel.listPage.currentPage == 1) {
          //刷新操作，清空数据再添加（防止多次刷新请求导致数据重复添加）
          pageModel.list.clear();
        }
        pageModel.list.addAll(model.messageList);
        if (model.messageList.length < HttpOptions.pageSize) pageModel.listPage.maxCount = true;
        if (callback != null) callback();
//        }
      } else {
        if (pageModel.list == null || pageModel.list.isEmpty) {
          //nodata
          pageModel.listPage.listState = ListState.HINT_NO_DATA_CLICK;
          pageModel.list.clear();
        } else {
          //已到列表最底
          pageModel.listPage.maxCount = true;
        }
      }
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
      pageModel.listPage.listState = ListState.HINT_LOADED_FAILED_CLICK;
    }
    notifyListeners();
  }

  void _messageListErrorCallBack(errorMsg, ListPageModel pageModel) {
    LogUtils.printLog('接口返回失败');
    pageModel.listPage.listState = ListState.HINT_LOADED_FAILED_CLICK;
    notifyListeners();
  }

  ///
  /// 消息子分类列表
  ///
  void loadMessageSubList(ListPageModel pageModel,
      {String messageType, String messageSubType,List<String> custSubMsgList,List<String> appSubMsgList, bool preRefresh = false, Function callback}) {
    pageModel.listPage.listState = ListState.HINT_LOADING;
    if (preRefresh) notifyListeners();
    pageModel.listPage.currentPage = 1;
    pageModel.listPage.maxCount = false;
    pageModel.list.clear();
    _getMessageSubList(pageModel, messageType: messageType, messageSubType: messageSubType,custSubMsgList:custSubMsgList,appSubMsgList:appSubMsgList, callback: callback);
  }

//  Future<void> messageHandleRefresh({@required TaskPageController controller, bool preRefresh = false}) async {
//    loadTaskList(controller:controller,preRefresh: preRefresh);
//  }

  messageSubLoadMore(ListPageModel pageModel, {String messageType, String messageSubType,List<String> custSubMsgList,List<String> appSubMsgList, Function callback}) {
    pageModel.listPage.currentPage++;
    if (!pageModel.listPage.maxCount) {
      _getMessageSubList(pageModel, messageType: messageType, messageSubType: messageSubType,custSubMsgList:custSubMsgList,appSubMsgList:appSubMsgList, callback: callback);
    }
  }

  _getMessageSubList(ListPageModel pageModel,
      {String messageType, String messageSubType,List<String> custSubMsgList,List<String> appSubMsgList, Function callback}) async {
    Map<String, dynamic> params = new Map();
    params['current'] = pageModel.listPage.currentPage;
    params['pageSize'] = HttpOptions.pageSize.toString();
    params['receiverId'] = stateModel.customerId;
    params['receiverAppId'] = stateModel.accountId;
    //messageType(消息类型：GDXX:工单消息 YWBL:业务办理 QTXX:其他消息 HDXX:互动消息 JSLT:集市聊天)
    params['messageType'] = messageType;
    //messageSubType(消息类型：REPLY:回复 LIKE:点赞)
    params['messageSubType'] = messageSubType;

    //接收类型为客户id的子消息类型
    params['custSubMsgList'] = custSubMsgList;
    //接收类型为账号id的子消息类型
    params['appSubMsgList'] = appSubMsgList;
    String jsonData = json.encode(params);
    String url = HttpOptions.messageSubWithCountUrl;
    HttpUtil.post(
        url,
        (data) {
          _messageSubListCallBack(data, pageModel, callback: callback);
        },
        jsonData: jsonData,
        errorCallBack: (errorMsg) {
          _messageSubListErrorCallBack(errorMsg, pageModel);
        });
  }

  void _messageSubListCallBack(data, ListPageModel pageModel, {Function callback}) {
    MessageWithCountModel model = MessageWithCountModel.fromJson(data);
    LogUtils.printLog('消息子分类列表:${json.encode(data)}');
    if (model.code == '0') {
      if (model.messageWithCount?.messageList != null && model.messageWithCount.messageList.length > 0) {
        pageModel.listPage.listState = ListState.HINT_DISMISS;
        if (pageModel.listPage.currentPage == 1) {
          //刷新操作，清空数据再添加（防止多次刷新请求导致数据重复添加）
          pageModel.list.clear();
        }
        pageModel.list.addAll(model.messageWithCount.messageList);
        if (model.messageWithCount.messageList.length < HttpOptions.pageSize) pageModel.listPage.maxCount = true;
//        if (callback != null) callback();
//        }
      } else {
        if (pageModel.list == null || pageModel.list.isEmpty) {
          //nodata
          pageModel.listPage.listState = ListState.HINT_NO_DATA_CLICK;
          pageModel.list.clear();
        } else {
          //已到列表最底
          pageModel.listPage.maxCount = true;
        }
      }
      if (callback != null) callback(count: model.messageWithCount?.yetReadMessageCount);
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
      pageModel.listPage.listState = ListState.HINT_LOADED_FAILED_CLICK;
    }
    notifyListeners();
  }

  void _messageSubListErrorCallBack(errorMsg, ListPageModel pageModel) {
    LogUtils.printLog('接口返回失败');
    pageModel.listPage.listState = ListState.HINT_LOADED_FAILED_CLICK;
    notifyListeners();
  }

  ///
  /// 设置消息已读
  ///
  void setMessageRead(int messageId, int receiverId,int receiverAppId, {Function callBack}) async {
    String jsonData = json.encode({'messageId': messageId, 'receiverId': receiverId ?? stateModel.customerId,"receiverAppId":receiverAppId??stateModel.accountId});

    HttpUtil.post(HttpOptions.setMessageReadUrl, (data) => _messageReadCallBack(data, callBack: callBack),
        jsonData: jsonData, errorCallBack: (errorMsg) => _messageReadErrorCallBack(errorMsg, callBack: callBack));
  }

  void _messageReadCallBack(data, {Function callBack}) async {
    LogUtils.printLog('设置消息已读:$data');
    CommonResultModel model = CommonResultModel.fromJson(data);
    if (model.code == '0') {
      if (callBack != null) callBack();
    } else {
//      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
//      if (callBack != null) callBack(errorMsg: failedDescri);
//      CommonToast.show(type: ToastIconType.FAILED, msg: failedDescri);
    }
    notifyListeners();
  }

  void _messageReadErrorCallBack(String errorMsg, {Function callBack}) {
    LogUtils.printLog('接口返回失败：$errorMsg');
////    if (callBack != null) callBack(errorMsg: errorMsg);
//    CommonToast.show(type: ToastIconType.FAILED, msg: errorMsg);
//    notifyListeners();
  }

  ///
  /// 获取未读消息总条数
  ///
  void getUnReadMessageTotalCount({Function callBack}) async {
    String jsonData = json.encode({'receiverId': stateModel.customerId});//,'receiverAppId': stateModel.accountId
    HttpUtil.post(HttpOptions.unReadMessageTotalCountUrl,
        (data) => _unReadMessageTotalCountCallBack(data, callBack: callBack),
        jsonData: jsonData,
        errorCallBack: (errorMsg) => _unReadMessageTotalCountErrorCallBack(errorMsg, callBack: callBack));
  }

  void _unReadMessageTotalCountCallBack(data, {Function callBack}) async {
    LogUtils.printLog('获取未读消息总条数:$data');
    CommonResultModel model = CommonResultModel.fromJson(data);
    if (model.code == '0' && model.data != null) {
      unReadMessageTotalCount = model.data;
      //ios需要更新角标
      if (Platform.isIOS) {
        stateModel.jPush.setBadge(unReadMessageTotalCount).then((map) {});
      }
    } else {
      unReadMessageTotalCount = 0;
//      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
//      CommonToast.show(type: ToastIconType.FAILED, msg: failedDescri);
    }
    notifyListeners();
  }

  void _unReadMessageTotalCountErrorCallBack(String errorMsg, {Function callBack}) {
    LogUtils.printLog('接口返回失败：$errorMsg');
//    CommonToast.show(type: ToastIconType.FAILED, msg: errorMsg);
    unReadMessageTotalCount = 0;
    notifyListeners();
  }

  ///
  /// 批量设置消息已读
  ///
  void setMessageReadBatch({List<int> ids, String messageType, String messageSubType,List<String> messageSubTypeList,List<String> custSubMsgList,List<String> appSubMsgList, Function callBack}) async {
    CommonToast.show();
//    String jsonData = json.encode({'id': ids, 'receiverId': stateModel.customerId});
    String jsonData =
        json.encode({'setAll': true, 'receiverId': stateModel.customerId, 'receiverAppId': stateModel.accountId,'messageSubTypeList':messageSubTypeList,'custSubMsgList':custSubMsgList,'appSubMsgList':appSubMsgList, 'messageType': messageType, 'messageSubType': messageSubType});

    HttpUtil.post(
        HttpOptions.setBatchMessageReadUrl, (data) => _messageReadBatchCallBack(data, callBack: callBack),
        jsonData: jsonData,
        errorCallBack: (errorMsg) => _messageReadBatchErrorCallBack(errorMsg, callBack: callBack));
  }

  void _messageReadBatchCallBack(data, {Function callBack}) async {
    LogUtils.printLog('批量设置消息已读:$data');
    CommonResultModel model = CommonResultModel.fromJson(data);
    if (model.code == '0') {
      CommonToast.dismiss();
      if (callBack != null) callBack();
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
//      if (callBack != null) callBack(errorMsg: failedDescri);
      CommonToast.show(type: ToastIconType.FAILED, msg: failedDescri);
    }
//    notifyListeners();
  }

  void _messageReadBatchErrorCallBack(String errorMsg, {Function callBack}) {
    LogUtils.printLog('接口返回失败：$errorMsg');
//    if (callBack != null) callBack(errorMsg: errorMsg);
    CommonToast.show(type: ToastIconType.FAILED, msg: errorMsg);
//    notifyListeners();
  }

  static NoticeStateModel of(context) => ScopedModel.of<NoticeStateModel>(context);
}
