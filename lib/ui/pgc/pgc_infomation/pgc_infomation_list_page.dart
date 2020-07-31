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

import '../pgc_ui.dart';

class PgcInfomationListPage extends StatefulWidget {
  PgcInfomationListPage();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _pgcInfomationListPageState();
  }
}

class _pgcInfomationListPageState extends State<PgcInfomationListPage> {
  PgcInfomationListModel _model;
  String searchWordstr = '';
  String searchType = '0';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _model = PgcInfomationListModel();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModel<PgcInfomationListModel>(
        model: _model,
        child: CommonScaffold(
            appTitle: '资讯列表',
            appBarActions: [
              CupertinoPopoverButton(
                  popoverWidth: UIData.spaceSize100,
                  popoverColor: UIData.greyColor,
                  child: FlatButton(
//                    alignment: Alignment.centerRight,
                    child: CommonText.red15Text(searchType == '2'
                        ? '按热度'
                        : (searchType == '1' ? '按时间' : '综合排序')),
//                    child: Row(
//                      crossAxisAlignment: CrossAxisAlignment.center,
//                      children: <Widget>[
//                        CommonText.blue14Text(searchType == '2'
//                            ? '按热度'
//                            : (searchType == '1' ? '按时间' : '综合排序')),
//                      ],
//                    ),
                  onPressed: null,
                  ),
                  popoverBuild: (context) {
                    return CupertinoPopoverMenuList(
                      children: <Widget>[
                        CupertinoPopoverMenuItem(
                          child: CommonText.white14Text("综合排序"),
                          onTap: () {
                            setState(() {
                              searchType = '0';
                              _model.pgcInfomationListHistoryHandleRefresh(
                                  preRefresh: true,
                                  map: {
                                    'keyword': searchWordstr,
                                    'searchType': searchType
                                  });
                            });
                          },
                        ),
                        CupertinoPopoverMenuItem(
                          child: CommonText.white14Text("按时间"),
                          onTap: () {
                            setState(() {
                              searchType = '1';
                              _model.pgcInfomationListHistoryHandleRefresh(
                                  preRefresh: true,
                                  map: {
                                    'keyword': searchWordstr,
                                    'searchType': searchType
                                  });
                            });
                          },
                        ),
                        CupertinoPopoverMenuItem(
                          child: CommonText.white14Text("按热度"),
                          onTap: () {
                            setState(() {
                              searchType = '2';
                              _model.pgcInfomationListHistoryHandleRefresh(
                                  preRefresh: true,
                                  map: {
                                    'keyword': searchWordstr,
                                    'searchType': searchType
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
                hintText: '请输入资讯标题/关键字',
                onSearch: (String searchWords) {
                  searchWordstr = searchWords;

                  _model.pgcInfomationListHistoryHandleRefresh(
                      preRefresh: true,
                      map: {
                        'keyword': searchWords,
                        'searchType': searchType,
                      });
                },
              ),
              Expanded(
                child: PGCInfomationList(
                  _model,
                  refreshCallback: () {
                    _model.pgcInfomationListHistoryHandleRefresh(
                        preRefresh: true,
                        map: {
                          'keyword': searchWordstr,
                          'searchType': searchType,
                        });
                  },
                  loadMoreCallback: (){
                    _model.pgcInfomationListHandleLoadMore(map: {
                      'keyword': searchWordstr,
                      'searchType': searchType,
                    });
                  },
                ),
              )
            ])));
  }
}
