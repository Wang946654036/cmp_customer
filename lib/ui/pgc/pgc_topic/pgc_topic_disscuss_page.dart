import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/work_order_vo.dart';
import 'package:cmp_customer/ui/common/common_audio.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_image_picker.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/work_other/complain_history_list.dart';
import 'package:cmp_customer/ui/work_other/work_other_ui.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';

///
/// 新建报障工单（政）since：2019/3/23
///
class PgcTopicDisscussPage extends StatefulWidget {
  PgcTopicDisscussPage();

  @override
  _PgcTopicDisscussPageState createState() => new _PgcTopicDisscussPageState();
}

class _PgcTopicDisscussPageState extends State<PgcTopicDisscussPage> {
  List<String> photos = new List();
  String file;
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  _PgcTopicDisscussPageState();

  FocusNode _commentFocus = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.text = "";
    controller2.text = "";
//    MainStateModel.of(context).loadHightWordsList(PgcTopicDisscussType);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    stateModel.cleanHighFrequencyWordsStateModel();
  }

  @override
  Widget build(BuildContext context) {
    return new CommonScaffold(
        appTitle: '参与话题',

        bodyData: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(right: UIData.spaceSize16),
                  child: Column(
                    children: <Widget>[
                      inputWidget(
                        autofocus: true,
                        labelText: '#我是主题# ',
                        labelStyle: TextStyle(

                            color: UIData.underlineBlueColor,
                            fontSize: UIData.fontSize15),
                        controller: controller,
                        hint_text: hint_text,
                        maxLength: 300,
                        bottomSpace: UIData.spaceSize16,
                        editTopPadding: UIData.spaceSize4,
                        editBotPadding: UIData.spaceSize30,
                      )
                    ],
                  )),

              CommonDivider(),

              Container(
                  //上传照片
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      leftTextWidget(
                          text: "上传照片", topSpacing: UIData.spaceSize16),
                      Container(
                        margin: EdgeInsets.all(UIData.spaceSize16),
                        child: CommonImagePicker(callback: (List<String> list) {
                          if (photos == null) {
                            photos = new List();
                          } else {
                            photos.clear();
                          }
                          photos.addAll(list);
                        }),
                      )
                    ],
                  )),

//              _buildList(),
            ],
          ),
        ),
        appBarActions: [
          FlatButton(
              onPressed: () {
                CommonToast.show(type: ToastIconType.SUCCESS, msg: '发表成功');
                Navigate.closePage(true);
              },
              child: CommonText.red15Text('发表')),
        ]);
  }
}
