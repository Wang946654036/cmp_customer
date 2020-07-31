//显示大图
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_view/photo_view_gallery.dart';

class CommonImageBig extends StatefulWidget {
  List<String> imagesUrl; //图片地址（网络地址uuid、资源地址、本地地址）
  int defaultIndex; //默认打开第几张
  ValueChanged<int> callback; //滑动回调
  final bool indexVisible;

  CommonImageBig(this.imagesUrl, {this.defaultIndex = 0, this.callback, this.indexVisible = true});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CommonImageBig();
  }
}

class _CommonImageBig extends State<CommonImageBig> {
  int imageIndex;
  PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: widget.defaultIndex,
    );
    imageIndex = widget.defaultIndex;
  }

//  //图片布局
//  Widget _buildImage(String url) {
//    if (StringsHelper.isUuid(url)) {
//      return CachedNetworkImage(
//        placeholder: (context, url) => Image.asset(UIData.imageImageLoading),
//        errorWidget: (context, url, error) =>
//            Image.asset(UIData.imageImageLoadFail),
//        imageUrl: HttpOptions.showPhotoUrl(url),
//        fit: BoxFit.contain,
//      );
//    } else if (url.contains(UIData.imageDir)) {
//      return Image.asset(
//        url,
//        fit: BoxFit.contain,
//      );
//    } else {
////      if(Platform.isAndroid){
////        return Image.file(new File(url),fit: BoxFit.contain,);
////      }else{
//      return FutureBuilder<Uint8List>(
//        future: AssetEntity(id: url).fullData,
//        builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
//          var futureData = snapshot.data;
//          if (snapshot.connectionState == ConnectionState.done &&
//              futureData != null) {
//            return Image.memory(
//              futureData,
//              key: Key(url),
//              fit: BoxFit.contain,
//            );
//          } else {
//            return Container();
//          }
//        },
//      );
////      }
//    }
//  }

  Widget _buildBody(double height) {
    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          child: PhotoViewGallery.builder(
            pageController: pageController,
            scrollPhysics: const BouncingScrollPhysics(),
            builder: (BuildContext context, int index) {
              return PhotoViewGalleryPageOptions(
                  imageProvider: AdvancedNetworkImage(
                HttpOptions.showPhotoUrl(widget.imagesUrl[index]),
                timeoutDuration: Duration(seconds: 30),
                retryLimit: 1,
              )
//                CachedNetworkImageProvider(
//                    HttpOptions.showPhotoUrl(widget.imagesUrl[index])),
                  );
            },
            onPageChanged: (index) {
              setState(() {
                imageIndex = index;
              });
            },
            itemCount: widget.imagesUrl.length,
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
        ),
        Visibility(
          visible: widget.indexVisible,
          child: Positioned(
            top: 20,
            child: Container(
              height: 50,
              alignment: Alignment.center,
              child: Text(
                (imageIndex + 1).toString() + ' / ' + widget.imagesUrl.length.toString(),
                style: TextStyle(
                    color: UIData.darkGreyColor,
                    fontSize: UIData.fontSize14,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none),
              ),
            ),
          ),
        ),
        Positioned(
            top: 20,
            right: 10,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: Container(
                height: 50,
                width: 50,
                alignment: Alignment.center,
                child: Icon(
                  Icons.cancel,
                  size: ScreenUtil.getInstance().setWidth(20),
                  color: UIData.lightGreyColor,
                ),
              ),
              onTap: () {
                Navigate.closePage();
              },
            )),
      ],
//      width: ScreenUtil.screenWidth,
//      height: height,
//          child: Swiper(
//            autoplay: false,
//            itemBuilder: (BuildContext context, int index) {
//              return  GestureDetector(onTap: (){
//                Navigator.of(context).pop();
//              },child:  Container(
//                color: Colors.white,
//                child: Stack(children: <Widget>[
//                  Center(
//                      child:
////                      DragScaleContainer(
////                        doubleTapStillScale: true,
////                        child: _buildImage(imagesUrl[index]),
////                      )
//                      PhotoView(
//                        imageProvider: CachedNetworkImageProvider(HttpOptions.showPhotoUrl(imagesUrl[index])),
//                      )
//                  ),
////                  Positioned(
////                    right: 0.0,
////                    top: 20.0,
////                    child: GestureDetector(
////                        behavior: HitTestBehavior.translucent,
////                        child: Container(
////                          height: 40,
//////                      iconSize: 35.0,
////                          padding: EdgeInsets.all(UIData.spaceSize16),
////                          child: Icon(Icons.close,
////                              color: UIData.darkGreyColor),
////                        ),
////                        onTap: () {
//////                        LogUtils.printLog('commonScaffold backButton');
////
////                          Navigator.of(context).pop();
////                        }),
////                  ),
//                  Positioned(
//                    bottom: 0.0,
//                    left: 0.0,
//                    right: 0.0,
//                    child: Container(
////                            decoration: BoxDecoration(
////                              gradient: LinearGradient(
////                                colors: [ Color.fromARGB(200, 0, 0, 0), Color.fromARGB(0, 0, 0, 0)],
////                                begin: Alignment.bottomCenter,
////                                end: Alignment.topCenter,
////                              ),
////                            ),
//                      color: Color.fromARGB(28, 0, 0, 0),
//                      padding:
//                      EdgeInsets.all(ScreenUtil.getInstance().setWidth(10)),
//                      child: Text(
//                        (index + 1).toString() +
//                            ' / ' +
//                            imagesUrl.length.toString(),
//                        style: TextStyle(
//                            color: UIData.darkGreyColor,
//                            fontSize: UIData.fontSize14,
//                            fontWeight: FontWeight.bold,
//                            decoration: TextDecoration.none),
//                      ),
//                    ),
//                  ),
//                ]),
////                  )
//              ),);
//            },
//            loop: false,
//            index: ,
//            itemCount: imagesUrl?.length ?? 0,
//            onIndexChanged: (index) {
//              if (callback != null) {
//                callback(index);
//              }
//            },
//          ),
    ));
//  }
//    return new Center(
//      child: CarouselSlider(
//        height:height,
//        items: map<Widget>(imagesUrl, (index, url) {
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
//                              (index + 1).toString() + ' / ' + imagesUrl.length.toString(),
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
//        initialPage: ,
//      ),
//    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.imagesUrl == null || widget.imagesUrl.isEmpty) {
      return Container();
    } else {
      return Container(
        child: _buildBody(MediaQuery.of(context).size.height),
      );
    }
  }
}

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}
