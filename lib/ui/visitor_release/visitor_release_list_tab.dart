
///业务办理列表切换
///
/// 
import 'package:cmp_customer/models/property_change_user_param.dart';
import 'package:cmp_customer/models/visitor_release_detail_model.dart';
import 'package:cmp_customer/scoped_models/visitor_release_state_model.dart';

import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/visitor_release/visitor_release_list.dart';

import 'package:flutter/material.dart';




//预约到访列表tab页
class VisitorReleaseInfoListTabPage extends StatefulWidget {

  VisitorReleaseStateModel _model;
  VisitorReleaseInfoListTabPage(this._model);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return VisitorReleaseInfoListTab();
  }
}

class VisitorReleaseInfoListTab extends State<VisitorReleaseInfoListTabPage>  with SingleTickerProviderStateMixin  {

  String queryType = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  Widget build(BuildContext context) {
    // TODO: implement build

    return CommonScaffold(
      appTitle: "预约到访申请记录",
      bodyData: _buildContent(widget._model,new List<VisitorReleaseDetail>()),

    );
  }



  Widget _buildContent(VisitorReleaseStateModel modle,List<VisitorReleaseDetail> list) {
//    queryType = getQueryTypeCode(type);
    return VisitorReleaseListPage(modle, callback:(PropertyChangeUserParam param) {

    });
  }
}
