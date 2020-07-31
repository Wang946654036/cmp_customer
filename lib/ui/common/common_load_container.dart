import 'package:cmp_customer/ui/common/common_list_loading.dart';
import 'package:cmp_customer/ui/common/common_list_refresh.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:flutter/material.dart';

///
/// 公用包含加载中、加载失败等状态的容器
///
class CommonLoadContainer extends StatelessWidget {
  final ListState state;
  final Function callback;
  final Widget content;

  CommonLoadContainer({@required this.state, @required this.callback, @required this.content});

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case ListState.HINT_LOADING:
        return CommonListLoading();
        break;
      case ListState.HINT_NO_DATA_CLICK:
        return CommonListRefresh(
            state: ListState.HINT_NO_DATA_CLICK,
            callBack: () {
              if (callback != null) callback();
            });
        break;
      case ListState.HINT_LOADED_FAILED_CLICK:
        return CommonListRefresh(
            state: ListState.HINT_LOADED_FAILED_CLICK,
            callBack: () {
              if (callback != null) callback();
            });
        break;
      case ListState.HINT_DISMISS:
        return content ?? Container();
        break;
    }
    return Container();
  }
}
