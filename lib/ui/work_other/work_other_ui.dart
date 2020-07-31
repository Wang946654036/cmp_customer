import 'package:cmp_customer/http/http_options.dart';
import 'package:cmp_customer/models/pay_service_info_list.dart';
import 'package:cmp_customer/models/work_other_list.dart';
import 'package:cmp_customer/models/work_other_obj.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_text_field.dart';
import 'package:cmp_customer/ui/common/ensure_visible_when_focused.dart';
import 'package:cmp_customer/ui/work_other/pay_service_detail.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const String lable_Warning_loction = "报障地点";
const String label_submit = "提交";
const String label_appointment = "预约";
const String hint_text_choose_required = '请选择（必填）';
const String hint_text_required = "请输入 (必填)";
const String hint_text_choose = '请选择（必填）';
const String hint_text_no_choose = '暂无，请联系管理处';
const String hint_text = "请输入";
const String no_price = '暂无参考价格，需现场报价';
const String above = '以上';
const String below = '以下';
const String complaint = '投诉';
const String Warning = '公区报障';
const String Repair = '室内维修';
const String pay_service = '社区服务';
const String service_time = '服务时间';
const String appointment_time = '预约时间';
const String appointment_address = '预约地点';
const String spec = '款式';
const String successfulAppointment = '预约成功';
String pay_Appliance_repair = '家政维修';
String pay__Appliance_installation = '家电安装';
String pay_Housekeeping = '家政保洁';
String pay_Housing_maintenance = '房屋维修';
String pay_orther = '其他服务';

const String state_accepting = '待受理';
const String state_accepted = '已受理';
const String state_pay_accepted = '已接单';
const String state_working = '服务中';
const String state_worked = '已处理';
const String state_finishe = '已完结';
const String state_can_rat = '待评价';
const String state_close = '已关单';
const String state_cance = '已撤单';
const String state_can_pay = '待付款';

const String state_tip = '尊敬的用户，我们将竭诚为您服务。';
const String state_tip2 = '尊敬的用户，感谢您对我们的支持！';
const String state_tip3 = "尊敬的用户，请对我们的服务进行打分评价！";
const String state_tip4 = '尊敬的用户，支付剩余时间：';
const String state_tip5 = '尊敬的用户，已帮您关单。';

const String pay_service_appointment_tip = '以上价格均为参考价格，实际价格以服务人员现场报价为准！';

enum WorkOtherMainType {
  Complaint,//投诉
Warning,//公区报障
Paid,//有偿服务
Praise,//表扬
Advice,//咨询建议
  Repair,
}

getWorkOtherMainTypeStr(WorkOtherMainType type){
  switch(type){
    case WorkOtherMainType.Complaint:
    return 'Complaint';
    break;
    case WorkOtherMainType.Warning:
      return 'Warning';
      break;
    case WorkOtherMainType.Paid:
      return 'Paid';
      break;
    case WorkOtherMainType.Praise:
      return 'Praise';
      break;
    case WorkOtherMainType.Advice:
      return 'Advice';
      break;
    case WorkOtherMainType.Repair:
      return 'Repair';
      break;
  }
}


enum WorkOtherSubType {
  Advice,//咨询建议
ProjectComplaint,//项目投诉
CompanyComplaint,//公司投诉
HqComplaint,//总部投诉
InstallPaid,//家电安装
RepairPaid,//家政维修
CleaningPaid,//家政保洁
HousePaid,//房屋维修
OtherPaid,//其它
Praise,//表扬
MinorWarning,//小修
MediumWarning,//中修
SeriousWarning,//大修
  Repair,
//  Opinion,//产品反馈
}


enum WorkOtherStateType {
  accepting, //待受理
  accepted, //已受理
  working, //服务中
  worked, //已完工
  finished, //已完结
  can_rate, //可评价
  closed, //已关单
  cancel, //已撤销
  can_pay, //待付款
}




class PayServiceCard extends StatelessWidget {
  PayServiceInfo info;


  PayServiceCard(this.info,);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return PayServiceDetailPage(info);
        }));
      },
      child: Container(
        color: Colors.white,
        height: UIData.spaceSize48 * 2 + UIData.spaceSize10,
        margin: EdgeInsets.only(top: UIData.spaceSize12),
        padding: EdgeInsets.all(UIData.spaceSize16),
        child: Row(
          children: <Widget>[
            Container(
              height: UIData.spaceSize30 * 2 + UIData.spaceSize10,
              width: UIData.spaceSize30 * 3 + UIData.spaceSize3,
              margin: EdgeInsets.only(right: UIData.spaceSize12),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),border: Border.all(color: UIData.yellowColor,width: 1),),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: FadeInImage.assetNetwork(
                  placeholder: UIData.imagePayServiceDefault,
                  image: info.posterPhotoList!=null&&info.posterPhotoList.length>0?HttpOptions.showPhotoUrl(info.posterPhotoList[0].uuid):'',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: UIData.spaceSize20),
                  padding: EdgeInsets.symmetric(vertical: UIData.spaceSize3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(child:  CommonText.black16Text(info.serviceName))
                      ,

                      Expanded(child:  CommonText.lightGrey12Text(info.serviceDesc, maxLines: 1)),

                      Expanded(child:  CommonText.lighterRed15Text(
                          '￥${info.priceMin??''}-${info.priceMax??''}' +
                              (StringsHelper.isNotEmpty(info.priceUnit)
                                  ? info.priceUnit
                                  : ''))),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}


String replaceSecondTime(String time){
  try{
    List<String> times = time.split(',');
    StringBuffer buffer = new StringBuffer();
    for(int i =0;i<times.length;i++){
      if(i!=0){
        buffer.write(times[i].substring(11,16));
      }else{
        buffer.write(times[i].substring(0,16));
      }
      if(i!=times.length-1){
        buffer.write('-');
      }
    }
    return buffer.toString();
  }catch(e){
    LogUtils.printLog('${time}time');
    return time;
  }
}

//class PayServiceCard extends StatelessWidget {
//  PayServiceInfo info;
//
//  PayServiceCard(this.info);
//
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return GestureDetector(
//      onTap: () {
//        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
//          return PayServiceDetailPage(info);
//        }));
//      },
//      child: Container(
//        color: Colors.white,
//        height: UIData.spaceSize48 * 2 + UIData.spaceSize10,
//        margin: EdgeInsets.only(top: UIData.spaceSize12),
//        padding: EdgeInsets.all(UIData.spaceSize16),
//        child: Row(
//          children: <Widget>[
//            Container(
//              color: UIData.yellowColor,
//              height: UIData.spaceSize30 * 2 + UIData.spaceSize10,
//              width: UIData.spaceSize30 * 3 + UIData.spaceSize3,
//              margin: EdgeInsets.only(right: UIData.spaceSize12),
//              child: ClipRRect(
//                borderRadius: BorderRadius.circular(2),
//                child: FadeInImage.assetNetwork(
//                  placeholder: UIData.imagePayServiceDefault,
//                  image: info.showPhotoList!=null&&info.showPhotoList.length>0?info.showPhotoList[0]:'',
//                  fit: BoxFit.cover,
//                ),
//              ),
//            ),
//            Expanded(
//                child: Container(
//              margin: EdgeInsets.only(right: UIData.spaceSize20),
//              padding: EdgeInsets.symmetric(vertical: UIData.spaceSize3),
//              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: <Widget>[
//                  Expanded(child: CommonText.black16Text(info.serviceName),),
//
//              Expanded(child:CommonText.lightGrey12Text(info.serviceDesc, maxLines: 2)),
//
//              Expanded(child:CommonText.lighterRed15Text(
//                      '￥${info.priceMin}-${info.priceMax}' +
//                          (StringsHelper.isNotEmpty(info.priceUnit)
//                              ? info.priceUnit
//                              : ''))),
//                ],
//              ),
//            ))
//          ],
//        ),
//      ),
//    );
//  }
//}

class inputWidget extends StatelessWidget {
  String hint_text;
  TextEditingController controller;
  int maxLength;
  int maxLines;
  bool isBold;
  bool canEdit;
  double topSpace;
  double rightSpace;
  double leftSpace;
  double bottomSpace;
  double editBotPadding;
  double editTopPadding;
  Color color; //字体颜色
  double fontSize; //字体大小
  TextInputType keyboardType; //输入形式
  ValueChanged<String> onChanged;
  String labelText;//预文字
  TextStyle labelStyle;
  bool autofocus;
  inputWidget(
      {this.hint_text,
        this.color = UIData.greyColor,
        this.controller,
        this.maxLength,
        this.maxLines,
        this.topSpace,
        this.rightSpace,
        this.leftSpace,
        this.bottomSpace,
        this.isBold = false,
        this.editTopPadding,
        this.editBotPadding,
        this.canEdit = true,
        this.keyboardType = TextInputType.text,
        this.onChanged,
      this.labelText,
      this.labelStyle,
      this.autofocus});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
//    FocusNode _focusNode = new FocusNode();
    return Padding(
      padding: EdgeInsets.only(
          left: leftSpace == null ? UIData.spaceSize16 : leftSpace,
          right: rightSpace == null ? UIData.spaceSize16 : rightSpace,
          bottom: bottomSpace == null ? 0 : bottomSpace,
          top: topSpace == null ? 0 : topSpace),
//      child: ConstrainedBox(
//        constraints: BoxConstraints(
//            minHeight: ScreenUtil.getInstance().setHeight(height.toDouble())),
        child: CommonTextField(
        hintText: hint_text,
          labelText:labelText,
          labelStyle: labelStyle,
          autofocus: autofocus,
          keyboardType: keyboardType,
//            enabled: canEdit,
//            style: TextStyle(
//                fontSize: fontSize == null ? UIData.fontSize16 : fontSize,
//                color: color,
//                fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
//            decoration: InputDecoration(
//                hintText: hint_text,
//                border: InputBorder.none,
//                contentPadding: EdgeInsets.only(
//                    top: editTopPadding ?? UIData.spaceSize4,
//                    bottom: editBotPadding ?? UIData.spaceSize4)
//                contentPadding: EdgeInsets.symmetric(vertical: input_padding)
//                ),
          controller: controller,
          maxLength: maxLength,
          maxLines: maxLines,
          onChanged: onChanged,
//              onSubmitted:(str){
//                _focusNode.unfocus();
//                FocusScope.of(context).requestFocus(_focusNode);
//              }
        ),
//      ),
    );
  }
}

String getTitle(WorkOtherMainType workOtherType,int type ,{WorkOtherSubType sub}) {

  String title;
  switch (workOtherType) {
    case WorkOtherMainType.Complaint:
      title = '投诉';
      break;
    case WorkOtherMainType.Warning:
      title = '公区报障';
      break;
    case WorkOtherMainType.Repair:
      title = '室内维修';
      break;
    case WorkOtherMainType.Praise:
      title = '表扬';
      break;
    case WorkOtherMainType.Advice:
//      if(sub==WorkOtherSubType.Opinion){
//        return  title = '反馈';
//      }else
      title = '咨询建议';
      break;
    default:
      title = '订单';
      break;
  }
  switch(type){
    case 0:
      title=title;
      break;
    case 1:
      title=title+'列表';
      break;
    case 2:
      title=title+'详情';
      break;
  }
  return title;
}

String getSubTitle(WorkOtherSubType _workOtherSubType) {
  String title;
  switch (_workOtherSubType) {
    case WorkOtherSubType.ProjectComplaint:
      title = '项目投诉';
      break;
    case WorkOtherSubType.CompanyComplaint:
      title = '公司投诉';
      break;
    case WorkOtherSubType.HqComplaint:
      title = '总部投诉';
      break;
    case WorkOtherSubType.MinorWarning:
      title = '公区报障-小修';
      break;
    case WorkOtherSubType.MediumWarning:
      title = '公区报障-中修';
      break;
    case WorkOtherSubType.SeriousWarning:
      title = '公区报障-大修';
      break;
    case WorkOtherSubType.Repair:
      title = Repair;
      break;
    case WorkOtherSubType.RepairPaid:
      title = pay_Appliance_repair;
      break;
    case WorkOtherSubType.InstallPaid:
      title = pay__Appliance_installation;
      break;
    case WorkOtherSubType.HousePaid:
      title =pay_Housing_maintenance;
      break;
    case WorkOtherSubType.CleaningPaid:
      title = pay_Housekeeping;
      break;
    case WorkOtherSubType.OtherPaid:
      title = pay_orther;
      break;
      break;
    case WorkOtherSubType.Advice:
      title = '咨询建议';
          break;
//    case WorkOtherSubType.Opinion:
//      title = '产品反馈';
//      break;
    case WorkOtherSubType.Praise:
      title = '表扬';
      break;
  }
  return title;
}
getWorkSubTypeStr(WorkOtherSubType type){
  String typestr;
  switch(type){
    case WorkOtherSubType.Advice:typestr='Advice';break;
//    case WorkOtherSubType.Opinion:typestr='Opinion';break;
    case WorkOtherSubType.ProjectComplaint:typestr='ProjectComplaint';break;
    case WorkOtherSubType.CompanyComplaint:typestr='CompanyComplaint';break;
    case WorkOtherSubType.HqComplaint:typestr='HqComplaint';break;
    case WorkOtherSubType.InstallPaid:typestr='InstallPaid';break;
    case WorkOtherSubType.RepairPaid:typestr='RepairPaid';break;
    case WorkOtherSubType.CleaningPaid:typestr='CleaningPaid';break;
    case WorkOtherSubType.HousePaid:typestr='HousePaid';break;
    case WorkOtherSubType.OtherPaid:typestr='OtherPaid';break;
    case WorkOtherSubType.Praise:typestr='Praise';break;
    case WorkOtherSubType.Repair:typestr='Repair';break;
    case WorkOtherSubType.MinorWarning:typestr='MinorWarning';break;
    case WorkOtherSubType.MediumWarning:typestr='MediumWarning';break;
    case WorkOtherSubType.SeriousWarning:typestr='SeriousWarning';break;
  }
  return typestr;
}
String getPrice(String min, String max, String unit) {
  String priceStr;
  if (StringsHelper.isEmpty(min) && StringsHelper.isEmpty(max)) {
    return no_price;
  } else if (StringsHelper.isNotEmpty(min) && StringsHelper.isNotEmpty(max)) {
    priceStr = '￥  '+min+'  -  '+max;
  } else if (StringsHelper.isEmpty(min)) {
    priceStr = '￥  '+max+'  ' + below;
  } else {
    priceStr = '￥  '+min+'  ' + above;
  }
  if (StringsHelper.isNotEmpty(unit)) {
    priceStr += '  /'+unit;
  }

  return priceStr;
}

//String getDetailStateString(WorkOtherMainType type, WorkOther workOther) {}

class leftTextWidget extends StatelessWidget {
  String text; //内容
  bool isBold;
  Color color; //字体颜色
  double topSpacing; //头部间距
  double bottomSpacing; //底部间距
  double fontSize; //字体大小
  leftTextWidget(
      {this.color = UIData.greyColor,
      this.text = "",
      this.isBold = false,
      this.topSpacing = 0,
      this.bottomSpacing = 0,
      this.fontSize});

//  @override
//  State<StatefulWidget> createState() {
//    // TODO: implement createState
//    return leftText();
//  }
//}
//class leftText extends State<leftTextWidget>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(
                left: UIData.spaceSize16,
                top: topSpacing,
                bottom: bottomSpacing),
            child: Text(text,
                style: TextStyle(
                    fontSize: fontSize == null ? UIData.fontSize16 : fontSize,
                    color: color,
                    fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          ),
        )
      ],
    );
  }
}
