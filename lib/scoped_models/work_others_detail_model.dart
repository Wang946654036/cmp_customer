import 'dart:convert';
import 'dart:io';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/brand_name_obj.dart';
import 'package:cmp_customer/models/common_result_model.dart';
import 'package:cmp_customer/models/dictionary_list.dart';
import 'package:cmp_customer/models/pay_service_info_list.dart';
import 'package:cmp_customer/models/pay_service_info_obj.dart';
import 'package:cmp_customer/models/project_setting_model.dart';
import 'package:cmp_customer/models/request/entrance_card_apply_request.dart';
import 'package:cmp_customer/models/response/entrance_card_house_response.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/models/work_order_vo.dart';
import 'package:cmp_customer/models/work_other_list.dart';
import 'package:cmp_customer/models/work_other_obj.dart';
import 'package:cmp_customer/models/work_task.dart';
import 'package:cmp_customer/ui/common/common_audio.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/work_other/work_other_ui.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/failed_code_trans.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:scoped_model/scoped_model.dart';

mixin WorkOthersDetailModel on Model{
  ListState workOtherDetailLoadState = ListState.HINT_LOADING;
  ListState workOtherChooseHouseState = ListState.HINT_LOADING;
  ListState workOthersAddWorkerModelLoadState = ListState.HINT_LOADING;
  ListState workOtherCommitState = ListState.HINT_DISMISS;
  ListState workOtherCreateState = ListState.HINT_DISMISS;
  ListState workOtherFreeBackCommitState = ListState.HINT_DISMISS;
  WorkOtherMainType complaintType;
  WorkOther workOther;
  PayServiceInfo payServiceInfo;
  ListState showPayInfo=ListState.HINT_LOADING;
  int _historyCurrentPage = 1;
  bool historyMaxCount = false;
bool hasUpload = false;

commitOther() async{
  CommonToast.show();
}

  void commitWorkTask({
    @required WorkTask task,
    VoidCallback callBack,

  }) async {
    CommonToast.show();
    if(workOtherCommitState !=  ListState.HINT_LOADING) {
      String jsonData = json.encode(task);
      workOtherCommitState=ListState.HINT_LOADING;
      HttpUtil.post(
          HttpOptions.processWorkTaskUrl,
              (data) {
            _commitOpoerationCallBack(data, callBack);
          },
          jsonData: jsonData,
          errorCallBack: (errorMsg) {
            _commitOpoerationErrorCallBack(errorMsg);
          });
    }
  }

  void _commitOpoerationCallBack(data ,callBack ) {
    CommonResultModel model = CommonResultModel.fromJson(data);
    LogUtils.printLog('发布工单:${json.encode(data)}');
    if (model.code == '0') {
      CommonToast.show(msg: '发布成功', type: ToastIconType.SUCCESS);
      if(callBack!=null)
        callBack();
      else{
        navigatorKey.currentState.pop(true);
      }
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
      CommonToast.show(msg: failedDescri, type: ToastIconType.FAILED);
    }
    workOtherCommitState =  ListState.HINT_DISMISS;
    notifyListeners();
  }

  void _commitOpoerationErrorCallBack(errorMsg) {
    LogUtils.printLog('接口返回失败');
    CommonToast.show(msg: errorMsg, type: ToastIconType.FAILED);
    workOtherCommitState =  ListState.HINT_DISMISS;
    notifyListeners();
  }

Future<void>    getWorkOthersDetail(int id) async{
    workOtherDetailLoadState = ListState.HINT_LOADING;
    notifyListeners();
    Map<String, int> params = new Map();
    params['workOrderId'] = id;
    params['customerId'] = stateModel.customerId;
    HttpUtil.post(HttpOptions.pendingOrderDetailUrl, _getDetailCallBack,
        jsonData: json.encode(params), errorCallBack: _getDetailErrorCallBack);
  }
Future<void>   getPayinfo(int serviceConfigId) async{
  Map<String, dynamic> params = {'serviceConfId':serviceConfigId};
  HttpUtil.post(HttpOptions.queryServiceConfigDetailUrl, _getPayInfoCallBack,
      jsonData: json.encode(params), errorCallBack: _getInfoErrorCallBack);
}

  _getDetailCallBack(data) {
    WorkOtherObj workotherobj = WorkOtherObj.fromJson(data);
    LogUtils.printLog('工单列表:$data');
    if (workotherobj.code == '0') {
      if (workotherobj.data != null) {
        workOtherDetailLoadState = ListState.HINT_DISMISS;
        workOther = workotherobj.data;
        if(workOther.paidServiceId!=null){
          getPayinfo(workOther.paidServiceId);
return;
        }
      } else {
        //nodata
        workOtherDetailLoadState = ListState.HINT_NO_DATA_CLICK;
      }
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(
          failCode: workotherobj.code.toString(),
          failMsg: workotherobj.message);
      workOtherDetailLoadState = ListState.HINT_LOADED_FAILED_CLICK;
      LogUtils.printLog('工单获取失败:' + failedDescri);
    }

    notifyListeners();
  }
  _getPayInfoCallBack(data) {
    PayServiceInfoObj payServiceInfoObj = PayServiceInfoObj.fromJson(data);
    LogUtils.printLog('工单列表:$data');
    if (payServiceInfoObj.code == '0') {
      if (payServiceInfoObj.data != null) {
        showPayInfo = ListState.HINT_DISMISS;
        payServiceInfo = payServiceInfoObj.data;

      } else {
        //nodata
        showPayInfo = ListState.HINT_NO_DATA_CLICK;
      }
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(
          failCode: payServiceInfoObj.code.toString(),
          failMsg: payServiceInfoObj.message);
      showPayInfo = ListState.HINT_LOADED_FAILED_CLICK;
      LogUtils.printLog('工单获取失败:' + failedDescri);
    }

    notifyListeners();
  }
  void _getDetailErrorCallBack(errorMsg) {
    LogUtils.printLog('接口返回失败');
    workOtherDetailLoadState = ListState.HINT_DISMISS;
    notifyListeners();
  }
  void _getInfoErrorCallBack(errorMsg) {
    LogUtils.printLog('接口返回失败');
    showPayInfo = ListState.HINT_LOADED_FAILED_CLICK;
    notifyListeners();
  }
  cleanWorkOthersDetailModel(){
//     workOtherDetailLoadState = ListState.HINT_LOADING;
//     complaintType=null;
//     workOther=null;
//     payServiceInfo;
//     showPayInfo=ListState.HINT_LOADING;
//     _historyCurrentPage = 1;
//     historyMaxCount = false;
  }

  void commitWorkOther({
    @required WorkOrderVo workOther,
    Function callBack,
  }) async {
    if(workOther.workOrderVoiceList!=null&&workOther.workOrderVoiceList.length>0&&workOther.workOrderVoiceList[0]!=null&&!hasUpload){
      if(Platform.isAndroid&&workOther.workOrderVoiceList[0].endsWith(CommonAudio.androidAudioFormat)){
        convertAudioFile(workOther , callBack);
      }else{
        uploadAudioFile(workOther , callBack);
      }
    }
    else
      _commitWorkOtherAfterAudioUpload(workOther,callBack);
  }
  //提交反馈
  void commitFeedback({
    @required Map<String , dynamic> feedbackInfo,
    Function callBack,
  }) async {
    CommonToast.show();
    if(workOtherFreeBackCommitState != ListState.HINT_LOADING) {
      String jsonData = json.encode(feedbackInfo);
      workOtherFreeBackCommitState = ListState.HINT_LOADING;

      HttpUtil.post(
          HttpOptions.createCustomerFeedback,
              (data) {
            _commitCreateCallBack(data, callBack,2);
          },
          jsonData: jsonData,
          errorCallBack: (errorMsg) {
            _commitCreateErrorCallBack(errorMsg,2);
          });
    }
  }


  void _commitWorkOtherAfterAudioUpload( @required WorkOrderVo workOther,
      Function callBack,){
    workOther.draftFlag = '2';

    String jsonData = json.encode(workOther);
    CommonToast.show();
if(workOtherCreateState!=ListState.HINT_LOADING) {
  workOtherCreateState = ListState.HINT_LOADING;
  notifyListeners();
  HttpUtil.post(
      HttpOptions.createWorkOrderUrl,
          (data) {
        _commitCreateCallBack(data, callBack, 1);
      },
      jsonData: jsonData,
      errorCallBack: (errorMsg) {
        _commitCreateErrorCallBack(errorMsg, 1);
      });
}
  }


  void _commitCreateCallBack(data ,callBack,final int flag) {
    CommonResultModel model = CommonResultModel.fromJson(data);
    LogUtils.printLog('发布工单:${json.encode(data)}');
    if (model.code == '0') {
      CommonToast.show(msg: '发布成功，感谢您的支持，我们将竭力为您服务', type: ToastIconType.SUCCESS);
      if(callBack!=null)
        callBack();
      else
        navigatorKey.currentState.pop();
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
      CommonToast.show(msg: failedDescri, type: ToastIconType.FAILED);
    }
    if(flag==1)
      workOtherCreateState = ListState.HINT_DISMISS;
    else{
      workOtherFreeBackCommitState = ListState.HINT_DISMISS;
    }
    notifyListeners();
  }

  void _commitCreateErrorCallBack(errorMsg,final int flag) {
    LogUtils.printLog('接口返回失败');
    CommonToast.show(msg: errorMsg, type: ToastIconType.FAILED);
    if(flag==1)
      workOtherCreateState = ListState.HINT_DISMISS;
    else{
      workOtherFreeBackCommitState = ListState.HINT_DISMISS;
    }
    notifyListeners();
  }

  //音频转换成标准的MP3
  convertAudioFile(WorkOrderVo vo,Function callback) async{
    CommonToast.show(msg: "音频转换中");
    stateModel.callNative("audioConvert",object: vo.workOrderVoiceList[0],callback: (String result){
      CommonToast.dismiss();
      if(result==null||result.contains("error")){
        CommonToast.show(type: ToastIconType.FAILED,msg: result??"convert audio fail !");
      }else{
        new File(vo.workOrderVoiceList[0])?.delete();//删除原始文件
        vo.workOrderVoiceList[0]=result;//修改成转换后的文件
        uploadAudioFile(vo,callback);
      }
    });
  }

  //上传录音文件
  uploadAudioFile(WorkOrderVo vo ,Function callback){
    File file = new File(vo.workOrderVoiceList[0]);
    if(file!=null&&file.existsSync()){
      CommonToast.show();
      FormData formData=new FormData();
      formData.add('file', UploadFileInfo(file,vo.workOrderVoiceList[0].substring(vo.workOrderVoiceList[0].lastIndexOf('/'))));
      HttpUtil.post(HttpOptions.fileUpload,(data){
        _uploadAudioSuccess(data,vo,callback);
      },formData:formData,errorCallBack: _errorCallBack);
    }else{
      CommonToast.show(type: ToastIconType.FAILED,msg: "file does not exist !");
    }
  }


  //上传成功回调
  _uploadAudioSuccess(data,WorkOrderVo vo,Function callback) {
    CommonToast.dismiss();
    try{
      CommonResultModel resultModel = CommonResultModel.fromJson(data);
      if(resultModel.success()&&resultModel.data!=null){
        hasUpload = true;
        vo.workOrderVoiceList.clear();
        vo.workOrderVoiceList.add(Attachment.fromJson(resultModel.data).attachmentUuid);
        _commitWorkOtherAfterAudioUpload(vo,callback);
      }else{
        CommonToast.show(type: ToastIconType.FAILED,msg: "file upload failed："+ resultModel.message);
      }
    }catch(e){
      CommonToast.show(type: ToastIconType.FAILED,msg: "file upload failed");
    }
  }

  //上传失败
  _errorCallBack(data){
    CommonToast.dismiss();
    CommonToast.show(type: ToastIconType.INFO,msg: data);
  }
  //上传失败
  _errorEntranceHouseCallBack(data){
    workOtherChooseHouseState = ListState.HINT_LOADED_FAILED_CLICK;
    CommonToast.show(type: ToastIconType.FAILED,msg:"获取房屋列表失败"+data);
 notifyListeners();
  }
  //获取房屋列表
  getHouseListInpay(Function callback){
    workOtherChooseHouseState = ListState.HINT_LOADING;
    notifyListeners();
    EntranceCardApplyRequest request = new EntranceCardApplyRequest();
    request.projectId=stateModel.defaultProjectId;
    HttpUtil.post(HttpOptions.houseCertifiedList, (data){_getEntranceHouseCallBack(data,callback);},
        jsonData: json.encode(request),errorCallBack: _errorEntranceHouseCallBack);
  }

  //获取房屋列表成功
  _getEntranceHouseCallBack(data,Function callback){
    try{
      EntranceCardHouseResponse response = EntranceCardHouseResponse.fromJson(data);
      if(response.success()){
        List<HouseInfo> houseList;
        houseList=response.houseList;
        if(houseList!=null&&houseList.length>0){
          if(callback!=null){
            callback(houseList);
          }
          workOtherChooseHouseState = ListState.HINT_DISMISS;

        }
        else{
          workOtherChooseHouseState = ListState.HINT_NO_DATA_CLICK;
        }

      }else{
        workOtherChooseHouseState = ListState.HINT_LOADED_FAILED_CLICK;
        CommonToast.show(type: ToastIconType.FAILED,msg: "获取房屋列表失败："+response?.message?.toString());
      }
    }catch(e){
      workOtherChooseHouseState = ListState.HINT_LOADED_FAILED_CLICK;
      CommonToast.show(type: ToastIconType.FAILED,msg:"获取房屋列表失败");
    }
    notifyListeners();
  }
  reflush(){

    workOthersAddWorkerModelLoadState = ListState.HINT_DISMISS;
    notifyListeners();
  }

//  userAllCheck(){
//    dispatchUser.forEach((info){
//      info.isCheck=true;
//    });
//    notifyListeners();
//  }

  void checkOutDataDictionaryList({

    @required Map<String,dynamic> dataMap,
    Function callBack,
  }) async {
    workOthersAddWorkerModelLoadState = ListState.HINT_LOADING;
    notifyListeners();
    String jsonData = json.encode(dataMap);
    HttpUtil.post(
        HttpOptions.findDataDictionaryList,
            (data) {
          _checkOutDataDictionaryListCallBack(data,callBack);
        },
        jsonData: jsonData,
        errorCallBack: (errorMsg) {
          _checkOutDataDictionaryListErrorCallBack(errorMsg);
        });
  }

  void _checkOutDataDictionaryListCallBack(data ,callBack) {
    DictionaryList model = DictionaryList.fromJson(data);
    LogUtils.printLog('字典信息:${json.encode(data)}');
    if (model.code == '0') {
      if(model.data!=null&&model.data.length>0){
        workOthersAddWorkerModelLoadState = ListState.HINT_DISMISS;
      }else{
        workOthersAddWorkerModelLoadState = ListState.HINT_NO_DATA_CLICK;
      }
      if(callBack!=null){
        callBack(model.data);
      }
    } else {
      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
      workOthersAddWorkerModelLoadState = ListState.HINT_LOADED_FAILED_CLICK;
      LogUtils.printLog('详情获取失败:' + failedDescri);
    }
    notifyListeners();
  }

  void _checkOutDataDictionaryListErrorCallBack(errorMsg) {
    LogUtils.printLog('接口返回失败');
    workOthersAddWorkerModelLoadState = ListState.HINT_LOADED_FAILED_CLICK;
    notifyListeners();
  }


  void queryProjectSettingDetail({
    Function callBack,
  }) async {
    workOthersAddWorkerModelLoadState = ListState.HINT_LOADING;
    notifyListeners();
    String jsonData = json.encode({'projectId': stateModel.defaultProjectId});
    HttpUtil.post(
        HttpOptions.hotWorkSettingUrl,
            (data) {
              _queryProjectSettingDetailCallBack(data,callBack);
        },
        jsonData: jsonData,
        errorCallBack: (errorMsg) {
          _queryProjectSettingDetailErrorCallBack(errorMsg);
        });
  }

  void _queryProjectSettingDetailCallBack(data ,callBack) {

    LogUtils.printLog('项目个性化设置详情:${json.encode(data)}');



    ProjectSettingModel model = ProjectSettingModel.fromJson(data);
    if (model.code == '0') {
      if (model?.projectSetting?.settingDetailList != null && model.projectSetting.settingDetailList.length > 0) {
        SettingDetail settingDetail = model.projectSetting.settingDetailList
            .firstWhere((SettingDetail detail) => detail?.typeCode == 'DECORATE_ESTIMATE_PERIOD', orElse: () => null);

        if (settingDetail != null) {
          workOthersAddWorkerModelLoadState = ListState.HINT_DISMISS;
          if (callBack != null) callBack(settingDetail?.settingVoList);
        }else{
          workOthersAddWorkerModelLoadState = ListState.HINT_NO_DATA_CLICK;
        }
      }else{
        workOthersAddWorkerModelLoadState = ListState.HINT_NO_DATA_CLICK;
      }
    }else {
      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
      workOthersAddWorkerModelLoadState = ListState.HINT_LOADED_FAILED_CLICK;
      LogUtils.printLog('详情获取失败:' + failedDescri);
    }
    notifyListeners();
  }

  void _queryProjectSettingDetailErrorCallBack(errorMsg) {
    LogUtils.printLog('接口返回失败');
    workOthersAddWorkerModelLoadState = ListState.HINT_LOADED_FAILED_CLICK;
    notifyListeners();
  }

  static WorkOthersDetailModel of(context) =>
      ScopedModel.of<WorkOthersDetailModel>(context);
}
