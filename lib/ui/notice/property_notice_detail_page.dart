import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/common/common_share_model.dart';
import 'package:cmp_customer/models/property_notice_detail_model.dart';
import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/strings/strings_notice.dart';
import 'package:cmp_customer/ui/common/common_attachment_container.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/popover/cupertino_popover.dart';
import 'package:cmp_customer/ui/common/popover/cupertino_popover_menu_item.dart';
import 'package:cmp_customer/utils/share_util.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

///
/// 物业通知详情
///
class PropertyNoticeDetailPage extends StatefulWidget {
  final int id;

  PropertyNoticeDetailPage(this.id);

  @override
  _PropertyNoticeDetailPageState createState() => _PropertyNoticeDetailPageState();
}

class _PropertyNoticeDetailPageState extends State<PropertyNoticeDetailPage> {
  PropertyNoticeDetailPageModel _pageModel = PropertyNoticeDetailPageModel();

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  void _refreshData() {
    stateModel.getPropertyNoticeDetail(widget.id, _pageModel);
  }

  Widget _buildContent() {
    PropertyNoticeDetail detail = _pageModel.propertyNoticeDetail;
    return Container(
      color: UIData.primaryColor,
      child: ListView(
        padding: EdgeInsets.only(left: UIData.spaceSize16, right: UIData.spaceSize16, bottom: UIData.spaceSize16),
        shrinkWrap: true,
        children: <Widget>[
          CommonText.darkGrey17Text(detail?.title ?? ''),
          SizedBox(height: UIData.spaceSize8),
          Row(
            children: <Widget>[
              CommonText.text12(urgentDegreeMap[detail?.type], color: urgentDegree2ColorMap[detail?.type]),
              CommonText.lightGrey12Text(detail?.sendTime ?? ''),
            ],
          ),
          SizedBox(height: UIData.spaceSize8),
          FadeInImage.assetNetwork(
            placeholder: UIData.imageActivityDefault,
            image: detail?.imageList != null && detail.imageList.length > 0
                ? HttpOptions.showPhotoUrl(detail.imageList[0].attachmentUuid)
                : '',
            fit: BoxFit.contain,
          ),
          SizedBox(height: UIData.spaceSize8),
          Html(data: detail?.content ?? ''),
          SizedBox(height: UIData.spaceSize8),
          AttachmentContainer(detail?.fileList)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
      return CommonScaffold(
        appTitle: '详情',
        appBarActions: [CupertinoPopoverButton(
            popoverWidth: UIData.spaceSize100,
            popoverColor: UIData.greyColor,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize16),
              alignment: Alignment.centerRight,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CommonText.red15Text('更多'),
                ],
              ),
            ),
            popoverBuild: (context) {
              PropertyNoticeDetail detail = _pageModel.propertyNoticeDetail;
              return CupertinoPopoverMenuList(
                children: <Widget>[
                  CupertinoPopoverMenuItemWithIcon(
                    leading: Icon(Icons.share),
                    child: CommonText.white14Text("一键分享"),
                    onTap: () {
                      String baseUrl = HttpOptions.baseUrl
                          .replaceAll('ubms-customer/', '');
                      print('${ baseUrl +
                          "template/appShare/propertyNoticeDetailPage.html?id=${widget.id}&receiveId=${stateModel.defaultProjectId}"
                          }');
                      String picUrl = ShareUtil.showShareMenu(
                          context,
                          CommonShareModel(
                            title: detail?.title ?? '',
                            thumbImageUrl: detail?.imageList != null && detail.imageList.length > 0
                                ? HttpOptions.showPhotoUrl(detail.imageList[0].attachmentUuid)
                                : '',
                            text: ' ',
                            url: baseUrl +
                                "template/appShare/propertyNoticeDetailPage.html?id=${widget.id}&receiveId=${stateModel.defaultProjectId}",
                          ));
                    },
                  ),
                ],
              );
            }),],
        bodyData: CommonLoadContainer(
          state: _pageModel.pageState,
          content: _buildContent(),
          callback: _refreshData,
        ),
      );
    });
  }
}

class PropertyNoticeDetailPageModel {
  PropertyNoticeDetail propertyNoticeDetail = PropertyNoticeDetail();
  ListState pageState = ListState.HINT_LOADING;
}
