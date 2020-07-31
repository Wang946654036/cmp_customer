import 'dart:convert';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/models/dictionary_list.dart';
import 'package:cmp_customer/models/pgc/pgc_infomation_list.dart';
import 'package:cmp_customer/models/pgc/pgc_infomation_obj.dart';
import 'package:cmp_customer/models/response/base_response.dart';
import 'package:cmp_customer/scoped_models/pgc_model/pgc_collect_state_model.dart';
import 'package:cmp_customer/scoped_models/pgc_model/pgc_comment_model.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/failed_code_trans.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../main.dart';

mixin MarketBaseModel on Model{
  List<Dictionary> wareGoodsTypeList;
  //查询商品类型
  Future<void> findWareDataDictionaryList({Function callback,bool showToast = false})async{
    if(showToast){
      CommonToast.show(msg: "正在获取...");
    }
    Map<String, dynamic> params = Map();
    params["dataType"] = "MarketGoodsType";
    HttpUtil.post(HttpOptions.findWareDataDictionaryList, (data){_findWareDataDictionaryListCallBack(data,callback: callback);},jsonData: json.encode(params),errorCallBack: _errorCallBack);
  }

  //查询商品类型成功
  _findWareDataDictionaryListCallBack(data,{Function callback}){
    CommonToast.dismiss();
    try {
      DictionaryList resultModel = DictionaryList.fromJson(data);
      if (resultModel != null) {
        if (resultModel.code == "0") {
          //请求成功
          if(resultModel.data!=null&&resultModel.data.isNotEmpty){
            wareGoodsTypeList = resultModel.data;
            if(callback!=null){
              callback();
            }
          }else{
            wareGoodsTypeList = List();
//            CommonToast.show(type: ToastIconType.FAILED,msg: "暂无商品分类数据");
          }
          return;
        } else {
          _errorCallBack(resultModel.message);
        }
      } else {
        _errorCallBack("无商品信息返回");
      }
    }catch(e){
      _errorCallBack("获取商品类型异常");
    }
  }

  //通用网络请求错误回调
  _errorCallBack(data) {
    CommonToast.dismiss();
    wareGoodsTypeList = null;
//    CommonToast.show(type: ToastIconType.FAILED,msg: data?.toString()??"请求失败");
  }



  static MarketBaseModel of(context) =>
      ScopedModel.of<MarketBaseModel>(context);
}
