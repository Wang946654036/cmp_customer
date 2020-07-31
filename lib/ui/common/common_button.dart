import 'package:cmp_customer/scoped_models/main_state_model.dart';
import 'package:cmp_customer/ui/common/common_text.dart';
import 'package:cmp_customer/ui/common/common_toast.dart';
import 'package:cmp_customer/utils/common_strings_helper.dart';
import 'package:cmp_customer/utils/constant.dart';
import 'package:cmp_customer/utils/ui_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../main.dart';

///
/// 用来区分按钮样式
///
enum ButtonType { CONFIRM, CANCEL, EDIT }

///
/// 实心背景圆角按钮
/// [btnType]默认为[ButtonType.CONFIRM]为渐变红色底色，[ButtonType.CANCEL]为深灰色底色
///
class BaseStadiumSolidButton extends StatelessWidget {
  final title;
  final ButtonType btnType;
  final GestureTapCallback onTap;
  final bool enable;

  BaseStadiumSolidButton(this.title, {this.btnType = ButtonType.CONFIRM, this.onTap, this.enable = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
//        margin: EdgeInsets.only(bottom: UIData.spaceSize20, left: UIData.spaceSize40, right: UIData.spaceSize40),
        padding: EdgeInsets.all(UIData.spaceSize8),
        decoration: ShapeDecoration(
            shape: StadiumBorder(),
            gradient: enable
                ? (btnType == ButtonType.CONFIRM
                    ? LinearGradient(colors: [UIData.redGradient1, UIData.redGradient2, UIData.redGradient4])
                    : btnType == ButtonType.EDIT
                        ? LinearGradient(colors: [UIData.redGradient1, UIData.redGradient2, UIData.redGradient4])
                        : LinearGradient(colors: [UIData.greyGradient1, UIData.greyGradient2]))
                : LinearGradient(colors: UIData.lighterGreyGradient),
            shadows: [
              BoxShadow(
                  color: enable
                      ? (btnType == ButtonType.CONFIRM
                          ? UIData.themeBgColor70
                          : btnType == ButtonType.EDIT ? UIData.themeBgColor70 : UIData.greyGradient70)
                      : UIData.lighterGreyGradient2,
                  offset: Offset(0.0, 3.5),
                  blurRadius: 4.0,
                  spreadRadius: 0.0)
            ]),
        child: title is String ? CommonText.white16Text(title) : title,
      ),
      onTap: enable ? onTap : null,
    );
  }
}

///
/// 有外边距的实心背景圆角按钮
/// [btnType]默认为[ButtonType.CONFIRM]为渐变红色底色，[ButtonType.CANCEL]为深灰色底色
///
class StadiumSolidButton extends StatelessWidget {
  final title;
  final ButtonType btnType;
  final GestureTapCallback onTap;
  final EdgeInsetsGeometry margin;
  final bool enable;

  StadiumSolidButton(this.title, {this.btnType = ButtonType.CONFIRM, this.onTap, this.margin, this.enable = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.symmetric(horizontal: UIData.spaceSize48, vertical: UIData.spaceSize10),
      child: BaseStadiumSolidButton(
        title,
        btnType: btnType,
        onTap: onTap,
        enable: enable,
      ),
    );
  }
}

///
/// 两个实心背景圆角按钮
/// 左边为深灰色底色，右边为渐变红色底色
///
class StadiumSolidWithTowButton extends StatelessWidget {
  final conFirmText;
  final cancelText;
  final GestureTapCallback onConFirm;
  final GestureTapCallback onCancel;
  final EdgeInsetsGeometry padding;
  bool conFirmEnable ;
  bool cancelEnable;
  StadiumSolidWithTowButton({this.conFirmText, this.cancelText, this.onConFirm, this.onCancel, this.padding,this.conFirmEnable=true,this.cancelEnable=true});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.symmetric(horizontal: UIData.spaceSize48, vertical: UIData.spaceSize10),
      child: Row(
        children: <Widget>[
          Visibility(
            visible: cancelText != null,
            child: Expanded(
                flex: 2, child: BaseStadiumSolidButton(cancelText, btnType: ButtonType.CANCEL, onTap: onCancel,enable: cancelEnable??true,)),
          ),
          Visibility(
            visible: cancelText != null && conFirmText != null,
            child: Flexible(child: Container(), flex: 1),
          ),
          Visibility(
            visible: conFirmText != null,
            child: Expanded(
                flex: 2,
                child: BaseStadiumSolidButton(conFirmText, btnType: ButtonType.CONFIRM, onTap: onConFirm,enable: conFirmEnable??true,)),
          ),
        ],
      ),
    );
  }
}

///
/// 两个实心背景圆角按钮
/// 左边为深灰色底色，右边为渐变红色底色
///
class StadiumSolidWithThreeButton extends StatelessWidget {
  final conFirmText;
  final cancelText;
  final editText;
  final GestureTapCallback onConFirm;
  final GestureTapCallback onCancel;
  final GestureTapCallback onEdit;
  final EdgeInsetsGeometry padding;

  StadiumSolidWithThreeButton(
      {this.conFirmText,
      this.cancelText,
      this.editText,
      this.onEdit,
      this.onConFirm,
      this.onCancel,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.symmetric(horizontal: UIData.spaceSize24, vertical: UIData.spaceSize10),
      child: Row(
        children: <Widget>[
          Visibility(
            visible: cancelText != null,
            child: Expanded(
                flex: 3, child: BaseStadiumSolidButton(cancelText, btnType: ButtonType.CANCEL, onTap: onCancel)),
          ),
          Visibility(
            visible: cancelText != null && conFirmText != null,
            child: Flexible(child: Container(), flex: 1),
          ),
          Visibility(
            visible: editText != null,
            child: Expanded(
                flex: 3, child: BaseStadiumSolidButton(editText, btnType: ButtonType.EDIT, onTap: onEdit)),
          ),
          Visibility(
            visible: editText != null && editText != null,
            child: Flexible(child: Container(), flex: 1),
          ),
          Visibility(
            visible: conFirmText != null,
            child: Expanded(
                flex: 3,
                child: BaseStadiumSolidButton(conFirmText, btnType: ButtonType.CONFIRM, onTap: onConFirm)),
          ),
        ],
      ),
    );
  }
}

//渐变椭圆文本
class RadiusSolidText extends StatelessWidget {
  final String text; //文本
  final double width; //宽度
  final double height; //高度
  final double horizontalPadding; //水平间距
  final double verticalPadding; //垂直间距
  final double radiusSize; //圆角大小
  final Color color; //字体颜色（默认白色）
  final double fontSize; //字体大小
  final Colors backgroundColors; //背景渐变颜色数组
  final Color backgroundColor; //背景单颜色
  final GestureTapCallback onTap;

  RadiusSolidText(
      {this.text,
      this.width,
      this.height,
      this.horizontalPadding = 0,
      this.verticalPadding = 0,
      this.color = Colors.white,
      this.fontSize,
      this.radiusSize,
      this.backgroundColors,
      this.backgroundColor,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
        onTap: onTap,
        child: Container(
            width: width,
            height: height,
            decoration: ShapeDecoration(
                shape: StadiumBorder(),
                color: backgroundColor,
                gradient: backgroundColor==null?LinearGradient(
                    colors: backgroundColors ?? [UIData.redGradient1, UIData.redGradient2, UIData.redGradient3]):null),
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
            alignment: Alignment.center,
            child: Text(
              text,
              style: TextStyle(fontSize: fontSize ?? UIData.fontSize12, color: color),
              textAlign: TextAlign.center,
            )));
  }
}

//用来区分接口调用，登录中的获取验证码调的接口不一样
enum VerifySmsType {
  LOGIN,
  MODIFYPWD,
  OTHER,
}

///
/// 倒数按钮（获取验证码）
///
class CommonCountDownButton extends StatefulWidget {
//  bool showCountDown;
  final String phoneNo;

//  final AnimationController animationController;
//  final bool showCountDown; //显示验证码倒数
  final VerifySmsType smsType;

  CommonCountDownButton(
      {@required this.phoneNo,
//        @required this.animationController,
//      this.showCountDown = false,
      this.smsType = VerifySmsType.OTHER});

  @override
  _CommonCountDownBtnState createState() => _CommonCountDownBtnState();
}

class _CommonCountDownBtnState extends State<CommonCountDownButton> with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _doubleAnimation;
  bool _showCountDown = false; //显示验证码倒数

//倒计时
  _buildCountDown() {
    setState(() {
      _showCountDown = true;
    });
//    widget.animationController.reset();
//    widget.animationController = new AnimationController(vsync: this, duration: Duration(seconds: durationSeconds));
    if (_doubleAnimation == null) {
      _doubleAnimation =
          new Tween(begin: Constant.verificationCodeSecond.toDouble(), end: 0.0).animate(_animationController)
            ..addListener(() {
              setState(() {});
            })
            ..addStatusListener((AnimationStatus status) {
              if (status == AnimationStatus.completed) {
//              timeDilation = 15.0;
//              SystemNavigator.pop();
//          userStateModel.decideStep();
                setState(() {
                  _showCountDown = false;
//              LogUtils.printLog('_showCountDown：${_doubleAnimation.value.toInt()}  :  ${widget.showCountDown}');
                });
              }
            });
    }
    _animationController.reset();
    _animationController.forward();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: Constant.verificationCodeSecond));
//    _showCountDown = widget.showCountDown;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    LogUtils.printLog('showCountDown状态：${_showCountDown}');
    return GestureDetector(
        child: _showCountDown
            ? CommonText.red14Text('${_doubleAnimation.value.toInt().toString()}s')
            : CommonText.red14Text('获取验证码'),
        onTap: !_showCountDown
            ? () {
                if (widget.phoneNo == null || widget.phoneNo.isEmpty) {
                  CommonToast.show(msg: '请输入手机号码', type: ToastIconType.INFO);
                  return;
                } else if (!StringsHelper.isPhone(widget.phoneNo)) {
                  CommonToast.show(msg: '请输入正确的手机号码', type: ToastIconType.INFO);
                  return;
                }
                _buildCountDown();
                if (widget.smsType == VerifySmsType.LOGIN) {
                  stateModel.checkMobileExist(widget.phoneNo, callBack: (bool exist) {
                    if (exist) {
                      stateModel.getVerificationCodeForLogin(
                          mobile: widget.phoneNo,
                          callBack: ({String failedMsg}) {
                            if (failedMsg == null) {
                              //提交成功(暂不做处理，从点击开始倒数)
//                        _buildCountDown();
                            } else {
                              setState(() {
                                _showCountDown = false;
                              });
                            }
                          });
                    } else {
                      setState(() {
                        _showCountDown = false;
                      });
                    }
                  });
                }  else if (widget.smsType == VerifySmsType.MODIFYPWD) {
                  stateModel.getVerificationCodeForModifyPwd(
                      mobile: widget.phoneNo,
                      callBack: ({bool msg}) {
                        if (msg) {
                          //提交成功(暂不做处理，从点击开始倒数)
//                        _buildCountDown();
                        } else {
                          setState(() {
                            _showCountDown = false;
                          });
                        }
                      });
                } else {
                  MainStateModel.of(context).getVerificationCode(
                      mobile: widget.phoneNo,
                      callBack: ({String failedMsg}) {
                        if (failedMsg == null) {
                          //提交成功(暂不做处理，从点击开始倒数)
//                        _buildCountDown();
                        } else {
                          setState(() {
                            _showCountDown = false;
                          });
                        }
                      });
                }
              }
            : null);
  }
}

///
/// 背景颜色加文字的label
///
class CommonLabel extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final EdgeInsetsGeometry padding;
  final GestureTapCallback onTap;

  CommonLabel(this.text,
      {this.backgroundColor = UIData.dividerColor,
      this.textColor = UIData.greyColor,
      this.padding,
      this.onTap,
      this.borderColor = Colors.transparent});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: padding ?? EdgeInsets.symmetric(horizontal: UIData.spaceSize4, vertical: UIData.spaceSize2),
        decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2.0),
                side: BorderSide(
                    color: borderColor, style: borderColor != null ? BorderStyle.solid : BorderStyle.none)),
            color: backgroundColor),
        child: CommonText.text11(text ?? '', color: textColor),
      ),
      onTap: onTap,
    );
  }
}

///
/// 椭圆形外边框按钮
///
class StadiumOutlineButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color outlineColor;
  final double textSize;
  final GestureTapCallback onTap;

  StadiumOutlineButton(this.text, {this.onTap, this.textColor, this.textSize, this.outlineColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
//        margin: EdgeInsets.only(bottom: UIData.spaceSize20, left: UIData.spaceSize40, right: UIData.spaceSize40),
        padding: EdgeInsets.symmetric(horizontal: UIData.spaceSize8, vertical: UIData.spaceSize4),
        decoration:
            ShapeDecoration(shape: StadiumBorder(side: BorderSide(color: outlineColor ?? UIData.redColor60))),
//        child: CommonText.text13(text, color: textColor),
        child: Text(
          text,
          style: TextStyle(color: textColor ?? UIData.redColor60, fontSize: textSize ?? UIData.fontSize11),
        ),
      ),
      onTap: onTap,
    );
  }
}


///
/// 通用单选
///
class CommonRadio<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T> onChanged;
  final String text;

  CommonRadio({@required this.value, @required this.onChanged, @required this.groupValue, @required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Radio<T>(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: value, groupValue: groupValue, onChanged: onChanged),
          CommonText.darkGrey15Text(text ?? ''),
        ],
      ),onTap: ()=> onChanged(value),
    );
  }
}

///
/// 通用多选
///
class CommonCheckBox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final String text;
  final double fontSize;

  CommonCheckBox({@required this.value, @required this.onChanged, this.text, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Checkbox(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            value: value,
            onChanged: onChanged),
        Visibility(
            visible: StringsHelper.isNotEmpty(text),
            child: Text(text, style: TextStyle(color: UIData.darkGreyColor, fontSize: fontSize ?? UIData.fontSize15))),
      ],
    );
  }
}
