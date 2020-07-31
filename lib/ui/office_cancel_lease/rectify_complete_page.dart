import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_image_picker.dart';
import 'package:cmp_customer/ui/common/common_picker.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_text_field.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';

///
/// 整改完成
///
class RectifyCompletePage extends StatefulWidget {
  final int id;

  RectifyCompletePage(this.id);

  @override
  _RectifyCompletePageState createState() => _RectifyCompletePageState();
}

class _RectifyCompletePageState extends State<RectifyCompletePage> {
  final TextEditingController _remarkController = TextEditingController();
  RectifyCompleteModel _rectifyModel = RectifyCompleteModel();

  @override
  void initState() {
    super.initState();
    _rectifyModel.officeSurrenderId = widget.id;
    _remarkController.addListener(() {
      _rectifyModel.remark = _remarkController.text;
    });
  }

  bool _checkCommit() {
    if (_rectifyModel.remark == null || _rectifyModel.remark.isEmpty) {
      CommonToast.show(msg: '请填写整改说明', type: ToastIconType.INFO);
      return false;
    }
    if (_rectifyModel.attRectifyList == null || _rectifyModel.attRectifyList.isEmpty) {
      CommonToast.show(msg: '请选择相关资料图片', type: ToastIconType.INFO);
      return false;
    }
    return true;
  }

  Widget _buildBody() {
    return Container(
      color: UIData.primaryColor,
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          CommonSelectSingleRow('可交验日期',
              hintText: '请选择',
              content: _rectifyModel.checkTime,
              onTap: () => CommonPicker.datePickerModal(context, onConfirm: (String date) {
                    setState(() {
                      _rectifyModel.checkTime = date;
                    });
                  })),
          CommonDivider(),
          Container(height: UIData.spaceSize16, color: UIData.scaffoldBgColor),
          Container(
            padding: EdgeInsets.only(left: UIData.spaceSize16, top: UIData.spaceSize16),
            child: CommonText.darkGrey15Text('相关资料（必填）'),
          ),
          Container(
            margin: EdgeInsets.all(UIData.spaceSize16),
            child: CommonImagePicker(
              photoIdList: _rectifyModel.attRectifyList,
                callback: (List<String> images) {
          _rectifyModel.attRectifyList = images;
          LogUtils.printLog('attRectifyList: ${_rectifyModel.attRectifyList}');
          },
            ),
          ),
          Container(height: UIData.spaceSize16, color: UIData.scaffoldBgColor),
          FormMultipleTextField('整改说明', hintText: '请说明整改情况（必填）', controller: _remarkController),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return StadiumSolidButton('提交', onTap: () {
      if (_checkCommit()) {
        stateModel.rectifyCompleteOfficeCancelLease(_rectifyModel);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appTitle: '交验登记',
      bodyData: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}

class RectifyCompleteModel {
  int officeSurrenderId; //写字楼退租id
  String operateStep; //操作环节
  String remark; //备注
  String checkTime; //可交验日期
  List<String> attRectifyList; //整改完成相关附件UUID列表（包括图片和Excel文件）、

  dynamic toJson() => {
        'officeSurrenderId': officeSurrenderId,
        'operateStep': operateStep,
        'remark': remark,
        'checkTime': checkTime,
        'attRectifyList': attRectifyList,
      };
}
