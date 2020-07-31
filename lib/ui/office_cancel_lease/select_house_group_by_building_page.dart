import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';

///
/// 指定项目底下的房屋列表（以楼栋为分组）
///
class SelectHouseGroupByBuildingPage extends StatefulWidget {
  final List<HouseInfo> houseList;
  final Function callback;

  SelectHouseGroupByBuildingPage(this.houseList, {this.callback});

  @override
  _SelectHouseGroupByBuildingPageState createState() => _SelectHouseGroupByBuildingPageState();
}

class _SelectHouseGroupByBuildingPageState extends State<SelectHouseGroupByBuildingPage> {
  List<HouseInfo> _houseList;

  @override
  void initState() {
    super.initState();
    _houseList = widget.houseList;
//    LogUtils.printLog('排序前：${_houseList.map((HouseInfo info) => info.buildId)}');
    _houseList.sort((a, b) => a.buildId.compareTo(b.buildId));
//    _houseList = widget.houseList;
//    LogUtils.printLog('排序后：${_houseList.map((HouseInfo info) => info.buildId)}');
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildBody() {
    return Container(
      color: UIData.primaryColor,
      child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            HouseInfo info = _houseList[index];
            return Column(
              children: <Widget>[
                (index == 0) || (index > 0 && _houseList[index - 1].buildId != info.buildId)
                    ? Container(
                        color: UIData.dividerColor,
                        child: ListTile(
                          dense: true,
                          title: CommonText.darkGrey15Text(info?.buildName ?? ''),
                          trailing: Checkbox(
                              value: _houseList
                                          .where((HouseInfo houseInfo) => houseInfo.buildId == info.buildId)
                                          .every((HouseInfo houseInfo) => houseInfo.selected ?? false),
                              onChanged: (bool check) {
//                      LogUtils.printLog('check:$check');
                                setState(() {
                                  _houseList
                                      .where((HouseInfo houseInfo) => houseInfo.buildId == info.buildId)
                                      .forEach((HouseInfo info) {
                                    info.selected = check;
                                  });
//                                  info.selected = check;
//                      stateModel.mainRefresh();
                                });
                              }),
                        ),
                      )
                    : Container(),
                ListTile(
                  title: CommonText.darkGrey15Text('${info?.unitName ?? ''}${info?.houseNo ?? ''}'),
                  trailing: Checkbox(
                      value: info.selected ?? false,
                      onChanged: (bool check) {
//                      LogUtils.printLog('check:$check');
                        setState(() {
                          info.selected = check;
//                      stateModel.mainRefresh();
                        });
                      }),
                  onTap: () => navigatorKey.currentState.pop(info),
                )
              ],
            );
          },
          separatorBuilder: (context, index) {
            return CommonDivider();
          },
          itemCount: _houseList.length),
    );
  }

  Widget _buildBottomNavigationBar(){
    List<HouseInfo> houseList = _houseList.where((HouseInfo houseInfo)=> houseInfo.selected ?? false).toList();
    return Container(
      color: UIData.primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: UIData.spaceSize16),
            child: CommonText.text15('已选（${houseList.length}）',
                color: houseList.length > 0
                    ? UIData.themeBgColor
                    : UIData.lightGreyColor),
          ),
          FlatButton(
              onPressed: () {
                if (houseList.length > 0 && widget.callback != null) widget.callback(houseList);
                navigatorKey.currentState.pop();
              },
              child: CommonText.text15('完成',
                  color: houseList.length > 0
                      ? UIData.themeBgColor
                      : UIData.lightGreyColor))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appTitle: '房屋选择',
      bodyData: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}
