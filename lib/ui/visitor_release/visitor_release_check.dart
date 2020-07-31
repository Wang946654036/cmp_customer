import 'package:cmp_customer/scoped_models/visitor_release_state_model.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_dialog.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/visitor_release/visit_content_view.dart';
import 'package:cmp_customer/ui/visitor_release/visitor_release_common_ui.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class VisitorReleaseCheckPage extends StatefulWidget {
  final VisitorReleaseStateModel stateModel;
  final int releasePassId;

  VisitorReleaseCheckPage(this.stateModel, this.releasePassId);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _VisitorReleaseCheckPageState();
  }
}

class _VisitorReleaseCheckPageState extends State<VisitorReleaseCheckPage> {
  void _refreshData() {
    widget.stateModel.getVisitorReleaseDetail(widget.releasePassId);
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  void finishThisPage() {
    Navigate.closePage(true);
  }

  Widget _buildContent() {
    return Container(
      child: ListView(
        children: <Widget>[
          Visibility(visible: widget.stateModel.visitorReleaseDetail?.isPassedFromCust!=null,child: _buildTop(),),
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
  Widget _buildTop() {
    return

      ///状态操作栏
      Container(
          color: Colors.white,
          padding: EdgeInsets.only(bottom: UIData.spaceSize12),
          margin: EdgeInsets.only(bottom: UIData.spaceSize12),
          child: Column(
            children: <Widget>[
              ///状态栏
              CommonText.darkGrey16Text(
                  '${getPassStateName(widget.stateModel.visitorReleaseDetail?.isPassedFromCust)}'),
            ],
          ));
  }
  @override
  Widget build(BuildContext context) {
    return ScopedModel<VisitorReleaseStateModel>(
      model: widget.stateModel,
      child: ScopedModelDescendant<VisitorReleaseStateModel>(
        builder: (context, child, model) {
          return CommonScaffold(
            appTitle: '临时到访受理',
            bodyData: _buildBody(),
            bottomNavigationBar: widget.stateModel.visitorReleaseInfoState ==
                        ListState.HINT_DISMISS &&
                    (widget.stateModel.visitorReleaseDetail?.isPassedFromCust != null &&
                        widget.stateModel.visitorReleaseDetail.isPassedFromCust == 2)
                ? StadiumSolidWithTowButton(
                    conFirmText: '授权放行',
                    cancelText: '授权不放行',
                    conFirmEnable:
                        widget.stateModel.visitorReleaseCommitState ==
                            ListState.HINT_DISMISS,
                    cancelEnable: widget.stateModel.visitorReleaseCommitState ==
                        ListState.HINT_DISMISS,
                    onConFirm: () {
                      CommonDialog.showAlertDialog(context,
                          content: '请您确认是否授权放行访客？', onConfirm: () {
                        widget.stateModel.visitorReleaseIsPass({
                          'appointmentVisitId': widget.releasePassId,
                          'isPassedFromCust': 1
                        }, visitorReleaseType: VisitorReleaseHttpType.ACCEPT);
                      }, negativeBtnText: '我再看看');
                    },
                    onCancel: () {
                      CommonDialog.showAlertDialog(context,
                          content: '请您确认是否授权不放行访客？', onConfirm: () {
                        widget.stateModel.visitorReleaseIsPass({
                          'appointmentVisitId': widget.releasePassId,
                          'isPassedFromCust': 0
                        }, visitorReleaseType: VisitorReleaseHttpType.ACCEPT);
                      }, negativeBtnText: '我再看看');
                    })
                : null,
          );
        },
      ),
    );
  }
}
