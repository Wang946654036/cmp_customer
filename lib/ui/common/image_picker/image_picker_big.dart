//显示大图
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import 'image_picker_loading.dart';

//选择图片的查看大图
class ImagePickerBig extends StatefulWidget {
  List<AssetEntity> entities; //本地资源
  int defaultIndex; //默认打开第几张
  ValueChanged<int> callback; //滑动回调
  ImagePickerBig(
    this.entities, {
    this.defaultIndex = 0,
    this.callback,
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ImagePickerBigState(entities,
        defaultIndex: defaultIndex, callback: callback);
  }
}

class _ImagePickerBigState extends State<ImagePickerBig>
    with AutomaticKeepAliveClientMixin {
  List<AssetEntity> entities; //本地资源
  List<Size> files; //本地资源
  int defaultIndex; //默认打开第几张
  ValueChanged<int> callback; //滑动回调
  PageController pageController;
  LoadingDelegate loadingDelegate;
  StreamController<int> pageChangeController = StreamController.broadcast();
  _ImagePickerBigState(
    this.entities, {
    this.defaultIndex = 0,
    this.callback,
  });

  @override
  void initState() {
    super.initState();
    pageChangeController.add(0);
    loadingDelegate = new ImagePickerLoadingDelegate();
    pageController = PageController(
      initialPage: defaultIndex,
    );
    _initFile();
  }

  _initFile() async {
    files = List();
    await entities.forEach((entity) async {
      files.add(await entity.size);
    });
    setState(() {});
  }

  @override
  void dispose() {
    pageChangeController.close();
    super.dispose();
  }

//  Widget _buildItem(BuildContext context, int index) {
//    var data = entities[index];
//    return BigPhotoImage(
//      assetEntity: data,
//      loadingWidget: _buildLoadingWidget(data),
//    );
//  }

  Widget _buildLoadingWidget(AssetEntity entity) {
    return loadingDelegate.buildBigImageLoading(context, entity, null);
  }

  void _onPageChanged(int value) {
    pageChangeController.add(value);
    if (callback != null) {
      callback(value);
    }
  }

  //图片布局
  Widget _buildImage(AssetEntity entity) {
    if (Platform.isAndroid) {
      return Image.file(
        new File(entity.id),
        fit: BoxFit.fill,
      );
    } else {
      return FutureBuilder<Uint8List>(
        future: entity.fullData,
        builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
          var futureData = snapshot.data;
          if (snapshot.connectionState == ConnectionState.done &&
              futureData != null) {
            return Image.memory(
              futureData,
              fit: BoxFit.fill,
            );
          } else {
            return Container();
          }
        },
      );
    }
  }

//  PageView.builder(
//  controller: pageController,
//  itemBuilder: _buildItem,
//  itemCount: list.length,
//  onPageChanged: _onPageChanged,
//  ),

  Widget _buildBody(double height) {
    return Container(
        alignment: Alignment.center,
//      width: ScreenUtil.screenWidth,
//      height: height,
        child:
//      PageView.builder(
//        controller: pageController,
//        itemBuilder: _buildItem,
//        itemCount: entities.length,
//        onPageChanged: _onPageChanged,
//      ),
          PhotoViewGallery.builder(
            scrollPhysics: const BouncingScrollPhysics(),
            builder: (BuildContext context, int index) {
              return PhotoViewGalleryPageOptions.customChild(
                  child:_buildImage(entities[index]),
                  childSize: files.isNotEmpty ? files[index] : Size(0,0),
                onTapUp: null,
                onTapDown: null,
                heroAttributes: PhotoViewHeroAttributes(tag: 1),
              );
            },
            pageController: pageController,
            onPageChanged: _onPageChanged,
            itemCount: entities.length,
            loadingChild: Center(
              child: Container(
                width: 20.0,
                height: 20.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(UIData.lightGreyColor),
                  strokeWidth: 2,
                ),
              ),
            ),
          ),
        );
//  }
//    return new Center(
//      child: CarouselSlider(
//        height:height,
//        items: map<Widget>(entities, (index, url) {
//          return new Builder(
//            builder: (BuildContext context) {
//              return Scaffold(
//                  body: GestureDetector(
//                    child: Container(
//                      color: Colors.black,
//                      child: Stack(children: <Widget>[
//                        Center(
//                            child:_buildImage(url)
//                        ),
//                        Positioned(
//                          bottom: 0.0,
//                          left: 0.0,
//                          right: 0.0,
//                          child: Container(
//                            decoration: BoxDecoration(
//                              gradient: LinearGradient(
//                                colors: [Color.fromARGB(200, 0, 0, 0), Color.fromARGB(0, 0, 0, 0)],
//                                begin: Alignment.bottomCenter,
//                                end: Alignment.topCenter,
//                              ),
//                            ),
//                            padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(10)),
//                            child: Text(
//                              (index + 1).toString() + ' / ' + entities.length.toString(),
//                              style: TextStyle(
//                                  color: Colors.white,
//                                  fontSize: UIData.fontSize14,
//                                  fontWeight: FontWeight.bold,
//                                  decoration: TextDecoration.none),
//                            ),
//                          ),
//                        ),
//                      ]),
////                  )
//                    ),
//                    onTap: () {
//                      if(callback==null){
//                        Navigator.of(context).pop();
//                      }
//                    },
//                  ));
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
  }

  File _getFile(int index) {
    entities[index].file.then((file) {
      return file;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (entities == null || entities.isEmpty) {
      return Container();
    } else {
      return Container(
        child: _buildBody(MediaQuery.of(context).size.height),
      );
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

//class BigPhotoImage extends StatefulWidget {
//  final AssetEntity assetEntity;
//  final Widget loadingWidget;
//
//  const BigPhotoImage({
//    Key key,
//    this.assetEntity,
//    this.loadingWidget,
//  }) : super(key: key);
//
//  @override
//  _BigPhotoImageState createState() => _BigPhotoImageState();
//}
//
//class _BigPhotoImageState extends State<BigPhotoImage>
//    with AutomaticKeepAliveClientMixin {
//  Widget get loadingWidget {
//    return widget.loadingWidget ?? Container();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    super.build(context);
//    var width = MediaQuery.of(context).size.width;
//    var height = MediaQuery.of(context).size.height;
//    return FutureBuilder(
//      future:
//      widget.assetEntity.thumbDataWithSize(width.floor(), height.floor()),
//      builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
//        var file = snapshot.data;
//        if (snapshot.connectionState == ConnectionState.done && file != null) {
//          print(file.length);
//          return DragScaleContainer(doubleTapStillScale: true,child: Image.memory(
//            file,
//            fit: BoxFit.contain,
//            width: double.infinity,
//            height: double.infinity,
//          ),);
//        }
//        return loadingWidget;
//      },
//    );
//  }
//
//  @override
//  bool get wantKeepAlive => true;
//}

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}
