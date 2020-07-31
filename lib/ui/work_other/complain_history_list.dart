import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/work_other_obj.dart';
import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_loadmore.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_shadow_container.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/work_other/complaint_detail_page.dart';
import 'package:cmp_customer/ui/work_other/work_other_ui.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ComplainHistoryPage extends StatefulWidget {
  WorkOtherMainType complaintType;

  ComplainHistoryPage(this.complaintType);

  @override
  _ComplainHistoryPageState createState() =>
      new _ComplainHistoryPageState(complaintType);
}

class _ComplainHistoryPageState extends State<ComplainHistoryPage> {
  ScrollController _loadMoreScrollController = new ScrollController();
  WorkOtherMainType complaintType;

  _ComplainHistoryPageState(this.complaintType);
GlobalKey<ComplaintDetailPageState> detailKey = new GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stateModel
        .workOtherHistoryHandleRefresh(getWorkOtherMainTypeStr(complaintType));
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    stateModel.cleanWorkOthersListModel();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new CommonScaffold(
        appTitle: getTitle(complaintType, 1),
//        appBarActions: [
////          GestureDetector(
////            onTap: () {
////              Navigator.of(context).pop();
////            },
////            child: UIData.iconAdd,
////          ),
////          SizedBox(
////            width: UIData.spaceSize16,
////          )
////        ],
        bodyData: _buildContent());
  }

  Widget _buildContent() {
    return ScopedModelDescendant<MainStateModel>(
      builder: (context, child, model) {
        return CommonLoadContainer(
          state: model.workOtherListLoadState,
          callback: _refresh,
          content: _buildList(),
        );
      },
    );
  }

  refresh() async {
    MainStateModel.of(context).workOtherHistoryHandleRefresh(
        getWorkOtherMainTypeStr(complaintType),
        preRefresh: true);
  }

  Future _refresh() {
    MainStateModel.of(context).workOtherHistoryHandleRefresh(
        getWorkOtherMainTypeStr(complaintType),
        preRefresh: true);
  }

  Widget _buildList() {
    return ScopedModelDescendant<MainStateModel>(
        builder: (context, child, model) {
      return RefreshIndicator(
        onRefresh: _refresh,
        child: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          controller: _loadMoreScrollController,
          itemCount: model.workOthers.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (model.workOthers?.length == index) {
              return CommonLoadMore(model.historyMaxCount);
            } else {
              WorkOther info = model.workOthers[index];
              WorkOtherStateType workOtherStateType;
              if (info?.hasEvaluate != null && info?.hasEvaluate == '1') {
                workOtherStateType = WorkOtherStateType.can_rate;
              } else if (info?.hasFinish != null && info?.hasFinish == '2') {
                workOtherStateType = WorkOtherStateType.finished;
              } else if (info?.hasDone != null && info?.hasDone == '2') {
                workOtherStateType = WorkOtherStateType.worked;
              } else if (info?.hasAccept != null && info?.hasAccept == '2') {
                workOtherStateType = WorkOtherStateType.accepted;
              } else {
                workOtherStateType = WorkOtherStateType.accepting;
              }
              if (info?.hasCancel != null && info?.hasCancel == '1') {
                workOtherStateType = WorkOtherStateType.cancel;
              }
              if (info?.hasClose != null && info?.hasClose == '2') {
                workOtherStateType = WorkOtherStateType.closed;
              }
              if (info?.hasPaid != null && info?.hasPaid == '1') {
                workOtherStateType = WorkOtherStateType.can_pay;
              }
              return GestureDetector(
                child: CommonShadowContainer(
                  margin: EdgeInsets.symmetric(
                      vertical: UIData.spaceSize12,
                      horizontal: UIData.spaceSize16),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return ComplaintDetailPage(
                            info?.serviceType, info?.workOrderId);
                      }));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ///订单号、待评价、返工单
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(
                              top: UIData.spaceSize16,
                              bottom: UIData.spaceSize12,
                              right: UIData.spaceSize16,
                              left: UIData.spaceSize16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  CommonText.grey12Text(
                                      '工单号：${info?.workOrderCode ?? ''}',
                                      ),
                                  Visibility(
                                    visible: info?.hasRework != null &&
                                        info?.hasRework == '2',
                                    child: Container(
                                        margin: EdgeInsets.only(
                                            left: UIData.spaceSize8),
                                        padding: EdgeInsets.symmetric(
                                            vertical: UIData.spaceSize1,
                                            horizontal: UIData.spaceSize4),
                                        decoration: ShapeDecoration(
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                  color: UIData.dividerColor,
                                                  width: 1,
                                                  style: BorderStyle.solid),
                                              borderRadius: BorderRadius.zero),
                                        ),
                                        child:
                                            CommonText.lighterGrey12Text('返工')),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,children: <Widget>[ Visibility(
                                  visible: info?.hasEvaluate != null &&
                                      info?.hasEvaluate == '1',
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: UIData.spaceSize2,
                                        horizontal: UIData.spaceSize4),
                                    color: Color(0x1FFF9200),
                                    child:
                                    CommonText.lighterYellow12Text(state_can_rat),
                                  )),
                              Visibility(
                                visible: info?.hasCancel != null &&
                                    info?.hasCancel == '1',
                                child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: UIData.spaceSize1,
                                        horizontal: UIData.spaceSize4),
                                    decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: UIData.dividerColor,
                                              width: 1,
                                              style: BorderStyle.solid),
                                          borderRadius: BorderRadius.zero),
                                    ),
                                    child:
                                    CommonText.lighterGrey12Text(state_cance)),
                              ),
                              Visibility(
                                visible: info?.hasClose != null &&
                                    info?.hasClose == '2',
                                child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: UIData.spaceSize1,
                                        horizontal: UIData.spaceSize4),
                                    decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: UIData.dividerColor,
                                              width: 1,
                                              style: BorderStyle.solid),
                                          borderRadius: BorderRadius.zero),
                                    ),
                                    child:
                                    CommonText.lighterGrey12Text(state_close)),
                              ),],),

                            ],
                          ),
                        ),
                        CommonFullScaleDivider(),

                        ///状态信息
                        Visibility(visible: (info?.hasCancel != null &&
                            info?.hasCancel != '1')
                          //钱钱改：辉姐说这是关单标识，应该只有已撤单不显示节点
                          ///    @ApiModelProperty(value = "是否关单：0=未配置；1=可关单；2=已关单")
                          //    private String hasClose;
                          //	@ApiModelProperty(value = "是否撤单：0=未撤单；1=已撤单")
                          //	private String hasCancel;
                          //    @ApiModelProperty(value = "是否完结：0=未配置；1=未完结；2=已完结")
                          //    private String hasFinish;

//                            &&(info?.hasClose != null &&
//                            info?.hasClose != '1')
                          ,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(
                              top: UIData.spaceSize16,
                              left: UIData.spaceSize20,
                              right: UIData.spaceSize20),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(child: Container()),
                                        Container(
                                          height: UIData.spaceSize14,
                                          width: UIData.spaceSize14,
                                          child: Image.asset(
                                              info?.hasAccept == '2'||info?.hasFinish == '2'
                                                  ? UIData.iconRedCircle
                                                  : UIData.iconRedCircle2),
                                        ),
                                        Expanded(
                                            child: Container(
                                              color:info?.hasDone == '2'||info?.hasFinish == '2'
                                                  ?UIData.redColor:   UIData.lightestRedColor,
                                              height: 1,
                                            )),
                                      ],
                                    ),
                                    SizedBox(
                                      height: UIData.spaceSize8,
                                    ),
                                    info?.hasAccept == '2'||info?.hasFinish == '2'
                                        ? CommonText.grey14Text('受理')
                                        : CommonText.lightGrey14Text('待受理'),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                            child: Container(
                                              color: info?.hasDone == '2'||info?.hasFinish == '2'
                                                  ?UIData.redColor:   UIData.lightestRedColor,
                                              height: 1,
                                            )),
                                        Container(
                                          height: UIData.spaceSize14,
                                          width: UIData.spaceSize14,
                                          child: Image.asset(info?.hasDone == '2'||info?.hasFinish == '2'
                                              ? UIData.iconRedCircle
                                              : UIData.iconRedCircle2),
                                        ),
                                        Expanded(
                                            child: Container(
                                              color:info?.hasFinish == '2'
                                                  ?UIData.redColor:  UIData.lightestRedColor,
                                              height: 1,
                                            )),
                                      ],
                                    ),
                                    SizedBox(
                                      height: UIData.spaceSize8,
                                    ),
                                    info?.hasDone == '2'||info?.hasFinish == '2'
                                        ? CommonText.grey14Text('处理')
                                        : CommonText.lightGrey14Text('待处理'),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                            child: Container(
                                              color:info?.hasFinish == '2'
                                                  ? UIData.redColor: UIData.lightestRedColor,
                                              height: 1,
                                            )),
                                        Container(
                                          height: UIData.spaceSize14,
                                          width: UIData.spaceSize14,
                                          child: Image.asset(
                                              info?.hasFinish == '2'
                                                  ? UIData.iconRedCircle
                                                  : UIData.iconRedCircle2),
                                        ),
                                        Expanded(child: Container()),
                                      ],
                                    ),
                                    SizedBox(
                                      height: UIData.spaceSize8,
                                    ),
                                    info?.hasFinish == '2'
                                        ? CommonText.grey14Text('完成')
                                        : CommonText.lightGrey14Text('待完成'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),)
                        ,

                        ///播放按钮
//                        Visibility(
//                          visible: info?.hasVoice == '1',
//                          child: Container(
//                            margin: EdgeInsets.only(
//                              top: UIData.spaceSize12,
//                              left: UIData.spaceSize16,
//                            ),
//                            child: CommonAudioPlayer((
//                                info?.workOrderVoiceList?.length ?? 0) > 0
//                                    ? (info?.workOrderVoiceList[0] != null &&
//                                            info?.workOrderVoiceList[0]
//                                                .containsKey('uuid'))
//                                        ? info?.workOrderVoiceList[0]['uuid']
//                                        : '5cbfd318b38c9322d4eb82af'
//                                    : '5cbfd318b38c9322d4eb82af'),
//                          ),
//                        ),

                        ///内容
                        Visibility(
                          visible: info?.reportContent!=null,
                          child: Container(
                            margin: EdgeInsets.only(
                              top: UIData.spaceSize12,
                              left: UIData.spaceSize16,
                              right: UIData.spaceSize16
                            ),
                            child: CommonText.grey14Text(

                                getTitle(complaintType,-1) +
                                    '内容：${info?.reportContent??''}'),
                          ),
                        ),
                        Visibility(
                          visible: complaintType == WorkOtherMainType.Warning||complaintType == WorkOtherMainType.Repair,
                          child: Container(
                            margin: EdgeInsets.only(
                              top: UIData.spaceSize12,
                              left: UIData.spaceSize16,
                            ),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: UIData.spaceSize14,
                                  width: UIData.spaceSize14,
                                  child: Image.asset(UIData.imageLocation),
                                ),
                                SizedBox(
                                  width: UIData.spaceSize4,
                                ),
                                Expanded(child: CommonText.grey14Text(
                                    '${info?.customerAddress}'),)
                                ,
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: UIData.spaceSize16,
                              top: UIData.spaceSize12,
                              bottom: UIData.spaceSize16),
                          child: CommonText.lightGrey12Text(
                              "${info?.createTime}"),
                        )
                      ],
                    ),
                  ),

//                    Container(
//                      margin: EdgeInsets.only(
//                          right: right_spacing, top: top_spacing),
//                      child: Text(
//                        getStateText(index + 1),
//                        style: TextStyle(
//                            fontSize: UIData.fontSize12,
//                            color: (index + 1) == completed
//                                ? color_text_gray
//                                : color_text_orange),
//                      ),
//                    ),
                ),
                onTap: () {

                  Navigate.toNewPage(ComplaintDetailPage(
                      info?.serviceType, info?.workOrderId , key: detailKey,)
//                      ,callBack: (flag){ if(flag!=null&&flag){
//                    refresh();
//                  }
//                  }
                  );

//                  Navigator.of(context)
//                      .push(MaterialPageRoute(builder: ((context) {
//                    return ComplaintDetailPage(
//                        info?.serviceType, info?.workOrderId);
//                  }))).then((flag){
//
//                    if(flag){
//                      refresh();
//                    }
//                  });
                },
              );
            }
          },
        ),
      );
    });
  }
}
