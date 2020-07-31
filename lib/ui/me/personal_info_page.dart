import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/me/common_me_single_row.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'nickname_page.dart';
import 'portrait_picker.dart';

///
/// 个人资料
///
class PersonalInfoPage extends StatefulWidget {
  @override
  _PersonalInfoPageState createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  String _birthDate;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appTitle: '个人资料',
      bodyData: Column(
        children: <Widget>[
          PorTraitPicker(
              photoId: stateModel.portrait,
              callback: (String uuid) {
                stateModel.modifyPersonalInfo(type: 2, custPhoto: uuid, showToast: false,
                    callBack: (int type) {
                      setState(() {
                        if (type == 2) {
                          stateModel.portrait = uuid;
                        }
                      });
                    });
              }),
          CommonDivider(),
          MeSingleLine(
            '昵称',
            content: stateModel.personalInfo?.nickName ?? '',
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                  return NicknamePage(callBack: (String nickname) {});
                })),
          ),
          SizedBox(height: UIData.spaceSize12),
          MeSingleLine(
            '姓名',
            content: stateModel.customerName ?? '',
//              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
//                return NicknamePage();
//              })),
            arrowVisible: false,
          ),
          CommonDivider(),
          MeSingleLine(
            '性别',
            content: stateModel.personalInfo?.sex ?? '',
//              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
//                    return SexSelectionPage();
//                  })),
            arrowVisible: false,
          ),
          CommonDivider(),
          MeSingleLine(
            '生日',
            content: stateModel.personalInfo?.birth ?? '',
//            onTap: () {
//              CommonDatePicker.datePickerModal(context, onConfirm: (String date) {
//                setState(() {
//                  _birthDate = date;
//                });
//              });
//            },
            arrowVisible: false,
          ),
//          CommonDivider(),
////          _buildSingleLine('家庭状态', ''),
////          _buildDivider(),
//          MeSingleLine('个性签名', content: stateModel.personalInfo?.signature ?? '',
//              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
//                return PersonalSignaturePage();
//              })),
//            arrowVisible: false),
        ],
      ),
    );
  }
}
