import 'package:cached_network_image/cached_network_image.dart';
import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/ui/common/common_list_loading.dart';
import 'package:cmp_customer/ui/common/common_list_refresh.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';

///
/// banner
///
class BannerDetailPage extends StatefulWidget {
  final String title;
  final String uuid;

  BannerDetailPage(this.uuid, this.title);

  @override
  _BannerDetailPageState createState() => _BannerDetailPageState();
}

class _BannerDetailPageState extends State<BannerDetailPage> {
  Widget _buildBody() {
    return SingleChildScrollView(
//      child: CachedNetworkImage(
//        placeholder: (context, url) => CommonListLoading(),
//        errorWidget: (context, url, error) => CommonListRefresh(
//            state: ListState.HINT_LOADED_FAILED_CLICK,
//            callBack: () {
//              LogUtils.printLog('广告详情222');
//              setState(() {});
//            }),
//        imageUrl: HttpOptions.showPhotoUrl(widget.uuid),
//        fit: BoxFit.fitWidth,
//      ),
    child: FadeInImage.assetNetwork(placeholder: UIData.imageBannerFrontBg, image: HttpOptions.showPhotoUrl(widget.uuid)),
    );
  }

//  CommonListLoading
  @override
  Widget build(BuildContext context) {
    LogUtils.printLog('广告详情：${HttpOptions.showPhotoUrl(widget.uuid)}');
    return CommonScaffold(
      appTitle: widget.title ?? '',
      bodyData: _buildBody(),
    );
  }
}
