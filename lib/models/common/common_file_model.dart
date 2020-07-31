import 'package:dio/dio.dart';

import '../user_data_model.dart';

class CommonFileModel{
  String fileName; //文件名称
  String filePath; //文件路径
  String compressFilePath; //文件路径
  String uuid; //文件的uuid
  String fileState; //文件状态0：等待压缩、1：压缩中、2：压缩失败、3：压缩成功（等待上传）、4：上传中、5：上传失败、6：上传成功
  String fileSource; //（仅适用于图片）文件来源0、拍照、1、选图
  Attachment attachment;//附件对象
  CancelToken cancelToken;//取消上传的token，当用户删除文件时，可取消上传操作
  CommonFileModel({this.fileName,this.filePath,this.uuid,this.fileState,this.fileSource,this.attachment,this.cancelToken });
}