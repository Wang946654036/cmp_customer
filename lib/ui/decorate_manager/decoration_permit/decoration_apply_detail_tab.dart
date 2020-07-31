///验收详情切换
///
///

import 'package:cmp_customer/scoped_models/decoration_model.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/decorate_manager/decoration_permit/decoration_check_apply.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../decoration_ui.dart';
import 'decoration_apply_detail.dart';
import 'decoration_check_detail.dart';
import 'decoration_history_list.dart';
import 'decoration_history_list_zk.dart';

//办理详情tab页
class DecorationDetailTabPage extends StatefulWidget {
  DecorationModel _model;
  int infoId;

  DecorationDetailTabPage(this._model, this.infoId);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DecorationApplyListTab();
  }
}

class DecorationApplyListTab extends State<DecorationDetailTabPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget._model.getDecorationInfo(widget.infoId);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (widget._model == null) widget._model = new DecorationModel();
    return DefaultTabController(
        length: 2,
        child: ScopedModel<DecorationModel>(
          model: widget._model,
          child: ScopedModelDescendant<DecorationModel>(
              builder: (context, child, model) {
            return new CommonScaffold(
              appTitle: "办理详情",
              bottomNavigationBar: (widget._model.decorationInfo
                              ?.decorateAcceptanceVo?.state ??
                          '') ==
                      acceptanceCheckFailed
                  ? Row(
                      children: <Widget>[
                        Expanded(
                            child: StadiumSolidWithTowButton(
                          cancelText: label_cansol,
                          onCancel: () {
                            widget._model.decorationIsPass({
                              'id': widget._model.decorationInfo.id,
                              'status': '2',
                              'checkRole':
                                  widget._model.decorationInfo?.decorateAcceptanceVo
                                    ?.bpmCurrentRole,
                              'acceptanceId':
                                  widget._model.decorationInfo.acceptanceId,
                              'acceptanceCheckRole': widget
                                  ._model.decorationInfo.acceptanceCheckRole
                            }, decorationType: DecorationHttpType.CHANGE);
                          },
                          conFirmText: label_edit,
                          onConFirm: () {
                            Navigate.toNewPage(
                                DecorationCheckApply(
                                  model: widget._model,
                                  decorationInfo: widget._model.decorationInfo,
                                ), callBack: (flag) {
                              if (flag != null && flag is bool && flag)
                                Navigate.closePage(true);
                            });
                          },
                        )),
                      ],
                    )
                  : ((widget._model.decorationInfo?.decorateAcceptanceVo
                                  ?.state ??
                              '') ==
                          acceptance_check
                      ? Row(
                          children: <Widget>[
                            Expanded(
                              child: StadiumSolidButton(
                                label_cansol,
                                btnType: ButtonType.CONFIRM,
                                onTap: () {
                                  widget._model.decorationIsPass({
                                    'id': widget._model.decorationInfo.id,
                                    'status': '2',
                                    'checkRole': widget
                                        ._model.decorationInfo?.decorateAcceptanceVo
                                      ?.bpmCurrentRole,
                                    'acceptanceId': widget
                                        ._model.decorationInfo.acceptanceId,
                                    'acceptanceCheckRole': widget._model
                                        .decorationInfo.acceptanceCheckRole
                                  }, decorationType: DecorationHttpType.CHANGE);
                                },
                              ),
                            )
                          ],
                        )
                      : null),
              tabBar: TabBar(tabs: <Widget>[
                new Tab(
                  text: "验收详情",
                ),
                new Tab(
                  text: "申请详情",
                )
              ], indicatorSize: TabBarIndicatorSize.label),
              bodyData: new TabBarView(
                children: <Widget>[
                  new DecorationCheckDetail(widget._model, widget.infoId),
                  new DecorationApplyDetail(widget._model, widget.infoId),
                ],
              ),
            );
          }),
        ));
  }
}
