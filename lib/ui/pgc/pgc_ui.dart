import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/models/pgc/pgc_comment_obj.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_image_display.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/date_util.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';

class PgcIconTextView extends StatefulWidget {
  Widget leading;
  Widget child;
  Function onTap;
  bool canClick;
  Color checkedColor;

  PgcIconTextView(
      {this.leading,
      this.child,
      this.onTap,
      this.canClick = true,
      this.checkedColor});

  @override
  State<StatefulWidget> createState() => PgcIconTextViewState();
}

class PgcIconTextViewState extends State<PgcIconTextView> {
  bool isClick = false;

  Widget _buildWidget() {
    return GestureDetector(
      child: Container(
        alignment: Alignment.centerRight,

        color: UIData.primaryColor,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
//        width: UIData.spaceSize30,
//        height: UIData.spaceSize30,
              child: IconTheme(
                  data: IconThemeData(
                      color: isClick
                          ? (widget.checkedColor ?? UIData.greyColor)
                          : UIData.greyColor,
                      size: 20.0),
                  child: widget.leading),
            ),
SizedBox(width: UIData.spaceSize3),
                DefaultTextStyle(
                    style: TextStyle(
                        color: isClick
                            ? (widget.checkedColor ?? UIData.greyColor)
                            : UIData.greyColor,
                        fontSize: UIData.fontSize14),
                    child: widget.child)
          ],
        ),
      ),
      onTap: () {
        if (widget.canClick && widget.onTap != null) {
          var flag = widget.onTap();
          if (flag != null && flag is bool)
            setState(() {
              isClick = flag;
            });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidget();
  }
}
enum PgcInfoType {
  infomation,//
  topic,//

}
//评论列表
class PgcDiscussItem extends StatelessWidget {
  Function onDianZanClick;
  PgcInfoType infoType;
  List<String> photoIdList;
  PgcCommentInfo info;
  PgcDiscussItem(this.info,{this.onDianZanClick,this.infoType = PgcInfoType.infomation});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: UIData.primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //评论人信息
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
                    border:
                        Border.all(color: UIData.primaryColor, width: 1),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(UIData.spaceSize18),
                    child: FadeInImage.assetNetwork(
                      placeholder: UIData.imagePayServiceDefault,
                      image: StringsHelper.isNotEmpty(info?.custPhoto)
                          ? HttpOptions.showPhotoUrl(info.custPhoto)
                          :'',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CommonText.grey16Text(info?.nickname??''),

                      CommonText.lightGrey12Text('${info?.formerName??''}')
                    ],
                  ),
                ),
                PgcIconTextView(
                    leading: (info?.custLike??'0')=='1'?UIData.iconDianzan2
                    : UIData.iconDianzan,
                    child: CommonText.grey14Text(getPGCNumb(info?.likeCount??0)),
                    canClick: true,
                    onTap: onDianZanClick),
              ],
            ),
          ),

//客户评论
          Visibility(visible: infoType == PgcInfoType.topic,child:  Container(
            padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize16),
            child: Text.rich(new TextSpan(children: [
              TextSpan(
                  text: "#我是话题# ",
                  style: TextStyle(
                      color: UIData.underlineBlueColor,
                      fontSize: UIData.fontSize14)),
              TextSpan(
                  text: info?.content??'',
                  style: TextStyle(
                      color: UIData.greyColor, fontSize: UIData.fontSize14))
            ])),
//            child: CommonText.grey14Text("我是内容我是内容我是内容"),
          ),),
          Visibility(visible: infoType == PgcInfoType.infomation,child:  Container(
            padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize16),
            child: CommonText.grey14Text(info?.content??''),
          ),),

          SizedBox(
            height: UIData.spaceSize8,
          ),
          CommonImageDisplay(
            photoIdList: photoIdList,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize16),

            child:Row(mainAxisAlignment:MainAxisAlignment.end,children: <Widget>[CommonText.lighterGrey12Text(
                DateUtils.getTheCommentTime(info?.createTime??'')),],) ,
          ),

          //客服点赞
          Visibility(
            visible: StringsHelper.isNotEmpty(info?.userLike??'')&&info?.userLike=='1',
            child: Container(
              margin: EdgeInsets.only(left: UIData.spaceSize8,right: UIData.spaceSize8,bottom:UIData.spaceSize10,top: UIData.spaceSize12 ),
              padding: EdgeInsets.symmetric(
                  vertical: UIData.spaceSize8, horizontal: UIData.spaceSize10),
              color: UIData.lightestGreyColor70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      //头像
                      Container(
                        height: UIData.spaceSize20,
                        width: UIData.spaceSize20,
                        margin: EdgeInsets.only(right: UIData.spaceSize12),
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(UIData.spaceSize10),
                          border: Border.all(
                              color: UIData.lighterGreyColor, width: 1),
                        ),
                        child: ClipRRect(
                          borderRadius:
                          BorderRadius.circular(UIData.spaceSize10),
                          child: Image.asset(
                            UIData.imageZhaoxiaotong,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Expanded(
                        child: CommonText.grey14Text("招小通"),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: UIData.spaceSize6,
                  ),
                  CommonText.grey12Text('给您点了个赞！'),

                ],
              ),
            ),
          ),


          //客服回复
          Visibility(
            visible: StringsHelper.isNotEmpty(info?.reply??''),
            child: Container(
              margin: EdgeInsets.only(left: UIData.spaceSize8,right: UIData.spaceSize8,top: UIData.spaceSize12 ),

              padding: EdgeInsets.symmetric(
                  vertical: UIData.spaceSize8, horizontal: UIData.spaceSize10),
              color: UIData.lightestGreyColor70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      //头像
                      Container(
                        height: UIData.spaceSize20,
                        width: UIData.spaceSize20,
                        margin: EdgeInsets.only(right: UIData.spaceSize12),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(UIData.spaceSize10),
                          border: Border.all(
                              color: UIData.lighterGreyColor, width: 1),
                        ),
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(UIData.spaceSize10),
                          child: Image.asset(
                            UIData.imageZhaoxiaotong,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Expanded(
                        child: CommonText.grey14Text("招小通"),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: UIData.spaceSize6,
                  ),
                  CommonText.grey12Text(info?.reply??''),
                  SizedBox(
                    height: UIData.spaceSize6,
                  ),
                  Container(child:  CommonText.lighterGrey12Text(
                      DateUtils.getTheCommentTime(info?.replyTime??'')),alignment: Alignment.centerRight,),

                ],
              ),
            ),
          ),
          SizedBox(
            height: UIData.spaceSize12,
          ),
          Container(padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize16),child: CommonFullDottedScaleDivider(),)

        ],
      ),
    );
  }
}

List<Widget> getSpcWidgetList({List<String> types}) {
  List<Widget> widgetList = new List();
  if (types != null)
    for (int i = 0; i < types.length; i++) {
      if(StringsHelper.isNotEmpty(types[i].trim()))
      widgetList.add(CommonLabel(
        '#${types[i]}',
        textColor: UIData.pgcBlueTextColor,
        backgroundColor: UIData.pgcBlueColor,
      ));
    }

  return widgetList;
}

String getPGCNumb(int count) {
  if (count != null) {
    if (count < 10000) {
      return count.toString();
    } else {
      double numb = count / 10000;
      String numbstr = '${numb.toStringAsFixed(1)}w';
      return numbstr;
    }
  } else {
    return '0';
  }
}
