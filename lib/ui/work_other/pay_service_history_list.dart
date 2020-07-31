import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/work_other_list.dart';
import 'package:cmp_customer/models/work_other_obj.dart';
import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/ui/common/common_loadmore.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/work_other/complaint_detail_page.dart';
import 'package:cmp_customer/ui/work_other/work_other_ui.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_shadow_container.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/utils/ui_data.dart';

///有偿服务历史
class PayServiceHistoryPage extends StatefulWidget {


  PayServiceHistoryPage();

@override
_PayServiceHistoryPageState createState() => new _PayServiceHistoryPageState();

}

class _PayServiceHistoryPageState extends State<PayServiceHistoryPage>  {

  WorkOtherMainType complaintType = WorkOtherMainType.Paid;
  ScrollController _loadMoreScrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new CommonScaffold(
        appTitle: getTitle(complaintType,1),
        bodyData: _buildContent());
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    stateModel.cleanWorkOthersListModel();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stateModel.workOtherHistoryHandleRefresh('Paid');


    _loadMoreScrollController.addListener(() {
      if (_loadMoreScrollController.position.pixels ==
          _loadMoreScrollController.position.maxScrollExtent) {
        if (stateModel.workOtherListLoadState != ListState.HINT_LOADING) {
          stateModel
              .workOtherHandleLoadMore(getWorkOtherMainTypeStr(complaintType));
        }
      }
    });

  }

  Widget _buildContent() {
    return ScopedModelDescendant<MainStateModel>(
      builder: (context, child, model) {
        return CommonLoadContainer(state: model.workOtherListLoadState,
            content: _buildList(),
            callback: ()=>_refresh());
      },
    );
  }

  Future _refresh() {
    MainStateModel.of(context)
        .workOtherHistoryHandleRefresh('Paid', preRefresh: true);
  }

  Widget _buildList() {
    return ScopedModelDescendant<MainStateModel>(
        builder: (context, child, model) {
          return
        RefreshIndicator(
          onRefresh: _refresh,

          child:
            ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              controller: _loadMoreScrollController,
              itemCount: model.workOthers.length+1,
              itemBuilder: (BuildContext context, int index) {

                if (model.workOthers?.length == index) {
                  return CommonLoadMore(model.historyMaxCount);
                }

                WorkOther info = model.workOthers[index];

                return CommonShadowContainer(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {

                      return ComplaintDetailPage('Paid',info.workOrderId);
                    }));
                  },
                  margin: EdgeInsets.only(
                      top: UIData.spaceSize12, left: UIData.spaceSize16, right: UIData.spaceSize16),
                  padding: EdgeInsets.all(UIData.spaceSize16),
                  child: Container(
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    CommonText.black16Text(info.serviceSubTypeName),
                                    SizedBox(
                                      height: UIData.spaceSize12,
                                    ),
                                    CommonText.lightGrey14Text(appointment_time+'${info.appointmentTime}'),

                                  ],
                                ),
                              ),
                          Container(
                            margin: EdgeInsets.only(top:UIData.spaceSize2),
                            padding: EdgeInsets.symmetric(
                                vertical: UIData.spaceSize2,
                                horizontal: UIData.spaceSize4),
                            color: info.hasEvaluate=='1'?Color(0x1FFF9200):Colors.white,
                            child: info.hasEvaluate=='1'?CommonText.lighterYellow12Text('待评价'):info.hasCancel=='1'?CommonText.lightGrey12Text('已撤单'):(info.hasFinish=='2'?CommonText.lightGrey12Text('已完成'):(info.hasDone=='2')?CommonText.lighterYellow12Text('已完工'):CommonText.lighterYellow12Text('待完工')),
                          ),
                        ],
                      ),
                    ),
                );
              },
          ),
            );
        });
  }

}