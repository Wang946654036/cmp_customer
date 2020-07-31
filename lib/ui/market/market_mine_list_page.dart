import 'package:cmp_customer/scoped_models/market_model/market_list_model.dart';
import 'package:cmp_customer/scoped_models/pgc_model/pgc_infomation_model.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_text_field.dart';
import 'package:cmp_customer/ui/common/popover/cupertino_popover.dart';
import 'package:cmp_customer/ui/common/popover/cupertino_popover_menu_item.dart';
import 'package:cmp_customer/ui/pgc/pgc_infomation/pgc_infomation_list.dart';

import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'market_list.dart';

class MarketMineListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ListPageState();
  }
}

class _ListPageState extends State<MarketMineListPage> {
  MarketListModel _model;
  String searchWordstr = '';
  String status = '1';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _model = MarketListModel();
    _model.isMine = true;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModel<MarketListModel>(
        model: _model,
        child: CommonScaffold(
            appTitle: '我发布的',
            appBarActions: [
              CupertinoPopoverButton(
                  popoverWidth: UIData.spaceSize100,
                  popoverColor: UIData.greyColor,
                  child: FlatButton(
                    child: CommonText.red15Text(status == '3'
                        ? '全部'
                        : (status == '1' ? '已上架' : '已下架')),
                    onPressed: null,
                  ),
                  popoverBuild: (context) {
                    return CupertinoPopoverMenuList(
                      children: <Widget>[
                        CupertinoPopoverMenuItem(
                          child: CommonText.white14Text("全部"),
                          onTap: () {
                            setState(() {
                              status = '3';
                              _model.marketListHistoryHandleRefresh(
                                  preRefresh: true,
                                  map: {
                                    'title': searchWordstr,
                                    'status': status
                                  });
                            });
                          },
                        ),
                        CupertinoPopoverMenuItem(
                          child: CommonText.white14Text("已上架"),
                          onTap: () {
                            setState(() {
                              status = '1';
                              _model.marketListHistoryHandleRefresh(
                                  preRefresh: true,
                                  map: {
                                    'title': searchWordstr,
                                    'status': status
                                  });
                            });
                          },
                        ),
                        CupertinoPopoverMenuItem(
                          child: CommonText.white14Text("已下架"),
                          onTap: () {
                            setState(() {
                              status = '2';
                              _model.marketListHistoryHandleRefresh(
                                  preRefresh: true,
                                  map: {
                                    'title': searchWordstr,
                                    'status': status
                                  });
                            });
                          },
                        ),
                      ],
                    );
                  }),
            ],
            bodyData: Column(children: <Widget>[
              CommonSearchBar(
                hintText: '请输入商品名称',
                onSearch: (String searchWords) {
                  searchWordstr = searchWords;
                  _model.marketListHistoryHandleRefresh(
                      preRefresh: true,
                      map: {
                        'title': searchWords,
                        'status': status,
                      });
                },
              ),
              Expanded(
                child: MarketList(
                  _model,
                  refreshCallback: () {
                    _model.marketListHistoryHandleRefresh(
                        preRefresh: true,
                        map: {
                          'title': searchWordstr,
                          'status': status,
                        });
                  },
                  loadMoreCallback: () {
                    _model.marketListHistoryHandleRefresh(map: {
                      'title': searchWordstr,
                      'status': status,
                    });
                  },
                ),
              )
            ])));
  }
}
