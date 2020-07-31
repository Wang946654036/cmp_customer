
import 'package:cmp_customer/models/pgc/pgc_infomation_obj.dart';
import 'package:cmp_customer/models/response/topic_list_response.dart';
import 'package:cmp_customer/models/response/winning_record_response.dart';
import 'package:cmp_customer/scoped_models/collect/topic_list_model.dart';
import 'package:cmp_customer/scoped_models/pgc_model/pgc_infomation_model.dart';
import 'package:cmp_customer/scoped_models/winning_record_state_model.dart';
import 'package:cmp_customer/ui/collect/topic_item.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_loadmore.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_text_field.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/pgc/pgc_infomation/pgc_infomation_item.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

//中奖记录
class WinningRecordPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ListState();
  }
}

class _ListState extends State<WinningRecordPage> {
  ScrollController _loadMoreScrollController = new ScrollController();

  WinningRecordListModel _model;
  Map<String, dynamic> searchParams;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _model = WinningRecordListModel();
    _loadMoreScrollController.addListener(() {
      if (_loadMoreScrollController.position.pixels ==
          _loadMoreScrollController.position.maxScrollExtent) {
        if (_model.listState != ListState.HINT_LOADING) {
          _model.listHandleLoadMore(map: searchParams);
        }
      }
    });
    searchParams = new Map();
    _refresh();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModel<WinningRecordListModel>(
      model: _model,
      child: CommonScaffold(
          appTitle: "中奖记录",
          bodyData: Column(
            children: <Widget>[
              CommonSearchBar(onSearch: (String text){
                searchParams["winningOrActivity"]= text?.trim();
                _refresh();
              },hintText: "请输入奖品名称/活动名称",),
              Expanded(
                child: buildList(),
              )
            ],
          ),
      ),
    );
  }



  Widget buildList() {
    return ScopedModelDescendant<WinningRecordListModel>(
      builder: (context, child, model) {
        return CommonLoadContainer(
            state: _model.listState,
            content: _buildList(),
            callback: (){
              _refresh();
            });
      },
    );
  }

  Future<void> _refresh() async{
      _model.listHistoryHandleRefresh(preRefresh: true,map: searchParams);
  }

  Widget _buildList() {
    return ScopedModelDescendant<WinningRecordListModel>(
        builder: (context, child, model) {
          return RefreshIndicator(
            child: ListView.builder(
              controller: _loadMoreScrollController,
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: (model.list?.length ?? 0) + 1,
              itemBuilder: (BuildContext context, int index) {
                if (model.list?.length == index) {
                  return CommonLoadMore(model.maxCount);
                } else {
                  WinningRecord info = model.list[index];
                  return _buildItem(info);

                }
              },
            ),
            onRefresh: _refresh ,
          );
        });
  }

  Widget _buildItem(WinningRecord info){
    return Container(
        color: Colors.white,
        margin: EdgeInsets.only(top: UIData.spaceSize8),
        padding: EdgeInsets.symmetric(
            vertical: UIData.spaceSize12, horizontal: UIData.spaceSize16),
        child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(bottom: UIData.spaceSize4,left: UIData.spaceSize4),
                          child: CommonText.black16Text('所属活动：${info?.activityName}',
                              textAlign: TextAlign.left),
                        ),
                      ),
                      Container(
                        child: CommonText.text16(info?.sendStatus=="1"?"已发放":"未发放",color: info?.sendStatus=="1"?UIData.greenColor:UIData.orangeColor),
                      )
                    ],
                  ),Container(
                    margin: EdgeInsets.only(bottom: UIData.spaceSize4,left: UIData.spaceSize4),
                    child: CommonText.black16Text('奖品名称：${info?.prizeName}',
                        textAlign: TextAlign.left),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: UIData.spaceSize4,left: UIData.spaceSize4),
                    child: CommonText.lighterGrey12Text('${info?.winningTime}',
                        textAlign: TextAlign.left),
                  ),
                ],

      ));
  }

}
