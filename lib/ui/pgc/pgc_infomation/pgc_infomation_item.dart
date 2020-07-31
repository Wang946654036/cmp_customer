import 'dart:typed_data';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/models/pgc/pgc_infomation_obj.dart';
import 'package:cmp_customer/scoped_models/pgc_model/pgc_infomation_model.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_image_widget.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/html/html_page.dart';
import 'package:cmp_customer/ui/pgc/pgc_infomation/pgc_infomation_detail.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../pgc_ui.dart';

class PgcInfomationItem extends StatelessWidget {
  PgcInfomationInfo info;
  PgcInfomationListModel model;
  Function refreshCallback;
  Function onClickCallback;

  PgcInfomationItem(this.info, this.model, {this.refreshCallback, this.onClickCallback});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        if (model.isBulkCollectOperation) {
          bool checked = model?.collectCheckedList?.contains(info.pgcId);
          model.changedCollectCheckbox(!checked, info?.pgcId);
        } else {
//        Navigate.toNewPage(HtmlPage('http://10.19.160.111:8020/utf8-jsp/text.html?__hbt=1578038364784','测试莫莫'));
          Navigate.toNewPage(PgcInfomationDetail(
            info,
            refreshCallback: refreshCallback,
          ));
        }
      },
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.only(top: UIData.spaceSize8),
        padding: EdgeInsets.symmetric(vertical: UIData.spaceSize12, horizontal: UIData.spaceSize16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Offstage(
              offstage: !model.isBulkCollectOperation,
              child: Checkbox(
                value: model?.collectCheckedList?.contains(info.pgcId) ?? false,
                onChanged: (checked) {
                  model.changedCollectCheckbox(checked, info?.pgcId);
                },
              ),
            ),
            Expanded(
                child: Container(
              height: ScreenUtil.getInstance().setWidth(95),
              margin: EdgeInsets.only(right: UIData.spaceSize16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: UIData.spaceSize4),
                    child: CommonText.black16Text(info?.pgcTitle ?? ''),
                  ),
                  Visibility(
                      visible: (info?.isTop ?? '0') == '1',
                      child: Container(
                        margin: EdgeInsets.only(bottom: UIData.spaceSize4),
                        child: CommonLabel(
                          '置顶',
                          textColor: UIData.pgcRedTextColor,
                          backgroundColor: UIData.pgcRedColor,
                        ),
                      )),
                  Expanded(
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      runAlignment: WrapAlignment.start,
                      spacing: UIData.spaceSize4,
                      runSpacing: UIData.spaceSize4,
                      children: [
                        CommonLabel(
                          '${StringsHelper.isNotEmpty(info?.keyword) ? '#' : ''}${info?.keyword?.replaceAll(',', '  #')?.replaceAll('，', '  #')}',
                          textColor: UIData.pgcBlueTextColor,
                          backgroundColor: UIData.pgcBlueColor,
                        )
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      children: <Widget>[
                        PgcIconTextView(
                          leading: UIData.iconWenzhangliulanshu,
                          child: CommonText.grey14Text(getPGCNumb(info?.browseCount ?? 0)),
                          canClick: false,
                        ),
                        SizedBox(width: UIData.spaceSize6),
                        PgcIconTextView(
                          leading: UIData.iconPinlun,
                          child: CommonText.grey14Text(getPGCNumb(info?.commentCount ?? 0)),
                          canClick: false,
                        ),
                        SizedBox(width: UIData.spaceSize6),
                        PgcIconTextView(
                          leading: UIData.iconDianzan,
                          child: CommonText.grey14Text(getPGCNumb(info?.likeCount ?? 0)),
                          canClick: false,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )),
            Container(
              height: UIData.spaceSize80,
              width: UIData.spaceSize150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                border: Border.all(color: UIData.primaryColor, width: 1),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child:
                   CommonImageWidget(info?.titlePic),
//                child: info?.titlePic != null && info.titlePic.isNotEmpty
//                    ? TransitionToImage(
//                  image: AdvancedNetworkImage(
//                    HttpOptions.showPhotoUrl(info?.titlePic ?? ''),
////                              loadedCallback: () => LogUtils.printLog('It works!'),
////                              loadFailedCallback: () => LogUtils.printLog('Oh, no!'),
//                    timeoutDuration: Duration(seconds: 30),
//                    retryLimit: 1,
//                  ),
//                  fit: BoxFit.cover,
//                  placeholder: Image.asset(UIData.imageBannerDefaultFailed, fit: BoxFit.cover),
//                  loadingWidgetBuilder: (
//                      BuildContext context,
//                      double progress,
//                      Uint8List imageData,
//                      ) {
//                    return Image.asset(UIData.imageBannerDefaultLoading, fit: BoxFit.cover);
//                  },
//                )
//                    : Image.asset(UIData.imageBannerDefaultNoData, fit: BoxFit.cover),
//                child:FadeInImage.assetNetwork(
//                  placeholder: UIData.imageBannerDefaultNoData,
//                  image: HttpOptions.showPhotoUrl(info?.titlePic ?? ''),
//                  fit: BoxFit.cover,
//                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
