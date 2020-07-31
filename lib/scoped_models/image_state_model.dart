import 'dart:io';

import 'package:cmp_customer/utils/log_util.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scoped_model/scoped_model.dart';

import 'file_state_model.dart';

//图片状态管理(web使用)
class ImageStateModel extends Model with FileStateModel {
  final int compressSize = 500 * 1024;

  Future getImage(String type, final Function successCallback,
      final ValueChanged<String> errorCallback,
      {bool compressImage = true}) async {
    File image = await ImagePicker.pickImage(
        source: type == "camera" ? ImageSource.camera : ImageSource.gallery);
    if(image!=null){
      if (compressImage) {
        File file = await _imageCompress(image); //先判断压缩
        uploadFile(file.path, successCallback, errorCallback);
      } else {
        uploadFile(image.path, successCallback, errorCallback);
      }
    }
  }

  //图片压缩
  Future<File> _imageCompress(File file) async {
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

  static ImageStateModel of(context) => ScopedModel.of<ImageStateModel>(context);
}
