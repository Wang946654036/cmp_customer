import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';

class CommonLoadMore extends StatelessWidget {
  final bool noMore;

  CommonLoadMore([this.noMore = false]);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Center(
        child: Text(
          noMore ? '没有更多内容了！' : '加载中...',
          style: TextStyle(fontSize: UIData.fontSize12, color: UIData.greyColor),
        ),
      ),
    );
  }
}
class CommonLoadMoreForPgc extends StatelessWidget {

  String tips;
  CommonLoadMoreForPgc({this.tips});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Center(
        child: Text(
          tips??'还没评论 快来说两句',
          style: TextStyle(fontSize: UIData.fontSize12, color: UIData.greyColor),
        ),
      ),
    );
  }
}

