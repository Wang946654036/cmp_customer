import 'package:cached_network_image/cached_network_image.dart';
import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/models/common/common_file_model.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/scoped_models/images_portrait_state_model.dart';
import 'package:cmp_customer/scoped_models/images_state_model.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_image_big.dart';
import 'package:cmp_customer/ui/common/common_image_widget.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/image_picker/image_picker.dart';
import 'package:cmp_customer/ui/common/image_picker/image_picker_loading.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/permission_util.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../main.dart';

//图片拍照布局
class PorTraitPicker extends StatefulWidget {
  final String photoId; //图片对应服务器的UUID列表
  final ValueChanged<String> callback; //回调函数(图片对应服务器的UUID)
  final ImagesPortraitStateModel imagesModel; //图片的数据控制器(非不要，若想使用里面的方法，可以传入自定义对象)
  PorTraitPicker({
    this.photoId,
    this.callback,
    this.imagesModel,
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ImagePicker();
  }
}

class _ImagePicker extends State<PorTraitPicker> {
  ImagesPortraitStateModel _stateModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _stateModel = widget.imagesModel ?? new ImagesPortraitStateModel();
    _stateModel.initData(widget.photoId, widget.callback);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _stateModel.dispose();
  }

  Widget _buildBottomSheet() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        ListTile(
          dense: true,
          title: CommonText.black16Text('拍照'),
          onTap: () {
            Navigate.closePage(); //先关闭页面
            _stateModel.getCameraImage();
          },
        ),
        CommonDivider(),
        ListTile(
          dense: true,
          title: CommonText.black16Text('从手机相册里选择'),
          onTap: () {
//            _stateModel.getGalleryImage();
            Navigate.closePage(); //先关闭页面
            PermissionUtil.requestPermission([PermissionGroup.storage, PermissionGroup.photos],
                callback: (bool isGranted) async {
              if (isGranted) {
                Navigate.toNewPage(ImagePickerPage(ImagePickType.image, 1), callBack: (data) {
                  if (data != null) {
                    _stateModel.setPickerImages(data);
                  }
                });
              }
            });
          },
        ),
      ],
    );
  }

  //图片布局
  Widget _buildImage() {
    if (StringsHelper.isUuid(stateModel.portrait)) {
      return GestureDetector(
          onTap: () {
            //查看大图
            Navigate.toNewPage(CommonImageBig(
              [stateModel.portrait],
              defaultIndex: 0,
              indexVisible: false,
            ));
          },
        child: CommonImageWidget(stateModel.portrait,
            loadingImage: UIData.imagePortrait,
            loadedFailedImage: UIData.imagePortrait,
            loadedNoDataImage: UIData.imagePortrait),
//          child: CachedNetworkImage(
//            placeholder: (context, url) => Image.asset(UIData.imagePortrait),
//            errorWidget: (context, url, error) => Image.asset(UIData.imagePortrait),
//            imageUrl: HttpOptions.showPhotoUrl(stateModel.portrait),
//            fit: BoxFit.fill,
//          )
      );
    } else {
      return Image.asset(UIData.imagePortrait);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
        model: _stateModel,
        child: ScopedModelDescendant<ImagesPortraitStateModel>(builder: (context, child, model) {
          return Container(
              color: UIData.primaryColor,
              child: ListTile(
                title: CommonText.grey16Text('头像'),
                trailing: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                        width: ScreenUtil.getInstance().setWidth(34),
                        height: ScreenUtil.getInstance().setWidth(34),
                        child: ClipOval(
                          child: _buildImage(),
                        )),
                    Icon(
                      Icons.keyboard_arrow_right,
                      color: UIData.lighterGreyColor,
                    )
                  ],
                ),
                onTap: (){
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return _buildBottomSheet();
                    },
                  );
                },
              ),
            );
        }));
  }
}
