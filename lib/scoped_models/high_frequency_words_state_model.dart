import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/http/http_util.dart';
import 'package:cmp_customer/models/high_frequency_words_model.dart';
import 'package:cmp_customer/ui/work_other/work_other_ui.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:scoped_model/scoped_model.dart';

mixin HighFrequencyWordsStateModel on Model {
  ListState highFrequencyWordsState = ListState.HINT_LOADING;
  String complaintTypeStr;
  List<Data> higtwordsList = new List();

  //
  loadHightWordsList(WorkOtherMainType complaintType, {bool preRefresh = true}) {
    if (highFrequencyWordsState == ListState.HINT_LOADED_FAILED_CLICK ||
        highFrequencyWordsState == ListState.HINT_NO_DATA_CLICK) {
      preRefresh = true;
    }
    highFrequencyWordsState = ListState.HINT_LOADING;
    if (preRefresh) notifyListeners();

    _getHighWorks(complaintType);
  }

  //获取列表
  _getHighWorks(WorkOtherMainType complaintType) async {
    List highWorks;
    String type;

    switch (complaintType) {
      case WorkOtherMainType.Complaint:
        type = '0';
        complaintTypeStr = '投诉';
        break;
      case WorkOtherMainType.Warning:
        type = '1';
        complaintTypeStr = '公区报障';
        break;
      default:
        break;
    }
    Map<String, String> params = new Map();
    params['type'] = type;

    HttpUtil.post(HttpOptions.loginUrl, _highWorkCallBack,
        params: params, errorCallBack: _highWorkErrorCallBack);
  }

  _highWorkCallBack(data) {
//    HighFrequencyWorks model = HighFrequencyWorks.fromJson(json.decode(data));
//    LogUtils.printLog(complaintTypeStr+'高频词记录列表:$data');
//    if (model.code == '0') {
//      if (model.datas != null && model.datas.length > 0) {
//        highFrequencyWordsState = ListState.HINT_DISMISS;
//        higtwordsList.addAll(model.datas);
////        }
//
//      } else {
//        if (higtwordsList == null || higtwordsList.isEmpty) {
//          //nodata
//          highFrequencyWordsState = ListState.HINT_NO_DATA_CLICK;
//          higtwordsList.clear();
//        }
//      }
//    } else {
//      String failedDescri = FailedCodeTrans.enTochsTrans(failCode: model.code.toString(), failMsg: model.message);
//      highFrequencyWordsState = ListState.HINT_LOADED_FAILED_CLICK;
////      Fluttertoast.showToast(msg: failedDescri);
//    }
//    for (int i = 0; i < 20; i++)
//      higtwordsList.add(new Data(i, "1", "hahahahahahhaahahahah"));
//    notifyListeners();
  }

  void _highWorkErrorCallBack(errorMsg) {
    LogUtils.printLog('接口返回失败');

    notifyListeners();
  }
cleanHighFrequencyWordsStateModel(){
   highFrequencyWordsState = ListState.HINT_LOADING;
   complaintTypeStr;
   higtwordsList.clear();
}
  static HighFrequencyWordsStateModel of(context) =>
      ScopedModel.of<HighFrequencyWordsStateModel>(context);
}
