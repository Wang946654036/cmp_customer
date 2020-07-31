import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/dictionary_list.dart';
import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_image_picker.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/work_other/work_other_ui.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

///
/// 新建报障工单（政）since：2019/3/23
///
class CreateCustomerFeedback extends StatefulWidget {
  CreateCustomerFeedback();

  @override
  _ComplaintPageState createState() => new _ComplaintPageState();
}

class _ComplaintPageState extends State<CreateCustomerFeedback> {
  List<String> photos = new List();
  TextEditingController controller = TextEditingController();
  List<Map> myList = new List();

  _ComplaintPageState();


  String feedbackType;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.text = "";
    stateModel.checkOutDataDictionaryList(
        dataMap: {"dataType": "WO_CUSTOMER_FEEDBACK"},
        callBack: (List<Dictionary> data) {

          myList.clear();
          data.forEach((Dictionary dictionary) {
            Map map = {'key': dictionary, 'bool': false};
            myList.add(map);
          });
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainStateModel>(
        builder: (context, child, model) {
      return new CommonScaffold(
        appTitle: '产品反馈',
        bodyData: CommonLoadContainer(
          state: model.workOthersAddWorkerModelLoadState,
          callback: () {
            stateModel.checkOutDataDictionaryList(
                dataMap: {"dataType": "WO_CUSTOMER_FEEDBACK"},
                callBack: (List<Dictionary> data) {

                  myList.clear();
                  data.forEach((Dictionary dictionary) {
                    Map map = {'key': dictionary, 'bool': false};
                    myList.add(map);
                  });
                });
          },
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  color: UIData.primaryColor,
                  padding: EdgeInsets.symmetric(
                      horizontal: UIData.spaceSize16,
                      vertical: UIData.spaceSize12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CommonText.darkGrey15Text('请选择反馈类型'),
                      SizedBox(
                        height: UIData.spaceSize3 * 2,
                      ),
                      Wrap(
                        alignment: WrapAlignment.start,
                        runAlignment: WrapAlignment.start,
                        spacing: UIData.spaceSize10,
                        runSpacing: UIData.spaceSize3 * 2,
                        children: getSpcWidgetList(),
                      ),
                    ],
                  ),
                ),
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
                          child:
                              CommonImagePicker(callback: (List<String> list) {
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
                CommonDivider(),
                Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(right: UIData.spaceSize16),
                    margin: EdgeInsets.only(top: UIData.spaceSize12),
                    child: Column(
                      children: <Widget>[
                        leftTextWidget(
                          text: '反馈意见',
                          topSpacing: UIData.spaceSize16,
                        ),
                        inputWidget(
                          controller: controller,
                          hint_text: '我们致力于为您提供更好的用户体验！请留下您宝贵的意见！',
                          maxLength: 200,
                          bottomSpace: UIData.spaceSize16,
                          editTopPadding: UIData.spaceSize4,
                          editBotPadding: UIData.spaceSize30,
                        )
                      ],
                    )),
                Container(
                  color: UIData.primaryColor,
                  child: Divider(color: UIData.dividerColor, height: 1.0),
                ),
//              _buildList(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Visibility(
          visible: model.workOthersAddWorkerModelLoadState== ListState.HINT_DISMISS,
          child: StadiumSolidButton(
            label_submit,
            btnType: ButtonType.CONFIRM,
            onTap: () {
              String contentStr = controller.text;
              String title = '反馈';
              if (StringsHelper.isEmpty(feedbackType)) {
                CommonToast.show(
                    msg: "亲，请选择" + title + "类型", type: ToastIconType.FAILED);
                return;
              }
              if (StringsHelper.isEmpty(contentStr)) {
                CommonToast.show(
                    msg: "亲，请填写" + title + "内容", type: ToastIconType.FAILED);
                return;
              }
              bool photosFlag = true;
              if(photos!=null)
              photos.forEach((str){
                if(str==null){
                  CommonToast.show(
                      msg: "尚有未上传完成的图片", type: ToastIconType.FAILED);
                  photosFlag = false;
                  return;
                }
              });
              if(!photosFlag){
                return;
              }

              stateModel.commitFeedback(
                  feedbackInfo: {
                    "customerId": stateModel.customerId,
                    "feedbackContent": contentStr,
                    "feedbackPhotoList": photos,
                    "feedbackType": feedbackType
                  },
                  callBack: () {
                    Navigator.of(context).pop();
                  });
            },
          ),
        ),
      );
    });
  }

  List<Widget> getSpcWidgetList() {
    List<Widget> widgetList = new List();
    for (int i = 0; i < myList.length; i++) {
      Dictionary key = myList[i]['key'];
      widgetList.add(ChoiceChip(
        label: Text(key.dataName),
        selected: myList[i]['bool'],
        selectedColor: UIData.themeBgColor,
        backgroundColor: Color(0xFFEFEFEF),
        labelStyle: myList[i]['bool']
            ? TextStyle(
                color: UIData.primaryColor,
                fontSize: UIData.fontSize14,
              )
            : TextStyle(
                color: UIData.lightGreyColor,
                fontSize: UIData.fontSize14,
              ),
        onSelected: (bool value) {
          setState(() {
            myList.forEach((info) {
              if (info['bool']) {
                info['bool'] = false;
              }
            });
            myList[i]['bool'] = true;
            feedbackType = key.dataCode;
          });
        },
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(UIData.spaceSize12 + UIData.spaceSize3)),
      ));
    }

    return widgetList;
  }
}
