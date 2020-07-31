import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/common/common_page_model.dart';
import 'package:cmp_customer/models/office_cancel_lease_record_model.dart';
import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/strings/strings_office_cancel_lease.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_loadmore.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_shadow_container.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/office_cancel_lease/office_cancel_lease_detail_page.dart';
import 'package:cmp_customer/ui/office_cancel_lease/office_cancel_lease_record_filter.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

///
/// 写字楼退租申请记录列表
///
class OfficeCancelLeaseRecordPage extends StatefulWidget {
  @override
  _OfficeCancelLeaseRecordPageState createState() => _OfficeCancelLeaseRecordPageState();
}

class _OfficeCancelLeaseRecordPageState extends State<OfficeCancelLeaseRecordPage>{
  ListPageModel _listPageModel = ListPageModel();
  ScrollController _loadMoreScrollController = new ScrollController();
  OfficeCancelLeaseFilterModel _filterModel = OfficeCancelLeaseFilterModel();

  @override
  void initState() {
    super.initState();
    _loadMoreScrollController.addListener(() {
      if (_loadMoreScrollController.position.pixels == _loadMoreScrollController.position.maxScrollExtent) {
        if (_listPageModel.listPage.listState != ListState.HINT_LOADING) {
//          stateModel.customerNotVisitedHandleLoadMore(_listPageModel, widget.task?.id);
        }
      }
    });
    _handleRefresh();
//    stateModel.loadCustomerNotVisitedList(_listPageModel, widget.task?.id);

  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _handleRefresh({bool preRefresh = false}) async {
    stateModel.loadOfficeCancelLeaseRecordList(_listPageModel, _filterModel, preRefresh: preRefresh);
  }

  ///
  /// item卡片
  ///
  Widget _buildCard(OfficeCancelLeaseInfo info) {
    return CommonShadowContainer(
      padding: EdgeInsets.all(UIData.spaceSize16),
      margin: EdgeInsets.only(left: UIData.spaceSize16, right: UIData.spaceSize16, bottom: UIData.spaceSize16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            //第一行，左边楼栋和房号， 右边是申请状态
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(child: CommonText.darkGrey16Text(info?.submitHouse ?? '')), //楼栋和房号
              SizedBox(width: UIData.spaceSize4),
              //状态，按照状态情况显示不同颜色
              CommonText.text12(officeCancelLeaseStatusMap[info?.status],
                  color: officeCancelLeaseStatusToColorMap[info?.status] ?? UIData.yellowColor)
            ],
          ),
          SizedBox(height: UIData.spaceSize8),
          //第二行，申请时间
          CommonText.lightGrey12Text(info?.createTime ?? ''),
        ],
      ),
      onTap: () {
        Navigate.toNewPage(OfficeCancelLeaseDetailPage(info?.officeSurrenderId, callback: () {
          _handleRefresh(preRefresh: true);
        }));
      },
    );
  }

  Widget _buildList() {
    return RefreshIndicator(
        child: ListView.builder(
            shrinkWrap: true,
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: UIData.spaceSize16),
            controller: _loadMoreScrollController,
            itemCount: (_listPageModel?.list?.length ?? 0) + 1,
            itemBuilder: (context, index) {
              if (_listPageModel?.list?.length == index) {
                return CommonLoadMore(_listPageModel.listPage.maxCount);
              } else {
                OfficeCancelLeaseInfo info = _listPageModel?.list[index];
                return _buildCard(info);
              }
            }),
        onRefresh: _handleRefresh);
  }


  Widget _buildBody(){
    return ScopedModelDescendant<MainStateModel>(builder: (context, child, model){
      return CommonLoadContainer(
        state: _listPageModel.listPage.listState,
//        state: ListState.HINT_DISMISS,//测试数据
        content: _buildList(),
        callback: () => _handleRefresh(preRefresh: true),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appTitle: '我的申请',
      appBarActions: <Widget>[
        Builder(builder: (context) {
          return IconButton(
            icon: UIData.iconFilter,
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
          );
        })
      ],
      endDrawerWidget: OfficeCancelLeaseRecordFilter(_filterModel, callback: () {
//            _startTime = startTime;
//            _endTime = endTime;
//            _reasonList = reasonList;
//            _statusList = statusList;
        _handleRefresh(preRefresh: true);
      }),
      bodyData: _buildBody(),
    );
  }
}

class OfficeCancelLeaseFilterModel {
  List<String> statusList = List(); //状态列表
  String startTime; //开始时间
  String endTime; //结束时间
}