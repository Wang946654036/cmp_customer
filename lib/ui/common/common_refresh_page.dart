import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../main.dart';
import 'common_button.dart';
import 'common_text.dart';

///
/// Created by qianlx on 2020/7/3 4:14 PM.
/// 首页和服务里面加载失败刷新的使用页面
///
class CommonRefreshPage extends StatefulWidget {
  final Function callbackRefresh;
  CommonRefreshPage({this.callbackRefresh});

  @override
  _CommonRefreshPageState createState() => _CommonRefreshPageState();
}

class _CommonRefreshPageState extends State<CommonRefreshPage> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainStateModel>(builder: (context, child, model) {
      return Container(
        color: UIData.primaryColor,
//            padding: EdgeInsets.all(UIData.spaceSize30),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
//            CommonText.darkGrey16Text('功能建设中', textAlign: TextAlign.center, fontWeight: FontWeight.w500),
//            SizedBox(height: UIData.spaceSize16),
              Container(
                alignment: Alignment.center,
                height: ScreenUtil.getInstance().setWidth(135),
                child: Image.asset(
                  UIData.imageNoNetwork,
                  fit: BoxFit.fitHeight,
                ),
              ),
              SizedBox(height: UIData.spaceSize30),
//            CommonText.darkGrey18Text('关注公众号“招商到家汇”', textAlign: TextAlign.center),
//            SizedBox(height: UIData.spaceSize20),
              CommonText.darkGrey15Text(
                  StringsHelper.isNotEmpty(model.baseDataLoadedFailedMsg)
                      ? model.baseDataLoadedFailedMsg
                      : '亲，您的手机网络不大顺畅哦，请检查网络设置',
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.fade),
              SizedBox(height: UIData.spaceSize40),
              StadiumSolidButton('刷新', onTap: () {
                if(widget.callbackRefresh != null) widget.callbackRefresh();
              }),
            ],
          ),
        ),
      );
    });
  }
}
