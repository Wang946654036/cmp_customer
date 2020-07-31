import 'package:cmp_customer/models/uncertified_community_model.dart';
import 'package:cmp_customer/strings/strings_house_auth.dart';
import 'package:cmp_customer/strings/strings_user.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_dialog.dart';
import 'package:cmp_customer/ui/common/common_shadow_container.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/house_authentication/my_house_page.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

///
/// 房屋列表
///
class HouseList extends StatefulWidget {
  var info;
  final GestureTapCallback onTap;
  final Function callback;

  HouseList(this.info, {this.onTap, this.callback});

  @override
  _HouseListState createState() => _HouseListState();
}

class _HouseListState extends State<HouseList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Color _getStatusColor() {
    if (widget.info.houseType == HouseType.Certified) {
      return UIData.greyColor;
    } else if (widget.info.auditStatus == houseAuditWaiting) {
      //待审核
      return UIData.yellowColor;
    } else if (widget.info.auditStatus == houseAuditFailed) {
      //认证失败
      return UIData.redColor;
    } else {
      return UIData.greyColor;
    }
  }

  ///
  /// 第一行内容（身份，认证状态）
  ///
  Widget _buildFirstRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CommonText.grey14Text('身份：${customerTypeMap[widget.info?.custProper]}'),
        CommonText.text14(
            widget.info.houseType == HouseType.Certified ? '已认证' : auditStatusMap[widget.info?.auditStatus] ?? '',
            color: _getStatusColor()),
      ],
    );
  }

  ///
  /// 第三行内容（地址、人数）
  ///
  Widget _buildThirdRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            UIData.iconLocation,
            CommonText.grey14Text(
                '${widget.info?.buildName ?? ''}${widget.info?.unitName ?? ''}${widget.info?.houseNo ?? ''}'),
          ],
        ),
        Row(
          children: <Widget>[
            Visibility(
                visible: widget.info.houseType == HouseType.Certified,
                child: Row(
                  children: <Widget>[
                    UIData.iconMemberNumber,
                    CommonText.grey14Text(
                        '${widget.info.houseType == HouseType.Certified ? (widget.info?.memberNumber ?? '') : ''}人'),
                  ],
                )),
            Visibility(
                //客户认证失败显示，游客不显示
                visible: widget.info?.auditStatus == houseAuditFailed && stateModel.customerType == 2,
                child: GestureDetector(
                  child: Icon(Icons.delete_forever, size: UIData.fontSize24, color: UIData.redColor),
                  onTap: () {
                    CommonDialog.showAlertDialog(context, title: '确定删除该房屋认证？', onConfirm: () {
                      stateModel.deleteAuditFailedHouse(widget.info?.houseCustAuditId, callBack: () {
                        if (widget.callback != null) widget.callback();
                      });
                    }, negativeBtnText: '我再看看', positiveBtnText: '确定');
                  },
                ))
          ],
        )
      ],
    );
  }

  ///
  /// 单个房屋信息卡片
  ///
  Widget _buildCard() {
    return Container(
      margin: EdgeInsets.only(left: UIData.spaceSize16, right: UIData.spaceSize16, bottom: UIData.spaceSize16),
      child: Stack(
        children: <Widget>[
          CommonShadowContainer(
            padding: EdgeInsets.all(UIData.spaceSize16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildFirstRow(), //第一行
                SizedBox(height: UIData.spaceSize8),
                CommonText.darkGrey16Text(widget.info?.formerName ?? ''), //第二行
                SizedBox(height: UIData.spaceSize8),
                _buildThirdRow(), //第三行
              ],
            ),
          ),
          Visibility(
              visible: (widget.info.houseType == HouseType.Certified &&
                      widget.info?.isDefaultHouse == '1' &&
                      (stateModel?.uncertifiedCommunityList == null ||
                          stateModel.uncertifiedCommunityList
                              .every((UncertifiedCommunity info) => !(info.isDefault ?? false)))) ??
                  false,
              child: CommonLabel('当前房屋',
                  textColor: UIData.redColor, backgroundColor: UIData.lightestRedColor)), //当前房屋标志
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(child: _buildCard(), onTap: widget.onTap);
  }
}
