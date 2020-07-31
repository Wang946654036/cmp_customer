import 'package:cmp_customer/scoped_models/entrance_model/entrance_list_state_model.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_history.dart';
import 'package:flutter/material.dart';

//门禁卡申请列表（租户）
class EntranceCardListTenantPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EntranceCardListTenant();
  }
}

class EntranceCardListTenant extends State<EntranceCardListTenantPage> {
  EntranceListStateModel _stateModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (_stateModel == null) {
      _stateModel = new EntranceListStateModel();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CommonScaffold(
        appTitle: "门禁卡申请列表",
        bodyData: EntranceCardHistoryPage(),
//        appBarActions: <Widget>[
//          Builder(builder: (context) {
//            return GestureDetector(
//                onTap: () {
//                  _stateModel.applyNewCard(EntranceApplyType.tenant);
//                },
//                child: Container(
//                    alignment: Alignment.centerRight,
//                    padding: EdgeInsets.only(right: right_spacing),
//                    child: CommonText.text15("我要申请",
//                        color: color_text_red, textAlign: TextAlign.center)));
//          })
//        ]
    );
  }
}
