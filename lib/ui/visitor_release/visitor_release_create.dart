import 'dart:convert';

import 'package:cmp_customer/models/new_house_model.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/models/visitor_release_detail_model.dart';
import 'package:cmp_customer/scoped_models/new_house_state_model.dart';
import 'package:cmp_customer/scoped_models/visitor_release_state_model.dart';
import 'package:cmp_customer/ui/common/car_number_input_keyboard.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_dialog.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/visitor_release/visit_content_view.dart';
import 'package:cmp_customer/ui/visitor_release/visitor_release_list_tab.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';



///
/// Created by yangyangyang on 2020/4/10
/// 新建、
///
class VisitorReleaseCreate extends StatefulWidget {
  final VisitorReleaseDetail visitorReleaseDetail;

  VisitorReleaseCreate({this.visitorReleaseDetail});

  @override
  _VisitorReleaseCreateState createState() => _VisitorReleaseCreateState();
}

class _VisitorReleaseCreateState extends State<VisitorReleaseCreate> {
//  int step = 0;
  VisitorReleaseStateModel _model = new VisitorReleaseStateModel();
  VisitorReleaseDetail _visitorReleaseDetail;
  ScrollController _loadMoreScrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() {
    if (widget.visitorReleaseDetail != null)
      _visitorReleaseDetail = VisitorReleaseDetail.fromJson(jsonDecode(jsonEncode(widget.visitorReleaseDetail.toJson())));
    else {
      _visitorReleaseDetail = VisitorReleaseDetail(); //新增
    }
  }

  bool checkData(VisitorReleaseDetail info) {
    String tips = '';

        if (StringsHelper.isEmpty(_visitorReleaseDetail.projectId?.toString() ?? '')) {
          tips = '请选择社区';
        } else if (StringsHelper.isEmpty(_visitorReleaseDetail.houseId?.toString() ?? '')) {
          tips = '请选择房屋';
        } else  if (StringsHelper.isEmpty(_visitorReleaseDetail.visitorName)) {
          tips = '请填写访客姓名';
        } else if (StringsHelper.isEmpty(_visitorReleaseDetail.visitorPhone)) {
          tips = '请填写访客电话';
        } else if (StringsHelper.isEmpty(_visitorReleaseDetail.paperType)) {
          tips = '请填写访客证件类型';
        } else if (StringsHelper.isEmpty(_visitorReleaseDetail.paperNumber)) {
          tips = '请填写访客证件号';
        } else if (StringsHelper.isEmpty(_visitorReleaseDetail.visitReason)) {
          tips = '请选择到访事由';
        } else if (StringsHelper.isEmpty(_visitorReleaseDetail.visitDate)) {
          tips = '请选择到访日期';
        } else if(_visitorReleaseDetail.visitNum==null||_visitorReleaseDetail.visitNum<=0){
          _visitorReleaseDetail.visitNum = 1;
        }

    if (StringsHelper.isNotEmpty(tips)) {
      CommonToast.show(type: ToastIconType.INFO, msg: tips);
      return false;
    } else {
      return true;
    }
  }

  Widget _buildCarNoKeyboard() {
    return ScopedModelDescendant<VisitorReleaseStateModel>(builder: (context, child, model) {

      return Theme(
          data: Theme.of(context).copyWith(),
          child: Material(
            color: Colors.transparent,
            child: Offstage(
              offstage: !_model.showCarNoInputView,
              child: CarNoInputKeyboard(
                key: _model.carNoInputKey,
                carNo: _model.plateNumber ?? '',
                onCancel: () {
                  setState(() {
                    _model.showCarNoInputView = false;
                  });
                },
                onConfirm: (String carNo) {
                  if (!StringsHelper.isCarNo(carNo)) {
                    CommonToast.show(msg: '请输入正确车牌号', type: ToastIconType.INFO);
                  } else {
                    _visitorReleaseDetail.carNumber=carNo;
                    _model.setCarNo(carNo);
                  }
                },
              ),
            ),
          ));
    });
  }

  Widget getBottomNavigationBar(VisitorReleaseStateModel model) {
    return StadiumSolidButton(
      '提交',
      enable: _model.visitorReleaseCommitState == ListState.HINT_DISMISS,
      onTap: () {
        if (checkData(_visitorReleaseDetail)) {

              //新建
              model.visitorReleaseIsPass(_visitorReleaseDetail.toJson(), visitorReleaseType: VisitorReleaseHttpType.SAVE);

        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModel<VisitorReleaseStateModel>(
        model: _model,
        child: ScopedModelDescendant<VisitorReleaseStateModel>(builder: (context, child, model) {
          return Stack(
            children: <Widget>[
              CommonScaffold(
                onWillPop: () {
                  CommonDialog.showAlertDialog(context,
                      content: '放弃预约？', onConfirm: () {
                        Navigate.closePage();
                      }, negativeBtnText: '我再看看');
                },
                popBack: () {
                  CommonDialog.showAlertDialog(context,
                      content: '放弃预约？', onConfirm: () {
                        Navigate.closePage();
                      }, negativeBtnText: '我再看看');
                },
                appTitle: "预约到访",
                appBarActions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigate.toNewPage(VisitorReleaseInfoListTabPage(_model));
                    },
                    child: Container(
                        alignment: Alignment.centerRight,
                        child:
                        CommonText.text15("预约列表", color: UIData.themeBgColor, textAlign: TextAlign.center)),
                  ),
                ],
                bodyData: _buildContent(),
                bottomNavigationBar: getBottomNavigationBar(model),
              ),
              _buildCarNoKeyboard()
            ],
          );
        }));
  }

  Widget _buildContent() {
    return ScopedModelDescendant<VisitorReleaseStateModel>(builder: (context, child, model) {
      return SingleChildScrollView(
        controller: _loadMoreScrollController,
        child: Column(children: <Widget>[
          VisitorReleaseContentView(true,_visitorReleaseDetail,model),

        ]),
      );
    });
  }
}
