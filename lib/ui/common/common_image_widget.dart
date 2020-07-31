import 'dart:typed_data';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';

///
/// Created by qianlx on 2020/6/15 5:35 PM.
/// 图片显示控件
///
class CommonImageWidget extends StatelessWidget {
  final String url;
  final GestureTapCallback onTap;
  final String loadingImage;
  final String loadedFailedImage;
  final String loadedNoDataImage;

  CommonImageWidget(this.url, {this.onTap, this.loadingImage, this.loadedFailedImage, this.loadedNoDataImage});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: url != null && url.isNotEmpty
            ? TransitionToImage(
                image: AdvancedNetworkImage(
                  url.contains('http://') || url.contains('https://') ? url : HttpOptions.showPhotoUrl(url),
//                  loadedCallback: () => LogUtils.printLog('It works!'),
//                  loadFailedCallback: () => LogUtils.printLog('Oh, no!'),
                  timeoutDuration: Duration(seconds: 30),
                  retryLimit: 1,
                ),
                fit: BoxFit.cover,
                placeholder: loadedFailedImage != null && loadedFailedImage.isNotEmpty &&
                        (loadedFailedImage.contains('http://') || loadedFailedImage.contains('https://'))
                    ? CommonImageWidget(loadedFailedImage)
                    : Image.asset(loadedFailedImage ?? UIData.imageBannerDefaultFailed, fit: BoxFit.cover),
                loadingWidgetBuilder: (
                  BuildContext context,
                  double progress,
                  Uint8List imageData,
                ) {
                  return loadingImage != null && loadingImage.isNotEmpty &&
                      (loadingImage.contains('http://') || loadingImage.contains('https://'))
                      ? CommonImageWidget(loadingImage)
                      : Image.asset(loadingImage ?? UIData.imageBannerDefaultLoading, fit: BoxFit.cover);
                },
              )
            : loadedNoDataImage != null && loadedNoDataImage.isNotEmpty &&
            (loadedNoDataImage.contains('http://') || loadedNoDataImage.contains('https://'))
                ? CommonImageWidget(loadedNoDataImage)
                : Image.asset(loadedNoDataImage ?? UIData.imageBannerDefaultNoData, fit: BoxFit.cover),
        onTap: onTap);
  }
}
