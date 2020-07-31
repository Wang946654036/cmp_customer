import 'package:cmp_customer/models/pgc/pgc_topic_obj.dart';
import 'package:cmp_customer/scoped_models/pgc_model/pgc_topic_model.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/pgc/pgc_topic/pgc_topic_detail.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../pgc_ui.dart';

class PgcTopicItem extends StatelessWidget {
  PgcTopicInfo info;
  PgcTopicListModel _model;
  PgcTopicItem(
    this.info,
      this._model
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return PgcTopicDetail(
            info,_model
          );
        }));
      },
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.only(top: UIData.spaceSize12),
        padding: EdgeInsets.all(UIData.spaceSize16),
        child: Column(
          children: <Widget>[
            //展示图
            Container(
              height: UIData.spaceSize30 * 2 + UIData.spaceSize10,
              width: UIData.spaceSize30 * 3 + UIData.spaceSize3,
              margin: EdgeInsets.only(right: UIData.spaceSize12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: UIData.yellowColor, width: 1),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: FadeInImage.assetNetwork(
                  placeholder: UIData.imagePayServiceDefault,
                  image:
//                  info.posterPhotoList != null &&
//                          info.posterPhotoList.length > 0
//                      ? HttpOptions.showPhotoUrl(info.posterPhotoList[0].uuid)
//                      :
                      '',
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(right: UIData.spaceSize20),
              padding: EdgeInsets.symmetric(vertical: UIData.spaceSize3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  //标题
                  Row(
                    children: <Widget>[
                      Visibility(
                        visible: true,
                        child: Container(
                          constraints: BoxConstraints(
                            minWidth: UIData.spaceSize48,
                          ),
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(right: UIData.spaceSize16),
                          child: Container(
                            constraints: BoxConstraints(
                              minWidth: UIData.spaceSize30,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  ScreenUtil.getInstance().setHeight(15)),
                              border:
                                  Border.all(color: UIData.yellowColor),
                              color: UIData.primaryColor,
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    ScreenUtil.getInstance().setHeight(8)),
                            //                height: ScreenUtil.getInstance().setHeight(16),
                            alignment: Alignment.center,
                            child: CommonText.text10('置顶',
                                color: UIData.yellowColor),
                          ),
                        ),
                      ),
                      Expanded(child: CommonText.black16Text('Title')),
                    ],
                  ),
                  Expanded(
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      runAlignment: WrapAlignment.start,
                      spacing: UIData.spaceSize10,
                      runSpacing: UIData.spaceSize3 * 2,
                      children: getSpcWidgetList(
                          types: ['1', '2', '3', 'a', 'b', 'c']),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          PgcIconTextView(
                            leading: UIData.iconWenzhangliulanshu,
                            child: CommonText.grey14Text(getPGCNumb(13956)),
                            canClick: false,
                          ),
                          PgcIconTextView(
                            leading: UIData.iconPinlun,
                            child: CommonText.grey14Text(getPGCNumb(19356)),
                            canClick: false,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getSpcWidgetList({List<String> types}) {
    List<Widget> widgetList = new List();
    if (types != null)
      for (int i = 0; i < types.length; i++) {
        widgetList.add(CommonLabel(
          '#${types[i]}',
          textColor: UIData.themeBgColor,
          backgroundColor: UIData.themeBgColor70,
        ));
      }

    return widgetList;
  }
}
