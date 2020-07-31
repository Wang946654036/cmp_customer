import 'package:cmp_customer/models/decoration_obj.dart';
import 'package:cmp_customer/models/meetingroom/meeting_room_info_obj.dart';
import 'package:cmp_customer/ui/conference_room_reservation/room_information_ui.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';

///会议室信息
class RoomsReservationInfoListView extends StatefulWidget {
 List<MeetingRoomInfo> infoList ;

  RoomsReservationInfoListView(this.infoList);

  @override
  _RoomsReservationInfoListViewState createState() {
    // TODO: implement createState

    return _RoomsReservationInfoListViewState();
  }
}
class _RoomsReservationInfoListViewState extends State<RoomsReservationInfoListView>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: UIData.primaryColor,
      child: Column(
        children: <Widget>[

          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.infoList.length,
            //展开全部，收起后，若最后一条主节点有子节点只显示最后的主节点以及其下的所有子节点，若最后一条没有子节点则
            itemBuilder: (BuildContext contex, int index) {

              MeetingRoomInfo node = widget.infoList[index];
              return RoomInformationView(index+1,node);
            },
          ),


        ],
      ),
    );;
  }

}