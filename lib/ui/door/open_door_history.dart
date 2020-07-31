import 'package:cmp_customer/models/response/door_history_response.dart';
import 'package:cmp_customer/scoped_models/door_model/open_history_state_model.dart';
import 'package:cmp_customer/scoped_models/parking_model/parking_history_state_model.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_loadmore.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_shadow_container.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/parking/parking_card_ui.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scoped_model/scoped_model.dart';

//开门历史记录
class OpenDoorHistoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => OpenDoorHistory();
}

class OpenDoorHistory extends State<OpenDoorHistoryPage>{
  OpenDoorHistoryModel _historyModel = new OpenDoorHistoryModel();
  ScrollController _loadMoreScrollController = new ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadMoreScrollController.addListener(() {
      if (_loadMoreScrollController.position.pixels ==
          _loadMoreScrollController.position.maxScrollExtent) {
        if (_historyModel.historyListState != ListState.HINT_LOADING) {
          _historyModel.quoteRecordHandleLoadMore();
        }
      }
    });
    _historyModel.loadHistoryList(preRefresh:true);
  }




  @override
  void dispose() {
    super.dispose();
    if (_loadMoreScrollController != null) _loadMoreScrollController.dispose();
  }


  Widget _buildList() {
    return ScopedModelDescendant<OpenDoorHistoryModel>(
        builder: (context, child, model) {
          return RefreshIndicator(
              child: ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  controller: _loadMoreScrollController,
                  itemCount: (model?.listData?.length ?? 0) + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (model.listData.length == index) {
                      return CommonLoadMore(model.maxCount);
                    } else {
                      DoorList info=model?.listData[index];
                      return CommonShadowContainer(
                            margin: EdgeInsets.only(
                                top: card_spacing,
                                left: left_spacing,
                                right: right_spacing),
                            backgroundColor: Colors.white,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                            left: left_spacing,
                                            top: top_spacing,
                                          ),
                                          child: CommonText.darkGrey15Text((info.projectLocalName??"")+" - "+(info.gateName??""))
                                          ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        margin: EdgeInsets.only(
                                            left: left_spacing,
                                            top:
                                            ScreenUtil.getInstance().setHeight(5),
                                            bottom: bottom_spacing),
                                        child: CommonText.lightGrey12Text(
                                            info.createTime ?? ""),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      right: right_spacing, top: top_spacing),
                                  child: CommonText.darkGrey12Text(_getOpenResultName(info.result??"")),
                                  ),
                              ],
                            ),
                          );
                    }
                  }),
              onRefresh: model.historyHandleRefresh);
        });
  }
  //创建控件
  Widget _buildContent() {
    return ScopedModelDescendant<OpenDoorHistoryModel>(
      builder: (context, child, model) {
        return CommonLoadContainer(
          state: _historyModel.historyListState,
          callback: (){
            _historyModel.loadHistoryList();
          },
          content: _buildList(),

        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModel<OpenDoorHistoryModel>(
        model: _historyModel,
        child: CommonScaffold(
          appTitle: "开门记录",
          bodyData: _buildContent(),
        ));
  }

  //开门的结果
  _getOpenResultName(String result){
    if(result=="0"){
      return "待返回";
    }else if(result=="1"){
      return "成功";
    }else if(result=="2"){
      return "失败";
    }else{
      return "";
    }
  }
}
