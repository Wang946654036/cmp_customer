import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';

final String scrawlImagePath = '/screen_shot_scraw.png';

Future<File> getScreenShotFile() async {
  Directory tempDir = await getTemporaryDirectory();
  String tempPath = '${tempDir.path}$scrawlImagePath';
  File image = File(tempPath);
  bool isExist = await image.exists();
  return isExist ? image : null;
}

Future saveScreenShot2SDCard(RenderRepaintBoundary boundary, {Function success, Function fail}) async {
  // check storage permission.
//  if(Platform.isAndroid){
//    PermissionUtil.requestPermission([PermissionGroup.storage], callback: (bool isGranted) {
//      if (isGranted) {
//        saveScreenShot2DataDir(boundary, success: success, fail: fail);
//      } else {
//        CommonToast.show(msg: '请打开读写文件权限', type: ToastIconType.INFO);
//      }
//    });
//  }else {
    saveScreenShot2DataDir(boundary, success: success, fail: fail);
//  }

}

void saveScreenShotUint8List2DataDir(Uint8List uint8List, {Function success, Function fail}) async{
    Directory tempDir = await getApplicationDocumentsDirectory();
    _saveImage(uint8List, Directory('${tempDir.path}/flutter_ui'), '/screen_shot_scraw_${DateTime.now()}.png',
        success: success, fail: fail);
}

void saveScreenShot2DataDir(RenderRepaintBoundary boundary, {Function success, Function fail}){
  capturePng2List(boundary).then((uint8List) async {
    if (uint8List == null || uint8List.length == 0) {
      if (fail != null) fail();
      return;
    }
    Directory tempDir = await getApplicationDocumentsDirectory();
    _saveImage(uint8List, Directory('${tempDir.path}/flutter_ui'), '/screen_shot_scraw_${DateTime.now()}.png',
        success: success, fail: fail);
  });
}

void saveScreenShot2TempDir(RenderRepaintBoundary boundary, {Function success, Function fail}) {
  capturePng2List(boundary).then((uint8List) async {
    if (uint8List == null || uint8List.length == 0) {
      if (fail != null) fail();
      return;
    }
    Directory tempDir = await getTemporaryDirectory();
    _saveImage(uint8List, tempDir, scrawlImagePath, success: success, fail: fail);
  });
}

void _saveImage(Uint8List uint8List, Directory dir, String fileName, {Function success, Function fail}) async {
  bool isDirExist = await Directory(dir.path).exists();
  if (!isDirExist) Directory(dir.path).create();
  String tempPath = '${dir.path}$fileName';
  File image = File(tempPath);
  bool isExist = await image.exists();
  if (isExist) await image.delete();
  File(tempPath).writeAsBytes(uint8List).then((_) {
    if (success != null) success(tempPath);
  });
}

Future<Uint8List> capturePng2List(RenderRepaintBoundary boundary) async {
  ui.Image image = await boundary.toImage();
  ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  Uint8List pngBytes = byteData.buffer.asUint8List();
  return pngBytes;
}
