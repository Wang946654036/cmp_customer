import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/common/common_page_model.dart';
import 'package:cmp_customer/models/house_all_model.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/house_authentication/my_house_page.dart';
import 'package:cmp_customer/ui/house_authentication/tourist_no_record.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

///
/// 我的房屋
///
class ChooseHousePage extends StatefulWidget {
  @override
  _MyHousePageState createState() => _MyHousePageState();
}

class _MyHousePageState extends State<ChooseHousePage> {

  List<HouseInfo> houseList = new List();
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stateModel.getHouseListInpay((List<HouseInfo> list){
      houseList.clear();
      houseList.addAll(list);
    });
  }

  Widget _buildList() {
    return ListView.builder(
        padding: EdgeInsets.only(top: UIData.spaceSize16),
        itemCount: houseList.length ?? 0,
        itemBuilder: (context, index) {
          HouseInfo info = houseList[index];
          return  Container(
            color: UIData.primaryColor,
            child: ListTile(
                title: CommonText.darkGrey15Text('${info?.buildName ?? ''}${info?.buildName ?? ''}${info?.unitName ?? ''}${info?.houseNo ?? ''}'),
                trailing: Icon(Icons.keyboard_arrow_right, color: UIData.lighterGreyColor),
                onTap: () {
                  Navigate.closePage(info);
                }),
          );
        });
  }



  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appTitle: '选择房屋',
      bodyData: ScopedModelDescendant<MainStateModel>(
          builder: (context, child, model) {
        return CommonLoadContainer(
          state: stateModel.workOtherChooseHouseState,
          content: _buildList() ?? Container(),
          callback: () {
            stateModel.getHouseListInpay((List<HouseInfo> list){
              houseList.clear();
              houseList.addAll(list);
            });
          },
        );
      }),
    );
  }
}
