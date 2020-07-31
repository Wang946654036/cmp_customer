import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/common/common_page_model.dart';
import 'package:cmp_customer/models/hot_work_record_model.dart';
import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/strings/strings_hot_work.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_loadmore.dart';
import 'package:cmp_customer/ui/common/common_shadow_container.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/hot_work/hot_work_detail_page.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

///
/// 动火记录列表内容
/// [customerType] 查询类型，业主查询租户申请：0，查询自己的申请：1
///
class HotWorkListContent extends StatefulWidget {
  final int customerType;

  HotWorkListContent(this.customerType);

  @override
  _HotWorkListContentState createState() => _HotWorkListContentState();
}

class _HotWorkListContentState extends State<HotWorkListContent> with AutomaticKeepAliveClientMixin {
  ListPageModel _listPageModel = ListPageModel();
  ScrollController _loadMoreScrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    _loadMoreScrollController.addListener(() {
      if (_loadMoreScrollController.position.pixels == _loadMoreScrollController.position.maxScrollExtent) {
        if (_listPageModel.listPage.listState != ListState.HINT_LOADING) {
//          stateModel.hotWorkRecordHandleLoadMore(_listPageModel, _filterModel);
          stateModel.hotWorkRecordHandleLoadMore(_listPageModel, widget.customerType);
        }
      }
    });
    _handleRefresh();
//    stateModel.loadHotWorkRecordList(_listPageModel);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  Future<void> _handleRefresh({bool preRefresh = false}) async {
//    stateModel.loadHotWorkRecordList(_listPageModel, _filterModel, preRefresh: preRefresh);
    stateModel.loadHotWorkRecordList(_listPageModel, widget.customerType, preRefresh: preRefresh);
  }

  ///
  /// item卡片
  ///
  Widget _buildCard(HotWorkInfo info) {
    return CommonShadowContainer(
      padding: EdgeInsets.all(UIData.spaceSize16),
      margin: EdgeInsets.only(left: UIData.spaceSize16, right: UIData.spaceSize16, bottom: UIData.spaceSize16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            //第一行申请人和状态
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                  child: CommonText.darkGrey16Text("${info?.customerName ?? ''}-${info?.customerPhone ?? ''}")),
              //申请人和电话
//              状态，按照状态情况显示不同颜色
              CommonText.text12(info?.processStateName,
                  color: hotWorkStatusToColorMap[info?.processState] ?? UIData.yellowColor)
            ],
          ),
          SizedBox(height: UIData.spaceSize8),
          //第二行，房屋
          CommonText.darkGrey15Text('${info?.formerName ?? ''}${info?.houseName ?? ''}'),
          SizedBox(height: UIData.spaceSize8),
          //第三行，申请时间
          CommonText.lightGrey12Text('${info?.createTime ?? ''}'),
        ],
      ),
      onTap: () {
        Navigate.toNewPage(HotWorkDetailPage(info?.hotWorkId, customerType: widget.customerType),
            callBack: (bool value) {
          if (value != null && value is bool && value) _handleRefresh(preRefresh: true);
        });
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
//            itemCount: 5, //测试数据
            itemBuilder: (context, index) {
              if (_listPageModel?.list?.length == index) {
                return CommonLoadMore(_listPageModel.listPage.maxCount);
              } else {
                HotWorkInfo info = _listPageModel?.list[index];
                return _buildCard(info);
              }
            }),
        onRefresh: _handleRefresh);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
      return CommonLoadContainer(
        state: _listPageModel.listPage.listState,
//        state: ListState.HINT_DISMISS, //测试数据
        content: _buildList(),
        callback: () => _handleRefresh(preRefresh: true),
      );
    });
  }
}
