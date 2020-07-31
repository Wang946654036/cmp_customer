import 'package:cmp_customer/models/decoration_obj_list.dart';
import 'package:cmp_customer/models/meetingroom/reserve_info.dart';
///业务办理列表切换
///
/// 
import 'package:cmp_customer/models/property_change_user_param.dart';
import 'package:cmp_customer/scoped_models/reservation_state_model.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/conference_room_reservation/reservation_list.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:flutter/material.dart';

import 'can_book_room_list.dart';


//会议室预定列表tab页
class ReservationListTabPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ReservationListTab();
  }
}

class ReservationListTab extends State<ReservationListTabPage>  with SingleTickerProviderStateMixin  {

  String queryType = '';
  List<ReserveInfo> reserveInfoList =  new List<ReserveInfo>();
  ReservationModel _model = new ReservationModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  Widget build(BuildContext context) {
    // TODO: implement build

    return CommonScaffold(
        appTitle: "预定列表",
//        tabBar: TabBar(tabs: <Widget>[
//          new Tab(
//            text: "经办",
//          ),
//          new Tab(
//            text: "全部",
//          )
//        ], indicatorSize: TabBarIndicatorSize.label,controller: _tabController,),
//        appBarActions: <Widget>[
//          Builder(builder: (context) {
//            return IconButton(
//              icon: UIData.iconFilter,
//              onPressed: () {
//                Scaffold.of(context).openEndDrawer();
//              },
//            );
//          })
//        ],

        bodyData: _buildContent(_model,reserveInfoList),
          bottomNavigationBar:StadiumSolidButton('我要预约', onTap: () {
            Navigate.toNewPage(CanBookRoomList(_model),callBack: (flag){
              if(flag!=null&&flag is bool&&flag){
                _model.loadHistoryList(PropertyChangeUserParam(),reserveInfoList);
              }
            });
          }),
      );
  }



  Widget _buildContent(ReservationModel modle,List<ReserveInfo> list) {
//    queryType = getQueryTypeCode(type);
    return ReservationListPage(modle, list,(PropertyChangeUserParam param) {

    });
  }
}
