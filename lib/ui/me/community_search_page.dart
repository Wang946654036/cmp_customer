import 'package:amap_base_location/amap_base_location.dart';
import 'package:azlistview/azlistview.dart';
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/city_model.dart';
import 'package:cmp_customer/models/common/common_page_model.dart';
import 'package:cmp_customer/models/project_model.dart';
import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_list_refresh.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_loadmore.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_text_field.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/permission_util.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scoped_model/scoped_model.dart';

import 'city_selector.dart';

///
/// 社区搜索
/// [callback]回调项目id:projectId和项目名称projectName
///
class CommunitySearchPage extends StatefulWidget {
  final Function callback;

  CommunitySearchPage({this.callback});

  @override
  _CommunitySearchPageState createState() => _CommunitySearchPageState();
}

class _CommunitySearchPageState extends State<CommunitySearchPage> {
//  ScrollController _loadMoreScrollController = new ScrollController();
  ListPageModel _listPageModel = ListPageModel();
  int _tipIndex = 0;
  String _keyword;

  int _suspensionHeight = 40;
  int _itemHeight = 60;
  String _suspensionTag = "";
  CityInfo _cityInfo;

  @override
  void initState() {
    super.initState();
    _initLocation();
//    _handleRefresh();
//    _loadMoreScrollController.addListener(() {
//      if (_loadMoreScrollController.position.pixels ==
//          _loadMoreScrollController.position.maxScrollExtent) {
//        if (_listPageModel.listPage.listState != ListState.HINT_LOADING) {
//          stateModel.searchProjectHandleLoadMore(_listPageModel,
//              keyword: _keyword);
//        }
//      }
//    });
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _tipIndex = 1;
    });
    stateModel.searchProject(
        pageModel: _listPageModel,
        keyword: _keyword,
        preRefresh: true,
        cityCode: _cityInfo?.code);
  }

  Widget _buildList() {
    List<ProjectInfo> _list = stateModel.projectInfoList;
    if(_list!=null&&_list.isNotEmpty && _suspensionTag.isEmpty){
      _suspensionTag = _list[0].tagIndex;//默认第一个，否则会不显示
    }
    return AzListView(
      data: _list,
      itemBuilder: (context, info) => _buildListItem(info),
      suspensionWidget: _buildSusWidget(_suspensionTag),
      isUseRealIndex: true,
      itemHeight: _itemHeight,
      suspensionHeight: _suspensionHeight,
      onSusTagChanged: _onSusTagChanged,
//      header: AzListViewHeader(
//          tag: "",
//          height: 1,
//          builder: (context) {
//            return Divider(height: 0,);
//          }),
      indexHintBuilder: (context, hint) {
        if (StringsHelper.isEmpty(hint)) {
          return Container();
        } else {
          return Container(
            alignment: Alignment.center,
            width: 80.0,
            height: 80.0,
            decoration:
                BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
            child: Text(hint,
                style: TextStyle(color: Colors.white, fontSize: 30.0)),
          );
        }
      },
    );
//    return RefreshIndicator(child: ListView.separated(
//        shrinkWrap: true,
//        physics: AlwaysScrollableScrollPhysics(),
//        controller: _loadMoreScrollController,
//        itemCount: (_listPageModel?.list?.length ?? 0) + 1,
//        itemBuilder: (context, index) {
//          if (_listPageModel?.list?.length == index) {
//            return CommonLoadMore(_listPageModel.listPage.maxCount);
//          } else {
//            ProjectInfo info = _listPageModel?.list[index];
//            return Container(
//                color: UIData.primaryColor,
//                child: ListTile(
//                    title: CommonText.darkGrey15Text(info?.formerName ?? ''),
//                    onTap: () {
//                      if (widget.callback != null) widget.callback(info?.projectId, info?.formerName);
//                      navigatorKey.currentState.pop();
//                    }));
//          }
//        },
//        separatorBuilder: (context, index) {
//          return CommonDivider();
//        }), onRefresh: ()=>_handleRefresh());
  }

  Widget _buildListItem(ProjectInfo info) {
    String susTag = info.getSuspensionTag();
    return Column(
      children: <Widget>[
        Offstage(
          offstage: info.isShowSuspension != true,
          child: _buildSusWidget(susTag),
        ),
        Container(
            height: _itemHeight.toDouble(),
            color: UIData.primaryColor,
            child: ListTile(
                title: CommonText.darkGrey15Text(info?.formerName ?? ''),
                onTap: () {
                  if (widget.callback != null)
                    widget.callback(info?.projectId, info?.formerName);
                  navigatorKey.currentState.pop();
                }))
      ],
    );
  }

  Widget _buildSusWidget(String susTag) {
    return Container(
      height: _suspensionHeight.toDouble(),
      padding: const EdgeInsets.only(left: 16.0),
      color: Color(0xfff3f4f5),
      alignment: Alignment.centerLeft,
      child: Text(
        '$susTag',
        softWrap: false,
        style: TextStyle(
          fontSize: 14.0,
          color: Color(0xff999999),
        ),
      ),
    );
  }

  void _onSusTagChanged(String tag) {
    setState(() {
      _suspensionTag = tag;
    });
  }

  ///
  /// 提示选择社区
  ///
  Widget _buildTip() {
    if(StringsHelper.isEmpty(_cityInfo?.code)){
      return CommonListRefresh(
        state: ListState.HINT_NO_DATA_CLICK,
        callBack: (){
          _initLocation(showToast: true);
        },
      );
    }else{
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              UIData.imageTouristNoRecord,
              fit: BoxFit.fitWidth,
              width: ScreenUtil.getInstance().setWidth(135),
            ),
            SizedBox(height: UIData.spaceSize16),
            CommonText.lightGrey15Text('请输入社区名称或选择城市进行查询'),
            SizedBox(height: UIData.spaceSize48),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appTitle: '选择社区',
      bodyData: Column(
        children: <Widget>[
          CommonSearchBar(
            hintText: '请输入社区名称',
            onSearch: (String keyword) {
              FocusScope.of(context).requestFocus(FocusNode());
              setState(() {
                _keyword = keyword.trim();
              });
              if (StringsHelper.isEmpty(_keyword) &&
                  StringsHelper.isEmpty(_cityInfo?.code)) {
                CommonToast.show(type: ToastIconType.INFO, msg: "请输入社区名称进行搜索");
              } else {
                _handleRefresh();
              }
            },
          ),
          Expanded(
              child: IndexedStack(
            index: _tipIndex,
            sizing: StackFit.expand,
            children: <Widget>[
              _buildTip(),
              ScopedModelDescendant<MainStateModel>(
                  builder: (context, child, model) {
                return CommonLoadContainer(
                  state: _listPageModel.listPage.listState,
                  content: _buildList(),
                  callback: () {
                    _handleRefresh();
                  },
                );
              }),
            ],
          ))
        ],
      ),
      appBarActions: [
        FlatButton(
          child: Row(
            children: <Widget>[
              Icon(
                Icons.location_on,
                color: UIData.themeBgColor,
                size: 20,
              ),
              CommonText.red14Text(_cityInfo?.name ?? "未知"),
            ],
          ),
          onPressed: () {
            Navigate.toNewPage(CitySelector(_cityInfo?.name), callBack: (cityInfo) {
              if (cityInfo!=null&& cityInfo is CityInfo) {
                setState(() {
                  _cityInfo = cityInfo;
                  _handleRefresh();
                });
              }
            });
          },
        )
      ],
    );
  }

  //定位
  void _initLocation({bool showToast = false}) async {
    PermissionUtil.requestPermission([PermissionGroup.location],
        callback: (bool isGranted) async {
      if (isGranted) {
        AMapLocation _mapLocation = new AMapLocation();
        await _mapLocation.init();
        _mapLocation
            .getLocation(LocationClientOptions(
                isOnceLocation: true,
                locatingWithReGeocode: true,
                isNeedAddress: true))
            .then((Location location) {
          if (location != null && location.city != null) {
            int length=stateModel.cityAllList.length;
            for(int i=0;i<length;i++){
              if(stateModel.cityAllList[i].name == location.city){
                setState(() {
                  _cityInfo = CityInfo(code: stateModel.cityAllList[i].code,name: stateModel.cityAllList[i].name);
                  _handleRefresh();
                });
              }
            }
          }
        });
      } else {
        if(showToast)
          CommonToast.show(msg: '请前往设置开启APP地理位置访问权限', type: ToastIconType.INFO);
      }
    });
  }
}
