
import 'package:cmp_customer/models/change_title_obj.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/parking/parking_card_ui.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const String auditWaiting = "DSH"; //待审核
const String auditFailed = "SHBTG"; //审核不通过
const String auditSuc = "DJJ"; //审核通过
const String completed = "YWG"; //已完成
const String cancelled = "YQX"; //已取消
const String closed = "YGD"; //已关单

const String label_name='姓名';
const String label_IDtype = '证件类型';
const String label_IDNo = '证件号码';
const String label_business_id = "业务ID";
const String label_contact_phone = "联系电话";

//SFZ-身份证,HZ-护照,JSZ-驾驶证,XSZ-学生证,GZTXZ-港澳通行证,RTZ-入台证,HKB-户口本,XGSFZ-香港身份证，YYZZ-营业执照，TYSHXYDM-统一社会信用代码

const Map<String, String> documentMap = {
  'SFZ': '身份证',
  'HZ': '护照',
  'JSZ': '驾驶证',
  'XSZ': '学生证',
  'GATXZ': '港澳通行证',
  'RTZ': '入台证',
  'HKB': '户口本',
  'XGSFZ': '香港身份证',
  'JGZ':'军官证',
  'TBZ':'台胞证',
  'AMSFZ':'澳门身份证',
  'TWSFZ':'台湾身份证',
//  'YYZZ': '营业执照',//企业用户不用
//  'TYSHXYDM': '统一社会信用代码',
};

String getIDType(String type){
  String typeName='';
  switch(type){
    case 'SFZ':
      typeName='身份证';
      break;
    case 'HZ':
      typeName='护照';
      break;
    case 'JSZ':
      typeName='驾驶证';
      break;
    case 'XSZ':
      typeName='学生证';
      break;
    case 'GATXZ':
      typeName='港澳通行证';
      break;
    case 'RTZ':
      typeName='入台证';
      break;
    case 'HKB':
      typeName='户口本';
      break;
    case 'XGSFZ':
      typeName='香港身份证';
      break;
     case 'JGZ':
    typeName ='军官证';
    break;
    case 'TBZ':
      typeName = '台胞证';
      break;

    case 'AMSFZ':
      typeName =  '澳门身份证';
      break;
    case 'TWSFZ':
      typeName =  '台湾身份证';
      break;
//    case 'YYZZ':
//      typeName='营业执照';
//      break;
//    case 'TYSHXYDM':
//      typeName='统一社会信用代码';
//      break;

  }
  return typeName;
}

const String hint_text = "请输入";
const String hint_text_required = "请输入 (必填)";
String getStateStr(String state){
  String stateText='';
  switch (state){
    case auditWaiting:
      stateText = "待审核";
      break;
    case auditFailed:
      stateText = "审核不通过";
      break;
    case auditSuc:
      stateText = "待交接";
      break;
    case completed:
      stateText = "交接完成";
      break;
    case cancelled:
      stateText = "已取消";
      break;
    case closed:
      stateText = "已关单";
      break;
  }
  return stateText;
}

//String getTips(ChangeTitleInfo info){
//  if(info.assigneeIdNumMatchId==-1&&info.assigneeMobileMatchId==-1){
//    return '受让方手机和证件信息在系统中都未匹配到客户${info.assigneeRealname}。若最终交接完成，系统将自动创建受让方客户信息，并将房屋转至受让方客户名下。';
//  }else if(info.assigneeIdNumMatchId==-1){
//    return '受让方手机在系统中匹配到客户${info.assigneeRealname}，但证件信息不符(证件类型:${getIDType(info.custSimpleVoAppByMobile?.idTypeId??'')}，证件号码:${info.custSimpleVoAppByMobile?.custIdNum??''})。若最终交接完成，系统将自动更新房屋信息，将房屋转至该客户名下。若需更新该客户证件信息，请在web【客户管理】提交修改申请';
//  }else if(info.assigneeMobileMatchId==-1){
//  return '受让方证件信息在系统中匹配到客户${info.assigneeRealname}，但手机号码不符(${(info.custSimpleVoAppByMobile.custPhone)})。若最终交接完成，系统将自动更新房屋信息，将房屋转至该客户名下。若需更新该客户手机号码，请在【客户管理】提交修改申请';
//  }else{
//return '受让方手机在系统中匹配到客户${info.custSimpleVoAppByMobile.custName}，证件匹配到客户林民，请核实';
//  }
//}


//搜索布局
class searchInputWidget extends StatelessWidget {
  String hintText;
  TextEditingController _controller = new TextEditingController();
  Function searchCallback;
  searchInputWidget({this.hintText, this.searchCallback});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: <Widget>[
        Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: UIData.scaffoldBgColor,
                borderRadius: BorderRadius.circular(5),
              ),
              padding: EdgeInsets.symmetric(horizontal: input_padding),
              child: TextFormField(
                controller: _controller,
                style: TextStyle(fontSize: normal_text_size, color: color_text),
                cursorColor: UIData.darkGreyColor,
                cursorWidth: 1,
                decoration: InputDecoration(
                  hintText: hintText,
                  border: InputBorder.none,
                  icon: Icon(
                    Icons.search,
                    size: ScreenUtil.getInstance().setWidth(25),
                    color: UIData.lightGreyColor,
                  ),
                  contentPadding: EdgeInsets.only(
                      top: input_padding,
                      left: -10,
                      right: input_padding,
                      bottom: input_padding),
                ),
              ),
            )),
        GestureDetector(
            onTap: () {
              if (searchCallback != null) {
                searchCallback(_controller.text);
              }
            },
            child: Container(
              margin: EdgeInsets.only(left: left_spacing),
              child: CommonText.black16Text("搜索"),
            ))
      ],
    );
  }
}