///会议室信息ui
///
import 'package:cmp_customer/models/change_title_obj.dart';
import 'package:cmp_customer/models/decoration_obj.dart';
import 'package:cmp_customer/models/meetingroom/meeting_room_info_obj.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/ui/brand_name/brand_name_ui.dart';
import 'package:cmp_customer/ui/common/common_animation.dart';
import 'package:cmp_customer/ui/common/common_audio_player.dart';
import 'package:cmp_customer/ui/common/common_audio_players.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_image_display.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/decorate_manager/decoration_ui.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
///会议室信息

getReservationStateStr(String state){
  //DSL-待受理，SLBTG-受理不通过，DJF-待缴费，JFCS-缴费超时，YDCG-预定成功，YQX-已取消
  switch(state){
    case 'DSL':
      return '待受理';
      break;
    case 'SLBTG':
      return '受理不通过';
      break;
    case 'DJF':
      return '待缴费';
      break;
    case 'JFCS':
      return '缴费超时';
      break;
    case 'YDCG':
      return '预定成功';
      break;
    case 'YQX':
      return '已取消';
      break;
  }
}


class RoomInformationView extends StatefulWidget {
  int position;
  MeetingRoomInfo node;
  RoomInformationView(this.position,this.node);

  @override
  _RoomInformationViewState createState() {
    // TODO: implement createState

    return _RoomInformationViewState();
  }
}

class _RoomInformationViewState extends State<RoomInformationView> {
  String WorkOtherProcessNodeTitle;
  MeetingRoomInfo info;
  bool isExpaned = false; //是否已拓展

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WorkOtherProcessNodeTitle = '会议室${widget.position}';
    info = widget.node;
  }

  _launchPHONE({String phone = ''}) async {
    String url = 'tel://' + phone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      color: UIData.primaryColor,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize16),
            child: Row(
              children: <Widget>[
                CommonText.black16Text(WorkOtherProcessNodeTitle,
                    textAlign: TextAlign.left),
                SizedBox(
                  width: UIData.spaceSize16,
                ),
                Expanded(
                  child: CommonText.black16Text(info.roomName??'',
                      textAlign: TextAlign.left),
                ),
                ArrowRotateWidget((onChanged) {
                  setState(() {
                    isExpaned = onChanged;
                  });
                }),
              ],
            ),
          ),
          Visibility(
            child: Container(
              padding: EdgeInsets.only(
                  bottom: UIData.spaceSize12,
                  top: UIData.spaceSize8,
                  left: UIData.spaceSize16,
                  right: UIData.spaceSize16),
              child: CommonImageDisplay(
                  photoIdList: getFileList(info.roomPhotoList)),
            ),
            visible:isExpaned&& info.roomPhotoList!=null&&info.roomPhotoList.length>0,
          ),
          Visibility(
            child: labelTextWidget(
              label: '位置',
              text: info.address ?? '暂无',
              topSpacing: UIData.spaceSize12,
            ),
            visible:isExpaned&& StringsHelper.isNotEmpty(info.address),
          ),
          Visibility(
            child: labelTextWidget(
              label: '使用人数',
              text: info.peopleNum?.toString() ?? '暂无',
              unit: '人',
              topSpacing: UIData.spaceSize12,
            ),
            visible:isExpaned&& StringsHelper.isNotEmpty(info.peopleNum?.toString()??''),
          ),
          Visibility(
            child: labelTextWidget(
              label: '预约日期',
              text: info.orderDate?? '暂无',
              topSpacing: UIData.spaceSize12,
            ),
            visible:isExpaned&& StringsHelper.isNotEmpty(info.orderDate),
          ),
          Visibility(
            visible:isExpaned&& (info.meetingSubOrderTimeVoList?.length??0) > 0,
            child: labelListWidget(
                  (BuildContext context, int index) {
                return labelTextWidget(topSpacing: UIData.spaceSize12,leftSpacing: 0,label: "${info.meetingSubOrderTimeVoList[index].beginTime}-${info.meetingSubOrderTimeVoList[index].endTime}");
              },
              info.meetingSubOrderTimeVoList?.length ?? 0,
              label: '时间段',
              topSpacing: UIData.spaceSize12,
            ),
          ),
          Visibility(
            visible:isExpaned&& (info.deviceSelectList?.length??0) > 0,
            child: labelListWidget(
                  (BuildContext context, int index) {
                return labelTextWidget(topSpacing: UIData.spaceSize12,leftSpacing: 0,label: '${info.deviceSelectList[index].name}',text: '${info.deviceSelectList[index].point??''}${info.deviceSelectList[index].measure??''}',);
              },
              info.deviceSelectList?.length ?? 0,
              label: '设备需求',
              topSpacing: UIData.spaceSize12,
            ),
          ),
          Visibility(
            child: labelTextWidget(
              label: '其他设备',
              text: info.deviceOther ?? '暂无',
              topSpacing: UIData.spaceSize12,
            ),
            visible:isExpaned&& StringsHelper.isNotEmpty(info.deviceOther),
          ),
          Visibility(
            visible:isExpaned&& (info.serviceSelectList?.length??0) > 0,
            child: labelListWidget(
                  (BuildContext context, int index) {
                return labelTextWidget(topSpacing: UIData.spaceSize12,leftSpacing: 0,label: '${info.serviceSelectList[index].name}',text: '${info.serviceSelectList[index].point??''}${info.serviceSelectList[index].measure??''}',);
              },
              info.serviceSelectList?.length ?? 0,
              label: '服务需求',
topSpacing: UIData.spaceSize12,
            ),
          ),
          Visibility(
            child: labelTextWidget(
              label: '其他服务',
              text: info.serviceOther ?? '暂无',
              topSpacing: UIData.spaceSize12,
            ),
            visible:isExpaned&& StringsHelper.isNotEmpty(info.serviceOther),
          ),
          Visibility(visible: isExpaned,child: SizedBox(height: UIData.spaceSize12,),),
          CommonDivider()
        ],
      ),
    );
  }
}
List<String> getFileList(List<Attachment> attFileList) {
  List<String> strs = new List();
  if (attFileList != null)
    attFileList.forEach((info) {
      strs.add(info.attachmentUuid);
    });
  return strs;
}
//标签与文本
class labelListWidget extends StatelessWidget {
  Function contentWidget; //内容
  String label; //标签
  int itemCount;
  bool isBold;
  bool needArrow;
  Color labelColor; //标签字体颜色
  double topSpacing; //头部间距
  double bottomSpacing; //底部间距
  double leftSpacing; //左边间距
  TextAlign textAlign;

  labelListWidget(this.contentWidget, this.itemCount,
      {this.label = "",
      this.isBold = false,
      this.needArrow = false,
      this.labelColor = color_text_gray,
      this.topSpacing = 0,
      this.bottomSpacing = 0,
      this.leftSpacing,
      this.textAlign});

//  @override
//  State<StatefulWidget> createState() {
//    // TODO: implement createState
//    return labelText();
//  }
//}
//class labelText extends State<labelTextWidget>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(
              left: leftSpacing ?? UIData.spaceSize16,
              top: topSpacing,
              bottom: bottomSpacing),
          width: label_width,
          child: Text(label,
              style: TextStyle(fontSize: normal_text_size, color: labelColor)),
        ),
        Expanded(
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: itemCount??0,
              itemBuilder: (BuildContext context, int index) {
                return contentWidget(context, index);
              }),
        ),
      ],
    );
  }
}
