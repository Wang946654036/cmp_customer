import 'dart:convert';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/models/common_result_model.dart';
import 'package:cmp_customer/models/market/ware_project_response.dart';
import 'package:cmp_customer/models/response/base_response.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/failed_code_trans.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../main.dart';
import '../base_model.dart';

class MarketApplyModel extends BaseModel{

  //发布
  Future<void> uploadData(String jsonData , {Function callback})async{
    CommonToast.show();
    HttpUtil.post(HttpOptions.addWare, (data){
      _uploadDataCallBack(data,callback: callback);
    },
        jsonData: jsonData,errorCallBack: errorCallBack);
  }

  //发布成功
  _uploadDataCallBack(data,{Function callback}){
    CommonToast.dismiss();
    try {
      CommonResultModel resultModel = CommonResultModel.fromJson(data);
      if (resultModel != null) {
        if (resultModel.success()) {
          //请求成功
          if(callback!=null){
            callback(resultModel?.data?.toString());
          }else{
            CommonToast.show(type: ToastIconType.SUCCESS,msg: "发布成功");
          }
        } else {
          CommonToast.show(type: ToastIconType.FAILED,
              msg: resultModel.message ?? "");
        }
      } else {
        CommonToast.show(type: ToastIconType.FAILED, msg: "发布失败");
      }
    }catch(e){
      CommonToast.show(type: ToastIconType.FAILED, msg: "发布异常，参数返回错误");
    }finally{
      notifyListeners();
    }
  }

  //编辑
  Future<void> uploadEditData(String jsonData , {Function callback})async{
    CommonToast.show();
    HttpUtil.post(HttpOptions.editWare, (data){
      successCallBack(data,callback: callback);
    },
        jsonData: jsonData,errorCallBack: errorCallBack);
  }

  ///
  /// 查询登录人房屋所属的项目
  ///
  void queryProjectList({Function callBack}) async {
    HttpUtil.post(HttpOptions.queryProjectList,
            (data) => queryProjectListCallBack(data,callBack: callBack),errorCallBack: errorCallBack);
  }

  void queryProjectListCallBack(data, {Function callBack}) async {
    WareProjectResponse model = WareProjectResponse.fromJson(data);
    if (model.success()) {
      if (model?.data != null) {
        if (callBack != null) {
          callBack(model?.data);
        }
      } else {
        String failedDescri = FailedCodeTrans.enTochsTrans(
            failCode: model.code.toString(), failMsg: model.message);
        errorCallBack(failedDescri);
      }
      notifyListeners();
    }
  }




  static MarketApplyModel of(context) =>
      ScopedModel.of<MarketApplyModel>(context);
}
