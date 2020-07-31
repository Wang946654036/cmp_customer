import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/common/common_page_model.dart';
import 'package:cmp_customer/models/decoration_obj.dart';
import 'package:cmp_customer/models/message_center_model.dart';
import 'package:cmp_customer/models/pgc/pgc_comment_obj.dart';
import 'package:cmp_customer/scoped_models/decoration_model.dart';
import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/scoped_models/new_house_state_model.dart';
import 'package:cmp_customer/scoped_models/visitor_release_state_model.dart';
import 'package:cmp_customer/strings/strings_notice.dart';
import 'package:cmp_customer/ui/articles_release/articles_release_detail_page.dart';
import 'package:cmp_customer/ui/change_of_title/change_of_title_detail.dart';
import 'package:cmp_customer/ui/check_in/check_in_details.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_dot.dart';
import 'package:cmp_customer/ui/common/common_image_widget.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_loadmore.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/decorate_manager/decoration_permit/decoration_apply_detail_page.dart';
import 'package:cmp_customer/ui/decorate_manager/decoration_permit/decoration_apply_detail_tab.dart';
import 'package:cmp_customer/ui/decoration/decoration_pass_card_details.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_apply_audit.dart';
import 'package:cmp_customer/ui/entrance/entrance_card_details.dart';
import 'package:cmp_customer/ui/home/mall_msg_detail_page.dart';
import 'package:cmp_customer/ui/hot_work/hot_work_detail_page.dart';
import 'package:cmp_customer/ui/house_authentication/house_detail_page.dart';
import 'package:cmp_customer/ui/html/html_page.dart';
import 'package:cmp_customer/ui/market/market_detail.dart';
import 'package:cmp_customer/ui/new_house/new_house_detail_page.dart';
import 'package:cmp_customer/ui/office_cancel_lease/office_cancel_lease_detail_page.dart';
import 'package:cmp_customer/ui/parking/parking_card_details.dart';
import 'package:cmp_customer/ui/pgc/pgc_comment_page.dart';
import 'package:cmp_customer/ui/pgc/pgc_ui.dart';
import 'package:cmp_customer/ui/visitor_release/visitor_release_check.dart';
import 'package:cmp_customer/ui/visitor_release/visitor_release_detail.dart';
import 'package:cmp_customer/ui/work_other/complaint_detail_page.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/shared_preferences_key.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

///
/// 子类型消息列表
///
class MessageListContent extends StatefulWidget {
  final String messageType;
  final String messageSubType;
  final Function callback;
  final List<String> custSubMsgList;
  final List<String> appSubMsgList;

//
  MessageListContent(this.messageType,
      {Key key, this.messageSubType, this.custSubMsgList, this.appSubMsgList, this.callback})
      : super(key: key);

  @override
  MessageListContentState createState() => MessageListContentState();
}

class MessageListContentState extends State<MessageListContent> with AutomaticKeepAliveClientMixin {
  ListPageModel _listPageModel = ListPageModel();
  ScrollController _loadMoreScrollController = new ScrollController();
  bool _modify = false; //是否编辑状态，编辑才显示checkbox
  List<int> _ids = List(); //设置已读id数组

  @override
  void initState() {
    super.initState();
    handleRefresh();

    _loadMoreScrollController.addListener(() {
      if (_loadMoreScrollController.position.pixels == _loadMoreScrollController.position.maxScrollExtent) {
        if (_listPageModel.listPage.listState != ListState.HINT_LOADING) {
          stateModel.messageSubLoadMore(
            _listPageModel, messageType: widget.messageType,
            messageSubType: widget.messageSubType,
            custSubMsgList: widget.custSubMsgList,
            appSubMsgList: widget.appSubMsgList,
//              callback: () {
//            setState(() {
//              _modify = false;
//            });
//          }
          );
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  Future<void> handleRefresh({bool preRefresh = false, String messageSubType}) async {
    stateModel.loadMessageSubList(_listPageModel,
        messageType: widget.messageType,
        messageSubType: messageSubType ?? widget.messageSubType,
        custSubMsgList: widget.custSubMsgList,
        appSubMsgList: widget.appSubMsgList,
        preRefresh: preRefresh,
        callback: widget.callback);
  }

  //互动消息获取头像
  Widget _getPortrait(String param) {
    return Container(
      margin: EdgeInsets.only(right: UIData.spaceSize4),
      width: ScreenUtil.getInstance().setWidth(25),
      height: ScreenUtil.getInstance().setWidth(25),
      child: ClipOval(
        child: StringsHelper.isNotEmpty(json.decode(param)['fromCustId'])
            ? CommonImageWidget(json.decode(param)['fromCustPhoto'],
                loadingImage: UIData.imagePayServiceDefault,
                loadedFailedImage: UIData.imagePayServiceDefault,
                loadedNoDataImage: UIData.imagePayServiceDefault)
//        CachedNetworkImage(
//                placeholder: (context, url) => Image.asset(UIData.imagePayServiceDefault),
//                errorWidget: (context, url, error) => Image.asset(UIData.imagePayServiceDefault),
//                imageUrl: HttpOptions.showPhotoUrl(json.decode(param)['fromCustPhoto']),
//                fit: BoxFit.fill,
//              )
            : Image.asset(
                UIData.imageZhaoxiaotong,
                fit: BoxFit.fill,
              ),
      ),
    );
  }

  //互动消息昵称
  Widget _getNickName(String param) {
    return CommonText.darkGrey15Text(
        StringsHelper.isNotEmpty(json.decode(param)['fromCustId']) ? json.decode(param)['fromNickName'] : '招小通',
        fontWeight: FontWeight.w200);
  }

  ///
  /// item卡片
  ///
  Widget _buildCard(MessageInfo info) {
    return GestureDetector(
      child: Container(
        padding: _modify
            ? EdgeInsets.only(top: UIData.spaceSize16, bottom: UIData.spaceSize16, right: UIData.spaceSize16)
            : EdgeInsets.all(UIData.spaceSize16),
        color: UIData.primaryColor,
        child: Row(
          children: <Widget>[
            Visibility(
                visible: _modify,
                child: Checkbox(
                    value: _ids.any((int id) => id == info.messageId),
                    onChanged: (bool check) {
//                      LogUtils.printLog('check:$check');
                      setState(() {
                        if (check) {
                          _ids.add(info.messageId);
                        } else {
                          _ids.remove(info.messageId);
                        }
                      });
                    })),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                        child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //未读才显示红点点
                        CommonDiamondDot(color: info.isRead == '0' ? UIData.redColor : UIData.primaryColor),
                        Expanded(
                            child: CommonText.darkGrey16Text(info?.messageTitle ?? '',
                                overflow: TextOverflow.ellipsis)),
                      ],
                    )),
                    Visibility(
                        child: Row(
                          children: <Widget>[
                            SizedBox(width: UIData.spaceSize8),
                            CommonText.lightGrey12Text(info?.createTime ?? '')
                          ],
                        ),
                        visible: info?.messageType != messageTypeHDXX)
                  ],
                ),
                SizedBox(height: UIData.spaceSize8),
                widget.messageType == messageTypeHDXX
                    ? _buildHDXX(info)
                    : CommonText.text13(info?.messageText ?? '',
                        color: UIData.greyColor, overflow: TextOverflow.fade)
              ],
            ))
          ],
        ),
      ),
      onTap: () {
        //点击后设置成已读
        //消息是否未读(0:未读 1：已读)
        if (info?.isRead == '0') {
          stateModel.setMessageRead(info.messageId, info.receiverId, stateModel.accountId, callBack: () {
            setState(() {
//            info.isRead = '1'; //设置已读
              stateModel.getUnReadMessageTotalCount();
              handleRefresh();
//            if (widget.callback != null) widget.callback(); //回调到消息中心刷新红点的未读消息数量
            });
          });
        }
        print(info?.subMessageType);
        print(int.parse(json.decode(info?.param)['relatedId']));
        if (StringsHelper.isNotEmpty(info?.messageType) && info?.messageType == 'GDXX') {
          //工单
          Navigate.toNewPage(ComplaintDetailPage(info?.subMessageType, info?.relatedId));
        } else if (StringsHelper.isNotEmpty(info?.subMessageType))
          //判断子类型来跳转
          switch (info?.subMessageType) {
            //房屋认证通知认证通过
            case 'FWRZTG':
              Navigate.toNewPage(HouseDetailPage(custHouseRelationId: info?.relatedId));
//            int custHouseRelationId;
//            int houseCustAuditId;
//            if (info?.relatedTableName == 'tm_cust_house_relation') //已认证通过
//              custHouseRelationId = info?.relatedId;
//            else //未认证通过
//              houseCustAuditId = info?.relatedId;
//            Navigate.toNewPage(
//                HouseDetailPage(custHouseRelationId: custHouseRelationId, houseCustAuditId: houseCustAuditId));
              break;
            //房屋认证通知认证不通过
            case 'FWRZBTG':
              Navigate.toNewPage(HouseDetailPage(houseCustAuditId: info?.relatedId));
              break;
            //门禁卡
            case 'MJK':
              if ("1" == json.decode(info?.param)['ToOwnerAgree']) {
                Navigate.toNewPage(EntranceCardApplyAuditPage(null, info?.relatedId));
              } else {
                Navigate.toNewPage(EntranceCardDetailsPage(info?.relatedId));
              }
//            Navigate.toNewPage(EntranceCardDetailsPage(info?.relatedId));
              break;
            //停车办理
            case 'XK':
            case 'XF':
            case 'TZ':
            case 'TCBL':
              Navigate.toNewPage(ParkingCardDetailsPage(info?.relatedId));
              break;
            case 'ZHRZ': //租户入驻
              Navigate.toNewPage(CheckInDetailsPage(info?.relatedId));
              break;
            case 'ACTIVITY_VIEW': //活动详情（1问卷/2投票/3报名）
              stateModel.communityActivityGetH5(info?.relatedId, callBack: (String url) {
                Navigate.toNewPage(HtmlPage(url, info?.messageTitle));
              });
              break;
            case 'WPFX': //物品放行
              Navigate.toNewPage(ArticlesReleaseDetailPage(info?.relatedId,
                  toOwnerAgree: json.decode(info?.param)['ToOwnerAgree']));
              break;
            case 'XZLTZ': //写字楼退租
              Navigate.toNewPage(OfficeCancelLeaseDetailPage(info?.relatedId));
              break;
            case 'DHSQ': //动火申请
//            Navigate.toNewPage(HotWorkDetailPage(info?.relatedId));
              Navigate.toNewPage(
                  HotWorkDetailPage(info?.relatedId, toOwnerAgree: json.decode(info?.param)['ToOwnerAgree']));
              break;
            case 'REPLY': //评论/回复
            case 'LIKE': //点赞
//            Navigate.toNewPage(HotWorkDetailPage(info?.relatedId));
              Navigate.toNewPage(PgcCommentPage(
                  PgcCommentInfo(
                      pgcId: int.parse(json.decode(info?.param)['mainId']),
                      pgcCommentId: int.parse(json.decode(info?.param)['relatedId'])),
                  PgcInfoType.infomation));
              break;
            case messageSubTypeWAREREPLY: //集市评论/回复
            case messageSubTypeWARELIKE: //集市点赞
              Navigate.toNewPage(MarketDetail(int.parse(json.decode(info?.param)['relatedId'])));
              break;
            case messageSubTypeTOPICCOMMENT: //话题评论/回复
            case messageSubTypeTOPICLIKE: //话题点赞
              _toTopicDetailPage(json.decode(info?.param)['relatedId']);
              break;
            case messageSubTypeTALKCOMMENT: //说说评论/回复
            case messageSubTypeTALKLIKE: //说说点赞
              _toTalkAboutDetailPage(json.decode(info?.param)['relatedId']);
              break;
            case 'ZXCRZ': //装修出入证
              if ("1" == json.decode(info?.param)['ToOwnerAgree']) {
                Navigate.toNewPage(DecorationPassCardDetailsPage(info?.relatedId, 0));
              } else {
                Navigate.toNewPage(DecorationPassCardDetailsPage(info?.relatedId, 1));
              }
              break;
            case 'CQBG': //产权变更
              Navigate.toNewPage(ChangeOfTitleDetail(
                  null,
//                                    widget.type,
                  int.parse(json.decode(info?.param)['relatedId'])));
              break;
            case 'ZXYS':
            case 'ZXXKZ': //装修许可证
              DecorationModel _model = new DecorationModel();
              _model.getDecorationInfo(int.parse(json.decode(info?.param)['relatedId']),
                  callback: (DecorationInfo info) {
                //ACCEPTANCE_CHECK-验收待处理，ACCEPTANCE_CHECK_FAIL-验收不通过，ACCEPTANCE_CHECK_SUCCESS-验收通过
                if ((info?.state ?? '') == 'ACCEPTANCE_CHECK' ||
                    (info?.state ?? '') == 'ACCEPTANCE_CHECK_FAIL' ||
                    (info?.state ?? '') == 'ACCEPTANCE_CHECK_SUCCESS')
                  Navigate.toNewPage(DecorationDetailTabPage(_model, info.id), callBack: (flag) {
                    if (flag != null && flag is bool && flag) {
                      handleRefresh();
                    }
                  });
                else
                  Navigate.toNewPage(DecorationApplyDetailPage(_model, info.id), callBack: (flag) {
                    if (flag != null && flag is bool && flag) {
                      handleRefresh();
                    }
                  });
              });
              break;
            case 'XFRH': //新房入伙
              Navigate.toNewPage(
                  NewHouseDetailPage(NewHouseStateModel(), int.parse(json.decode(info?.param)['relatedId'])));
              break;
            case 'YYDF': //预约到访
              Navigate.toNewPage(VisitorReleaseDetailPage(
                  VisitorReleaseStateModel(), int.parse(json.decode(info?.param)['relatedId'])));
              break;
            case 'LSDF': //临时到访
              Navigate.toNewPage(VisitorReleaseCheckPage(
                  VisitorReleaseStateModel(), int.parse(json.decode(info?.param)['relatedId'])));
              break;
            case 'SCXX': //商城
              if (StringsHelper.isNotEmpty(json.decode(info?.param)['visitUrl']?.toString())) {
                //url有值跳转htmlPage
//                Navigate.toNewPage(HtmlPage(json.decode(info?.param)['visitUrl']?.toString(), '商城'));
                Navigate.toNewPage(HtmlPage(
                    HttpOptions.getMallUrl(json.decode(info?.param)['visitUrl']?.toString(), stateModel.accountId,
                        stateModel.defaultProjectId),
                    '商城'));
              } else {
                Navigate.toNewPage(MallMsgDetailPage(json.decode(info?.param)['messageTitle']?.toString(),
                    json.decode(info?.param)['messageText']?.toString()));
              }
              break;
          }
      },
    );
  }

  Widget _buildHDXX(MessageInfo info) {
    if (info?.subMessageType == messageSubTypeWARELIKE || info?.subMessageType == messageSubTypeWAREREPLY || info?.subMessageType == messageSubTypeTOPICCOMMENT || info?.subMessageType == messageSubTypeTOPICLIKE|| info?.subMessageType == messageSubTypeTALKCOMMENT || info?.subMessageType == messageSubTypeTALKLIKE) {
      //集市的布局
      String messageText = json.decode(info?.param)['messageText'];
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
            _getPortrait(info?.param),
            CommonText.darkGrey15Text(json.decode(info?.param)['fromNickName'] ?? '', fontWeight: FontWeight.w200),
            Expanded(
              child: CommonText.grey14Text(messageText ?? '', overflow: TextOverflow.ellipsis),
            )
          ]),
          Visibility(
              child: Column(
                children: <Widget>[
                  SizedBox(height: UIData.spaceSize8),
                  CommonText.lightGrey14Text(json.decode(info?.param)['msgDescribe'] ?? '')
                ],
              ),
              visible: info?.subMessageType == messageSubTypeWAREREPLY||info?.subMessageType == messageSubTypeTOPICCOMMENT||info?.subMessageType == messageSubTypeTALKCOMMENT)
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  _getPortrait(info?.param),
                  _getNickName(info?.param),
                  SizedBox(width: UIData.spaceSize8),
                  CommonText.grey14Text(json.decode(info?.param)['messageText'] ?? '')
                ],
              ),
              Visibility(
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: UIData.spaceSize8),
                      CommonText.lightGrey12Text(info?.createTime ?? '')
                    ],
                  ),
                  visible: info?.subMessageType == messageSubTypeREPLY)
            ],
          ),
          Visibility(
              child: Column(
                children: <Widget>[
                  SizedBox(height: UIData.spaceSize8),
                  CommonText.lightGrey14Text(json.decode(info?.param)['msgDescribe'] ?? '')
                ],
              ),
              visible: info?.subMessageType == messageSubTypeREPLY)
        ],
      );
    }
  }

  Widget _buildList() {
    return RefreshIndicator(
        child: ListView.separated(
//            padding: EdgeInsets.only(top: UIData.spaceSize16),
          physics: AlwaysScrollableScrollPhysics(),
          controller: _loadMoreScrollController,
          itemCount: (_listPageModel?.list?.length ?? 0) + 1,
//            itemCount: 2,
          itemBuilder: (context, index) {
            if (_listPageModel?.list?.length == index) {
              return CommonLoadMore(_listPageModel.listPage.maxCount);
            } else {
              MessageInfo info = _listPageModel?.list[index];
//              PropertyNotice info;
              return _buildCard(info);
            }
          },
          separatorBuilder: (context, index) {
//            return CommonDivider();
            if (index == (_listPageModel?.list?.length ?? 0) - 1)
              return Container();
            else
              return SizedBox(height: UIData.spaceSize12);
          },
        ),
        onRefresh: handleRefresh);
  }

//  Widget _buildBottomNavigationBar() {
//    return _modify
//        ? Container(
//            color: UIData.primaryColor,
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//              children: <Widget>[
//                Row(
//                  children: <Widget>[
//                    Checkbox(
//                        value: _ids.length == _listPageModel.list.length,
//                        onChanged: (bool check) {
////                      LogUtils.printLog('check:$check');
//                          setState(() {
//                            if (check) {
//                              _listPageModel.list.forEach((info) {
//                                _ids.add(info?.messageId);
//                              });
//                            } else {
//                              _ids.clear();
//                            }
//                          });
//                        }),
//                    CommonText.red15Text('全选')
//                  ],
//                ),
//                FlatButton(
//                    child: CommonText.red15Text('标为已读'),
//                    onPressed: () {
//                      if (_ids.length > 0) {
//                        stateModel.setMessageReadBatch(
//                            ids: _ids,
//                            callBack: () {
//                              setState(() {
//                                _modify = false;
//                                _ids.clear();
//                              });
//                              if (widget.callback != null)
//                                widget.callback(); //回调到消息中心刷新红点的未读消息数量
//                              handleRefresh(preRefresh: true);
//                            });
//                      } else {
//                        CommonToast.show(
//                            msg: '请勾选未读消息', type: ToastIconType.INFO);
//                      }
//                    })
//              ],
//            ),
//          )
//        : null;
//  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
      return CommonLoadContainer(
          state: _listPageModel.listPage.listState,
//              state: ListState.HINT_DISMISS, //测试数据
          content: _buildList(),
          callback: () {
            handleRefresh(preRefresh: true);
          });
    });
  }

  //跳转到话题详情页面
  _toTopicDetailPage(String topicId) async {
    if(StringsHelper.isNotEmpty(topicId)){
      SharedPreferences prefs = await SharedPreferencesKey.globalPrefs;
      String token = prefs.getString(SharedPreferencesKey.KEY_ACCESS_TOEKN);
      Navigate.toNewPage(HtmlPage("${HttpOptions.baseUrl.replaceAll(
          "ubms-customer/",
          "")}template/appShare/topicDetails.html?projectId=${stateModel
          ?.defaultProjectId}&token=$token&topicId=$topicId&closePage=1",
        "", showTitle: false,));
    }
  }

  //跳转到说说详情页面
  _toTalkAboutDetailPage(String talkId) async{
    if(StringsHelper.isNotEmpty(talkId)) {
      SharedPreferences prefs = await SharedPreferencesKey.globalPrefs;
      String token = prefs.getString(SharedPreferencesKey.KEY_ACCESS_TOEKN);
      Navigate.toNewPage(HtmlPage("${HttpOptions.baseUrl.replaceAll(
          "ubms-customer/",
          "")}template/appShare/talkAboutDetail.html?projectId=${stateModel
          ?.defaultProjectId}&token=$token&talkId=$talkId&closePage=1", "",
        showTitle: false,));
    }
  }
}
