import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

getLimitDatesStrings(int max){
  List<String> dates = new List();
  if(max!=null&&max>0){
    int i = 1;
    while(i<=max){
      dates.add(i.toString()+'天');
      i++;
    }
  }else{
    dates.add('1');
  }
  return dates;
}
const String hasSuc='2';
const String hasFail='1';
const String waiting = '0';
String getStateName(String state){
  switch(state){
    case hasSuc:
      return '预约成功';
    case hasFail:
      return '受理不通过';
    case waiting:
      return '待受理';
  }
  return '待受理';
}
String getPassStateName(int state){
  if(state==null)
    return '';
  switch(state){
    case 0:
      return '授权不放行';
    case 1:
      return '授权放行';
    case 2:
      return '未授权';
      default:
        return '';
  }
}

double label_width = ScreenUtil.getInstance().setWidth(100); //标签宽度
const Color color_text = UIData.darkGreyColor; //字体颜色
double normal_text_size = UIData.fontSize15; //默认字体大小
const Color color_text_gray = UIData.lightGreyColor; //字体灰色
const Color color_icon_right = UIData.lighterGreyColor;
//标签与文本
class labelTextWidgetForVisit extends StatelessWidget {
  String text; //内容
  String label; //标签
  String unit; //单位
  bool isBold;
  bool needArrow;
  Color labelColor; //标签字体颜色
  Color unitColor; //单位颜色
  Color color; //字体颜色
  double topSpacing; //头部间距
  double bottomSpacing; //底部间距
  IconData icon;
  TextAlign textAlign;
  Function onIconClick;
  CrossAxisAlignment crossAxisAlignment;
  labelTextWidgetForVisit(
      {this.label = "",
        this.text = "",
        this.isBold = false,
        this.labelColor = color_text_gray,
        this.color = color_text,
        this.topSpacing = 0,
        this.bottomSpacing = 0,
        this.crossAxisAlignment,
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
      crossAxisAlignment: crossAxisAlignment??CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: topSpacing,bottom: bottomSpacing),
          width: label_width,
          child: Text(label, style: TextStyle(fontSize: normal_text_size, color: labelColor)),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: topSpacing, bottom: bottomSpacing),
            child: Text(
              text,
              textAlign: textAlign ?? TextAlign.left,
              style: TextStyle(
                  fontSize: normal_text_size,
                  color: color,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
            ),
          ),
        ),
      ],
    );
  }
}