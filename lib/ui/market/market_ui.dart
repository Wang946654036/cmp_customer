import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/models/market/ware_comment_response.dart';
import 'package:cmp_customer/models/pgc/pgc_comment_obj.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_image_display.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/pgc/pgc_ui.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/date_util.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';

import 'market_basedata.dart';

//评论列表
class MarketDiscussItem extends StatelessWidget {
  Function onMessageTap;
  PgcInfoType infoType;
  List<String> photoIdList;
  Record info;
  MarketDiscussItem(this.info,
      {this.onMessageTap, this.infoType = PgcInfoType.infomation});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: UIData.primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //留言信息
          Container(
            padding: EdgeInsets.symmetric(
                vertical: UIData.spaceSize12, horizontal: UIData.spaceSize16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                //头像
                Container(
                  height: UIData.spaceSize18 * 2,
                  width: UIData.spaceSize18 * 2,
                  margin: EdgeInsets.only(right: UIData.spaceSize12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(UIData.spaceSize18),
                    border: Border.all(color: UIData.primaryColor, width: 1),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(UIData.spaceSize18),
                    child: StringsHelper.isNotEmpty(
                            info?.userPicture?.attachmentUuid)
                        ? FadeInImage.assetNetwork(
                            placeholder: UIData.imagePayServiceDefault,
                            image: StringsHelper.isNotEmpty(
                                    info?.userPicture?.attachmentUuid)
                                ? HttpOptions.showPhotoUrl(
                                    info?.userPicture?.attachmentUuid)
                                : '',
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            UIData.imagePortrait,
                            fit: BoxFit.fill,
                          ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          CommonText.grey16Text(info?.nickName ?? ''),
                          SizedBox(
                            width: UIData.spaceSize8,
                          ),
                          Visibility(
                            visible: info?.isOwner == "1",
                            child: CommonText.blue14Text('主人'),
                          )
                        ],
                      ),
                      CommonText.lightGrey12Text(
                          getProjectAndCity(info?.projectName, info?.city))
                    ],
                  ),
                ),
                CommonText.lightGrey12Text(
                    DateUtils.getTheCommentTime(info?.createTime))
              ],
            ),
          ),
          //留言内容
          GestureDetector(
            child: Container(
                padding: EdgeInsets.only(
                    left: UIData.spaceSize16,
                    right: UIData.spaceSize16,
                    bottom: UIData.spaceSize12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Visibility(
                      visible: info?.replyName != null,
                      child: CommonText.grey14Text("回复"),
                    ),
                    Visibility(
                      visible: info?.replyName != null,
                      child: CommonText.darkGrey14Text(
                          '${info?.replyName ?? ""}：'),
                    ),
                    Expanded(
                      child: CommonText.grey14Text(info?.content ?? '',
                          overflow: TextOverflow.visible),
                    )
                  ],
                )),
            onTap: () {
              if (onMessageTap != null) onMessageTap();
            },
          ),
        ],
      ),
    );
  }
}
