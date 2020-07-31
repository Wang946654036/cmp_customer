import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/tourist_account_status_model.dart';
import 'package:cmp_customer/strings/strings_user.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_shadow_container.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_text_field.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/house_authentication/common_house_listtile.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
/// 游客-自动认证
///
class TouristAutoAuthPage extends StatefulWidget {
  final List<CustomerInfo> list;

  TouristAutoAuthPage(this.list);

  @override
  _TouristAutoAuthStatePage createState() => _TouristAutoAuthStatePage();
}

class _TouristAutoAuthStatePage extends State<TouristAutoAuthPage> {
  String _smsCode;

  Widget _buildList() {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget?.list?.length ?? 0,
        itemBuilder: (context, index) {
          CustomerInfo info = widget?.list[index];
          return _buildCard(info);
        });
  }

  ///
  /// 卡片显示房屋信息
  ///
  Widget _buildCard(CustomerInfo info) {
    return CommonShadowContainer(
        margin: EdgeInsets.only(bottom: UIData.spaceSize16, left: UIData.spaceSize16, right: UIData.spaceSize16),
        padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize16),
        child: CommonHouseListTile(
            title: info?.custName ?? '',
            subTitleIconVisible: true,
            subTitle: '${info?.buildName ?? ''}${info?.unitName ?? ''}${info?.houseNo ?? ''}',
            label: customerTypeMap[info?.custProper] ?? ''));
  }

  ///
  /// 顶部提示语和验证码栏
  ///
  Widget _buildTop() {
    return Container(
      color: UIData.primaryColor,
      padding: EdgeInsets.all(UIData.spaceSize16),
      child: Column(
        children: <Widget>[
          CommonText.darkGrey16Text('您的账号${stateModel.userAccount}与预留手机号码一致，输入验证码即可完成快捷自动认证哦',
              overflow: TextOverflow.fade),
          SizedBox(height: UIData.spaceSize16),
          Row(
            children: <Widget>[
              Expanded(
                  child: LoginTypeTextField(
                //验证码输入框
//                    controller: _pwdController,
                hintText: '请输入验证码',
//                    focusNode: _pwdFocusNode,
                showCancelBtn: false,
                onChanged: (String value) {
                  setState(() {
                    _smsCode = value;
                  });
                },
              )),
              CommonCountDownButton(phoneNo: stateModel.userAccount),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildBody() {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        _buildTop(),
        SizedBox(height: UIData.spaceSize16),
        _buildList(),
//          CommonDivider(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appTitle: '房屋认证',
      bodyData: _buildBody(),
      bottomNavigationBar: StadiumSolidButton('提交认证', onTap: () {
        if (_smsCode == null) {
          CommonToast.show(msg: '请输入验证码', type: ToastIconType.INFO);
          return;
        }
        stateModel.houseAutoAuth(_smsCode);
      }),
    );
  }
}
