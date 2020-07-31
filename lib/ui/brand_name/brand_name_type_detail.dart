import 'package:cmp_customer/models/brand_name_obj.dart';
import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/ui/brand_name/brand_name_ui.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_image_display.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/parking/parking_card_ui.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class BrandNameTypeDetail extends StatefulWidget {
  List<SettingList> infos;
  Function callback;

  BrandNameTypeDetail(this.infos, this.callback);

  @override
  _BrandNameTypeDetailState createState() => _BrandNameTypeDetailState();
}

class _BrandNameTypeDetailState extends State<BrandNameTypeDetail>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController =
        new TabController(length: widget.infos.length, vsync: this);
  }

  List<Widget> getTab() {
    List<Widget> list = new List();
    widget.infos.forEach((info) {
      list.add(new Tab(
        text: info.settingTitle,
      ));
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
        length: 2,
        child: new CommonScaffold(
          bottomNavigationBar: Visibility(
            visible: widget.infos != null && widget.infos.length > 1,
            child: StadiumSolidButton(
              '确认方案',
              onTap: () {
                if (widget.callback != null) {
                  widget.callback(_tabController.index);
                  Navigate.closePage(true);
                }
              },
            ),
          ),
          appTitle: widget.infos != null && widget.infos.length > 1?"选择方案":'方案详情',
          tabBar: TabBar(
            tabs: getTab(),
            indicatorSize: TabBarIndicatorSize.label,
            controller: _tabController,
          ),
//          appBarActions: <Widget>[
//            Builder(builder: (context) {
//              return IconButton(
//                icon: UIData.iconFilter,
//                onPressed: () {
//                  Scaffold.of(context).openEndDrawer();
//                },
//              );
//            })
//          ],
//              endDrawerWidget: ChangeOfTitleScreenPage(callback: (Map map) {
//                parammMap.clear();
//                parammMap.addAll(map);
//                _model.loadHistoryList(new PropertyChangeUserParam(
//                    queryType: queryType,
//                    startTime: map['startDate'],
//                    endTime: map['endDate'],
//                    status: map['state'])
//                );
//              },),
          bodyData: _buildBody(),
        ));
  }

  Widget _buildBody() {
    return TabBarView(
      children: _getTabPage(),
      controller: _tabController,
    );
  }

  List<Widget> _getTabPage() {
    List<Widget> widgetList = List();
    widget.infos.forEach((info) {
      widgetList.add(_buildContent(info));
    });
    return widgetList;
  }

  Widget _buildContent(
    SettingList info,
  ) {
    return SingleChildScrollView(
      child: Column(children: <Widget>[
        Container(
            color: UIData.primaryColor,
            padding: EdgeInsets.only(bottom: UIData.spaceSize12),
            child: Column(children: <Widget>[
              leftTextWidget(isBold: true,fontSize: UIData.spaceSize16,
                  text: info.settingTyepName, topSpacing: UIData.spaceSize12),
              leftTextWidget(
                  text: info.settingDesc, topSpacing: UIData.spaceSize12),
            ])),
        Container(
            color: UIData.primaryColor,
            margin: EdgeInsets.only(top: UIData.spaceSize12),
            padding: EdgeInsets.symmetric(vertical: UIData.spaceSize12),
            child: Column(
              children: <Widget>[
                leftTextWidget(
                  text: '效果样板',
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: UIData.spaceSize12,horizontal: UIData.spaceSize16),
                  child: CommonImageDisplay(photoIdList: getFileList(info)),
                ),
              ],
            )),
        Visibility(
          visible: info.markPrice != null,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: UIData.spaceSize12),
            margin: EdgeInsets.only(top: UIData.spaceSize12),
            color: Colors.white,
            child: Column(
              children: <Widget>[
                labelTextWidget(
                  label: '制作单价',
                  unit: "元",
                  color: UIData.orangeColor,
                  text: info.markPrice?.toString() ?? '',

                )
              ],
            ),
          ),
        ),
      ]),
    );
  }

  List<String> getFileList(SettingList info) {
    List<String> strs = new List();
    if (info.photoAttList != null) {
      info.photoAttList.forEach((info) {
        strs.add(info.attachmentUuid);
      });
    }

    return strs;
  }
}
