import 'package:azlistview/azlistview.dart';
import 'package:cmp_customer/models/city_model.dart';
import 'package:cmp_customer/models/common/common_page_model.dart';
import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_text_field.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class Choice {
  const Choice({this.title});

  final String title;
}

class CitySelector extends StatefulWidget {
  String cityName;
  CitySelector(this.cityName);
  @override
  CitySelectorState createState() => CitySelectorState();
}

class CitySelectorState extends State<CitySelector> {
  List<Choice> choices;
  int _suspensionHeight = 40;
  int _itemHeight = 60;
  FocusNode _focusNode = FocusNode();
  int _listOrSearchIndex = 0; //显示列表：0， 显示搜索：1，搜索框有内容：2
  final TextEditingController _searchController = new TextEditingController();

  @override
  void initState() {
    super.initState();
//    MainStateModel.of(context).loadCityData();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          _listOrSearchIndex = 1;
        });
      } else {
        setState(() {
          _listOrSearchIndex = 0;
        });
        Future.delayed(Duration(milliseconds: 10)).whenComplete(() {
          _searchController.text = '';
        });
      }
    });
  }

  Widget _buildHeader() {
    return ScopedModelDescendant<MainStateModel>(
        builder: (context, widget, model) {
      return Container(
        color: UIData.primaryColor,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 10,
              color: UIData.scaffoldBgColor,
            ),
            Container(
              height: 40,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: UIData.spaceSize16),
              child: CommonText.darkGrey14Text("热门城市"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(width: UIData.spaceSize16,),
                Expanded(
                  child: _buildHotCityItem(model.cityHotList[0])
                ),
                SizedBox(
                  width: UIData.spaceSize10,
                ),
                Expanded(
                  child: _buildHotCityItem(model.cityHotList[1])
                ),
                SizedBox(
                  width: UIData.spaceSize10,
                ),
                Expanded(
                  child: _buildHotCityItem(model.cityHotList[2])
                ),
                SizedBox(
                  width: 50,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(width: UIData.spaceSize16,),
                Expanded(
                  child: _buildHotCityItem(model.cityHotList[3])
                ),
                SizedBox(
                  width: UIData.spaceSize10,
                ),
                Expanded(
                  child: _buildHotCityItem(model.cityHotList[4])
                ),
                SizedBox(
                  width: UIData.spaceSize10,
                ),
                Expanded(
                  child: _buildHotCityItem(model.cityHotList[5])
                ),
                SizedBox(width: 50,)
              ],
            ),
            Container(
              height: 40,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: UIData.spaceSize16),
              child: CommonText.darkGrey14Text("更多城市"),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildHotCityItem(CityInfo cityInfo){
    return GestureDetector(
      onTap: (){
        Navigate.closePage(cityInfo);
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: UIData.dividerColor),
            borderRadius: BorderRadius.circular(5)),
        height: 35,
        alignment: Alignment.center,
        child: CommonText.darkGrey16Text(cityInfo.name),
      ),
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

  Widget _buildListItem(CityInfo cityInfo) {
    String susTag = cityInfo.getSuspensionTag();
    return ScopedModelDescendant<MainStateModel>(
        builder: (context, widget, model) {
      return Column(
        children: <Widget>[
          Offstage(
            offstage: cityInfo.isShowSuspension != true,
            child: _buildSusWidget(susTag),
          ),
          Container(
            height: _itemHeight.toDouble(),
            color: UIData.primaryColor,
            padding: EdgeInsets.only(right: 16.0),
            child: ListTile(
              title: Text(
                cityInfo.name,
                style: TextStyle(
                    fontSize: UIData.fontSize16, color: UIData.darkGreyColor),
              ),
              onTap: () {
                Navigate.closePage(cityInfo);
              },
            ),
          ),
        ],
      );
    });
  }

  Widget _buildList() {
    return ScopedModelDescendant<MainStateModel>(
        builder: (context, widget, model) {
      return Column(
        children: <Widget>[
          Container(
            height: 40,
            child: CommonSingleInputRow(
              "当前城市：",
              content: CommonText.text16(this.widget.cityName??"未知", color: UIData.themeBgColor),
              arrowVisible: false,
            ),
          ),
          Expanded(
              flex: 1,
              child: AzListView(
                data: model.cityAllList,
                itemBuilder: (context, cityInfo) => _buildListItem(cityInfo),
                suspensionWidget: _buildSusWidget(model.suspensionTag),
                isUseRealIndex: true,
                itemHeight: _itemHeight,
                suspensionHeight: _suspensionHeight,
                onSusTagChanged: model.onSusTagChanged,
                header: AzListViewHeader(
                    tag: "热门",
                    height: 180,
                    builder: (context) {
                      return _buildHeader();
                    }),
                indexHintBuilder: (context, hint) {
                  LogUtils.printLog('hint:$hint');
                  return Container(
                    alignment: Alignment.center,
                    width: 80.0,
                    height: 80.0,
                    decoration: BoxDecoration(
                        color: Colors.black54, shape: BoxShape.circle),
                    child: Text(hint,
                        style: TextStyle(color: Colors.white, fontSize: 30.0)),
                  );
                },
              )),
        ],
      );
    });
  }

  Widget _buildContent() {
    return ScopedModelDescendant<MainStateModel>(
      builder: (context, widget, model) {
        return CommonScaffold(
          showLeftButton: _listOrSearchIndex == 0 ? true : false,
          appTitle: "选择城市",
          appBarActions: _listOrSearchIndex != 0
              ? [
                  GestureDetector(
                    child: Container(
                      padding: EdgeInsets.only(right: 8.0),
                      alignment: Alignment.center,
                      child: CommonText.white16Text('取消'),
                    ),
                    onTap: () {
                      setState(() {
//                            _listOrSearchIndex = 0;
                        _focusNode.unfocus();
//                            FocusScope.of(context).requestFocus(new FocusNode());
                      });
                    },
                  ),
                ]
              : null,
          bodyData: Stack(
//                index: _listOrSearchIndex,
            children: <Widget>[
              _buildList(),
              _buildSearchContent(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSearchContent() {
    return Offstage(
        offstage: _listOrSearchIndex == 0 ? true : false,
        child: _buildSearchList());
  }

  Widget _buildSearchList() {
    if (_listOrSearchIndex == 1) {
      return Container(
        color: UIData.opacity50BlackColor,
      );
    } else if (_listOrSearchIndex == 2) {
      return Container(
        color: UIData.themeBgColor,
        child: ScopedModelDescendant<MainStateModel>(
            builder: (context, child, model) {
          List<Widget> listWidget = List();
          model.searchCityList.forEach((CityInfo cityInfo) {
            var listTile = ListTile(
              title: Text(
                cityInfo.name,
                style: TextStyle(
                    fontSize: UIData.fontSize16, color: UIData.darkGreyColor),
              ),
              subtitle: Text(
                cityInfo.subName,
                style: TextStyle(
                    fontSize: UIData.fontSize14, color: UIData.lightGreyColor),
              ),
              onTap: () {
                LogUtils.printLog("OnItemClick: $cityInfo");
                Navigator.of(context).pop();
              },
            );
            listWidget.add(listTile);
          });
          var divideList =
              ListTile.divideTiles(context: context, tiles: listWidget)
                  .toList();
          return ListView(
            children: divideList,
          );
        }),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainStateModel>(
        builder: (context, widget, model) {
      return _buildContent();
    });
  }
}
