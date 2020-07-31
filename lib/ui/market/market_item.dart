import 'package:cached_network_image/cached_network_image.dart';
import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/models/market/ware_detail_model.dart';
import 'package:cmp_customer/scoped_models/market_model/market_list_model.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_dialog.dart';
import 'package:cmp_customer/ui/common/common_image_display.dart';
import 'package:cmp_customer/ui/common/common_image_widget.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/pgc/pgc_ui.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/date_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/shared_preferences_key.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import 'market_basedata.dart';
import 'market_detail.dart';

class MarketItem extends StatelessWidget {
  WareDetailModel info;
  MarketListModel model;
  Function refreshCallback;
  Function onClickCallback;
  final bool fromHome; //是否首页跳转

  MarketItem(this.info, this.model, {this.refreshCallback, this.onClickCallback, this.fromHome = false});

  //显示图片
  Widget _buildDisPlayImage(List<String> attachmentList) {
    if (attachmentList == null || attachmentList.length == 0) {
      return Container();
    } else {
      return GridView.builder(
        physics: new NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          mainAxisSpacing: UIData.spaceSize12,
          crossAxisSpacing: UIData.spaceSize12,
        ),
        itemCount: attachmentList.length,
        itemBuilder: (BuildContext context, int index) {
          return ConstrainedBox(
            constraints: BoxConstraints.expand(),
            child: CommonImageWidget(attachmentList[index],
//            child: CommonImageWidget('http://218.17.81.123:9001/ubms-customer/base/mongo/show/5ec5f75355ae0c33d3da1400',
                loadingImage: UIData.imageImageLoading, loadedFailedImage: UIData.imageLoadedFailed),
//              child: CachedNetworkImage(
//                placeholder: (context, url) => Image.asset(UIData.imageImageLoading),
//                errorWidget: (context, url, error) => Image.asset(UIData.imageLoadedFailed),
//                imageUrl: HttpOptions.showPhotoUrl(attachmentList[index]),
//                fit: BoxFit.cover,
//              )
          );
        },
      );
    }
  }

  void _operateItem() {
    if (model.isBulkCollectOperation) {
      bool checked = model?.collectCheckedList?.contains(info.waresId);
      model.changedCollectCheckbox(!checked, info?.waresId);
    } else {
      if (model.isBulkCollectPage && info?.status != "1") {
        CommonToast.show(msg: "该商品已下架", type: ToastIconType.INFO);
      } else {
        Navigate.toNewPage(MarketDetail(
          info?.waresId,
          refreshCallback: refreshCallback,
        ));
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
        if (fromHome) {
          SharedPreferences prefs = await SharedPreferencesKey.globalPrefs;
//                      prefs.setBool(SharedPreferencesKey.KEY_SHOW_MARKET_STATEMENT, true); //测试数据
          bool showMarketStatement = prefs.getBool(SharedPreferencesKey.KEY_SHOW_MARKET_STATEMENT) ?? true;
          if (showMarketStatement) {
            CommonDialog.showAlertDialog(context,
                title: '邻里集市免责申明',
                content: StatefulBuilder(
                    key: _marketStatementDialogKey,
                    builder: (context, state) {
                      return ListView(
                        shrinkWrap: true,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize16),
                            child: CommonText.darkGrey14Text(stateModel.marketStatement ?? '',
                                height: 1.2, overflow: TextOverflow.fade),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize8),
                            child: CommonCheckBox(
                                text: '我已充分了解以上申明，下次不再提示',
                                fontSize: UIData.fontSize12,
                                value: _marketStatementCheck,
                                onChanged: (value) {
                                  _marketStatementDialogKey.currentState.setState(() {
                                    _marketStatementCheck = value;
                                  });
                                }),
                          )
                        ],
                      );
                    }),
                showNegativeBtn: false,
                positiveBtnText: '我知道了', onConfirm: () {
              if (_marketStatementCheck) {
                prefs.setBool(SharedPreferencesKey.KEY_SHOW_MARKET_STATEMENT, false);
                _marketStatementCheck = false;
              }
              _operateItem();
            });
          } else {
            _operateItem();
          }
        } else {
          _operateItem();
        }
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
                value: model?.collectCheckedList?.contains(info.waresId) ?? false,
                onChanged: (checked) {
                  model.changedCollectCheckbox(checked, info?.waresId);
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
                          Row(
                            children: <Widget>[
                              CommonText.darkGrey14Text(info?.nickName),
                              SizedBox(
                                width: UIData.spaceSize8,
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: CommonText.orange14Text(
                                    getPriceAndUnit(info?.price?.toString(), info?.priceDescribe),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: UIData.spaceSize8,
                              ),
                              RadiusSolidText(
                                text: '${MarketTypeMap[info?.tradingType] ?? ""}',
                                color: UIData.primaryColor,
                                backgroundColor: getMarketTypeColor(info?.tradingType),
                                horizontalPadding: UIData.spaceSize6,
                                verticalPadding: UIData.spaceSize2,
                              ),
//                              CommonText.text14('${MarketTypeMap[info?.tradingType] ?? ""}',
//                                  color: getMarketTypeColor(info?.tradingType))
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              info?.customerType == 2 ? UIData.iconMarketRZYH : UIData.iconMarketYK,
                              CommonText.text12((info?.customerType == 2) ? "认证用户" : "游客",
                                  color: (info?.customerType == 2) ? UIData.orangeColor : UIData.pgcBlueTextColor),
                            ],
                          ),
                          CommonText.lightGrey12Text(getProjectAndCity(info?.projectName, info?.city)),
                        ],
                      ),
                    )
                  ]),
                  Container(
                    margin: EdgeInsets.only(bottom: UIData.spaceSize4, top: UIData.spaceSize4),
                    child: CommonText.darkGrey16Text(info?.title ?? ''),
                  ),
//                  _buildDisPlayImage(info?.picAttachmentList?.map((attach) => attach.attachmentUuid)?.toList()),
                  CommonImageDisplay(
                    photoIdList: info?.picAttachmentList?.map((attach) => attach.attachmentUuid)?.toList(),
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
                          child: CommonText.grey14Text(getPGCNumb(info?.browseCount ?? 0)),
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
