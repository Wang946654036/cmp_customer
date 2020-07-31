import 'dart:typed_data';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/pgc/pgc_infomation_obj.dart';
import 'package:cmp_customer/models/response/topic_list_response.dart';
import 'package:cmp_customer/scoped_models/collect/topic_list_model.dart';
import 'package:cmp_customer/scoped_models/pgc_model/pgc_infomation_model.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_image_widget.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/html/html_page.dart';
import 'package:cmp_customer/ui/pgc/pgc_infomation/pgc_infomation_detail.dart';
import 'package:cmp_customer/ui/pgc/pgc_ui.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/navigate.dart';
import 'package:cmp_customer/utils/shared_preferences_key.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//话题
class TopicItem extends StatelessWidget {
  TopicInfo info;
  TopicListModel model;
  Function refreshCallback;
  Function onClickCallback;

  TopicItem(this.info, this.model,
      {this.refreshCallback, this.onClickCallback});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        _operateItem();
      },
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.only(top: UIData.spaceSize8),
        padding: EdgeInsets.symmetric(
            vertical: UIData.spaceSize12, horizontal: UIData.spaceSize16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Offstage(
              offstage: !model.isBulkCollectOperation,
              child: Checkbox(
                value:
                    model?.collectCheckedList?.contains(info.topicId) ?? false,
                onChanged: (checked) {
                  model.changedCollectCheckbox(checked, info?.topicId);
                },
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    height: UIData.spaceSize120,
                    margin: EdgeInsets.only(bottom: UIData.spaceSize4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(color: UIData.primaryColor, width: 1),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child: CommonImageWidget(info?.titlePic),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Visibility(
                          visible: info?.isTop == '1',
                          child: Container(
                            margin: EdgeInsets.only(bottom: UIData.spaceSize4),
                            child: CommonLabel(
                              '置顶',
                              textColor: UIData.pgcRedTextColor,
                              backgroundColor: UIData.pgcRedColor,
                            ),
                          )),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(bottom: UIData.spaceSize4,left: UIData.spaceSize4),
                          child: CommonText.black16Text(info?.topicTitle ?? '',
                              textAlign: TextAlign.left),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Visibility(
                          visible: StringsHelper.isNotEmpty(info?.keyword),
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            runAlignment: WrapAlignment.start,
                            spacing: UIData.spaceSize4,
                            runSpacing: UIData.spaceSize4,
                            children: [
                              CommonLabel(
                                '#${info?.keyword?.replaceAll(',', '  #')?.replaceAll('，', '  #')}',
                                textColor: UIData.pgcBlueTextColor,
                                backgroundColor: UIData.pgcBlueColor,
                              )
                            ],
                          ),
                        )
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        child: Row(
                          children: <Widget>[
                            PgcIconTextView(
                              leading: UIData.iconWenzhangliulanshu,
                              child: CommonText.grey14Text(
                                  getPGCNumb(info?.browseCount ?? 0)),
                              canClick: false,
                            ),
                            SizedBox(width: UIData.spaceSize6),
                            PgcIconTextView(
                              leading: UIData.iconPinlun,
                              child: CommonText.grey14Text(
                                  getPGCNumb(info?.commentCount ?? 0)),
                              canClick: false,
                            ),
//                            SizedBox(width: UIData.spaceSize6),
//                            PgcIconTextView(
//                              leading: UIData.iconDianzan,
//                              child: CommonText.grey14Text(
//                                  getPGCNumb(info?.likeCount ?? 0)),
//                              canClick: false,
//                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  void _operateItem() async{
    if (model.isBulkCollectOperation) {
      bool checked = model?.collectCheckedList?.contains(info.topicId);
      model.changedCollectCheckbox(!checked, info?.topicId);
    } else {
      SharedPreferences prefs = await SharedPreferencesKey.globalPrefs;
      String token = prefs.getString(SharedPreferencesKey.KEY_ACCESS_TOEKN);
      Navigate.toNewPage(HtmlPage("${HttpOptions.baseUrl.replaceAll(
          "ubms-customer/",
          "")}template/appShare/topicDetails.html?projectId=${stateModel?.defaultProjectId}&token=$token&topicId=${info?.topicId}&closePage=1", "", showTitle: false,));
    }
  }
}
