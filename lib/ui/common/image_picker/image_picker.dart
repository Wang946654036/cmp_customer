import 'dart:typed_data';

import 'package:cmp_customer/scoped_models/images_picker_state_model.dart';
import 'package:cmp_customer/ui/common/image_picker/image_picker_display.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:scoped_model/scoped_model.dart';
import '../common_load_container.dart';
import '../common_scaffold.dart';
import '../common_text.dart';
import 'image_picker_loading.dart';
import 'image_picker_lru.dart';

part 'package:cmp_customer/ui/common/image_picker/image_picker_item.dart';

enum ImagePickType {
  image,
  audio,
  video,
  all,
}

//通用的文件选择控件
class ImagePickerPage extends StatefulWidget {
  ImagePickType type;
  int maxCount;
  ImagePickerPage(this.type,this.maxCount);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ImagePickerState();
  }
}

class _ImagePickerState extends State<ImagePickerPage> {
  String title; //标题
  ScrollController scrollController;
  ImagesPickerStateModel imagesPickerStateModel;

  //获取标题
  _getTitle() {
    switch (widget.type) {
      case ImagePickType.image:
        title = "图片选择";
        break;
      case ImagePickType.audio:
        title = "音频选择";
        break;
      case ImagePickType.video:
        title = "视频选择";
        break;
      case ImagePickType.all:
        title = "文件选择";
        break;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getTitle();
    scrollController = ScrollController();
    imagesPickerStateModel = new ImagesPickerStateModel(widget.maxCount);
    imagesPickerStateModel.getAssetImage();
//    var result =  PhotoManager.requestPermission();
  }

  _buildMask(bool showMask) {
    return IgnorePointer(
      child: AnimatedContainer(
        color: Colors.black.withOpacity(showMask ? 0.5: 0.0),
        duration: Duration(milliseconds: 300),
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    return ScopedModelDescendant<ImagesPickerStateModel>(
        builder: (context, child, model) {
      AssetEntity entity = model.assetsImageList[index];
      return Stack(
        children: <Widget>[
          ConstrainedBox(
              constraints: BoxConstraints.expand(),
              child: GestureDetector(
                  onTap: () {
                    model.setCurrent(index);
                  //查看大图
                    Navigate.toNewPage(ImagePickerDisplayPage(model,false),callBack: (success){
                      if(success!=null&&success){
                        Navigate.closePage(model.selectedImageList);
                      }
                    });
                  },
                  child: ImagePickerItem(
                    entity: entity,
                    loadingDelegate: ImagePickerLoadingDelegate(),
                  ))),
          _buildMask(model.isChecked(entity)),
          Positioned(
              top: 0,
              right: 0,
              child: Checkbox(
                value: model.isChecked(entity),
                onChanged: (checked) {
                  model.checkedImage(checked, entity);
                },
              )),
        ],
      );
    });
  }

  Widget _buildContent() {
    return Container(
      child: GridView.builder(
        controller: scrollController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: UIData.spaceSize1,
          mainAxisSpacing: UIData.spaceSize1,
        ),
        itemBuilder: _buildItem,
        itemCount: imagesPickerStateModel.assetsImageList?.length ?? 0,
      ),
    );
  }

  Widget _buildBody() {
    return CommonLoadContainer(
      state: imagesPickerStateModel.listState,
      callback: () {
        imagesPickerStateModel.getAssetImage();
      },
      content: _buildContent(),
    );
  }

  //图片目录选择
  Widget _buildBottomSheet() {
    return Container(
      child: ListView.builder(
        itemCount: imagesPickerStateModel.imageDirectoryList.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: CommonText.darkGrey16Text(
                imagesPickerStateModel.imageDirectoryList[index].name),
            onTap: () {
              Navigate.closePage();
              imagesPickerStateModel.setSelectedAssetsIndex(index);
            },
          );
        },
      ),
    );
  }

  //底部导航栏
  Widget _buildBottomNavigationBar() {
    if (imagesPickerStateModel.imageDirectoryList == null ||
        imagesPickerStateModel.imageDirectoryList.length == 0 ||
        imagesPickerStateModel.selectedAssetsIndex < 0) {
      return Container();
    } else {
      AssetPathEntity entity = imagesPickerStateModel
          .imageDirectoryList[imagesPickerStateModel.selectedAssetsIndex];
      return Container(
        color: UIData.primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: ListTile(
                title: CommonText.darkGrey16Text(entity.name ?? ""),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return _buildBottomSheet();
                    },
                  );
                },
              ),
            ),
            Expanded(
              child: ListTile(
                title: CommonText.text16(
                    '预览(${imagesPickerStateModel.selectedImageList?.length ?? 0})',
                    color: (imagesPickerStateModel.selectedImageList?.length ?? 0) > 0
                        ? UIData.themeBgColor
                        : UIData.lightGreyColor,
                    textAlign: TextAlign.right),
                onTap: () {

                  //查看大图
                  Navigate.toNewPage(ImagePickerDisplayPage(imagesPickerStateModel,true),callBack: (success){
                    if(success!=null&&success){
                      Navigate.closePage(imagesPickerStateModel.selectedImageList);
                    }
                  });
                },
              ),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ImagesPickerStateModel>(
        model: imagesPickerStateModel,
        child: ScopedModelDescendant<ImagesPickerStateModel>(
            builder: (context, child, model) {
          return CommonScaffold(
            appTitle: title,
            appBarActions: [
              FlatButton(
                child: CommonText.red15Text('完成(${model.selectedImageList.length}/${widget.maxCount})'),
                onPressed: (){
                  if(model.selectedImageList.length>0){
                    Navigate.closePage(model.selectedImageList);
                  }
                },
              )
            ],
            bodyData: _buildBody(),
            bottomNavigationBar: _buildBottomNavigationBar(),
          );
        }));
  }
}
