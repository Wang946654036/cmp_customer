import 'package:cmp_customer/scoped_models/high_frequency_words_state_model.dart';
import 'package:cmp_customer/scoped_models/work_others_detail_model.dart';
import 'package:cmp_customer/scoped_models/work_others_list_model.dart';
import 'package:cmp_customer/scoped_models/work_others_process_node_model.dart';
import 'community_state_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'user_state_model.dart';
import 'house_state_model.dart';
import 'html_state_model.dart';

class HomeStateModel extends Model {

  int _mainCurrentIndex = 0; //首页tab页当前显示页面

  int get mainCurrentIndex => _mainCurrentIndex;

  set mainCurrentIndex(int value) {
    _mainCurrentIndex = value;
    notifyListeners();
  }

  static HomeStateModel of(context) => ScopedModel.of<HomeStateModel>(context);
}
