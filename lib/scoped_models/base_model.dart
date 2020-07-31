import 'package:cmp_customer/models/response/base_response.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:scoped_model/scoped_model.dart';

class BaseModel extends Model {
  ListState listState = ListState.HINT_LOADING;
  int listCurrentPage = 1;
  bool maxCount = false;
  List list =  new List();


  //通用网络请求错误回调
  errorCallBack(data) {
    CommonToast.show(type: ToastIconType.FAILED,msg: data?.toString()??"请求失败");
  }

  //通用的请求成功
  successCallBack(data,{Function callback}){
    CommonToast.dismiss();
    try {
      BaseResponse resultModel = BaseResponse.fromJson(data);
      if (resultModel != null) {
        if (resultModel.success()) {
          //请求成功
          if(callback!=null){
            callback(true);
          }else{
            CommonToast.show(type: ToastIconType.SUCCESS,msg: "请求成功");
            Navigate.closePage(true);
          }
        } else {
          CommonToast.show(type: ToastIconType.FAILED,
              msg: "提交失败:" + resultModel.message ?? "");
        }
      } else {
        CommonToast.show(type: ToastIconType.FAILED, msg: "提交失败");
      }
    }catch(e){
      CommonToast.show(type: ToastIconType.FAILED, msg: "提交异常，参数返回错误");
    }finally{
      notifyListeners();
    }
  }
}