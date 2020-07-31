import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/request/parking_card_apply_request.dart';
import 'package:cmp_customer/models/response/parking_card_details_response.dart';
import 'package:cmp_customer/models/response/parking_card_monthly_response.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/scoped_models/parking_model/parking_apply_state_model.dart';
import 'package:cmp_customer/scoped_models/parking_model/parking_bind_state_model.dart';
import 'package:cmp_customer/ui/common/car_number_input_keyboard.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_dialog.dart';
import 'package:cmp_customer/ui/common/common_image_picker.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_shadow_container.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/parking/parking_card_price.dart';
import 'package:cmp_customer/ui/parking/parking_card_state.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/date_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scoped_model/scoped_model.dart';
import 'parking_card_ui.dart';

//停车卡绑定
class ParkingCardBindPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ParkingCardBind();
  }
}

class ParkingCardBind extends State<ParkingCardBindPage> {
  ParkingBindStateModel _stateModel;
  bool _showCarNoInputView = false; //是否显示车牌号键盘
  String plate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _stateModel = new ParkingBindStateModel();
  }

  //布局
  Widget _buildBody() {
    return CommonScaffold(
      appTitle: "绑定月卡",
      bodyData: Column(
        children: <Widget>[
          Container(
            color: color_layout_bg,
            margin: EdgeInsets.only(top: top_spacing),
            child: GestureDetector(
              child: labelTextWidget(
                label: label_apply_car_no,
                text: plate ?? hint_text_required,
                topSpacing: top_spacing,
                labelColor: UIData.darkGreyColor,
                color: StringsHelper.isEmpty(plate)
                    ? UIData.lightGreyColor
                    : UIData.darkGreyColor,
                bottomSpacing: bottom_spacing,
              ),
              onTap: () {
                setState(() {
                  FocusScope.of(context).requestFocus(FocusNode());
                  _showCarNoInputView = true;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.separated(
                itemCount: _stateModel.list?.length ?? 0,
                separatorBuilder: (BuildContext context, int index) =>
                    horizontalLineWidget(),
                itemBuilder: (BuildContext context, int index) {
                  ParkingCardMonthly info = _stateModel.list[index];
                  return CommonShadowContainer(
                    margin: EdgeInsets.only(
                        top: card_spacing,
                        left: left_spacing,
                        right: right_spacing),
                    padding: EdgeInsets.symmetric(vertical: vertical_spacing),
                    backgroundColor: Colors.white,
                    child: new Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: left_spacing),
                          child: CommonText.darkGrey16Text("${info.communityName??""} - ${info.parkName??""}"),
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  leftTextWidget(
                                    text: label_apply_parking_packages + "：" + (info.priceName??""),
                                    topSpacing:
                                        ScreenUtil.getInstance().setHeight(8),
                                  ),
                                  leftTextWidget(
                                    text: label_apply_car_no + "：" + (info.plate??""),
                                    topSpacing:
                                    ScreenUtil.getInstance().setHeight(8),
                                  ),
                                  leftTextWidget(
                                    text: label_apply_validity_date + "：" + DateUtils.getDataText(info.start) + " 至 "+DateUtils.getDataText(info.end),
                                    topSpacing:
                                    ScreenUtil.getInstance().setHeight(8),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  );
                }),
          )
        ],
      ),
      bottomNavigationBar:
          (_stateModel.list != null && _stateModel.list.isNotEmpty)
              ? StadiumSolidButton(
                  label_bind,
                  btnType: ButtonType.CONFIRM,
                  onTap: () {
                    _stateModel.uploadBindData();
                  },
                )
              : null,
    );
  }

  //车牌号码键盘
  Widget _buildCarNoKeyboard() {
    return Theme(
        data: Theme.of(context).copyWith(),
        child: Material(
          color: Colors.transparent,
          child: Offstage(
            offstage: !_showCarNoInputView,
            child: CarNoInputKeyboard(
              carNo: plate ?? "",
              onCancel: () {
                setState(() {
                  _showCarNoInputView = false;
                });
              },
              onConfirm: (String carNo) {
                if (!StringsHelper.isCarNo(carNo)) {
                  CommonToast.show(msg: '请输入正确车牌号', type: ToastIconType.INFO);
                } else {
                  setState(() {
                    _showCarNoInputView = false;
                    plate = carNo;
                  });
                  _stateModel.checkData(plate);
                }
              },
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModel<ParkingBindStateModel>(
        model: _stateModel,
        child: ScopedModelDescendant<ParkingBindStateModel>(
            builder: (context, child, model) {
          return Stack(children: <Widget>[_buildBody(), _buildCarNoKeyboard()]);
        }));
  }
}
