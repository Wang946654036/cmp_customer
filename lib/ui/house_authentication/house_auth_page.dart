import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/strings/strings_house_auth.dart';
import 'package:cmp_customer/strings/strings_user.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_dialog.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_picker.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_shadow_container.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_text_field.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_state.dart';
import 'package:cmp_customer/ui/house_authentication/select_house_page.dart';
import 'package:cmp_customer/ui/me/community_search_page.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum HouseAuthType {
  AddAuth, //新增房屋
  ReAuth, //重新认证
  FirstAuth, //游客首次
}

///
/// 房屋认证-人工认证/新增房屋
///
class HouseAuthPage extends StatefulWidget {
  final CreateHouseModel createHouseModel;
  final HouseAuthType houseAuthType;

  HouseAuthPage({this.createHouseModel, this.houseAuthType});

  @override
  _HouseAuthPageState createState() => _HouseAuthPageState();
}

class _HouseAuthPageState extends State<HouseAuthPage> {
  CreateHouseModel _createHouseModel;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _documentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _createHouseModel = widget.createHouseModel ?? CreateHouseModel();
//    if(_createHouseModel?.name != null)
    _nameController.text = _createHouseModel?.name;
    _documentController.text = _createHouseModel?.documentNo;
    if (stateModel.custType != null) _createHouseModel.authType = stateModel.custType;
//    else _createHouseModel.authType = authTypeGR;
  }

  ///
  /// 检查表单填写
  ///
  bool _checkData() {
    if (_createHouseModel?.projectId == null) {
      CommonToast.show(msg: '请选择社区', type: ToastIconType.INFO);
      return false;
    }
    if (_createHouseModel?.houseId == null) {
      CommonToast.show(msg: '请选择房号信息', type: ToastIconType.INFO);
      return false;
    }
    if (widget.houseAuthType == HouseAuthType.FirstAuth) {
    //默认认证的都是个人认证
//      if (_createHouseModel?.authType == null || _createHouseModel.authType.isEmpty) {
//        CommonToast.show(msg: '请选择认证类型', type: ToastIconType.INFO);
//        return false;
//      }
      if (_createHouseModel?.name == null || _createHouseModel.name.isEmpty) {
        CommonToast.show(msg: '请输入姓名', type: ToastIconType.INFO);
        return false;
      }
    }
    if (_createHouseModel?.customerType == null || _createHouseModel.customerType.isEmpty) {
      CommonToast.show(msg: '请选择客户类型', type: ToastIconType.INFO);
      return false;
    }
    return true;
  }

  ///
  /// 选择身份：业主、业主成员、租户、租户成员
  ///
  Widget _buildCustomerProper(String title, String imagePath, String type) {
    return CommonShadowContainer(
      borderVisible: type == _createHouseModel.customerType,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(imagePath, width: ScreenUtil.getInstance().setWidth(64), fit: BoxFit.fitWidth),
          CommonText.grey15Text(title),
        ],
      ),
      onTap: () {
        setState(() {
          _createHouseModel.customerType = type;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appTitle: '房屋认证',
      bodyData: Container(
        child: ListView(
          children: <Widget>[
            CommonSingleInputRow(
              '社区',
              content: _createHouseModel?.projectId != null
                  ? CommonText.darkGrey15Text(_createHouseModel.formerName ?? '')
                  : CommonText.lightGrey15Text('请选择'),
              onTap: () {
                navigatorKey.currentState.push(MaterialPageRoute(builder: (context) {
                  return CommunitySearchPage(callback: (int projectId, String formerName) {
                    setState(() {
                      _createHouseModel.projectId = projectId;
                      _createHouseModel.formerName = formerName;
                      _createHouseModel.houseAddr = null;
                      _createHouseModel.houseId = null;
                    });
                  });
                }));
              },
            ),
            CommonDivider(),
            CommonSingleInputRow(
              '房号',
              content: _createHouseModel?.houseAddr != null
                  ? CommonText.darkGrey15Text(_createHouseModel.houseAddr ?? '')
                  : CommonText.lightGrey15Text('请选择'),
              onTap: () {
                if (_createHouseModel.projectId == null) {
                  CommonToast.show(msg: '请先选择社区', type: ToastIconType.INFO);
                  return;
                }
                navigatorKey.currentState.push<HouseAddrModel>(MaterialPageRoute(builder: (context) {
                  return SelectHousePage(_createHouseModel.projectId, _createHouseModel.formerName);
                })).then((HouseAddrModel model) {
                  if (model != null) {
                    setState(() {
                      _createHouseModel.houseAddr =
                          '${model?.buildingName ?? ''}${model?.unitName ?? ''}${model?.roomName ?? ''}';
                      _createHouseModel.houseId = model?.roomId;
                    });
                  }
                });
              },
            ),
            Visibility(
                visible: widget.houseAuthType == HouseAuthType.FirstAuth,
                child: Column(
                  children: <Widget>[
                    CommonDivider(),
//                    Container(
//                      color: UIData.primaryColor,
//                      child: Row(
//                        children: <Widget>[
//                          Radio<String>(
//                              groupValue: _createHouseModel.authType,
//                              value: authTypeGR,
//                              onChanged: (String value) {
//                                setState(() {
//                                  _createHouseModel.authType = value;
//                                  _createHouseModel.documentType = null;
//                                  _documentController.text = '';
//                                });
//                              }),
//                          CommonText.darkGrey15Text('个人认证'),
//                          Radio<String>(
//                              groupValue: _createHouseModel.authType,
//                              value: authTypeQY,
//                              onChanged: (String value) {
//                                setState(() {
//                                  _createHouseModel.authType = value;
//                                  if (_createHouseModel.customerType == customerJTCY ||
//                                      _createHouseModel.customerType == customerZHCY)
//                                    _createHouseModel.customerType = null;
//                                  _createHouseModel.documentType = null;
//                                  _documentController.text = '';
//                                });
//                              }),
//                          CommonText.darkGrey15Text('企业认证'),
//                        ],
//                      ),
//                    ),
//                    SizedBox(height: UIData.spaceSize16),
                    CommonSingleInputRow(
                      _createHouseModel.authType == authTypeGR ? '姓名' : '企业名称',
                      content: TextField(
                        controller: _nameController,
                        style: CommonText.darkGrey15TextStyle(),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '请输入（必填）',
                          hintStyle: CommonText.lightGrey15TextStyle(),
                          isDense: true,
                        ),
                        onChanged: (String value) {
                          setState(() {
                            _createHouseModel.name = value;
                          });
                        },
                      ),
                      arrowVisible: false,
                    ),
                    CommonDivider(),
                    Visibility(
                        visible: widget.houseAuthType == HouseAuthType.FirstAuth,
                        child: Column(
                          children: <Widget>[
                            CommonSingleInputRow(
                              '证件类型',
                              content: _createHouseModel.documentType != null
                                  ? CommonText.darkGrey15Text(_createHouseModel.authType == authTypeGR
                                      ? documentGRMap[_createHouseModel.documentType]
                                      : documentQYMap[_createHouseModel.documentType])
                                  : CommonText.lightGrey15Text('请选择'),
                              onTap: () => CommonPicker.singlePickerModal(
                                      context,
                                      _createHouseModel.authType == authTypeGR
                                          ? documentGRMap.values.toList()
                                          : documentQYMap.values.toList(), onConfirm: (int index, String data) {
                                    setState(() {
                                      _createHouseModel.documentType = _createHouseModel.authType == authTypeGR
                                          ? documentGRMap.keys.toList()[index]
                                          : documentQYMap.keys.toList()[index];
                                    });
                                  }),
                            ),
                            CommonDivider(),
                          ],
                        )),
                    Visibility(
                        visible: widget.houseAuthType == HouseAuthType.FirstAuth,
                        child: CommonSingleInputRow(
                          '证件号',
                          content: TextField(
                            controller: _documentController,
                            style: CommonText.darkGrey15TextStyle(),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '填写证件可以更快通过认证',
                              hintStyle: CommonText.lightGrey15TextStyle(),
                              isDense: true,
                            ),
                            onChanged: (String value) {
                              setState(() {
                                _createHouseModel.documentNo = value;
                              });
                            },
                          ),
                          arrowVisible: false,
                        )),
                  ],
                )),
            GridView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(UIData.spaceSize16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.38,
                    mainAxisSpacing: UIData.spaceSize16,
                    crossAxisSpacing: UIData.spaceSize16),
                children: <Widget>[
                  _buildCustomerProper('我是业主', UIData.imageOwner, customerYZ),
                  _buildCustomerProper('我是租户', UIData.imageTenant, customerZH),
                  Visibility(
                      visible: _createHouseModel.authType == authTypeGR,
                      child: _buildCustomerProper('我是业主成员', UIData.imageMember, customerJTCY)),
                  Visibility(
                      visible: _createHouseModel.authType == authTypeGR,
                      child: _buildCustomerProper('我是租户成员', UIData.imageTenantMember, customerZHCY)),
                ]),
          ],
        ),
      ),
      bottomNavigationBar: StadiumSolidButton('提交认证', onTap: () {
        if (_checkData()) {
          if (stateModel.customerType == 2) {
            //认证过的客户
            stateModel.createHouse(_createHouseModel);
          } else {
            //游客
            stateModel.getTouristAccountStatus(
                documentType: _createHouseModel?.documentType,
                documentNo: _createHouseModel?.documentNo,
                callBack: ({String message, String mobile, List list}) {
                  if (message == '452') {
                    //匹配到客户且关联账号
                    CommonDialog.showAlertDialog(context,
                        content: '通过证件检测到您已有账号$mobile，您可登录该账号修改手机号或者请联系物管中心知会系统后台人员解决。',
                        positiveBtnText: '返回登录',
                        negativeBtnText: '取消', onConfirm: () {
                      navigatorKey.currentState
                          .pushNamedAndRemoveUntil(Constant.pageLogin, ModalRoute.withName('/'));
                    });
                  } else {
                    stateModel.createHouse(_createHouseModel);
                  }
                });
          }
        }
      }),
    );
  }
}

///
///  游客人工认证/客户添加房屋提交数据对象
///
class CreateHouseModel {
  int houseId; //房号id
  String authType; //认证类型：G-个人，Q-企业
  String name; //姓名
  String documentType; //证件类型
  String documentNo; //证件号码
  String customerType; //客户属性
  int projectId; //社区Id
  String formerName; //社区名称
  String houseAddr; //房屋地址
  int houseCustAuditId; //房屋认证表id

  CreateHouseModel(
      {this.documentType, //
      this.documentNo, //
      this.houseId, //
      this.authType = authTypeGR, //
      this.customerType, //
      this.name, //
      this.formerName,
      this.projectId,
      this.houseAddr,
      this.houseCustAuditId});

  dynamic toJson() => {
        'custName': name,
        'custProper': customerType,
        'custType': authType,
        'houseId': houseId,
        'idTypeId': documentType,
        'custIdNum': documentNo,
        'houseCustAuditId': houseCustAuditId,
      };
}
