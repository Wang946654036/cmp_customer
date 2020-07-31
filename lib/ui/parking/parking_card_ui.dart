import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_text_field.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

double half_height = ScreenUtil.getInstance().setHeight(11); //半行高度
double single_height = ScreenUtil.getInstance().setHeight(22); //单行高度
double label_width = ScreenUtil.getInstance().setWidth(112); //标签宽度
double unit_width = ScreenUtil.getInstance().setWidth(38); //单位宽度
double screen_botton_width =
    ScreenUtil.getInstance().setWidth(80); //筛选页面单选或多选宽度

//字体间距
double text_spacing = ScreenUtil.getInstance().setHeight(8); //字体之间间距
double left_spacing = ScreenUtil.getInstance().setWidth(16); //左边间距
double right_spacing = ScreenUtil.getInstance().setWidth(16); //右边间距
double top_spacing = ScreenUtil.getInstance().setHeight(12); //上边边间距
double bottom_spacing = ScreenUtil.getInstance().setHeight(12); //下边间距
double vertical_spacing = ScreenUtil.getInstance().setHeight(12); //垂直间距
double horizontal_spacing = ScreenUtil.getInstance().setWidth(16); //水平间距
double screen_top_spacing = ScreenUtil.getInstance().setHeight(16); //筛选的上边距

double card_spacing = ScreenUtil.getInstance().setWidth(12); //卡片间隔
double line_height = ScreenUtil.getInstance().setHeight(1); //线的大小
double line_width = ScreenUtil.getInstance().setWidth(1); //线的大小
double normal_text_size = UIData.fontSize15; //默认字体大小
double little_text_size = UIData.fontSize14; //小号字体大小
double normal_right_icon_size =
    ScreenUtil.getInstance().setHeight(22); //默认右箭头大小
double input_padding = ScreenUtil.getInstance().setWidth(5); //输入框padding

double parking_state_height = ScreenUtil.getInstance().setHeight(30); //月卡页面状态高度
double parking_state_half_height =
    ScreenUtil.getInstance().setHeight(15); //月卡页面状态一半高度
double parking_state_weight = ScreenUtil.getInstance().setWidth(60); //月卡页面状态宽度

double screen_left_spacing = ScreenUtil.getInstance().setWidth(12); //筛选页面左边间距
double node_line_width = ScreenUtil.getInstance().setWidth(1); //流程节点线的宽度
double node_left_spacing = ScreenUtil.getInstance().setWidth(19); //流程节点线距离左边的间距

const Color color_layout_bg = Colors.white;
const Color color_icon_right = UIData.lighterGreyColor;
const Color color_line = UIData.dividerColor;
const Color color_text_white = Colors.white; //字体白色
const Color color_text_gray = Color(0xFF555555); //字体灰色
const Color color_text_red = UIData.themeBgColor; //字体红色
const Color color_text = Color(0xFF333333); //字体颜色
const Color color_text_hint = Color(0xFF999999); //提示字体灰色
const Color color_label = Colors.grey; //标签颜色
const Color color_text_orange = UIData.yellowColor;
const List<Color> color_grey_gradient = [
  UIData.greyGradient1,
  UIData.greyGradient2
];

const Color radius_solid_background = Color(0xFFDBEFFF);
const Color radius_solid_text = Color(0xFF1B82D1);

const String hint_text = "请输入";
const String hint_text_required = "请输入 (必填)";
const String hint_expect_stop_date = "请输入您期望的停用日期";

const String label_apply_persion = "申请人(单位)";
const String label_apply_phone = "申请人电话";
const String label_apply_car_no = "车牌号码";
const String label_apply_car_brand = "车辆品牌";
const String label_apply_car_color = "车辆颜色";
const String label_apply_driver_name = "车主姓名";
const String label_apply_driver_phone = "车主电话";
const String label_apply_time = "申请时间";
const String label_apply_validity_date = "有效期";
const String label_apply_startup_date = "启动日期";
const String label_apply_termination_date = "终止日期";
const String label_apply_start_n_stop_date = "起止日期";
const String label_apply_old_start_n_stop_date = "原起止日期";
const String label_apply_advance_termination_date = "提前终止日期";
const String label_apply_expect_date = "期望终止日期";
const String label_apply_select_start_time = "选择起始时间";
const String label_apply_select_end_time = "选择截止时间";
const String label_apply_stop_date = "停用日期";
const String label_apply_duration = "申请时长";
const String label_apply_duration_renew = "续费时长";
const String label_apply_fee = "费用金额";
const String label_apply_back_fee = "可退金额";
const String label_apply_upload_driving_license = "行驶证";
const String label_apply_charge_standard = "收费标准";
const String label_apply_business_agreement = "《停车场业务办理协议》";
const String label_apply_deal_recent_record = "最近办理记录";
const String label_apply_deal_type = "办理类型";
const String label_apply_deal_no = "办理单号";
const String label_apply_deal_progress = "办理进度";
const String label_apply_deal_time = "办理时间";
const String label_apply_audit_time = "审核时间";
const String label_apply_audit_opinion = "审核意见";
const String label_apply_recent_record = "最近办理记录";
const String label_apply_parking_place = "停放车场";
const String label_apply_parking_packages = "套餐";
const String label_apply_pay_fee = "支付金额";
const String label_apply_pay_time = "支付时间";
const String label_apply_pay_method = "支付方式";
const String label_apply_accept_fee = "可退金额";
const String label_apply_accept_opinion = "受理意见";
const String label_unit_fee = "元";
const String label_unit_month = "个月";

const String label_search = "查询";
const String label_bind = "绑定";
const String label_submit = "提交";
const String label_sure = "确定";
const String label_reset = "重置";

//横线
class horizontalLineWidget extends StatelessWidget {
  double spacing;
  horizontalLineWidget({this.spacing = 0});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spacing),
      height: line_height,
      color: color_line,
    );
  }
}

//竖线
class VerticalLineWidget extends StatelessWidget {
  double spacing;
  VerticalLineWidget({this.spacing = 0});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spacing),
      width: line_height,
      color: color_line,
    );
  }
}

//单行靠左文本
class leftTextWidget extends StatelessWidget {
  String text; //内容
  bool isBold;
  Color color; //字体颜色
  double topSpacing; //头部间距
  double leftSpacing; //头部间距
  double bottomSpacing; //底部间距
  double fontSize; //字体大小
  leftTextWidget(
      {this.color = color_text,
      this.text = "",
      this.isBold = false,
      this.topSpacing = 0,
      this.leftSpacing = -1,
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
                left: leftSpacing < 0 ? left_spacing : leftSpacing,
                top: topSpacing,
                bottom: bottomSpacing),
            child: Text(text,
                style: TextStyle(
                    fontSize: fontSize == null ? normal_text_size : fontSize,
                    color: color,
                    fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          ),
        )
      ],
    );
  }
}

//标签与文本
class labelTextWidget extends StatelessWidget {
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
  labelTextWidget(
      {this.label = "",
      this.unit = "",
      this.text = "",
      this.isBold = false,
      this.needArrow = false,
      this.labelColor = color_text_gray,
      this.color = color_text,
      this.unitColor = color_text,
      this.topSpacing = 0,
      this.bottomSpacing = 0});
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
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(
              left: left_spacing, top: topSpacing, bottom: bottomSpacing),
          width: label_width,
          child: Text(label,
              style: TextStyle(fontSize: normal_text_size, color: labelColor)),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: topSpacing, bottom: bottomSpacing,right: right_spacing),
            child: Text(
              text,
              style: TextStyle(
                  fontSize: normal_text_size,
                  color: color,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
            ),
          ),
        ),
        Visibility(
            visible: needArrow,
            child: Padding(
                padding: EdgeInsets.only(
                    right: right_spacing,
                    top: topSpacing,
                    bottom: bottomSpacing),
                child: Icon(
                  Icons.keyboard_arrow_right,
                  size: normal_right_icon_size,
                  color: color_icon_right,
                ))),
        Visibility(
            visible: unit.isNotEmpty,
            child: Container(
              alignment: Alignment.centerRight,
              width: unit_width,
              margin: EdgeInsets.only(
                  right: left_spacing, top: topSpacing, bottom: bottomSpacing),
              child: Text(unit,
                  style:
                      TextStyle(fontSize: normal_text_size, color: unitColor)),
            ))
      ],
    );
  }
}

//标签与输入
class labelInputWidget extends StatelessWidget {
  String text; //内容
  String label; //标签
  String unit; //单位
  String hint; //提示文字
  bool isBold; //输入是否加粗
  bool isRequired; //是否必填
  bool enable; //是否允许修改
  Color labelColor; //标签颜色
  Color color; //字体颜色
  Color unitColor; //单位颜色
  int maxLength; //最大长度限制
  int limitLength; //字数限制
  double topSpacing; //头部间距
  double bottomSpacing; //底部间距
  TextEditingController controller;
  TextInputType keyboardType; //输入类型（默认text）
  labelInputWidget(this.controller,
      {this.label = "",
      this.text,
      this.hint,
      this.unit = "",
      this.isBold = false,
      this.isRequired = false,
      this.enable = true,
      this.labelColor=color_text,
      this.color = color_text,
      this.unitColor = color_text,
      this.maxLength,
      this.limitLength,
      this.topSpacing = 0,
      this.bottomSpacing = 0,
      this.keyboardType});
//  @override
//  State<StatefulWidget> createState() {
//    // TODO: implement createState
//    return labelInput();
//  }
//}
//
//class labelInput extends State<labelInputWidget>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(
              left: left_spacing, top: topSpacing, bottom: bottomSpacing),
          width: label_width,
          child: Text(label,
              style: TextStyle(fontSize: normal_text_size, color: labelColor)),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.centerLeft,
            child: CommonTextField(
              enabled: enable,
              textColor: color,
              hintText: hint ?? (isRequired ? hint_text_required : hint_text),
//              style: TextStyle(fontSize: normal_text_size, color: color),
//              decoration: InputDecoration(
//                  hintText: isRequired ? hint_text_required : hint_text,
//                  border: InputBorder.none,
//                  contentPadding:
//                      EdgeInsets.symmetric(vertical: input_padding)),
              controller: controller,
//              initialValue: text,
              maxLength: maxLength,
              limitLength: limitLength,
              keyboardType: keyboardType,
            ),
          ),
        ),
        Visibility(
            visible: unit.isNotEmpty,
            child: Container(
              alignment: Alignment.centerRight,
              width: unit_width,
              margin: EdgeInsets.only(
                  right: left_spacing, top: topSpacing, bottom: bottomSpacing),
              child: Text(unit,
                  style:
                      TextStyle(fontSize: normal_text_size, color: unitColor)),
            ))
      ],
    );
  }
}

////输入框
//class inputWidget extends StatelessWidget {
//  String hint_text;
//  TextEditingController controller;
//  int maxLength;
//  int maxLines;
//  inputWidget({this.hint_text, this.controller, this.maxLength, this.maxLines});
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return Padding(
//        padding: EdgeInsets.all(
//          left_spacing,
//        ),
//        child: CommonTextField(
//          textColor: color_text,
////          decoration: InputDecoration(
////              hintText: hint_text,
////              border: InputBorder.none,
////              contentPadding: EdgeInsets.symmetric(vertical: input_padding)),
//          controller: controller,
//          maxLength: maxLength,
//          maxLines: maxLines,
//        ));
//  }
//}

//椭圆样式(可自定义圆角大小)
class ellipseBotton extends StatelessWidget {
  String text; //内容
  bool selected; //是否选中的样式
  bool ellipse;
  ValueChanged<bool> onChanged; //点击回调
  ellipseBotton(this.text, this.selected,
      {this.onChanged, this.ellipse = true});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(ellipse ? 5.0 : parking_state_half_height),
          border: Border.all(
              color: selected ? UIData.themeBgColor : UIData.scaffoldBgColor),
          color: selected ? UIData.lighterRedColor : UIData.scaffoldBgColor,
        ),
        margin: EdgeInsets.only(right: right_spacing),
//        width: screen_botton_width,
        height: parking_state_height,
        alignment: Alignment.center,
        child: CommonText.text12(text,
            color: selected ? UIData.themeBgColor : UIData.darkGreyColor,),
      ),
      onTap: () {
        onChanged(!selected);
      },
    );
  }
}

//圆角按钮
class ellipseText extends StatelessWidget {
  String text; //内容
  Color textColor; //字体颜色
  Color backgroundColor; //本经颜色
  GestureTapCallback onTap; //点击回调
  double leftSpacing;
  double rightSpacing;
  ellipseText(this.text,{this.textColor=UIData.lightGreyColor,this.backgroundColor=UIData.scaffoldBgColor,this.onTap,this.leftSpacing=0,this.rightSpacing=0});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
//          border: Border.all(
//              color: selected ? UIData.themeBgColor : UIData.scaffoldBgColor),
          color: backgroundColor,
        ),

        margin: EdgeInsets.only(left:leftSpacing,right: rightSpacing),
        height: parking_state_height,
        alignment: Alignment.center,
        child: CommonText.text12(text,
            color: textColor),
      ),
      onTap: onTap,
    );
  }
}
