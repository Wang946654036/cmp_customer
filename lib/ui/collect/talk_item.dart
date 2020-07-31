import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/models/response/talk_list_response.dart';
import 'package:cmp_customer/scoped_models/collect/talk_list_model.dart';
import 'package:cmp_customer/ui/common/common_image_display.dart';
import 'package:cmp_customer/ui/common/common_image_widget.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/html/html_page.dart';
import 'package:cmp_customer/ui/market/market_basedata.dart';
import 'package:cmp_customer/ui/pgc/pgc_ui.dart';
import 'package:cmp_customer/utils/date_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/shared_preferences_key.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

//说说
class TalkItem extends StatelessWidget {
  TalkInfo info;
  TalkListModel model;
  Function refreshCallback;
  Function onClickCallback;
  final bool fromHome; //是否首页跳转

  TalkItem(this.info, this.model, {this.refreshCallback, this.onClickCallback, this.fromHome = false});

//  //显示图片
//  Widget _buildDisPlayImage(List<String> attachmentList) {
//    if (attachmentList == null || attachmentList.length == 0) {
//      return Container();
//    } else {
//      return GridView.builder(
//        physics: new NeverScrollableScrollPhysics(),
//        shrinkWrap: true,
//        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//          crossAxisCount: 5,
//          mainAxisSpacing: UIData.spaceSize12,
//          crossAxisSpacing: UIData.spaceSize12,
//        ),
//        itemCount: attachmentList.length,
//        itemBuilder: (BuildContext context, int index) {
//          return ConstrainedBox(
//            constraints: BoxConstraints.expand(),
//            child: CommonImageWidget(attachmentList[index],
////            child: CommonImageWidget('http://218.17.81.123:9001/ubms-customer/base/mongo/show/5ec5f75355ae0c33d3da1400',
//                loadingImage: UIData.imageImageLoading, loadedFailedImage: UIData.imageLoadedFailed),
////              child: CachedNetworkImage(
////                placeholder: (context, url) => Image.asset(UIData.imageImageLoading),
////                errorWidget: (context, url, error) => Image.asset(UIData.imageLoadedFailed),
////                imageUrl: HttpOptions.showPhotoUrl(attachmentList[index]),
////                fit: BoxFit.cover,
////              )
//          );
//        },
//      );
//    }
//  }

  void _operateItem() async{
    if (model.isBulkCollectOperation) {
      bool checked = model?.collectCheckedList?.contains(info.talkId);
      model.changedCollectCheckbox(!checked, info?.talkId);
    } else {
      if (model.isBulkCollectPage && info?.status != "1") {
        CommonToast.show(msg: "说说已删除", type: ToastIconType.INFO);
      } else {
        SharedPreferences prefs = await SharedPreferencesKey.globalPrefs;
        String token = prefs.getString(SharedPreferencesKey.KEY_ACCESS_TOEKN);
        Navigate.toNewPage(HtmlPage("${HttpOptions.baseUrl.replaceAll(
            "ubms-customer/",
            "")}template/appShare/talkAboutDetail.html?projectId=${stateModel?.defaultProjectId}&token=$token&talkId=${info?.talkId}&closePage=1", "", showTitle: false,));
      }
    }
  }

  GlobalKey _marketStatementDialogKey = GlobalKey(); //邻里集市声明弹框的key
  bool _marketStatementCheck = false; //邻里集市声明是否显示
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () async {
        _operateItem();
      },
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.only(top: UIData.spaceSize8),
        padding: EdgeInsets.symmetric(vertical: UIData.spaceSize12, horizontal: UIData.spaceSize16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Offstage(
              offstage: !model.isBulkCollectOperation,
              child: Checkbox(
                value: model?.collectCheckedList?.contains(info.talkId) ?? false,
                onChanged: (checked) {
                  model.changedCollectCheckbox(checked, info?.talkId);
                },
              ),
            ),
            Expanded(
                child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(children: <Widget>[
                    Container(
                      width: UIData.spaceSize18 * 2,
                      height: UIData.spaceSize18 * 2,
                      margin: EdgeInsets.only(right: UIData.spaceSize8),
                      padding: EdgeInsets.all(1.0),
                      decoration: ShapeDecoration(shape: StadiumBorder(), color: UIData.primaryColor),
                      child: ClipOval(
                        child: CommonImageWidget(info?.userPicture?.attachmentUuid,
                        loadingImage: UIData.imagePortrait,
                        loadedFailedImage: UIData.imagePortrait,
                        loadedNoDataImage: UIData.imagePortrait),
//                        child: StringsHelper.isNotEmpty(info?.userPicture?.attachmentUuid)
//                            ? CachedNetworkImage(
//                                placeholder: (context, url) => Image.asset(UIData.imagePortrait),
//                                errorWidget: (context, url, error) => Image.asset(UIData.imagePortrait),
//                                imageUrl: HttpOptions.showPhotoUrl(info?.userPicture?.attachmentUuid),
//                                fit: BoxFit.fill,
//                              )
//                            : Image.asset(
//                                UIData.imagePortrait,
//                                fit: BoxFit.fill,
//                              ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          CommonText.darkGrey14Text(info?.nickName),
                          CommonText.lightGrey12Text(getProjectAndCity(info?.projectName, info?.city)),
                        ],
                      ),
                    )
                  ]),
                  Container(
                    margin: EdgeInsets.only(bottom: UIData.spaceSize4, top: UIData.spaceSize4),
                    child: CommonText.darkGrey16Text(info?.content ?? '',maxLines: 2,overflow: TextOverflow.visible),
                  ),
//                  _buildDisPlayImage(info?.picAttachmentList?.map((attach) => attach.attachmentUuid)?.toList()),
                  CommonImageDisplay(
                    photoIdList: info?.attachmentList?.map((attach) => attach.attachmentUuid)?.toList(),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: CommonText.lightGrey12Text(DateUtils.getTheCommentTime(info?.createTime)),
                        ),
                        PgcIconTextView(
                          leading: UIData.iconWenzhangliulanshu,
                          child: CommonText.grey14Text(getPGCNumb(info?.viewCount ?? 0)),
                          canClick: false,
                        ),
                        SizedBox(
                          width: UIData.spaceSize8,
                        ),
                        PgcIconTextView(
                          leading: UIData.iconPinlun,
                          child: CommonText.grey14Text(getPGCNumb(info?.commentCount ?? 0)),
                          canClick: false,
                        ),
                        SizedBox(
                          width: UIData.spaceSize8,
                        ),
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
          ],
        ),
      ),
    );
  }
}
