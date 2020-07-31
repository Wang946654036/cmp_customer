import 'package:cmp_customer/scoped_models/entrance_model/entrance_list_state_model.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_apply.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_history.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_list.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_state.dart';
import 'package:cmp_customer/utils/common_event_bus.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:cmp_customer/ui/parking/parking_card_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scoped_model/scoped_model.dart';

//门禁卡申请列表（业主）
class EntranceCardListLandlordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EntranceCardListLandlord();
  }
}

class EntranceCardListLandlord extends State<EntranceCardListLandlordPage> {
  EntranceListStateModel _stateModel;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (_stateModel == null) _stateModel = new EntranceListStateModel();
    return DefaultTabController(
        length: 2,
        child: ScopedModel<EntranceListStateModel>(
          model: _stateModel,
          child: new CommonScaffold(
            appTitle: "门禁卡申请列表",
            tabBar: TabBar(tabs: <Widget>[
              new Tab(
                text: "租户申请",
              ),
              new Tab(
                text: "我的申请",
              )
            ], indicatorSize: TabBarIndicatorSize.label),
            bodyData: new TabBarView(
              children: <Widget>[
                new EntranceCardListPage(),
                new EntranceCardHistoryPage(),
              ],
            ),
//            appBarActions: <Widget>[
//              Builder(builder: (context) {
//                return GestureDetector(
//                    onTap: () {
//                      _stateModel.applyNewCard(EntranceApplyType.landlord);
//                    },
//                    child: Container(
//                        alignment: Alignment.centerRight,
//                        padding: EdgeInsets.only(right: right_spacing),
//                        child: CommonText.text15("我要申请",
//                            color: color_text_red,
//                            textAlign: TextAlign.center)));
//              })
//            ],
          ),
        ));
  }
}
