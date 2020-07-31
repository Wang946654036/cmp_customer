import 'package:cmp_customer/models/response/check_in_details_response.dart';
import 'package:cmp_customer/scoped_models/check_in_model/check_in_agreement_state_model.dart';
import 'package:cmp_customer/strings/strings_common.dart';
import 'package:cmp_customer/ui/check_in/check_in_label.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/copy_writing_page.dart';
import 'package:cmp_customer/ui/parking/parking_card_ui.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CheckInAgreementPage extends StatefulWidget {
  CheckInDetails applyRequest;
  CheckInAgreementPage(this.applyRequest);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CheckInAgreement();
  }
}

class _CheckInAgreement extends State<CheckInAgreementPage> {
  CheckInAgreementModel _applyModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(_applyModel==null){
      _applyModel = new CheckInAgreementModel();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Widget _buildContent() {
      return ScopedModelDescendant<CheckInAgreementModel>(
          builder: (context, child, model) {
            return CommonScaffold(
              appTitle: label_apply_tenant_entry_apply,
              bodyData: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          Navigate.toNewPage(CopyWritingPage('业主公约', CopyWritingType.OwnerPledge));
                        },
                        child:Container(
                          padding: EdgeInsets.symmetric(horizontal: horizontal_spacing,vertical: vertical_spacing),
                          child: CommonText.text12("《业主公约》"),
                        )
                    ),
                    GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          Navigate.toNewPage(CopyWritingPage('精神文明建设公约', CopyWritingType.CivilizationConvention));
                        },
                        child:Container(
                          padding: EdgeInsets.symmetric(horizontal: horizontal_spacing,vertical: vertical_spacing),
                          child: CommonText.text12("《精神文明建设公约》"),
                        )
                    ),
                    GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          Navigate.toNewPage(CopyWritingPage('安全防火责任书', CopyWritingType.FireSafetyResponsibility));
                        },
                        child:Container(
                          padding: EdgeInsets.symmetric(horizontal: horizontal_spacing,vertical: vertical_spacing),
                          child: CommonText.text12("《安全防火责任书》"),
                        )
                    ),
                    GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          Navigate.toNewPage(CopyWritingPage('防火负责人联络表', CopyWritingType.FireDirectorContact));
                        },
                        child:Container(
                          padding: EdgeInsets.symmetric(horizontal: horizontal_spacing,vertical: vertical_spacing),
                          child: CommonText.text12("《防火负责人联络表》"),
                        )
                    ),
                    GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          Navigate.toNewPage(CopyWritingPage('委托收款结算协议书', CopyWritingType.EntrustPayAgreement));
                        },
                        child:Container(
                          padding: EdgeInsets.symmetric(horizontal: horizontal_spacing,vertical: vertical_spacing),
                          child: CommonText.text12("《委托收款结算协议书》"),
                        )
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: vertical_spacing),
                      child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            model.onChangeAgree();
                          },
                          child:Container(
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: horizontal_spacing,vertical: vertical_spacing),
                                  child: model.agree
                                      ? UIData.iconCheckBoxSelected
                                      : UIData.iconCheckBoxNormal,
                                ),
                                CommonText.text12("同意,并签署以上协议", color: UIData.redColor),
                              ],
                            ),
                          )
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: StadiumSolidButton(
                label_submit,
                btnType: ButtonType.CONFIRM,
                onTap: () {
                  model.uploadApplyData(widget.applyRequest);
                },
              ),
            );
          });
    }

    return ScopedModel<CheckInAgreementModel>(
        model: _applyModel, child: _buildContent());
  }
}
