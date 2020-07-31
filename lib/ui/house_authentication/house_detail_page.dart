import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/common/common_page_model.dart';
import 'package:cmp_customer/models/house_detail_model.dart';
import 'package:cmp_customer/models/uncertified_community_model.dart';
import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/strings/strings_house_auth.dart';
import 'package:cmp_customer/strings/strings_user.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_dialog.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_shadow_container.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_state.dart';
import 'package:cmp_customer/ui/house_authentication/common_house_listtile.dart';
import 'package:cmp_customer/ui/house_authentication/house_auth_page.dart';
import 'package:cmp_customer/ui/house_authentication/house_info_card.dart';
import 'package:cmp_customer/ui/house_authentication/my_house_page.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scoped_model/scoped_model.dart';

///
/// 房屋详情
/// 若是待审核或者审核失败必填参数:[houseCustAuditId]
/// 若是已认证必填参数:[custHouseRelationId]
/// 两个参数不能同时非空
///
class HouseDetailPage extends StatefulWidget {
  final int custHouseRelationId;
  final int houseCustAuditId;
  final Function callback;

  HouseDetailPage({this.custHouseRelationId, this.houseCustAuditId, this.callback})
      : assert(custHouseRelationId == null || houseCustAuditId == null);

  @override
  _HouseDetailPageState createState() => _HouseDetailPageState();
}

class _HouseDetailPageState extends State<HouseDetailPage> {
  HouseDetailPageModel _pageModel = HouseDetailPageModel();

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _refreshData() {
    stateModel.getHouseDetail(widget.custHouseRelationId, widget.houseCustAuditId, _pageModel);
  }

  double get _getSilverTopHeight {
    return _pageModel.pageState == ListState.HINT_DISMISS ? 177 : 147;
  }

  ///
  /// 对应状态显示字体颜色
  ///
  Color _getStatusColor() {
    if (_pageModel?.houseInfo?.auditStatus == houseAuditSuccess) {
      //审核通过
      return UIData.greyColor;
    } else if (_pageModel?.houseInfo?.auditStatus == houseAuditWaiting) {
      //待审核
      return UIData.yellowColor;
    } else if (_pageModel?.houseInfo?.auditStatus == houseAuditFailed) {
      //认证失败
      return UIData.redColor;
    } else {
      return UIData.greyColor;
    }
  }

  ///
  /// 我的认证信息单行
  ///
  Widget _buildAuthInfoSingleRow(String title, String content) {
    return Container(
      padding: EdgeInsets.only(left: UIData.spaceSize16, right: UIData.spaceSize16, bottom: UIData.spaceSize16),
      child: Row(
        children: <Widget>[
          SizedBox(width: ScreenUtil.getInstance().setWidth(70), child: CommonText.grey15Text(title)),
          CommonText.darkGrey15Text(content),
        ],
      ),
    );
  }

  Widget _buildLoadedWidget(ListState state) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(right: UIData.spaceSize16),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(80),
              child: Image(
                  image: AssetImage(
                      state == ListState.HINT_NO_DATA_CLICK ? UIData.imageNoData : UIData.imageLoadedFailed)),
            ),
            state == ListState.HINT_NO_DATA_CLICK
                ? CommonText.lightGrey14Text('暂无数据')
                : CommonText.grey14Text('刷新'),
          ],
        ),
      ),
      onTap: () => state == ListState.HINT_LOADED_FAILED_CLICK ? _refreshData() : null,
    );
  }

  ///
  /// 现有成员列表
  ///
  Widget _buildMemberList() {
    return ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
      switch (_pageModel.memberPageState) {
        case ListState.HINT_LOADING:
//          return ListTile(
//              dense: true,
//              title: Row(
//                  mainAxisSize: MainAxisSize.min,
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: <Widget>[
//                    SizedBox(
//                        width: UIData.spaceSize16,
//                        height: UIData.spaceSize16,
//                        child: CircularProgressIndicator(
//                            strokeWidth: 3.0, valueColor: AlwaysStoppedAnimation(UIData.redColor60))),
//                    SizedBox(width: UIData.spaceSize8),
//                    CommonText.darkGrey14Text('加载中...'),
//                  ]));
          break;
        case ListState.HINT_NO_DATA_CLICK:
          return _buildLoadedWidget(ListState.HINT_NO_DATA_CLICK);
          break;
        case ListState.HINT_LOADED_FAILED_CLICK:
//          return _buildLoadedWidget(ListState.HINT_LOADED_FAILED_CLICK);
          break;
        case ListState.HINT_DISMISS:
          return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: _pageModel?.memberList?.length ?? 0,
              itemBuilder: (context, index) {
                MemberInfo info = _pageModel.memberList[index];
                return CommonHouseListTile(
                  showAll: _pageModel?.houseInfo?.custProper == customerYZ ||
                      _pageModel?.houseInfo?.custProper == customerJTCY,
                  title: info?.custName ?? '',
                  subTitle: info?.custPhone ?? '',
                  label: customerTypeMap[info?.custProper],
                  //业主才能迁出业主成员，才显示迁出按钮
                  trailingOnTapVisible: _pageModel?.houseInfo?.custProper == customerTypeMap.keys.toList()[0],
                  trailingOnTap: () {
                    CommonDialog.showAlertDialog(context, title: '确定迁出该住户？', onConfirm: () {
                      stateModel.moveOutMember(info.custHouseRelationId, callBack: () {
                        _refreshData();
                        if (widget.callback != null) widget.callback();
                      });
                    });
                  },
                );
              });
          break;
        default:
          return Container();
          break;
      }
    });
  }

  Widget _buildHouseDetail() {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
      SizedBox(height: UIData.spaceSize16),
      CommonShadowContainer(
          //认证信息
          margin: EdgeInsets.symmetric(horizontal: UIData.spaceSize16),
          child: Column(
            children: <Widget>[
              ListTile(
                title: CommonText.darkGrey16Text('我的认证'),
                trailing: CommonText.text14(auditStatusMap[_pageModel?.houseInfo?.auditStatus ?? ''] ?? '',
                    color: _getStatusColor()),
              ),
              _buildAuthInfoSingleRow('身份', customerTypeMap[_pageModel?.houseInfo?.custProper]),
//              _buildAuthInfoSingleRow('姓名', stateModel.customerName ?? ''),
//              _buildAuthInfoSingleRow('手机', stateModel.mobile ?? ''),
              _buildAuthInfoSingleRow('姓名', _pageModel?.houseInfo?.custName ?? ''),
              _buildAuthInfoSingleRow('手机', _pageModel?.houseInfo?.custPhone ?? ''),
            ],
          )),
//      SizedBox(height: UIData.spaceSize16),
      Visibility(
          visible: _pageModel?.houseInfo?.auditStatus == houseAuditSuccess, //已认证才显示现有成员
          child: CommonShadowContainer(
              //现有成员
              margin: EdgeInsets.symmetric(horizontal: UIData.spaceSize16, vertical: UIData.spaceSize16),
              padding:
                  EdgeInsets.only(left: UIData.spaceSize16, top: UIData.spaceSize16, bottom: UIData.spaceSize16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  CommonText.darkGrey16Text('现有成员', textAlign: TextAlign.start),
                  SizedBox(height: UIData.spaceSize16),
                  _buildMemberList(),
                ],
              ))),
      Visibility(
          //审核意见，认证失败时显示
          visible: _pageModel?.houseInfo?.auditStatus == houseAuditFailed,
          child: CommonShadowContainer(
            margin: EdgeInsets.only(left: UIData.spaceSize16, right: UIData.spaceSize16, top: UIData.spaceSize16),
            padding: EdgeInsets.all(UIData.spaceSize16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CommonText.darkGrey16Text('审核意见'),
                SizedBox(height: UIData.spaceSize8),
                CommonText.grey15Text(_pageModel?.houseInfo?.auditStatus != houseAuditSuccess
                    ? _pageModel?.houseInfo?.auditDesc ?? ''
                    : '')
              ],
            ),
          ))
    ]);
  }

  Widget _buildBody() {
    return SliverList(
        delegate: SliverChildListDelegate(<Widget>[
      Container(
        height: _pageModel.pageState == ListState.HINT_DISMISS
            ? null
            : ScreenUtil.screenHeightDp - ScreenUtil.getInstance().setHeight(_getSilverTopHeight),
        child: CommonLoadContainer(
          state: _pageModel.pageState,
          content: _buildHouseDetail(),
          callback: _refreshData,
        ),
      )
    ]));
  }

  Widget _buildTop() {
    return Visibility(
        visible: _pageModel.pageState == ListState.HINT_DISMISS,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Visibility(
                //审核提示：待审核状态显示
                visible: _pageModel?.houseInfo?.auditStatus == houseAuditWaiting,
                child: Container(
                  margin: EdgeInsets.only(bottom: UIData.spaceSize4),
                  padding: EdgeInsets.symmetric(vertical: UIData.spaceSize8, horizontal: UIData.spaceSize16),
                  color: UIData.lighterYellowColor,
                  child: CommonText.text14('您的认证申请在核实中，敬请耐心等待！', color: UIData.orangeColor),
                )),
            HouseInfoCard(
                //房屋信息
                title: _pageModel?.houseInfo?.formerName ?? '',
                subTitle:
                    '${_pageModel?.houseInfo?.buildName ?? ''}${_pageModel?.houseInfo?.unitName ?? ''}${_pageModel?.houseInfo?.houseNo ?? ''}',
                //已认证房屋为已通过并且是默认房屋，或者未认证社区有默认社区
                trailingVisible: _pageModel?.houseInfo?.auditStatus == houseAuditSuccess &&
                    (_pageModel?.houseInfo?.isDefaultHouse != '1' ||
                        //未认证社区有默认社区
                        (stateModel.uncertifiedCommunityList != null &&
                            stateModel.uncertifiedCommunityList.length > 0 &&
                            stateModel.uncertifiedCommunityList
                                .any((UncertifiedCommunity info) => info.isDefault))),
                trailingOnTap: () {
                  stateModel.changeDefaultHouse(_pageModel?.houseInfo?.houseId, callBack: () {
                    _refreshData();
                    stateModel.setUncertifiedCommunityFalse();
                    stateModel.reLogin(callBack: () {
                      //回调刷新房屋列表
                      if (widget.callback != null) widget.callback();
                    });
//                    stateModel.clearAccessToken();
//                    stateModel.getUserData(callBack: () {
//                      //回调刷新房屋列表
//                      if (widget.callback != null) widget.callback();
//                    });
                  });
                })
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
      return Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: ScreenUtil.getInstance().setHeight(_getSilverTopHeight),
              elevation: 0.0,
              title: CommonText.darkGrey18Text('房屋详情'),
              titleSpacing: 0,
              pinned: true,
//          floating: true,
              leading: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.keyboard_arrow_left, color: UIData.darkGreyColor),
                  onPressed: () => Navigator.of(context).pop()),
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: UIData.scaffoldBgColor,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      Container(
                        margin: _pageModel.pageState == ListState.HINT_DISMISS
                            ? EdgeInsets.only(bottom: UIData.spaceSize30)
                            : null,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            image: DecorationImage(image: AssetImage(UIData.imageHouseBg), fit: BoxFit.fitHeight)),
                      ),
                      _buildTop(),
                    ],
                  ),
                ),
              ),
            ),
            _buildBody(),
          ],
        ),
        bottomNavigationBar: _pageModel?.houseInfo?.auditStatus == houseAuditFailed //认证失败显示重新认证按钮
            ? StadiumSolidButton('重新认证', onTap: () {
                navigatorKey.currentState.push<bool>(MaterialPageRoute(builder: (context) {
                  return HouseAuthPage(
                    createHouseModel: CreateHouseModel(
                      projectId: _pageModel?.houseInfo?.projectId,
                      formerName: _pageModel?.houseInfo?.formerName,
                      houseId: _pageModel?.houseInfo?.houseId,
                      houseAddr:
                          '${_pageModel?.houseInfo?.buildName ?? ''}${_pageModel?.houseInfo?.unitName ?? ''}${_pageModel?.houseInfo?.houseNo ?? ''}',
                      authType: _pageModel?.houseInfo?.custType,
                      name: _pageModel?.houseInfo?.custName,
                      documentType: _pageModel?.houseInfo?.idTypeId,
                      documentNo: _pageModel?.houseInfo?.custIdNum,
                      customerType: _pageModel?.houseInfo?.custProper,
                      houseCustAuditId: _pageModel?.houseInfo?.houseCustAuditId,
                    ),
                    //如果是游客则认定为首次认证
                    houseAuthType: stateModel.customerType == 1 ? HouseAuthType.FirstAuth : HouseAuthType.ReAuth,
                  );
                })).then((bool value) {
                  if (value != null && value) {
//                      if(widget.callback != null) widget.callback();
                    navigatorKey.currentState.pop(true);
                  }
                });
//        stateModel.createHouse(_createHouseModel);
              })
            : _pageModel?.houseInfo?.auditStatus == houseAuditWaiting //待审核显示编辑按钮
                ? StadiumSolidButton('编辑', onTap: () {
                    navigatorKey.currentState.push<bool>(MaterialPageRoute(builder: (context) {
                      return HouseAuthPage(
                        createHouseModel: CreateHouseModel(
                          projectId: _pageModel?.houseInfo?.projectId,
                          formerName: _pageModel?.houseInfo?.formerName,
                          houseId: _pageModel?.houseInfo?.houseId,
                          houseAddr:
                              '${_pageModel?.houseInfo?.buildName ?? ''}${_pageModel?.houseInfo?.unitName ?? ''}${_pageModel?.houseInfo?.houseNo ?? ''}',
                          authType: _pageModel?.houseInfo?.custType,
                          name: _pageModel?.houseInfo?.custName,
                          documentType: _pageModel?.houseInfo?.idTypeId,
                          documentNo: _pageModel?.houseInfo?.custIdNum,
                          customerType: _pageModel?.houseInfo?.custProper,
                          houseCustAuditId: _pageModel?.houseInfo?.houseCustAuditId,
                        ),
                        //如果是游客则认定为首次认证
                        houseAuthType:
                            stateModel.customerType == 1 ? HouseAuthType.FirstAuth : HouseAuthType.ReAuth,
                      );
                    })).then((bool value) {
                      if (value != null && value) {
//                      if(widget.callback != null) widget.callback();
                        navigatorKey.currentState.pop(true);
                      }
                    });
//        stateModel.createHouse(_createHouseModel);
                  })
                : null,
      );
    });
  }
}

class HouseDetailPageModel {
//  HouseDetail houseDetail = HouseDetail();
  HouseInfo houseInfo = HouseInfo();
  List<MemberInfo> memberList = List();
  ListState pageState = ListState.HINT_LOADING;
  ListState memberPageState = ListState.HINT_LOADING;
}
