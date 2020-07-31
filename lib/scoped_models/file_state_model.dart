
import 'dart:io';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/models/common_result_model.dart';
import 'package:cmp_customer/models/response/base_response.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';

//文件上传管理
mixin FileStateModel on Model {
//  ValueChanged<Map<String, dynamic>> _uploadFileCallback;//文件上传回调，返回两个参数（bool 是否上传成功；string：上传成功时返回文件uuid、上传失败时返回错误信息）
//  ValueChanged<String> _uploadFileError;//文件上传回调，返回两个参数（bool 是否上传成功；string：上传成功时返回文件uuid、上传失败时返回错误信息）
//  String audioFilePath;//录音文件本地路径

  //上传录音文件
  uploadFile(String filePath,final ValueChanged<Map<String, dynamic>> successCallback,final ValueChanged<String> errorCallback,{CancelToken cancelToken}){
    File file = new File(filePath);
    if(file!=null&&file.existsSync()){
//      CommonToast.show();
      FormData formData=new FormData();
      formData.add('file', UploadFileInfo(file,filePath.substring(filePath.lastIndexOf('/'))));
      HttpUtil.post(HttpOptions.fileUpload,(data){
        _uploadAudioSuccess(successCallback,errorCallback,data);
      },formData:formData,
          errorCallBack: (errorData){
        _errorCallBack(errorCallback,errorData);
      },
      cancelToken: cancelToken);
    }else{
      if(errorCallback!=null){
        errorCallback("附件不存在");
      }
    }
  }


  //上传成功回调
  _uploadAudioSuccess(final ValueChanged<Map<String, dynamic>> successCallback,final ValueChanged<String> errorCallback,data) {
//    CommonToast.dismiss();
    try{
      CommonResultModel resultModel = CommonResultModel.fromJson(data);
      if(resultModel.success()&&resultModel.data!=null){
        if(successCallback!=null){
          successCallback(resultModel.data);
        }
      }else{
        if(errorCallback!=null){
          errorCallback(resultModel?.message??"附件上传失败");
        }
      }
    }catch(e){
      if(errorCallback!=null){
        errorCallback("附件上传失败");
      }
    }
  }

  //上传失败
  _errorCallBack(final ValueChanged<String> errorCallback,data){
//    CommonToast.dismiss();
    if(errorCallback!=null){
      errorCallback("附件上传失败");
    }
  }

}
