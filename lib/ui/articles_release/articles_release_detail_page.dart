import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/articles_release_detail_model.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/scoped_models/images_state_model.dart';
import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/strings/strings_articles_release.dart';
import 'package:cmp_customer/strings/strings_common.dart';
import 'package:cmp_customer/ui/articles_release/articles_release_apply_page.dart';
import 'package:cmp_customer/ui/articles_release/articles_release_detail_node.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_dialog.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_image_display.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_text_field.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/common/scrawl_page/scrawl_page.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_state.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/share_util.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:qr_flutter/qr_flutter.dart';

///
/// 物品放行详情
/// [customerType] 查询类型，业主查询租户申请：0，查询自己的申请：1
///
class ArticlesReleaseDetailPage extends StatefulWidget {
  final int releasePassId;
  final Function callback;
  final int customerType;
  final String toOwnerAgree;

  ArticlesReleaseDetailPage(this.releasePassId, {this.callback, this.customerType, this.toOwnerAgree});

  @override
  _ArticlesReleaseDetailPageState createState() => _ArticlesReleaseDetailPageState();
}

class _ArticlesReleaseDetailPageState extends State<ArticlesReleaseDetailPage> {
  ArticlesReleasePageModel _pageModel = ArticlesReleasePageModel();
  final GlobalKey _shareWidgetKey = GlobalKey();
  final TextEditingController _remarkController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _refreshData() {
    stateModel.getArticlesReleaseDetail(widget.releasePassId, _pageModel);
  }

  Widget _buildTop() {
    return Container(
      color: UIData.primaryColor,
//      padding: EdgeInsets.only(bottom: UIData.spaceSize16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Visibility(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: UIData.spaceSize8, horizontal: UIData.spaceSize16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        width: ScreenUtil.getInstance().setWidth(20), child: Image.asset(UIData.iconMerchantsLogo)),
                    SizedBox(width: UIData.spaceSize8),
                    CommonText.darkGrey14Text('招商局物业管理有限公司'),
                    SizedBox(width: UIData.spaceSize8),
                    CommonText.darkGrey14Text('表 380-7A'),
                  ],
                ),
              ),
              visible: _pageModel.articlesReleaseDetail?.status == articlesReleaseSHTG),
          Visibility(
              child: CommonText.darkGrey18Text(_pageModel.articlesReleaseDetail?.statusDesc ?? ''),
              // 显示状态：审核通过/放行通过/放行不通过
              visible: _pageModel.articlesReleaseDetail?.status == articlesReleaseSHTG ||
                  _pageModel.articlesReleaseDetail?.status == articlesReleaseFXBTG ||
                  _pageModel.articlesReleaseDetail?.status == articlesReleaseFXTG),
          RepaintBoundary(
            key: _shareWidgetKey,
            child: ListView(
              shrinkWrap: true,
//              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Visibility(
                    // 显示二维码：审核通过/放行通过/放行不通过
                    visible: _pageModel.articlesReleaseDetail?.status == articlesReleaseSHTG ||
                        _pageModel.articlesReleaseDetail?.status == articlesReleaseFXBTG ||
                        _pageModel.articlesReleaseDetail?.status == articlesReleaseFXTG,
                    child: Container(
                        color: UIData.primaryColor,
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: UIData.spaceSize12),
                            QrImage(
                              size: ScreenUtil.screenWidthDp / 3,
                              padding: EdgeInsets.zero,
                              version: 2,
                              //二维码版本，越高可显示字符越多
                              data: StringsHelper.enum2String(QRCodeType.ArticlesRelease) +
                                  '_' +
                                  widget.releasePassId.toString(),
                              onError: (ex) {
                                setState(() {
                                  LogUtils.printLog('二维码生成失败：$ex');
                                });
                              },
                            ),
                            SizedBox(height: UIData.spaceSize12),
                            CommonText.red14Text(_pageModel.articlesReleaseDetail?.outTime != null
                                ? '有效期${StringsHelper.formatterYMD.format(DateTime.parse(_pageModel.articlesReleaseDetail?.outTime).add(Duration(days: -1)))}'
                                    '至${StringsHelper.formatterYMD.format(DateTime.parse(_pageModel.articlesReleaseDetail?.outTime).add(Duration(days: 1)))}'
                                : ''),
                            SizedBox(height: UIData.spaceSize12),
                          ],
                        ))),
                Visibility(
                    // 温馨提示和分享：审核通过显示
                    visible: _pageModel.articlesReleaseDetail?.status == articlesReleaseSHTG,
                    child: Container(
                      color: UIData.primaryColor,
                      child: Column(
                        children: <Widget>[
                          CommonText.lightGrey12Text('温馨提示：1、出门时，请向门岗出示此二维码；\n2、请在有效期内使用，否则门岗将不允放行。'),
                          SizedBox(height: UIData.spaceSize12),
                          CommonFullScaleDivider(),
                        ],
                      ),
                    ))
              ],
            ),
          ),
          Visibility(
              child: FlatButton(
                  onPressed: () {
                    ShareUtil.shareWidget(_shareWidgetKey);
                  },
                  child: CommonText.red16Text('分享')),
              // 温馨提示和分享：审核通过显示
              visible: _pageModel.articlesReleaseDetail?.status == articlesReleaseSHTG),
          Visibility(
              //业主审核不通过或物业审核不通过显示审核意见
              visible: _pageModel.articlesReleaseDetail?.status == articlesReleaseSHBTG ||
                  _pageModel.articlesReleaseDetail?.status == articlesReleaseYZSHBTG,
              child: Column(
                children: <Widget>[
                  CommonText.darkGrey18Text(_pageModel.articlesReleaseDetail?.statusDesc ?? ''),
                  SizedBox(height: UIData.spaceSize4),
                  CommonText.grey14Text(_pageModel.articlesReleaseDetail?.remark ?? ''),
                  SizedBox(height: UIData.spaceSize12),
                ],
              ))
        ],
      ),
    );
  }

  Widget _buildDetail() {
    return Container(
      color: UIData.primaryColor,
      padding: EdgeInsets.all(UIData.spaceSize16),
      child: Column(
        children: <Widget>[
          DetailSingleRow('业务单号', _pageModel.articlesReleaseDetail?.businessNo ?? ''),
          DetailSingleRow('办理进度', _pageModel.articlesReleaseDetail?.statusDesc ?? ''),
          DetailSingleRow(
              '房号',
              (_pageModel.articlesReleaseDetail?.formerName ?? '') +
                  (_pageModel.articlesReleaseDetail?.buildName ?? '') +
                  (_pageModel.articlesReleaseDetail?.unitName ?? '') +
                  (_pageModel.articlesReleaseDetail?.houseNo ?? '')),
          DetailSingleRow('申请人', _pageModel.articlesReleaseDetail?.customerName ?? ''),
          DetailSingleRow('申请人电话', _pageModel.articlesReleaseDetail?.customerPhone ?? ''),
          DetailSingleRow('证件号码', _pageModel.articlesReleaseDetail?.custIdNum ?? ''),
          DetailSingleRow(
              '申请理由',
              articleReleaseReasonMap.keys.firstWhere(
                  (String key) => articleReleaseReasonMap[key] == _pageModel.articlesReleaseDetail?.reason,
                  orElse: () => '')),
          DetailSingleRow('出门日期', _pageModel.articlesReleaseDetail?.outTime),
          Visibility(
              child: DetailSingleRow(
                  '',
                  StringsHelper.isNotEmpty(_pageModel.articlesReleaseDetail?.outTime)
                      ? CommonText.text13(
                          '有效期${StringsHelper.formatterYMD.format(DateTime.parse(_pageModel.articlesReleaseDetail?.outTime).add(Duration(days: -1)))}'
                          '至${StringsHelper.formatterYMD.format(DateTime.parse(_pageModel.articlesReleaseDetail?.outTime).add(Duration(days: 1)))}',
                          color: UIData.themeBgColor,
                          overflow: TextOverflow.fade)
                      : ''),
              visible: StringsHelper.isNotEmpty(_pageModel.articlesReleaseDetail?.outTime)),
          DetailSingleRow('车牌号码', _pageModel.articlesReleaseDetail?.carNo ?? ''),
          DetailSingleRow('单位证明', null),
          Container(
            padding: EdgeInsets.only(bottom: UIData.spaceSize12),
            child: CommonImageDisplay(
                photoIdList: _pageModel.articlesReleaseDetail?.attDwzmList
                    ?.map((Attachment attach) => attach?.attachmentUuid)
                    ?.toList()),
          ),
//          DetailSingleRow('物品数量', _pageModel.articlesReleaseDetail?.goodNums?.toString()),
//          DetailSingleRow('物品名称', _pageModel.articlesReleaseDetail?.goodNames),
//          DetailSingleRow('物品照片', null),
//          Container(
//            padding: EdgeInsets.only(bottom: UIData.spaceSize12),
//            child: CommonImageDisplay(
//                photoIdList: _pageModel.articlesReleaseDetail?.attWpzpList
//                    ?.map((Attachment attach) => attach?.attachmentUuid)
//                    ?.toList()),
//          ),
        ],
      ),
    );
  }

  //物品列表
  Widget _buildGoodsList() {
    return Visibility(
        visible: _pageModel?.articlesReleaseDetail?.goodsList != null &&
            _pageModel.articlesReleaseDetail.goodsList.length > 0,
        child: ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: UIData.spaceSize8),
            itemCount: _pageModel?.articlesReleaseDetail?.goodsList?.length ?? 0,
            itemBuilder: (context, index) {
//              WelderInfo welderInfo = _applyModel.welderList[index];
              return GoodsCard(index, _pageModel?.articlesReleaseDetail, false);
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: UIData.spaceSize16);
            }));
  }

  //跟踪节点
  Widget _buildNode() {
    return Container(
      color: UIData.primaryColor,
      child: ArticlesReleaseNode(_pageModel.articlesReleaseDetail?.recordList),
    );
  }

  //审核意见
  Widget _buildRemark() {
    return Visibility(
        //待业主审核并且是租户申请才显示审核意见
        visible: (widget.customerType == 0 || widget.toOwnerAgree == '1') &&
            _pageModel.articlesReleaseDetail?.status == articlesReleaseDYZSH,
        child: Container(
          margin: EdgeInsets.only(top: UIData.spaceSize8),
          child: FormMultipleTextField('审核意见', hintText: '请输入审核意见', controller: _remarkController),
        ));
  }

  Widget _buildContent() {
    return Container(
      child: ListView(
//        padding: EdgeInsets.only(top: UIData.spaceSize16),
        shrinkWrap: true,
        children: <Widget>[
          _buildTop(),
          SizedBox(height: UIData.spaceSize8),
          _buildDetail(),
          _buildGoodsList(),
          _buildRemark(),
          SizedBox(height: UIData.spaceSize8),
          _buildNode(),
          SizedBox(height: UIData.spaceSize8),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return CommonLoadContainer(
      state: _pageModel.pageState,
      content: _buildContent(),
      callback: _refreshData,
    );
  }

  //取消申请
  void _cancelAction() {
    CommonDialog.showAlertDialog(context,
        title: '取消申请',
        content: '确认取消该物品放行申请？',
        onConfirm: () => stateModel.changeArticleReleaseStatus(widget.releasePassId, articleReleaseQXSQ,
            callBack: widget.callback));
  }

  //业主操作（0-不通过、1-通过）
  void _YZAction(String flag) {
    if (_remarkController.text == null || _remarkController.text.isEmpty)
      CommonToast.show(msg: '请输入审核意见', type: ToastIconType.INFO);
    else {
      //通过需要签名才能提交
      if (flag == '1') {
        Navigate.toNewPage(ScrawlPage(), callBack: (path) {
          if (path != null && path is String && StringsHelper.isNotEmpty(path))
            ImagesStateModel().uploadFile(path, (data) {
              CommonToast.dismiss();
              Attachment info = Attachment.fromJson(data);
              List attWpSignList = List();
              attWpSignList.add(info);
              stateModel.changeArticleReleaseStatus(widget.releasePassId, articleReleaseYZSH,
                  passFlag: flag,
                  remark: _remarkController.text,
                  attWpSignList: attWpSignList,
                  callBack: widget.callback);
            }, (data) {
              CommonToast.show(type: ToastIconType.FAILED, msg: data?.toString() ?? "");
            });
//                    }
        });
      } else {
        stateModel.changeArticleReleaseStatus(widget.releasePassId, articleReleaseYZSH,
            passFlag: flag, remark: _remarkController.text, callBack: widget.callback);
      }
    }
  }

  Widget _buildBottomNavigationBar() {
    if (_pageModel.pageState == ListState.HINT_DISMISS) {
      /// 待审核、待业主审核、业主审核不通过、审核不通过可以取消申请
      /// 本单是租户提交并且是待业主同意、本单是业主提交并且是待物业通过都可以修改申请
      if ((widget.customerType == 1 || widget.toOwnerAgree == "0") &&
          (_pageModel.articlesReleaseDetail?.status == articlesReleaseDSH ||
              _pageModel.articlesReleaseDetail?.status == articlesReleaseDYZSH ||
              _pageModel.articlesReleaseDetail?.status == articlesReleaseYZSHBTG ||
              _pageModel.articlesReleaseDetail?.status == articlesReleaseSHBTG)) {
        if ((_pageModel.articlesReleaseDetail?.status == articlesReleaseYZSHBTG ||
                _pageModel.articlesReleaseDetail?.status == articlesReleaseSHBTG) ||
            ((_pageModel.articlesReleaseDetail?.applyType == customerYZ &&
                    _pageModel.articlesReleaseDetail?.status == articlesReleaseDSH) ||
                (_pageModel.articlesReleaseDetail?.applyType == customerZH &&
                    _pageModel.articlesReleaseDetail?.status == articlesReleaseDYZSH))) {
          return StadiumSolidWithTowButton(
              conFirmText: '修改申请',
              cancelText: '取消申请',
              onConFirm: () =>
                  Navigate.toNewPage(ArticlesReleaseApplyPage(applyModel: _pageModel.articlesReleaseDetail),
                      callBack: (bool value) {
                    if (value != null && value) {
                      _refreshData();
                      Navigate.closePage(true);
                    }
                  }),
              onCancel: () => _cancelAction());
        } else {
          return StadiumSolidButton('取消申请', onTap: () => _cancelAction());
        }
      }
      //待业主同意状态并且租户申请列表进来，则显示同意和不同意按钮
      else if ((widget.customerType == 0 || widget.toOwnerAgree == "1") &&
          _pageModel.articlesReleaseDetail?.status == articlesReleaseDYZSH)
        return StadiumSolidWithTowButton(
            conFirmText: '同意',
            cancelText: '不同意',
            onConFirm: () {
              _YZAction('1');
            },
            onCancel: () {
              _YZAction('0');
            });
      else
        return null;
    } else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
      return CommonScaffold(
        appTitle: '物品放行详情',
        bodyData: _buildBody(),
        //待审核和审核不通过才显示修改申请和取消办理按钮
        bottomNavigationBar: _buildBottomNavigationBar(),
      );
    });
  }
}

class ArticlesReleasePageModel {
  ArticlesReleaseDetail articlesReleaseDetail = ArticlesReleaseDetail();
  ListState pageState = ListState.HINT_LOADING;
}
