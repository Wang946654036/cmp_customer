import 'dart:io';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/models/common/common_file_model.dart';
import 'package:cmp_customer/models/common_result_model.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:cmp_customer/models/user_data_model.dart';

import 'file_state_model.dart';

//图片状态管理
class ImagesStateModel extends Model with FileStateModel {
//  List<File> images; //本地图片集合
//  List<String> photoIdList; //图片对应服务器的UUID列表
  ValueChanged<List<String>> callback; //回调函数(图片对应服务器的UUID)
//  List<Attachment> attachmentList;
  ValueChanged<List<Attachment>> callbackWithInfo; //回调函数(服务器返回的对象)
  final int compressSize = 200 * 1024; //压缩后最大的图片大小（单位b）
  List<CommonFileModel> files = List(); //图片列表，用于上传

  initData(
      List<String> photoIdList,
      ValueChanged<List<String>> callback,
      List<Attachment> attachmentList,
      ValueChanged<List<Attachment>> callbackWithInfo) {
    this.callback = callback;
    this.callbackWithInfo = callbackWithInfo;
    if (files == null) {
      files = new List();
    }
    if (attachmentList != null) {
//      this.photoIdList.addAll(this.attachmentList?.map((Attachment attach) => attach?.attachmentUuid)?.toList());
      this.files.addAll(attachmentList?.map((Attachment attach) {
            return new CommonFileModel(
                uuid: attach.attachmentUuid, attachment: attach);
          })?.toList());
    } else if (photoIdList != null) {
      this.files.addAll(photoIdList?.map((String uuid) {
            return new CommonFileModel(uuid: uuid);
          })?.toList());
    }
  }

  Future getCameraImage() async {
    try {
      File image = await ImagePicker.pickImage(source: ImageSource.camera);
      if (image != null) {
        CommonFileModel model = new CommonFileModel(
            filePath: image.path, fileState: '0', fileSource: '0');
        files.add(model);
        notifyListeners();
        imagesCallback();
        files.forEach((CommonFileModel model) {
          _compressImages(model);
        });
//        _compressImages(model);
//        CommonToast.show(msg: "正在压缩图片");
//        File compressImage = await imageCompress(image);
//        CommonToast.dismiss();
//        if (compressImage != null) {
//          _uploadImage(compressImage);
//          image.delete(); //删除原始文件
//        } else {
//          CommonToast.show(msg: "图片压缩失败", type: ToastIconType.FAILED);
//        }
      }
    } on Exception catch (e) {
      if (e.toString().contains('PlatformException')) {
        CommonToast.show(msg: '请打开拍照权限', type: ToastIconType.INFO);
      }
    }
  }

//  //图片选择
//  Future getGalleryImage() async {
//    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
//    if (image != null) {
//      CommonToast.show(msg: "正在压缩图片");
//      File compressImage = await imageCompress(image);
//      CommonToast.dismiss();
//      if (compressImage != null) {
//        _uploadImage(compressImage);
//      } else {
//        CommonToast.show(msg: "图片压缩失败", type: ToastIconType.FAILED);
//      }
//    }
//  }

//  //上传图片
//  _uploadImage(File image) async {
//    CommonToast.show(msg: "上传图片中...");
//    String path = image.path;
////    Map<String, Object> params = new Map();
////    params['file'] = UploadFileInfo(image,path.substring(path.lastIndexOf('/')));
//    FormData formData = new FormData();
//    formData.add('file', UploadFileInfo(image, path.substring(path.lastIndexOf('/') + 1)));
////    ,contentType: ContentType.parse('image/jpeg')
//    HttpUtil.post(HttpOptions.fileUpload, _uploadImageSuccess,
//        formData: formData, errorCallBack: _uploadImageError);
//  }

//  _uploadImageSuccess(data) {
//    CommonToast.dismiss();
//    CommonResultModel resultModel = CommonResultModel.fromJson(data);
//    if (resultModel.success() && resultModel.data != null) {
//      Attachment info = Attachment.fromJson(resultModel.data);
//      attachmentList.add(info);
//      photoIdList.add(info.attachmentUuid);
////      if (callback != null) {
////        callback(photoIdList);
////      }
////      if (callbackWithInfo != null) {
////        callbackWithInfo(attachmentList);
////      }
//      imagesCallback();
////      notifyListeners();
//    } else {
//      //请求失败
//      LogUtils.printLog("图片上传失败：" + resultModel.message);
//      CommonToast.show(type: ToastIconType.FAILED, msg: "图片上传失败：" + resultModel.message);
//    }
//  }

//  _uploadImageError(data) {
//    CommonToast.show(type: ToastIconType.FAILED, msg: "图片上传异常");
//  }

  //图片压缩
  Future<File> imageCompress(CommonFileModel model) async {
    File file = new File(model.filePath);
    if (file == null) {
      return null;
    }
    int length = await file.length();
    LogUtils.printLog("原图大小：" + length.toString());
    Directory externalDir = await getTemporaryDirectory();
    if (length < compressSize) {
      return file;
    } else {
      File result = await FlutterImageCompress.compressAndGetFile(
          file.absolute.path,
          externalDir.path + file.path.substring(file.path.lastIndexOf("/")),
          quality: 50);
      if (result != null) {
        LogUtils.printLog("压缩图大小：" + (await result.length()).toString());
        return result;
      } else {
        return null;
      }
    }
  }

  //移除图片
  removeImage(int index) {
//    if (photoIdList != null&&index<photoIdList.length)
//      photoIdList.removeAt(index);
//    if (attachmentList != null)
//      attachmentList.removeAt(index);
    if (files != null && index < files.length) {
      files.removeAt(index);
      imagesCallback();
    }
  }

  //图片回调
  imagesCallback() {
    if (callback != null) {
      callback(files.map((CommonFileModel model) => model.uuid).toList());
    }
    if (callbackWithInfo != null) {
      callbackWithInfo(
          files.map((CommonFileModel model) => model.attachment).toList());
    }
    notifyListeners();
  }

  //设置选中的图片列表
  setPickerImages(List<AssetEntity> images) async{
    if (images != null && images.isNotEmpty) {
      for(int i=0;i<images.length;i++){
        File filePath=await images[i].file;
        files.add(new CommonFileModel(filePath: filePath.path, fileState: '0', fileSource: '1'));
      }
    }
    notifyListeners();
    imagesCallback();
    files.forEach((CommonFileModel model) {
      _compressImages(model);
    });
  }

  //调用压缩图片
  _compressImages(CommonFileModel model) async {
    if (model.fileState == '0' || model.fileState == '2') {
      model.fileState = '1'; //压缩中
      File compressFile = await imageCompress(model); //先判断压缩
      if (compressFile != null) {
        model.fileState = '3'; //压缩成功
        model.compressFilePath = compressFile.path; //设置压缩路径
        _uploadImages(model);
      } else {
        model.fileState = '2'; //压缩失败
        notifyListeners();
      }
    } else if (model.fileState == '3' || model.fileState == '5') {
      model.fileState = '4'; //上传中
      _uploadImages(model);
    }
  }

  //调用上传图片
  _uploadImages(CommonFileModel model) async {
    uploadFile(model.compressFilePath, (data) {
      LogUtils.printLog("上传成功：uuid=" + data?.toString());
      if (data != null) {
        Attachment info = Attachment.fromJson(data);
        model.fileState = '6'; //上传成功
        model.uuid = info.attachmentUuid; //设置服务器uuid
        model.attachment = info;
        imagesCallback();
//        _deleteImage(model);
      } else {
        model.fileState = '5'; //上传失败
        notifyListeners();
      }
    }, (errorData) {
      model.fileState = '5'; //上传失败
      notifyListeners();
    });
  }

  //重新调用压缩图片
  reCompressImages(CommonFileModel model) async {
    if (model.fileState == '2') {
      model.fileState = '1'; //压缩中
      notifyListeners();
      File compressFile = await imageCompress(model); //先判断压缩
      if (compressFile != null) {
        model.fileState = '3'; //压缩成功
        model.compressFilePath = compressFile.path; //设置压缩路径
        _uploadImages(model);
      } else {
        model.fileState = '2'; //压缩失败
        notifyListeners();
      }
    } else if (model.fileState == '5') {
      model.fileState = '4'; //上传中
      notifyListeners();
      _uploadImages(model);
    }
  }

  //删除图片（防止内存越来越大）
  _deleteImage(CommonFileModel model) {
    try {
      if (model.fileSource == '0') {
        new File(model.filePath).delete();
        new File(model.compressFilePath).delete();
      } else if (model.fileSource == '1' &&
          model.filePath != model.compressFilePath) {
        new File(model.compressFilePath).delete();
      }
    } catch (e) {}
  }

  void dispose() {
    //删除压缩图片
    files.forEach((CommonFileModel model){
      _deleteImage(model);
    });
    //清空
    files.clear();
    files = null;
  }

  static ImagesStateModel of(context) =>
      ScopedModel.of<ImagesStateModel>(context);
}
