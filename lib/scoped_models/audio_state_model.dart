
import 'dart:io';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/common_result_model.dart';
import 'package:cmp_customer/models/response/base_response.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';

//音频状态管理
class AudioStateModel extends Model {
//  Function(bool,String) _uploadAudioCallback;//录音文件上传回调，返回两个参数（bool 是否上传成功；string：上传成功时返回文件uuid、上传失败时返回错误信息）
//  String uuid;//服务器请求返回的uuid
//  String audioFilePath;//录音文件本地路径
  double dbLevel;//录音分贝声音大小

  //设置分贝大小
  setDBLevel(double level){
    dbLevel = level;
    notifyListeners();
  }
//
//  //音频转换成标准的MP3
//  convertAudioFile() async{
////    CommonToast.show(msg: "音频转换中");
//    //在后台执行转换操作
//    stateModel.callNative("audioConvert",object: audioFilePath,callback: (result){
//      CommonToast.dismiss();
//      LogUtils.printLog(result?.toString());
//      if(result=="error"){
//        CommonToast.show(type: ToastIconType.FAILED,msg: "audio convert failed!");
//      }else{
//
//      }
//    });
//  }

//  //上传录音文件
//  uploadAudioFile(Function(bool,String) callback) async{
//    _uploadAudioCallback=callback;
//    String path=audioFilePath;
//    FormData formData=new FormData();
//    formData.add('file', UploadFileInfo(new File(audioFilePath),path.substring(path.lastIndexOf('/'))));
//    HttpUtil.post(HttpOptions.fileUpload,_uploadAudioSuccess,formData:formData,errorCallBack: _errorCallBack);
//  }
//
//
//  //上传成功回调
//  _uploadAudioSuccess(data) {
//    CommonToast.dismiss();
//    try{
//      CommonResultModel resultModel = CommonResultModel.fromJson(data);
//      if(resultModel.success()&&resultModel.data!=null){
//        if(_uploadAudioCallback!=null){
//          uuid=resultModel.data;
//          _uploadAudioCallback(true,uuid);
//        }
//      }else{
//        if(_uploadAudioCallback!=null){
//          _uploadAudioCallback(false,"文件上传失败："+ resultModel.message);
//        }
//      }
//    }catch(e){
//      if(_uploadAudioCallback!=null){
//        _uploadAudioCallback(false,"文件上传失败");
//      }
//    }
//  }
//
//  //上传失败
//  _errorCallBack(data){
//    if(_uploadAudioCallback!=null){
//      _uploadAudioCallback(false,"文件上传异常");
//    }
//  }
}
