import 'dart:convert';

import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/project_model.dart';
import 'package:cmp_customer/models/work_order_vo.dart';
import 'package:cmp_customer/models/pay_service_info_list.dart';
import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_load_container.dart';
import 'package:cmp_customer/ui/common/common_picker.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/work_other/pay_service_check_other.dart';
import 'package:cmp_customer/ui/work_other/work_other_ui.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:scoped_model/scoped_model.dart';

///有偿服务预约
class PayServiceDetailPage extends StatefulWidget {
  PayServiceInfo payServiceInfo; //传进来的info，有可能与网络的不符，所以需要获取
  ProjectInfo projectInfo;

  PayServiceDetailPage(this.payServiceInfo);

  @override
  _PayServiceDetailPageState createState() => new _PayServiceDetailPageState();
}

class _PayServiceDetailPageState extends State<PayServiceDetailPage> {
  List<Map> myList = new List();
  WorkOrderVo workOrderVo = new WorkOrderVo(createSource: 'CreateByCustomerApp',validFlag : '1');

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new CommonScaffold(
        appTitle: widget.payServiceInfo.serviceName,
        bodyData: _buildContent(),
        bottomNavigationBar: _buildNavigationBar());
  }

  Widget _buildNavigationBar() {
    return Container(
      height: UIData.spaceSize30 * 2,
      padding: EdgeInsets.symmetric(
          vertical: UIData.spaceSize12, horizontal: UIData.spaceSize16),
      decoration: new BoxDecoration(
          color: Colors.white,
          border:
          Border(top: BorderSide(width: 1, color: UIData.dividerColor))),
      child: Row(
        children: <Widget>[
          Expanded(
            child: CommonText.lightGrey11Text(pay_service_appointment_tip),
          ),
          StadiumSolidButton(
            label_appointment,
            margin:
            EdgeInsets.only(left: UIData.spaceSize30 + UIData.spaceSize2),
            btnType: ButtonType.CONFIRM,
            onTap: () {
              workOrderVo.projectId = stateModel.defaultProjectId;
              workOrderVo.paidServiceId = widget.payServiceInfo.serviceConfId;
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return PayServiceCheckPage(workOrderVo,myList);
              }));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return ScopedModelDescendant<MainStateModel>(
      builder: (context, child, model) {
        if(stateModel?.payServiceInfo?.styleListName==null&&stateModel?.payServiceInfo?.styleListJson!=null)
          stateModel?.payServiceInfo?.styleListName=json.decode(stateModel?.payServiceInfo?.styleListJson);
        if(myList.length==0)
          for (int i = 0; i < (stateModel?.payServiceInfo?.styleListName?.length??0); i++) {
            Map map = {'key': stateModel?.payServiceInfo?.styleListName[i], 'bool': false};
            myList.add(map);
          }
        LogUtils.printLog(stateModel.showPayInfo.toString());
        return CommonLoadContainer(
            state: stateModel.showPayInfo,
            callback: _refresh,
            content: _buildWidget());
      },
    );
  }

  _refresh() {
    stateModel.getPayinfo(widget.payServiceInfo.serviceConfId);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.projectInfo = new ProjectInfo(projectId: stateModel.defaultProjectId) ;
    stateModel.payServiceInfo = widget.payServiceInfo;
    workOrderVo.serviceType = 'Paid';
    workOrderVo.serviceSubType=widget.payServiceInfo.serviceType;
    stateModel.getPayinfo(widget.payServiceInfo.serviceConfId);
  }

  Widget _buildWidget() {
    String url =   stateModel?.payServiceInfo?.posterPhotoList!=null&& (stateModel?.payServiceInfo?.posterPhotoList?.length ?? 0)>0?HttpOptions.showPhotoUrl(stateModel?.payServiceInfo?.posterPhotoList[0].uuid):'';
    LogUtils.printLog("url:"+url);
    return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: FadeInImage.assetNetwork(
                placeholder: UIData.imagePayServiceDetailDefault,
                image:     url,
                fit: BoxFit.contain,
              ),
            ),
//基础信息
            Container(
              color: UIData.primaryColor,
              padding: EdgeInsets.symmetric(
                  horizontal: UIData.spaceSize16, vertical: UIData.spaceSize18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CommonText.darkGrey18Text(stateModel?.payServiceInfo?.serviceName),
                  SizedBox(
                    height: UIData.spaceSize8,
                  ),
                  CommonText.lightGrey12Text(stateModel?.payServiceInfo?.serviceDesc,
                      maxLines: 2),
                  SizedBox(
                    height: UIData.spaceSize16,
                  ),
                  Row(
                    children: <Widget>[
                      CommonText.lighterRed15Text((stateModel.payServiceInfo?.priceRange!=null)?'￥' + stateModel?.payServiceInfo?.priceRange:no_price
                      ),
                      CommonText.lightGrey15Text(StringsHelper.isNotEmpty(
                          stateModel?.payServiceInfo?.priceUnit)
                          ? '/' + stateModel?.payServiceInfo?.priceUnit
                          : ''),
                    ],
                  )
                ],
              ),
            ),
            CommonDivider(),

            ///型号
            Container(
              color: UIData.primaryColor,
              padding: EdgeInsets.symmetric(
                  horizontal: UIData.spaceSize16, vertical: UIData.spaceSize12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CommonText.darkGrey15Text(spec),
                  SizedBox(
                    height: UIData.spaceSize3 * 2,
                  ),
                  Wrap(
                    alignment: WrapAlignment.start,
                    runAlignment: WrapAlignment.start,
                    spacing: UIData.spaceSize10,
                    runSpacing: UIData.spaceSize3 * 2,
                    children: getSpcWidgetList(),
                  ),
                ],
              ),
            ),
            CommonDivider(),

            ///服务时间
            Container(
              color: UIData.primaryColor,
              padding: EdgeInsets.symmetric(
                  horizontal: UIData.spaceSize16, vertical: UIData.spaceSize12),
              child: Row(
                children: <Widget>[
                  CommonText.darkGrey15Text(service_time),
                  SizedBox(
                    width: UIData.spaceSize30,
                  ),
                  CommonText.lightGrey15Text(stateModel?.payServiceInfo?.serviceTime)
                ],
              ),
            ),

//            CommonDivider(),

            ///选择预约时间

//            Container(
//
//              margin: EdgeInsets.only(bottom: UIData.spaceSize12),
//              padding: EdgeInsets.symmetric(
//                  horizontal: UIData.spaceSize16, vertical: UIData.spaceSize12),
//              color: Colors.white,
//              child: GestureDetector(
//                onTap: () {
//                  CommonPicker.datePickerModal(context,type:PickerDateTimeType.kMDYHM,needTime: true,onConfirm: (String date){
//                    setState(() {
//                      workOrderVo.appointmentTime=date;
//                    });
//
//                  });
//                },
//                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.start,
//                  children: <Widget>[
//                    CommonText.darkGrey15Text(appointment_time),
//                    SizedBox(width: UIData.spaceSize30,),
//                    Expanded(
//                        child:( workOrderVo.appointmentTime ==null|| workOrderVo.appointmentTime=='') ? CommonText.lightGrey16Text(hint_text_choose) : CommonText.darkGrey16Text( workOrderVo.appointmentTime)
//                    ),
//                    Icon(
//                      Icons.keyboard_arrow_right,
//                      color: UIData.iconGreyColor,
//                    ),
//                  ],
//                ),
//              ),
//            ),
            Visibility(
                visible: stateModel?.payServiceInfo?.showPhotoList!=null&&(stateModel?.payServiceInfo?.showPhotoList?.length ?? 0) > 0,
                child: _buildListView())
          ],
        ));
  }

  List<Widget> getSpcWidgetList() {


    List<Widget> widgetList = new List();
    for (int i = 0; i < myList.length; i++) {
      widgetList.add(ChoiceChip(
        label: Text(myList[i]['key']),
        selected: myList[i]['bool'],
        selectedColor: UIData.themeBgColor,
        backgroundColor: Color(0xFFEFEFEF),
        labelStyle: myList[i]['bool'] ? TextStyle(color: UIData.primaryColor, fontSize: UIData.fontSize14,) : TextStyle(color: UIData.lightGreyColor, fontSize: UIData.fontSize14,),
        onSelected: (bool value) {
          setState(() {
            myList[i]['bool']
                ? myList[i]['bool'] = false
                : myList[i]['bool'] = true;
            if(workOrderVo.paidStyleList==null){
              workOrderVo.paidStyleList = new List();
            }
            workOrderVo.paidStyleList.clear();
            myList.forEach((info){
              if(info['bool']){
                workOrderVo.paidStyleList.add(info['key']);
              }
            });
          });
        },
        shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(UIData.spaceSize12 + UIData.spaceSize3)),
      ));
    }

    return widgetList;
  }

  Widget _buildListView() {
    return ScopedModelDescendant<MainStateModel>(
        builder: (context, child, model) {
          return Container(
              color: Colors.white,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: stateModel.payServiceInfo?.showPhotoList?.length??0,
                itemBuilder: (BuildContext context, int index) {
                  return FadeInImage.assetNetwork(
                    placeholder: UIData.imagePayServiceDetailDefault,
                    image:stateModel?.payServiceInfo?.showPhotoList!=null&&(stateModel?.payServiceInfo?.showPhotoList?.length ?? 0)>0? HttpOptions.showPhotoUrl(stateModel?.payServiceInfo?.showPhotoList[index].uuid):'',
                    fit: BoxFit.contain,
                  );
                },
              ));
        });
  }
}

