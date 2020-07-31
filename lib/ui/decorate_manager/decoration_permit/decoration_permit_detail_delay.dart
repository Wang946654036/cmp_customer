///装修许可证详情
///
///
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/decoration_permit_obj.dart';
import 'package:cmp_customer/scoped_models/decoration_permit_model.dart';
import 'package:cmp_customer/ui/common/common_bottom_input_view/bottom_input_view.dart';
import 'package:cmp_customer/ui/common/common_bottom_input_view/pop_route.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/date_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../decoration_ui.dart';

class DecorationPermitDetailDelay extends StatefulWidget {

  int infoId;
  DecorationPermitModel _model;

  DecorationPermitDetailDelay(this._model,this.infoId);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DecorationPermitDetailDelayState();
  }
}

class _DecorationPermitDetailDelayState extends State<DecorationPermitDetailDelay> {

  TextEditingController remarkController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget._model.getDecorationPermitInfo(widget.infoId);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModel<DecorationPermitModel>(
        model: widget._model,
        child: ScopedModelDescendant<DecorationPermitModel>(
            builder: (context, child, model) {
              DecorationPermitInfo info = model.decorationPermitInfo;
              return CommonScaffold(
                  appTitle: "延期申请",
                  bodyData: _buildBody(),
                  bottomNavigationBar: StadiumSolidButton(
                    label_submit,
                    btnType: ButtonType.CONFIRM,
                    onTap: () {
                      widget._model.decorationPermitIsPass({},callback: (){ widget._model.getDecorationPermitInfo(widget.infoId);});
                    },
                  ));
            }));
  }
  Widget _buildBody() {
    return ScopedModelDescendant<DecorationPermitModel>(
        builder: (context, child, model) {
          return _buildContent();
        });
  }

  Widget _buildContent() {
    return ScopedModelDescendant<DecorationPermitModel>(
        builder: (context, child, model) {
          DecorationPermitInfo info = model.decorationPermitInfo;
          return SingleChildScrollView(
            child: Column(children: <Widget>[
              Container(
                  color: UIData.primaryColor,
                  padding: EdgeInsets.only(bottom: UIData.spaceSize12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CommonText.darkGrey16Text('处理意见'),
                      SizedBox(
                        height: UIData.spaceSize4,
                      ),
                      inputWidget(
                        remarkController,
                        hint_text: hint_text,
                        maxLength: 200,
//                        onChanged: (string) {
//                          workTask.processContent = string;
//                        },
                      )
                    ],
                  )),

            ]),
          );
        });
  }
//

  String isOverTime(String lastDate){
    DateTime last = DateUtils.getDateTimeFromString(lastDate);
    DateTime now = DateTime.now();
    if(now.isBefore(last)){
      return normalTime;
    }else{
      return overTime;
    }
  }



}
