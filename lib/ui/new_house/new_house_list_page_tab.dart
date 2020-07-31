
import 'package:cmp_customer/models/new_house_model.dart';
///业务办理列表切换
///
/// 
import 'package:cmp_customer/models/property_change_user_param.dart';
import 'package:cmp_customer/scoped_models/new_house_state_model.dart';

import 'package:cmp_customer/ui/common/common_scaffold.dart';

import 'package:flutter/material.dart';

import 'new_house_list_Page.dart';



//新房入伙列表tab页
class NewHouseInfoListTabPage extends StatefulWidget {

  NewHouseStateModel _model;
  NewHouseInfoListTabPage(this._model);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NewHouseInfoListTab();
  }
}

class NewHouseInfoListTab extends State<NewHouseInfoListTabPage>  with SingleTickerProviderStateMixin  {

  String queryType = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  Widget build(BuildContext context) {
    // TODO: implement build

    return CommonScaffold(
      appTitle: "新房入伙申请记录",
      bodyData: _buildContent(widget._model,new List<NewHouseDetail>()),

    );
  }



  Widget _buildContent(NewHouseStateModel modle,List<NewHouseDetail> list) {
//    queryType = getQueryTypeCode(type);
    return NewHouseListPage(modle, callback:(PropertyChangeUserParam param) {

    });
  }
}
