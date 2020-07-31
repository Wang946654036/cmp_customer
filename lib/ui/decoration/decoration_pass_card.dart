import 'package:cached_network_image/cached_network_image.dart';
import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/models/common/common_share_model.dart';
import 'package:cmp_customer/models/response/decoration_pass_card_details_response.dart';
import 'package:cmp_customer/strings/strings_common.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_image_widget.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_share_bottom_sheet.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/parking/parking_card_ui.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/date_util.dart';
import 'package:cmp_customer/utils/share_util.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'decoration_pass_card_label.dart';

//装修工出入证
class DecorationPassCardPage extends StatefulWidget {
  DecorationPassCardDetails detail;

  DecorationPassCardPage(this.detail);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DecorationPassCardDetails();
  }
}

class _DecorationPassCardDetails extends State<DecorationPassCardPage> with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<GlobalKey> shareWidgetKeys = List();
  List<UserList> cards;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cards = widget.detail.userList;
    _tabController = TabController(length: cards.length, vsync: this)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    Widget _buildContent(UserList details, int index) {
      return SingleChildScrollView(
          child: RepaintBoundary(
              key: shareWidgetKeys[index],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    color: color_layout_bg,
                    padding: EdgeInsets.only(
                        top: UIData.spaceSize30,
                        bottom: UIData.spaceSize30,
                        left: UIData.spaceSize14,
                        right: UIData.spaceSize30),
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        Container(
                            width: ScreenUtil.getInstance().setWidth(100),
                            height: ScreenUtil.getInstance().setWidth(100),
                            child: CommonImageWidget(details?.headPhotos[0]?.attachmentUuid,
                                loadingImage: UIData.imagePortrait,
                                loadedFailedImage: UIData.imagePortrait,
                                loadedNoDataImage: UIData.imagePortrait)),
//                        CachedNetworkImage(
//                          placeholder: (context, url) =>
//                              Image.asset(UIData.imagePortrait),
//                          errorWidget: (context, url, error) =>
//                              Image.asset(UIData.imagePortrait),
//                          imageUrl: HttpOptions.showPhotoUrl(
//                              details?.headPhotos[0]?.attachmentUuid ?? ""),
//                          fit: BoxFit.cover,
//                          width: ScreenUtil.getInstance().setWidth(100),
//                          height: ScreenUtil.getInstance().setWidth(100),
//                        ),
                        labelTextWidget(
                          label: label_apply_construction,
                          text: widget.detail.company ?? "",
                          topSpacing: top_spacing,
                          bottomSpacing: bottom_spacing,
                        ),
                        CommonDivider(),
                        labelTextWidget(
                          label: label_apply_name,
                          text: details?.name ?? "",
                          topSpacing: top_spacing,
                          bottomSpacing: bottom_spacing,
                        ),
                        CommonDivider(),
                        labelTextWidget(
                          label: label_apply_id_number,
                          text: details?.idCard ?? "",
                          topSpacing: top_spacing,
                          bottomSpacing: bottom_spacing,
                        ),
                        CommonDivider(),
                        labelTextWidget(
                          label: label_apply_accreditation_validity,
                          topSpacing: top_spacing,
                          bottomSpacing: bottom_spacing,
                          text: StringsHelper.getStringValue(details?.beginDate) +
                              " - " +
                              StringsHelper.getStringValue(details?.endDate),
                        ),
//                    CommonDivider(),
//                    labelTextWidget(
//                      label: label_apply_accreditation_status,
//                      topSpacing: top_spacing,
//                      bottomSpacing: bottom_spacing,
//                      text: _getCardValidityName(widget.detail.endDate),
//                    ),
                        CommonDivider(),
                        labelTextWidget(
                          label: label_apply_project,
                          topSpacing: top_spacing,
                          bottomSpacing: bottom_spacing,
                          text: widget.detail.formerName ?? "",
                        ),
                        CommonDivider(),
                        labelTextWidget(
                          label: label_apply_construction_scope,
                          topSpacing: top_spacing,
                          bottomSpacing: bottom_spacing,
                          text: widget.detail.houseName ?? "",
                        ),
                        CommonDivider(),
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: horizontal_spacing),
                            child: QrImage(
                              size: ScreenUtil.getInstance().setWidth(150),
                              data: StringsHelper.enum2String(QRCodeType.DecorationPass) +
                                  '_${details?.applyId ?? ""}_${details?.id ?? ""}',
                            )),
                      ],
                    ),
                  ),
                ],
              )));
    }

    //员工列表
    List<Widget> _getContentPage() {
      List<Widget> widgetList = List();
      shareWidgetKeys.clear();
      int length = cards.length;
      for (int i = 0; i < length; i++) {
        shareWidgetKeys.add(new GlobalKey());
        widgetList.add(_buildContent(cards[i], i));
      }
      return widgetList;
    }

    Widget _buildBody() {
      return TabBarView(children: _getContentPage(), controller: _tabController);
    }

    return CommonScaffold(
        appTitle: "装修工出入证",
        bodyData: _buildBody(),
        bottomNavigationBar: Container(
          color: UIData.primaryColor,
          alignment: Alignment.center,
          margin: EdgeInsets.all(0),
          padding: EdgeInsets.symmetric(vertical: vertical_spacing, horizontal: horizontal_spacing),
          child: Row(
            children: <Widget>[
              CommonText.red14Text((_tabController.index + 1).toString()),
              CommonText.darkGrey14Text("/" + (_tabController.length).toString()),
              Expanded(
                child: Container(),
              ),
              GestureDetector(
                child: CommonText.red16Text("分享给好友"),
                onTap: () {
                  ShareUtil.shareWidget(shareWidgetKeys[_tabController.index]);
                },
              )
            ],
          ),
        ));
  }

  //有效性
  _getCardValidityName(String endTime) {
    if (StringsHelper.isEmpty(endTime)) return "";
    int days = DateUtils.getDifferenceDay(endTime);
    String text = "";
    if (days > 30) {
      text = "已启用";
    } else if (days >= 0) {
      text = "即将过期";
    } else {
      text = "已过期";
    }
    return text;
  }
}
