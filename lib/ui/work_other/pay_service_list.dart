import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/pay_service_info_list.dart';
import 'package:cmp_customer/scoped_models/work_others_pay_model.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_loadmore.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_shadow_container.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/work_other/pay_service_history_list.dart';
import 'package:cmp_customer/ui/work_other/work_other_ui.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

///有偿服务列表
class PayServiceWorkOtherListPage extends StatefulWidget {
//  WorkOtherMainType complaintType;
  WorkOtherSubType cominSubType;
  List<WorkOtherSubType> workOtherSubTypeList;

  PayServiceWorkOtherListPage(this.cominSubType, this.workOtherSubTypeList);

  @override
  _ComplainHistoryPageState createState() =>
      new _ComplainHistoryPageState(workOtherSubTypeList);
}

class _ComplainHistoryPageState extends State<PayServiceWorkOtherListPage>  with SingleTickerProviderStateMixin {
//  WorkOtherMainType complaintType;

  WorkOthersPayModel model;

  TabController mController;

  Map<WorkOtherSubType,ScrollController> _loadMoreScrollControllers = new Map();

  _ComplainHistoryPageState(List<WorkOtherSubType> workOtherSubTypeList){
    model = new WorkOthersPayModel(list:workOtherSubTypeList);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    model.cleanWorkOthersPayModel();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < widget.workOtherSubTypeList.length; i++) {

      WorkOtherSubType type = widget.workOtherSubTypeList[i];
      model.payServiceInfoPayListHandleRefresh(type);
      ScrollController _loadMoreScrollController = new ScrollController();
      _loadMoreScrollController.addListener(() {
        if (_loadMoreScrollController.position.pixels == _loadMoreScrollController.position.maxScrollExtent) {
          if (model.payAdapterMap[type].payServiceInfoListLoadState != ListState.HINT_LOADING) {
            model.payServiceInfoPayHandleLoadMore(type);
          }
        }
      });
      _loadMoreScrollControllers.addAll({type:_loadMoreScrollController});
    }

    mController = TabController(
      initialIndex: widget.workOtherSubTypeList.indexOf(widget.cominSubType),
      length: widget.workOtherSubTypeList.length,
      vsync: this,
    );

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return DefaultTabController(
      length: widget.workOtherSubTypeList.length,
      child: CommonScaffold(
        appTitle: pay_service,
        appBarActions: [_buildAction()],
        tabBar: _buildTabBar(),
        bodyData: _buildBody(),
      ),
    );
  }

  _buildTabBar() {
    return Container(
      color: UIData.primaryColor,
      child: TabBar(
        controller: mController,
          isScrollable: true,
          indicator: UnderlineTabIndicator(
              borderSide: BorderSide(width: 4.0, color: UIData.redGradient2),
              insets: EdgeInsets.symmetric(horizontal: UIData.spaceSize30*2)),
//            indicatorSize: TabBarIndicatorSize.values,
//            indicatorColor: UIData.themeBgColor,
//            indicatorWeight: 4.0,
          labelStyle: CommonText.darkGrey15TextStyle(),
          tabs: _getTabLabel()),
    );
  }

  List<Widget> _getTabLabel() {
    List<Widget> widgetList = List();
    widget.workOtherSubTypeList.forEach((WorkOtherSubType type) {
      widgetList.add(Tab(

          text: getSubTitle(type)));
    });
    return widgetList;
  }

  ///
  Widget _buildAction() {
    return
//      Padding(
//      padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize16),
//      child:
    IconButton(icon:  UIData.iconMore2, onPressed: (){_goToHistory();});

//      GestureDetector(
//        onTap:(){_goToHistory();} ,
//        child: UIData.iconMore2,
//      ),
//    );
  }

  List<Widget> _getTabPage() {
    List<Widget> widgetList = List();
    widget.workOtherSubTypeList.forEach((workOtherSubType) {
      widgetList.add(_buildContent(workOtherSubType));
    });
    return widgetList;
  }

  Widget _buildContent(WorkOtherSubType type,) {
    return ScopedModel<WorkOthersPayModel>(
        model: model,
        child: ScopedModelDescendant<WorkOthersPayModel>(
          builder: (context, child, model) {

           return CommonLoadContainer(state: model.payAdapterMap[type].payServiceInfoListLoadState,
           content: _buildList(type),
           callback: ()=>_refresh(type));
          },
        ));
  }

  Widget _buildBody() {
    return TabBarView(controller:mController,children: _getTabPage());
  }

  Future<void>  _refresh(WorkOtherSubType type) {
    model.loadWorkOthersPayListList(type,preRefresh: true);
  }

  Widget _buildList(WorkOtherSubType type) {
      return
        RefreshIndicator(
          onRefresh: (){_refresh(type);},
          child:
          ListView.separated(
            physics: AlwaysScrollableScrollPhysics(),
            controller: _loadMoreScrollControllers[type],
        separatorBuilder: (BuildContext context, int index) =>
            new CommonFullScaleDivider(),
        itemCount: model.payAdapterMap[type].payServiceInfos.length+1,
        itemBuilder: (BuildContext context, int index) {

          if (model.payAdapterMap[type].payServiceInfos?.length == index) {
            return CommonLoadMore(model.payAdapterMap[type].historyMaxCount);
          }

          PayServiceInfo info = model.payAdapterMap[type].payServiceInfos[index];
          return CommonShadowContainer(
            child: PayServiceCard(info),
          );
        },
          ),
      );
  }



  _goToHistory() {

    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return PayServiceHistoryPage();    }));
  }
}
