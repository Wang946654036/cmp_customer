import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/common/common_page_model.dart';
import 'package:cmp_customer/models/community_certified_model.dart';
import 'package:cmp_customer/models/uncertified_community_model.dart';
import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/ui/common/common_dialog.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/me/community_search_page.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/shared_preferences_key.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:scoped_model/scoped_model.dart';

///
/// 社区管理（选择社区）
///
class CommunitySelectionPage extends StatefulWidget {
  @override
  _CommunitySelectionPageState createState() => _CommunitySelectionPageState();
}

class _CommunitySelectionPageState extends State<CommunitySelectionPage> {
  ListPageModel _listPageModel = ListPageModel();

//  bool _uncertifiedDefault = false; //判断是否未认证社区为默认值

//  List<UncertifiedCommunity> _uncertifiedCommunityList;

  @override
  void initState() {
    super.initState();
//    _getUncertifiedCommunity();
    _refreshData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _refreshData() {
    //客户才调用获取已认证房屋的接口
//    if (stateModel.customerType == 2)
    stateModel.getCommunityCertifiedList(_listPageModel,
        callBack: ({String errorMsg}) async {
      //判断是否未认证社区为默认社区，先判断未认证社区
      if (stateModel.uncertifiedCommunityList != null &&
          stateModel.uncertifiedCommunityList.length > 0) {
        for (int i = stateModel.uncertifiedCommunityList.length - 1;
            i >= 0;
            i--) {
          UncertifiedCommunity uncertifiedCommunity =
              stateModel.uncertifiedCommunityList[i];
          CommunityCertified info = _listPageModel?.list?.firstWhere(
              (data) => data.projectId == uncertifiedCommunity.projectId,
              orElse: () => null);
          if (info != null) {
            stateModel.uncertifiedCommunityList.remove(uncertifiedCommunity);
          } else {
            if (uncertifiedCommunity.isDefault)
              stateModel.uncertifiedDefault = true;
          }
        }
      }
//        _listPageModel.list.forEach((data) {
//          CommunityCertified info = data;
//          for (int i = stateModel.uncertifiedCommunityList.length - 1; i > -1; i--) {
//            UncertifiedCommunity community = stateModel.uncertifiedCommunityList[i];
//            if (community.projectId == info.projectId) {
//              if(community.isDefault) stateModel.changeDefaultCommunity(community.projectId);
//              stateModel.uncertifiedCommunityList.removeAt(i);
//            }
//          }
//        });
//        SharedPreferences prefs = await SharedPreferencesKey.globalPrefs;
//        prefs.setString(SharedPreferencesKey.KEY_UNCERTIFIED_COMMUNITY,
//            json.encode(UncertifiedCommunityModel(uncertifiedCommunityList: stateModel.uncertifiedCommunityList)));
    });
  }

//  //获取本地缓存的未认证社区列表
//  _getUncertifiedCommunity() async {
//    SharedPreferences prefs = await SharedPreferencesKey.globalPrefs;
//    String jsonCommunity = prefs.getString(SharedPreferencesKey.KEY_UNCERTIFIED_COMMUNITY);
//    if (jsonCommunity != null && jsonCommunity.isNotEmpty) {
//      UncertifiedCommunityModel model = UncertifiedCommunityModel();
//      model = UncertifiedCommunityModel.fromJson(json.decode(jsonCommunity));
//      if (model.uncertifiedCommunityList != null && model.uncertifiedCommunityList.length > 0) {
//        _uncertifiedCommunityList = model.uncertifiedCommunityList;
//      }
//    }
//    setState(() {});
//  }

  //更换默认社区
  void _changeDefaultCommunity(CommunityCertified data) {
    stateModel.changeDefaultCommunity(data?.projectId, callBack: () {
      stateModel.setUncertifiedCommunityFalse();
      stateModel.uncertifiedDefault = false;
      _refreshData();
      stateModel.reLogin();
//                            stateModel.clearAccessToken();
//                            stateModel.getUserData();
    });
  }

  Widget _buildList() {
    return ListView(
      shrinkWrap: true,
      primary: false,
      children: <Widget>[
        Visibility(
            visible:
                _listPageModel?.list != null && _listPageModel.list.length > 0,
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: UIData.spaceSize8, horizontal: UIData.spaceSize16),
              child: CommonText.lightGrey14Text('已认证社区'),
            )),
        //已认证房屋列表
        ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
//            primary: false,
            itemBuilder: (context, index) {
              CommunityCertified data = _listPageModel?.list[index];
              return Slidable(
                key: new Key(index.toString()),
                delegate: SlidableBehindDelegate(),
//        actionExtentRatio: 0.25,
                child: Container(
                  color: UIData.primaryColor,
                  child: ListTile(
                    title: CommonText.darkGrey15Text(data?.formerName ?? ''),
                    trailing: data?.isDefaultProject == '1' &&
                            !stateModel.uncertifiedDefault
                        ? UIData.iconTick
                        : null,
                    onTap: () {
                      if (data.isDefaultProject == '0' ||
                          stateModel.uncertifiedDefault) {
                        //不是默认的才弹框
                        CommonDialog.showAlertDialog(context,
                            content: '确认更换“${data?.formerName}”为默认社区？',
                            onConfirm: () {
                          _changeDefaultCommunity(data);
                        });
                      }
                    },
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return CommonDivider();
            },
            itemCount: _listPageModel?.list?.length ?? 0),
//        Visibility(
//            visible: _listPageModel.list != null && _listPageModel.list.length > 0,
//            child: SizedBox(height: UIData.spaceSize16)),
        Visibility(
            visible: stateModel.uncertifiedCommunityList != null &&
                stateModel.uncertifiedCommunityList.length > 0,
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: UIData.spaceSize8, horizontal: UIData.spaceSize16),
              child: CommonText.lightGrey12Text('未认证社区'),
            )),
        //未认证房屋列表，缓存在本地
        ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
//            primary: false,
            itemBuilder: (context, index) {
              UncertifiedCommunity data =
                  stateModel.uncertifiedCommunityList[index];
              return Slidable(
                key: new Key(index.toString()),
                delegate: SlidableScrollDelegate(),
                actionExtentRatio: 0.25,
                child: Container(
                  color: UIData.primaryColor,
                  child: ListTile(
                    title: CommonText.darkGrey15Text(data?.formerName ?? ''),
                    trailing: data.isDefault ? UIData.iconTick : null,
                    onTap: () {
                      if (!data.isDefault) {
                        CommonDialog.showAlertDialog(context,
                            content: '确认更换“${data?.formerName}”为默认社区？',
                            onConfirm: () async{
                              SharedPreferences prefs = await SharedPreferencesKey.globalPrefs;
                          setState(() {
                            stateModel.setUncertifiedCommunityFalse();
                            stateModel.defaultProjectId = data?.projectId;
                            prefs.setInt(SharedPreferencesKey.KEY_PROJECT_ID, stateModel.defaultProjectId);
                            stateModel.defaultProjectName = data?.formerName;
                            stateModel.defaultBuildingName = null;
                            stateModel.defaultUnitName = null;
                            stateModel.defaultHouseName = null;
                            stateModel.defaultHouseId = null;
//                            stateModel.customerType = 1;
                            stateModel.uncertifiedDefault = true;
                            data.isDefault = true;
                            stateModel.saveUnCertifiedCommunity();
                            stateModel.reloadUsedDoor();
                            stateModel.getMarketListOnHomePage();
                            stateModel.getPgcInformationListOnHomePage();
                            stateModel.getCommunityActivityListOnHomePage();
                            stateModel.getVoteListOnHomePage();
                            stateModel.getQuestionnaireListOnHomePage();
                            stateModel.getBanner();
                          });

//                          stateModel.changeDefaultCommunity(data?.projectId, callBack: () {
//                            _refreshData();
//                            stateModel.getUserData();
//                          });
                        });
                      }
                    },
                  ),
                ),
                secondaryActions: <Widget>[
                  new IconSlideAction(
                    caption: '删除',
                    color: Colors.red,
                    icon: Icons.delete,
                    closeOnTap: true,
                    onTap: () {
                      setState(() {
                        //已认证社区为0并且未认证社区只剩一个的时候不可删除最后一个社区
                        if ((_listPageModel.list == null ||
                                _listPageModel.list.length == 0) &&
                            stateModel.uncertifiedCommunityList.length == 1) {
                          CommonToast.show(
                              msg: '最少保留一个社区', type: ToastIconType.INFO);
                        } else if (data.isDefault) {
                          CommonToast.show(
                              msg: '不能删除默认社区', type: ToastIconType.INFO);
                        } else {
                          setState(() {
                            stateModel.uncertifiedCommunityList.removeAt(index);
                            stateModel.saveUnCertifiedCommunity();
                          });
                        }
                      });
                    },
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) {
              return CommonDivider();
            },
            itemCount: stateModel.uncertifiedCommunityList?.length ?? 0)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainStateModel>(
        builder: (context, child, model) {
      return CommonScaffold(
        appTitle: '社区管理',
        appBarActions: [
          IconButton(
              icon: Icon(Icons.add, color: UIData.darkGreyColor),
              onPressed: () {
                Navigate.toNewPage(CommunitySearchPage(
                    callback: (int projectId, String formerName) {
                  CommunityCertified communityCertified = _listPageModel?.list
                      ?.firstWhere((data) => data?.projectId == projectId,
                          orElse: () => null);
                  UncertifiedCommunity unCertifiedCommunity =
                      model.uncertifiedCommunityList?.firstWhere(
                          (UncertifiedCommunity unCommunity) =>
                              unCommunity?.projectId == projectId,
                          orElse: () => null);
                  if (communityCertified == null &&
                      unCertifiedCommunity == null) {
                    setState(() {
                      UncertifiedCommunity community = UncertifiedCommunity();
                      community.projectId = projectId;
                      community.formerName = formerName;
                      community.isDefault = false;
                      if (model.uncertifiedCommunityList == null)
                        model.uncertifiedCommunityList = List();
                      model.uncertifiedCommunityList.add(community);
                      model.saveUnCertifiedCommunity();
                    });
                  }
//                  if (data != null) {
//                    if (data.isDefaultProject == '1' && !stateModel.uncertifiedDefault) {
//                      //选中的社区为默认社区并且未认证社区没有默认社区，代表选中的社区即默认社区，不做任何操作
////                      Navigate.closePage();
//                    } else if (data.isDefaultProject == '1' && stateModel.uncertifiedDefault) {
//                      //选中的社区为默认社区并且未认证社区有默认社区，把未认证社区的默认值去掉
//                      stateModel.setUncertifiedCommunityFalse();
//                      stateModel.uncertifiedDefault = false;
//                      stateModel.reLogin();
//                    } else {
//                      _changeDefaultCommunity(data);
//                    }
//                  } else {
//                    stateModel.uncertifiedDefault = true;
//                    stateModel.setUncertifiedCommunity(projectId, formerName);
//                    stateModel.getUserData();
//                  }
                }));
              })
        ],
        bodyData: CommonLoadContainer(
//          state: stateModel.uncertifiedCommunityList != null && stateModel.uncertifiedCommunityList.length > 0
//              ? ListState.HINT_DISMISS
//              : stateModel.customerType == 1 ? ListState.HINT_NO_DATA_CLICK : _listPageModel.listPage.listState,
          //判断是否为游客，如果是游客并且未认证社区列表为空则显示暂无数据，如果是游客并且未认证社区列表不为空则显示未认证社区里列表，
          //如果是客户则按照加载状态来显示
          state: stateModel.customerType == 1
              ? (stateModel.uncertifiedCommunityList != null &&
                      stateModel.uncertifiedCommunityList.length > 0)
                  ? ListState.HINT_DISMISS
                  : ListState.HINT_NO_DATA_CLICK
              : _listPageModel.listPage.listState,
          content: _buildList(),
          callback: _refreshData,
        ),
      );
    });
  }
}
