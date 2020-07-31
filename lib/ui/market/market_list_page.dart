import 'package:cmp_customer/scoped_models/market_model/market_list_model.dart';
import 'package:cmp_customer/scoped_models/pgc_model/pgc_infomation_model.dart';
import 'package:cmp_customer/ui/common/common_dialog.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_text_field.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/common/popover/cupertino_popover.dart';
import 'package:cmp_customer/ui/common/popover/cupertino_popover_menu_item.dart';
import 'package:cmp_customer/ui/parking/parking_card_screen.dart';
import 'package:cmp_customer/ui/pgc/pgc_infomation/pgc_infomation_list.dart';
import 'package:cmp_customer/utils/navigate.dart';

import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../main.dart';
import 'market_apply.dart';
import 'market_basedata.dart';
import 'market_list.dart';
import 'market_mine_list_page.dart';
import 'market_screen.dart';

class MarketListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ListPageState();
  }
}

class _ListPageState extends State<MarketListPage> {
  MarketListModel _model;
  String searchWordstr = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _model = MarketListModel();

    //初始化筛选数据
    _model.initScreenData();
    _model.params['projectId'] = stateModel.defaultProjectId;//设置当前城市
    _model.params['regionFlag'] = 1;//设置默认查询同城汇的数据
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModel<MarketListModel>(
        model: _model,
        child: CommonScaffold(
            appTitle: '商品列表',
            appBarActions: [
              FlatButton(
                child: CommonText.red15Text("我发布的"),
                onPressed: () {
                  Navigate.toNewPage(MarketMineListPage());
                },
              ),
            ],
            floatingActionButton: IconButton(
              icon: Image.asset(UIData.imageMarketAdd),
              onPressed: () {
                _showAddDialog();
              },
            ),
            endDrawerWidget: MarketScreenPage(),
            bodyData: Column(children: <Widget>[
              Container(
                  color: UIData.primaryColor,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(
                      horizontal: UIData.spaceSize16,
                      vertical: UIData.spaceSize8),
                  child: Row(children: <Widget>[
                    Expanded(
                      child: CommonSearchRightBar(
                        hintText: '请输入商品名称',
                        onSearch: (String searchWords) {
                          _model.setSearchWord(searchWords);
                          _refresh();
                        },
                      ),
                    ),
                    Builder(builder: (context) {
                      return GestureDetector(
                        child: Container(
                          padding: EdgeInsets.only(left: UIData.spaceSize16),
                          child: Row(
                            children: <Widget>[
                              CommonText.darkGrey14Text('筛选'),
                              UIData.iconFilter,
                            ],
                          ),
                        ),
                        onTap: () => Scaffold.of(context).openEndDrawer(),
                      );
                    }),
                  ])),
              Expanded(
                child: MarketList(
                  _model,
                  refreshCallback: () {
                    _refresh();
                  },
                  loadMoreCallback: () {
                    _model.marketListHandleLoadMore(map: _model.params);
                  },
                ),
              )
            ])));
  }

  void _refresh(){
    _model.marketListHistoryHandleRefresh(map: _model.params,preRefresh: true);
  }

  void _showAddDialog() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: UIData.primaryColor,
            padding: EdgeInsets.only(top: UIData.spaceSize12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                        child: GestureDetector(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          UIData.iconMarketZJ,
                          Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: UIData.spaceSize12),
                              child: CommonText.darkGrey14Text("租借",
                                  textAlign: TextAlign.center))
                        ],
                      ),
                      onTap: () {
                        Navigate.closePage();
                        checkPublish(MarketType.ZJ);
                      },
                    )),
                    Expanded(
                        child: GestureDetector(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          UIData.iconMarketXSY,
                          Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: UIData.spaceSize12),
                              child: CommonText.darkGrey14Text("小生意",
                                  textAlign: TextAlign.center))
                        ],
                      ),
                      onTap: () {
                        Navigate.closePage();
                        checkPublish(MarketType.XSY);
                      },
                    )),
                    Expanded(
                        child: GestureDetector(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          UIData.iconMarketES,
                          Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: UIData.spaceSize12),
                              child: CommonText.darkGrey14Text("二手",
                                  textAlign: TextAlign.center))
                        ],
                      ),
                      onTap: () {
                        Navigate.closePage();
                        checkPublish(MarketType.ES);
                      },
                    )),
                    Expanded(
                        child: GestureDetector(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          UIData.iconMarketZS,
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: UIData.spaceSize12),
                            child: CommonText.darkGrey14Text("赠品",
                                textAlign: TextAlign.center),
                          )
                        ],
                      ),
                      onTap: () {
                        Navigate.closePage();
                        checkPublish(MarketType.ZS);
                      },
                    )),
                  ],
                ),
                CommonDivider(),
                IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: UIData.lightGreyColor,
                  ),
                  onPressed: () {
                    Navigate.closePage();
                  },
                ),
              ],
            ),
          );
        });
  }

  //查询是否可继续发布商品
  void checkPublish(MarketType type){
    _model.wareIsPublish((success){
      if(success!=null){
        if(success){
          Navigate.toNewPage(MarketApplyPage(
            marketType: type,
          ),callBack: (success){
            if(success!=null&& success){
              _refresh();
            }
          });
        }else{
          CommonToast.show(msg: "每天最多发布3个商品哦，亲",type: ToastIconType.FAILED);
        }
      }
    });
  }
}
