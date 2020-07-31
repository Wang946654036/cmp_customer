import 'package:cmp_customer/http/http_options.dart';
///装修许可证详情
///
///
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/decoration_permit_obj.dart';
import 'package:cmp_customer/models/project_setting_model.dart';
import 'package:cmp_customer/scoped_models/decoration_permit_model.dart';
import 'package:cmp_customer/strings/strings_common.dart';
import 'package:cmp_customer/ui/common/common_bottom_input_view/bottom_input_view.dart';
import 'package:cmp_customer/ui/common/common_bottom_input_view/pop_route.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/work_other/add_worker.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/date_util.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/share_util.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

import '../decoration_ui.dart';
import 'decoration_permit_detail_delay.dart';

class DecorationPermitDetail extends StatefulWidget {
  int infoId;
  DecorationPermitModel _model;

  DecorationPermitDetail(this.infoId);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DecorationPermitDetailState();
  }
}

class _DecorationPermitDetailState extends State<DecorationPermitDetail> {
  int delayLong;
  final GlobalKey _shareWidgetKey = GlobalKey();
  GlobalKey<BottomInputViewState> _handleGlobalKey = GlobalKey<BottomInputViewState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget._model = new DecorationPermitModel();
    widget._model.getDecorationPermitInfo(widget.infoId);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModel<DecorationPermitModel>(
        model: widget._model,
        child: ScopedModelDescendant<DecorationPermitModel>(
            builder: (context, child, model) {
          DecorationPermitInfo info = model.decorationPermitInfo;
          if (info?.delayDate == null) {
            if (info?.fromDate != null && info?.applyVo?.workDayLong != null) {
              DateTime from = DateTime.parse(info?.fromDate);
              DateTime dalay =
                  from.add(new Duration(days: info?.applyVo?.workDayLong));
              info?.delayDate = "${dalay.year}-${dalay.month}-${dalay.day}";
            }
          }
          return CommonScaffold(
              appTitle: "许可证详情",
              bodyData: _buildBody(),
              bottomNavigationBar: Column(
                children: <Widget>[

                  //正常证件-未申请延期
//                  Visibility(
//                      visible: StringsHelper.isEmpty(info?.delayState ?? '') &&
//                          isOverTime(info?.delayDate ?? '') == normalTime,
//                      child: StadiumSolidWithTowButton(
//                        cancelText: "延期申请",
//                        onCancel: () {
//                          getBottomSheet(context, '延期申请');
//                        },
//                        conFirmText: "发送给他",
//                        onConFirm: () {},
//                      )),
                  Visibility(
                      visible: StringsHelper.isEmpty(info?.delayState ?? '') &&
                          isOverTime(info?.delayDate ?? '') == normalTime,
                      child: Row(children: <Widget>[Expanded(child: StadiumSolidButton(
                        "发送给他",
                        onTap: () {
                          ShareUtil.shareWidget(_shareWidgetKey);
                        },
                      ))],)),
                  //已过期证件-未申请延期
//                  Visibility(
//                      visible: StringsHelper.isEmpty(info?.delayState ?? '') &&
//                          isOverTime(info?.delayDate ?? '') == overTime,
//                      child: StadiumSolidWithTowButton(
//                        cancelText: "",
//                        onCancel: () {
//
//                        },
//                        conFirmText: "",
//                        onConFirm: () {},
//                      )),
                ],
              ));
        }));
  }

  Widget _buildBody() {
    return ScopedModelDescendant<DecorationPermitModel>(
        builder: (context, child, model) {
      return CommonLoadContainer(
        state: widget._model.decorationPermitInfoState,
        callback: () {
          widget._model.getDecorationPermitInfo(widget.infoId);
        },
        content:RepaintBoundary(child: _buildContent(), key: _shareWidgetKey,),
      );
    });
  }

  Widget _buildContent() {
    return ScopedModelDescendant<DecorationPermitModel>(
        builder: (context, child, model) {
      DecorationPermitInfo info = model.decorationPermitInfo;
      if (info?.delayDate == null) {
        if (info?.fromDate != null && info?.applyVo?.workDayLong != null) {
          DateTime from = DateTime.parse(info?.fromDate);
          DateTime dalay =
              from.add(new Duration(days: info?.applyVo?.workDayLong));
          info?.delayDate = "${dalay.year}-${dalay.month}-${dalay.day}";
        }
      }
      return SingleChildScrollView(
        child: Column(children: <Widget>[
          Container(
              color: UIData.primaryColor,
              padding: EdgeInsets.only(bottom: UIData.spaceSize12),
              child: Column(children: <Widget>[
                labelTextWidget(
                  label: '编号',
                  text: info.newNumber ?? "",
                  topSpacing: UIData.spaceSize12,
                ),
                labelTextWidget(
                  label: writerName,
                  text: info.writerName ?? "",
                  topSpacing: UIData.spaceSize12,
                ),
                labelTextWidget(
                  label: writeDate,
                  text: info.writeDate ?? "",
                  topSpacing: UIData.spaceSize12,
                ),
                labelTextWidget(
                  label: houseName,
                  text: info?.applyVo?.houseName ?? "",
                  topSpacing: UIData.spaceSize12,
                ),
                labelTextWidget(
                  label: programDesc,
                  text: info?.applyVo?.programDesc ?? "",
                  topSpacing: UIData.spaceSize12,
                ),
                labelTextWidget(
                  label: workCompany,
                  text: info?.applyVo?.workCompany ?? "",
                  topSpacing: UIData.spaceSize12,
                ),
                labelTextWidget(
                  label: lawfulDate,
                  text: '${info?.fromDate ?? ""} ~ ${info?.delayDate ?? ""}',
                  topSpacing: UIData.spaceSize12,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          labelTextWidget(
                            label: manager,
                            text: info?.applyVo?.manager ?? "",
                            topSpacing: UIData.spaceSize12,
                          ),
                          labelTextWidget(
                            label: managerPhone,
                            text: info?.applyVo?.managerPhone ?? "",
                            topSpacing: UIData.spaceSize12,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Image.asset(UIData.imagePhone),
                      onPressed: () {
                        if (StringsHelper.isNotEmpty(
                            info?.applyVo?.managerPhone ?? '')) {
                          stateModel
                              .callPhone(info?.applyVo?.managerPhone ?? '');
                        }
                      },
                    ),
                  ],
                ),
                labelTextWidget(
                  label: permitState,
                  text: isOverTime(info?.delayDate ?? ''),
                  topSpacing: UIData.spaceSize12,
                ),
              ])),

          //延期信息
          Visibility(
            visible: StringsHelper.isNotEmpty(info?.delayState),
            child: Container(
                color: UIData.primaryColor,
                margin: EdgeInsets.only(top: UIData.spaceSize12),
                padding: EdgeInsets.symmetric(vertical: UIData.spaceSize12),
                child: Column(
                  children: <Widget>[
                    leftTextWidget(
                      text: '申请信息',
                      color: UIData.greyColor,
                      fontSize: UIData.fontSize17,
                    ),
                    labelTextWidget(
                      label: delayState,
                      text: getDelayState(info?.delayState ?? ''),
                      topSpacing: UIData.spaceSize12,
                    ),
                    labelTextWidget(
                      label: delayTime,
                      text: info?.delayDate ?? '',
                      topSpacing: UIData.spaceSize12,
                    ),
                    labelTextWidget(
                      label: reason,
                      text: info?.reason ?? '',
                      topSpacing: UIData.spaceSize12,
                    ),
                    Visibility(
                      visible: StringsHelper.isNotEmpty(info?.remark ?? ''),
                      child: labelTextWidget(
                        label: remark,
                        text: info?.remark ?? '',
                        topSpacing: UIData.spaceSize12,
                      ),
                    ),
                  ],
                )),
          ),
          Container(
            color: UIData.primaryColor,
            child: Column(
              children: <Widget>[
               Row(children: <Widget>[Expanded(child: SizedBox(height: UIData.spaceSize16),)],),
                QrImage(
                  size: ScreenUtil.screenWidthDp / 3,
                  padding: EdgeInsets.zero,
                  version: 2,
                  //二维码版本，越高可显示字符越多
                  data: StringsHelper.enum2String(QRCodeType.DecorationPermit) +
                      '_' +
                      info.id.toString(),
                  onError: (ex) {
//                setState(() {
                    LogUtils.printLog('二维码生成失败：$ex');
//                });
                  },
                ),
                SizedBox(height: UIData.spaceSize30),
              ],
            ),
          ),
//              Container(
//                color: UIData.primaryColor,
//                margin: EdgeInsets.only(top: UIData.spaceSize12),
//                child: DecorationPermitNodeListView(info.recordList),
//              ),
        ]),
      );
    });
  }

//

  String isOverTime(String lastDate) {
    if (StringsHelper.isNotEmpty(lastDate)) {
      DateTime last = DateUtils.getDateTimeFromString(lastDate);
      DateTime now = DateTime.now();
      if (now.isBefore(last)) {
        return normalTime;
      } else {
        return overTime;
      }
    } else {
      return '';
    }
  }

  getBottomSheet(BuildContext context, String str) {
    TextEditingController controller = new TextEditingController();

    Navigator.push(
        context,
        PopRoute(
            child: BottomInputView(
          str,
          () {
            if (StringsHelper.isNotEmpty(controller.text)) {
//        CommonToast.show();
//        _model.createCustomerOperation({
//
//        }, callback: () {
//          CommonToast.show(type: ToastIconType.SUCCESS, msg: '成功发表');
//          controller.text = '';
//          Navigator.of(context).pop();
//
//        });
            } else {
              CommonToast.show(type: ToastIconType.FAILED, msg: '请先输入内容');
            }
          },
          controller,
          hint: '请输入延长事由',
          outputView: Container(
            padding: EdgeInsets.symmetric(
                horizontal: UIData.spaceSize16,
                vertical: UIData.spaceSize12),
            color: Colors.white,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push<CommonMap>(
                    MaterialPageRoute(builder: (context) {
                      return AddWorker('预计工期', '1',
                              (List<CommonMap> commonMaps) {
                            stateModel.queryProjectSettingDetail(
                                callBack: (List<SettingVoList> settingVoLists) {
                                  settingVoLists.forEach((SettingVoList info) {
                                    commonMaps.add(CommonMap(info.code, info.name));
                                  });
                                });
                          });
                    })).then((CommonMap commonMap) {
                      LogUtils.printLog('111');
                  if (commonMap != null)
                    _handleGlobalKey.currentState.setState(() {
                      LogUtils.printLog('222');
                      delayLong =
                          int.parse(commonMap.complaintPropertyId);
                    });
                });
              },
              child: Row(
                children: <Widget>[
                  CommonText.darkGrey15Text('延长工期'),
                  SizedBox(
                    width: UIData.spaceSize30,
                  ),
                  Expanded(
                      child: (StringsHelper.isEmpty(delayLong
                          ?.toString() ??
                          ''))
                          ? CommonText.lightGrey15Text('请选择（必填）')
                          : CommonText.darkGrey15Text((delayLong
                          ?.toString() ??
                          '') +
                          '天')),
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: UIData.iconGreyColor,
                  ),
                ],
              ),
            ),
          ),key: _handleGlobalKey,
        )));
  }
}
