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

import '../main.dart';
import 'file_state_model.dart';

//头像状态管理
class ImagesPortraitStateModel extends Model with FileStateModel {
  ValueChanged<String> callback; //回调函数(图片对应服务器的UUID)
  final int compressSize = 200 * 1024; //压缩后最大的图片大小（单位b）
  CommonFileModel file = CommonFileModel(); //图片对象，用于上传

  initData(
    String photoId,
    ValueChanged<String> callback,
  ) {
    this.callback = callback;
    if (StringsHelper.isNotEmpty(photoId)) {
      this.file.uuid = photoId;
    }
  }

  Future getCameraImage() async {
    try {
      File image = await ImagePicker.pickImage(source: ImageSource.camera);
      if (image != null) {
        CommonToast.show(msg: '头像上传中');
        file.filePath = image.path;
        file.fileState = '0';
        file.fileSource = '0';
//        notifyListeners();
//        imagesCallback();
        _compressImages(file);
      }
    } on Exception catch (e) {
      if (e.toString().contains('PlatformException')) {
        CommonToast.show(msg: '请打开拍照权限', type: ToastIconType.INFO);
      }
    }
  }

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
          file.absolute.path, externalDir.path + file.path.substring(file.path.lastIndexOf("/")),
          quality: 50);
      if (result != null) {
        LogUtils.printLog("压缩图大小：" + (await result.length()).toString());
        return result;
      } else {
        return null;
      }
    }
  }

  //图片回调
  imagesCallback(String uuid) {
    if (callback != null) {
      callback(uuid);
    }
//    notifyListeners();
  }

  //设置选中的图片列表
  setPickerImages(List<AssetEntity> images) async {
    if (images != null && images.isNotEmpty) {
      CommonToast.show(msg: '头像上传中');
      File filePath = await images[0].file;
      file.filePath = filePath.path;
      file.fileState = '0';
      file.fileSource = '1';
    }
//    notifyListeners();
//    imagesCallback();
    _compressImages(file);
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
        CommonToast.show(msg: '头像压缩失败', type: ToastIconType.INFO);
//        notifyListeners();
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
        imagesCallback(model.uuid);
        _deleteImage(model);
      } else {
        model.fileState = '5'; //上传失败
        CommonToast.show(msg: '头像上传失败', type: ToastIconType.INFO);
//        notifyListeners();
      }
    }, (errorData) {
      model.fileState = '5'; //上传失败
      CommonToast.show(msg: '头像上传失败', type: ToastIconType.INFO);
//      notifyListeners();
    });
  }

  //重新调用压缩图片
  reCompressImages(CommonFileModel model) async {
    if (model.fileState == '2') {
      model.fileState = '1'; //压缩中
//      notifyListeners();
      File compressFile = await imageCompress(model); //先判断压缩
      if (compressFile != null) {
        model.fileState = '3'; //压缩成功
        model.compressFilePath = compressFile.path; //设置压缩路径
        _uploadImages(model);
      } else {
        model.fileState = '2'; //压缩失败
//        notifyListeners();
      }
    } else if (model.fileState == '5') {
      model.fileState = '4'; //上传中
//      notifyListeners();
      _uploadImages(model);
    }
  }

  //删除图片（防止内存越来越大）
  _deleteImage(CommonFileModel model) {
    try {
      if (model.fileSource == '0') {
        new File(model.filePath).delete();
        new File(model.compressFilePath).delete();
      } else if (model.fileSource == '1' && model.filePath != model.compressFilePath) {
        new File(model.compressFilePath).delete();
      }
    } catch (e) {}
  }

  void dispose() {
    //删除压缩图片
//    files.forEach((CommonFileModel model) {
//      _deleteImage(model);
//    });
//    //清空
//    files.clear();
//    files = null;
  }

  static ImagesPortraitStateModel of(context) => ScopedModel.of<ImagesPortraitStateModel>(context);
}
