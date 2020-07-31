import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/common/common_page_model.dart';
import 'package:cmp_customer/models/house_list_model.dart';
import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/house_authentication/select_house_content.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:scoped_model/scoped_model.dart';

///
/// 选择房号
///
class SelectHousePage extends StatefulWidget {
  final int id;
  final String name;

  SelectHousePage(this.id, this.name);

  @override
  _SelectHousePageState createState() => _SelectHousePageState();
}

class _SelectHousePageState extends State<SelectHousePage> {
  HouseAddrPageModel _pageModel = HouseAddrPageModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageModel.titleList.add(widget.name);
    stateModel.getHouseList(widget.id, _pageModel);
  }

  ///
  ///  顶部导航条
  ///
  Widget _buildTop() {
    return Container(
      color: UIData.primaryColor,
//      height: ScreenUtil.getInstance().setHeight(50),
      margin: EdgeInsets.only(bottom: UIData.spaceSize8),
      alignment: Alignment.centerLeft,
      child: ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
        return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize16),
            itemCount: _pageModel?.titleList?.length ?? 0,
//                shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              String title = _pageModel.titleList[index] ?? '';
              return Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Visibility(
                      //第一个以外的前面加箭头
                      visible: index > 0,
                      child: Icon(
                        Icons.keyboard_arrow_right,
                        color: UIData.lighterGreyColor,
                      )),
                  GestureDetector(
                    child: Center(
                        //任务标题导航文字，能返回的蓝色，最后一个深灰色
                        child: index == _pageModel.titleList.length - 1
                            ? CommonText.darkGrey15Text(title)
                            : CommonText.red15Text(title)),
                    onTap: () {
                      //点击返回到对应页面
                      if (index < _pageModel.titleList.length - 1) {
                        setState(() {
                          _pageModel.titleList.removeRange(index + 1, _pageModel.titleList.length);
                          _pageModel.dataList.removeRange(index + 1, _pageModel.dataList.length);
                          _pageModel.contentPageList.removeRange(index + 1, _pageModel.contentPageList.length);
                          switch(index){
                            case 0:
                              _pageModel.houseAddrType = HouseAddrType.Building;
                              break;
                            case 1:
                              _pageModel.houseAddrType = HouseAddrType.Unit;
                              break;
                          }
                        });
                      }
                    },
                  )
                ],
              );
            });
      }),
    );
  }

  _refreshData() {
//    MainStateModel.of(context).taskDetailCreate = false;
    stateModel.getHouseList(widget.id, _pageModel);
  }

  Widget _buildBody() {
    return ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
      return CommonLoadContainer(
          state: _pageModel.houseListState,
          callback: _refreshData,
          content: Stack(
            children: _pageModel.contentPageList,
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
      return CommonScaffold(
        appTitle: '选择房号',
        tabBar: _buildTop(),
        tabBarBackgroundColor: UIData.scaffoldBgColor,
        bodyData: _buildBody(),
        popBack: () => navigatorKey.currentState.pop(null),
      );
    });
  }
}

///
/// 房屋地址分类
///
enum HouseAddrType {
  Building, //楼栋
  Unit, //单元
  Room, //房号
}

///
/// 选择楼栋-单元-房号对象
///
class HouseAddrPageModel {
  List<SelectHouseContent> contentPageList = List();
  List<List<HouseAddr>> dataList = List();
  List<String> titleList = List();
  ListState houseListState = ListState.HINT_LOADING;
  bool houseListCreate = true;
  HouseAddrType houseAddrType = HouseAddrType.Building;
  HouseAddrModel houseAddrModel = HouseAddrModel();
}

///
/// 选择房屋地址后用来回调给页面的对象
///
class HouseAddrModel {
  int buildingId;
  String buildingName;
  int unitId;
  String unitName;
  int roomId;
  String roomName;
}
