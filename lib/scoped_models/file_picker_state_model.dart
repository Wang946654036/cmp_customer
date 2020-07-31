import 'package:cmp_customer/models/common/common_file_model.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/utils/file_format.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

import 'file_state_model.dart';

//文件选择状态管理
class FilePickerStateModel extends Model with FileStateModel {
  List<CommonFileModel> files = List(); //文件列表，用于上传
  ValueChanged<List<Attachment>> callbackWithInfo; //回调函数(服务器返回的对象)

  initData(List<Attachment> attachmentList,
      ValueChanged<List<Attachment>> callbackWithInfo) {
    this.callbackWithInfo = callbackWithInfo;
    if (attachmentList != null) {
      this.files.addAll(attachmentList?.map((Attachment attach) {
            return new CommonFileModel(
                uuid: attach.attachmentUuid, attachment: attach);
          })?.toList());
    }
  }

  //获取本地文件
  getLocalFile() async {
    Map<String, String> list =
        await FilePicker.getMultiFilePath(type: FileType.ANY);
    if(list!=null&&list.isNotEmpty){
      String unsupportFormats;
      list.forEach((String key, String value) {
        int index=key.lastIndexOf('.');
        if(index>=0){
          String format=key.substring(index);
          if(FileFormat.contains(format)){//文件类型允许上传
            files.add(new CommonFileModel(fileName: key,
                filePath: value, fileState: '3',cancelToken: new CancelToken())); //文件类型不能压缩，直接等待上传
          }else{
            if(unsupportFormats == null){
              unsupportFormats = format;
            }else if(!unsupportFormats.contains(format)){
              unsupportFormats += format;
            }
          }
        }
      });
      notifyListeners();
      pickerCallback();
      files.forEach((CommonFileModel model) {
        uploadLocalFile(model);
      });
      if(unsupportFormats!=null){
        CommonToast.show(type: ToastIconType.FAILED,msg: "不支持格式："+unsupportFormats.toString());
      }
    }
  }

  //调用上传文件
  uploadLocalFile(CommonFileModel model) async {
    if (model.fileState == '3' || model.fileState == '5') {
      model.fileState = '4'; //上传中
      notifyListeners();
      uploadFile(model.filePath, (data) {
        LogUtils.printLog("上传成功：uuid=" + data?.toString());
        if (data != null) {
          Attachment info = Attachment.fromJson(data);
          model.fileState = '6'; //上传成功
          model.uuid = info.attachmentUuid; //设置服务器uuid
          model.attachment = info;
          pickerCallback();
        } else {
          model.fileState = '5'; //上传失败
          notifyListeners();
        }
      }, (errorData) {
        model.fileState = '5'; //上传失败
        notifyListeners();
      },
      cancelToken: model.cancelToken);
    }
  }

  //移除文件
  removeFile(CommonFileModel model) {
    if (files != null && model != null) {
      files.remove(model);
      pickerCallback();
      cancelUploadFile(model);
    }
  }

  //取消上传
  cancelUploadFile(CommonFileModel model) async{
    if(model!=null&&model.cancelToken!=null){
      model.cancelToken.cancel();
    }
  }

  //选择回调
  pickerCallback() {
    if (callbackWithInfo != null) {
      callbackWithInfo(
          files.map((CommonFileModel model) => model.attachment).toList());
    }
    notifyListeners();
  }

//  //检查图片是否全部上传成功
//  checkUploadFinish(){
//    if(images==null||images.isEmpty){
//      CommonToast.show(type: ToastIconType.INFO,msg: "请上传图片");
//    }else{
//      bool finish=true;
//      for(int i=0;i<images.length;i++){
//        if(images[i]==null){
//          finish=false;
//          break;
//        }
//      }
//      if(finish){
//        CommonToast.show(type: ToastIconType.INFO, msg: "校验成功");
//      }else{
//        CommonToast.show(type: ToastIconType.INFO, msg: "尚有未上传完成的图片");
//      }
//    }
//  }
}
