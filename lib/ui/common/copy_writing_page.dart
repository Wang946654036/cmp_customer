import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/response/agreement_response.dart';
import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/strings/strings_common.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';


import 'package:flutter/material.dart';

///
/// 文案配置显示页面
///
class CopyWritingPage extends StatefulWidget {
  final String title;
  final CopyWritingType type;
int projectId;
  CopyWritingPage(this.title, this.type,{this.projectId});

  @override
  _CopyWritingPageState createState() => _CopyWritingPageState();
}

class _CopyWritingPageState extends State<CopyWritingPage> {
  CopyWritingPageModel _pageModel = CopyWritingPageModel();

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _refreshData(){
    stateModel.getCopyWriting(widget.projectId??stateModel.defaultProjectId, widget.type, _pageModel);
  }

  Widget _buildBody() {
    return ScopedModelDescendant<MainStateModel>(builder: (context, child, model){
      return CommonLoadContainer(
        state: _pageModel.pageState,
        content: Container(
          color: UIData.primaryColor,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(UIData.spaceSize16),
            children: <Widget>[CommonText.grey14Text(_pageModel.agreementInfo?.agreementContent ?? '',
            height: 1.3, overflow: TextOverflow.fade)],
          ),
        ),
        callback: _refreshData,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appTitle: _pageModel.agreementInfo?.agreementTitle ?? widget.title,
      bodyData: _buildBody(),
    );
  }
}

class CopyWritingPageModel {
  AgreementInfo agreementInfo = AgreementInfo();
  ListState pageState = ListState.HINT_LOADING;
}