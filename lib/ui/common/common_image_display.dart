import 'package:cached_network_image/cached_network_image.dart';
import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/ui/common/common_image_big.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';

import 'common_image_widget.dart';

//图片显示布局(仅用于显示)
class CommonImageDisplay extends StatelessWidget {
  List<String> photoIdList; //图片对应服务器的UUID列表
  int crossAxisCount; //每一行显示的个数（默认5个，如果是流程节点，可调整设置成4个）
  CommonImageDisplay({this.photoIdList, this.crossAxisCount = 5});

//  @override
//  State<StatefulWidget> createState() {
//    // TODO: implement createState
//  }
//}

//class _imageDisplay extends State<CommonImageDisplay> {
  @override
  Widget build(BuildContext context) {
    if (photoIdList == null || photoIdList.length == 0) {
      return Container();
    } else {
      return GridView.builder(
        physics: new NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: UIData.spaceSize12,
          crossAxisSpacing: UIData.spaceSize12,
        ),
        itemCount: photoIdList.length,
        itemBuilder: (BuildContext context, int index) {
          return ConstrainedBox(
              constraints: BoxConstraints.expand(),
              child: GestureDetector(
                onTap: () {
                  //查看大图
                  Navigate.toNewPage(CommonImageBig(
                    photoIdList,
                    defaultIndex: index,
                  ));
//                  Navigator.of(context).push(
//                      new MaterialPageRoute(builder: (_) {
//                        return _BigImageDisplay(
//                            photoIdList, index);
//                      }));
                },

//                child: FadeInImage.assetNetwork(
//                  placeholder: UIData.imageImageLoading,
//                  image: HttpOptions.showPhotoUrl(
//                    photoIdList[index]),
//                  fit: BoxFit.cover,
//                ),

                child: CommonImageWidget(photoIdList[index],
                    loadingImage: UIData.imageImageLoading, loadedFailedImage: UIData.imageLoadedFailed),
//                  child: CachedNetworkImage(
//                    placeholder: (context, url) => Image.asset(UIData.imageImageLoading),
//                    errorWidget: (context, url,error) => Image.asset(UIData.imageLoadedFailed),
//                    imageUrl: HttpOptions.showPhotoUrl(photoIdList[index]),
//                    fit: BoxFit.cover,
//                  ),
              ));
        },
      );
    }
  }
}

////显示大图
//class _BigImageDisplay extends StatelessWidget {
//  List<String> imagesUrl; //图片uuid
//  int defaultIndex; //默认打开第几张
//  _BigImageDisplay(this.imagesUrl, this.defaultIndex);
//  @override
//  Widget build(BuildContext context) {
//    return new Center(
//      child: CarouselSlider(
//        height: MediaQuery.of(context).size.height,
//        items: map<Widget>(imagesUrl, (index, url) {
//          return new Builder(
//            builder: (BuildContext context) {
//              return Scaffold(
//                  body:GestureDetector(
//                    child:Container(
//                      color: Colors.black,
//                      child: Stack(children: <Widget>[
//                        Center(
////                          child:CachedNetworkImage(
////                            imageUrl: "http://via.placeholder.com/350x150",
////                            placeholder: (context, url) => new CircularProgressIndicator(),
////                            errorWidget: (context, url, error) => new Icon(Icons.error),
////                            fit: ,
////                          ),
//                          child: CachedNetworkImage(
//                            placeholder: (context, url) => Image.asset(UIData.imageImageLoading),
//                            errorWidget: (context, url,error) => Image.asset(UIData.imageImageLoadFail),
//                            imageUrl: HttpOptions.showPhotoUrl(url),
//                            fit: BoxFit.fill,
//                          ),
////                          child:Image.network(HttpOptions.showPhotoUrl(url),fit: BoxFit.fill,),
//                        ),
//
//                        Positioned(
//                          bottom: 0.0,
//                          left: 0.0,
//                          right: 0.0,
//                          child: Container(
//                            decoration: BoxDecoration(
//                              gradient: LinearGradient(
//                                colors: [
//                                  Color.fromARGB(200, 0, 0, 0),
//                                  Color.fromARGB(0, 0, 0, 0)
//                                ],
//                                begin: Alignment.bottomCenter,
//                                end: Alignment.topCenter,
//                              ),
//                            ),
//                            padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(10)),
//                            child: Text(
//                              (index+1).toString() + ' / ' + imagesUrl.length.toString(),
//                              style: TextStyle(
//                                  color: Colors.white,
//                                  fontSize: UIData.fontSize14,
//                                  fontWeight: FontWeight.bold,
//                                  decoration: TextDecoration.none
//                              ),
//                            ),
//                          ),
//                        ),
//                      ]),
////                  )
//                    ),
//                    onTap: (){
//                      Navigator.of(context).pop();
//                    },
//                  )
//              );
//            },
//          );
//        }).toList(),
//        viewportFraction: 1.0,
//        aspectRatio: 2.0,
//        autoPlay: false,
//        enlargeCenterPage: false,
//        enableInfiniteScroll:false,
//        initialPage: defaultIndex,
//      ),
//    );
//  }
//}
//
//
//
//List<T> map<T>(List list, Function handler) {
//  List<T> result = [];
//  for (var i = 0; i < list.length; i++) {
//    result.add(handler(i, list[i]));
//  }
//
//  return result;
//}
