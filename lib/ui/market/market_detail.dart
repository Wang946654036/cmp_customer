import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/common/common_share_model.dart';
import 'package:cmp_customer/models/market/ware_comment_response.dart';
import 'package:cmp_customer/models/market/ware_detail_model.dart';
import 'package:cmp_customer/models/pgc/pgc_comment_obj.dart';
import 'package:cmp_customer/models/pgc/pgc_infomation_obj.dart';
import 'package:cmp_customer/scoped_models/market_model/market_detail_model.dart';
import 'package:cmp_customer/scoped_models/pgc_model/pgc_infomation_model.dart';
import 'package:cmp_customer/ui/common/common_bottom_input_view/bottom_input_view.dart';
import 'package:cmp_customer/ui/common/common_bottom_input_view/pop_route.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_dialog.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_image_big.dart';
import 'package:cmp_customer/ui/common/common_image_widget.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_loadmore.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/common/popover/cupertino_popover.dart';
import 'package:cmp_customer/ui/common/popover/cupertino_popover_menu_item.dart';
import 'package:cmp_customer/ui/pgc/pgc_ui.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/share_util.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:flutter_fai_webview/flutter_fai_webview.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:scoped_model/scoped_model.dart';

import 'chat_page.dart';
import 'market_apply.dart';
import 'market_basedata.dart';
import 'market_ui.dart';

class MarketDetail extends StatefulWidget {
  final int wareId;
  final Function refreshCallback;

  MarketDetail(this.wareId, {this.refreshCallback});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PageState();
  }
}

class _PageState extends State<MarketDetail> {
  ScrollController _loadMoreScrollController = new ScrollController();
  TextEditingController controller = TextEditingController();
  MarketDetailModel _model;
  bool canEdit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _model = MarketDetailModel();
    canEdit = false;
    _refresh();
  }

  /// 轮播图
  Widget _buildSwiper() {
    return Visibility(
      child: Container(
        alignment: Alignment.topCenter,
        width: ScreenUtil.screenWidth,
        height: UIData.spaceSize200,
        child: Swiper(
            autoplay: (_model.marketInfo?.picAttachmentList?.length ?? 0) > 1,
            loop: (_model.marketInfo?.picAttachmentList?.length ?? 0) > 1,
            itemBuilder: (BuildContext context, int index) {
              return CommonImageWidget(_model?.marketInfo?.picAttachmentList[index]?.attachmentUuid, onTap: () {
                Navigate.toNewPage(CommonImageBig(
                  _model.marketInfo.picAttachmentList.map((attachment) => attachment.attachmentUuid).toList(),
                  defaultIndex: index,
                ));
              });
//              return GestureDetector(
//                  child: _model
//                      .marketInfo.picAttachmentList[index].attachmentUuid != null && _model
//                      .marketInfo.picAttachmentList[index].attachmentUuid.isNotEmpty
//                      ? TransitionToImage(
//                    image: AdvancedNetworkImage(
//                      HttpOptions.showPhotoUrl(_model
//                          .marketInfo.picAttachmentList[index].attachmentUuid),
//                      loadedCallback: () => LogUtils.printLog('It works!'),
//                      loadFailedCallback: () => LogUtils.printLog('Oh, no!'),
//                      timeoutDuration: Duration(seconds: 30),
//                      retryLimit: 1,
//                    ),
//                    fit: BoxFit.cover,
//                    placeholder: Image.asset(UIData.imageBannerDefaultFailed, fit: BoxFit.cover),
//                    loadingWidgetBuilder: (
//                        BuildContext context,
//                        double progress,
//                        Uint8List imageData,
//                        ) {
//                      return Image.asset(UIData.imageBannerDefaultLoading, fit: BoxFit.cover);
//                    },
//                  )
//                      : Image.asset(UIData.imageBannerDefaultNoData, fit: BoxFit.cover),
//                  onTap: () {
//                    Navigate.toNewPage(CommonImageBig(
//                      _model.marketInfo.picAttachmentList
//                          .map((attachment) => attachment.attachmentUuid)
//                          .toList(),
//                      defaultIndex: index,
//                    ));
//                  });
//              return GestureDetector(
//                child: CachedNetworkImage(
//                  placeholder: (context, url) =>
//                      Image.asset(UIData.imageBannerDefaultLoading),
//                  errorWidget: (context, url, error) =>
//                      Image.asset(UIData.imageBannerDefaultFailed),
//                  imageUrl: HttpOptions.showPhotoUrl(_model
//                      .marketInfo.picAttachmentList[index].attachmentUuid),
//                  fit: BoxFit.cover,
//                ),
//                onTap: () {
//                  Navigate.toNewPage(CommonImageBig(
//                    _model.marketInfo.picAttachmentList
//                        .map((attachment) => attachment.attachmentUuid)
//                        .toList(),
//                    defaultIndex: index,
//                  ));
//                },
//              );
            },
            itemCount: _model.marketInfo?.picAttachmentList?.length ?? 0,
            pagination: _buildSwiperPagination()),
      ),
      visible: (_model.marketInfo?.picAttachmentList?.length ?? 0) > 0,
    );
  }

  SwiperPlugin _buildSwiperPagination() {
    return SwiperPagination(
        margin: EdgeInsets.all(0.0),
        builder: SwiperCustomPagination(builder: (BuildContext context, SwiperPluginConfig config) {
          return Container(
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(UIData.imageBannerFrontBg), fit: BoxFit.fill)),
            padding: EdgeInsets.only(right: UIData.spaceSize4),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: _model.marketInfo?.picAttachmentList?.length ?? 0,
//                reverse: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: ScreenUtil.getInstance().setWidth(5),
                      height: ScreenUtil.getInstance().setHeight(5),
                      margin: EdgeInsets.only(right: UIData.spaceSize2, top: UIData.spaceSize20),
                      decoration: ShapeDecoration(
                          shape: BeveledRectangleBorder(
                            //每个角落的半径
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          color: config.activeIndex == index ? UIData.themeBgColor : UIData.dividerColor),
                    ),
                  );
                }),
            constraints: new BoxConstraints.expand(height: 35.0),
          );
        }));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModel<MarketDetailModel>(
        model: _model,
        child: ScopedModelDescendant<MarketDetailModel>(builder: (context, child, model) {
//          hasDianzan =
//              (model.marketInfo?.userIsLike ?? '0') == '0' ? false : true;
//          hasSelected =
//              (model.marketInfo?.userIsCollect ?? '0') == '0' ? false : true;
          return CommonScaffold(
              appTitle: '商品详情',
              appBarActions: model.marketInfo != null
                  ? [
                      CupertinoPopoverButton(
                          popoverWidth: UIData.spaceSize100,
                          popoverColor: UIData.greyColor,
                          child: FlatButton(
                            child: CommonText.red15Text('更多'),
                            onPressed: null,
                          ),
                          popoverBuild: (context) {
                            return CupertinoPopoverMenuList(
                              children: <Widget>[
                                Visibility(
                                  visible: canEdit,
                                  child: CupertinoPopoverMenuItemWithIcon(
                                    leading: Icon(Icons.edit),
                                    child: CommonText.white14Text("编辑商品"),
                                    onTap: () {
                                      Navigate.toNewPage(
                                          MarketApplyPage(
                                            detail: model.marketInfo,
                                            marketType: getEnumMarket(model.marketInfo?.tradingType),
                                          ), callBack: (success) {
                                        if (success != null && success) {
                                          if (widget.refreshCallback != null) {
                                            widget.refreshCallback();
                                          }
                                          _refresh();
                                        }
                                      });
                                    },
                                  ),
                                ),
                                Visibility(
                                  visible: canEdit,
                                  child: CupertinoPopoverMenuItemWithIcon(
                                    leading: Icon(Icons.not_interested),
                                    child: CommonText.white14Text(
                                        (model.marketInfo?.status == "1") ? "下架商品" : "上架商品"),
                                    onTap: () {
                                      String operationText = (model.marketInfo?.status == "1") ? "下架" : "上架";
                                      CommonDialog.showAlertDialog(context, title: "确定${operationText ?? ""}该商品？",
                                          onConfirm: () {
                                        CommonToast.show();
                                        model.updateWareStatus({
                                          "waresId": model.marketInfo.waresId,
                                          "status": (model.marketInfo.status == "1") ? "2" : "1"
                                        }, callback: () {
                                          setState(() {
                                            model.marketInfo.status =
                                                (model.marketInfo?.status == "1") ? "2" : "1";
                                          });
                                          CommonToast.show(
                                              type: ToastIconType.SUCCESS,
                                              msg: (model.marketInfo?.status == "1") ? '上架成功' : '已下架');
                                          if (widget.refreshCallback != null) {
                                            Navigate.closePage(true);
                                            widget.refreshCallback();
                                          }
                                        });
                                      }, negativeBtnText: '我点错了');
                                    },
                                  ),
                                ),
                                Visibility(
                                  visible: !canEdit,
                                  child: CupertinoPopoverMenuItemWithIcon(
                                    leading: (model.marketInfo?.userIsCollect ?? false)
                                        ? Icon(
                                            UIData.iconDataStartSelected,
                                            color: UIData.yellowColor,
                                          )
                                        : Icon(
                                            UIData.iconDataStartUnselected,
                                            color: UIData.primaryColor,
                                          ),
                                    child: CommonText.white14Text(
                                        (model.marketInfo?.userIsCollect ?? false) ? "取消收藏" : '点击收藏'),
                                    onTap: () {
                                      model.collectWare({
                                        'waresId': model.marketInfo?.waresId,
                                        'collectType': "1",
                                        'isCollect': (model.marketInfo?.userIsCollect ?? false) ? '0' : '1',
                                      }, callback: () {
                                        CommonToast.show(
                                            type: ToastIconType.SUCCESS,
                                            msg: (model.marketInfo?.userIsCollect ?? false) ? '已取消收藏' : '收藏成功');

                                        setState(() {
                                          model.marketInfo.userIsCollect =
                                              !(model.marketInfo.userIsCollect ?? false);
                                        });
                                        if (widget.refreshCallback != null) {
                                          //收藏页面进来的，取消收藏后，关闭页面，并刷新列表
//                                          Navigate.closePage(true);
                                          widget.refreshCallback();
                                        }
                                      });
                                    },
                                  ),
                                ),
                                CupertinoPopoverMenuItemWithIcon(
                                  leading: Icon(Icons.share),
                                  child: CommonText.white14Text("一键分享"),
                                  onTap: () {
                                    String baseUrl = HttpOptions.baseUrl.replaceAll('ubms-customer/', '');
                                    String picUrl = ShareUtil.showShareMenu(
                                        context,
                                        CommonShareModel(
                                          title: model.marketInfo?.title,
                                          thumbImageUrl: (model.marketInfo?.picAttachmentList != null &&
                                                  model.marketInfo.picAttachmentList.isNotEmpty)
                                              ? HttpOptions.showPhotoUrl(
                                                  model.marketInfo.picAttachmentList[0].attachmentUuid)
                                              : null,
                                          text: model.marketInfo?.content ?? ' ',
                                          url: baseUrl +
                                              "template/appShare/wareDetail.html?id=${model.marketInfo?.waresId}",
                                        ));
                                  },
                                ),
                              ],
                            );
                          }),
                    ]
                  : null,
              bottomNavigationBar: (_model.marketInfo != null)
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          color: UIData.primaryColor,
                          padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize8),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: FlatButton(
                                  color: UIData.scaffoldBgColor,
                                  child: CommonText.grey14Text('发表留言'),
                                  onPressed: () {
                                    getBottomSheet(context, null, false);
                                  },
                                ),
                              ),
                              Visibility(
                                visible: stateModel.accountId != _model.marketInfo.custAppId,
                                child: SizedBox(
                                  width: UIData.spaceSize8,
                                ),
                              ),
                              Visibility(
                                visible: stateModel.accountId != _model.marketInfo.custAppId,
                                child: FlatButton(
                                  color: UIData.lightBlueColor,
                                  child: CommonText.white14Text('马上联系'),
                                  onPressed: () {
                                    Navigate.toNewPage(ChatPage(
                                      model.marketInfo?.waresId,
                                      model.marketInfo?.custAppId,
                                      stateModel.accountId,
                                      model.marketInfo?.nickName,
                                      stateModel.personalInfo?.nickName,
                                    ));
                                  },
                                ),
                              ),
                              SizedBox(
                                width: UIData.spaceSize8,
                              ),
                              PgcIconTextView(
                                leading: (model.marketInfo?.userIsLike ?? false)
                                    ? UIData.iconDianzan2
                                    : UIData.iconDianzan,
                                child: CommonText.lightGrey14Text(getPGCNumb((model.marketInfo?.likeCount ?? 0))),
                                canClick: true,
                                onTap: () {
                                  model.likeWare({
                                    'waresId': model.marketInfo?.waresId,
                                    'isLike': model.marketInfo.userIsLike ? '0' : '1',
                                  }, callback: () {
                                    CommonToast.show(
                                        type: ToastIconType.SUCCESS,
                                        msg: (model.marketInfo?.userIsLike ?? false) ? '点赞-1' : '点赞+1');
                                    setState(() {
                                      model.marketInfo.userIsLike = !(model.marketInfo?.userIsLike ?? false);
                                      model.marketInfo.likeCount = model.marketInfo.userIsLike
                                          ? ((model.marketInfo?.likeCount ?? 0) + 1)
                                          : ((model.marketInfo?.likeCount ?? 0) - 1);
                                      if ((model.marketInfo?.likeCount ?? 0) < 0) {
                                        model.marketInfo?.likeCount = 0;
                                      }
                                    });
                                    if (widget.refreshCallback != null) {
                                      widget.refreshCallback();
                                    }
                                  });
                                },
                              ),
                              SizedBox(
                                width: UIData.spaceSize8,
                              ),
                              PgcIconTextView(
                                leading: UIData.iconWenzhangliulanshu,
                                child: CommonText.lightGrey14Text(getPGCNumb(
                                    model.marketInfo?.browseCount ?? (model.marketInfo?.browseCount ?? 0))),
                              ),
                              SizedBox(
                                width: UIData.spaceSize8,
                              ),
                              PgcIconTextView(
                                leading: UIData.iconPinlun,
                                child: CommonText.lightGrey14Text(getPGCNumb(((_model.records?.length ?? 0) > 0)
                                    ? _model.records.length
                                    : (model.marketInfo?.commentCount ?? 0))),
                                canClick: true,
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : null,
              bodyData: _buildDetail());
        }));
  }

  Widget _buildDetail() {
    return ScopedModelDescendant<MarketDetailModel>(
      builder: (context, child, model) {
        return CommonLoadContainer(
            state: _model.listState,
            content: SingleChildScrollView(
              controller: _loadMoreScrollController,
              child: Column(
                children: <Widget>[
                  _buildSwiper(),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              CommonText.darkGrey16Text(model.marketInfo?.title ?? "",
                                  fontWeight: FontWeight.bold),
                              SizedBox(
                                height: UIData.spaceSize8,
                              ),
                              Visibility(
                                visible: model.marketInfo?.tradingType ==
                                    StringsHelper.enum2String(MarketType.XSY), //小生意
                                child: CommonText.orange14Text(
                                    getPriceAndUnit(
                                        model.marketInfo?.price?.toString(), model.marketInfo?.priceDescribe),
                                    fontWeight: FontWeight.bold),
                              ),
                              Visibility(
                                visible:
                                    model.marketInfo?.tradingType == StringsHelper.enum2String(MarketType.ES), //二手
                                child: Row(
                                  children: <Widget>[
                                    CommonText.orange14Text(
                                        model.marketInfo?.price != null
                                            ? "￥${StringsHelper.validDecimalFormat(model.marketInfo?.price?.toString()) ?? ""}"
                                            : "",
                                        fontWeight: FontWeight.bold),
                                    Visibility(
                                      visible: model.marketInfo?.priceBak != null,
                                      child: Container(
                                        margin: EdgeInsets.only(left: UIData.spaceSize8),
                                        child: CommonText.text14(
                                            " ￥${StringsHelper.validDecimalFormat(model.marketInfo?.priceBak?.toString()) ?? ''}",
                                            color: UIData.lightGreyColor,
                                            textDecoration: TextDecoration.lineThrough),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible:
                                    model.marketInfo?.tradingType == StringsHelper.enum2String(MarketType.ZJ), //租借
                                child: Row(
                                  children: <Widget>[
                                    CommonText.lightGrey14Text("租金："),
                                    Expanded(
                                      child: CommonText.orange14Text(
                                          getPriceAndUnit(model.marketInfo?.price?.toString(),
                                              model.marketInfo?.priceDescribe),
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                              Visibility(
                                visible:
                                    model.marketInfo?.tradingType == StringsHelper.enum2String(MarketType.ZJ) &&
                                        model.marketInfo?.priceBak != null, //租借
                                child: Row(
                                  children: <Widget>[
                                    CommonText.lightGrey14Text("押金："),
                                    Expanded(
                                      child: CommonText.orange14Text(
                                          "￥${StringsHelper.validDecimalFormat(model.marketInfo?.priceBak?.toString()) ?? ''}",
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: UIData.spaceSize8,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize16),
                                child: CommonText.darkGrey14Text(model.marketInfo?.content ?? "",
                                    overflow: TextOverflow.fade),
                              )
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            RadiusSolidText(
                              text: '${MarketTypeMap[model.marketInfo?.tradingType] ?? ""}',
                              color: UIData.primaryColor,
                              backgroundColor: getMarketTypeColor(model.marketInfo?.tradingType),
                              horizontalPadding: UIData.spaceSize6,
                              verticalPadding: UIData.spaceSize2,
                            ),
//                            CommonText.text14(
//                                MarketTypeMap[model.marketInfo?.tradingType] ??
//                                    "",
//                                color: getMarketTypeColor(model.marketInfo?.tradingType)),
                            Visibility(
                                visible:
                                    model.marketInfo?.tradingType == StringsHelper.enum2String(MarketType.ES) &&
                                        model.marketInfo?.tradingOpt == "1",
                                child: Container(
                                  margin: EdgeInsets.only(top: UIData.spaceSize4),
                                  child: RadiusSolidText(
                                    text: '可交换',
                                    color: UIData.primaryColor,
                                    backgroundColor: UIData.marketGreyColor,
                                    horizontalPadding: UIData.spaceSize6,
                                    verticalPadding: UIData.spaceSize2,
                                  ),
                                )
//                              CommonText.text14("可交换",
//                                  color: UIData.greenColor),
                                ),
                            Visibility(
                              visible: model.marketInfo?.tradingType == StringsHelper.enum2String(MarketType.ZJ) &&
                                  model.marketInfo?.tradingOpt == "1",
                              child:
//                              CommonText.text14("押金可免",
//                                  color: UIData.pgcBlueTextColor),
                                  Container(
                                margin: EdgeInsets.only(top: UIData.spaceSize4),
                                child: RadiusSolidText(
                                  text: '押金可免',
                                  color: UIData.primaryColor,
                                  backgroundColor: UIData.marketGreyColor,
                                  horizontalPadding: UIData.spaceSize6,
                                  verticalPadding: UIData.spaceSize2,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    color: UIData.primaryColor,
                    padding: EdgeInsets.symmetric(vertical: UIData.spaceSize12, horizontal: UIData.spaceSize16),
                  ),
                  CommonDivider(),
                  Container(
                    child: Row(children: <Widget>[
                      Container(
                        width: UIData.spaceSize18 * 2,
                        height: UIData.spaceSize18 * 2,
                        margin: EdgeInsets.only(right: UIData.spaceSize8),
                        padding: EdgeInsets.all(1.0),
                        decoration: ShapeDecoration(shape: StadiumBorder(), color: UIData.primaryColor),
                        child: ClipOval(
                          child: CommonImageWidget(model.marketInfo?.userPicture?.attachmentUuid,
                              loadingImage: UIData.imagePortrait,
                              loadedFailedImage: UIData.imagePortrait,
                              loadedNoDataImage: UIData.imagePortrait),
//                          child: StringsHelper.isNotEmpty(
//                                  model.marketInfo?.userPicture?.attachmentUuid)
//                              ? CachedNetworkImage(
//                                  placeholder: (context, url) =>
//                                      Image.asset(UIData.imagePortrait),
//                                  errorWidget: (context, url, error) =>
//                                      Image.asset(UIData.imagePortrait),
//                                  imageUrl: HttpOptions.showPhotoUrl(model
//                                      .marketInfo?.userPicture?.attachmentUuid),
//                                  fit: BoxFit.fill,
//                                )
//                              : Image.asset(
//                                  UIData.imagePortrait,
//                                  fit: BoxFit.fill,
//                                ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                CommonText.darkGrey14Text(model.marketInfo?.nickName ?? ""),
                                SizedBox(
                                  width: UIData.spaceSize8,
                                ),
                                model.marketInfo?.customerType == 2 ? UIData.iconMarketRZYH : UIData.iconMarketYK,
                                CommonText.text12((model.marketInfo?.customerType == 2) ? "认证用户" : "游客",
                                    color: (model.marketInfo?.customerType == 2)
                                        ? UIData.orangeColor
                                        : UIData.pgcBlueTextColor),
                              ],
                            ),
                            CommonText.lightGrey12Text(
                                getProjectAndCity(model.marketInfo?.projectName, model.marketInfo?.city)),
                          ],
                        ),
                      ),
                      CommonText.lightGrey12Text(model.marketInfo?.createTime ?? ""),
                    ]),
                    color: UIData.primaryColor,
                    padding: EdgeInsets.symmetric(vertical: UIData.spaceSize12, horizontal: UIData.spaceSize16),
                  ),
                  _buildList()
                ],
              ),
            ),
            callback: () {
              _refresh();
            });
      },
    );
  }

  Future<void> _refresh() async {
    _model.getDetail(widget.wareId, callBack: () {
      setState(() {
        canEdit = (_model.marketInfo?.custAppId == stateModel.accountId);
      });
      _getCommentData();
    });
  }

  void _getCommentData() async {
    _model.commentInfoListHistoryHandleRefresh(
        map: {"waresId": widget.wareId ?? ''},
        callback: () {
          _loadMoreScrollController.addListener(() {
            if (_loadMoreScrollController.position.pixels == _loadMoreScrollController.position.maxScrollExtent) {
              if (_model.commentListState != ListState.HINT_LOADING) {
                _model.commentInfoListHandleLoadMore(map: {
                  'pgcId': widget.wareId,
                });
              }
            }
          });
        });
  }

  Widget _buildList() {
    return ScopedModelDescendant<MarketDetailModel>(builder: (context, child, model) {
      return ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: (model.records?.length ?? 0) + 2,
        separatorBuilder: (BuildContext context, int index) {
          return CommonDivider();
        },
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Container(
              color: UIData.primaryColor,
              margin: EdgeInsets.only(top: UIData.spaceSize8),
              padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize16, vertical: UIData.spaceSize8),
              child: CommonText.darkGrey16Text(
                  '${getPGCNumb(((_model.records?.length ?? 0) > 0) ? _model.records.length : (model.marketInfo?.commentCount ?? 0))}条评论',
                  fontWeight: FontWeight.bold),
            );
          } else if ((model.records?.length ?? 0) == index - 1) {
            if (model.commentListState == ListState.HINT_NO_DATA_CLICK) {
              return CommonLoadMoreForPgc();
            } else if (model.commentListState == ListState.HINT_LOADING) {
              return CommonLoadMore(model.historyMaxCount);
            } else if (model.commentListState == ListState.HINT_LOADED_FAILED_CLICK) {
              return FlatButton(
                child: Container(
                  child: CommonLoadMoreForPgc(tips: '获取失败，点击刷新'),
                  padding: EdgeInsets.only(bottom: UIData.spaceSize16),
                ),
                onPressed: () {
                  _model.commentInfoListHandleLoadMore(map: {
                    'waresId': model.marketInfo.waresId,
                  });
                },
              );
            } else {
              if (model.historyMaxCount)
                return CommonLoadMore(model.historyMaxCount);
              else {
                return Container();
              }
            }
          } else if ((model.records?.length ?? 0) > 0) {
            Record info = model.records[index - 1];
            return MarketDiscussItem(info, infoType: PgcInfoType.infomation, onMessageTap: () {
              if (stateModel.accountId != info.custId) {
                getBottomSheet(context, info, true);
              }
            });
          } else {
            return Container();
          }
        },
      );
    });
  }

  getBottomSheet(BuildContext context, Record info, bool isAnswer) {
    TextEditingController controller = new TextEditingController();

    Navigator.push(
        context,
        PopRoute(
            child: BottomInputView(isAnswer ? "回复${info?.nickName ?? ''}" : "发表评论", () {
          if (StringsHelper.isNotEmpty(controller.text)) {
            CommonToast.show();
            _model.addWareComment({
              'commentType': isAnswer ? "0" : "1",
              'content': controller.text,
              'waresId': _model.marketInfo?.waresId, //商品id
              'lastCommentId': isAnswer ? info?.custId : null, //上一层的客户id
              'rootCommentId': isAnswer ? info?.waresCommentId : null, //上一层的留言id
              'projectId': stateModel?.defaultProjectId,
            }, callback: () {
              CommonToast.show(type: ToastIconType.SUCCESS, msg: '成功发表');
              controller.text = '';
              Navigator.of(context).pop();
//              _model.marketInfo?.browseCount =
//                  (_model.marketInfo?.browseCount ?? 0) + 1;
              _getCommentData();
            });
          } else {
            CommonToast.show(type: ToastIconType.FAILED, msg: '请先输入内容');
          }
        }, controller)));
  }

//  Row textField() {
//    return Row(
//      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//      crossAxisAlignment: CrossAxisAlignment.end,
//      children: <Widget>[
//        Expanded(
//          child: new TextField(
//            controller: controller,
//            decoration: InputDecoration(
//              hintText: '发表...',
//              border: null,
//              focusedBorder: UnderlineInputBorder(
//                borderSide: BorderSide(color: UIData.themeBgColor),
//              ),
//            ),
//            keyboardType: TextInputType.text,
//            maxLength: 600,
//            maxLines: 10,
//          ),
//        ),
//        FlatButton(
//          child: CommonText.red14Text('发表'),
//          onPressed: () {
//            if (StringsHelper.isNotEmpty(controller.text)) {
//              CommonToast.show();
//              _model.createCustomerOperation({
//                'type': '3',
//                'content': controller.text,
//                'waresId': model.marketInfo?.waresId
//              }, callback: () {
//                CommonToast.show(type: ToastIconType.SUCCESS, msg: '成功发表');
//                controller.text = '';
//                Navigator.of(context).pop();
//                _model.marketInfo?.commentCount =
//                    (_model.marketInfo?.commentCount ?? 0) + 1;
//                _model.commentInfoListHistoryHandleRefresh(
//                    map: {'waresId': model.marketInfo?.waresId, 'sortName': searchType});
//              });
//            } else {
//              CommonToast.show(type: ToastIconType.FAILED, msg: '请先输入内容');
//            }
//          },
//        ),
//      ],
//    );
//  }
}
