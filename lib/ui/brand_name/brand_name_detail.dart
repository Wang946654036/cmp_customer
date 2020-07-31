import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/models/brand_name_obj.dart';
import 'package:cmp_customer/models/property_change_user_param.dart';
import 'package:cmp_customer/scoped_models/brand_name_model.dart';
import 'package:cmp_customer/scoped_models/pay_state_model.dart';
import 'package:cmp_customer/ui/brand_name/brand_name_create.dart';
import 'package:cmp_customer/ui/brand_name/brand_name_nodelist.dart';
import 'package:cmp_customer/ui/brand_name/brand_name_ui.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_dialog.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_image_display.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/html/html_page.dart';
import 'package:cmp_customer/ui/parking/parking_card_ui.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';

class BrandNameDetail extends StatefulWidget {
  int infoId;
  BrandNameModel _model;

  BrandNameDetail(this._model, this.infoId);

  @override
  _BrandNameDetailState createState() => _BrandNameDetailState();
}

class _BrandNameDetailState extends State<BrandNameDetail> {
  int spPosition;
  int mpPosition;
  bool isNeedRefreshList = false;
//  double payFees = 500.00;

  _BrandNameDetailState();

  TextEditingController remarkController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget._model.getBrandNameInfo(widget.infoId);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModel<BrandNameModel>(
        model: widget._model,
        child: ScopedModelDescendant<BrandNameModel>(
            builder: (context, child, model) {
          BrandNameInfo info = model.brandNameInfo;
          if (model.brandNameInfo?.spSettingList != null &&
              spPosition == null) {
            for (int i = 0; i < model.brandNameInfo.spSettingList.length; i++) {
              if (((model.brandNameInfo.spSettingList[i].isCustChoose) ??
                      '0') ==
                  '1') {
                spPosition = i;
                break;
              }
            }
            if (spPosition != null) {
              SettingList settingList =
                  model.brandNameInfo.spSettingList.removeAt(spPosition);
              model.brandNameInfo.spSettingList.clear();
              model.brandNameInfo.spSettingList.add(settingList);
              spPosition = 0;
            }
          }
          if (model.brandNameInfo?.mpSettingList != null &&
              mpPosition == null) {
            for (int i = 0; i < model.brandNameInfo.mpSettingList.length; i++) {
              if (((model.brandNameInfo.mpSettingList[i].isCustChoose) ??
                      '0') ==
                  '1') {
                mpPosition = i;
                break;
              }
            }
            if (mpPosition != null) {
              SettingList settingList =
                  model.brandNameInfo.mpSettingList.removeAt(mpPosition);
              model.brandNameInfo.mpSettingList.clear();
              model.brandNameInfo.mpSettingList.add(settingList);
              mpPosition = 0;
            }
          }

          return CommonScaffold(
            appTitle: "水牌名牌办理详情",
            bodyData: _buildBody(),
            popBack: (){
              Navigate.closePage(isNeedRefreshList);
            },
            onWillPop: (){
              Navigate.closePage(isNeedRefreshList);
            },
            appBarActions: [
              Visibility(
                visible: (info?.status ?? '') == auditSuc ||
                    (info?.status ?? '') == payWaiting,
                child: FlatButton(
                  onPressed: () {
                    widget._model.brandNameIsPass(widget.infoId, 'SPMP_QXSQ',
                        callback: () {
                      widget._model
                          .loadHistoryList(new PropertyChangeUserParam());
                    });
                  },
                  child: CommonText.red15Text('撤回'),
                ),
              )
            ],
            bottomNavigationBar: _buildBottom(info, model),
          );
        }));
  }

  Widget _buildBottom(BrandNameInfo info, BrandNameModel model) {
    if ((info?.status ?? '') == auditWaiting) {
      return StadiumSolidWithTowButton(
        cancelText: "取消办理",
        onCancel: () {
          model.brandNameIsPass(widget.infoId, 'SPMP_QXSQ', callback: () {
            widget._model.loadHistoryList(new PropertyChangeUserParam());
          });
        },
        conFirmText: "修改申请",
        onConFirm: () {
//          Navigate.closePage(true);
          info.operateStep = 'SPMP_TJSQ';
          Navigate.toNewPage(
              new BrandNameCreate(
                brandNameInfo: info,
              ), callBack: (data) {
            widget._model.getBrandNameInfo(widget.infoId);
            isNeedRefreshList = true;
          });
        },
      );
    } else if ((info?.status ?? '') == auditFailed) {
      return StadiumSolidWithTowButton(
        cancelText: "取消办理",
        onCancel: () {
          widget._model.brandNameIsPass(widget.infoId, 'SPMP_QXSQ',
              callback: () {
            widget._model.loadHistoryList(new PropertyChangeUserParam());
          });
        },
        conFirmText: "修改申请",
        onConFirm: () {
//          Navigate.closePage(true);
          info.operateStep = 'SPMP_TJSQ';
          Navigate.toNewPage(
              new BrandNameCreate(
                brandNameInfo: info,
              ), callBack: (data) {
            widget._model.getBrandNameInfo(widget.infoId);
          });
        },
      );
    } else if ((info?.status ?? '') == auditSuc) {
      return StadiumSolidButton(
        '确认',
        onTap: () {
          LogUtils.printLog('queren');
          Map<String, dynamic> params = new Map();
          List<int> settings = new List();
          switch (info?.applyType ?? '') {
            case 'SP':
              if (spPosition != null) {
                settings.add(info?.spSettingList[spPosition]?.settingId ?? -1);
              } else {
                if (info?.spSettingList != null &&
                    info.spSettingList.length > 0) {
                  settings.add(info?.spSettingList[0]?.settingId ?? -1);
                }
              }
              break;
            case 'MP':
              if (mpPosition != null) {
                settings.add(info?.mpSettingList[mpPosition]?.settingId ?? -1);
              } else {
                if (info?.mpSettingList != null &&
                    info.mpSettingList.length > 0) {
                  settings.add(info?.mpSettingList[0]?.settingId ?? -1);
                }
              }
              break;
            case 'SPMP':
              if (spPosition != null) {
                settings.add(info?.spSettingList[spPosition]?.settingId ?? -1);
              } else {
                if (info?.spSettingList != null &&
                    info.spSettingList.length > 0) {
                  settings.add(info?.spSettingList[0]?.settingId ?? -1);
                }
              }
              if (mpPosition != null) {
                settings.add(info?.mpSettingList[mpPosition]?.settingId ?? -1);
              } else {
                if (info?.mpSettingList != null &&
                    info.mpSettingList.length > 0) {
                  settings.add(info?.mpSettingList[0]?.settingId ?? -1);
                }
              }
              break;
          }
          params['settings'] = settings;
          params['brandNameId'] = widget.infoId;
          params['operateStep'] = 'SPMP_QRFA';

          model.brandNameFunctionCheck(params, callback: () {
            widget._model.loadHistoryList(new PropertyChangeUserParam());
          });
        },
      );
    } else if ((info?.status ?? '') == payWaiting) {
      return StadiumSolidWithTowButton(
        cancelText: "线下支付",
        onCancel: () {
          CommonDialog.showAlertDialog(context,showNegativeBtn: false,title: "线下支付提示",content: "选择线下支付后，请到物业管理处缴费！");
        },
        conFirmText: "线上支付",
        onConFirm: () {
          CommonToast.show();
          PayStateModel().getPayUrl(info.brandNameId,"BRANDNAME", (payUrl){
            Navigate.toNewPage(HtmlPage(payUrl,"水牌名牌支付"),callBack: (success){
              if(success!=null&&success){
                //H5支付遗留问题，无法知道用户是否真的支付完成，只能重新刷新了
                isNeedRefreshList = true;//需要刷新列表页面
                widget._model.getBrandNameInfo(widget.infoId);
              }
            });
          });
        },
      );
    } else {
      return null;
    }
  }

  Widget _buildBody() {
    return ScopedModelDescendant<BrandNameModel>(
        builder: (context, child, model) {
      return CommonLoadContainer(
        state: widget._model.brandNameInfoState,
        callback: () {
          widget._model.getBrandNameInfo(widget.infoId);
        },
        content: _buildContent(),
      );
    });
  }

  Widget _buildContent() {
    return ScopedModelDescendant<BrandNameModel>(
        builder: (context, child, model) {
      BrandNameInfo info = model.brandNameInfo;
      return SingleChildScrollView(
        child: Column(children: <Widget>[
          Container(
              color: UIData.primaryColor,
              padding: EdgeInsets.only(bottom: UIData.spaceSize12),
              child: Column(children: <Widget>[
                labelTextWidget(
                  label: businessNo,
                  text: info.businessNo ?? "",
                  topSpacing: UIData.spaceSize12,
                ),
                labelTextWidget(
                  label: createTime,
                  text: info.createTime ?? "",
                  topSpacing: UIData.spaceSize12,
                ),
                labelTextWidget(
                  label: applyType,
                  text: info.applyTypeName,
                  topSpacing: UIData.spaceSize12,
                ),
                labelTextWidget(
                  label: deal_progress,
                  text: getStateStr(info.status),
                  topSpacing: UIData.spaceSize12,
                ),

                Visibility(
                  visible: info.shouldPayMoney != null,
                  child: Container(
                    margin: EdgeInsets.only(top: UIData.spaceSize12),
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        labelTextWidget(
                          label: payFeesStr,
                          unit: "元",
                          color: UIData.orangeColor,
                          text: StringsHelper.getDoubleToStringValue(
                              info.shouldPayMoney),
                        )
                      ],
                    ),
                  ),
                ),
//                            leftTextWidget(
//                              text: label_photo_head, topSpacing: UIData.spaceSize12,),
//                            Container(
//                              margin: EdgeInsets.all(UIData.spaceSize16),
//                              child: CommonImageDisplay(null),
//                            ),
//                            leftTextWidget(text: label_photo_identity,
//                              topSpacing: UIData.spaceSize12,),
//                            Container(
//                              margin: EdgeInsets.all(UIData.spaceSize16),
//                              child: CommonImageDisplay(null),
//                            ),
              ])),
          Container(
            color: UIData.primaryColor,
            margin: EdgeInsets.only(top: UIData.spaceSize12),
            padding: EdgeInsets.symmetric(vertical: UIData.spaceSize12),
            child: labelTextWidget(
              label: useTime,
              text: info.useTime,
            ),
          ),

          //水牌信息
          Visibility(
            visible: info.applyType != 'MP',
            child: Container(
              color: UIData.primaryColor,
              margin: EdgeInsets.only(top: UIData.spaceSize12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  labelTextWidget(
                    label: spApplyCount,
                    text: (info.spApplyCount?.toString() ?? "") + '个',
                    topSpacing: UIData.spaceSize12,
                  ),
                  labelTextWidget(
                    label: spContent,
                    text: info.spContent ?? "",
                    topSpacing: UIData.spaceSize12,
                    bottomSpacing: UIData.spaceSize12,
                  ),
                  CommonDivider(),
                  Visibility(
                    visible: info?.spSettingList != null &&
                        info?.spSettingList.length > 0,
                    child: BrandNameTypeCard(
                      info?.spSettingList ?? [],
                      position: spPosition,
                      callback: (int position) {
                        setState(() {
                          spPosition = position;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          //名牌信息
          Visibility(
            visible: info.applyType != 'SP',
            child: Container(
              color: UIData.primaryColor,
              margin: EdgeInsets.only(top: UIData.spaceSize12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  labelTextWidget(
                    label: mpApplyCount,
                    text: (info.mpApplyCount?.toString() ?? "") + '个',
                    topSpacing: UIData.spaceSize12,
                  ),
                  labelTextWidget(
                    label: mpContent,
                    text: info.mpContent ?? "",
                    topSpacing: UIData.spaceSize12,
                    bottomSpacing: UIData.spaceSize12,
                  ),
                  CommonDivider(),
                  Visibility(
                    visible: info?.mpSettingList != null &&
                        info?.mpSettingList.length > 0,
                    child: BrandNameTypeCard(
                      info?.mpSettingList ?? [],
                      position: mpPosition,
                      callback: (int position) {
                        setState(() {
                          mpPosition = position;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

//              Container( color: UIData.primaryColor,
//                margin: EdgeInsets.only(top: UIData.spaceSize1),
//                padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize16,vertical: UIData.spaceSize12),
//                child: CommonText.lightGrey14Text(getTips(info)),),

          Container(
              color: UIData.primaryColor,
              margin: EdgeInsets.only(top: UIData.spaceSize12),
              padding: EdgeInsets.symmetric(vertical: UIData.spaceSize12),
              child: Column(
                children: <Widget>[
                  leftTextWidget(
                    text: '制作附件',
                  ),
                  Container(
                    margin: EdgeInsets.all(UIData.spaceSize16),
                    child: CommonImageDisplay(photoIdList: getFileList(info)),
                  ),
                  Visibility(
                    visible: StringsHelper.isNotEmpty(info.remark ?? ""),
                    child: labelTextWidget(
                      label: '备注',
                      text: info.remark ?? "",
                      topSpacing: UIData.spaceSize12,
                      bottomSpacing: UIData.spaceSize12,
                    ),
                  ),
                ],
              )),

//              Visibility(
//                visible:
////                widget.type == PageQueryType.TODO &&
//                    info.status==auditWaiting,
//                child: Container(
//                  margin: EdgeInsets.only(top: UIData.spaceSize12),
//                  padding: EdgeInsets.only(bottom: bottom_spacing),
//                  color: UIData.primaryColor,
//                  child: Column(
//                    children: <Widget>[
//                      leftTextWidget(
//                        text: label_apply_audit_opinion,
//                        color: UIData.greyColor,
//                        topSpacing: UIData.spaceSize12,
//                      ),
//                      inputWidget(controller: remarkController,
//                          hint_text: "若审核不通过，请务必写明缘由"),
//                    ],
//                  ),
//                ),
//              ),

          Container(
            color: UIData.primaryColor,
            margin: EdgeInsets.only(top: UIData.spaceSize12),
            child: BrandNameNodeListView(info.recordList),
          ),
        ]),
      );
    });
  }

  List<String> getFileList(BrandNameInfo BrandNameInfo) {
    List<String> strs = new List();
    if (BrandNameInfo.attList != null) {
      BrandNameInfo.attList.forEach((info) {
        strs.add(info.attachmentUuid);
      });
      if (BrandNameInfo.attList == null || BrandNameInfo.attList.length == 0) {
        BrandNameInfo.attList = new List();
        BrandNameInfo.attList.addAll(BrandNameInfo.attList);
      }
    }

    return strs;
  }
}
