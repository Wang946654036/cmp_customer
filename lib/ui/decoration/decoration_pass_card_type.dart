import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/hot_work_detail_model.dart';
import 'package:cmp_customer/models/response/check_in_details_response.dart';
import 'package:cmp_customer/models/response/decoration_pass_card_details_response.dart';
import 'package:cmp_customer/scoped_models/decoration/decoration_pass_card_type_state_model.dart';
import 'package:cmp_customer/ui/check_in/check_in_history.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_text_field.dart';
import 'package:cmp_customer/ui/parking/parking_card_ui.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'decoration_pass_card_history_tab.dart';
import 'decoration_pass_card_label.dart';

//装修工出入证类型
class DecorationPassCardTypePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DecorationPassCardType();
  }
}

class _DecorationPassCardType extends State<DecorationPassCardTypePage> {
  DecorationPassCardTypeStateModel _typeModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (_typeModel == null) {
      _typeModel = new DecorationPassCardTypeStateModel();
    }
    _typeModel.initSelectData();
    _typeModel.setDefaultType();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Widget _buildContent() {
      return ScopedModelDescendant<DecorationPassCardTypeStateModel>(
          builder: (context, child, model) {
            DecorationPassCardDetails applyRequest = model.applyRequest;
        return CommonScaffold(
          appTitle: label_apply_pass_card_apply,
          bodyData: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  color: color_layout_bg,
                  margin: EdgeInsets.only(top: top_spacing),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      leftTextWidget(
                        text: label_apply_person,
                        topSpacing: top_spacing,
                      ),
                      Container(
                        color: UIData.primaryColor,
                        margin: EdgeInsets.only(
                            left: left_spacing,
                            top: top_spacing,
                            bottom: bottom_spacing),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: ellipseBotton(
                                model.applyTypeList[0].name,
                                model.applyTypeList[0].selected,
                                onChanged: (value) {
                                  model.setCustomerType(0, value);
                                },
                              ),
                            ),
                            Expanded(
                              child: ellipseBotton(
                                model.applyTypeList[1].name,
                                model.applyTypeList[1].selected,
                                onChanged: (value) {
                                  model.setCustomerType(1, value);
                                },
                              ),
                            ),
                            Expanded(
                              child: ellipseBotton(
                                model.applyTypeList[2].name,
                                model.applyTypeList[2].selected,
                                onChanged: (value) {
                                  model.setCustomerType(2, value);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      CommonDivider(),
                      GestureDetector(
                        child: labelTextWidget(
                          label: label_apply_community,
                          labelColor: color_text,
                          topSpacing: top_spacing,
                          needArrow: true,
                          bottomSpacing: bottom_spacing,
                          text: applyRequest.formerName??label_please_select_community,
                        ),
                        onTap: () {
                          model.selectCommunity();
                        },
                      ),
                      CommonDivider(),
                      GestureDetector(
                        child: labelTextWidget(
                          label: label_apply_house,
                          labelColor: color_text,
                          needArrow: true,
                          topSpacing: top_spacing,
                          bottomSpacing: bottom_spacing,
                          text: applyRequest.houseName??label_please_select_house,
                        ),
                        onTap: () {
                          model.selectHouse();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: StadiumSolidButton(
            label_next,
            btnType: ButtonType.CONFIRM,
            onTap: () {
              model.checkData();
            },
          ),
            appBarActions: <Widget>[
              Builder(builder: (context) {
                return FlatButton(
                    onPressed: () {
                      Navigate.toNewPage(DecorationPassCardHistoryTabPage(model.isOwner));
                    },
//                    child: Container(
//                        alignment: Alignment.centerRight,
//                        padding: EdgeInsets.only(right: right_spacing),
                        child: CommonText.text15("申请列表",
                            color: color_text_red,
                            textAlign: TextAlign.center)
//                )
                );
              })
            ]
        );
      });
    }

    return ScopedModel<DecorationPassCardTypeStateModel>(
        model: _typeModel, child: _buildContent());
  }
}
