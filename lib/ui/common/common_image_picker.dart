import 'package:cached_network_image/cached_network_image.dart';
import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/models/common/common_file_model.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/scoped_models/images_state_model.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_image_big.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/image_picker/image_picker.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/permission_util.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scoped_model/scoped_model.dart';

import 'common_image_widget.dart';
import 'image_picker/image_picker_loading.dart';

//图片拍照布局
class CommonImagePicker extends StatefulWidget {
  int maxCount; //限制最大张数
  List<Attachment> attachmentList;
  ValueChanged<List<Attachment>> callbackWithInfo;
  List<String> photoIdList; //图片对应服务器的UUID列表
  ValueChanged<List<String>> callback; //回调函数(图片对应服务器的UUID)
  bool enableAddImage; //是否允许增加照片（默认true）
  ImagesStateModel imagesModel; //图片的数据控制器(非不要，若想使用里面的方法，可以传入自定义对象)
  int crossAxisCount; //每一行显示的个数（默认5个，如果是流程节点，可调整设置成4个）
  CommonImagePicker({
    this.maxCount = 5,
    this.photoIdList,
    this.callback,
    this.attachmentList,
    this.callbackWithInfo,
    this.enableAddImage = true,
    this.imagesModel,
    this.crossAxisCount = 5,
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _imagePicker();
  }
}

class _imagePicker extends State<CommonImagePicker> {
  ImagesStateModel _stateModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _stateModel = widget.imagesModel ?? new ImagesStateModel();
    _stateModel.initData(widget.photoIdList, widget.callback,
        widget.attachmentList, widget.callbackWithInfo);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _stateModel.dispose();
  }

  Widget _buildBottomSheet() {
    FocusScope.of(context).requestFocus(FocusNode());
    return
//      Container(
//      child:
        Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
//          GestureDetector(
//            onTap: (){
//              _stateModel.getCameraImage();
//              Navigator.pop(context);
//            },
//            child:Container(
//              padding: EdgeInsets.symmetric(vertical:ScreenUtil.getInstance().setHeight(16)),
////              alignment: Alignment.center,
//              child:  CommonText.black16Text("拍照"),
//            )
//          ),
//          CommonDivider(),
//          GestureDetector(
//              onTap: (){
//                _stateModel.getGalleryImage();
//                Navigator.pop(context);
//              },
//              child:Container(
//                padding: EdgeInsets.symmetric(vertical:ScreenUtil.getInstance().setHeight(16)),
////                alignment: Alignment.center,
//                child:  CommonText.black16Text("本地图片"),
//              )
//          ),

        ListTile(
          dense: true,
          title: CommonText.black16Text('拍照'),
          onTap: () {
//              _getImage(context: context, callback: callback);
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
            PermissionUtil.requestPermission([PermissionGroup.storage,PermissionGroup.photos],
                callback: (bool isGranted) async {
              if (isGranted) {
                Navigate.toNewPage(
                    ImagePickerPage(ImagePickType.image,
                        widget.maxCount - (_stateModel.files?.length ?? 0)),
                    callBack: (data) {
                  if (data != null) {
                    _stateModel.setPickerImages(data);
                  }
                });
              }
            });
          },
        ),
      ],
//      ),
    );
  }

  //图片布局
  Widget _buildImage(final CommonFileModel model, int index) {
    if (StringsHelper.isUuid(model.uuid)) {
      return GestureDetector(
          onTap: () {
            //查看大图
            Navigate.toNewPage(CommonImageBig(
              _stateModel.files
                  .map((CommonFileModel model) =>
                      model.uuid ?? model.filePath ?? model.compressFilePath)
                  .toList(),
              defaultIndex: index,
            ));
          },
        child: CommonImageWidget(model.uuid, loadingImage: UIData.imageImageLoading, loadedFailedImage: UIData.imageImageLoadFail),
//          child: CachedNetworkImage(
//            placeholder: (context, url) =>
//                Image.asset(UIData.imageImageLoading),
//            errorWidget: (context, url, error) =>
//                Image.asset(UIData.imageImageLoadFail),
//            imageUrl: HttpOptions.showPhotoUrl(model.uuid),
//            fit: BoxFit.fill,
//          )
      );
//    }else if(model?.fileState==){
//      return Image.file(new File(model.compressFilePath),fit: BoxFit.fill,);
    } else if (model.fileState == '2' || model.fileState == '5') {
      return Container(
          color: UIData.scaffoldBgColor,
          alignment: Alignment.center,
          child: IconButton(
//        iconSize: 20,
            icon: Icon(
              Icons.error_outline,
              size: 20,
              color: UIData.themeBgColor,
            ),
            onPressed: () {
              _stateModel.reCompressImages(model);
            },
          ));
    } else if (model.fileState != '2' && model.fileState != '5') {
      return Container(
          color: UIData.scaffoldBgColor,
          alignment: Alignment.center,
          child: ImagePickerLoading());
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
        model: _stateModel,
        child: ScopedModelDescendant<ImagesStateModel>(
            builder: (context, child, model) {
          return GridView.builder(
            physics: new NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.crossAxisCount,
              mainAxisSpacing: UIData.spaceSize12,
              crossAxisSpacing: UIData.spaceSize12,
            ),
            itemCount: _getImageLength() +
                (widget.enableAddImage
                    ? ((_stateModel?.files?.length ?? 0) < widget.maxCount
                        ? 1
                        : 0)
                    : 0),
            itemBuilder: (BuildContext context, int index) {
              if (_isAddImage(index)) {
                return GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return _buildBottomSheet();
                      },
                    );
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: ScreenUtil.getInstance().setWidth(1),
                              color: UIData.dividerColor)),
                      child: Icon(
                        Icons.photo_camera,
                        color: UIData.greyColor,
                      )),
                );
              } else {
                return Stack(
                  children: <Widget>[
                    ConstrainedBox(
                        constraints: BoxConstraints.expand(),
                        child: _buildImage(_stateModel.files[index], index)),
                    Visibility(
                      visible: widget.enableAddImage,
                      child: Positioned(
                          top: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              _stateModel.removeImage(index);
                            },
                            child: Icon(
                              Icons.cancel,
                              color: UIData.lightGreyColor,
                              size: ScreenUtil.getInstance().setWidth(20),
                            ),
                          )),
                    )
                  ],
                );
              }
            },
          );
        }));
  }

  _isAddImage(int index) {
    return _stateModel.files == null || _stateModel.files.length == index;
  }

  //获取图片张数，不能操过最大张数
  _getImageLength() {
    return _stateModel.files.length > widget.maxCount
        ? widget.maxCount
        : _stateModel.files.length;
  }

//  static showPhotoSelectBottomSheet({@required BuildContext context, Function callback}) {
//    showModalBottomSheet(
//        context: context,
//        builder: (BuildContext context) {
//          return BottomSheet(
//              onClosing: () {},
//              builder: (BuildContext context) {
//                return Column(
//                  crossAxisAlignment: CrossAxisAlignment.stretch,
//                  mainAxisSize: MainAxisSize.min,
//                  children: <Widget>[
//                    ListTile(
//                      dense: true,
//                      title: CommonText.red16Text('拍照'),
//                      onTap: (){
//                        _getImage(context: context, callback: callback);
//                      },
//                    ),
//                    Container(
//                      height: 1.0,
//                      color: UIData.dividerColor,
//                    ),
//                    ListTile(
//                      dense: true,
//                      title: CommonText.darkGrey16Text('从手机相册里选择', textAlign: TextAlign.center),
//                      onTap: () {
//                        _getImage(context: context, imageSource: ImageSource.gallery, callback: callback);
//                      },
//                    ),
//                              Container(
//                                color: Colors.black54,
//                                height: UIData.spaceSize8,
//                              ),
//                              Container(
//                                color: UIData.primaryColor,
//                                child: ListTile(
//                                dense: true,
////                              contentPadding: EdgeInsets.zero,
//                                  title: CommonText.white16Text('取消'),
//                                ),
//                              ),
//                  ],
//                );
//              });
//        });
//  }
//
//  static Future _getImage(
//      {@required BuildContext context,
//        Function callback,
//        ImageSource imageSource = ImageSource.camera}) async {
//    Navigator.of(context).pop();
//    var image = await ImagePicker.pickImage(source: imageSource);
////    LogUtils.printLog('image类型:$image');
//    if (callback != null) callback(image: image);
//  }

}

////显示大图
//class _BigImageDisplay extends StatelessWidget {
//  List<String> imagesUrl; //图片uuid
//  int defaultIndex; //默认打开第几张
//  _BigImageDisplay(this.imagesUrl, this.defaultIndex);
//
//  @override
//  Widget build(BuildContext context) {
//    return new Center(
//      child: CarouselSlider(
//        height: MediaQuery.of(context).size.height,
//        items: map<Widget>(imagesUrl, (index, url) {
//          return new Builder(
//            builder: (BuildContext context) {
//              return Scaffold(
//                  body: GestureDetector(
//                child: Container(
//                  color: Colors.black,
//                  child: Stack(children: <Widget>[
//                    Center(
////                      child: FadeInImage.assetNetwork(
////                        placeholder: UIData.imageImageLoading,
////                        image: HttpOptions.showPhotoUrl(url),
////                        fit: BoxFit.fill,
////                      ),
//
//                      child: CachedNetworkImage(
//                        placeholder: (context, url) => Image.asset(UIData.imageImageLoading),
//                        errorWidget: (context, url,error) => Image.asset(UIData.imageImageLoadFail),
//                        imageUrl: HttpOptions.showPhotoUrl(url),
//                        fit: BoxFit.fill,
//                      ),
////                      child: Image.network(
////                        HttpOptions.showPhotoUrl(url),
////                        fit: BoxFit.fill,
////                      ),
//                    ),
//                    Positioned(
//                      bottom: 0.0,
//                      left: 0.0,
//                      right: 0.0,
//                      child: Container(
//                        decoration: BoxDecoration(
//                          gradient: LinearGradient(
//                            colors: [Color.fromARGB(200, 0, 0, 0), Color.fromARGB(0, 0, 0, 0)],
//                            begin: Alignment.bottomCenter,
//                            end: Alignment.topCenter,
//                          ),
//                        ),
//                        padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(10)),
//                        child: Text(
//                          (index + 1).toString() + ' / ' + imagesUrl.length.toString(),
//                          style: TextStyle(
//                              color: Colors.white,
//                              fontSize: UIData.fontSize14,
//                              fontWeight: FontWeight.bold,
//                              decoration: TextDecoration.none),
//                        ),
//                      ),
//                    ),
//                  ]),
////                  )
//                ),
//                onTap: () {
//                  Navigator.of(context).pop();
//                },
//              ));
//            },
//          );
//        }).toList(),
//        viewportFraction: 1.0,
//        aspectRatio: 2.0,
//        autoPlay: false,
//        enlargeCenterPage: false,
//        enableInfiniteScroll: false,
//        initialPage: defaultIndex,
//      ),
//    );
//  }
//}
//
//List<T> map<T>(List list, Function handler) {
//  List<T> result = [];
//  for (var i = 0; i < list.length; i++) {
//    result.add(handler(i, list[i]));
//  }
//
//  return result;
//}
