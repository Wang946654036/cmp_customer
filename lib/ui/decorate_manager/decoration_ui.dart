//SPMP_TJSQ-提交申请、SPMP_SLPG-受理评估、SPMP_XGSQ-修改申请、SPMP_QRFA-确认方案、SPMP_QRZF-确认支付、SPMP_QXSQ-取消申请、SPMP_WGDJ-完工登记
//状态：DSL-待受理、KFTH-客服退回、DQRFA-待确认方案、DZF-待支付、ZZZ-制作中、YWG-已完工、YQX-已取消、YGD-已关单
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_text_field.dart';
import 'package:cmp_customer/utils/log_util.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


const String label_apply_deal_progress = "办理进度";
const String label_apply_audit_opinion = "审核意见";
const payFeesStr = '应付金额';
const paymentTime = '缴费时间';
const remark = '备注';

const deal_progress = "办理进度";

const String agree = '是否同意所有协议：1-同意， 0-不同意';
const String applyDate = '申请日期';
const String applyTime = '申请时间';
const String applyType = '申请类型';
const String applyState = '状态';
const String beginWorkDate = '开工日期';
const String bpmCurrentRole = 'bpm当前执行角色';
const String bpmCurrentState = 'bpm当前状态';
const String checkRole = '用来校验防重复提交的字段';
const String companyPaperNumber = '证件号';
const String credentialNumber = '资质证书号';
const String houseCustName = '业主';
const String custId = '申请人id';
const String custName = '申请人';
const String custPhone = '申请人手机';
const String decorateType = '装修方式';
const String houseId = '房屋id';
const String houseName = '房屋（施工范围）';
const String id = 'id';
const String manager = '施工负责人';
const String managerIdCard = '身份证号';
const String managerPhone = '联系电话';
const String oddNumber = '业务单号';
const String operationCust = '操作业主id';
const String operationUser = '操作员工id';
const String postId = '岗位id';
const String processId = 'bpm流程id';
const String programDesc = '工程描述';
const String programName = '工程名称';
const String projectId = '项目id';
const String state = '当前状态';
const String status = '操作结果：0-不通过，1-通过，2-撤单';
const String userId = '用户id';
const String workCompany = '施工单位';
const String workDayLong = '预计工期';
const String workPeopleNum = '装修人数';

const String backPrice = '退款金额';
const String checkDate = '验收日期';
const String checkDesc = '验收记录';
const String checkResult = '审核结果：1-通过，0-不通过';
const String counter = '第几次验收申请：1-第一次验收申请，2-第二次验收申请';
const String finishDate = '竣工日期';
const String isBack = '是否退押金';
const String price = '工程总价';
const String quality = '质量评定'; //：1-优秀，2-良好，3-一般，4-较差
const String suggestion = '审核意见';
const String writerName = '签发人';
const String writeDate = '签发日期';
const String lawfulDate = '有效时间';
const String overTime = '已过期';
const String normalTime = '正常';
const String delayState = '延期状态';
const String permitState = '证件状态';
const String reason = '申请原由';
const String delayTime = '延长工期';

const String label_submit = '发起验收';
const String label_cansol = '取消办理';
const String label_edit = '修改申请';
const String label_agree = '同意';
const String label_disagree='不同意';
const String apply_tips =
    '须上传的资料附件有：\n1、业主身份或业主委托书，\n2、装修负责人身份证，\n3、施工队的证件照和资质证书。\n\n如无证件照和资质证书，业主需填写：\n1、《房屋装修业主担保书》，\n2、装修申请方案及施工设计图纸，\n3、写字楼还需上传消防主管部门书面审批同意的消防报建审批意见书。';

double unit_width = ScreenUtil.getInstance().setWidth(38); //单位宽度
const Color color_text_white = Color(0xFFFFFFFF); //字体白色
double label_width = ScreenUtil.getInstance().setWidth(112); //标签宽度
const Color color_text = Color(0xFF333333); //字体颜色
double normal_text_size = UIData.fontSize15; //默认字体大小
double vertical_spacing = ScreenUtil.getInstance().setHeight(12); //垂直间距
double normal_right_icon_size =
    ScreenUtil.getInstance().setHeight(22); //默认右箭头大小
const Color color_text_gray = Color(0xFF555555); //字体灰色
const Color color_icon_right = UIData.lighterGreyColor;

const String hint_text = "请输入";
const String hint_text_required = "请输入 (必填)";

///YZ_CHECK-待业主同意，
///YZ_DISAGREE-业主不同意，
///WY_CHECK-申请待处理，
///WY_CHECK_FAIL-申请不通过，
///PAYMENT_PENDING-待缴费，
///WRITED-已签证，
///ACCEPTANCE_CHECK-验收待处理，
///ACCEPTANCE_CHECK_FAIL-验收不通过，
///ACCEPTANCE_CHECK_SUCCESS-验收通过
const yzauditWaiting = "YZ_CHECK"; //待业主同意
const yzauditFailed = "YZ_DISAGREE"; //业主不同意
const wyauditWaiting = "WY_CHECK"; //待受理
const wyauditFailed = "WY_CHECK_FAIL"; //客服会退
const payWaiting = "PAYMENT_PENDING"; //待缴费
const wyauditSuc = "WRITED"; //已签证
const acceptance_check = "ACCEPTANCE_CHECK"; //验收待处理
const acceptanceCheckFailed = "ACCEPTANCE_CHECK_FAIL"; //验收不通过
const acceptanceCheckSuc = 'ACCEPTANCE_CHECK_SUCCESS'; //验收通过
const closed = 'CANCEL_REQUEST'; //已经关单
///WY_CHECK_FAIL-申请不通过，
//DELAY_CHECK_SUCCESS-申请通过，
//WY_CHECK-审核中,
//DELAY_CANCEL_REQUEST-延期申请撤单操作
const wyCheckFail = 'WY_CHECK_FAIL';
const delayCheckSuc = 'DELAY_CHECK_SUCCESS';
const wyCheck = 'WY_CHECK';
const delayCancel = 'DELAY_CANCEL_REQUEST';
const acceptance_cancel = 'ACCEPTANCE_CANCEL_REQUEST';
String getDelayState(state) {
  String stateText = '';
  switch (state) {
    case wyCheckFail:
      stateText = '申请不通过';
      break;
    case delayCheckSuc:
      stateText = '申请通过';
      break;
    case wyCheck:
      stateText = '延期审核';
      break;
    case delayCancel:
      stateText = '已撤单';
      break;
  }
  return stateText;
}

String getStateStr(state) {
  String stateText = '';
  switch (state) {
    case yzauditWaiting:
      stateText = "待业主同意";
      break;
    case yzauditFailed:
      stateText = "业主不同意";
      break;
    case wyauditWaiting:
      stateText = "申请待处理";
      break;
    case wyauditFailed:
      stateText = "申请不通过";
      break;
    case payWaiting:
      stateText = "待缴费";
      break;
    case wyauditSuc:
      stateText = "已签证";
      break;
    case acceptance_check:
      stateText = "验收待处理";
      break;
    case acceptanceCheckFailed:
      stateText = '验收不通过';
      break;
    case acceptanceCheckSuc:
      stateText = '验收通过';
      break;
    case closed:
      stateText = '已撤单';
      break;
  }
  return stateText;
}

getQualityString(int quality){
  String q = '';
  if(quality==null){
    return '';
  }
  switch(quality){
    case 1:
      q='优秀';
    break;
    case 2:
      q='良好';
      break;
    case 3:
      q='一般';
      break;
    case 4:
      q='较差';
      break;
    default:
      break;
  }
  return q;
}

//输入框
class inputWidget extends StatelessWidget {
  String hint_text;
  TextEditingController controller;
  int maxLength;
  int maxLines;
  bool editable;
  Color color;
  inputWidget(this.controller, {this.hint_text, this.maxLength, this.maxLines,this.editable=true,this.color});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: UIData.spaceSize16,
        ),
        child: CommonTextField(
//          style: TextStyle(fontSize: normal_text_size, color: color_text),
//          decoration: InputDecoration(
//              hintText: hint_text,
//              border: InputBorder.none,
//              contentPadding: EdgeInsets.symmetric(vertical: input_padding)),
        hintText: hint_text??'',
          controller: controller,
          maxLength: maxLength,
          maxLines: maxLines,
          textColor: color,
          enabled: editable,
        ));
  }
}

//费用输入
class feeInputWidget extends StatelessWidget {
  String hint_text; //隐藏内容
//   text;//内容
  String label; //标签
  String unit; //单位
  bool isBold; //输入是否加粗
  Color color; //字体颜色
  Color unitColor; //单位颜色
  bool enable; //是否允许修改
  int maxLength; //最大长度限制
  double topSpacing; //头部间距
  double bottomSpacing; //底部间距
  TextEditingController controller;

  feeInputWidget(this.controller,
      {this.label = "",
      this.unit = "",
      this.isBold = false,
      this.hint_text = "",
      this.color = color_text,
      this.unitColor = color_text,
      this.maxLength,
      this.topSpacing = 0,
      this.bottomSpacing = 0,
      this.enable = true});

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
            width: label_width,
            child: Text(label,
                style: TextStyle(
                    fontSize: normal_text_size, color: UIData.darkGreyColor)),
          ),
        ),
        Container(
          width: label_width,
          margin: EdgeInsets.symmetric(vertical: vertical_spacing),
          alignment: Alignment.centerLeft,
//          decoration: BoxDecoration(
//            border: Border.all(color: color_text)
//          ),
          child: TextFormField(
            enabled: enable,
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: normal_text_size,
              color: color,
            ),
            decoration: InputDecoration(
                hintText: hint_text ?? "",
//                border: OutlineInputBorder(
//                  borderSide: BorderSide(color: color_text)
//                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(0)),
            controller: controller,
//            initialValue: text??"",
            maxLength: maxLength,
          ),
        ),
        Visibility(
            visible: unit.isNotEmpty,
            child: Container(
              alignment: Alignment.centerRight,
              width: unit_width,
              margin: EdgeInsets.only(
                  right: UIData.spaceSize16,
                  top: topSpacing,
                  bottom: bottomSpacing),
              child: Text(unit,
                  style:
                      TextStyle(fontSize: normal_text_size, color: unitColor)),
            ))
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
  double leftSpacing; //左边间距
  IconData icon;
  TextAlign textAlign;
  Function onIconClick;
  CrossAxisAlignment crossAxisAlignment;
  labelTextWidget(
      {this.label = "",
        this.unit = "",
        this.text = "",
        this.isBold = false,
        this.needArrow = false,
        this.labelColor = color_text_gray,
        this.color = color_text,
        this.unitColor = color_text,
        this.icon = Icons.keyboard_arrow_right,
        this.topSpacing = 0,
        this.bottomSpacing = 0,
        this.leftSpacing,
        this.onIconClick,
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
          margin: EdgeInsets.only(left: leftSpacing ?? UIData.spaceSize16, top: topSpacing,bottom: bottomSpacing),
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
        Visibility(
            visible: needArrow,
            child: Padding(
              padding: EdgeInsets.only(right: UIData.spaceSize16, top: topSpacing, bottom: bottomSpacing),
              child: GestureDetector(child: Icon(
                icon,
                size: normal_right_icon_size,
                color: color_icon_right,
              ),onTap: onIconClick,),)),
        Visibility(
            visible: unit.isNotEmpty,
            child: Container(
              alignment: Alignment.centerRight,
              width: unit_width,
              margin: EdgeInsets.only(right: UIData.spaceSize16, top: topSpacing, bottom: bottomSpacing),
              child: Text(unit, style: TextStyle(fontSize: normal_text_size, color: unitColor)),
            ))
      ],
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
  double rightSpacing;
  double bottomSpacing; //底部间距
  double fontSize; //字体大小
  TextDecoration textDecoration;

  leftTextWidget({
    this.color = color_text,
    this.text = "",
    this.isBold = false,
    this.topSpacing = 0,
    this.leftSpacing = -1,
    this.rightSpacing = -1,
    this.bottomSpacing = 0,
    this.fontSize,
    this.textDecoration,
  });

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
              right: rightSpacing<0? 0 : rightSpacing,
                left: leftSpacing < 0 ? UIData.spaceSize16 : leftSpacing,
                top: topSpacing,
                bottom: bottomSpacing),
            child: Text(text,
                style: TextStyle(
                    decoration: textDecoration ?? TextDecoration.none,
                    fontSize: fontSize == null ? normal_text_size : fontSize,
                    color: color,
                    fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          ),
        )
      ],
    );
  }
}

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
          borderRadius: BorderRadius.circular(
              ellipse ? 5.0 : ScreenUtil.getInstance().setHeight(15)),
          border: Border.all(
              color: selected ? UIData.themeBgColor : UIData.scaffoldBgColor),
          color: selected ? UIData.lighterRedColor : UIData.scaffoldBgColor,
        ),
        margin: EdgeInsets.only(right: UIData.spaceSize16),
//        width: screen_botton_width,
        height: ScreenUtil.getInstance().setHeight(30),
        alignment: Alignment.center,
        child: CommonText.text12(text,
            color: selected ? UIData.themeBgColor : UIData.darkGreyColor),
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

  ellipseText(this.text,
      {this.textColor = UIData.lightGreyColor,
      this.backgroundColor = UIData.scaffoldBgColor,
      this.onTap,
      this.leftSpacing = 0,
      this.rightSpacing = 0});

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
        margin: EdgeInsets.only(left: leftSpacing, right: rightSpacing),
        height: ScreenUtil.getInstance().setHeight(30),
        alignment: Alignment.center,
        child: CommonText.text12(text, color: textColor),
      ),
      onTap: onTap,
    );
  }
}
