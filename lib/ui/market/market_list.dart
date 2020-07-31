import 'package:cmp_customer/models/market/ware_detail_model.dart';
import 'package:cmp_customer/models/pgc/pgc_infomation_obj.dart';
import 'package:cmp_customer/scoped_models/market_model/market_detail_model.dart';
import 'package:cmp_customer/scoped_models/market_model/market_list_model.dart';
import 'package:cmp_customer/scoped_models/pgc_model/pgc_infomation_model.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_loadmore.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/pgc/pgc_infomation/pgc_infomation_item.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'market_item.dart';

class MarketList extends StatefulWidget {
  MarketListModel _model;
  Function refreshCallback;
  Function loadMoreCallback;
  MarketList(this._model, {this.refreshCallback, this.loadMoreCallback});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ListState();
  }
}

class _ListState extends State<MarketList> {
  ScrollController _loadMoreScrollController = new ScrollController();

  MarketListModel _model;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _model = widget._model;
    _model.collectCheckedList.clear(); //清空选中的收藏列表
    if (widget.refreshCallback != null) {
      widget.refreshCallback();
    }
    _loadMoreScrollController.addListener(() {
      if (_loadMoreScrollController.position.pixels ==
          _loadMoreScrollController.position.maxScrollExtent) {
        if (_model.marketListState != ListState.HINT_LOADING) {
          if (widget.loadMoreCallback != null) widget.loadMoreCallback();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModel<MarketListModel>(
      model: _model,
      child: CommonScaffold(
          showAppBar: false,
          bodyData: buildPGCInfomationList(),
          bottomNavigationBar: _model.isBulkCollectPage
              ? _buildBottomNavigationBar()
              : Container()),
    );
  }

  Widget buildPGCInfomationList() {
    return ScopedModelDescendant<MarketListModel>(
      builder: (context, child, model) {
        return CommonLoadContainer(
            state: _model.marketListState,
            content: _buildList(),
            callback: refresh);
      },
    );
  }

  Future<void> _refresh() async {
    if (widget.refreshCallback != null) {
      widget.refreshCallback();
    }
  }

  refresh() {
    _model.collectCheckedList.clear();
    if (widget.refreshCallback != null) {
      widget.refreshCallback();
    }
  }

  Widget _buildList() {
    return ScopedModelDescendant<MarketListModel>(
        builder: (context, child, model) {
      return RefreshIndicator(
        child: ListView.builder(
          controller: _loadMoreScrollController,
          shrinkWrap: true,
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: (model.markets?.length ?? 0) + 1,
          itemBuilder: (BuildContext context, int index) {
            if (model.markets?.length == index) {
              return CommonLoadMore(model.historyMaxCount);
            } else {
              WareDetailModel info = model.markets[index];
              return MarketItem(
                info,
                _model,
                refreshCallback: refresh,
              );
            }
          },
        ),
        onRefresh: _refresh,
      );
    });
  }

  //是否全选
  bool _isAllCollected() {
    return _model.collectCheckedList.length > 0 &&
        _model.collectCheckedList.length == _model.markets.length;
  }

  //设置全选
  _setAllCollected(bool checked) {
    _model.setAllCollected(checked);
  }

  //按钮布局
  Widget _buildBottomNavigationBar() {
    return ScopedModelDescendant<MarketListModel>(
      builder: (context, child, model) {
        return Offstage(
          offstage: !_model.isBulkCollectOperation,
          child: Container(
              color: UIData.primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Checkbox(
                          value: _isAllCollected(),
                          onChanged: (bool checked) {
                            _setAllCollected(checked);
                          }),
//                    CommonText.darkGrey15Text(_isAllCollected()?'全删':'全选')
                      CommonText.darkGrey15Text('全选')
                    ],
                  ),
                  FlatButton(
                      child: CommonText.red15Text('取消收藏'),
                      onPressed: () {
                        _cancelCollect();
                      })
                ],
              )),
        );
      },
    );
  }

  //取消收藏
  _cancelCollect() {
    if (_model.collectCheckedList == null ||
        _model.collectCheckedList.isEmpty) {
      CommonToast.show(msg: "请勾选需要取消的信息", type: ToastIconType.INFO);
    } else {
      _model.cancelCollectList(_model.collectCheckedList, 0, (success) {
        if (success != null && success) {
          CommonToast.show(type: ToastIconType.SUCCESS, msg: "已取消收藏");
          //上传成功，清除选择列表，并刷新页面数据
          refresh();
        }
      });
    }
  }
}
