import 'dart:io';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/models/common_result_model.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:scoped_model/scoped_model.dart';

import 'base_model.dart';

//图片选择状态管理
class ImagesPickerStateModel extends BaseModel {
  List<AssetPathEntity> imageDirectoryList;//目录列表
  int selectedAssetsIndex = -1;//选中的清单列表
  List<AssetEntity> assetsImageList;//图片列表
  List<AssetEntity> selectedImageList =  new List();//图片列表
  int maxImageCount = 0;//图片选择的最大张数
  int current;//当前显示的位置

  ImagesPickerStateModel(this.maxImageCount);

  //获取图片列表
  getAssetImage() async{
    imageDirectoryList = await PhotoManager.getImageAsset();
    if(imageDirectoryList!=null&&imageDirectoryList.length>0){
      for (var path in imageDirectoryList) {
        if (path.isAll) {
          path.name = "全部图片";
        }
      }
      setSelectedAssetsIndex(0);
    }
    listState = ListState.HINT_DISMISS;
    notifyListeners();
  }

  //设置选中的图片目录
  setSelectedAssetsIndex(int index) async{
    selectedAssetsIndex = index ;
    assetsImageList = await imageDirectoryList[index].assetList;
    assetsImageList.sort((before,after)=>after.createTime.compareTo(before.createTime));
    notifyListeners();
  }

  //选中或取消图片
  checkedImage(bool checked,AssetEntity entity){
    if(checked){
      if(selectedImageList.length>=maxImageCount){
        CommonToast.show(type: ToastIconType.INFO,msg: "最多选择$maxImageCount张");
      }else{
        selectedImageList.add(entity);
      }
    }else{
      selectedImageList.remove(entity);
    }
    notifyListeners();
  }

  //移除全部已选图片
  clearCheckedImage(){
    selectedImageList.clear();
  }

  //判断图片是否选中
  isChecked(AssetEntity entity){
    return selectedImageList.contains(entity);
  }

  //设置当前位置
  setCurrent(int current) {
    this.current=current;
    notifyListeners();
  }

//  //设置选择最多的图片张数
//  setMaxImageCount(int maxCount){
//    maxImageCount = maxCount;
//  }

//  static ImagesStateModel of(context) => ScopedModel.of<ImagesStateModel>(context);
}
