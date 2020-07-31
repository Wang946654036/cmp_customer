import 'package:cmp_customer/scoped_models/visitor_release_state_model.dart';
import 'package:cmp_customer/strings/strings_common.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/decorate_manager/decoration_ui.dart';
import 'package:cmp_customer/ui/visitor_release/visit_content_view.dart';
import 'package:cmp_customer/ui/visitor_release/visitor_release_common_ui.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/share_util.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

///
/// Created by yyy
/// 详情页面
///
class VisitorReleaseDetailPage extends StatefulWidget {
  final VisitorReleaseStateModel stateModel;
  final int releasePassId;

  VisitorReleaseDetailPage(this.stateModel, this.releasePassId);

  @override
  _VisitorReleaseDetailPageState createState() =>
      _VisitorReleaseDetailPageState();
}

class _VisitorReleaseDetailPageState extends State<VisitorReleaseDetailPage> {
  final GlobalKey _shareWidgetKey = GlobalKey();

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
    widget.stateModel.getVisitorReleaseDetail(widget.releasePassId);
  }

  void finishThisPage() {
    Navigate.closePage(true);
  }

  Widget _buildTop() {
    return

        ///状态操作栏
        Container(
            color: Colors.white,

            child: Column(
              children: <Widget>[
                ///状态栏
                CommonText.darkGrey16Text(
                    '${widget.stateModel.visitorReleaseDetail?.stateName ?? getStateName(widget.stateModel.visitorReleaseDetail?.state)}'),
                Container(
                  padding: EdgeInsets.only(top: UIData.spaceSize8,bottom: UIData.spaceSize12, left: UIData.spaceSize16,
                    right: UIData.spaceSize16,),
                  child: CommonText.lightGrey12Text(StringsHelper.isNotEmpty(
                          widget.stateModel.visitorReleaseDetail?.acceptRemark)
                      ? '受理意见：' +
                          widget.stateModel.visitorReleaseDetail?.acceptRemark
                      : '尊敬的用户，我们将竭诚为您服务。',overflow: TextOverflow.visible),
                ),

                ///二维码分享
                RepaintBoundary(
                  key: _shareWidgetKey,
                  child: Visibility(
                      visible: widget.stateModel.visitorReleaseDetail?.state ==
                          hasSuc,
                      child: Container(
                          color: UIData.primaryColor,
                          padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(height: UIData.spaceSize12),
                              QrImage(
                                size: ScreenUtil.screenWidthDp / 2,
                                padding: EdgeInsets.zero,
                                version: 2,
                                //二维码版本，越高可显示字符越多
                                data: StringsHelper.enum2String(
                                        QRCodeType.VisitorRelease) +
                                    '_' +
                                    widget.releasePassId.toString()+"_YYDF",
                                onError: (ex) {
                                  setState(() {
                                    LogUtils.printLog('二维码生成失败：$ex');
                                  });
                                },
                              ),
//
                              Container(
                                color: UIData.primaryColor,
                                width: ScreenUtil.screenWidthDp / 4*3,
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: UIData.spaceSize12),

                                    labelTextWidgetForVisit(
                                      labelColor:UIData.lightGreyColor,
                                      color: UIData.lightGreyColor,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      label: '可使用日期：',
                                      text: StringsHelper.isNotEmpty(widget
                                              .stateModel
                                              .visitorReleaseDetail
                                              ?.visitDate)
                                          ? '${widget.stateModel.visitorReleaseDetail?.visitDate}${(widget.stateModel.visitorReleaseDetail?.effective ?? 1)==1?'':"至 ${StringsHelper.formatterYMD.format(DateTime.parse(widget.stateModel.visitorReleaseDetail?.visitDate).add(Duration(days: (widget.stateModel.visitorReleaseDetail?.effective ?? 1)-1)))}"} '
                                          : '',
                                    ),
//
                                    SizedBox(height: UIData.spaceSize8),
                                    labelTextWidgetForVisit(
                                      labelColor:UIData.lightGreyColor,
                                      color: UIData.lightGreyColor,
//                                      isBold:true,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      label: '可用时间段：',
                                      textAlign: TextAlign.left,
                                      text:
                                          '${widget.stateModel.visitorReleaseDetail?.beginTime ?? '09:00'}-${widget.stateModel.visitorReleaseDetail?.endTime ?? '17:00'}',
                                    ),
//
                                    SizedBox(height: UIData.spaceSize8),
                                    labelTextWidgetForVisit(
                                      labelColor:UIData.lightGreyColor,
                                      color: UIData.lightGreyColor,

                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      label: '温馨提示：',
                                      text: '请把预约二维码截图分享给访客，到达社区时请向门卫出示预约凭证。',
                                    ),
                                    SizedBox(height: UIData.spaceSize8),
//                                      CommonText.lightGrey12Text('温馨提示：请把预约二维码截图分享给访客，到达社区时请向门卫出示预约凭证。',overflow: TextOverflow.visible),
                                  ],
                                ),
                              )
                            ],
                          ))),
                ),
                CommonFullScaleDivider(),
                Visibility(
                    child: FlatButton(
                        onPressed: () {
                          ShareUtil.shareWidget(_shareWidgetKey);
                        },
                        child: CommonText.red16Text('分享')),
                    // 温馨提示和分享：审核通过显示
                    visible: widget.stateModel.visitorReleaseDetail?.state ==
                        hasSuc),
              ],
            ));
  }

  Widget _buildContent() {
    return Container(
      child: ListView(
        children: <Widget>[
          _buildTop(),
          SizedBox(height: UIData.spaceSize12,),
          VisitorReleaseContentView(
              false, widget.stateModel.visitorReleaseDetail, widget.stateModel),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return CommonLoadContainer(
      state: widget.stateModel.visitorReleaseInfoState,
      content: _buildContent(),
      callback: _refreshData,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<VisitorReleaseStateModel>(
      model: widget.stateModel,
      child: ScopedModelDescendant<VisitorReleaseStateModel>(
        builder: (context, child, model) {
          return CommonScaffold(
            appTitle: '预约到访详情',
            bodyData: _buildBody(),
          );
        },
      ),
    );
  }
}
