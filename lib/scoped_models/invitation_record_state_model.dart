import 'dart:convert';
import 'dart:io';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/models/common_result_model.dart';
import 'package:cmp_customer/models/response/base_response.dart';
import 'package:cmp_customer/models/response/invitation_record_response.dart';
import 'package:cmp_customer/models/response/parking_card_history_response.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:scoped_model/scoped_model.dart';

import 'base_model.dart';

//邀请记录
class InvitationRecordStateModel extends BaseModel {
  
  //获取列表
  loadList({bool preRefresh = false}) async{
    if (listState == ListState.HINT_LOADED_FAILED_CLICK ||
        listState == ListState.HINT_NO_DATA_CLICK) {
      preRefresh = true;
    }
    listState = ListState.HINT_LOADING;
    if (preRefresh) notifyListeners();
    listCurrentPage = 1;
    maxCount = false;
    if (list != null) list.clear();
    _getHistoryList();
  }

  Future<void> historyHandleRefresh({bool preRefresh = false}) async {
    loadList(preRefresh: preRefresh);
  }

  quoteRecordHandleLoadMore() {
//    _historyCurrentPage += HttpOptions.pageSize;
    if (!maxCount) {
      _getHistoryList();
    }
  }

  _getHistoryList() {
    Map<String, dynamic> params = new Map();
    params['current'] = listCurrentPage;
    params['pageSize'] = HttpOptions.pageSize;
    HttpUtil.post(HttpOptions.findCustSharePage, _historyCallBack,jsonData: json.encode(params), errorCallBack: _historyErrorCallBack);
  }

  void _historyCallBack(data) {
    try{
      InvitationRecordResponse model = InvitationRecordResponse.fromJson(data);
      if (model.success()) {
        if (model.data != null && model.data.length > 0) {
          listState = ListState.HINT_DISMISS;
          if(listCurrentPage==1){//刷新操作，清空数据再添加（防止多次刷新请求导致数据重复添加）
            list.clear();
          }
          list.addAll(model.data);
          if (model.data.length < HttpOptions.pageSize) maxCount = true;
          else listCurrentPage++;//页面加1，用于加载下一页
        } else {
          if (list == null || list.isEmpty) {
            //nodata
            listState = ListState.HINT_NO_DATA_CLICK;
            list.clear();
          } else {
            //已到列表最底
            maxCount = true;
          }
        }
      } else {
        listState = ListState.HINT_LOADED_FAILED_CLICK;
      }
    }catch(e){
      listState = ListState.HINT_LOADED_FAILED_CLICK;
    }
    notifyListeners();
  }

  void _historyErrorCallBack(errorMsg) {
    listState = ListState.HINT_LOADED_FAILED_CLICK;
    notifyListeners();
  }
}
