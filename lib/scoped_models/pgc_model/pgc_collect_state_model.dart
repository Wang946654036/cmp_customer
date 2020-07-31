import 'dart:convert';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:flutter/material.dart';

import '../base_model.dart';

class PgcCollectStateModel extends BaseModel{

  //取消收藏
  cancelCollectList(List<int> collectIdList,int type,Function callback) {
    Map<String, Object> params = new Map();
    params['collectIdList'] = collectIdList;//关联id列表
    params['type'] = type;//收藏类型: 0:PGC资讯, 1:话题, 2:集市商品, 3:积分商品, 4:说说;
    HttpUtil.post(HttpOptions.deleteCustomerCollect, (data){
      successCallBack(data,callback: callback);
    },
        jsonData: json.encode(params), errorCallBack: errorCallBack);
  }
}