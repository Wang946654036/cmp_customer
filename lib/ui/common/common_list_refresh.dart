import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonListRefresh extends StatelessWidget {
  final ListState state;
  final Function callBack;

  CommonListRefresh({this.state = ListState.HINT_LOADED_FAILED_CLICK, this.callBack});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            child: Container(
              width: ScreenUtil().setWidth(state == ListState.HINT_NO_DATA_CLICK ? 100 : 80),
//              height: ScreenUtil().setWidth(180),
              child: Image(
                  image: AssetImage(state == ListState.HINT_LOADED_FAILED_CLICK
                      ? UIData.imageLoadedFailed
                      : UIData.imageNoData)),
            ),
            onTap: () {
              if (callBack != null) callBack();
            },
          ),
          Visibility(
              visible: state == ListState.HINT_NO_DATA_CLICK,
              child: GestureDetector(
                  child: Container(
                      margin: EdgeInsets.only(top: UIData.spaceSize8), child: CommonText.lightGrey15Text('暂无数据')),
                  onTap: () {
                    if (callBack != null) callBack();
                  })),
          FlatButton(
              onPressed: () {
                if (callBack != null) callBack();
              },
              child: CommonText.grey15Text('刷新')),
          SizedBox(height: UIData.spaceSize48),
        ],
      ),
    );
  }
}
