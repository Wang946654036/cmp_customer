import 'package:cmp_customer/models/hot_work_record_model.dart';
import 'package:cmp_customer/models/response/check_in_history_response.dart';
import 'package:cmp_customer/models/response/decoration_pass_card_details_response.dart';
import 'package:cmp_customer/scoped_models/check_in_model/check_in_history_state_model.dart';
import 'package:cmp_customer/scoped_models/decoration/decoration_pass_card_history_state_model.dart';
import 'package:cmp_customer/strings/strings_hot_work.dart';
import 'package:cmp_customer/ui/check_in/check_in_details.dart';
import 'package:cmp_customer/ui/check_in/check_in_screen.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_loadmore.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_shadow_container.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/decoration/decoration_pass_card_details.dart';
import 'package:cmp_customer/ui/parking/parking_card_ui.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scoped_model/scoped_model.dart';

import 'decoration_pass_card_label.dart';
import 'decoration_pass_card_status.dart';

//申请记录
/// [customerType] 查询类型，业主查询租户申请：0，查询自己的申请：1
class DecorationPassCardHistoryPage extends StatefulWidget {
  final int customerType;
  DecorationPassCardHistoryPage(this.customerType);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DecorationPassCardHistory();
  }
}

class _DecorationPassCardHistory extends State<DecorationPassCardHistoryPage> {
  DecorationPassCardHistoryStateModel _stateModel;
  ScrollController _loadMoreScrollController;

  @override
  void initState() {
    super.initState();
    if (_stateModel == null) {
      _stateModel = new DecorationPassCardHistoryStateModel();
      _stateModel.setCustomerType(widget.customerType);
    }
    if (_loadMoreScrollController == null) {
      _loadMoreScrollController = new ScrollController();
      _loadMoreScrollController.addListener(() {
        if (_loadMoreScrollController.position.pixels ==
            _loadMoreScrollController.position.maxScrollExtent) {
          if (_stateModel.listState != ListState.HINT_LOADING) {
            _stateModel.quoteRecordHandleLoadMore();
          }
        }
      });
    }
    _stateModel.loadHistoryList();
  }

  @override
  void dispose() {
    super.dispose();
    if (_loadMoreScrollController != null) _loadMoreScrollController.dispose();
  }

  Widget _buildContent() {
    return ScopedModelDescendant<DecorationPassCardHistoryStateModel>(
      builder: (context, child, model) {
        return CommonLoadContainer(
          state: model.listState,
          callback: (){
            _stateModel.historyHandleRefresh(preRefresh: true);
          },
          content: _buildList(),
        );
      },
    );
  }

  ///
  /// item卡片
  ///
  Widget _buildCard(DecorationPassCardDetails info) {
    return CommonShadowContainer(
      padding: EdgeInsets.all(UIData.spaceSize16),
      margin: EdgeInsets.only(left: UIData.spaceSize16, right: UIData.spaceSize16, top: UIData.spaceSize12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            //第一行申请人和状态
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                  child: CommonText.darkGrey16Text("${info?.custName ?? ''}-${info?.custPhone ?? ''}")),
              //申请人和电话
//              状态，按照状态情况显示不同颜色
              CommonText.text12(info?.stateString??"",
                  color: getStateColor(info?.state) ?? UIData.lightGreyColor)
            ],
          ),
          SizedBox(height: UIData.spaceSize8),
          //第二行，房屋
          CommonText.darkGrey15Text('${info?.formerName ?? ''}${info?.houseName ?? ''}'),
          SizedBox(height: UIData.spaceSize8),
          //第三行，申请时间
          CommonText.lightGrey12Text('${info?.createDate ?? ''}'),
        ],
      ),
      onTap: () {
        Navigate.toNewPage(DecorationPassCardDetailsPage(info?.id,widget.customerType),callBack: (data) {
          _stateModel.historyHandleRefresh(preRefresh: true);
        });
      },
    );
  }

  Widget _buildList() {
    return ScopedModelDescendant<DecorationPassCardHistoryStateModel>(
        builder: (context, child, model) {
      return RefreshIndicator(
          child: ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            controller: _loadMoreScrollController,
            itemCount: (model?.historyList?.length ?? 0) + 1,
            itemBuilder: (BuildContext context, int index) {
              if (model.historyList.length == index) {
                return CommonLoadMore(model.maxCount);
              } else {
                return _buildCard(model.historyList[index]);
              }
            },
          ),
          onRefresh: model.historyHandleRefresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<DecorationPassCardHistoryStateModel>(
      model: _stateModel,
      child: _buildContent()
    );
  }
}
