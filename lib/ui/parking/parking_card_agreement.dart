import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/request/parking_card_apply_request.dart';
import 'package:cmp_customer/models/response/agreement_response.dart';
import 'package:cmp_customer/models/response/parking_card_details_response.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/scoped_models/parking_model/parking_apply_state_model.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_image_picker.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/parking/parking_card_price.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'parking_card_ui.dart';

//停车协议
class ParkingCardAgreementPage extends StatelessWidget {
  AgreementInfo info;

  ParkingCardAgreementPage(this.info);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CommonScaffold(
      appTitle: "停车协议",
      bodyData: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: horizontal_spacing, vertical: vertical_spacing),
          child: Text(
            info?.agreementContent ?? "",
            style: TextStyle(
                color: UIData.darkGreyColor, fontSize: UIData.fontSize16),
          ),
        ),
      ),
    );
  }
}
