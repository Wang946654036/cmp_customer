import 'package:cmp_customer/models/response/parking_card_details_response.dart';
import 'package:cmp_customer/models/response/parking_card_prices_response.dart';
import 'package:cmp_customer/scoped_models/parking_model/parking_apply_state_model.dart';
import 'package:cmp_customer/scoped_models/parking_model/parking_mine_state_model.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/parking/parking_card_ui.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

//停车场套餐选择
class ParkingCardPricePage extends StatefulWidget {
  ParkingApplyStateModel stateModel;

  ParkingCardPricePage(this.stateModel);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ParkingCardPricePageState();
  }

}
//
//class ParkingCardSelect extends State<ParkingCardSelectPage>{
//  bool checkboxState=false;

class _ParkingCardPricePageState extends State<ParkingCardPricePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if ((widget.stateModel.parkingCardPrices == null ||
            widget.stateModel.parkingCardPrices.length == 0))
    widget.stateModel.getParkingPrices ();
  }


  Widget buildParkingCardPricePage() {
    return ScopedModelDescendant<ParkingApplyStateModel>(
      builder: (context, child, model) {
        return CommonLoadContainer(
            state: model.parkingCardPriceListState,
            content: RefreshIndicator(
                onRefresh: () {
                  _refresh();
                },
                child: ScopedModelDescendant<ParkingApplyStateModel>(
                    builder: (context, child, model) {
                      return ListView.separated(
                          itemCount: model.parkingCardPrices.length,
                          separatorBuilder: (BuildContext context, int index) =>
                              horizontalLineWidget(),
                          itemBuilder: (BuildContext context, int index) {
                            ParkingCardPrices info = model
                                .parkingCardPrices[index];
                            return GestureDetector(
                                onTap: () {
                                  model.selectParkingPackage(index);
                                },
                                child: Container(
                                    color: Colors.white,
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                              color: Colors.white,
                                              alignment: Alignment.centerLeft,
                                              padding: EdgeInsets.all(
                                                  left_spacing),
                                              child: CommonText.text15(
                                                  StringsHelper.getStringValue(
                                                      info.parkName) +
                                                      " - " +
                                                      StringsHelper
                                                          .getStringValue(
                                                          info.priceName) +
                                                      " " +
                                                      StringsHelper
                                                          .getStringValue(
                                                          info.price) +
                                                      "/月")),
                                        ),
                                        Visibility(
                                            visible: model.selectedPrices ==
                                                index,
                                            child: Container(
                                              color: Colors.white,
                                              child: Icon(
                                                Icons.check,
                                                color: UIData.themeBgColor,
                                                size: normal_right_icon_size,
                                              ),
                                            ))
                                      ],
                                    )));
                          });
                    })),

            callback: _refresh);
      },
    );
  }

  _refresh() async {
    widget.stateModel.getParkingPrices();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
//    final stateModel = ScopedModel.of<ParkingMineStateModel>(context);
    return CommonScaffold(
        appTitle: "套餐选择",
        bodyData: ScopedModel<ParkingApplyStateModel>(
            model: widget.stateModel,
            child: buildParkingCardPricePage())
    );
  }

}