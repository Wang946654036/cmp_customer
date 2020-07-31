
import 'package:cmp_customer/utils/constant.dart';

class Page {
  Page({this.label, this.tag});

  String label;
  var tag;

  String get id => label[0];

//  set label(label) {
//    this.label = label;
//  }

  @override
  String toString() => '$runtimeType("$label--$tag")';
}

class ListPage extends Page {
  int currentPage;
  bool maxCount;
  ListState listState;
  int refreshHint;

  ListPage(
      {String label,
      var tag,
      this.currentPage = 1,
      this.maxCount = false,
      this.listState = ListState.HINT_LOADING,
      this.refreshHint = 0})
      : super(label: label, tag: tag);
}

class ListPageModel {
  List list = List();
  ListPage listPage = ListPage();
}

class DetailPageModel {
  var detail;
  ListState pageState = ListState.HINT_LOADING;
}
