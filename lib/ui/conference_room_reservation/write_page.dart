import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/response/agreement_response.dart';
import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/strings/strings_common.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';


import 'package:flutter/material.dart';

///
/// 文案配置显示页面
///
class WritingPage extends StatefulWidget {
  final String title;
  final String content;
  WritingPage(this.title, this.content);

  @override
  _WritingPageState createState() => _WritingPageState();
}

class _WritingPageState extends State<WritingPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }



  Widget _buildBody() {
    return ScopedModelDescendant<MainStateModel>(builder: (context, child, model){
      return CommonLoadContainer(
        state: ListState.HINT_DISMISS,
        content: Container(
          color: UIData.primaryColor,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(UIData.spaceSize16),
            children: <Widget>[CommonText.grey14Text(widget.content ?? '',
                height: 1.3,overflow:TextOverflow.visible)],
          ),
        ),
        callback: (){},
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appTitle: widget.title,
      bodyData: _buildBody(),
    );
  }
}

