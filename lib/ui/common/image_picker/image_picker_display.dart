import 'package:cmp_customer/scoped_models/images_picker_state_model.dart';
import 'package:cmp_customer/scoped_models/images_state_model.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:scoped_model/scoped_model.dart';

import '../common_scaffold.dart';
import '../common_text.dart';
import '../common_image_big.dart';
import 'image_picker_big.dart';

//图片选择查看大图
class ImagePickerDisplayPage extends StatefulWidget {
  ImagesPickerStateModel imagesPickerStateModel; //图片列表
  bool isPreview;
  ImagePickerDisplayPage(this.imagesPickerStateModel,this.isPreview);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ImagePickerDisplay();
  }
}

class _ImagePickerDisplay extends State<ImagePickerDisplayPage> {
  List<AssetEntity> imagesList; //图片显示列表
  int defaultIndex; //默认项目

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imagesList = new List();
    if(widget.isPreview){//预览
      imagesList.addAll(widget.imagesPickerStateModel?.selectedImageList);
      defaultIndex = 0;
      widget.imagesPickerStateModel?.setCurrent(0);
    }else{//查看大图
      imagesList.addAll(widget.imagesPickerStateModel?.assetsImageList);
      defaultIndex = widget.imagesPickerStateModel?.current;
    }
  }

  //底部导航栏
  Widget _buildBottomNavigationBar(AssetEntity entity) {
    return Container(
      color: UIData.primaryColor,
      alignment: Alignment.centerRight,
      child: GestureDetector(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            CommonText.red15Text('选择', textAlign: TextAlign.right),
            Checkbox(
              value:  widget.imagesPickerStateModel.isChecked(entity),
              onChanged: (checked) {
                widget.imagesPickerStateModel.checkedImage(checked, entity);
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CommonScaffold(
        appTitle: '图片选择',
        bodyData: ImagePickerBig(
          imagesList,
          defaultIndex: defaultIndex,
          callback: (index) {
            widget.imagesPickerStateModel.setCurrent(index);
          },
        ),
        appBarActions: [
          ScopedModel<ImagesPickerStateModel>(
              model: widget.imagesPickerStateModel,
              child: ScopedModelDescendant<ImagesPickerStateModel>(
                  builder: (context, child, model) {
                return FlatButton(
                  child: CommonText.red15Text(
                      '完成(${model.selectedImageList.length}/${model.maxImageCount})'),
                  onPressed: () {
                    Navigate.closePage(true);
                  },
                );
              }))
        ],
        bottomNavigationBar: ScopedModel<ImagesPickerStateModel>(
            model: widget.imagesPickerStateModel,
            child: ScopedModelDescendant<ImagesPickerStateModel>(
                builder: (context, child, model) {
              return _buildBottomNavigationBar(imagesList[widget.imagesPickerStateModel.current]);
            })));
  }
}
