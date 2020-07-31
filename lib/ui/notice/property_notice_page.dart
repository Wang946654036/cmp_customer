import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/common/common_page_model.dart';
import 'package:cmp_customer/models/property_notice_model.dart';
import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/strings/strings_notice.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_dot.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_loadmore.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_shadow_container.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_text_field.dart';
import 'package:cmp_customer/ui/notice/property_notice_detail_page.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scoped_model/scoped_model.dart';

///
/// 物业通知列表
///
class PropertyNoticePage extends StatefulWidget {
//
  PropertyNoticePage();

  @override
  _PropertyNoticePageState createState() => _PropertyNoticePageState();
}

class _PropertyNoticePageState extends State<PropertyNoticePage> {
  ListPageModel _listPageModel = ListPageModel();
  ScrollController _loadMoreScrollController = new ScrollController();
  String _keyword = '';
  int _read = 2; //是否已读 0:未读 1:已读 2:全部


  @override
  void initState() {
    super.initState();
    stateModel.loadPropertyNoticeList(pageModel: _listPageModel, keyword: _keyword, read: _read);

    _loadMoreScrollController.addListener(() {
      if (_loadMoreScrollController.position.pixels == _loadMoreScrollController.position.maxScrollExtent) {
        if (_listPageModel.listPage.listState != ListState.HINT_LOADING) {
          stateModel.propertyNoticeLoadMore(_listPageModel, keyword: _keyword, read:_read);
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///
  /// item卡片
  ///
  Widget _buildCard(PropertyNotice info) {
    return CommonShadowContainer(
      padding: EdgeInsets.symmetric(vertical: UIData.spaceSize16),
      margin: EdgeInsets.only(left: UIData.spaceSize16, right: UIData.spaceSize16, top: UIData.spaceSize16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize16),
              child: Row(
                //第一行，未读、紧急程度、标题
                children: <Widget>[
                  info?.isRead == "0" ? CommonDiamondDot() : Container(), //未读显示点
                  SizedBox(width: UIData.spaceSize4),
                  info?.type != null
                      ? CommonLabel(urgentDegreeMap[info?.type],
                          backgroundColor: UIData.primaryColor,
                          textColor: urgentDegree2ColorMap[info?.type],
                          borderColor: urgentDegree2ColorMap[info?.type])
                      : Container(),
                  SizedBox(width: UIData.spaceSize4),
                  CommonText.darkGrey15Text(info?.title ?? ''), //通知名称
                  //先判断是待办还是全部，待办显示多久前已读，全部显示任务状态
                ],
              )),
          SizedBox(height: UIData.spaceSize8),
          //第二行，图片
          Container(
//            alignment: Alignment.topCenter,
            height: ScreenUtil.getInstance().setHeight(105),
            child: FadeInImage.assetNetwork(
              placeholder: UIData.imageActivityDefault,
              image: info?.imageList != null && info.imageList.length > 0
                  ? HttpOptions.showPhotoUrl(info.imageList[0].attachmentUuid)
                  : '',
              fit: BoxFit.cover,
            ),
//            decoration: BoxDecoration(
////              borderRadius: BorderRadius.circular(6.0),
//              image: DecorationImage(image: AssetImage(UIData.imageActivityDefault), fit: BoxFit.fitWidth),
//            ),
          ),
          SizedBox(height: UIData.spaceSize8),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize16),
              child: Row(
                children: <Widget>[
                  CommonText.lightGrey12Text(info?.orgName ?? ''),
                  SizedBox(width: UIData.spaceSize4),
                  CommonText.lightGrey12Text(info?.sendTime ?? ''),
                ],
              ))
        ],
      ),
      onTap: () {
        Navigate.toNewPage(PropertyNoticeDetailPage(info?.id));
      },
    );
  }

//  _refresh() {
//    MainStateModel.of(context).taskHandleRefresh(pageModel: _listPageModel, preRefresh: true);
//  }
  Future<void> _handleRefresh() async {
    stateModel.loadPropertyNoticeList(pageModel: _listPageModel, keyword: _keyword, read:_read);
  }

  Widget _buildList() {
    return RefreshIndicator(
        child: ListView.builder(
//            padding: EdgeInsets.only(top: UIData.spaceSize16),
            controller: _loadMoreScrollController,
            itemCount: (_listPageModel?.list?.length ?? 0) + 1,
//            itemCount: 2,
            itemBuilder: (context, index) {
              if (_listPageModel?.list?.length == index) {
                return CommonLoadMore(_listPageModel.listPage.maxCount);
              } else {
                PropertyNotice info = _listPageModel?.list[index];
//              PropertyNotice info;
                return _buildCard(info);
              }
            }),
        onRefresh: _handleRefresh);
  }

  Widget _buildContent() {
    return Column(
      children: <Widget>[
        CommonSearchBar(
            hintText: '请输入通知标题',
            onSearch: (String keyword) {
              setState(() {
                _keyword = keyword;
                FocusScope.of(context).requestFocus(FocusNode());
                stateModel.loadPropertyNoticeList(pageModel: _listPageModel, keyword: keyword, read:_read, preRefresh: true);
              });
            }),
        Expanded(
          child: CommonLoadContainer(
              state: _listPageModel.listPage.listState,
//              state: ListState.HINT_DISMISS, //测试数据
              content: _buildList(),
              callback: () {
                stateModel.loadPropertyNoticeList(pageModel: _listPageModel, keyword: _keyword,  read:_read, preRefresh: true);
              }),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
      return CommonScaffold(
        appTitle: '物业通知',
        appBarActions: [
          FlatButton(
              child: CommonText.red15Text(_read == 2 ? '全部' : '未读'),
              onPressed: () {
                setState(() {
                  if (_read == 2)
                    _read = 0;
                  else
                    _read = 2;
                  stateModel.loadPropertyNoticeList(
                      pageModel: _listPageModel, keyword: _keyword, read: _read, preRefresh: true);
                });
              })
        ],
        bodyData: _buildContent(),
      );
    });
  }
}
