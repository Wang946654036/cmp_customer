import 'package:cmp_customer/main.dart';
import 'package:cmp_customer/models/user_data_model.dart';
import 'package:cmp_customer/models/work_order_vo.dart';
import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/ui/common/common_button.dart';
import 'package:cmp_customer/ui/common/common_divider.dart';
import 'package:cmp_customer/ui/common/common_image_picker.dart';
import 'package:cmp_customer/ui/common/common_picker.dart';
import 'package:cmp_customer/ui/common/common_scaffold.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/ui/work_other/choose_house.dart';
import 'package:cmp_customer/ui/work_other/successful_appointment.dart';
import 'package:cmp_customer/ui/work_other/work_other_ui.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:scoped_model/scoped_model.dart';

///有偿服务预约
class PayServiceCheckPage extends StatefulWidget {
  WorkOrderVo workOrderVo; //传进来的info，有可能与网络的不符，所以需要获取

  List<Map> myList;

  PayServiceCheckPage(this.workOrderVo, this.myList) {
    workOrderVo.customerName = stateModel.customerName;
    ;
    workOrderVo.customerPhone = stateModel.userAccount;
    workOrderVo.customerId = stateModel.customerId;
    workOrderVo.houseId = stateModel.defaultHouseId;
    workOrderVo.projectId = stateModel.defaultProjectId ?? -1;

    workOrderVo.buildId = stateModel.defaultBuildingId ?? -1;
    workOrderVo.unitId = stateModel.defaultUnitId ?? -1;
    workOrderVo.orderCategory = 'WY';
    workOrderVo.customerAddress = (stateModel.defaultProjectName ?? '') +
        (stateModel.defaultBuildingName ?? '') +
        (stateModel.defaultUnitName ?? '') +
        (stateModel.defaultHouseName ?? '');
  }

  @override
  _PayServiceCheckPageState createState() => new _PayServiceCheckPageState();
}

class _PayServiceCheckPageState extends State<PayServiceCheckPage> {
//  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new CommonScaffold(
        appTitle: '确认预约',
        bodyData: _buildContent(),
        bottomNavigationBar: _buildNavigationBar());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    stateModel.workOtherCreateState = ListState.HINT_DISMISS;
    stateModel.cleanWorkOthersDetailModel();
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
            enable: stateModel.workOtherCreateState != ListState.HINT_LOADING,
            margin:
                EdgeInsets.only(left: UIData.spaceSize30 + UIData.spaceSize2),
            btnType: ButtonType.CONFIRM,
            onTap: () {
              String tips = '亲，';

//              if (widget.workOrderVo.houseId==null){
//                tips += '预约地点、';
//              }
              if (StringsHelper.isEmpty(widget.workOrderVo.appointmentTime)) {
                tips += '预约时间、';
              }
//              if (widget.workOrderVo.paidStyleList==null||widget.workOrderVo.paidStyleList.length==0){
//                tips += '款式、';
//              }
              if (StringsHelper.isEmpty(widget.workOrderVo.reportContent)) {
                widget.workOrderVo.reportContent = '暂无';
              }
              if (tips.endsWith('、')) {
                tips = tips.substring(0, tips.length - 1);
                CommonToast.show(
                    msg: tips + '不能为空', type: ToastIconType.FAILED);
              } else {
                bool photosFlag = true;
                if (widget.workOrderVo.workOrderPhotoList != null)
                  widget.workOrderVo.workOrderPhotoList.forEach((str) {
                    if (str == null) {
                      CommonToast.show(
                          msg: "尚有未上传完成的图片", type: ToastIconType.FAILED);
                      photosFlag = false;
                      return;
                    }
                  });
                if (!photosFlag) {
                  return;
                }

                stateModel.commitWorkOther(
                    workOther: widget.workOrderVo,
                    callBack: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return SuccessfulAppointmentPage();
                      }));
                    });
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return ScopedModelDescendant<MainStateModel>(
      builder: (context, child, model) {
        return _buildWidget();
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget _buildWidget() {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        ///选择预约地点
        Container(
          margin: EdgeInsets.only(bottom: UIData.spaceSize12),
          padding: EdgeInsets.symmetric(
              horizontal: UIData.spaceSize16, vertical: UIData.spaceSize12),
          color: Colors.white,
          child: GestureDetector(
            onTap: () {
              navigatorKey.currentState
                  .push<HouseInfo>(MaterialPageRoute(builder: (context) {
                return ChooseHousePage();
              })).then((HouseInfo model) {
                if (model != null) {
                  setState(() {
                    widget.workOrderVo.customerAddress =
                        '${model?.formerName ?? ''}${model?.buildName ?? ''}${model?.unitName ?? ''}${model?.houseNo ?? ''}';
                    widget.workOrderVo.houseId = model?.houseId;
                    widget.workOrderVo.projectId = model?.projectId ?? -1;
                    widget.workOrderVo.buildId = model?.buildId ?? -1;
                    widget.workOrderVo.unitId = model?.unitId ?? -1;
                  });
                }
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CommonText.darkGrey15Text(appointment_address),
                SizedBox(
                  width: UIData.spaceSize30,
                ),
                Expanded(
                    child: widget.workOrderVo.houseId == null ||
                            widget.workOrderVo.customerAddress == null
                        ? CommonText.lightGrey16Text(hint_text_no_choose)
                        : CommonText.darkGrey16Text(
                            widget.workOrderVo.customerAddress,
                            overflow: TextOverflow.fade)),
                Icon(
                  Icons.keyboard_arrow_right,
                  color: UIData.iconGreyColor,
                ),
              ],
            ),
          ),
        ),
//            CommonDivider(),
        ///选择预约时间
        Container(
          margin: EdgeInsets.only(bottom: UIData.spaceSize12),
          padding: EdgeInsets.symmetric(
              horizontal: UIData.spaceSize16, vertical: UIData.spaceSize12),
          color: Colors.white,
          child: GestureDetector(
            onTap: () {
              CommonPicker.datePickerModal(context,
                  type: PickerDateTimeType.kYMDHM,
                  needTime: true, onConfirm: (String date) {
                setState(() {
                  widget.workOrderVo.appointmentTime = date;
                });
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CommonText.darkGrey15Text(appointment_time),
                SizedBox(
                  width: UIData.spaceSize30,
                ),
                Expanded(
                    child: widget.workOrderVo.appointmentTime == null
                        ? CommonText.lightGrey16Text(hint_text_choose)
                        : CommonText.darkGrey16Text(
                            widget.workOrderVo.appointmentTime)),
                Icon(
                  Icons.keyboard_arrow_right,
                  color: UIData.iconGreyColor,
                ),
              ],
            ),
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

        Container(
            //上传照片
            color: Colors.white,
            child: Column(
              children: <Widget>[
                leftTextWidget(text: "上传照片", topSpacing: UIData.spaceSize16),
                Container(
                  margin: EdgeInsets.all(UIData.spaceSize16),
                  child: CommonImagePicker(callback: setImageList),
                )
              ],
            )),
        CommonDivider(),
        Container(
            color: Colors.white,
            padding: EdgeInsets.only(right: UIData.spaceSize16),
            margin: EdgeInsets.only(top: UIData.spaceSize12),
            child: Column(
              children: <Widget>[
                leftTextWidget(
                  text: '备注',
                  topSpacing: UIData.spaceSize16,
                ),
                inputWidget(
//                      controller: controller,
                  hint_text: hint_text,
                  maxLength: 200,
                  bottomSpace: UIData.spaceSize16,
                  editTopPadding: UIData.spaceSize4,
                  editBotPadding: UIData.spaceSize30,
                  onChanged: (str) {
                    widget.workOrderVo.reportContent = str;
                  },
                )
              ],
            )),
      ],
    ));
  }

  List<Widget> getSpcWidgetList() {
    List<Widget> widgetList = new List();
    for (int i = 0; i < widget.myList.length; i++) {
      widgetList.add(ChoiceChip(
        label: Text(widget.myList[i]['key']),
        selected: widget.myList[i]['bool'],
        selectedColor: UIData.themeBgColor,
        backgroundColor: Color(0xFFEFEFEF),
        labelStyle: widget.myList[i]['bool']
            ? TextStyle(
                color: UIData.primaryColor,
                fontSize: UIData.fontSize14,
              )
            : TextStyle(
                color: UIData.lightGreyColor,
                fontSize: UIData.fontSize14,
              ),
        onSelected: (bool value) {
          setState(() {
            widget.myList[i]['bool']
                ? widget.myList[i]['bool'] = false
                : widget.myList[i]['bool'] = true;
            if (widget.workOrderVo.paidStyleList == null) {
              widget.workOrderVo.paidStyleList = new List();
            }
            widget.workOrderVo.paidStyleList.clear();
            widget.myList.forEach((info) {
              if (info['bool']) {
                widget.workOrderVo.paidStyleList.add(info['key']);
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

  setImageList(List<String> list) {
    if (widget.workOrderVo.workOrderPhotoList == null) {
      widget.workOrderVo.workOrderPhotoList = new List();
    }
    widget.workOrderVo.workOrderPhotoList.clear();
    widget.workOrderVo.workOrderPhotoList.addAll(list);
  }
}
