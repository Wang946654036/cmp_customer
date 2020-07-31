import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class ImagePickerLoading extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Container(
        width: 15,
        height: 15,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(UIData.lightGreyColor),
          strokeWidth: 2,
        ),
      ),
    );;
  }
}

abstract class LoadingDelegate {
  Widget buildBigImageLoading(
      BuildContext context, AssetEntity entity, Color themeColor);

  Widget buildPreviewLoading(
      BuildContext context, AssetEntity entity, Color themeColor);
}

class ImagePickerLoadingDelegate extends LoadingDelegate {
  @override
  Widget buildBigImageLoading(
      BuildContext context, AssetEntity entity, Color themeColor) {
    return ImagePickerLoading();
  }

  @override
  Widget buildPreviewLoading(
      BuildContext context, AssetEntity entity, Color themeColor) {
    return ImagePickerLoading();
  }
}
